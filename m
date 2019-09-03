Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E9BA6781
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfICLhJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:37:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728923AbfICLgt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:36:49 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 94C6C2A09AC
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 11:36:48 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id n6so8629022wrw.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 04:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GsTPmCBROXkWENE8u9zhZAvKwRylFezdTcPk/AGw/ug=;
        b=cfdDU3KOCzc5IlVHa48yFGJwXAnsSWaOhg7ons9dU/gBwji1SbnAUijoMztmrSGItX
         sKEULURWpqfcE+qpeENEh4053oj++HAmDdX62GeQ3KFszTMJZT3abV18s+fCsGUngJGJ
         TVDkScaZpYvRc1G3PzDQoaJhPumJAskjbxf5prgys3lzIW50aTRoqaOgM0MoTX43YM6C
         uWEKcoXy+JGUsPKyaN8cz/jYaNF5elOyj4DvSikwD+8armrj07NBADq5pTN0DAVhz0Y0
         f9qFInaaTGdP1Y0DUSKc+SgrzTIrYiI1uo8LVa+GcaE+stXK/cgEvP7KpUWyGEsVomSB
         yz4A==
X-Gm-Message-State: APjAAAWib1GAjx1qs/qrqZKVU8RzYzqwUYJrl4NAbv9szWzd8VoJuILY
        M6HN1Lel8M1vjsSLt9sCiHQEIwT1deFQkVQEbYFomHM9oi6IWKi7+cWd0BKi6Gibd9lXJNlp+lo
        tq4MaIV0KQDsSwKUZeb7OcNLmDg==
X-Received: by 2002:a1c:cf8c:: with SMTP id f134mr36659170wmg.174.1567510607222;
        Tue, 03 Sep 2019 04:36:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyaQmM6ki55/MXLUqsRFjhUVH9FR9teEsXG03/JzDrxL6iIV536blqTA9FvfRi/RsyYgT+xpA==
X-Received: by 2002:a1c:cf8c:: with SMTP id f134mr36659137wmg.174.1567510606923;
        Tue, 03 Sep 2019 04:36:46 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v186sm40446906wmb.5.2019.09.03.04.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:36:46 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v4 02/16] fuse: convert to use the new mount API
Date:   Tue,  3 Sep 2019 13:36:26 +0200
Message-Id: <20190903113640.7984-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Convert the fuse filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/inode.c | 292 +++++++++++++++++++++++++++---------------------
 1 file changed, 167 insertions(+), 125 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4bb885b0f032..2597ed237ada 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -15,7 +15,8 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/statfs.h>
 #include <linux/random.h>
 #include <linux/sched.h>
