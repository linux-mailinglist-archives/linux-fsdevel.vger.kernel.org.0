Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD2617501B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgCAVxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:53:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41760 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgCAVwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:51 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WW1-003fR5-VM; Sun, 01 Mar 2020 21:52:50 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 55/55] fs/namei.c: kill follow_mount()
Date:   Sun,  1 Mar 2020 21:52:40 +0000
Message-Id: <20200301215240.873899-55-viro@ZenIV.linux.org.uk>
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

the only remaining caller should be using follow_down() anyway

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f247eca119f1..d9fd5fd43ca1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1414,22 +1414,6 @@ static bool choose_mountpoint(struct mount *m, const struct path *root,
 }
 
 /*
- * Skip to top of mountpoint pile in refwalk mode for follow_dotdot()
- */
-static void follow_mount(struct path *path)
-{
-	while (d_mountpoint(path->dentry)) {
-		struct vfsmount *mounted = lookup_mnt(path);
-		if (!mounted)
-			break;
-		dput(path->dentry);
-		mntput(path->mnt);
-		path->mnt = mounted;
-		path->dentry = dget(mounted->mnt_root);
-	}
-}
-
-/*
  * This looks up the name in dcache and possibly revalidates the found dentry.
  * NULL is returned if the dentry does not exist in the cache.
  */
@@ -2668,7 +2652,7 @@ int path_pts(struct path *path)
 
 	path->dentry = child;
 	dput(parent);
-	follow_mount(path);
+	follow_down(path);
 	return 0;
 }
 #endif
-- 
2.11.0

