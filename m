Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C423F0F73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 02:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbhHSA1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 20:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhHSA1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:27:49 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEB2C061764;
        Wed, 18 Aug 2021 17:27:14 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id i28so8341323ljm.7;
        Wed, 18 Aug 2021 17:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=slL8WQJpSveoTSV6+zYKqn8eOOZlUj3SM/meJfx6NDE=;
        b=er/1safoIgTxu/eLbD4Co2oQLxnwwTPhTP5q2/hH/B+Ygmcw8aJ6Qlmm7SGkaX5Z45
         Zgirj1kMlOd/110wA8MHzABWDOu6um7oWHSK8PxXikf0o5jgUNdgrvuuH4tPHM83OU6c
         y2cKPz9UWu2do6g+9zk5lRSyKxvcttRbgcR3KPnlr5D6nlWK7Kj11enyOo5MY7oUvV+c
         xDulBemre9SsOijns6dcaGHX8H8+NzwASYPILHSlm1Hi/tUHU55sAsytO0/Xo7IY2yzI
         yk1HrOEBZbWzEM3j+BZgAGdq6jSd8dn3hWHlUZklh8mHbF7bqjv9LiHGfbrCrl3FbNlh
         HBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slL8WQJpSveoTSV6+zYKqn8eOOZlUj3SM/meJfx6NDE=;
        b=isVvTyGADfK346lgVLMvFL2JpWpzhc8Fz2gJXifwZ3BqKbtCFLRrG8t+pzOpI4IyyH
         0VbALJU7q0NYHd3nAlXeVkORnSBLr8hRztb6+gSwonG0HyYyN+4p3qFrbowcn4Dfnh1n
         L7GaihIF5dKJ3JIZ0EGG/U6v/4TNAm1oqV58FmEYg2vNjkoQPYFXBGIYbeR2c/eGXovT
         mGhLxdS5t1TQZPP5oUxo2eqJBT5cBcY4zsH9AgiC+e0Hi6XHTnDkDKlzVRxMCUy41nyo
         R/vLVDkeHj5K7UTnD1vDLarJqU2rs77rJWMXgB05pBfXUUtVmhitTgY3iNT6bFIKth2u
         ADiQ==
X-Gm-Message-State: AOAM531f4gHkyS0BYWYlW2E+E9ddeA3MMbUv8tdpyGj8JbFicoWM0ezE
        gGfDEncV/oEK+tsPrPbOZBI=
X-Google-Smtp-Source: ABdhPJwnsV4SMG7OuYD6myrNeUyMpHAoYwCBMPSkB+2stWoo/1xHNTQTieSp3EsNJbGeq8GutcExbA==
X-Received: by 2002:a2e:9d8e:: with SMTP id c14mr10187135ljj.156.1629332832420;
        Wed, 18 Aug 2021 17:27:12 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id l14sm125907lji.106.2021.08.18.17.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 17:27:12 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 3/6] fs/ntfs3: Use new api for mounting
Date:   Thu, 19 Aug 2021 03:26:30 +0300
Message-Id: <20210819002633.689831-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819002633.689831-1-kari.argillander@gmail.com>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have now new mount api as described in Documentation/filesystems. We
should use it as it gives us some benefits which are desribed here
lore.kernel.org/linux-fsdevel/159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk/

Nls loading is changed a to load with string. This did make code also
little cleaner.

Also try to use fsparam_flag_no as much as possible. This is just nice
little touch and is not mandatory but it should not make any harm. It
is just convenient that we can use example acl/noacl mount options.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/ntfs_fs.h |   1 +
 fs/ntfs3/super.c   | 392 +++++++++++++++++++++++----------------------
 2 files changed, 199 insertions(+), 194 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 0c3ac89c3115..1f07dd17c6c7 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -50,6 +50,7 @@
 
 struct ntfs_mount_options {
 	struct nls_table *nls;
+	char *nls_name;
 
 	kuid_t fs_uid;
 	kgid_t fs_gid;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 702da1437cfd..39936a4ce831 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -28,10 +28,11 @@
 #include <linux/buffer_head.h>
 #include <linux/exportfs.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/iversion.h>
 #include <linux/module.h>
 #include <linux/nls.h>
-#include <linux/parser.h>
 #include <linux/seq_file.h>
 #include <linux/statfs.h>
 
@@ -197,8 +198,32 @@ void *ntfs_put_shared(void *ptr)
 	return ret;
 }
 
