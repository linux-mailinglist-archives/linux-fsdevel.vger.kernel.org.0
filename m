Return-Path: <linux-fsdevel+bounces-24842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9C0945602
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 03:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DAA28623C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 01:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865F4D29E;
	Fri,  2 Aug 2024 01:33:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E517C68;
	Fri,  2 Aug 2024 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562408; cv=none; b=XP6AuM1V5QCKMwrMPCrRueEKzsrmuuHDijsGfsZJ0cED9lRMdf2PC+NvX84l3+YcdDQ14owSzU38Hii6XZfPz5NQKqqGrNtlSHNjXAGe9imnVxRDfMjhWk9/Fy0mhyV4Er/VNneJk8PSOakxCYp43+AVP4lME7majOGmWJemfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562408; c=relaxed/simple;
	bh=G6Tpqay0idHyaRgKJ8AaDU7Ry5dQM+9M8L+tr3YSLi0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eK1nzJbSO6raTQMv8dEZ9Sz05n8Xqy1htELllWK3BfPsITxld4HwijO/U1WYC0F0cUL4ueJcNBcvFr6e0JLyPOwaWPHj/58R645bDQkR/GfaIo31AfD2XlASCVOBMA4jigWOLQMBBilTm25r+uu8/uFEzIc6uHmjXCrYMcZgr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WZpFt4r3RzfZ79;
	Fri,  2 Aug 2024 09:31:30 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id E98F618005F;
	Fri,  2 Aug 2024 09:33:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 2 Aug
 2024 09:33:21 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <dushistov@mail.ru>, <brauner@kernel.org>
CC: <lizetao1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: [PATCH] fs: ufs: convert to use the new mount API
Date: Fri, 2 Aug 2024 09:39:23 +0800
Message-ID: <20240802013923.2122600-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Convert ufs to use the new mount API.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/ufs/super.c | 300 +++++++++++++++++++++++--------------------------
 fs/ufs/ufs.h   |   2 +-
 2 files changed, 143 insertions(+), 159 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index bc625788589c..738778cf933c 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -83,11 +83,12 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/init.h>
-#include <linux/parser.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
 #include <linux/log2.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/seq_file.h>
 #include <linux/iversion.h>
 
@@ -342,125 +343,31 @@ void ufs_warning (struct super_block * sb, const char * function,
 	va_end(args);
 }
 
