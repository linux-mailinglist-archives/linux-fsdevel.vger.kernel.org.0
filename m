Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDC638B384
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbhETPsk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 11:48:40 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:30205 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232575AbhETPsh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 11:48:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-3MzFbQv4MyK5fa_1GMvdAw-1; Thu, 20 May 2021 11:47:11 -0400
X-MC-Unique: 3MzFbQv4MyK5fa_1GMvdAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91082107ACE4;
        Thu, 20 May 2021 15:47:09 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-99.ams2.redhat.com [10.36.112.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C710810013C1;
        Thu, 20 May 2021 15:47:07 +0000 (UTC)
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Greg Kurz <groug@kaod.org>
Subject: [PATCH v4 2/5] fuse: Call vfs_get_tree() for submounts
Date:   Thu, 20 May 2021 17:46:51 +0200
Message-Id: <20210520154654.1791183-3-groug@kaod.org>
In-Reply-To: <20210520154654.1791183-1-groug@kaod.org>
References: <20210520154654.1791183-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't set the SB_BORN flag on submounts superblocks. This is wrong
as these superblocks are then considered as partially constructed or
dying in the rest of the code and can break some assumptions.

One such case is when you have a virtiofs filesystem and you try to
mount it again : virtio_fs_get_tree() tries to obtain a superblock
with sget_fc(). The matching criteria in virtio_fs_test_super() is
the pointer of the underlying virtiofs device, which is shared by
the root mount and its submounts. This means that any submount can
be picked up instead of the root mount. This is itself a bug :
submounts should be ignored in this case. But, most importantly, it
then triggers an infinite loop in sget_fc() because it fails to grab
the superblock (very easy to reproduce).

The only viable solution is to set SB_BORN at some point. This
must be done with vfs_get_tree() because setting SB_BORN requires
special care, i.e. a memory barrier for super_cache_count() which
can check SB_BORN without taking any lock.

This requires to split out some code from fuse_dentry_automount() to
a new dedicated fuse_get_tree_submount().

The fs_private field of the filesystem context isn't used with
submounts : hijack it to pass the FUSE inode of the mount point
down to fuse_get_tree_submount().

Finally, adapt virtiofs to use this.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fs/fuse/dir.c       | 48 +++++++++++----------------------------------
 fs/fuse/fuse_i.h    |  6 ++++++
 fs/fuse/inode.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 fs/fuse/virtio_fs.c |  3 +++
 4 files changed, 63 insertions(+), 37 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index fb2af70596c3..4c8dafe4f69e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -309,12 +309,9 @@ static int fuse_dentry_delete(const struct dentry *dentry)
 static struct vfsmount *fuse_dentry_automount(struct path *path)
 {
 	struct fs_context *fsc;
-	struct fuse_mount *parent_fm = get_fuse_mount_super(path->mnt->mnt_sb);
-	struct fuse_conn *fc = parent_fm->fc;
 	struct fuse_mount *fm;
 	struct vfsmount *mnt;
 	struct fuse_inode *mp_fi = get_fuse_inode(d_inode(path->dentry));
-	struct super_block *sb;
 	int err;
 
 	fsc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry);
@@ -323,36 +320,19 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 		goto out;
 	}
 
-	err = -ENOMEM;
-	fm = kzalloc(sizeof(struct fuse_mount), GFP_KERNEL);
-	if (!fm)
+	/*
+	 * Hijack fsc->fs_private to pass the mount point inode to
+	 * fuse_get_tree_submount(). It *must* be NULLified afterwards
+	 * to avoid the inode pointer to be passed to kfree() when
+	 * the context gets freed.
+	 */
+	fsc->fs_private = mp_fi;
+	err = vfs_get_tree(fsc);
+	fsc->fs_private = NULL;
+	if (err)
 		goto out_put_fsc;
 