+/*
+ * Load nls table or if @nls is utf8 then return NULL because
+ * nls=utf8 is totally broken.
+ */
+static struct nls_table *ntfs_load_nls(char *nls)
+{
+	struct nls_table *ret;
+
+	if (!nls)
+		nls = CONFIG_NLS_DEFAULT;
+
+	if (strcmp(nls, "utf8"))
+		return NULL;
+	if (strcmp(nls, CONFIG_NLS_DEFAULT))
+		return load_nls_default();
+
+	ret = load_nls(nls);
+	if (!ret)
+		return ERR_PTR(-EINVAL);
+
+	return ret;
+}
+
 static inline void clear_mount_options(struct ntfs_mount_options *options)
 {
+	kfree(options->nls_name);
 	unload_nls(options->nls);
 }
 
@@ -221,202 +246,150 @@ enum Opt {
 	Opt_err,
 };
 
-static const match_table_t ntfs_tokens = {
-	{ Opt_uid, "uid=%u" },
-	{ Opt_gid, "gid=%u" },
-	{ Opt_umask, "umask=%o" },
-	{ Opt_dmask, "dmask=%o" },
-	{ Opt_fmask, "fmask=%o" },
-	{ Opt_immutable, "sys_immutable" },
-	{ Opt_discard, "discard" },
-	{ Opt_force, "force" },
-	{ Opt_sparse, "sparse" },
-	{ Opt_nohidden, "nohidden" },
-	{ Opt_acl, "acl" },
-	{ Opt_showmeta, "showmeta" },
-	{ Opt_nls, "nls=%s" },
-	{ Opt_prealloc, "prealloc" },
-	{ Opt_no_acs_rules, "no_acs_rules" },
-	{ Opt_err, NULL },
+static const struct fs_parameter_spec ntfs_fs_parameters[] = {
+	fsparam_u32("uid",			Opt_uid),
+	fsparam_u32("gid",			Opt_gid),
+	fsparam_u32oct("umask",			Opt_umask),
+	fsparam_u32oct("dmask",			Opt_dmask),
+	fsparam_u32oct("fmask",			Opt_fmask),
+	fsparam_flag_no("sys_immutable",	Opt_immutable),
+	fsparam_flag_no("discard",		Opt_discard),
+	fsparam_flag_no("force",		Opt_force),
+	fsparam_flag_no("sparse",		Opt_sparse),
+	fsparam_flag("nohidden",		Opt_nohidden),
+	fsparam_flag_no("acl",			Opt_acl),
+	fsparam_flag_no("showmeta",		Opt_showmeta),
+	fsparam_string("nls",			Opt_nls),
+	fsparam_flag_no("prealloc",		Opt_prealloc),
+	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
+	{}
 };
 
-static noinline int ntfs_parse_options(struct super_block *sb, char *options,
-				       int silent,
-				       struct ntfs_mount_options *opts)
+static int ntfs_fs_parse_param(struct fs_context *fc,
+			       struct fs_parameter *param)
 {
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	char nls_name[30];
-	struct nls_table *nls;
-
-	opts->fs_uid = current_uid();
-	opts->fs_gid = current_gid();
-	opts->fs_fmask_inv = opts->fs_dmask_inv = ~current_umask();
-	nls_name[0] = 0;
-
-	if (!options)
-		goto out;
-
-	while ((p = strsep(&options, ","))) {
-		int token;
+	struct ntfs_sb_info *sbi = fc->s_fs_info;
+	struct ntfs_mount_options *opts = &sbi->options;
+	struct fs_parse_result result;
+	int opt;
 
-		if (!*p)
-			continue;
+	opt = fs_parse(fc, ntfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
 
-		token = match_token(p, ntfs_tokens, args);
-		switch (token) {
-		case Opt_immutable:
-			opts->sys_immutable = 1;
-			break;
-		case Opt_uid:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			opts->fs_uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(opts->fs_uid))
-				return -EINVAL;
-			opts->uid = 1;
-			break;
-		case Opt_gid:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			opts->fs_gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(opts->fs_gid))
-				return -EINVAL;
-			opts->gid = 1;
-			break;
-		case Opt_umask:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->fs_fmask_inv = opts->fs_dmask_inv = ~option;
-			opts->fmask = opts->dmask = 1;
-			break;
-		case Opt_dmask:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->fs_dmask_inv = ~option;
-			opts->dmask = 1;
-			break;
-		case Opt_fmask:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->fs_fmask_inv = ~option;
-			opts->fmask = 1;
-			break;
-		case Opt_discard:
-			opts->discard = 1;
-			break;
-		case Opt_force:
-			opts->force = 1;
-			break;
-		case Opt_sparse:
-			opts->sparse = 1;
-			break;
-		case Opt_nohidden:
-			opts->nohidden = 1;
-			break;
-		case Opt_acl:
+	switch (opt) {
+	case Opt_uid:
+		opts->fs_uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(opts->fs_uid))
+			return -EINVAL;
+		opts->uid = 1;
+		break;
+	case Opt_gid:
+		opts->fs_gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(opts->fs_gid))
+			return -EINVAL;
+		opts->gid = 1;
+		break;
+	case Opt_umask:
+		opts->fs_fmask_inv = ~result.uint_32;
+		opts->fs_dmask_inv = ~result.uint_32;
+		opts->fmask = 1;
+		opts->dmask = 1;
+		break;
+	case Opt_dmask:
+		opts->fs_dmask_inv = ~result.uint_32;
+		opts->dmask = 1;
+		break;
+	case Opt_fmask:
+		opts->fs_fmask_inv = ~result.uint_32;
+		opts->fmask = 1;
+		break;
+	case Opt_immutable:
+		opts->sys_immutable = result.negated ? 0 : 1;
+		break;
+	case Opt_discard:
+		opts->discard = result.negated ? 0 : 1;
+		break;
+	case Opt_force:
+		opts->force = result.negated ? 0 : 1;
+		break;
+	case Opt_sparse:
+		opts->sparse = result.negated ? 0 : 1;
+		break;
+	case Opt_nohidden:
+		opts->nohidden = 1;
+		break;
+	case Opt_acl:
+		if (!result.negated)
 #ifdef CONFIG_NTFS3_FS_POSIX_ACL
-			sb->s_flags |= SB_POSIXACL;
-			break;
+			fc->sb_flags |= SB_POSIXACL;
 #else
-			ntfs_err(sb, "support for ACL not compiled in!");
-			return -EINVAL;
+			return invalf(fc, "ntfs3: Support for ACL not compiled in!");
 #endif
-		case Opt_showmeta:
-			opts->showmeta = 1;
-			break;
-		case Opt_nls:
-			match_strlcpy(nls_name, &args[0], sizeof(nls_name));
-			break;
-		case Opt_prealloc:
-			opts->prealloc = 1;
-			break;
-		case Opt_no_acs_rules:
-			opts->no_acs_rules = 1;
-			break;
-		default:
-			if (!silent)
-				ntfs_err(
-					sb,
-					"Unrecognized mount option \"%s\" or missing value",
-					p);
-			//return -EINVAL;
-		}
+		else
+			fc->sb_flags &= ~SB_POSIXACL;
+		break;
+	case Opt_showmeta:
+		opts->showmeta = result.negated ? 0 : 1;
+		break;
+	case Opt_nls:
+		opts->nls_name = param->string;
+		param->string = NULL;
+		break;
+	case Opt_prealloc:
+		opts->prealloc = result.negated ? 0 : 1;
+		break;
+	case Opt_no_acs_rules:
+		opts->no_acs_rules = 1;
+		break;
+	default:
+		/* Should not be here unless we forget add case. */
+		return -EINVAL;
 	}
