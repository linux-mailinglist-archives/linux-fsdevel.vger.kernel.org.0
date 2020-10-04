Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C051282823
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgJDCjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgJDCjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B12C0613E8;
        Sat,  3 Oct 2020 19:39:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvv-00BUqh-Jn; Sun, 04 Oct 2020 02:39:31 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 13/27] ep_loop_check_proc(): saner calling conventions
Date:   Sun,  4 Oct 2020 03:39:15 +0100
Message-Id: <20201004023929.2740074-13-viro@ZenIV.linux.org.uk>
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

1) 'cookie' argument is unused; kill it.
2) 'priv' one is always an epoll struct file, and we only care
about its associated struct eventpoll; pass that instead.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 6b1990b8b9a0..e971e3ace557 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1845,19 +1845,14 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
  *                      result in excessive stack usage).
  *
  * @priv: Pointer to the epoll file to be currently checked.
- * @cookie: Original cookie for this call. This is the top-of-the-chain epoll
- *          data structure pointer.
- * @call_nests: Current dept of the @ep_call_nested() call stack.
+ * @depth: Current depth of the path being checked.
  *
  * Returns: Returns zero if adding the epoll @file inside current epoll
  *          structure @ep does not violate the constraints, or -1 otherwise.
  */
-static int ep_loop_check_proc(void *priv, void *cookie, int depth)
+static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 {
 	int error = 0;
-	struct file *file = priv;
-	struct eventpoll *ep = file->private_data;
-	struct eventpoll *ep_tovisit;
 	struct rb_node *rbp;
 	struct epitem *epi;
 
@@ -1866,15 +1861,14 @@ static int ep_loop_check_proc(void *priv, void *cookie, int depth)
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = rb_next(rbp)) {
 		epi = rb_entry(rbp, struct epitem, rbn);
 		if (unlikely(is_file_epoll(epi->ffd.file))) {
+			struct eventpoll *ep_tovisit;
 			ep_tovisit = epi->ffd.file->private_data;
 			if (ep_tovisit->gen == loop_check_gen)
 				continue;
-			if (ep_tovisit == inserting_into || depth > EP_MAX_NESTS) {
+			if (ep_tovisit == inserting_into || depth > EP_MAX_NESTS)
 				error = -1;
-			} else {
-				error = ep_loop_check_proc(epi->ffd.file, ep_tovisit,
-						   depth + 1);
-			}
+			else
+				error = ep_loop_check_proc(ep_tovisit, depth + 1);
 			if (error != 0)
 				break;
 		} else {
@@ -1899,20 +1893,20 @@ static int ep_loop_check_proc(void *priv, void *cookie, int depth)
 }
 
 /**
- * ep_loop_check - Performs a check to verify that adding an epoll file (@file)
- *                 another epoll file (represented by @ep) does not create
+ * ep_loop_check - Performs a check to verify that adding an epoll file (@to)
+ *                 into another epoll file (represented by @from) does not create
  *                 closed loops or too deep chains.
  *
- * @ep: Pointer to the epoll private data structure.
- * @file: Pointer to the epoll file to be checked.
+ * @from: Pointer to the epoll we are inserting into.
+ * @to: Pointer to the epoll to be inserted.
  *
- * Returns: Returns zero if adding the epoll @file inside current epoll
- *          structure @ep does not violate the constraints, or -1 otherwise.
+ * Returns: Returns zero if adding the epoll @to inside the epoll @from
+ * does not violate the constraints, or -1 otherwise.
  */
-static int ep_loop_check(struct eventpoll *ep, struct file *file)
+static int ep_loop_check(struct eventpoll *ep, struct eventpoll *to)
 {
 	inserting_into = ep;
-	return ep_loop_check_proc(file, ep, 0);
+	return ep_loop_check_proc(to, 0);
 }
 
 static void clear_tfile_check_list(void)
@@ -2086,8 +2080,9 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 			loop_check_gen++;
 			full_check = 1;
 			if (is_file_epoll(tf.file)) {
+				tep = tf.file->private_data;
 				error = -ELOOP;
-				if (ep_loop_check(ep, tf.file) != 0)
+				if (ep_loop_check(ep, tep) != 0)
 					goto error_tgt_fput;
 			} else {
 				get_file(tf.file);
@@ -2098,7 +2093,6 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 			if (error)
 				goto error_tgt_fput;
 			if (is_file_epoll(tf.file)) {
-				tep = tf.file->private_data;
 				error = epoll_mutex_lock(&tep->mtx, 1, nonblock);
 				if (error) {
 					mutex_unlock(&ep->mtx);
-- 
2.11.0

