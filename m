Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F75C98182
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfHURit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:38:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729999AbfHURiV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:38:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D6408D5BAB;
        Wed, 21 Aug 2019 17:38:21 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8D995C21A;
        Wed, 21 Aug 2019 17:38:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C4CD8223D04; Wed, 21 Aug 2019 13:38:14 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, stefanha@redhat.com,
        dgilbert@redhat.com, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 08/13] fuse: extract fuse_fill_super_common()
Date:   Wed, 21 Aug 2019 13:37:37 -0400
Message-Id: <20190821173742.24574-9-vgoyal@redhat.com>
In-Reply-To: <20190821173742.24574-1-vgoyal@redhat.com>
References: <20190821173742.24574-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Wed, 21 Aug 2019 17:38:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

fuse_fill_super() includes code to process the fd= option and link the
struct fuse_dev to the fd's struct file.  In virtio-fs there is no file
descriptor because /dev/fuse is not used.

This patch extracts fuse_fill_super_common() so that both classic fuse
and virtio-fs can share the code to initialize a mount.

parse_fuse_opt() is also extracted so that the fuse_fill_super_common()
caller has access to the mount options.  This allows classic fuse to
handle the fd= option outside fuse_fill_super_common().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h |  33 ++++++++++++
 fs/fuse/inode.c  | 137 ++++++++++++++++++++++++-----------------------
 2 files changed, 103 insertions(+), 67 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d4b27f048d81..062f929348cc 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -60,6 +60,25 @@ extern struct mutex fuse_mutex;
 extern unsigned max_user_bgreq;
 extern unsigned max_user_congthresh;
 
+/** Mount options */
+struct fuse_mount_data {
+	int fd;
+	unsigned rootmode;
+	kuid_t user_id;
+	kgid_t group_id;
+	unsigned fd_present:1;
+	unsigned rootmode_present:1;
+	unsigned user_id_present:1;
+	unsigned group_id_present:1;
+	unsigned default_permissions:1;
+	unsigned allow_other:1;
+	unsigned max_read;
+	unsigned blksize;
+
+	/* fuse_dev pointer to fill in, should contain NULL on entry */
+	void **fudptr;
+};
+
 /* One forget request */
 struct fuse_forget_link {
 	struct fuse_forget_one forget_one;
@@ -999,6 +1018,20 @@ struct fuse_dev *fuse_dev_alloc(struct fuse_conn *fc);
 void fuse_dev_free(struct fuse_dev *fud);
 void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req);
 
+/**
+ * Parse a mount options string
+ */
+int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
+				struct user_namespace *user_ns);
+
+/**
+ * Fill in superblock and initialize fuse connection
+ * @sb: partially-initialized superblock to fill in
+ * @mount_data: mount parameters
+ */
+int fuse_fill_super_common(struct super_block *sb,
+			   struct fuse_mount_data *mount_data);
+
 /**
  * Add connection to control filesystem
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 14a4e915294c..9f21a0cb58b9 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -59,21 +59,6 @@ MODULE_PARM_DESC(max_user_congthresh,
 /** Congestion starts at 75% of maximum */
 #define FUSE_DEFAULT_CONGESTION_THRESHOLD (FUSE_DEFAULT_MAX_BACKGROUND * 3 / 4)
 
-struct fuse_mount_data {
-	int fd;
-	unsigned rootmode;
-	kuid_t user_id;
-	kgid_t group_id;
-	unsigned fd_present:1;
-	unsigned rootmode_present:1;
-	unsigned user_id_present:1;
-	unsigned group_id_present:1;
-	unsigned default_permissions:1;
-	unsigned allow_other:1;
-	unsigned max_read;
-	unsigned blksize;
-};
-
 struct fuse_forget_link *fuse_alloc_forget(void)
 {
 	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL);
@@ -477,7 +462,7 @@ static int fuse_match_uint(substring_t *s, unsigned int *res)
 	return err;
 }
 
-static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
+int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
 			  struct user_namespace *user_ns)
 {
 	char *p;
@@ -554,12 +539,13 @@ static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
 		}
 	}
 
-	if (!d->fd_present || !d->rootmode_present ||
-	    !d->user_id_present || !d->group_id_present)
+	if (!d->rootmode_present || !d->user_id_present ||
+	    !d->group_id_present)
 		return 0;
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(parse_fuse_opt);
 
 static int fuse_show_options(struct seq_file *m, struct dentry *root)
 {
@@ -1076,15 +1062,13 @@ void fuse_dev_free(struct fuse_dev *fud)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_free);
 
