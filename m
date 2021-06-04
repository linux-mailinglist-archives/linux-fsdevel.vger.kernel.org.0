Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF86039BCBE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 18:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhFDQON convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 4 Jun 2021 12:14:13 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:33335 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhFDQOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:14:12 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-xGoyTos_OVKeYCaxchsOVA-1; Fri, 04 Jun 2021 12:12:22 -0400
X-MC-Unique: xGoyTos_OVKeYCaxchsOVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D8F6107ACC7;
        Fri,  4 Jun 2021 16:12:21 +0000 (UTC)
Received: from bahia.lan (ovpn-112-232.ams2.redhat.com [10.36.112.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 969291B5B7;
        Fri,  4 Jun 2021 16:12:17 +0000 (UTC)
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, Max Reitz <mreitz@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Vivek Goyal <vgoyal@redhat.com>, Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 5/7] fuse: Call vfs_get_tree() for submounts
Date:   Fri,  4 Jun 2021 18:11:54 +0200
Message-Id: <20210604161156.408496-6-groug@kaod.org>
In-Reply-To: <20210604161156.408496-1-groug@kaod.org>
References: <20210604161156.408496-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We recently fixed an infinite loop by setting the SB_BORN flag on
submounts along with the write barrier needed by super_cache_count().
This is the job of vfs_get_tree() and FUSE shouldn't have to care
about the barrier at all.

Split out some code from fuse_dentry_automount() to the dedicated
fuse_get_tree_submount() handler for submounts and call vfs_get_tree().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fs/fuse/dir.c   | 53 +++++--------------------------------------------
 fs/fuse/inode.c | 36 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 48 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 3fa8604c21d5..b88e5785a3dd 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -309,12 +309,8 @@ static int fuse_dentry_delete(const struct dentry *dentry)
 static struct vfsmount *fuse_dentry_automount(struct path *path)
 {
 	struct fs_context *fsc;
-	struct fuse_mount *parent_fm = get_fuse_mount_super(path->mnt->mnt_sb);
-	struct fuse_conn *fc = parent_fm->fc;
-	struct fuse_mount *fm;
 	struct vfsmount *mnt;
 	struct fuse_inode *mp_fi = get_fuse_inode(d_inode(path->dentry));
-	struct super_block *sb;
 	int err;
 
 	fsc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry);
@@ -323,48 +319,15 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 		goto out;
 	}
 
-	err = -ENOMEM;
-	fm = kzalloc(sizeof(struct fuse_mount), GFP_KERNEL);
-	if (!fm)
-		goto out_put_fsc;
+	/* Pass the FUSE inode of the mount for fuse_get_tree_submount() */
+	fsc->fs_private = mp_fi;
 
-	fsc->s_fs_info = fm;
-	sb = sget_fc(fsc, NULL, set_anon_super_fc);
-	if (IS_ERR(sb)) {
-		err = PTR_ERR(sb);
-		kfree(fm);
+	err = vfs_get_tree(fsc);
+	if (err)
 		goto out_put_fsc;
-	}
-	fm->fc = fuse_conn_get(fc);
-
-	/* Initialize superblock, making @mp_fi its root */
-	err = fuse_fill_super_submount(sb, mp_fi);
-	if (err) {
-		fuse_conn_put(fc);
-		kfree(fm);
-		sb->s_fs_info = NULL;
-		goto out_put_sb;
-	}
-
-	down_write(&fc->killsb);
-	list_add_tail(&fm->fc_entry, &fc->mounts);
-	up_write(&fc->killsb);
-
-	sb->s_flags |= SB_ACTIVE;
-	fsc->root = dget(sb->s_root);
-
-	/*
-	 * FIXME: setting SB_BORN requires a write barrier for
-	 *        super_cache_count(). We should actually come
-	 *        up with a proper ->get_tree() implementation
-	 *        for submounts and call vfs_get_tree() to take
-	 *        care of the write barrier.
-	 */
-	smp_wmb();
-	sb->s_flags |= SB_BORN;
 
 	/* We are done configuring the superblock, so unlock it */
-	up_write(&sb->s_umount);
+	up_write(&fsc->root->d_sb->s_umount);
 
 	/* Create the submount */
 	mnt = vfs_create_mount(fsc);
@@ -376,12 +339,6 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
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
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fa96a3762ea2..bec1676811d4 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1313,8 +1313,44 @@ int fuse_fill_super_submount(struct super_block *sb,
 	return 0;
 }
 
+/* Filesystem context private data holds the FUSE inode of the mount point */
 static int fuse_get_tree_submount(struct fs_context *fsc)
 {
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
+		kfree(fm);
+		sb->s_fs_info = NULL;
+		deactivate_locked_super(sb);
+		return err;
+	}
+
+	down_write(&fc->killsb);
+	list_add_tail(&fm->fc_entry, &fc->mounts);
+	up_write(&fc->killsb);
+
+	sb->s_flags |= SB_ACTIVE;
+	fsc->root = dget(sb->s_root);
+
 	return 0;
 }
 
-- 
2.31.1

