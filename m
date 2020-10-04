Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F24B282836
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgJDCkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgJDCjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE8C0613D0;
        Sat,  3 Oct 2020 19:39:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvv-00BUqV-3n; Sun, 04 Oct 2020 02:39:31 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 11/27] ep_loop_check_proc(): lift pushing the cookie into callers
Date:   Sun,  4 Oct 2020 03:39:13 +0100
Message-Id: <20201004023929.2740074-11-viro@ZenIV.linux.org.uk>
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
 fs/eventpoll.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 33af838046ea..9edea3933790 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1877,9 +1877,6 @@ static int ep_loop_check_proc(void *priv, void *cookie, int depth)
 	struct rb_node *rbp;
 	struct epitem *epi;
 
-	if (!ep_push_nested(cookie)) /* limits recursion */
-		return -1;
-
 	mutex_lock_nested(&ep->mtx, depth + 1);
 	ep->gen = loop_check_gen;
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = rb_next(rbp)) {
@@ -1888,8 +1885,13 @@ static int ep_loop_check_proc(void *priv, void *cookie, int depth)
 			ep_tovisit = epi->ffd.file->private_data;
 			if (ep_tovisit->gen == loop_check_gen)
 				continue;
-			error = ep_loop_check_proc(epi->ffd.file, ep_tovisit,
+			if (!ep_push_nested(ep_tovisit)) {
+				error = -1;
+			} else {
+				error = ep_loop_check_proc(epi->ffd.file, ep_tovisit,
 						   depth + 1);
+				nesting--;
+			}
 			if (error != 0)
 				break;
 		} else {
@@ -1909,7 +1911,6 @@ static int ep_loop_check_proc(void *priv, void *cookie, int depth)
 		}
 	}
 	mutex_unlock(&ep->mtx);
-	nesting--; /* pop */
 
 	return error;
 }
@@ -1927,7 +1928,12 @@ static int ep_loop_check_proc(void *priv, void *cookie, int depth)
  */
 static int ep_loop_check(struct eventpoll *ep, struct file *file)
 {
-	return ep_loop_check_proc(file, ep, 0);
+	int err;
+
+	ep_push_nested(ep); // can't fail
+	err = ep_loop_check_proc(file, ep, 0);
+	nesting--;
+	return err;
 }
 
 static void clear_tfile_check_list(void)
-- 
2.11.0

