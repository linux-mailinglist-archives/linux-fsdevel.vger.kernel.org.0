Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F418282815
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgJDCjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgJDCjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:31 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073F9C0613D0;
        Sat,  3 Oct 2020 19:39:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvt-00BUpZ-Lz; Sun, 04 Oct 2020 02:39:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 03/27] untangling ep_call_nested(): get rid of useless arguments
Date:   Sun,  4 Oct 2020 03:39:05 +0100
Message-Id: <20201004023929.2740074-3-viro@ZenIV.linux.org.uk>
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

ctx is always equal to current, ncalls - to &poll_loop_ncalls.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 44aca681d897..ef73d71a5dc8 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -455,21 +455,19 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
  *                  the same nested call (by the meaning of same cookie) is
  *                  no re-entered.
  *
- * @ncalls: Pointer to the nested_calls structure to be used for this call.
  * @nproc: Nested call core function pointer.
  * @priv: Opaque data to be passed to the @nproc callback.
  * @cookie: Cookie to be used to identify this nested call.
- * @ctx: This instance context.
  *
  * Returns: Returns the code returned by the @nproc callback, or -1 if
  *          the maximum recursion limit has been exceeded.
  */
-static int ep_call_nested(struct nested_calls *ncalls,
-			  int (*nproc)(void *, void *, int), void *priv,
-			  void *cookie, void *ctx)
+static int ep_call_nested(int (*nproc)(void *, void *, int), void *priv,
+			  void *cookie)
 {
 	int error, call_nests = 0;
 	unsigned long flags;
+	struct nested_calls *ncalls = &poll_loop_ncalls;
 	struct list_head *lsthead = &ncalls->tasks_call_list;
 	struct nested_call_node *tncur;
 	struct nested_call_node tnode;
@@ -482,7 +480,7 @@ static int ep_call_nested(struct nested_calls *ncalls,
 	 * very much limited.
 	 */
 	list_for_each_entry(tncur, lsthead, llink) {
-		if (tncur->ctx == ctx &&
+		if (tncur->ctx == current &&
 		    (tncur->cookie == cookie || ++call_nests > EP_MAX_NESTS)) {
 			/*
 			 * Ops ... loop detected or maximum nest level reached.
@@ -494,7 +492,7 @@ static int ep_call_nested(struct nested_calls *ncalls,
 	}
 
 	/* Add the current task and cookie to the list */
-	tnode.ctx = ctx;
+	tnode.ctx = current;
 	tnode.cookie = cookie;
 	list_add(&tnode.llink, lsthead);
 
@@ -1397,10 +1395,8 @@ static int reverse_path_check_proc(void *priv, void *cookie, int call_nests)
 					break;
 				}
 			} else {
-				error = ep_call_nested(&poll_loop_ncalls,
-							reverse_path_check_proc,
-							child_file, child_file,
-							current);
+				error = ep_call_nested(reverse_path_check_proc,
+							child_file, child_file);
 			}
 			if (error != 0)
 				break;
@@ -1431,9 +1427,8 @@ static int reverse_path_check(void)
 	/* let's call this for all tfiles */
 	list_for_each_entry(current_file, &tfile_check_list, f_tfile_llink) {
 		path_count_init();
-		error = ep_call_nested(&poll_loop_ncalls,
-					reverse_path_check_proc, current_file,
-					current_file, current);
+		error = ep_call_nested(reverse_path_check_proc, current_file,
+					current_file);
 		if (error)
 			break;
 	}
@@ -1970,9 +1965,8 @@ static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
 			ep_tovisit = epi->ffd.file->private_data;
 			if (ep_tovisit->gen == loop_check_gen)
 				continue;
-			error = ep_call_nested(&poll_loop_ncalls,
-					ep_loop_check_proc, epi->ffd.file,
-					ep_tovisit, current);
+			error = ep_call_nested(ep_loop_check_proc, epi->ffd.file,
+					ep_tovisit);
 			if (error != 0)
 				break;
 		} else {
@@ -2009,8 +2003,7 @@ static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
  */
 static int ep_loop_check(struct eventpoll *ep, struct file *file)
 {
-	return ep_call_nested(&poll_loop_ncalls,
-			      ep_loop_check_proc, file, ep, current);
+	return ep_call_nested(ep_loop_check_proc, file, ep);
 }
 
 static void clear_tfile_check_list(void)
-- 
2.11.0

