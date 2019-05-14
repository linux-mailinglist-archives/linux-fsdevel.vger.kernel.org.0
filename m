Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3A71E4FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 00:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfENWU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 18:20:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44908 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfENWTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 18:19:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id c5so426835wrs.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2BwTP2UXR2wpUVBza+34moJhMmiADl3xE9wV3LEwbVE=;
        b=GB8EgYcimUxTgqpYS4QKdpfWWv4UnIHa+X8vqhBrejIO4deeFR3ao75oZYwu10KLlu
         JN2t9+fHr8taE2J41tGDUm1RwxpGwpICdXbHWXY05h1otzNN5LoIBmbd+IH0IhQXJXlA
         VGuAYpCq6yk7UxF62i1RCezny+mJVonZwBwxYJ33gP2x4wbvdAPM63wjguMkD+OGa90b
         SCWu9lozXUc8j8JeVEcPHWW3d13oFxeSy6uwd+kZdaPZDIM9CR+XvpAEqip6Wg2sVdvi
         hNOz0xd0kieVzvW0e+BVcjmGPa2drq2tsW3PDu9xAwIiXoPO4MI1nuXt2hObLn/qs1tL
         omDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2BwTP2UXR2wpUVBza+34moJhMmiADl3xE9wV3LEwbVE=;
        b=sj2RrXi2Db5ZEpy/6KlAIh5uQ24IQjve4a862k+OeSr70F+Ne5q1FaIFyqMLdBafrY
         79vfXilO3Bh/dOUt8cwG2ibLAKkg04ANvwsuEE/Z8vlg2nsCVN0b7+bIyx5l4waw2FvM
         XEMJpHD24iXcIGEQmJj7kZ+5uFzc4JMX2VMM/fkQh5UJ6nYmsPEVR4EL/cQQ3DDvvMgh
         4KDvypI2piSj95vSXZAZOXCz2I1S84fRt3SYJQ/XwNGJREHPqhN446G5XJp6lg2yzYRq
         0n8CeavKbwkZ/8grMmYMBY1T/x5hgCxHxYOIujiLPqOLgFaRFQyS/NFpY9cTJwPtD1vM
         8o8A==
X-Gm-Message-State: APjAAAWJ8U67xReWFN4b2ogxRF8J5a/2ULS7mkNw3KYUjIBxiDEAsjck
        Bnp4phRfZFqaKoSjx4fQ3IQ=
X-Google-Smtp-Source: APXvYqwwL/Yck7SUL+/HsNbdrc2XxxtGcquj9fMy+bHGaOmwxiJmAgJi1XjM481f/V6vtNCxJ/ROiA==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr12688862wrt.197.1557872356154;
        Tue, 14 May 2019 15:19:16 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id h188sm423553wmf.48.2019.05.14.15.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 15:19:15 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 4/4] fsnotify: move fsnotify_nameremove() hook out of d_delete()
Date:   Wed, 15 May 2019 01:19:01 +0300
Message-Id: <20190514221901.29125-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514221901.29125-1-amir73il@gmail.com>
References: <20190514221901.29125-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

d_delete() was piggy backed for the fsnotify_nameremove() hook when
in fact not all callers of d_delete() care about fsnotify events.

For all callers of d_delete() that may be interested in fsnotify
events, we made sure that parent dir and d_name are stable and
we call the fsnotify_remove() hook before calling d_delete().
Because of that, fsnotify_remove() does not need the safety measures
that were in fsnotify_nameremove() to stabilize parent and name.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/afs/dir_silly.c               |  5 ----
 fs/btrfs/ioctl.c                 |  4 +++-
 fs/configfs/dir.c                |  3 +++
 fs/dcache.c                      |  2 --
 fs/devpts/inode.c                |  1 +
 fs/nfs/unlink.c                  |  6 -----
 fs/notify/fsnotify.c             | 41 --------------------------------
 include/linux/fsnotify.h         |  7 +++++-
 include/linux/fsnotify_backend.h |  4 ----
 9 files changed, 13 insertions(+), 60 deletions(-)

diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index f6f89fdab6b2..d3494825d08a 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -57,11 +57,6 @@ static int afs_do_silly_rename(struct afs_vnode *dvnode, struct afs_vnode *vnode
 		if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
 			afs_edit_dir_add(dvnode, &new->d_name,
 					 &vnode->fid, afs_edit_dir_for_silly_1);
-
-		/* vfs_unlink and the like do not issue this when a file is
-		 * sillyrenamed, so do it here.
-		 */
-		fsnotify_nameremove(old, 0);
 	}
 
 	_leave(" = %d", ret);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6dafa857bbb9..cd76e705d401 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2930,8 +2930,10 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	inode_lock(inode);
 	err = btrfs_delete_subvolume(dir, dentry);
 	inode_unlock(inode);
-	if (!err)
+	if (!err) {
+		fsnotify_remove(dir, dentry);
 		d_delete(dentry);
+	}
 
 out_dput:
 	dput(dentry);
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 591e82ba443c..78566002234a 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -27,6 +27,7 @@
 #undef DEBUG
 
 #include <linux/fs.h>
+#include <linux/fsnotify.h>
 #include <linux/mount.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -1797,6 +1798,7 @@ void configfs_unregister_group(struct config_group *group)
 	configfs_detach_group(&group->cg_item);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
