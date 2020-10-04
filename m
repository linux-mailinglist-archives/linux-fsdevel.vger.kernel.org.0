Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929C9282818
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgJDCji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgJDCjc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:32 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8FEC0613E8;
        Sat,  3 Oct 2020 19:39:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvu-00BUq0-Ch; Sun, 04 Oct 2020 02:39:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 07/27] untangling ep_call_nested(): and there was much rejoicing
Date:   Sun,  4 Oct 2020 03:39:09 +0100
Message-Id: <20201004023929.2740074-7-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 43 +++++++++++--------------------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 9a6ee5991f3d..8c3b02755a50 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -439,25 +439,6 @@ static bool ep_push_nested(void *cookie)
 	return true;
 }
 
-/**
- * ep_call_nested - Perform a bound (possibly) nested call, by checking
- *                  that the recursion limit is not exceeded, and that
- *                  the same nested call (by the meaning of same cookie) is
- *                  no re-entered.
- *
- * @nproc: Nested call core function pointer.
- * @priv: Opaque data to be passed to the @nproc callback.
- * @cookie: Cookie to be used to identify this nested call.
- *
- * Returns: Returns the code returned by the @nproc callback, or -1 if
- *          the maximum recursion limit has been exceeded.
- */
-static int ep_call_nested(int (*nproc)(void *, void *, int), void *priv,
-			  void *cookie)
-{
-	return (*nproc)(priv, cookie, nesting);
-}
-
 /*
  * As described in commit 0ccf831cb lockdep: annotate epoll
  * the use of wait queues used by epoll is done in a very controlled
@@ -1325,7 +1306,7 @@ static void path_count_init(void)
 		path_count[i] = 0;
 }
 
-static int reverse_path_check_proc(void *priv, void *cookie, int call_nests)
+static int reverse_path_check_proc(void *priv, void *cookie, int depth)
 {
 	int error = 0;
 	struct file *file = priv;
@@ -1341,13 +1322,13 @@ static int reverse_path_check_proc(void *priv, void *cookie, int call_nests)
 		child_file = epi->ep->file;
 		if (is_file_epoll(child_file)) {
 			if (list_empty(&child_file->f_ep_links)) {
-				if (path_count_inc(call_nests)) {
+				if (path_count_inc(depth)) {
 					error = -1;
 					break;
 				}
 			} else {
-				error = ep_call_nested(reverse_path_check_proc,
-							child_file, child_file);
+				error = reverse_path_check_proc(child_file, child_file,
+								depth + 1);
 			}
 			if (error != 0)
 				break;
@@ -1379,8 +1360,7 @@ static int reverse_path_check(void)
 	/* let's call this for all tfiles */
 	list_for_each_entry(current_file, &tfile_check_list, f_tfile_llink) {
 		path_count_init();
-		error = ep_call_nested(reverse_path_check_proc, current_file,
-					current_file);
+		error = reverse_path_check_proc(current_file, current_file, 0);
 		if (error)
 			break;
 	}
@@ -1886,8 +1866,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 }
 
 /**
- * ep_loop_check_proc - Callback function to be passed to the @ep_call_nested()
- *                      API, to verify that adding an epoll file inside another
+ * ep_loop_check_proc - verify that adding an epoll file inside another
  *                      epoll structure, does not violate the constraints, in
  *                      terms of closed loops, or too deep chains (which can
  *                      result in excessive stack usage).
@@ -1900,7 +1879,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
  * Returns: Returns zero if adding the epoll @file inside current epoll
  *          structure @ep does not violate the constraints, or -1 otherwise.
  */
-static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
+static int ep_loop_check_proc(void *priv, void *cookie, int depth)
 {
 	int error = 0;
 	struct file *file = priv;
@@ -1912,7 +1891,7 @@ static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
 	if (!ep_push_nested(cookie)) /* limits recursion */
 		return -1;
 
-	mutex_lock_nested(&ep->mtx, call_nests + 1);
+	mutex_lock_nested(&ep->mtx, depth + 1);
 	ep->gen = loop_check_gen;
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = rb_next(rbp)) {
 		epi = rb_entry(rbp, struct epitem, rbn);
@@ -1920,8 +1899,8 @@ static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
 			ep_tovisit = epi->ffd.file->private_data;
 			if (ep_tovisit->gen == loop_check_gen)
 				continue;
-			error = ep_call_nested(ep_loop_check_proc, epi->ffd.file,
-					ep_tovisit);
+			error = ep_loop_check_proc(epi->ffd.file, ep_tovisit,
+						   depth + 1);
 			if (error != 0)
 				break;
 		} else {
@@ -1959,7 +1938,7 @@ static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
  */
 static int ep_loop_check(struct eventpoll *ep, struct file *file)
 {
-	return ep_call_nested(ep_loop_check_proc, file, ep);
+	return ep_loop_check_proc(file, ep, 0);
 }
 
 static void clear_tfile_check_list(void)
-- 
2.11.0

