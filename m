Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31157175056
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgCAVzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:55:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41618 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgCAVwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:45 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVv-003fNd-Oh; Sun, 01 Mar 2020 21:52:43 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 20/55] merging pick_link() with get_link(), part 3
Date:   Sun,  1 Mar 2020 21:52:05 +0000
Message-Id: <20200301215240.873899-20-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
References: <20200301215125.GA873525@ZenIV.linux.org.uk>
 <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

After a pure jump ("/" or procfs-style symlink) we don't need to
hold the link anymore.  link_path_walk() dropped it if such case
had been detected, lookup_last/do_last() (i.e. old trailing_symlink())
left it on the stack - it ended up calling terminate_walk() shortly
anyway, which would've purged the entire stack.

Do it in get_link() itself instead.  Simpler logics that way...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 888b1e5b994e..46cd3e5cb052 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1154,7 +1154,9 @@ const char *get_link(struct nameidata *nd)
 		} else {
 			res = get(dentry, inode, &last->done);
 		}
-		if (IS_ERR_OR_NULL(res))
+		if (!res)
+			goto all_done;
+		if (IS_ERR(res))
 			return res;
 	}
 	if (*res == '/') {
@@ -1164,9 +1166,11 @@ const char *get_link(struct nameidata *nd)
 		while (unlikely(*++res == '/'))
 			;
 	}
-	if (!*res)
-		res = NULL;
-	return res;
+	if (*res)
+		return res;
+all_done: // pure jump
+	put_link(nd);
+	return NULL;
 }
 
 /*
@@ -2211,11 +2215,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 
 			if (IS_ERR(s))
 				return PTR_ERR(s);
-			err = 0;
-			if (unlikely(!s)) {
-				/* jumped */
-				put_link(nd);
-			} else {
+			if (likely(s)) {
 				nd->stack[nd->depth - 1].name = name;
 				name = s;
 				continue;
-- 
2.11.0

