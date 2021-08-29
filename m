Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6329E3FAA93
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 11:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhH2J5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 05:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbhH2J5m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:57:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44259C061575;
        Sun, 29 Aug 2021 02:56:50 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s12so20216815ljg.0;
        Sun, 29 Aug 2021 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdHTY/IMUrMCAKQbEKX6eMWE1VQbU+5gBAU9bs7v5xo=;
        b=F2C3LgJz5fo5L3+hkO/WCCXVR2u2mUG3QXVnSsjNB23e6+PLTzabb2JGMye22HKEsX
         KmokhEJozm4gjXIdNzPHNJLFcMWclakVH1cNTM5BXdxlaE/6gVBkyffcrUtZp1gTqBaO
         3FBUJnYH7yxl4GLZpR5eSWupUk/8dz8D6yhE+rFDjELuOnvfEo7XmgKXPHIIZnnecqRu
         qJSxTtueh8lYym6XH7Da9z1d5z10Ji18x1RwXsVDvINAMtzrLFkA9SIZlBt8LxkxivPA
         L55ofL2sPtxIhXwMBKf5teIRlllUrfxGNeIgX13N9Q+CMQgFmsHZ21yJXua9+dtplLSv
         hTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdHTY/IMUrMCAKQbEKX6eMWE1VQbU+5gBAU9bs7v5xo=;
        b=MC8dQAiJnrBoPgw0Oyz8Gy8pvr9yiiZvCygTu/7hbiEY1Q5IthmSe9tmJnRl8YjUyS
         GRVIp9/CB1tY5pv865w4abbv5TlAxgQVunjJ9Hnow4a93VEb1wHbVl2JpcNOm9Rz4f75
         WFqWiDNTBMxYHUQHgBEHrY3fYwGouny0N/90ji6SpstXfoCxSttZTg3ojLLBCyNfoAz6
         Z7cklOTxbw2Nyw095JaFxqvCz8Pq98hOGr+V6xUpigXODAARqgFwTjfnmA1gheoP7JLi
         WeqbQ5rihAHMhdikxHusnnd9uZv8dTaRWbK2/H2lXIgGhO7JNnofasnvL86il2hQd2tk
         7erg==
X-Gm-Message-State: AOAM532sHqY0n9FVvLiu/wIeti8Vfvh+0oe9ff+VxHVZMedKhLeuS5mC
        Xm+ZfIR1pZVUiZPGaWaYC8s=
X-Google-Smtp-Source: ABdhPJyIft6JvND9JDRhwRugF6nxmvLSVt0rGR27PTpUrNWPZDYrT1R0vV2uaIBX/Y8ldEdbYs8k2w==
X-Received: by 2002:a2e:3914:: with SMTP id g20mr15652340lja.88.1630231008525;
        Sun, 29 Aug 2021 02:56:48 -0700 (PDT)
Received: from localhost.localdomain (37-33-245-172.bb.dnainternet.fi. [37.33.245.172])
        by smtp.gmail.com with ESMTPSA id d6sm1090521lfi.57.2021.08.29.02.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:56:48 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 4/9] fs/ntfs3: Use new api for mounting
Date:   Sun, 29 Aug 2021 12:56:09 +0300
Message-Id: <20210829095614.50021-5-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829095614.50021-1-kari.argillander@gmail.com>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
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
 fs/ntfs3/super.c   | 426 ++++++++++++++++++++++++---------------------
 2 files changed, 225 insertions(+), 202 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 43b177280f39..45d6f4f91222 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -52,6 +52,7 @@
 // clang-format on
 
 struct ntfs_mount_options {
+	char *nls_name;
 	struct nls_table *nls;
 
 	kuid_t fs_uid;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index e9dfe274b558..99102a146cf5 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -28,11 +28,12 @@
 #include <linux/buffer_head.h>
 #include <linux/exportfs.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/iversion.h>
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/nls.h>
-#include <linux/parser.h>
 #include <linux/seq_file.h>
 #include <linux/statfs.h>
 
@@ -198,9 +199,11 @@ void *ntfs_put_shared(void *ptr)
 	return ret;
 }
 
