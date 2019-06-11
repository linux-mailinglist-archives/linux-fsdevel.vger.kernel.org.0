Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A25083CFDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 16:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfFKO4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 10:56:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:52422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391593AbfFKOzK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:55:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7FD17AF0C;
        Tue, 11 Jun 2019 14:55:08 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/14] epoll: allocate user header and user events ring for polling from userspace
Date:   Tue, 11 Jun 2019 16:54:47 +0200
Message-Id: <20190611145458.9540-4-rpenyaev@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611145458.9540-1-rpenyaev@suse.de>
References: <20190611145458.9540-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This one allocates user header and user events ring according to max items
number, passed as a parameter.  User events (index) ring is in a pow2.
Pages, which will be shared between kernel and userspace, are accounted
through user->locked_vm counter.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c                 | 138 +++++++++++++++++++++++++++++++--
 include/uapi/linux/eventpoll.h |   3 +-
 2 files changed, 133 insertions(+), 8 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 90dc75ad4144..3a5c4d641ff0 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -228,6 +228,33 @@ struct eventpoll {
 
 	struct file *file;
 
+	/* User header with array of items */
+	struct epoll_uheader *user_header;
+
+	/* User index, which acts as a ring of coming events */
+	unsigned int *user_index;
+
+	/* Actual length of user header, always aligned on page */
+	unsigned int header_length;
+
+	/* Actual length of user index, always pow2 */
+	unsigned int index_length;
+
+	/* Maximum possible event items */
+	unsigned int max_items_nr;
+
+	/* Items bitmap, is used to get a free bit for new registered epi */
+	unsigned long *items_bm;
+
+	/* Length of both items bitmaps, always aligned on page */
+	unsigned int items_bm_length;
+
+	/*
+	 * Counter to support atomic and lockless ->tail updates.
+	 * See add_event_to_uring() for details of counter layout.
+	 */
+	atomic64_t shadow_cnt;
+
 	/* used to optimize loop detection check */
 	int visited;
 	struct list_head visited_list_link;
@@ -377,6 +404,27 @@ static void ep_nested_calls_init(struct nested_calls *ncalls)
 	spin_lock_init(&ncalls->lock);
 }
 
+static inline unsigned int ep_to_items_length(unsigned int nr)
+{
+	struct epoll_uheader *user_header;
+
+	return PAGE_ALIGN(struct_size(user_header, items, nr));
+}
+
+static inline unsigned int ep_to_index_length(unsigned int nr)
+{
+	struct eventpoll *ep;
+	unsigned int size;
+
+	size = roundup_pow_of_two(nr << ilog2(sizeof(*ep->user_index)));
+	return max_t(typeof(size), size, PAGE_SIZE);
+}
+
+static inline unsigned int ep_to_items_bm_length(unsigned int nr)
+{
+	return PAGE_ALIGN(ALIGN(nr, 8) >> 3);
+}
+
 /**
  * ep_events_available - Checks if ready events might be available.
  *
@@ -832,6 +880,38 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 	return 0;
 }
 
+static int ep_account_mem(struct eventpoll *ep, struct user_struct *user)
+{
+	unsigned long nr_pages, page_limit, cur_pages, new_pages;
+
+	nr_pages  = ep->header_length >> PAGE_SHIFT;
+	nr_pages += ep->index_length >> PAGE_SHIFT;
+
+	/* Don't allow more pages than we can safely lock */
+	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+
+	do {
+		cur_pages = atomic_long_read(&user->locked_vm);
+		new_pages = cur_pages + nr_pages;
+		if (new_pages > page_limit && !capable(CAP_IPC_LOCK))
+			return -ENOMEM;
+	} while (atomic_long_cmpxchg(&user->locked_vm, cur_pages,
+				     new_pages) != cur_pages);
+
+	return 0;
+}
+
+static void ep_unaccount_mem(struct eventpoll *ep, struct user_struct *user)
+{
+	unsigned long nr_pages;
+
+	nr_pages  = ep->header_length >> PAGE_SHIFT;
+	nr_pages += ep->index_length >> PAGE_SHIFT;
+	if (nr_pages)
+		/* When polled by user */
+		atomic_long_sub(nr_pages, &user->locked_vm);
+}
+
 static void ep_free(struct eventpoll *ep)
 {
 	struct rb_node *rbp;
@@ -879,8 +959,12 @@ static void ep_free(struct eventpoll *ep)
 
 	mutex_unlock(&epmutex);
 	mutex_destroy(&ep->mtx);
-	free_uid(ep->user);
 	wakeup_source_unregister(ep->ws);
+	vfree(ep->user_header);
+	vfree(ep->user_index);
+	vfree(ep->items_bm);
+	ep_unaccount_mem(ep, ep->user);
+	free_uid(ep->user);
 	kfree(ep);
 }
 
