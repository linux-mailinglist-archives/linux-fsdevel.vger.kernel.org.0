Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6A51852C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgCMX4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:56:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50136 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgCMXyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7v-00B6cz-Mo; Fri, 13 Mar 2020 23:54:03 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 48/69] follow_dotdot{,_rcu}(): switch to use of step_into()
Date:   Fri, 13 Mar 2020 23:53:36 +0000
Message-Id: <20200313235357.2646756-48-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
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
 fs/namei.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1749e435edc7..9c775013368a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1722,33 +1722,18 @@ static const char *follow_dotdot_rcu(struct nameidata *nd)
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
+		return step_into(nd, WALK_NOFOLLOW,
+				 nd->path.dentry, nd->inode, nd->seq);
 	} else {
-		nd->path.dentry = parent;
-		nd->seq = seq;
+		return step_into(nd, WALK_NOFOLLOW, parent, inode, seq);
 	}
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
-	}
-	nd->inode = inode;
-	return NULL;
 }
 
 static const char *follow_dotdot(struct nameidata *nd)
@@ -1774,13 +1759,11 @@ static const char *follow_dotdot(struct nameidata *nd)
 	if (unlikely(!parent)) {
 		if (unlikely(nd->flags & LOOKUP_BENEATH))
 			return ERR_PTR(-EXDEV);
+		return step_into(nd, WALK_NOFOLLOW,
+				 dget(nd->path.dentry), nd->inode, nd->seq);
 	} else {
-		dput(nd->path.dentry);
-		nd->path.dentry = parent;
+		return step_into(nd, WALK_NOFOLLOW, parent, parent->d_inode, 0);
 	}
-	follow_mount(&nd->path);
-	nd->inode = nd->path.dentry->d_inode;
-	return NULL;
 }
 
 static const char *handle_dots(struct nameidata *nd, int type)
-- 
2.11.0

