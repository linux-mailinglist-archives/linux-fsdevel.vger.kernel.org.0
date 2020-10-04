Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB42D282824
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgJDCkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgJDCji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BE2C0613B2;
        Sat,  3 Oct 2020 19:39:35 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvy-00BUsJ-1u; Sun, 04 Oct 2020 02:39:34 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 27/27] epoll: take epitem list out of struct file
Date:   Sun,  4 Oct 2020 03:39:29 +0100
Message-Id: <20201004023929.2740074-27-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201004023929.2740074-1-viro@ZenIV.linux.org.uk>
References: <20201004023608.GM3421308@ZenIV.linux.org.uk>
 <20201004023929.2740074-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Move the head of epitem list out of struct file; for epoll ones it's
moved into struct eventpoll (->refs there), for non-epoll - into
the new object (struct epitem_head).  In place of ->f_ep_links we
leave a pointer to the list head (->f_ep).

->f_ep is protected by ->f_lock and it's zeroed as soon as the list
of epitems becomes empty (that can happen only in ep_remove() by
now).

The list of files for reverse path check is *not* going through
struct file now - it's a single-linked list going through epitem_head
instances.  It's terminated by ERR_PTR(-1) (== EP_UNACTIVE_POINTER),
so the elements of list can be distinguished by head->next != NULL.

epitem_head instances are allocated at ep_insert() time (by
attach_epitem()) and freed either by ep_remove() (if it empties
the set of epitems *and* epitem_head does not belong to the
reverse path check list) or by clear_tfile_check_list() when
the list is emptied (if the set of epitems is empty by that
point).  Allocations are done from a separate slab - minimal kmalloc()
size is too large on some architectures.

As the result, we trim struct file _and_ get rid of the games with
temporary file references.