-
-out:
-	if (!strcmp(nls_name[0] ? nls_name : CONFIG_NLS_DEFAULT, "utf8")) {
-		/* For UTF-8 use utf16s_to_utf8s/utf8s_to_utf16s instead of nls */
-		nls = NULL;
-	} else if (nls_name[0]) {
-		nls = load_nls(nls_name);
-		if (!nls) {
-			ntfs_err(sb, "failed to load \"%s\"", nls_name);
-			return -EINVAL;
-		}
-	} else {
-		nls = load_nls_default();
-		if (!nls) {
-			ntfs_err(sb, "failed to load default nls");
-			return -EINVAL;
-		}
-	}
-	opts->nls = nls;
-
 	return 0;
 }
 
-static int ntfs_remount(struct super_block *sb, int *flags, char *data)
+static int ntfs_fs_reconfigure(struct fs_context *fc)
 {
-	int err, ro_rw;
+	struct super_block *sb = fc->root->d_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
-	struct ntfs_mount_options old_opts;
-	char *orig_data = kstrdup(data, GFP_KERNEL);
+	struct ntfs_mount_options *new_opts = fc->s_fs_info;
+	int ro_rw;
 
-	if (data && !orig_data)
-		return -ENOMEM;
-
-	/* Store  original options */
-	memcpy(&old_opts, &sbi->options, sizeof(old_opts));
-	clear_mount_options(&sbi->options);
-	memset(&sbi->options, 0, sizeof(sbi->options));
-
-	err = ntfs_parse_options(sb, data, 0, &sbi->options);
-	if (err)
-		goto restore_opts;
-
-	ro_rw = sb_rdonly(sb) && !(*flags & SB_RDONLY);
+	ro_rw = sb_rdonly(sb) && !(fc->sb_flags & SB_RDONLY);
 	if (ro_rw && (sbi->flags & NTFS_FLAGS_NEED_REPLAY)) {
-		ntfs_warn(
-			sb,
-			"Couldn't remount rw because journal is not replayed. Please umount/remount instead\n");
-		err = -EINVAL;
-		goto restore_opts;
+		errorf(fc, "ntfs3: Couldn't remount rw because journal is not replayed. Please umount/remount instead\n");
+		goto clear_new_fc;
 	}
 
 	sync_filesystem(sb);
 
 	if (ro_rw && (sbi->volume.flags & VOLUME_FLAG_DIRTY) &&
-	    !sbi->options.force) {
-		ntfs_warn(sb, "volume is dirty and \"force\" flag is not set!");
-		err = -EINVAL;
-		goto restore_opts;
+	    !new_opts->force) {
+		errorf(fc, "ntfs3: Volume is dirty and \"force\" flag is not set!");
+		goto clear_new_fc;
 	}
 
-	clear_mount_options(&old_opts);
+	/*
+	 * TODO: We should probably check some mount options does
+	 * they all work after remount. Example can we really change
+	 * nls. Remove this comment when all testing is done or
+	 * even better xfstest is made for it.
+	 */
 
-	ntfs_info(sb, "re-mounted. Opts: %s", orig_data);
-	err = 0;
-	goto out;
+	new_opts->nls = ntfs_load_nls(new_opts->nls_name);
+	if (IS_ERR(new_opts->nls)) {
+		errorf(fc, "ntfs3: Cannot load nls %s", new_opts->nls_name);
+		goto clear_new_fc;
+	}
 
-restore_opts:
 	clear_mount_options(&sbi->options);
-	memcpy(&sbi->options, &old_opts, sizeof(old_opts));
+	sbi->options = *new_opts;
+	return 0;
 
-out:
-	kfree(orig_data);
-	return err;
+clear_new_fc:
+	clear_mount_options(new_opts);
+	return -EINVAL;
 }
 
 static struct kmem_cache *ntfs_inode_cachep;