-static inline void clear_mount_options(struct ntfs_mount_options *options)
+static inline void put_mount_options(struct ntfs_mount_options *options)
 {
+	kfree(options->nls_name);
 	unload_nls(options->nls);
+	kfree(options);
 }
 
 enum Opt {
@@ -222,202 +225,171 @@ enum Opt {
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
+/*
+ * Load nls table or if @nls is utf8 then return NULL.
+ */
+static struct nls_table *ntfs_load_nls(char *nls)
 {
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	char nls_name[30];
-	struct nls_table *nls;
+	struct nls_table *ret;
 
-	opts->fs_uid = current_uid();
-	opts->fs_gid = current_gid();
-	opts->fs_fmask_inv = opts->fs_dmask_inv = ~current_umask();
-	nls_name[0] = 0;
+	if (!nls)
+		nls = CONFIG_NLS_DEFAULT;
 
-	if (!options)
-		goto out;
+	if (strcmp(nls, "utf8") == 0)
+		return NULL;
 
-	while ((p = strsep(&options, ","))) {
-		int token;
+	if (strcmp(nls, CONFIG_NLS_DEFAULT) == 0)
+		return load_nls_default();
 
-		if (!*p)
-			continue;
+	ret = load_nls(nls);
+	if (ret)
+		return ret;
 
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
+	return ERR_PTR(-EINVAL);
+}
+
+static int ntfs_fs_parse_param(struct fs_context *fc,
+			       struct fs_parameter *param)
+{
+	struct ntfs_mount_options *opts = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, ntfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_uid:
+		opts->fs_uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(opts->fs_uid))
+			return invalf(fc, "ntfs3: Invalid value for uid.");
+		opts->uid = 1;
+		break;
+	case Opt_gid:
+		opts->fs_gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(opts->fs_gid))
+			return invalf(fc, "ntfs3: Invalid value for gid.");
+		opts->gid = 1;
+		break;
+	case Opt_umask:
+		if (result.uint_32 & ~07777)
+			return invalf(fc, "ntfs3: Invalid value for umask.");
+		opts->fs_fmask_inv = ~result.uint_32;
+		opts->fs_dmask_inv = ~result.uint_32;
+		opts->fmask = 1;
+		opts->dmask = 1;
+		break;
+	case Opt_dmask:
+		if (result.uint_32 & ~07777)
+			return invalf(fc, "ntfs3: Invalid value for dmask.");
+		opts->fs_dmask_inv = ~result.uint_32;
+		opts->dmask = 1;
+		break;
+	case Opt_fmask:
+		if (result.uint_32 & ~07777)
+			return invalf(fc, "ntfs3: Invalid value for fmask.");
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
-	}
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
+		else
+			fc->sb_flags &= ~SB_POSIXACL;
+		break;
+	case Opt_showmeta:
+		opts->showmeta = result.negated ? 0 : 1;
+		break;
+	case Opt_nls:
+		kfree(opts->nls_name);
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
-
-	if (data && !orig_data)
-		return -ENOMEM;
-
-	/* Store  original options */
-	memcpy(&old_opts, sbi->options, sizeof(old_opts));
-	clear_mount_options(sbi->options);
-	memset(sbi->options, 0, sizeof(old_opts));
+	struct ntfs_mount_options *new_opts = fc->fs_private;
+	int ro_rw;
 
-	err = ntfs_parse_options(sb, data, 0, sbi->options);
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
+		return -EINVAL;
+	}
+
+	new_opts->nls = ntfs_load_nls(new_opts->nls_name);
+	if (IS_ERR(new_opts->nls)) {
+		new_opts->nls = NULL;
+		errorf(fc, "ntfs3: Cannot load nls %s", new_opts->nls_name);
+		return -EINVAL;
 	}
+	if (new_opts->nls != sbi->options->nls)
+		return invalf(fc, "ntfs3: Cannot use different nls when remounting!");
 
 	sync_filesystem(sb);
 
 	if (ro_rw && (sbi->volume.flags & VOLUME_FLAG_DIRTY) &&
-	    !sbi->options->force) {
-		ntfs_warn(sb, "volume is dirty and \"force\" flag is not set!");
-		err = -EINVAL;
-		goto restore_opts;
+	    !new_opts->force) {
+		errorf(fc, "ntfs3: Volume is dirty and \"force\" flag is not set!");
+		return -EINVAL;
 	}
 
-	clear_mount_options(&old_opts);
-
-	ntfs_info(sb, "re-mounted. Opts: %s", orig_data);
-	err = 0;
-	goto out;
-
-restore_opts:
-	clear_mount_options(sbi->options);
-	memcpy(sbi->options, &old_opts, sizeof(old_opts));
+	memcpy(sbi->options, new_opts, sizeof(*new_opts));
 
-out:
-	kfree(orig_data);
-	return err;
+	return 0;
 }
 
 static struct kmem_cache *ntfs_inode_cachep;
@@ -494,9 +466,6 @@ static noinline void put_ntfs(struct ntfs_sb_info *sbi)
 	xpress_free_decompressor(sbi->compress.xpress);
 	lzx_free_decompressor(sbi->compress.lzx);
 #endif
-	clear_mount_options(sbi->options);
-	kfree(sbi->options);
-
 	kfree(sbi);
 }
 
