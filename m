Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0927C282833
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgJDCk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgJDCji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D82C0613AF;
        Sat,  3 Oct 2020 19:39:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvx-00BUry-IH; Sun, 04 Oct 2020 02:39:33 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 24/27] convert ->f_ep_links/->fllink to hlist
Date:   Sun,  4 Oct 2020 03:39:26 +0100
Message-Id: <20201004023929.2740074-24-viro@ZenIV.linux.org.uk>
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

we don't care about the order of elements there

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c            | 18 +++++++++---------
 include/linux/eventpoll.h |  4 ++--
 include/linux/fs.h        |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 66da645d5eb4..78b8769b72dc 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -160,7 +160,7 @@ struct epitem {
 	struct eventpoll *ep;
 
 	/* List header used to link this item to the "struct file" items list */
-	struct list_head fllink;
+	struct hlist_node fllink;
 
 	/* wakeup_source used when EPOLLWAKEUP is set */
 	struct wakeup_source __rcu *ws;
@@ -642,7 +642,7 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 
 	/* Remove the current item from the list of epoll hooks */
 	spin_lock(&file->f_lock);
-	list_del_rcu(&epi->fllink);
+	hlist_del_rcu(&epi->fllink);
 	spin_unlock(&file->f_lock);
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
@@ -835,7 +835,8 @@ static const struct file_operations eventpoll_fops = {
 void eventpoll_release_file(struct file *file)
 {
 	struct eventpoll *ep;
-	struct epitem *epi, *next;
+	struct epitem *epi;
+	struct hlist_node *next;
 
 	/*
 	 * We don't want to get "file->f_lock" because it is not
@@ -851,7 +852,7 @@ void eventpoll_release_file(struct file *file)
 	 * Besides, ep_remove() acquires the lock, so we can't hold it here.
 	 */
 	mutex_lock(&epmutex);
-	list_for_each_entry_safe(epi, next, &file->f_ep_links, fllink) {
+	hlist_for_each_entry_safe(epi, next, &file->f_ep_links, fllink) {
 		ep = epi->ep;
 		mutex_lock_nested(&ep->mtx, 0);
 		ep_remove(ep, epi);
@@ -1257,11 +1258,11 @@ static int reverse_path_check_proc(struct file *file, int depth)
 
 	/* CTL_DEL can remove links here, but that can't increase our count */
 	rcu_read_lock();
-	list_for_each_entry_rcu(epi, &file->f_ep_links, fllink) {
+	hlist_for_each_entry_rcu(epi, &file->f_ep_links, fllink) {
 		struct file *recepient = epi->ep->file;
 		if (WARN_ON(!is_file_epoll(recepient)))
 			continue;
-		if (list_empty(&recepient->f_ep_links))
+		if (hlist_empty(&recepient->f_ep_links))
 			error = path_count_inc(depth);
 		else
 			error = reverse_path_check_proc(recepient, depth + 1);
@@ -1361,7 +1362,6 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 
 	/* Item initialization follow here ... */
 	INIT_LIST_HEAD(&epi->rdllink);
-	INIT_LIST_HEAD(&epi->fllink);
 	epi->ep = ep;
 	ep_set_ffd(&epi->ffd, tfile, fd);
 	epi->event = *event;
@@ -1373,7 +1373,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 		mutex_lock(&tep->mtx);
 	/* Add the current item to the list of active epoll hook for this file */
 	spin_lock(&tfile->f_lock);
-	list_add_tail_rcu(&epi->fllink, &tfile->f_ep_links);
+	hlist_add_head_rcu(&epi->fllink, &tfile->f_ep_links);
 	spin_unlock(&tfile->f_lock);
 
 	/*
@@ -1999,7 +1999,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	if (error)
 		goto error_tgt_fput;
 	if (op == EPOLL_CTL_ADD) {
-		if (!list_empty(&f.file->f_ep_links) ||
+		if (!hlist_empty(&f.file->f_ep_links) ||
 				ep->gen == loop_check_gen ||
 						is_file_epoll(tf.file)) {
 			mutex_unlock(&ep->mtx);
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 8f000fada5a4..4e215ccfa792 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -25,7 +25,7 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long t
 /* Used to initialize the epoll bits inside the "struct file" */
 static inline void eventpoll_init_file(struct file *file)
 {
-	INIT_LIST_HEAD(&file->f_ep_links);
+	INIT_HLIST_HEAD(&file->f_ep_links);
 	INIT_LIST_HEAD(&file->f_tfile_llink);
 }
 
@@ -50,7 +50,7 @@ static inline void eventpoll_release(struct file *file)
 	 * because the file in on the way to be removed and nobody ( but
 	 * eventpoll ) has still a reference to this file.
 	 */
-	if (likely(list_empty(&file->f_ep_links)))
+	if (likely(hlist_empty(&file->f_ep_links)))
 		return;
 
 	/*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e019ea2f1347..9dc4c09f1d13 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -951,7 +951,7 @@ struct file {
 
 #ifdef CONFIG_EPOLL
 	/* Used by fs/eventpoll.c to link all the hooks to this file */
-	struct list_head	f_ep_links;
+	struct hlist_head	f_ep_links;
 	struct list_head	f_tfile_llink;
 #endif /* #ifdef CONFIG_EPOLL */
 	struct address_space	*f_mapping;
-- 
2.11.0

