Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7028282F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgJDCk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgJDCji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A0C0613AC;
        Sat,  3 Oct 2020 19:39:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvx-00BUrd-39; Sun, 04 Oct 2020 02:39:33 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 21/27] take the common part of ep_eventpoll_poll() and ep_item_poll() into helper
Date:   Sun,  4 Oct 2020 03:39:23 +0100
Message-Id: <20201004023929.2740074-21-viro@ZenIV.linux.org.uk>
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

The only reason why ep_item_poll() can't simply call ep_eventpoll_poll()
(or, better yet, call vfs_poll() in all cases) is that we need to tell
lockdep how deep into the hierarchy of ->mtx we are.  So let's add
a variant of ep_eventpoll_poll() that would take depth explicitly
and turn ep_eventpoll_poll() into wrapper for that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 57 +++++++++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 39947b71f7af..a50b48d26c55 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -732,6 +732,27 @@ static int ep_eventpoll_release(struct inode *inode, struct file *file)
 static __poll_t ep_read_events_proc(struct eventpoll *ep, struct list_head *head,
 			       int depth);
 
+static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int depth)
+{
+	struct eventpoll *ep = file->private_data;
+	LIST_HEAD(txlist);
+	__poll_t res;
+
+	/* Insert inside our poll wait queue */
+	poll_wait(file, &ep->poll_wait, wait);
+
+	/*
+	 * Proceed to find out if wanted events are really available inside
+	 * the ready list.
+	 */
+	mutex_lock_nested(&ep->mtx, depth);
+	ep_start_scan(ep, &txlist);
+	res = ep_read_events_proc(ep, &txlist, depth + 1);
+	ep_done_scan(ep, &txlist);
+	mutex_unlock(&ep->mtx);
+	return res;
+}
+
 /*
  * Differs from ep_eventpoll_poll() in that internal callers already have
  * the ep->mtx so we need to start from depth=1, such that mutex_lock_nested()
@@ -740,22 +761,14 @@ static __poll_t ep_read_events_proc(struct eventpoll *ep, struct list_head *head
 static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 				 int depth)
 {
-	struct eventpoll *ep;
-	LIST_HEAD(txlist);
+	struct file *file = epi->ffd.file;
 	__poll_t res;
 
 	pt->_key = epi->event.events;
-	if (!is_file_epoll(epi->ffd.file))
-		return vfs_poll(epi->ffd.file, pt) & epi->event.events;
-
-	ep = epi->ffd.file->private_data;
-	poll_wait(epi->ffd.file, &ep->poll_wait, pt);
-
-	mutex_lock_nested(&ep->mtx, depth);
-	ep_start_scan(ep, &txlist);
-	res = ep_read_events_proc(ep, &txlist, depth + 1);
-	ep_done_scan(ep, &txlist);
-	mutex_unlock(&ep->mtx);
+	if (!is_file_epoll(file))
+		res = vfs_poll(file, pt);
+	else
+		res = __ep_eventpoll_poll(file, pt, depth);
 	return res & epi->event.events;
 }
 
@@ -786,23 +799,7 @@ static __poll_t ep_read_events_proc(struct eventpoll *ep, struct list_head *head
 
 static __poll_t ep_eventpoll_poll(struct file *file, poll_table *wait)
 {
-	struct eventpoll *ep = file->private_data;
-	LIST_HEAD(txlist);
-	__poll_t res;
-
-	/* Insert inside our poll wait queue */
-	poll_wait(file, &ep->poll_wait, wait);
-
-	/*
-	 * Proceed to find out if wanted events are really available inside
-	 * the ready list.
-	 */
-	mutex_lock(&ep->mtx);
-	ep_start_scan(ep, &txlist);
-	res = ep_read_events_proc(ep, &txlist, 1);
-	ep_done_scan(ep, &txlist);
-	mutex_unlock(&ep->mtx);
-	return res;
+	return __ep_eventpoll_poll(file, wait, 0);
 }
 
 #ifdef CONFIG_PROC_FS
-- 
2.11.0