@@ -59,7 +60,13 @@ MODULE_PARM_DESC(max_user_congthresh,
 /** Congestion starts at 75% of maximum */
 #define FUSE_DEFAULT_CONGESTION_THRESHOLD (FUSE_DEFAULT_MAX_BACKGROUND * 3 / 4)
 
-struct fuse_mount_data {
+#ifdef CONFIG_BLOCK
+static struct file_system_type fuseblk_fs_type;
+#endif
+
+struct fuse_fs_context {
+	const char	*subtype;
+	bool		is_bdev;
 	int fd;
 	unsigned rootmode;
 	kuid_t user_id;
@@ -443,6 +450,8 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 }
 
 enum {
+	OPT_SOURCE,
+	OPT_SUBTYPE,
 	OPT_FD,
 	OPT_ROOTMODE,
 	OPT_USER_ID,
@@ -454,111 +463,110 @@ enum {
 	OPT_ERR
 };
 
-static const match_table_t tokens = {
-	{OPT_FD,			"fd=%u"},
-	{OPT_ROOTMODE,			"rootmode=%o"},
-	{OPT_USER_ID,			"user_id=%u"},
-	{OPT_GROUP_ID,			"group_id=%u"},
-	{OPT_DEFAULT_PERMISSIONS,	"default_permissions"},
-	{OPT_ALLOW_OTHER,		"allow_other"},
-	{OPT_MAX_READ,			"max_read=%u"},
-	{OPT_BLKSIZE,			"blksize=%u"},
-	{OPT_ERR,			NULL}
+static const struct fs_parameter_spec fuse_param_specs[] = {
+	fsparam_string	("source",		OPT_SOURCE),
+	fsparam_u32	("fd",			OPT_FD),
+	fsparam_u32oct	("rootmode",		OPT_ROOTMODE),
+	fsparam_u32	("user_id",		OPT_USER_ID),
+	fsparam_u32	("group_id",		OPT_GROUP_ID),
+	fsparam_flag	("default_permissions",	OPT_DEFAULT_PERMISSIONS),
+	fsparam_flag	("allow_other",		OPT_ALLOW_OTHER),
+	fsparam_u32	("max_read",		OPT_MAX_READ),
+	fsparam_u32	("blksize",		OPT_BLKSIZE),
+	__fsparam(fs_param_is_string, "subtype", OPT_SUBTYPE,
+		  fs_param_v_optional),
+	{}
+};
+
+static const struct fs_parameter_description fuse_fs_parameters = {
+	.name		= "fuse",
+	.specs		= fuse_param_specs,
 };
 
-static int fuse_match_uint(substring_t *s, unsigned int *res)
+static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	int err = -ENOMEM;
-	char *buf = match_strdup(s);
-	if (buf) {
-		err = kstrtouint(buf, 10, res);
-		kfree(buf);
+	struct fs_parse_result result;
+	struct fuse_fs_context *ctx = fc->fs_private;
+	int opt;
+
+	opt = fs_parse(fc, &fuse_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case OPT_SOURCE:
+		if (fc->source)
+			return invalf(fc, "fuse: Multiple sources specified");
+		fc->source = param->string;
+		param->string = NULL;
+		break;
+
+	case OPT_SUBTYPE:
+		if (ctx->subtype)
+			return invalf(fc, "fuse: Multiple subtypes specified");
+		ctx->subtype = param->string;
+		param->string = NULL;
+		return 0;
+
+	case OPT_FD:
+		ctx->fd = result.uint_32;
+		ctx->fd_present = 1;
+		break;
+
+	case OPT_ROOTMODE:
+		if (!fuse_valid_type(result.uint_32))
+			return invalf(fc, "fuse: Invalid rootmode");
+		ctx->rootmode = result.uint_32;
+		ctx->rootmode_present = 1;
+		break;
+
+	case OPT_USER_ID:
+		ctx->user_id = make_kuid(fc->user_ns, result.uint_32);
+		if (!uid_valid(ctx->user_id))
+			return invalf(fc, "fuse: Invalid user_id");
+		ctx->user_id_present = 1;
+		break;
+
+	case OPT_GROUP_ID:
+		ctx->group_id = make_kgid(fc->user_ns, result.uint_32);
+		if (!gid_valid(ctx->group_id))
+			return invalf(fc, "fuse: Invalid group_id");
+		ctx->group_id_present = 1;
+		break;
+
+	case OPT_DEFAULT_PERMISSIONS:
+		ctx->default_permissions = 1;
+		break;
+
+	case OPT_ALLOW_OTHER:
+		ctx->allow_other = 1;
+		break;
+
+	case OPT_MAX_READ:
+		ctx->max_read = result.uint_32;
+		break;
+
+	case OPT_BLKSIZE:
+		if (!ctx->is_bdev)
+			return invalf(fc, "fuse: blksize only supported for fuseblk");
+		ctx->blksize = result.uint_32;
+		break;
+
+	default:
+		return -EINVAL;
 	}
-	return err;
+
+	return 0;
 }
 
-static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
-			  struct user_namespace *user_ns)
+static void fuse_free_fc(struct fs_context *fc)
 {
-	char *p;
-	memset(d, 0, sizeof(struct fuse_mount_data));
-	d->max_read = ~0;
-	d->blksize = FUSE_DEFAULT_BLKSIZE;
-
-	while ((p = strsep(&opt, ",")) != NULL) {
-		int token;
-		int value;
-		unsigned uv;
-		substring_t args[MAX_OPT_ARGS];
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case OPT_FD:
-			if (match_int(&args[0], &value))
-				return 0;
-			d->fd = value;
-			d->fd_present = 1;
-			break;
-
-		case OPT_ROOTMODE:
-			if (match_octal(&args[0], &value))
-				return 0;
-			if (!fuse_valid_type(value))
-				return 0;
-			d->rootmode = value;
-			d->rootmode_present = 1;
-			break;
-
-		case OPT_USER_ID:
-			if (fuse_match_uint(&args[0], &uv))
-				return 0;
-			d->user_id = make_kuid(user_ns, uv);
-			if (!uid_valid(d->user_id))
-				return 0;
-			d->user_id_present = 1;
-			break;
-
-		case OPT_GROUP_ID:
-			if (fuse_match_uint(&args[0], &uv))
-				return 0;
-			d->group_id = make_kgid(user_ns, uv);
-			if (!gid_valid(d->group_id))
-				return 0;
-			d->group_id_present = 1;
-			break;
-
-		case OPT_DEFAULT_PERMISSIONS:
-			d->default_permissions = 1;
-			break;
-
-		case OPT_ALLOW_OTHER:
-			d->allow_other = 1;
-			break;
-
-		case OPT_MAX_READ:
-			if (match_int(&args[0], &value))
-				return 0;
-			d->max_read = value;
-			break;
-
-		case OPT_BLKSIZE:
-			if (!is_bdev || match_int(&args[0], &value))
-				return 0;
-			d->blksize = value;
-			break;
-
-		default:
-			return 0;
-		}
-	}
+	struct fuse_fs_context *ctx = fc->fs_private;
 
-	if (!d->fd_present || !d->rootmode_present ||
-	    !d->user_id_present || !d->group_id_present)
-		return 0;
-
-	return 1;
+	if (ctx) {
+		kfree(ctx->subtype);
+		kfree(ctx);
+	}
 }
 
 static int fuse_show_options(struct seq_file *m, struct dentry *root)
@@ -1075,12 +1083,12 @@ void fuse_dev_free(struct fuse_dev *fud)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_free);
 
-static int fuse_fill_super(struct super_block *sb, void *data, int silent)
+static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 {
+	struct fuse_fs_context *ctx = fsc->fs_private;
 	struct fuse_dev *fud;
 	struct fuse_conn *fc;
 	struct inode *root;
-	struct fuse_mount_data d;
 	struct file *file;
 	struct dentry *root_dentry;
 	struct fuse_req *init_req;
@@ -1093,19 +1101,19 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
 
-	if (!parse_fuse_opt(data, &d, is_bdev, sb->s_user_ns))
-		goto err;
-
 	if (is_bdev) {
 #ifdef CONFIG_BLOCK
 		err = -EINVAL;
-		if (!sb_set_blocksize(sb, d.blksize))
+		if (!sb_set_blocksize(sb, ctx->blksize))
 			goto err;
 #endif
 	} else {
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
 	}
+
+	sb->s_subtype = ctx->subtype;
+	ctx->subtype = NULL;
 	sb->s_magic = FUSE_SUPER_MAGIC;
 	sb->s_op = &fuse_super_operations;
 	sb->s_xattr = fuse_xattr_handlers;
@@ -1116,7 +1124,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 
-	file = fget(d.fd);
+	file = fget(ctx->fd);
 	err = -EINVAL;
 	if (!file)
 		goto err;
@@ -1159,17 +1167,17 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 		fc->dont_mask = 1;
 	sb->s_flags |= SB_POSIXACL;
 
-	fc->default_permissions = d.default_permissions;
-	fc->allow_other = d.allow_other;
-	fc->user_id = d.user_id;
-	fc->group_id = d.group_id;
-	fc->max_read = max_t(unsigned, 4096, d.max_read);
+	fc->default_permissions = ctx->default_permissions;
+	fc->allow_other = ctx->allow_other;
+	fc->user_id = ctx->user_id;
+	fc->group_id = ctx->group_id;
+	fc->max_read = max_t(unsigned, 4096, ctx->max_read);
 
 	/* Used by get_root_inode() */
 	sb->s_fs_info = fc;
 
 	err = -ENOMEM;
-	root = fuse_get_root_inode(sb, d.rootmode);
+	root = fuse_get_root_inode(sb, ctx->rootmode);
 	sb->s_d_op = &fuse_root_dentry_operations;
 	root_dentry = d_make_root(root);
 	if (!root_dentry)
@@ -1229,11 +1237,50 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	return err;
 }
 
-static struct dentry *fuse_mount(struct file_system_type *fs_type,
-		       int flags, const char *dev_name,
-		       void *raw_data)
+static int fuse_get_tree(struct fs_context *fc)
 {
-	return mount_nodev(fs_type, flags, raw_data, fuse_fill_super);
+	struct fuse_fs_context *ctx = fc->fs_private;
+
+	if (!ctx->fd_present || !ctx->rootmode_present ||
+	    !ctx->user_id_present || !ctx->group_id_present)
+		return -EINVAL;
+
+#ifdef CONFIG_BLOCK
+	if (ctx->is_bdev)
+		return vfs_get_block_super(fc, fuse_fill_super);
+#endif
+
+	return get_tree_nodev(fc, fuse_fill_super);
+}
+
+static const struct fs_context_operations fuse_context_ops = {
+	.free		= fuse_free_fc,
+	.parse_param	= fuse_parse_param,
+	.get_tree	= fuse_get_tree,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+static int fuse_init_fs_context(struct fs_context *fc)
+{
+	struct fuse_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct fuse_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->max_read = ~0;
+	ctx->blksize = FUSE_DEFAULT_BLKSIZE;
+
+#ifdef CONFIG_BLOCK
+	if (fc->fs_type == &fuseblk_fs_type)
+		ctx->is_bdev = true;
+#endif
+
+	fc->fs_private = ctx;
+	fc->ops = &fuse_context_ops;
+	return 0;
 }
 
 static void fuse_sb_destroy(struct super_block *sb)
@@ -1262,19 +1309,13 @@ static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
 	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
-	.mount		= fuse_mount,
+	.init_fs_context = fuse_init_fs_context,
+	.parameters	= &fuse_fs_parameters,
 	.kill_sb	= fuse_kill_sb_anon,
 };
 MODULE_ALIAS_FS("fuse");
 
 #ifdef CONFIG_BLOCK
-static struct dentry *fuse_mount_blk(struct file_system_type *fs_type,
-			   int flags, const char *dev_name,
-			   void *raw_data)
-{
-	return mount_bdev(fs_type, flags, dev_name, raw_data, fuse_fill_super);
-}
-
 static void fuse_kill_sb_blk(struct super_block *sb)
 {
 	fuse_sb_destroy(sb);
@@ -1284,7 +1325,8 @@ static void fuse_kill_sb_blk(struct super_block *sb)
 static struct file_system_type fuseblk_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuseblk",
-	.mount		= fuse_mount_blk,
+	.init_fs_context = fuse_init_fs_context,
+	.parameters	= &fuse_fs_parameters,
 	.kill_sb	= fuse_kill_sb_blk,
 	.fs_flags	= FS_REQUIRES_DEV | FS_HAS_SUBTYPE,
 };
-- 
2.21.0

