Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1962D1EFC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 01:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgLHAc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 19:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgLHAcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:32:25 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D42C061749;
        Mon,  7 Dec 2020 16:31:44 -0800 (PST)
Received: from localhost (unknown [IPv6:2804:14c:132:242d::1001])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DD59E1F44BBC;
        Tue,  8 Dec 2020 00:31:41 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 3/8] watch_queue: Support a text field at the end of the notification
Date:   Mon,  7 Dec 2020 21:31:12 -0300
Message-Id: <20201208003117.342047-4-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208003117.342047-1-krisman@collabora.com>
References: <20201208003117.342047-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allow notifications to send text information to userspace without
having to copy it to a temporary buffer to then copy to the ring.  One
use case to pass text information in notifications is for error
reporting, where more debug information might be needed, but we don't
want to explode the number of subtypes of notifications.  For instance,
ext4 can have a single inode error notification subtype, and pass more
information on the cause of the error in this field.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 include/linux/watch_queue.h | 14 ++++++++++++--
 kernel/watch_queue.c        | 29 ++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index f1086d12cd03..2f5a7446bca6 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -79,7 +79,7 @@ struct watch_list {
 extern void __post_watch_notification(struct watch_list *,
 				      struct watch_notification *,
 				      const struct cred *,
-				      u64);
+				      u64, const char*, va_list*);
 extern struct watch_queue *get_watch_queue(int);
 extern void put_watch_queue(struct watch_queue *);
 extern void init_watch(struct watch *, struct watch_queue *);
@@ -105,7 +105,17 @@ static inline void post_watch_notification(struct watch_list *wlist,
 					   u64 id)
 {
 	if (unlikely(wlist))
-		__post_watch_notification(wlist, n, cred, id);
+		__post_watch_notification(wlist, n, cred, id, NULL, NULL);
+}
+
+static inline void post_watch_notification_string(struct watch_list *wlist,
+						  struct watch_notification *n,
+						  const struct cred *cred,
+						  u64 id, const char *fmt,
+						  va_list *args)
+{
+	if (unlikely(wlist))
+		__post_watch_notification(wlist, n, cred, id, fmt, args);
 }
 
 static inline void remove_watch_list(struct watch_list *wlist, u64 id)
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 0ef8f65bd2d7..89fcf0420ce7 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -70,13 +70,15 @@ static const struct pipe_buf_operations watch_queue_pipe_buf_ops = {
  * Post a notification to a watch queue.
  */
 static bool post_one_notification(struct watch_queue *wqueue,
-				  struct watch_notification *n)
+				  struct watch_notification *n,
+				  const char *fmt, va_list *args)
 {
 	void *p;
 	struct pipe_inode_info *pipe = wqueue->pipe;
 	struct pipe_buffer *buf;
 	struct page *page;
 	unsigned int head, tail, mask, note, offset, len;
+	int wlen = 0;
 	bool done = false;
 
 	if (!pipe)
@@ -102,6 +104,23 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	get_page(page);
 	len = n->info & WATCH_INFO_LENGTH;
 	p = kmap_atomic(page);
+	/*
+	 * Write the tail description before the actual header, because
+	 * the string needs to be generated to calculate the final
+	 * notification size, that is passed in the header.
+	 */
+	if (fmt) {
+		wlen = vscnprintf(p + offset + len, WATCH_INFO_LENGTH - len,
+				  fmt, (args ? *args : NULL));
+		wlen += 1; /* vscnprintf doesn't include '\0' */
+		if (wlen > 0) {
+			n->info = n->info & ~WATCH_INFO_LENGTH;
+			n->info |= (len + wlen) & WATCH_INFO_LENGTH;
+		} else {
+			/* Drop errors when writing the extra string. */
+			wlen = 0;
+		}
+	}
 	memcpy(p + offset, n, len);
 	kunmap_atomic(p);
 
@@ -110,7 +129,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	buf->private = (unsigned long)wqueue;
 	buf->ops = &watch_queue_pipe_buf_ops;
 	buf->offset = offset;
-	buf->len = len;
+	buf->len = (len + wlen);
 	buf->flags = PIPE_BUF_FLAG_WHOLE;
 	pipe->head = head + 1;
 
@@ -175,7 +194,7 @@ static bool filter_watch_notification(const struct watch_filter *wf,
 void __post_watch_notification(struct watch_list *wlist,
 			       struct watch_notification *n,
 			       const struct cred *cred,
-			       u64 id)
+			       u64 id, const char *fmt, va_list *args)
 {
 	const struct watch_filter *wf;
 	struct watch_queue *wqueue;
@@ -202,7 +221,7 @@ void __post_watch_notification(struct watch_list *wlist,
 		if (security_post_notification(watch->cred, cred, n) < 0)
 			continue;
 
-		post_one_notification(wqueue, n);
+		post_one_notification(wqueue, n, fmt, args);
 	}
 
 	rcu_read_unlock();
@@ -522,7 +541,7 @@ int remove_watch_from_object(struct watch_list *wlist, struct watch_queue *wq,
 	 * protecting *wqueue from deallocation.
 	 */
 	if (wqueue) {
-		post_one_notification(wqueue, &n.watch);
+		post_one_notification(wqueue, &n.watch, NULL, NULL);
 
 		spin_lock_bh(&wqueue->lock);
 
-- 
2.29.2

