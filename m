Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31AA6A67B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfICLmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:42:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729062AbfICLmM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:12 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2ABBC049E36
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:11 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id x1so4985622wrn.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lj+i9hsWGMhzYGiBt3I8Vc577d4ACT6f/qOeoSl2HU=;
        b=tFpEgN2gw9w/Bi44S6KmluTfrEGLNct2D0Mi1xWfHOvaANwO7Gxw96GzmzcVvP5GB4
         HHiGJLlJe5gJ3fI4CrV3MpDhblpsCe+2JdRhHFZCGtoCAxyUfGo8LVRYoBPLxS4MQW7Q
         DTpaEPJRvTuscA0laNdCWaCs93/ZiZVdY5F3h/c55zPhegHQHUcSlyoFbUvRL4/kVCq0
         EA1PbWEpbz3JKwuKCE4aD7QFF4sENcwMNzMm8qEgAFtU/DDTBMEy76K6xtb9c9kdDdnw
         Ylj09w1FpNPzRLqGf9Ch6Wk24xiweZtE21TxKNi7SJ9hneIDCGqF3i8a5OnOt5JDxIrJ
         D2mQ==
X-Gm-Message-State: APjAAAXjyffz7j/UoEk45KCz1Qr9/aK0c03GXtfZSsp6GlJXztFGkODJ
        jOEi9SaT2609S++f9tHbk3hh9XmI8+/Q9gDlHP03uZxZ0QKEIT+XdHFu7Nl1nDKFKvOjSet91S7
        143E/hfppFlf8wNSmeNk57cPtZA==
X-Received: by 2002:a05:600c:20c2:: with SMTP id y2mr22978052wmm.68.1567510930102;
        Tue, 03 Sep 2019 04:42:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwGAAZu8McIJtNp1jZdMvhjDkySdFxErSMDbo6PHusWOwcFHWmbfdIRhH0PjpoofZrnzTGImA==
X-Received: by 2002:a05:600c:20c2:: with SMTP id y2mr22978026wmm.68.1567510929856;
        Tue, 03 Sep 2019 04:42:09 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:09 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 09/16] fuse: extract fuse_fill_super_common()
Date:   Tue,  3 Sep 2019 13:41:56 +0200
Message-Id: <20190903114203.8278-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

fuse_fill_super() includes code to process the fd= option and link the
struct fuse_dev to the fd's struct file.  In virtio-fs there is no file
descriptor because /dev/fuse is not used.

This patch extracts fuse_fill_super_common() so that both classic fuse and
virtio-fs can share the code to initialize a mount.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h |  27 ++++++++++
 fs/fuse/inode.c  | 133 +++++++++++++++++++++++------------------------
 2 files changed, 91 insertions(+), 69 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6533be37873f..d0c8f131fb5d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -504,6 +504,26 @@ struct fuse_dev {
 	struct list_head entry;
 };
 
