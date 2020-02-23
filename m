Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C27616929A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgBWBRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:17:54 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50104 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgBWBRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:17:54 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5ftk-00HDb5-Fh; Sun, 23 Feb 2020 01:17:40 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 06/34] handle_mounts(): start building a sane wrapper for follow_managed()
Date:   Sun, 23 Feb 2020 01:15:58 +0000
Message-Id: <20200223011626.4103706-6-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

All callers of follow_managed() follow it on success with the same steps -
d_backing_inode(path->dentry) is calculated and stored into some struct inode *
variable and, in all but one case, an unsigned variable (nd->seq to be) is
zeroed.  The single exception is lookup_fast() and there zeroing is correct
thing to do - not doing it is a pointless microoptimization.

	Add a wrapper for follow_managed() that would do that combination.
It's mostly a vehicle for code massage - it will be changing quite a bit,
and the current calling conventions are by no means final.  Right now it
takes path, nameidata and (as out params) inode and seq, similar to
__follow_mount_rcu().  Which will soon get folded into it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6938d20aa73a..c104ec75faef 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1385,6 +1385,18 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 		!(path->dentry->d_flags & DCACHE_NEED_AUTOMOUNT);
 }
 
+static inline int handle_mounts(struct path *path, struct nameidata *nd,
+			  struct inode **inode, unsigned int *seqp)
+{
+	int ret = follow_managed(path, nd);
+
+	if (likely(ret >= 0)) {
+		*inode = d_backing_inode(path->dentry);
+		*seqp = 0; /* out of RCU mode, so the value doesn't matter */
+	}
+	return ret;
+}
+
 static int follow_dotdot_rcu(struct nameidata *nd)
 {
 	struct inode *inode = nd->inode;
@@ -1607,7 +1619,6 @@ static int lookup_fast(struct nameidata *nd,
 	struct vfsmount *mnt = nd->path.mnt;
 	struct dentry *dentry, *parent = nd->path.dentry;
 	int status = 1;
-	int err;
 
 	/*
 	 * Rename seqlock is not required here because in the off chance
@@ -1677,10 +1688,7 @@ static int lookup_fast(struct nameidata *nd,
 
 	path->mnt = mnt;
 	path->dentry = dentry;
-	err = follow_managed(path, nd);
-	if (likely(err > 0))
-		*inode = d_backing_inode(path->dentry);
-	return err;
+	return handle_mounts(path, nd, inode, seqp);
 }
 
 /* Fast lookup failed, do it the slow way */
@@ -1875,12 +1883,9 @@ static int walk_component(struct nameidata *nd, int flags)
 			return PTR_ERR(path.dentry);
 
 		path.mnt = nd->path.mnt;
-		err = follow_managed(&path, nd);
+		err = handle_mounts(&path, nd, &inode, &seq);
 		if (unlikely(err < 0))
 			return err;
-
-		seq = 0;	/* we are already out of RCU mode */
-		inode = d_backing_inode(path.dentry);
 	}
 
 	return step_into(nd, &path, flags, inode, seq);
@@ -2365,11 +2370,9 @@ static int handle_lookup_down(struct nameidata *nd)
 			return -ECHILD;
 	} else {
 		dget(path.dentry);
-		err = follow_managed(&path, nd);
+		err = handle_mounts(&path, nd, &inode, &seq);
 		if (unlikely(err < 0))
 			return err;
-		inode = d_backing_inode(path.dentry);
-		seq = 0;
 	}
 	path_to_nameidata(&path, nd);
 	nd->inode = inode;
@@ -3392,12 +3395,9 @@ static int do_last(struct nameidata *nd,
 		got_write = false;
 	}
 
-	error = follow_managed(&path, nd);
+	error = handle_mounts(&path, nd, &inode, &seq);
 	if (unlikely(error < 0))
 		return error;
-
-	seq = 0;	/* out of RCU mode, so the value doesn't matter */
-	inode = d_backing_inode(path.dentry);
 finish_lookup:
 	error = step_into(nd, &path, 0, inode, seq);
 	if (unlikely(error))
-- 
2.11.0