@@ -545,10 +518,8 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",fmask=%04o", ~opts->fs_fmask_inv);
 	if (opts->dmask)
 		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
-	if (opts->nls)
-		seq_printf(m, ",nls=%s", opts->nls->charset);
-	else
-		seq_puts(m, ",nls=utf8");
+	if (opts->nls_name)
+		seq_printf(m, ",nls=%s", opts->nls_name);
 	if (opts->sys_immutable)
 		seq_puts(m, ",sys_immutable");
 	if (opts->discard)
@@ -619,7 +590,6 @@ static const struct super_operations ntfs_sops = {
 	.statfs = ntfs_statfs,
 	.show_options = ntfs_show_options,
 	.sync_fs = ntfs_sync_fs,
-	.remount_fs = ntfs_remount,
 	.write_inode = ntfs3_write_inode,
 };
 
@@ -883,10 +853,10 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 }
 
 /* try to mount*/
-static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
+static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	int err;
-	struct ntfs_sb_info *sbi;
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	struct block_device *bdev = sb->s_bdev;
 	struct inode *bd_inode = bdev->bd_inode;
 	struct request_queue *rq = bdev_get_queue(bdev);
@@ -905,11 +875,6 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	ref.high = 0;
 
-	sbi = ntfs_zalloc(sizeof(struct ntfs_sb_info));
-	if (!sbi)
-		return -ENOMEM;
-
-	sb->s_fs_info = sbi;
 	sbi->sb = sb;
 	sb->s_flags |= SB_NODIRATIME;
 	sb->s_magic = 0x7366746e; // "ntfs"