+	fsnotify_remove(d_inode(parent), dentry);
 	d_delete(dentry);
 	inode_unlock(d_inode(parent));
 
@@ -1925,6 +1927,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	configfs_detach_group(&group->cg_item);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
+	fsnotify_remove(d_inode(root), dentry);
 	inode_unlock(d_inode(dentry));
 
 	d_delete(dentry);
diff --git a/fs/dcache.c b/fs/dcache.c
index 8136bda27a1f..ce131339410c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2371,7 +2371,6 @@ EXPORT_SYMBOL(d_hash_and_lookup);
 void d_delete(struct dentry * dentry)
 {
 	struct inode *inode = dentry->d_inode;
-	int isdir = d_is_dir(dentry);
 
 	spin_lock(&inode->i_lock);
 	spin_lock(&dentry->d_lock);
@@ -2386,7 +2385,6 @@ void d_delete(struct dentry * dentry)
 		spin_unlock(&dentry->d_lock);
 		spin_unlock(&inode->i_lock);
 	}
-	fsnotify_nameremove(dentry, isdir);
 }
 EXPORT_SYMBOL(d_delete);
 
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 553a3f3300ae..aea8dda154e2 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -624,6 +624,7 @@ void devpts_pty_kill(struct dentry *dentry)
 
 	dentry->d_fsdata = NULL;
 	drop_nlink(dentry->d_inode);
+	fsnotify_remove(d_inode(dentry->d_parent), dentry);
 	d_delete(dentry);
 	dput(dentry);	/* d_alloc_name() in devpts_pty_new() */
 }
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 52d533967485..0effeee28352 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -396,12 +396,6 @@ nfs_complete_sillyrename(struct rpc_task *task, struct nfs_renamedata *data)
 		nfs_cancel_async_unlink(dentry);
 		return;
 	}
-
-	/*
-	 * vfs_unlink and the like do not issue this when a file is
-	 * sillyrenamed, so do it here.
-	 */
-	fsnotify_nameremove(dentry, 0);
 }
 
 #define SILLYNAME_PREFIX ".nfs"
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 8c7cbac7183c..5433e37fb0c5 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -107,47 +107,6 @@ void fsnotify_sb_delete(struct super_block *sb)
 	fsnotify_clear_marks_by_sb(sb);
 }
 
-/*
- * fsnotify_nameremove - a filename was removed from a directory
- *
- * This is mostly called under parent vfs inode lock so name and
- * dentry->d_parent should be stable. However there are some corner cases where
- * inode lock is not held. So to be on the safe side and be reselient to future
- * callers and out of tree users of d_delete(), we do not assume that d_parent
- * and d_name are stable and we use dget_parent() and
- * take_dentry_name_snapshot() to grab stable references.
- */
-void fsnotify_nameremove(struct dentry *dentry, int isdir)
-{
-	struct dentry *parent;
-	struct name_snapshot name;
-	__u32 mask = FS_DELETE;
-
-	/* d_delete() of pseudo inode? (e.g. __ns_get_path() playing tricks) */
-	if (IS_ROOT(dentry))
-		return;
-
-	if (isdir)
-		mask |= FS_ISDIR;
-
-	parent = dget_parent(dentry);
-	/* Avoid unneeded take_dentry_name_snapshot() */
-	if (!(d_inode(parent)->i_fsnotify_mask & FS_DELETE) &&
-	    !(dentry->d_sb->s_fsnotify_mask & FS_DELETE))
-		goto out_dput;
-
-	take_dentry_name_snapshot(&name, dentry);
-
-	fsnotify(d_inode(parent), mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
-		 &name.name, 0);
-
-	release_dentry_name_snapshot(&name);
-
-out_dput:
-	dput(parent);
-}
-EXPORT_SYMBOL(fsnotify_nameremove);
-
 /*
  * Given an inode, first check if we care what happens to our children.  Inotify
  * and dnotify both tell their parents about events.  If we care about any event
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 455dff82595e..7f68cb9825dd 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -158,10 +158,15 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
  */
 static inline void fsnotify_remove(struct inode *dir, struct dentry *dentry)
 {
+	__u32 mask = FS_DELETE;
+
 	/* Expected to be called before d_delete() */
 	WARN_ON_ONCE(d_is_negative(dentry));
 
-	/* TODO: call fsnotify_dirent() */
+	if (d_is_dir(dentry))
+		mask |= FS_ISDIR;
+
+	fsnotify_dirent(dir, dentry, mask);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a9f9dcc1e515..c28f6ed1f59b 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -355,7 +355,6 @@ extern int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u
 extern void __fsnotify_inode_delete(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
-extern void fsnotify_nameremove(struct dentry *dentry, int isdir);
 extern u32 fsnotify_get_cookie(void);
 
 static inline int fsnotify_inode_watches_children(struct inode *inode)
@@ -525,9 +524,6 @@ static inline void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 static inline void fsnotify_sb_delete(struct super_block *sb)
 {}
 
-static inline void fsnotify_nameremove(struct dentry *dentry, int isdir)
-{}
-
 static inline void fsnotify_update_flags(struct dentry *dentry)
 {}
 
-- 
2.17.1