-static int fuse_fill_super(struct super_block *sb, void *data, int silent)
+int fuse_fill_super_common(struct super_block *sb,
+			   struct fuse_mount_data *mount_data)
 {
 	struct fuse_dev *fud;
 	struct fuse_conn *fc;
 	struct inode *root;
-	struct fuse_mount_data d;
-	struct file *file;
 	struct dentry *root_dentry;
-	struct fuse_req *init_req;
 	int err;
 	int is_bdev = sb->s_bdev != NULL;
 
@@ -1094,13 +1078,10 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
 
-	if (!parse_fuse_opt(data, &d, is_bdev, sb->s_user_ns))
-		goto err;
-
 	if (is_bdev) {
 #ifdef CONFIG_BLOCK
 		err = -EINVAL;
-		if (!sb_set_blocksize(sb, d.blksize))
+		if (!sb_set_blocksize(sb, mount_data->blksize))
 			goto err;
 #endif
 	} else {
@@ -1117,19 +1098,6 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 
-	file = fget(d.fd);
-	err = -EINVAL;
-	if (!file)
-		goto err;
-
-	/*
-	 * Require mount to happen from the same user namespace which
-	 * opened /dev/fuse to prevent potential attacks.
-	 */
-	if (file->f_op != &fuse_dev_operations ||
-	    file->f_cred->user_ns != sb->s_user_ns)
-		goto err_fput;
-
 	/*
 	 * If we are not in the initial user namespace posix
 	 * acls must be translated.
@@ -1140,7 +1108,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
 	err = -ENOMEM;
 	if (!fc)
-		goto err_fput;
+		goto err;
 
 	fuse_conn_init(fc, sb->s_user_ns);
 	fc->release = fuse_free_conn;
@@ -1160,17 +1128,17 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 		fc->dont_mask = 1;
 	sb->s_flags |= SB_POSIXACL;
 
-	fc->default_permissions = d.default_permissions;
-	fc->allow_other = d.allow_other;
-	fc->user_id = d.user_id;
-	fc->group_id = d.group_id;
-	fc->max_read = max_t(unsigned, 4096, d.max_read);
+	fc->default_permissions = mount_data->default_permissions;
+	fc->allow_other = mount_data->allow_other;
+	fc->user_id = mount_data->user_id;
+	fc->group_id = mount_data->group_id;
+	fc->max_read = max_t(unsigned, 4096, mount_data->max_read);
 
 	/* Used by get_root_inode() */
 	sb->s_fs_info = fc;
 
 	err = -ENOMEM;
-	root = fuse_get_root_inode(sb, d.rootmode);
+	root = fuse_get_root_inode(sb, mount_data->rootmode);
 	sb->s_d_op = &fuse_root_dentry_operations;
 	root_dentry = d_make_root(root);
 	if (!root_dentry)
@@ -1178,20 +1146,15 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	/* Root dentry doesn't have .d_revalidate */
 	sb->s_d_op = &fuse_dentry_operations;
 
-	init_req = fuse_request_alloc(0);
-	if (!init_req)
-		goto err_put_root;
-	__set_bit(FR_BACKGROUND, &init_req->flags);
-
 	if (is_bdev) {
 		fc->destroy_req = fuse_request_alloc(0);
 		if (!fc->destroy_req)
-			goto err_free_init_req;
+			goto err_put_root;
 	}
 
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
-	if (file->private_data)
+	if (*mount_data->fudptr)
 		goto err_unlock;
 
 	err = fuse_ctl_add_conn(fc);
@@ -1200,23 +1163,12 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
-	file->private_data = fud;
+	*mount_data->fudptr = fud;
 	mutex_unlock(&fuse_mutex);
-	/*
-	 * atomic_dec_and_test() in fput() provides the necessary
-	 * memory barrier for file->private_data to be visible on all
-	 * CPUs after this
-	 */
-	fput(file);
-
-	fuse_send_init(fc, init_req);
-
 	return 0;
 
  err_unlock:
 	mutex_unlock(&fuse_mutex);
- err_free_init_req:
-	fuse_request_free(init_req);
  err_put_root:
 	dput(root_dentry);
  err_dev_free:
@@ -1224,11 +1176,62 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
  err_put_conn:
 	fuse_conn_put(fc);
 	sb->s_fs_info = NULL;
- err_fput:
-	fput(file);
  err:
 	return err;
 }
+EXPORT_SYMBOL_GPL(fuse_fill_super_common);
+
+static int fuse_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct fuse_mount_data d;
+	struct file *file;
+	int is_bdev = sb->s_bdev != NULL;
+	int err;
+	struct fuse_req *init_req;
+
+	err = -EINVAL;
+	if (!parse_fuse_opt(data, &d, is_bdev, sb->s_user_ns))
+		goto err;
+	if (!d.fd_present)
+		goto err;
+
+	file = fget(d.fd);
+	if (!file)
+		goto err;
+
+	/*
+	 * Require mount to happen from the same user namespace which
+	 * opened /dev/fuse to prevent potential attacks.
+	 */
+	if ((file->f_op != &fuse_dev_operations) ||
+	    (file->f_cred->user_ns != sb->s_user_ns))
+		goto err_fput;
+
+	init_req = fuse_request_alloc(0);
+	if (!init_req)
+		goto err_fput;
+	__set_bit(FR_BACKGROUND, &init_req->flags);
+
+	d.fudptr = &file->private_data;
+	err = fuse_fill_super_common(sb, &d);
+	if (err < 0)
+		goto err_free_init_req;
+	/*
+	 * atomic_dec_and_test() in fput() provides the necessary
+	 * memory barrier for file->private_data to be visible on all
+	 * CPUs after this
+	 */
+	fput(file);
+	fuse_send_init(get_fuse_conn_super(sb), init_req);
+	return 0;
+
+err_free_init_req:
+	fuse_request_free(init_req);
+err_fput:
+	fput(file);
+err:
+	return err;
+}
 
 static struct dentry *fuse_mount(struct file_system_type *fs_type,
 		       int flags, const char *dev_name,
-- 
2.20.1

