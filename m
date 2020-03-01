Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C529317501F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCAVxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:53:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41752 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbgCAVwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:50 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WW1-003fQs-DE; Sun, 01 Mar 2020 21:52:49 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 53/55] helper for mount rootwards traversal
Date:   Sun,  1 Mar 2020 21:52:38 +0000
Message-Id: <20200301215240.873899-53-viro@ZenIV.linux.org.uk>
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

The loops in follow_dotdot{_rcu()} are doing the same thing:
we have a mount and we want to find out how far up the chain
of mounts do we need to go.

We follow the chain of mount until we find one that is not
directly overmounting the root of another mount.  If such
a mount is found, we want the location it's mounted upon.
If we run out of chain (i.e. get to a mount that is not
mounted on anything else) or run into process' root, we
report failure.

On success, we want (in RCU case) d_seq of resulting location
sampled or (in non-RCU case) references to that location
acquired.

This commit introduces such primitive for RCU case and
switches follow_dotdot_rcu() to it; non-RCU case will be
go in the next commit.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ab17f7ea8c9f..8c09523c6f56 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1363,6 +1363,26 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 	return ret;
 }
 
+static bool choose_mountpoint_rcu(struct mount *m, const struct path *root,
+				  struct path *path, unsigned *seqp)
+{
+	while (mnt_has_parent(m)) {
+		struct dentry *mountpoint = m->mnt_mountpoint;
+
+		m = m->mnt_parent;
+		if (unlikely(root->dentry == mountpoint &&
+			     root->mnt == &m->mnt))
+			break;
+		if (mountpoint != m->mnt.mnt_root) {
+			path->mnt = &m->mnt;
+			path->dentry = mountpoint;
+			*seqp = read_seqcount_begin(&mountpoint->d_seq);
+			return true;
+		}
+	}
+	return false;
+}
+
 /*
  * Skip to top of mountpoint pile in refwalk mode for follow_dotdot()
  */
@@ -1698,23 +1718,11 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 	if (path_equal(&nd->path, &nd->root))
 		goto in_root;
 	if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
-		struct path path = nd->path;
+		struct path path;
 		unsigned seq;
-
-		while (1) {
-			struct mount *mnt = real_mount(path.mnt);
-			struct mount *mparent = mnt->mnt_parent;
-			struct dentry *mountpoint = mnt->mnt_mountpoint;
-			seq = read_seqcount_begin(&mountpoint->d_seq);
-			if (&mparent->mnt == path.mnt)
-				goto in_root;
-			path.dentry = mountpoint;
-			path.mnt = &mparent->mnt;
-			if (path_equal(&path, &nd->root))
-				goto in_root;
-			if (path.dentry != path.mnt->mnt_root)
-				break;
-		}
+		if (!choose_mountpoint_rcu(real_mount(nd->path.mnt),
+					   &nd->root, &path, &seq))
+			goto in_root;
 		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
 			return ERR_PTR(-ECHILD);
 		nd->path = path;
-- 
2.11.0

