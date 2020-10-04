Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484CA28283D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgJDCkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgJDCjc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:32 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5E0C0613E7;
        Sat,  3 Oct 2020 19:39:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvu-00BUpt-AD; Sun, 04 Oct 2020 02:39:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 06/27] untangling ep_call_nested(): move push/pop of cookie into the callbacks
Date:   Sun,  4 Oct 2020 03:39:08 +0100
Message-Id: <20201004023929.2740074-6-viro@ZenIV.linux.org.uk>
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
 fs/eventpoll.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index bd2cc78c47c8..9a6ee5991f3d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -455,15 +455,7 @@ static bool ep_push_nested(void *cookie)
 static int ep_call_nested(int (*nproc)(void *, void *, int), void *priv,
 			  void *cookie)
 {
-	int error;
-
-	if (!ep_push_nested(cookie))
-		return -1;
-	/* Call the nested function */
-	error = (*nproc)(priv, cookie, nesting - 1);
-	nesting--;
-
-	return error;
+	return (*nproc)(priv, cookie, nesting);
 }
 
 /*
@@ -1340,6 +1332,9 @@ static int reverse_path_check_proc(void *priv, void *cookie, int call_nests)
 	struct file *child_file;
 	struct epitem *epi;
 
+	if (!ep_push_nested(cookie)) /* limits recursion */
+		return -1;
+
 	/* CTL_DEL can remove links here, but that can't increase our count */
 	rcu_read_lock();
 	list_for_each_entry_rcu(epi, &file->f_ep_links, fllink) {
@@ -1362,6 +1357,7 @@ static int reverse_path_check_proc(void *priv, void *cookie, int call_nests)
 		}
 	}
 	rcu_read_unlock();
+	nesting--; /* pop */
 	return error;
 }
 
@@ -1913,6 +1909,9 @@ static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
 	struct rb_node *rbp;
 	struct epitem *epi;
 
+	if (!ep_push_nested(cookie)) /* limits recursion */
+		return -1;
+
 	mutex_lock_nested(&ep->mtx, call_nests + 1);
 	ep->gen = loop_check_gen;
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = rb_next(rbp)) {
@@ -1942,6 +1941,7 @@ static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
 		}
 	}
 	mutex_unlock(&ep->mtx);
+	nesting--; /* pop */
 
 	return error;
 }
-- 
2.11.0

