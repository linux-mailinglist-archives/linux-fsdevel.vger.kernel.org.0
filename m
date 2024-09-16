Return-Path: <linux-fsdevel+bounces-29523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006CD97A6B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 19:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC0B1F285A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E3115C123;
	Mon, 16 Sep 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFxklthV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343EC15B548
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507501; cv=none; b=T2FbUtfUJfFUkoJ5iqE62InhFYPWQB6PMUloeqnWzKPI+2q64ghR5N6OwET5jQEDNC1QmGeAqRUxI44/TNk+WsMz5pOU7dZC+3A8B1BKHZmFueQac6EzhHo7MnN6aiGfTWycAr66LnCV1VEvYnMl4wYugHfcVWV9J+Lb8WOOkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507501; c=relaxed/simple;
	bh=egAzxbRiUeyTphbm2kmTPLUDKN2CmPW6Vbvz23ZROTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDgEAKYCNKkX3BU1ZvpjDSGKTaXBOWXym2N5G8mYL7kDYEr3gwDwMArcmfVC47lEn4iS5R0VltYa4TecRi3rPKRT9WlFx+bTomBoDG/oKsNImKIXsyTZKTF8Jlb2LNjHsNLv1walN80z+ed9uUAJY7lt5TX2lQs0PMnCCYlheN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFxklthV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726507498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5tPvEKAQ6yVLsuESavAfyWUYl7cBbr1QNanORAGr0Q=;
	b=WFxklthVOmw42OWX/WtmGn7iocM32AppVIbI9PCd5pGBz+uiaZWu/pq8JHRuwmlFivYFa6
	IeEDU7Bi4EG1v43pzt2y70t7OJA0NRu3fCcPJs30TRVMXGHAYsYRA+9e8o7LT4yxB+9wY5
	wWdQSNpFKlDbqtP4J9RkKrQKgcuRaDU=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-zPx9NnlIP5699wQI4mIb0Q-1; Mon, 16 Sep 2024 13:24:57 -0400
X-MC-Unique: zPx9NnlIP5699wQI4mIb0Q-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cf30e0092so578038339f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 10:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726507496; x=1727112296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5tPvEKAQ6yVLsuESavAfyWUYl7cBbr1QNanORAGr0Q=;
        b=LXPMobsGJo7544leTNSyPOOPkuepYGg3GgM52Ghqjhqp+tfDPsfsVI321ACQz2c7W9
         hUlIsrjmHUdcpRcm/Vy2XNoAVXYuyrA+aYE+wgMTZnaEfT6hfWIH9ZPoWzAPHnWkoj9b
         AzW94TYSlmkuG90DDnL7KdY04W8rKtCybDBN14U/0E6vA70KL5v5iU7g/4ky/15Rsyc5
         GYjFolmcwY38+ctoIKrAE+X3lsGGYnTo1Qj0zjcierZbBo8sVZvjXRvn2fV+tzUGx+pI
         QT/LGCmypdGnojvS/Fs+Bbzg9aRhJE5sFv7fMlR4Nl2u7d6NAMWZCHiZKalSkqHpAWnj
         ZAzg==
X-Gm-Message-State: AOJu0YwXJx+A1UpQ3GLFVVBvTfmA9/tN3ikqLgYFd1zjOPIB35WmW9Db
	tAZJ+s0ht5Xpnzoq+wR6Tv7EsehgU61UBr1LobJ+nfDo+wOALafOkVcWFZ9ZSX6iH1ySTWvTyn1
	m0Su7Ho590GbnEZrpgZMN8/+hhEfDkO5tvMxM0UcdSKimR/Z5quU/9dpdLgLR4Oj4Jmpjq4dcO4
	IYO9tOpI2267f3SN2VpGHP8GOXd1O0ynGdFvEDF2sRB2AOfg==
X-Received: by 2002:a05:6602:168a:b0:82d:18d:bab with SMTP id ca18e2360f4ac-82d37842cb3mr1247660039f.15.1726507496127;
        Mon, 16 Sep 2024 10:24:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmfBafdazvfIPXIczBek7SkReT+90d6molqx8wnp00GvEBG1d6/ZtqjXiqtoj1qbegrPccRQ==
X-Received: by 2002:a05:6602:168a:b0:82d:18d:bab with SMTP id ca18e2360f4ac-82d37842cb3mr1247655839f.15.1726507495599;
        Mon, 16 Sep 2024 10:24:55 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net (67-4-202-127.mpls.qwest.net. [67.4.202.127])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed190a2sm1610876173.89.2024.09.16.10.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 10:24:55 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 4/5] hfs: convert hfs to use the new mount api
