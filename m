Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19CE0141BB3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgASD0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:26:18 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57032 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgASD0R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:26:17 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it1Dg-00BFmW-4K; Sun, 19 Jan 2020 03:25:51 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 8/9] massage __follow_mount_rcu() a bit
Date:   Sun, 19 Jan 2020 03:17:37 +0000
Message-Id: <20200119031738.2681033-25-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
References: <20200119031423.GV8904@ZenIV.linux.org.uk>
 <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

make the loop more similar to that in follow_managed(), with
explicit tracking of flags, etc.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 70 +++++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 40263f89a54f..310c5ccddf42 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1268,12 +1268,6 @@ int follow_down_one(struct path *path)
 }
 EXPORT_SYMBOL(follow_down_one);
 
-static inline int managed_dentry_rcu(const struct path *path)
-{
-	return (path->dentry->d_flags & DCACHE_MANAGE_TRANSIT) ?
-		path->dentry->d_op->d_manage(path, true) : 0;
-}
-
 /*
  * Try to skip to top of mountpoint pile in rcuwalk mode.  Fail if
  * we meet a managed dentry that would need blocking.
@@ -1281,43 +1275,49 @@ static inline int managed_dentry_rcu(const struct path *path)
 static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 			       struct inode **inode, unsigned *seqp)
 {
+	struct dentry *dentry = path->dentry;
+	unsigned int flags = dentry->d_flags;
+
+	if (likely(!(flags & DCACHE_MANAGED_DENTRY)))
+		return true;
+
+	if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+		return false;
+
 	for (;;) {
-		struct mount *mounted;
 		/*
 		 * Don't forget we might have a non-mountpoint managed dentry
 		 * that wants to block transit.
 		 */
-		switch (managed_dentry_rcu(path)) {
-		case -ECHILD:
-		default:
-			return false;
-		case -EISDIR:
-			return true;
-		case 0:
-			break;
+		if (unlikely(flags & DCACHE_MANAGE_TRANSIT)) {
+			int res = dentry->d_op->d_manage(path, true);
+			if (res)
+				return res == -EISDIR;
+			flags = dentry->d_flags;
 		}
 
-		if (!d_mountpoint(path->dentry))
-			return !(path->dentry->d_flags & DCACHE_NEED_AUTOMOUNT);
-
-		mounted = __lookup_mnt(path->mnt, path->dentry);
-		if (!mounted)
-			break;
-		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
-			return false;
-		path->mnt = &mounted->mnt;
-		path->dentry = mounted->mnt.mnt_root;
-		nd->flags |= LOOKUP_JUMPED;
-		*seqp = read_seqcount_begin(&path->dentry->d_seq);
-		/*
-		 * Update the inode too. We don't need to re-check the
-		 * dentry sequence number here after this d_inode read,
-		 * because a mount-point is always pinned.
-		 */
-		*inode = path->dentry->d_inode;
+		if (flags & DCACHE_MOUNTED) {
+			struct mount *mounted = __lookup_mnt(path->mnt, dentry);
+			if (mounted) {
+				path->mnt = &mounted->mnt;
+				dentry = path->dentry = mounted->mnt.mnt_root;
+				nd->flags |= LOOKUP_JUMPED;
+				*seqp = read_seqcount_begin(&dentry->d_seq);
+				*inode = dentry->d_inode;
+				/*
+				 * We don't need to re-check ->d_seq after this
+				 * ->d_inode read - there will be an RCU delay
+				 * between mount hash removal and ->mnt_root
+				 * becoming unpinned.
+				 */
+				flags = dentry->d_flags;
+				continue;
+			}
+			if (read_seqretry(&mount_lock, nd->m_seq))
+				return false;
+		}
+		return !(flags & DCACHE_NEED_AUTOMOUNT);
 	}
-	return !read_seqretry(&mount_lock, nd->m_seq) &&
-		!(path->dentry->d_flags & DCACHE_NEED_AUTOMOUNT);
 }
 
 static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
-- 
2.20.1

