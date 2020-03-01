Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE0017500F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCAVwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:52:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41710 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgCAVws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:48 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVz-003fPt-9D; Sun, 01 Mar 2020 21:52:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 43/55] follow_dotdot{,_rcu}(): lift LOOKUP_BENEATH checks out of loop
Date:   Sun,  1 Mar 2020 21:52:28 +0000
Message-Id: <20200301215240.873899-43-viro@ZenIV.linux.org.uk>
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

Behaviour change: LOOKUP_BENEATH lookup of .. in absolute root
yields an error even if it's not the process' root.  That's
possible only if you'd managed to escape chroot jail by way of
procfs symlinks, but IMO the resulting behaviour is not worse -
more consistent and easier to describe:
	".." in root is "stay where you are", uness LOOKUP_BENEATH
	has been given, in which case it's "fail with EXDEV".

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c307bf7cbaa1..be756aa32240 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1370,11 +1370,8 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 	unsigned seq;
 
 	while (1) {
-		if (path_equal(&nd->path, &nd->root)) {
-			if (unlikely(nd->flags & LOOKUP_BENEATH))
-				return -ECHILD;
+		if (path_equal(&nd->path, &nd->root))
 			break;
-		}
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
 			struct dentry *old = nd->path.dentry;
 
@@ -1405,7 +1402,10 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 			nd->seq = seq;
 		}
 	}
-	if (likely(parent)) {
+	if (unlikely(!parent)) {
+		if (unlikely(nd->flags & LOOKUP_BENEATH))
+			return -ECHILD;
+	} else {
 		nd->path.dentry = parent;
 		nd->seq = seq;
 	}
@@ -1447,11 +1447,8 @@ static int follow_dotdot(struct nameidata *nd)
 {
 	struct dentry *parent = NULL;
 	while (1) {
-		if (path_equal(&nd->path, &nd->root)) {
-			if (unlikely(nd->flags & LOOKUP_BENEATH))
-				return -EXDEV;
+		if (path_equal(&nd->path, &nd->root))
 			break;
-		}
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
 			/* rare case of legitimate dget_parent()... */
 			parent = dget_parent(nd->path.dentry);
@@ -1466,7 +1463,10 @@ static int follow_dotdot(struct nameidata *nd)
 		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
 			return -EXDEV;
 	}
-	if (likely(parent)) {
+	if (unlikely(!parent)) {
+		if (unlikely(nd->flags & LOOKUP_BENEATH))
+			return -EXDEV;
+	} else {
 		dput(nd->path.dentry);
 		nd->path.dentry = parent;
 	}
-- 
2.11.0