@@ -507,7 +476,9 @@ static void ntfs_put_super(struct super_block *sb)
 	/*mark rw ntfs as clear, if possible*/
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
 
+	put_mount_options(sbi->options);
 	put_ntfs(sbi);
+	sb->s_fs_info = NULL;
 
 	sync_blockdev(sb->s_bdev);
 }
@@ -621,7 +592,6 @@ static const struct super_operations ntfs_sops = {
 	.statfs = ntfs_statfs,
 	.show_options = ntfs_show_options,
 	.sync_fs = ntfs_sync_fs,
-	.remount_fs = ntfs_remount,
 	.write_inode = ntfs3_write_inode,
 };
 
@@ -885,10 +855,10 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
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
@@ -907,17 +877,6 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	ref.high = 0;
 
-	sbi = kzalloc(sizeof(struct ntfs_sb_info), GFP_NOFS);
-	if (!sbi)
-		return -ENOMEM;
-
-	sbi->options = kzalloc(sizeof(struct ntfs_mount_options), GFP_NOFS);
-	if (!sbi->options) {
-		kfree(sbi);
-		return -ENOMEM;
-	}
-
-	sb->s_fs_info = sbi;
 	sbi->sb = sb;
 	sb->s_flags |= SB_NODIRATIME;
 	sb->s_magic = 0x7366746e; // "ntfs"
@@ -929,9 +888,12 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	ratelimit_state_init(&sbi->msg_ratelimit, DEFAULT_RATELIMIT_INTERVAL,
 			     DEFAULT_RATELIMIT_BURST);
 
-	err = ntfs_parse_options(sb, data, silent, sbi->options);
-	if (err)
-		goto out;
+	sbi->options->nls = ntfs_load_nls(sbi->options->nls_name);
+	if (IS_ERR(sbi->options->nls)) {
+		sbi->options->nls = NULL;
+		errorf(fc, "Cannot load nls %s", sbi->options->nls_name);
+		return -EINVAL;
+	}
 
 	if (!rq || !blk_queue_discard(rq) || !rq->limits.discard_granularity) {
 		;
@@ -1324,6 +1286,9 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 		goto out;
 	}
 
+	fc->fs_private = NULL;
+	fc->s_fs_info = NULL;
+
 	return 0;
 
 out:
@@ -1334,9 +1299,6 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 		sb->s_root = NULL;
 	}
 
-	put_ntfs(sbi);
-
-	sb->s_fs_info = NULL;
 	return err;
 }
 
@@ -1408,19 +1370,79 @@ int ntfs_discard(struct ntfs_sb_info *sbi, CLST lcn, CLST len)
 	return err;
 }
 
-static struct dentry *ntfs_mount(struct file_system_type *fs_type, int flags,
-				 const char *dev_name, void *data)
+static int ntfs_fs_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, ntfs_fill_super);
+}
+
+/*
+ * Note that this will be called after fill_super and reconfigure
+ * even when they pass. So they have to take pointers if they pass.
+ */
+static void ntfs_fs_free(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, ntfs_fill_super);
+	struct ntfs_mount_options *opts = fc->fs_private;
+	struct ntfs_sb_info *sbi = fc->s_fs_info;
+
+	if (sbi)
+		put_ntfs(sbi);
+
+	if (opts)
+		put_mount_options(opts);
+}
+
+static const struct fs_context_operations ntfs_context_ops = {
+	.parse_param	= ntfs_fs_parse_param,
+	.get_tree	= ntfs_fs_get_tree,
+	.reconfigure	= ntfs_fs_reconfigure,
+	.free		= ntfs_fs_free,
+};
+
+/*
+ * This will called when mount/remount. We will first initiliaze
+ * options so that if remount we can use just that.
+ */
+static int ntfs_init_fs_context(struct fs_context *fc)
+{
+	struct ntfs_mount_options *opts;
+	struct ntfs_sb_info *sbi;
+
+	opts = kzalloc(sizeof(struct ntfs_mount_options), GFP_NOFS);
+	if (!opts)
+		return -ENOMEM;
+
+	/* Default options. */
+	opts->fs_uid = current_uid();
+	opts->fs_gid = current_gid();
+	opts->fs_fmask_inv = ~current_umask();
+	opts->fs_dmask_inv = ~current_umask();
+
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
+		goto ok;
+
+	sbi = kzalloc(sizeof(struct ntfs_sb_info), GFP_NOFS);
+	if (!sbi) {
+		kfree(opts);
+		return -ENOMEM;
+	}
+
+	sbi->options = opts;
+	fc->s_fs_info = sbi;
+ok:
+	fc->fs_private = opts;
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

