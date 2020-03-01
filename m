Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA07175012
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCAVww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:52:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41730 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgCAVwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:49 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WW0-003fQO-9C; Sun, 01 Mar 2020 21:52:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 48/55] follow_dotdot{,_rcu}(): switch to use of step_into()
Date:   Sun,  1 Mar 2020 21:52:33 +0000
Message-Id: <20200301215240.873899-48-viro@ZenIV.linux.org.uk>
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

gets the regular mount crossing on result of ..

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3e3bf11ee3d7..cc01bca2266c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1724,35 +1724,19 @@ static const char *follow_dotdot_rcu(struct nameidata *nd, int flags)
 			/* we know that mountpoint was pinned */
 			nd->path.dentry = mountpoint;
 			nd->path.mnt = &mparent->mnt;
-			inode = inode2;
+			inode = nd->inode = inode2;
 			nd->seq = seq;
 		}
 	}
 	if (unlikely(!parent)) {
 		if (unlikely(nd->flags & LOOKUP_BENEATH))
 			return ERR_PTR(-ECHILD);
+		return step_into(nd, flags | WALK_NOFOLLOW,
+				 nd->path.dentry, nd->inode, nd->seq);
 	} else {
-		nd->path.dentry = parent;
-		nd->seq = seq;
-	}
-	while (unlikely(d_mountpoint(nd->path.dentry))) {
-		struct mount *mounted;
-		mounted = __lookup_mnt(nd->path.mnt, nd->path.dentry);
-		if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
-			return ERR_PTR(-ECHILD);
-		if (!mounted)
-			break;
-		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
-			return ERR_PTR(-ECHILD);
-		nd->path.mnt = &mounted->mnt;
-		nd->path.dentry = mounted->mnt.mnt_root;
-		inode = nd->path.dentry->d_inode;
-		nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
+		return step_into(nd, flags | WALK_NOFOLLOW,
+				 parent, inode, seq);
 	}
-	nd->inode = inode;
-	if (!(flags & WALK_MORE) && nd->depth)
-		put_link(nd);
-	return NULL;
 }
 
 static const char *follow_dotdot(struct nameidata *nd, int flags)
@@ -1778,15 +1762,12 @@ static const char *follow_dotdot(struct nameidata *nd, int flags)
 	if (unlikely(!parent)) {
 		if (unlikely(nd->flags & LOOKUP_BENEATH))
 			return ERR_PTR(-EXDEV);
+		return step_into(nd, flags | WALK_NOFOLLOW,
+				 dget(nd->path.dentry), nd->inode, nd->seq);
 	} else {
-		dput(nd->path.dentry);
-		nd->path.dentry = parent;
+		return step_into(nd, flags | WALK_NOFOLLOW,
+				 parent, parent->d_inode, 0);
 	}
-	follow_mount(&nd->path);
-	nd->inode = nd->path.dentry->d_inode;
-	if (!(flags & WALK_MORE) && nd->depth)
-		put_link(nd);
-	return NULL;
 }
 
 static const char *handle_dots(struct nameidata *nd, int type, int flags)
-- 
2.11.0