@@ -1033,7 +1117,7 @@ void eventpoll_release_file(struct file *file)
 	mutex_unlock(&epmutex);
 }
 
-static int ep_alloc(struct eventpoll **pep)
+static int ep_alloc(struct eventpoll **pep, int flags, size_t max_items)
 {
 	int error;
 	struct user_struct *user;
@@ -1045,6 +1129,39 @@ static int ep_alloc(struct eventpoll **pep)
 	if (unlikely(!ep))
 		goto free_uid;
 
+	if (flags & EPOLL_USERPOLL) {
+		BUILD_BUG_ON(sizeof(*ep->user_header) !=
+			     EPOLL_USERPOLL_HEADER_SIZE);
+		BUILD_BUG_ON(sizeof(ep->user_header->items[0]) != 16);
+
+		if (!max_items || max_items > EP_USERPOLL_MAX_ITEMS_NR) {
+			error = -EINVAL;
+			goto free_ep;
+		}
+		ep->max_items_nr = max_items;
+		ep->header_length = ep_to_items_length(max_items);
+		ep->index_length = ep_to_index_length(max_items);
+		ep->items_bm_length = ep_to_items_bm_length(max_items);
+
+		error = ep_account_mem(ep, user);
+		if (error)
+			goto free_ep;
+
+		ep->user_header = vmalloc_user(ep->header_length);
+		ep->user_index = vmalloc_user(ep->index_length);
+		ep->items_bm = vzalloc(ep->items_bm_length);
+		if (!ep->user_header || !ep->user_index || !ep->items_bm)
+			goto unaccount_mem;
+
+		*ep->user_header = (typeof(*ep->user_header)) {
+			.magic         = EPOLL_USERPOLL_HEADER_MAGIC,
+			.header_length = ep->header_length,
+			.index_length  = ep->index_length,
+			.max_items_nr  = ep->max_items_nr,
+		};
+	}
+
+	atomic64_set(&ep->shadow_cnt, 0);
 	mutex_init(&ep->mtx);
 	rwlock_init(&ep->lock);
 	init_waitqueue_head(&ep->wq);
@@ -1058,6 +1175,13 @@ static int ep_alloc(struct eventpoll **pep)
 
 	return 0;
 
+unaccount_mem:
+	ep_unaccount_mem(ep, user);
+free_ep:
+	vfree(ep->user_header);
+	vfree(ep->user_index);
+	vfree(ep->items_bm);
+	kfree(ep);
 free_uid:
 	free_uid(user);
 	return error;
@@ -2062,7 +2186,7 @@ static void clear_tfile_check_list(void)
 /*
  * Open an eventpoll file descriptor.
  */
-static int do_epoll_create(int flags)
+static int do_epoll_create(int flags, size_t size)
 {
 	int error, fd;
 	struct eventpoll *ep = NULL;
@@ -2071,12 +2195,12 @@ static int do_epoll_create(int flags)
 	/* Check the EPOLL_* constant for consistency.  */
 	BUILD_BUG_ON(EPOLL_CLOEXEC != O_CLOEXEC);
 
-	if (flags & ~EPOLL_CLOEXEC)
+	if (flags & ~(EPOLL_CLOEXEC | EPOLL_USERPOLL))
 		return -EINVAL;
 	/*
 	 * Create the internal data structure ("struct eventpoll").
 	 */
-	error = ep_alloc(&ep);
+	error = ep_alloc(&ep, flags, size);
 	if (error < 0)
 		return error;
 	/*
@@ -2107,7 +2231,7 @@ static int do_epoll_create(int flags)
 
 SYSCALL_DEFINE1(epoll_create1, int, flags)
 {
-	return do_epoll_create(flags);
+	return do_epoll_create(flags, 0);
 }
 
 SYSCALL_DEFINE1(epoll_create, int, size)
@@ -2115,7 +2239,7 @@ SYSCALL_DEFINE1(epoll_create, int, size)
 	if (size <= 0)
 		return -EINVAL;
 
-	return do_epoll_create(0);
+	return do_epoll_create(0, 0);
 }
 
 /*
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index 3317901b19c4..efd58e9177c2 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -20,7 +20,8 @@
 #include <linux/types.h>
 
 /* Flags for epoll_create1.  */
-#define EPOLL_CLOEXEC O_CLOEXEC
+#define EPOLL_CLOEXEC  O_CLOEXEC
+#define EPOLL_USERPOLL 1
 
 /* Valid opcodes to issue to sys_epoll_ctl() */
 #define EPOLL_CTL_ADD 1
-- 
2.21.0