-enum {
-       Opt_type_old = UFS_MOUNT_UFSTYPE_OLD,
-       Opt_type_sunx86 = UFS_MOUNT_UFSTYPE_SUNx86,
-       Opt_type_sun = UFS_MOUNT_UFSTYPE_SUN,
-       Opt_type_sunos = UFS_MOUNT_UFSTYPE_SUNOS,
-       Opt_type_44bsd = UFS_MOUNT_UFSTYPE_44BSD,
-       Opt_type_ufs2 = UFS_MOUNT_UFSTYPE_UFS2,
-       Opt_type_hp = UFS_MOUNT_UFSTYPE_HP,
-       Opt_type_nextstepcd = UFS_MOUNT_UFSTYPE_NEXTSTEP_CD,
-       Opt_type_nextstep = UFS_MOUNT_UFSTYPE_NEXTSTEP,
-       Opt_type_openstep = UFS_MOUNT_UFSTYPE_OPENSTEP,
-       Opt_onerror_panic = UFS_MOUNT_ONERROR_PANIC,
-       Opt_onerror_lock = UFS_MOUNT_ONERROR_LOCK,
-       Opt_onerror_umount = UFS_MOUNT_ONERROR_UMOUNT,
-       Opt_onerror_repair = UFS_MOUNT_ONERROR_REPAIR,
-       Opt_err
+struct ufs_fs_context {
+	unsigned int s_mount_opt;
 };
 
-static const match_table_t tokens = {
-	{Opt_type_old, "ufstype=old"},
-	{Opt_type_sunx86, "ufstype=sunx86"},
-	{Opt_type_sun, "ufstype=sun"},
-	{Opt_type_sunos, "ufstype=sunos"},
-	{Opt_type_44bsd, "ufstype=44bsd"},
-	{Opt_type_ufs2, "ufstype=ufs2"},
-	{Opt_type_ufs2, "ufstype=5xbsd"},
-	{Opt_type_hp, "ufstype=hp"},
-	{Opt_type_nextstepcd, "ufstype=nextstep-cd"},
-	{Opt_type_nextstep, "ufstype=nextstep"},
-	{Opt_type_openstep, "ufstype=openstep"},
-/*end of possible ufs types */
-	{Opt_onerror_panic, "onerror=panic"},
-	{Opt_onerror_lock, "onerror=lock"},
-	{Opt_onerror_umount, "onerror=umount"},
-	{Opt_onerror_repair, "onerror=repair"},
-	{Opt_err, NULL}
+static const struct constant_table ufs_param_type[] = {
+	{"old",		UFS_MOUNT_UFSTYPE_OLD},
+	{"sunx86",	UFS_MOUNT_UFSTYPE_SUNx86},
+	{"sun",		UFS_MOUNT_UFSTYPE_SUN},
+	{"sunos",	UFS_MOUNT_UFSTYPE_SUNOS},
+	{"44bsd",	UFS_MOUNT_UFSTYPE_44BSD},
+	{"ufs2",	UFS_MOUNT_UFSTYPE_UFS2},
+	{"5xbsd",	UFS_MOUNT_UFSTYPE_UFS2},
+	{"hp",		UFS_MOUNT_UFSTYPE_HP},
+	{"nextstep-cd",	UFS_MOUNT_UFSTYPE_NEXTSTEP_CD},
+	{"openstep",	UFS_MOUNT_UFSTYPE_NEXTSTEP},
+	{}
 };
 
-static int ufs_parse_options (char * options, unsigned * mount_options)
-{
-	char * p;
-	
-	UFSD("ENTER\n");
-	
-	if (!options)
-		return 1;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		substring_t args[MAX_OPT_ARGS];
-		int token;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_type_old:
-			ufs_clear_opt (*mount_options, UFSTYPE);
-			ufs_set_opt (*mount_options, UFSTYPE_OLD);
-			break;
-		case Opt_type_sunx86:
-			ufs_clear_opt (*mount_options, UFSTYPE);
-			ufs_set_opt (*mount_options, UFSTYPE_SUNx86);
-			break;
-		case Opt_type_sun:
-			ufs_clear_opt (*mount_options, UFSTYPE);
-			ufs_set_opt (*mount_options, UFSTYPE_SUN);
-			break;
-		case Opt_type_sunos:
-			ufs_clear_opt(*mount_options, UFSTYPE);
-			ufs_set_opt(*mount_options, UFSTYPE_SUNOS);
-			break;
-		case Opt_type_44bsd:
-			ufs_clear_opt (*mount_options, UFSTYPE);
-			ufs_set_opt (*mount_options, UFSTYPE_44BSD);
-			break;
-		case Opt_type_ufs2:
-			ufs_clear_opt(*mount_options, UFSTYPE);
-			ufs_set_opt(*mount_options, UFSTYPE_UFS2);
-			break;
-		case Opt_type_hp:
-			ufs_clear_opt (*mount_options, UFSTYPE);
-			ufs_set_opt (*mount_options, UFSTYPE_HP);
-			break;
-		case Opt_type_nextstepcd:
-			ufs_clear_opt (*mount_options, UFSTYPE);
-			ufs_set_opt (*mount_options, UFSTYPE_NEXTSTEP_CD);
-			break;
-		case Opt_type_nextstep:
-			ufs_clear_opt (*mount_options, UFSTYPE);
-			ufs_set_opt (*mount_options, UFSTYPE_NEXTSTEP);
-			break;
-		case Opt_type_openstep:
-			ufs_clear_opt (*mount_options, UFSTYPE);
-			ufs_set_opt (*mount_options, UFSTYPE_OPENSTEP);
-			break;
-		case Opt_onerror_panic:
-			ufs_clear_opt (*mount_options, ONERROR);
-			ufs_set_opt (*mount_options, ONERROR_PANIC);
-			break;
-		case Opt_onerror_lock:
-			ufs_clear_opt (*mount_options, ONERROR);
-			ufs_set_opt (*mount_options, ONERROR_LOCK);
-			break;
-		case Opt_onerror_umount:
-			ufs_clear_opt (*mount_options, ONERROR);
-			ufs_set_opt (*mount_options, ONERROR_UMOUNT);
-			break;
-		case Opt_onerror_repair:
-			pr_err("Unable to do repair on error, will lock lock instead\n");
-			ufs_clear_opt (*mount_options, ONERROR);
-			ufs_set_opt (*mount_options, ONERROR_REPAIR);
-			break;
-		default:
-			pr_err("Invalid option: \"%s\" or missing value\n", p);
-			return 0;
-		}
-	}
-	return 1;
-}
+static const struct constant_table ufs_param_onerror[] = {
+	{"panic",	UFS_MOUNT_ONERROR_PANIC},
+	{"lock",	UFS_MOUNT_ONERROR_LOCK},
+	{"umount",	UFS_MOUNT_ONERROR_UMOUNT},
+	{"repair",	UFS_MOUNT_ONERROR_REPAIR},
+	{}
+};
 
 /*
  * Different types of UFS hold fs_cstotal in different
@@ -775,7 +682,7 @@ static u64 ufs_max_bytes(struct super_block *sb)
 	return res << uspi->s_bshift;
 }
 
-static int ufs_fill_super(struct super_block *sb, void *data, int silent)
+static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ufs_sb_info * sbi;
 	struct ufs_sb_private_info * uspi;
@@ -783,8 +690,10 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	struct ufs_super_block_second * usb2;
 	struct ufs_super_block_third * usb3;
 	struct ufs_buffer_head * ubh;	
+	struct ufs_fs_context *ctx;
 	struct inode *inode;
 	unsigned block_size, super_block_size;
+	int silent = fc->sb_flags & SB_SILENT;
 	unsigned flags;
 	unsigned super_block_offset;
 	unsigned maxsymlen;
@@ -806,7 +715,9 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi = kzalloc(sizeof(struct ufs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		goto failed_nomem;
+	ctx = fc->fs_private;
 	sb->s_fs_info = sbi;
+	fc->s_fs_info = sbi;
 	sbi->sb = sb;
 
 	UFSD("flag %u\n", (int)(sb_rdonly(sb)));
@@ -815,15 +726,9 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	spin_lock_init(&sbi->work_lock);
 	INIT_DELAYED_WORK(&sbi->sync_work, delayed_sync_fs);
 	/*
-	 * Set default mount options
-	 * Parse mount options
+	 * The mount parameters have been parsed by the new mount framework
 	 */