+struct fuse_fs_context {
+	int fd;
+	unsigned int rootmode;
+	kuid_t user_id;
+	kgid_t group_id;
+	bool is_bdev:1;
+	bool fd_present:1;
+	bool rootmode_present:1;
+	bool user_id_present:1;
+	bool group_id_present:1;
+	bool default_permissions:1;
+	bool allow_other:1;
+	unsigned int max_read;
+	unsigned int blksize;
+	const char *subtype;
+
+	/* fuse_dev pointer to fill in, should contain NULL on entry */
+	void **fudptr;
+};
+
 /**
  * A Fuse connection.
  *
@@ -1000,6 +1020,13 @@ struct fuse_dev *fuse_dev_alloc(struct fuse_conn *fc);
 void fuse_dev_free(struct fuse_dev *fud);
 void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req);
 
+/**
+ * Fill in superblock and initialize fuse connection
+ * @sb: partially-initialized superblock to fill in
+ * @ctx: mount context
+ */
+int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx);
+
 /**
  * Add connection to control filesystem
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 31cf0c47da13..048816c95b69 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -64,23 +64,6 @@ MODULE_PARM_DESC(max_user_congthresh,
 static struct file_system_type fuseblk_fs_type;
 #endif
 
-struct fuse_fs_context {
-	const char	*subtype;
-	bool		is_bdev;
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
@@ -1083,17 +1066,13 @@ void fuse_dev_free(struct fuse_dev *fud)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_free);
 
-static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
+int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 {
-	struct fuse_fs_context *ctx = fsc->fs_private;
 	struct fuse_dev *fud;
-	struct fuse_conn *fc;
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
 	struct inode *root;
-	struct file *file;
 	struct dentry *root_dentry;
-	struct fuse_req *init_req;
 	int err;
-	int is_bdev = sb->s_bdev != NULL;
 
 	err = -EINVAL;
 	if (sb->s_flags & SB_MANDLOCK)
@@ -1101,7 +1080,7 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
 
-	if (is_bdev) {
+	if (ctx->is_bdev) {
 #ifdef CONFIG_BLOCK
 		err = -EINVAL;
 		if (!sb_set_blocksize(sb, ctx->blksize))
@@ -1124,19 +1103,6 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 
-	file = fget(ctx->fd);
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
@@ -1144,17 +1110,9 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_xattr = fuse_no_acl_xattr_handlers;
 
-	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
-	err = -ENOMEM;
-	if (!fc)
-		goto err_fput;
-
-	fuse_conn_init(fc, sb->s_user_ns);
-	fc->release = fuse_free_conn;
-
 	fud = fuse_dev_alloc(fc);
 	if (!fud)
-		goto err_put_conn;
+		goto err;
 
 	fc->dev = sb->s_dev;
 	fc->sb = sb;
@@ -1173,9 +1131,6 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	fc->group_id = ctx->group_id;
 	fc->max_read = max_t(unsigned, 4096, ctx->max_read);
 
-	/* Used by get_root_inode() */
-	sb->s_fs_info = fc;
-
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
 	sb->s_d_op = &fuse_root_dentry_operations;
@@ -1185,20 +1140,15 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	/* Root dentry doesn't have .d_revalidate */
 	sb->s_d_op = &fuse_dentry_operations;
 
-	init_req = fuse_request_alloc(0);
-	if (!init_req)
-		goto err_put_root;
-	__set_bit(FR_BACKGROUND, &init_req->flags);
-
-	if (is_bdev) {
+	if (ctx->is_bdev) {
 		fc->destroy_req = fuse_request_alloc(0);
 		if (!fc->destroy_req)
-			goto err_free_init_req;
+			goto err_put_root;
 	}
 
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
-	if (file->private_data)
+	if (*ctx->fudptr)
 		goto err_unlock;
 
 	err = fuse_ctl_add_conn(fc);
@@ -1207,30 +1157,75 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
-	file->private_data = fud;
+	*ctx->fudptr = fud;
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
 	fuse_dev_free(fud);
+ err:
+	return err;
+}
+EXPORT_SYMBOL_GPL(fuse_fill_super_common);
+
+static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
+{
+	struct fuse_fs_context *ctx = fsc->fs_private;
+	struct file *file;
+	int err;
+	struct fuse_req *init_req;
+	struct fuse_conn *fc;
+
+	err = -EINVAL;
+	file = fget(ctx->fd);
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
+	ctx->fudptr = &file->private_data;
+
+	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
+	err = -ENOMEM;
+	if (!fc)
+		goto err_free_init_req;
+
+	fuse_conn_init(fc, sb->s_user_ns);
+	fc->release = fuse_free_conn;
+	sb->s_fs_info = fc;
+
+	err = fuse_fill_super_common(sb, ctx);
+	if (err)
+		goto err_put_conn;
+	/*
+	 * atomic_dec_and_test() in fput() provides the necessary
+	 * memory barrier for file->private_data to be visible on all
+	 * CPUs after this
+	 */
+	fput(file);
+	fuse_send_init(get_fuse_conn_super(sb), init_req);
+	return 0;
+
  err_put_conn:
 	fuse_conn_put(fc);
 	sb->s_fs_info = NULL;
+ err_free_init_req:
+	fuse_request_free(init_req);
  err_fput:
 	fput(file);
  err:
-- 
2.21.0