Locking and barriers are interesting (aren't they always); see unlist_file()
and ep_remove() for details.  The non-obvious part is that ep_remove() needs
to decide if it will be the one to free the damn thing *before* actually
storing NULL to head->epitems.first - that's what smp_load_acquire is for
in there.  unlist_file() lockless path is safe, since we hit it only if
we observe NULL in head->epitems.first and whoever had done that store is
guaranteed to have observed non-NULL in head->next.  IOW, their last access
had been the store of NULL into ->epitems.first and we can safely free
the sucker.  OTOH, we are under rcu_read_lock() and both epitem and
epitem->file have their freeing RCU-delayed.  So if we see non-NULL
->epitems.first, we can grab ->f_lock (all epitems in there share the
same struct file) and safely recheck the emptiness of ->epitems; again,
->next is still non-NULL, so ep_remove() couldn't have freed head yet.
->f_lock serializes us wrt ep_remove(); the rest is trivial.

Note that once head->epitems becomes NULL, nothing can get inserted into
it - the only remaining reference to head after that point is from the
reverse path check list.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c            | 168 ++++++++++++++++++++++++++++++++++------------
 fs/file_table.c           |   1 -
 include/linux/eventpoll.h |  11 +--
 include/linux/fs.h        |   5 +-
 4 files changed, 129 insertions(+), 56 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index eea269670168..d3fdabf6fd34 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -215,6 +215,7 @@ struct eventpoll {
 
 	/* used to optimize loop detection check */
 	u64 gen;
+	struct hlist_head refs;
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	/* used to track busy poll napi_id */
@@ -259,7 +260,45 @@ static struct kmem_cache *pwq_cache __read_mostly;
  * List of files with newly added links, where we may need to limit the number
  * of emanating paths. Protected by the epmutex.
  */
-static LIST_HEAD(tfile_check_list);
+struct epitems_head {
+	struct hlist_head epitems;
+	struct epitems_head *next;
+};
+static struct epitems_head *tfile_check_list = EP_UNACTIVE_PTR;
+
+static struct kmem_cache *ephead_cache __read_mostly;
+
+static inline void free_ephead(struct epitems_head *head)
+{
+	if (head)
+		kmem_cache_free(ephead_cache, head);
+}
+
+static void list_file(struct file *file)
+{
+	struct epitems_head *head;
+
+	head = container_of(file->f_ep, struct epitems_head, epitems);
+	if (!head->next) {
+		head->next = tfile_check_list;
+		tfile_check_list = head;
+	}
+}
+
+static void unlist_file(struct epitems_head *head)
+{
+	struct epitems_head *to_free = head;
+	struct hlist_node *p = rcu_dereference(hlist_first_rcu(&head->epitems));
+	if (p) {
+		struct epitem *epi= container_of(p, struct epitem, fllink);
+		spin_lock(&epi->ffd.file->f_lock);
+		if (!hlist_empty(&head->epitems))
+			to_free = NULL;
+		head->next = NULL;
+		spin_unlock(&epi->ffd.file->f_lock);
+	}
+	free_ephead(to_free);
+}
 
 #ifdef CONFIG_SYSCTL
 
@@ -632,6 +671,8 @@ static void epi_rcu_free(struct rcu_head *head)
 static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 {
 	struct file *file = epi->ffd.file;
+	struct epitems_head *to_free;
+	struct hlist_head *head;
 
 	lockdep_assert_irqs_enabled();
 
@@ -642,8 +683,20 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 
 	/* Remove the current item from the list of epoll hooks */
 	spin_lock(&file->f_lock);
+	to_free = NULL;
+	head = file->f_ep;
+	if (head->first == &epi->fllink && !epi->fllink.next) {
+		file->f_ep = NULL;
+		if (!is_file_epoll(file)) {
+			struct epitems_head *v;
+			v = container_of(head, struct epitems_head, epitems);
+			if (!smp_load_acquire(&v->next))
+				to_free = v;
+		}
+	}
 	hlist_del_rcu(&epi->fllink);
 	spin_unlock(&file->f_lock);
+	free_ephead(to_free);
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
@@ -852,7 +905,11 @@ void eventpoll_release_file(struct file *file)
 	 * Besides, ep_remove() acquires the lock, so we can't hold it here.
 	 */
 	mutex_lock(&epmutex);
-	hlist_for_each_entry_safe(epi, next, &file->f_ep_links, fllink) {
+	if (unlikely(!file->f_ep)) {
+		mutex_unlock(&epmutex);
+		return;
+	}
+	hlist_for_each_entry_safe(epi, next, file->f_ep, fllink) {
 		ep = epi->ep;
 		mutex_lock_nested(&ep->mtx, 0);
 		ep_remove(ep, epi);
@@ -1248,7 +1305,7 @@ static void path_count_init(void)
 		path_count[i] = 0;
 }
 
-static int reverse_path_check_proc(struct file *file, int depth)
+static int reverse_path_check_proc(struct hlist_head *refs, int depth)
 {
 	int error = 0;
 	struct epitem *epi;
@@ -1257,14 +1314,12 @@ static int reverse_path_check_proc(struct file *file, int depth)
 		return -1;
 
 	/* CTL_DEL can remove links here, but that can't increase our count */
-	hlist_for_each_entry_rcu(epi, &file->f_ep_links, fllink) {
-		struct file *recepient = epi->ep->file;
-		if (WARN_ON(!is_file_epoll(recepient)))
-			continue;
-		if (hlist_empty(&recepient->f_ep_links))
+	hlist_for_each_entry_rcu(epi, refs, fllink) {
+		struct hlist_head *refs = &epi->ep->refs;
+		if (hlist_empty(refs))
 			error = path_count_inc(depth);
 		else
-			error = reverse_path_check_proc(recepient, depth + 1);
+			error = reverse_path_check_proc(refs, depth + 1);
 		if (error != 0)
 			break;
 	}
@@ -1272,7 +1327,7 @@ static int reverse_path_check_proc(struct file *file, int depth)
 }
 
 /**
- * reverse_path_check - The tfile_check_list is list of file *, which have
+ * reverse_path_check - The tfile_check_list is list of epitem_head, which have
  *                      links that are proposed to be newly added. We need to
  *                      make sure that those added links don't add too many
  *                      paths such that we will spend all our time waking up
@@ -1283,19 +1338,18 @@ static int reverse_path_check_proc(struct file *file, int depth)
  */
 static int reverse_path_check(void)
 {
-	int error = 0;
-	struct file *current_file;
+	struct epitems_head *p;
 
-	/* let's call this for all tfiles */
-	list_for_each_entry(current_file, &tfile_check_list, f_tfile_llink) {
+	for (p = tfile_check_list; p != EP_UNACTIVE_PTR; p = p->next) {
+		int error;
 		path_count_init();
 		rcu_read_lock();
-		error = reverse_path_check_proc(current_file, 0);
+		error = reverse_path_check_proc(&p->epitems, 0);
 		rcu_read_unlock();
 		if (error)
-			break;
+			return error;
 	}
-	return error;
+	return 0;
 }
 
 static int ep_create_wakeup_source(struct epitem *epi)
@@ -1336,6 +1390,39 @@ static noinline void ep_destroy_wakeup_source(struct epitem *epi)
 	wakeup_source_unregister(ws);
 }
 
+static int attach_epitem(struct file *file, struct epitem *epi)
+{
+	struct epitems_head *to_free = NULL;
+	struct hlist_head *head = NULL;
+	struct eventpoll *ep = NULL;
+
+	if (is_file_epoll(file))
+		ep = file->private_data;
+
+	if (ep) {
+		head = &ep->refs;
+	} else if (!READ_ONCE(file->f_ep)) {
+allocate:
+		to_free = kmem_cache_zalloc(ephead_cache, GFP_KERNEL);
+		if (!to_free)
+			return -ENOMEM;
+		head = &to_free->epitems;
+	}
+	spin_lock(&file->f_lock);
+	if (!file->f_ep) {
+		if (unlikely(!head)) {
+			spin_unlock(&file->f_lock);
+			goto allocate;
+		}
+		file->f_ep = head;
+		to_free = NULL;
+	}
+	hlist_add_head_rcu(&epi->fllink, file->f_ep);
+	spin_unlock(&file->f_lock);
+	free_ephead(to_free);
+	return 0;
+}
+
 /*
  * Must be called with "mtx" held.
  */
@@ -1367,19 +1454,21 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	epi->event = *event;
 	epi->next = EP_UNACTIVE_PTR;
 
-	atomic_long_inc(&ep->user->epoll_watches);
-
 	if (tep)
 		mutex_lock(&tep->mtx);
 	/* Add the current item to the list of active epoll hook for this file */
-	spin_lock(&tfile->f_lock);
-	hlist_add_head_rcu(&epi->fllink, &tfile->f_ep_links);
-	spin_unlock(&tfile->f_lock);
-	if (full_check && !tep) {
-		get_file(tfile);
-		list_add(&tfile->f_tfile_llink, &tfile_check_list);
+	if (unlikely(attach_epitem(tfile, epi) < 0)) {
+		kmem_cache_free(epi_cache, epi);
+		if (tep)
+			mutex_lock(&tep->mtx);
+		return -ENOMEM;
 	}
 
+	if (full_check && !tep)
+		list_file(tfile);
+
+	atomic_long_inc(&ep->user->epoll_watches);
+
 	/*
 	 * Add the current item to the RB tree. All RB tree operations are
 	 * protected by "mtx", and ep_insert() is called with "mtx" held.
@@ -1813,11 +1902,7 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 			 * not already there, and calling reverse_path_check()
 			 * during ep_insert().
 			 */
-			if (list_empty(&epi->ffd.file->f_tfile_llink)) {
-				if (get_file_rcu(epi->ffd.file))
-					list_add(&epi->ffd.file->f_tfile_llink,
-						 &tfile_check_list);
-			}
+			list_file(epi->ffd.file);
 		}
 	}
 	mutex_unlock(&ep->mtx);
@@ -1844,16 +1929,13 @@ static int ep_loop_check(struct eventpoll *ep, struct eventpoll *to)
 
 static void clear_tfile_check_list(void)
 {
-	struct file *file;
-
-	/* first clear the tfile_check_list */
-	while (!list_empty(&tfile_check_list)) {
-		file = list_first_entry(&tfile_check_list, struct file,
-					f_tfile_llink);
-		list_del_init(&file->f_tfile_llink);
-		fput(file);
+	rcu_read_lock();
+	while (tfile_check_list != EP_UNACTIVE_PTR) {
+		struct epitems_head *head = tfile_check_list;
+		tfile_check_list = head->next;
+		unlist_file(head);
 	}
-	INIT_LIST_HEAD(&tfile_check_list);
+	rcu_read_unlock();
 }
 
 /*
@@ -2003,9 +2085,8 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	if (error)
 		goto error_tgt_fput;
 	if (op == EPOLL_CTL_ADD) {
-		if (!hlist_empty(&f.file->f_ep_links) ||
-				ep->gen == loop_check_gen ||
-						is_file_epoll(tf.file)) {
+		if (READ_ONCE(f.file->f_ep) || ep->gen == loop_check_gen ||
+		    is_file_epoll(tf.file)) {
 			mutex_unlock(&ep->mtx);
 			error = epoll_mutex_lock(&epmutex, 0, nonblock);
 			if (error)
@@ -2216,6 +2297,9 @@ static int __init eventpoll_init(void)
 	pwq_cache = kmem_cache_create("eventpoll_pwq",
 		sizeof(struct eppoll_entry), 0, SLAB_PANIC|SLAB_ACCOUNT, NULL);
 
+	ephead_cache = kmem_cache_create("ep_head",
+		sizeof(struct epitems_head), 0, SLAB_PANIC|SLAB_ACCOUNT, NULL);
+
 	return 0;
 }
 fs_initcall(eventpoll_init);
diff --git a/fs/file_table.c b/fs/file_table.c
index 656647f9575a..f2bb37fd0905 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -113,7 +113,6 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
 	rwlock_init(&f->f_owner.lock);
 	spin_lock_init(&f->f_lock);
 	mutex_init(&f->f_pos_lock);
-	eventpoll_init_file(f);
 	f->f_flags = flags;
 	f->f_mode = OPEN_FMODE(flags);
 	/* f->f_version: 0 */
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 4e215ccfa792..0350393465d4 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -22,14 +22,6 @@ struct file;
 struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long toff);
 #endif
 
-/* Used to initialize the epoll bits inside the "struct file" */
-static inline void eventpoll_init_file(struct file *file)
-{
-	INIT_HLIST_HEAD(&file->f_ep_links);
-	INIT_LIST_HEAD(&file->f_tfile_llink);
-}
-
-
 /* Used to release the epoll bits inside the "struct file" */
 void eventpoll_release_file(struct file *file);
 
@@ -50,7 +42,7 @@ static inline void eventpoll_release(struct file *file)
 	 * because the file in on the way to be removed and nobody ( but
 	 * eventpoll ) has still a reference to this file.
 	 */
-	if (likely(hlist_empty(&file->f_ep_links)))
+	if (likely(!file->f_ep))
 		return;
 
 	/*
@@ -72,7 +64,6 @@ static inline int ep_op_has_event(int op)
 
 #else
 
-static inline void eventpoll_init_file(struct file *file) {}
 static inline void eventpoll_release(struct file *file) {}
 
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9dc4c09f1d13..a9242e1464d1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -928,7 +928,7 @@ struct file {
 	const struct file_operations	*f_op;
 
 	/*
-	 * Protects f_ep_links, f_flags.
+	 * Protects f_ep, f_flags.
 	 * Must not be taken from IRQ context.
 	 */
 	spinlock_t		f_lock;
@@ -951,8 +951,7 @@ struct file {
 
 #ifdef CONFIG_EPOLL
 	/* Used by fs/eventpoll.c to link all the hooks to this file */
-	struct hlist_head	f_ep_links;
-	struct list_head	f_tfile_llink;
+	struct hlist_head	*f_ep;
 #endif /* #ifdef CONFIG_EPOLL */
 	struct address_space	*f_mapping;
 	errseq_t		f_wb_err;
-- 
2.11.0