-	sbi->s_mount_opt = 0;
-	ufs_set_opt (sbi->s_mount_opt, ONERROR_LOCK);
-	if (!ufs_parse_options ((char *) data, &sbi->s_mount_opt)) {
-		pr_err("wrong mount options\n");
-		goto failed;
-	}
+	sbi->s_mount_opt = ctx->s_mount_opt;
 	if (!(sbi->s_mount_opt & UFS_MOUNT_UFSTYPE)) {
 		if (!silent)
 			pr_err("You didn't specify the type of your ufs filesystem\n\n"
@@ -1297,6 +1202,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	kfree (uspi);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
+	fc->s_fs_info = NULL;
 	UFSD("EXIT (FAILED)\n");
 	return ret;
 
@@ -1305,14 +1211,17 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	return -ENOMEM;
 }
 
-static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
+static int ufs_reconfigure(struct fs_context *fc)
 {
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
 	struct ufs_super_block_third * usb3;
 	unsigned new_mount_opt, ufstype;
+	struct ufs_fs_context *ctx;
+	struct super_block *sb;
 	unsigned flags;
 
+	sb = fc->root->d_sb;
 	sync_filesystem(sb);
 	mutex_lock(&UFS_SB(sb)->s_lock);
 	uspi = UFS_SB(sb)->s_uspi;
@@ -1325,12 +1234,8 @@ static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
 	 * It is not possible to change ufstype option during remount
 	 */
 	ufstype = UFS_SB(sb)->s_mount_opt & UFS_MOUNT_UFSTYPE;
-	new_mount_opt = 0;
-	ufs_set_opt (new_mount_opt, ONERROR_LOCK);
-	if (!ufs_parse_options (data, &new_mount_opt)) {
-		mutex_unlock(&UFS_SB(sb)->s_lock);
-		return -EINVAL;
-	}
+	ctx = fc->fs_private;
+	new_mount_opt = ctx->s_mount_opt;
 	if (!(new_mount_opt & UFS_MOUNT_UFSTYPE)) {
 		new_mount_opt |= ufstype;
 	} else if ((new_mount_opt & UFS_MOUNT_UFSTYPE) != ufstype) {
@@ -1339,16 +1244,13 @@ static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
 		return -EINVAL;
 	}
 
-	if ((bool)(*mount_flags & SB_RDONLY) == sb_rdonly(sb)) {
-		UFS_SB(sb)->s_mount_opt = new_mount_opt;
-		mutex_unlock(&UFS_SB(sb)->s_lock);
-		return 0;
-	}
-	
+	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
+		goto set_new_mount_opt;
+
 	/*
 	 * fs was mouted as rw, remounting ro
 	 */
-	if (*mount_flags & SB_RDONLY) {
+	if (fc->sb_flags & SB_RDONLY) {
 		ufs_put_super_internal(sb);
 		usb1->fs_time = ufs_get_seconds(sb);
 		if ((flags & UFS_ST_MASK) == UFS_ST_SUN
@@ -1384,6 +1286,10 @@ static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
 		sb->s_flags &= ~SB_RDONLY;
 #endif
 	}
+
+set_new_mount_opt:
+	if (ctx->s_mount_opt != new_mount_opt)
+		ctx->s_mount_opt = new_mount_opt;
 	UFS_SB(sb)->s_mount_opt = new_mount_opt;
 	mutex_unlock(&UFS_SB(sb)->s_lock);
 	return 0;
@@ -1392,19 +1298,26 @@ static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
 static int ufs_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct ufs_sb_info *sbi = UFS_SB(root->d_sb);
-	unsigned mval = sbi->s_mount_opt & UFS_MOUNT_UFSTYPE;
-	const struct match_token *tp = tokens;
+	const struct constant_table *param;
+	unsigned int mval;
 
-	while (tp->token != Opt_onerror_panic && tp->token != mval)
-		++tp;
-	BUG_ON(tp->token == Opt_onerror_panic);
-	seq_printf(seq, ",%s", tp->pattern);
+	mval = sbi->s_mount_opt & UFS_MOUNT_UFSTYPE;
+	for (param = ufs_param_type; !param->name; param++) {
+		if (param->value == mval) {
+			seq_printf(seq, ",ufstype=%s", param->name);
+			break;
+		}
+	}
+	WARN_ON_ONCE(param->name == NULL);
 
 	mval = sbi->s_mount_opt & UFS_MOUNT_ONERROR;
-	while (tp->token != Opt_err && tp->token != mval)
-		++tp;
-	BUG_ON(tp->token == Opt_err);
-	seq_printf(seq, ",%s", tp->pattern);
+	for (param = ufs_param_onerror; !param->name; param++) {
+		if (param->value == mval) {
+			seq_printf(seq, ",onerror=%s", param->name);
+			break;
+		}
+	}
+	WARN_ON_ONCE(param->name == NULL);
 
 	return 0;
 }
@@ -1498,22 +1411,93 @@ static const struct super_operations ufs_super_ops = {
 	.put_super	= ufs_put_super,
 	.sync_fs	= ufs_sync_fs,
 	.statfs		= ufs_statfs,
-	.remount_fs	= ufs_remount,
 	.show_options   = ufs_show_options,
 };
 
-static struct dentry *ufs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+enum {
+	Opt_type,
+	Opt_onerror,
+};
+
+static const struct fs_parameter_spec ufs_param_spec[] = {
+	fsparam_enum("ufstype", Opt_type, ufs_param_type),
+	/*end of possible ufs types */
+	fsparam_enum("onerror", Opt_onerror, ufs_param_onerror),
+	{}
+};
+
+static int ufs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, ufs_fill_super);
+	struct ufs_fs_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, ufs_param_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_type:
+		ufs_clear_opt(ctx->s_mount_opt, UFSTYPE);
+		ctx->s_mount_opt |= result.uint_32;
+		break;
+
+	case Opt_onerror:
+		if (result.uint_32 == UFS_MOUNT_ONERROR_REPAIR)
+			pr_err("Unable to do repair on error, will lock instead\n");
+		ufs_clear_opt(ctx->s_mount_opt, ONERROR);
+		ctx->s_mount_opt |= result.uint_32;
+		break;
+
+	default:
+		pr_err("Invalid option: \"%s\" or missing value\n", param->key);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ufs_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, ufs_fill_super);
+}
+
+static void ufs_free_fc(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
+static const struct fs_context_operations ufs_context_ops = {
+	.parse_param	= ufs_parse_param,
+	.get_tree	= ufs_get_tree,
+	.reconfigure	= ufs_reconfigure,
+	.free		= ufs_free_fc,
+};
+
+static int ufs_init_fs_context(struct fs_context *fc)
+{
+	struct ufs_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (unlikely(!ctx))
+		return -ENOMEM;
+
+	/*
+	 * Set default mount options
+	 */
+	ufs_set_opt(ctx->s_mount_opt, ONERROR_LOCK);
+	fc->fs_private = ctx;
+	fc->ops = &ufs_context_ops;
+	return 0;
 }
 
 static struct file_system_type ufs_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "ufs",
-	.mount		= ufs_mount,
-	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.owner		 = THIS_MODULE,
+	.name		 = "ufs",
+	.init_fs_context = ufs_init_fs_context,
+	.parameters	 = ufs_param_spec,
+	.kill_sb	 = kill_block_super,
+	.fs_flags	 = FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ufs");
 
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index 6b499180643b..e94a52c9c7da 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -24,7 +24,7 @@ struct ufs_sb_info {
 	struct ufs_cg_private_info * s_ucpi[UFS_MAX_GROUP_LOADED];
 	unsigned s_cgno[UFS_MAX_GROUP_LOADED];
 	unsigned short s_cg_loaded;
-	unsigned s_mount_opt;
+	unsigned int s_mount_opt;
 	struct super_block *sb;
 	int work_queued; /* non-zero if the delayed work is queued */
 	struct delayed_work sync_work; /* FS sync delayed work */
-- 
2.34.1


