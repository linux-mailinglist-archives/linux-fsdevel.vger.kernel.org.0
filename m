Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DAF175026
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgCAVx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:53:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41738 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgCAVwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:50 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WW0-003fQa-Mi; Sun, 01 Mar 2020 21:52:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 50/55] follow_dotdot{,_rcu}(): massage loops
Date:   Sun,  1 Mar 2020 21:52:35 +0000
Message-Id: <20200301215240.873899-50-viro@ZenIV.linux.org.uk>
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

The logics in both of them is the same:
	while true
		if in process' root	// uncommon
			break
		if *not* in mount root	// normal case
			find the parent
			return
		if at absolute root	// very uncommon
			break
		move to underlying mountpoint
	report that we are in root

Pull the common path out of the loop:
	if in process' root		// uncommon
		goto in_root
	if unlikely(in mount root)
		while true
			if at absolute root
				goto in_root
			move to underlying mountpoint
			if in process' root
				goto in_root
			if in mount root
				break;
	find the parent	// we are not in mount root
	return
in_root:
	report that we are in root

The reason for that transformation is that we get to keep the
common path straight *and* get a separate block for "move
through underlying mountpoints", which will allow to sanitize
NO_XDEV handling there.  What's more, the pared-down loops
will be easier to deal with - in particular, non-RCU case
has no need to grab mount_lock and rewriting it to the
form that wouldn't do that is a non-trivial change.  Better
do that with less stuff getting in the way...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 77 ++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index cf7b7a6c08fc..aa03a4b2ebe9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1693,21 +1693,12 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 					struct inode **inodep,
 					unsigned *seqp)
 {
-	while (1) {
-		if (path_equal(&nd->path, &nd->root))
-			break;
-		if (nd->path.dentry != nd->path.mnt->mnt_root) {
-			struct dentry *old = nd->path.dentry;
-			struct dentry *parent = old->d_parent;
+	struct dentry *parent, *old;
 
-			*inodep = parent->d_inode;
-			*seqp = read_seqcount_begin(&parent->d_seq);
-			if (unlikely(read_seqcount_retry(&old->d_seq, nd->seq)))
-				return ERR_PTR(-ECHILD);
-			if (unlikely(!path_connected(nd->path.mnt, parent)))
-				return ERR_PTR(-ECHILD);
-			return parent;
-		} else {
+	if (path_equal(&nd->path, &nd->root))
+		goto in_root;
+	if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
+		while (1) {
 			struct mount *mnt = real_mount(nd->path.mnt);
 			struct mount *mparent = mnt->mnt_parent;
 			struct dentry *mountpoint = mnt->mnt_mountpoint;
@@ -1716,7 +1707,7 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 			if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
 				return ERR_PTR(-ECHILD);
 			if (&mparent->mnt == nd->path.mnt)
-				break;
+				goto in_root;
 			if (unlikely(nd->flags & LOOKUP_NO_XDEV))
 				return ERR_PTR(-ECHILD);
 			/* we know that mountpoint was pinned */
@@ -1724,8 +1715,22 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 			nd->path.mnt = &mparent->mnt;
 			nd->inode = inode;
 			nd->seq = seq;
+			if (path_equal(&nd->path, &nd->root))
+				goto in_root;
+			if (nd->path.dentry != nd->path.mnt->mnt_root)
+				break;
 		}
 	}
+	old = nd->path.dentry;
+	parent = old->d_parent;
+	*inodep = parent->d_inode;
+	*seqp = read_seqcount_begin(&parent->d_seq);
+	if (unlikely(read_seqcount_retry(&old->d_seq, nd->seq)))
+		return ERR_PTR(-ECHILD);
+	if (unlikely(!path_connected(nd->path.mnt, parent)))
+		return ERR_PTR(-ECHILD);
+	return parent;
+in_root:
 	if (unlikely(nd->flags & LOOKUP_BENEATH))
 		return ERR_PTR(-ECHILD);
 	return NULL;
@@ -1735,25 +1740,33 @@ static struct dentry *follow_dotdot(struct nameidata *nd,
 				 struct inode **inodep,
 				 unsigned *seqp)
 {
-	while (1) {
-		if (path_equal(&nd->path, &nd->root))
-			break;
-		if (nd->path.dentry != nd->path.mnt->mnt_root) {
-			/* rare case of legitimate dget_parent()... */
-			struct dentry *parent = dget_parent(nd->path.dentry);
-			if (unlikely(!path_connected(nd->path.mnt, parent))) {
-				dput(parent);
-				return ERR_PTR(-ENOENT);
-			}
-			*seqp = 0;
-			*inodep = parent->d_inode;
-			return parent;
+	struct dentry *parent;
+
+	if (path_equal(&nd->path, &nd->root))
+		goto in_root;
+	if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
+		while (1) {
+			if (!follow_up(&nd->path))
+				goto in_root;
+			if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+				return ERR_PTR(-EXDEV);
+			if (path_equal(&nd->path, &nd->root))
+				goto in_root;
+			if (nd->path.dentry != nd->path.mnt->mnt_root)
+				break;
 		}
-		if (!follow_up(&nd->path))
-			break;
-		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
-			return ERR_PTR(-EXDEV);
 	}
+	/* rare case of legitimate dget_parent()... */
+	parent = dget_parent(nd->path.dentry);
+	if (unlikely(!path_connected(nd->path.mnt, parent))) {
+		dput(parent);
+		return ERR_PTR(-ENOENT);
+	}
+	*seqp = 0;
+	*inodep = parent->d_inode;
+	return parent;
+
+in_root:
 	if (unlikely(nd->flags & LOOKUP_BENEATH))
 		return ERR_PTR(-EXDEV);
 	dget(nd->path.dentry);
-- 
2.11.0