-	fsc->s_fs_info = fm;
-	sb = sget_fc(fsc, NULL, set_anon_super_fc);
-	if (IS_ERR(sb)) {
-		err = PTR_ERR(sb);
-		kfree(fm);
-		goto out_put_fsc;
-	}
-	fm->fc = fuse_conn_get(fc);
-
-	/* Initialize superblock, making @mp_fi its root */
-	err = fuse_fill_super_submount(sb, mp_fi);
-	if (err) {
-		fuse_conn_put(fc);
-		kfree(fm);
-		goto out_put_sb;
-	}
-
-	sb->s_flags |= SB_ACTIVE;
-	fsc->root = dget(sb->s_root);
-	/* We are done configuring the superblock, so unlock it */
-	up_write(&sb->s_umount);
-
-	down_write(&fc->killsb);
-	list_add_tail(&fm->fc_entry, &fc->mounts);
-	up_write(&fc->killsb);
+	fm = get_fuse_mount_super(fsc->root->d_sb);
 
 	/* Create the submount */
 	mnt = vfs_create_mount(fsc);
@@ -364,12 +344,6 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 	put_fs_context(fsc);
 	return mnt;
 
-out_put_sb:
-	/*
-	 * Only jump here when fsc->root is NULL and sb is still locked
-	 * (otherwise put_fs_context() will put the superblock)
-	 */
-	deactivate_locked_super(sb);
 out_put_fsc:
 	put_fs_context(fsc);
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7e463e220053..d7fcf59a6a0e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1090,6 +1090,12 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx);
 int fuse_fill_super_submount(struct super_block *sb,
 			     struct fuse_inode *parent_fi);
 
+/*
+ * Get the mountable root for the submount
+ * @fsc: superblock configuration context
+ */
+int fuse_get_tree_submount(struct fs_context *fsc);
+
 /*
  * Remove the mount from the connection
  *
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 393e36b74dc4..74e5205f203c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1313,6 +1313,49 @@ int fuse_fill_super_submount(struct super_block *sb,
 	return 0;
 }
 
+/* Filesystem context private data holds the FUSE inode of the mount point */
+int fuse_get_tree_submount(struct fs_context *fsc)
+{
+	struct fuse_mount *fm;
+	struct fuse_inode *mp_fi = fsc->fs_private;
+	struct fuse_conn *fc = get_fuse_conn(&mp_fi->inode);
+	struct super_block *sb;
+	int err;
+
+	fm = kzalloc(sizeof(struct fuse_mount), GFP_KERNEL);
+	if (!fm)
+		return -ENOMEM;
+
+	fsc->s_fs_info = fm;
+	sb = sget_fc(fsc, NULL, set_anon_super_fc);
+	if (IS_ERR(sb)) {
+		kfree(fm);
+		return PTR_ERR(sb);
+	}
+	fm->fc = fuse_conn_get(fc);
+
+	/* Initialize superblock, making @mp_fi its root */
+	err = fuse_fill_super_submount(sb, mp_fi);
+	if (err) {
+		fuse_conn_put(fc);
+		deactivate_locked_super(sb);
+		kfree(fm);
+		return err;
+	}
+
+	sb->s_flags |= SB_ACTIVE;
+	fsc->root = dget(sb->s_root);
+	/* We are done configuring the superblock, so unlock it */
+	up_write(&sb->s_umount);
+
+	down_write(&fc->killsb);
+	list_add_tail(&fm->fc_entry, &fc->mounts);
+	up_write(&fc->killsb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fuse_get_tree_submount);
+
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 {
 	struct fuse_dev *fud = NULL;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index bcb8a02e2d8b..e12e5190352c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1420,6 +1420,9 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	unsigned int virtqueue_size;
 	int err = -EIO;
 
+	if (fsc->purpose == FS_CONTEXT_FOR_SUBMOUNT)
+		return fuse_get_tree_submount(fsc);
+
 	/* This gets a reference on virtio_fs object. This ptr gets installed
 	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
 	 * to drop the reference to this object.
-- 
2.26.3