Date: Mon, 16 Sep 2024 13:26:21 -0400
Message-ID: <20240916172735.866916-5-sandeen@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916172735.866916-1-sandeen@redhat.com>
References: <20240916172735.866916-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the hfs filesystem to use the new mount API.
Tested by comparing random mount & remount options before and after
the change.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/hfs/super.c | 341 ++++++++++++++++++++++---------------------------
 1 file changed, 154 insertions(+), 187 deletions(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index eeac99765f0d..ee314f3e39f8 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -15,10 +15,11 @@
 #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/mount.h>
 #include <linux/init.h>
 #include <linux/nls.h>
-#include <linux/parser.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/vfs.h>
@@ -111,21 +112,24 @@ static int hfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-static int hfs_remount(struct super_block *sb, int *flags, char *data)
+static int hfs_reconfigure(struct fs_context *fc)
 {
+	struct super_block *sb = fc->root->d_sb;
+
 	sync_filesystem(sb);
-	*flags |= SB_NODIRATIME;
-	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
+	fc->sb_flags |= SB_NODIRATIME;
+	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
 		return 0;
-	if (!(*flags & SB_RDONLY)) {
+
+	if (!(fc->sb_flags & SB_RDONLY)) {
 		if (!(HFS_SB(sb)->mdb->drAtrb & cpu_to_be16(HFS_SB_ATTRIB_UNMNT))) {
 			pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is recommended.  leaving read-only.\n");
 			sb->s_flags |= SB_RDONLY;
-			*flags |= SB_RDONLY;
+			fc->sb_flags |= SB_RDONLY;
 		} else if (HFS_SB(sb)->mdb->drAtrb & cpu_to_be16(HFS_SB_ATTRIB_SLOCK)) {
 			pr_warn("filesystem is marked locked, leaving read-only.\n");
 			sb->s_flags |= SB_RDONLY;
-			*flags |= SB_RDONLY;
+			fc->sb_flags |= SB_RDONLY;
 		}
 	}
 	return 0;
@@ -180,7 +184,6 @@ static const struct super_operations hfs_super_operations = {
 	.put_super	= hfs_put_super,
 	.sync_fs	= hfs_sync_fs,
 	.statfs		= hfs_statfs,
-	.remount_fs     = hfs_remount,
 	.show_options	= hfs_show_options,
 };
 
@@ -188,181 +191,112 @@ enum {
 	opt_uid, opt_gid, opt_umask, opt_file_umask, opt_dir_umask,
 	opt_part, opt_session, opt_type, opt_creator, opt_quiet,
 	opt_codepage, opt_iocharset,
-	opt_err
 };
 
-static const match_table_t tokens = {
-	{ opt_uid, "uid=%u" },
-	{ opt_gid, "gid=%u" },
-	{ opt_umask, "umask=%o" },
-	{ opt_file_umask, "file_umask=%o" },
-	{ opt_dir_umask, "dir_umask=%o" },
-	{ opt_part, "part=%u" },
-	{ opt_session, "session=%u" },
-	{ opt_type, "type=%s" },
-	{ opt_creator, "creator=%s" },
-	{ opt_quiet, "quiet" },
-	{ opt_codepage, "codepage=%s" },
-	{ opt_iocharset, "iocharset=%s" },
-	{ opt_err, NULL }
+static const struct fs_parameter_spec hfs_param_spec[] = {
+	fsparam_u32	("uid",		opt_uid),
+	fsparam_u32	("gid",		opt_gid),
+	fsparam_u32oct	("umask",	opt_umask),
+	fsparam_u32oct	("file_umask",	opt_file_umask),
+	fsparam_u32oct	("dir_umask",	opt_dir_umask),
+	fsparam_u32	("part",	opt_part),
+	fsparam_u32	("session",	opt_session),
+	fsparam_string	("type",	opt_type),
+	fsparam_string	("creator",	opt_creator),
+	fsparam_flag	("quiet",	opt_quiet),
+	fsparam_string	("codepage",	opt_codepage),
+	fsparam_string	("iocharset",	opt_iocharset),
+	{}
 };
 
-static inline int match_fourchar(substring_t *arg, u32 *result)
-{
-	if (arg->to - arg->from != 4)
-		return -EINVAL;
-	memcpy(result, arg->from, 4);
-	return 0;
-}
-
 /*
- * parse_options()
+ * hfs_parse_param()
  *
- * adapted from linux/fs/msdos/inode.c written 1992,93 by Werner Almesberger
- * This function is called by hfs_read_super() to parse the mount options.
+ * This function is called by the vfs to parse the mount options.
  */
-static int parse_options(char *options, struct hfs_sb_info *hsb)
+static int hfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int tmp, token;
-
-	/* initialize the sb with defaults */
-	hsb->s_uid = current_uid();
-	hsb->s_gid = current_gid();
-	hsb->s_file_umask = 0133;
-	hsb->s_dir_umask = 0022;
-	hsb->s_type = hsb->s_creator = cpu_to_be32(0x3f3f3f3f);	/* == '????' */
-	hsb->s_quiet = 0;
-	hsb->part = -1;
-	hsb->session = -1;
-
-	if (!options)
-		return 1;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case opt_uid:
-			if (match_int(&args[0], &tmp)) {
-				pr_err("uid requires an argument\n");
-				return 0;
-			}
-			hsb->s_uid = make_kuid(current_user_ns(), (uid_t)tmp);
-			if (!uid_valid(hsb->s_uid)) {
-				pr_err("invalid uid %d\n", tmp);
-				return 0;
-			}
-			break;
-		case opt_gid:
-			if (match_int(&args[0], &tmp)) {
-				pr_err("gid requires an argument\n");
-				return 0;
-			}
-			hsb->s_gid = make_kgid(current_user_ns(), (gid_t)tmp);
-			if (!gid_valid(hsb->s_gid)) {
-				pr_err("invalid gid %d\n", tmp);
-				return 0;
-			}
-			break;
-		case opt_umask:
-			if (match_octal(&args[0], &tmp)) {
-				pr_err("umask requires a value\n");
-				return 0;
-			}
-			hsb->s_file_umask = (umode_t)tmp;
-			hsb->s_dir_umask = (umode_t)tmp;
-			break;
-		case opt_file_umask:
-			if (match_octal(&args[0], &tmp)) {
-				pr_err("file_umask requires a value\n");
-				return 0;
-			}
-			hsb->s_file_umask = (umode_t)tmp;
-			break;
-		case opt_dir_umask:
-			if (match_octal(&args[0], &tmp)) {
-				pr_err("dir_umask requires a value\n");
-				return 0;
-			}
-			hsb->s_dir_umask = (umode_t)tmp;
-			break;
-		case opt_part:
-			if (match_int(&args[0], &hsb->part)) {
-				pr_err("part requires an argument\n");
-				return 0;
-			}
-			break;
-		case opt_session:
-			if (match_int(&args[0], &hsb->session)) {
-				pr_err("session requires an argument\n");
-				return 0;
-			}
-			break;
-		case opt_type:
-			if (match_fourchar(&args[0], &hsb->s_type)) {
-				pr_err("type requires a 4 character value\n");
-				return 0;
-			}
-			break;
-		case opt_creator:
-			if (match_fourchar(&args[0], &hsb->s_creator)) {
-				pr_err("creator requires a 4 character value\n");
-				return 0;
-			}
-			break;
-		case opt_quiet:
-			hsb->s_quiet = 1;
-			break;
-		case opt_codepage:
-			if (hsb->nls_disk) {
-				pr_err("unable to change codepage\n");
-				return 0;
-			}
-			p = match_strdup(&args[0]);
-			if (p)
-				hsb->nls_disk = load_nls(p);
-			if (!hsb->nls_disk) {
-				pr_err("unable to load codepage \"%s\"\n", p);
-				kfree(p);
-				return 0;
-			}
-			kfree(p);
-			break;
-		case opt_iocharset:
-			if (hsb->nls_io) {
-				pr_err("unable to change iocharset\n");
-				return 0;
-			}
-			p = match_strdup(&args[0]);
-			if (p)
-				hsb->nls_io = load_nls(p);
-			if (!hsb->nls_io) {
-				pr_err("unable to load iocharset \"%s\"\n", p);
-				kfree(p);
-				return 0;
-			}
-			kfree(p);
-			break;
-		default:
-			return 0;
-		}
-	}
+	struct hfs_sb_info *hsb = fc->s_fs_info;
+	struct fs_parse_result result;
+	int opt;
+
+	/* hfs does not honor any fs-specific options on remount */
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
+		return 0;
 
-	if (hsb->nls_disk && !hsb->nls_io) {
-		hsb->nls_io = load_nls_default();
+	opt = fs_parse(fc, hfs_param_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case opt_uid:
+		hsb->s_uid = result.uid;
+		break;
+	case opt_gid:
+		hsb->s_gid = result.gid;
+		break;
+	case opt_umask:
+		hsb->s_file_umask = (umode_t)result.uint_32;
+		hsb->s_dir_umask = (umode_t)result.uint_32;
+		break;
+	case opt_file_umask:
+		hsb->s_file_umask = (umode_t)result.uint_32;
+		break;
+	case opt_dir_umask:
+		hsb->s_dir_umask = (umode_t)result.uint_32;
+		break;
+	case opt_part:
+		hsb->part = result.uint_32;
+		break;
+	case opt_session:
+		hsb->session = result.uint_32;
+		break;
+	case opt_type:
+		if (strlen(param->string) != 4) {
+			pr_err("type requires a 4 character value\n");
+			return -EINVAL;
+		}
+		memcpy(&hsb->s_type, param->string, 4);
+		break;
+	case opt_creator:
+		if (strlen(param->string) != 4) {
+			pr_err("creator requires a 4 character value\n");
+			return -EINVAL;
+		}
+		memcpy(&hsb->s_creator, param->string, 4);
+		break;
+	case opt_quiet:
+		hsb->s_quiet = 1;
+		break;
+	case opt_codepage:
+		if (hsb->nls_disk) {
+			pr_err("unable to change codepage\n");
+			return -EINVAL;
+		}
+		hsb->nls_disk = load_nls(param->string);
+		if (!hsb->nls_disk) {
+			pr_err("unable to load codepage \"%s\"\n",
+					param->string);
+			return -EINVAL;
+		}
+		break;
+	case opt_iocharset:
+		if (hsb->nls_io) {
+			pr_err("unable to change iocharset\n");
+			return -EINVAL;
+		}
+		hsb->nls_io = load_nls(param->string);
 		if (!hsb->nls_io) {
-			pr_err("unable to load default iocharset\n");
-			return 0;
+			pr_err("unable to load iocharset \"%s\"\n",
+					param->string);
+			return -EINVAL;
 		}
+		break;
+	default:
+		return -EINVAL;
 	}
-	hsb->s_dir_umask &= 0777;
-	hsb->s_file_umask &= 0577;
 
-	return 1;
+	return 0;
 }
 
 /*
@@ -376,29 +310,24 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
  * hfs_btree_init() to get the necessary data about the extents and
  * catalog B-trees and, finally, reading the root inode into memory.
  */
-static int hfs_fill_super(struct super_block *sb, void *data, int silent)
+static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct hfs_sb_info *sbi;
+	struct hfs_sb_info *sbi = HFS_SB(sb);
 	struct hfs_find_data fd;
 	hfs_cat_rec rec;
 	struct inode *root_inode;
+	int silent = fc->sb_flags & SB_SILENT;
 	int res;
 
-	sbi = kzalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
-	if (!sbi)
-		return -ENOMEM;
+	/* load_nls_default does not fail */
+	if (sbi->nls_disk && !sbi->nls_io)
+		sbi->nls_io = load_nls_default();
+	sbi->s_dir_umask &= 0777;
+	sbi->s_file_umask &= 0577;
 
-	sbi->sb = sb;
-	sb->s_fs_info = sbi;
 	spin_lock_init(&sbi->work_lock);
 	INIT_DELAYED_WORK(&sbi->mdb_work, flush_mdb);
 
-	res = -EINVAL;
-	if (!parse_options((char *)data, sbi)) {
-		pr_err("unable to parse mount options\n");
-		goto bail;
-	}
-
 	sb->s_op = &hfs_super_operations;
 	sb->s_xattr = hfs_xattr_handlers;
 	sb->s_flags |= SB_NODIRATIME;
@@ -451,18 +380,56 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
 	return res;
 }
 
-static struct dentry *hfs_mount(struct file_system_type *fs_type,
-		      int flags, const char *dev_name, void *data)
+static int hfs_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, hfs_fill_super);
+	return get_tree_bdev(fc, hfs_fill_super);
+}
+
+static void hfs_free_fc(struct fs_context *fc)
+{
+	kfree(fc->s_fs_info);
+}
+
+static const struct fs_context_operations hfs_context_ops = {
+	.parse_param	= hfs_parse_param,
+	.get_tree	= hfs_get_tree,
+	.reconfigure	= hfs_reconfigure,
+	.free		= hfs_free_fc,
+};
+
+static int hfs_init_fs_context(struct fs_context *fc)
+{
+	struct hfs_sb_info *hsb;
+
+	hsb = kzalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
+	if (!hsb)
+		return -ENOMEM;
+
+	fc->s_fs_info = hsb;
+	fc->ops = &hfs_context_ops;
+
+	if (fc->purpose != FS_CONTEXT_FOR_RECONFIGURE) {
+		/* initialize options with defaults */
+		hsb->s_uid = current_uid();
+		hsb->s_gid = current_gid();
+		hsb->s_file_umask = 0133;
+		hsb->s_dir_umask = 0022;
+		hsb->s_type = cpu_to_be32(0x3f3f3f3f); /* == '????' */
+		hsb->s_creator = cpu_to_be32(0x3f3f3f3f); /* == '????' */
+		hsb->s_quiet = 0;
+		hsb->part = -1;
+		hsb->session = -1;
+	}
+
+	return 0;
 }
 
 static struct file_system_type hfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfs",
-	.mount		= hfs_mount,
 	.kill_sb	= kill_block_super,
 	.fs_flags	= FS_REQUIRES_DEV,
+	.init_fs_context = hfs_init_fs_context,
 };
 MODULE_ALIAS_FS("hfs");
 
-- 
2.46.0