@@ -921,10 +886,6 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	ratelimit_state_init(&sbi->msg_ratelimit, DEFAULT_RATELIMIT_INTERVAL,
 			     DEFAULT_RATELIMIT_BURST);
 
-	err = ntfs_parse_options(sb, data, silent, &sbi->options);
-	if (err)
-		goto out;
-
 	if (!rq || !blk_queue_discard(rq) || !rq->limits.discard_granularity) {
 		;
 	} else {
@@ -933,6 +894,14 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 			~(u64)(sbi->discard_granularity - 1);
 	}
 
+	sbi->options.nls = ntfs_load_nls(sbi->options.nls_name);
+	if (IS_ERR(sbi->options.nls)) {
+		ntfs_err(sb, "ntfs3: Cannot load nls %s",
+				sbi->options.nls_name);
+		err = PTR_ERR(sbi->options.nls);
+		goto out;
+	}
+
 	sb_set_blocksize(sb, PAGE_SIZE);
 
 	/* parse boot */
@@ -1400,19 +1369,54 @@ int ntfs_discard(struct ntfs_sb_info *sbi, CLST lcn, CLST len)
 	return err;
 }
 
-static struct dentry *ntfs_mount(struct file_system_type *fs_type, int flags,
-				 const char *dev_name, void *data)
+static int ntfs_fs_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, ntfs_fill_super);
+}
+
+static void ntfs_fs_free(struct fs_context *fc)
+{
+	struct ntfs_sb_info *sbi = fc->s_fs_info;
+
+	if (sbi)
+		put_ntfs(sbi);
+}
+
+static const struct fs_context_operations ntfs_context_ops = {
+	.parse_param	= ntfs_fs_parse_param,
+	.get_tree	= ntfs_fs_get_tree,
+	.reconfigure	= ntfs_fs_reconfigure,
+	.free		= ntfs_fs_free,
+};
+
+static int ntfs_init_fs_context(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, ntfs_fill_super);
+	struct ntfs_sb_info *sbi;
+
+	sbi = ntfs_zalloc(sizeof(struct ntfs_sb_info));
+	if (!sbi)
+		return -ENOMEM;
+
+	/* Default options */
+	sbi->options.fs_uid = current_uid();
+	sbi->options.fs_gid = current_gid();
+	sbi->options.fs_fmask_inv = ~current_umask();
+	sbi->options.fs_dmask_inv = ~current_umask();
+
+	fc->s_fs_info = sbi;
+	fc->ops = &ntfs_context_ops;
+
+	return 0;
 }
 
 // clang-format off
 static struct file_system_type ntfs_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "ntfs3",
-	.mount		= ntfs_mount,
-	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.owner			= THIS_MODULE,
+	.name			= "ntfs3",
+	.init_fs_context	= ntfs_init_fs_context,
+	.parameters		= ntfs_fs_parameters,
+	.kill_sb		= kill_block_super,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 // clang-format on
 
-- 
2.25.1

