Return-Path: <linux-fsdevel+bounces-31335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CAD994C55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507871C21578
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334631DEFE6;
	Tue,  8 Oct 2024 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imCjydxU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B101DE3A3
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391975; cv=none; b=mV9Tg691/ad6GFNfTfOIUlkQhEmwqkxwT9f5xr/jQuaJi/nxm2oYT6zjmd565XfR/DjOZkeK9xqlZdG17ipQ+bF6KDPAu2aM4JswflyzYwnrgd7gSj15buHzUX444NdNkWeNkdf78moJYmGLLxxP9pLliqB85xu798o3+fg0Fdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391975; c=relaxed/simple;
	bh=uxf8U3EZDOxAdDBoEr7C1w93PuTqQAyoGDyGNDO+G1Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BHXJmax3PyVOlvdVmQzkFN1u4ssLhTVEJ7+qpPkhaCQR44SZV2bD1IvZR4zqkQBfQaXkxXrF2UvTK8ZHgH/QWgHrims/wJjgBKDgxDwTVEwnQwPZI/qzaJkTAPPCSxPe2XYg8ubR57P29x3/xFvnvxcMzWWoGh+DcP8zQbGfUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imCjydxU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728391972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g753v0yhlhkzXHZsTX/jO6mJR5g9N4z6zR2aWIfQMVQ=;
	b=imCjydxUW/t6KCvlPPzm3u07PLGDx2mX25WIHor8xeiZaokon4Hulm++8FBWS0xpOgIe1z
	IYL/AY7f2SRPdVHrb+zZGq+U9UJAdJPh3GresBoFsnRr4kwYuBGMCzaHpZwM63ICIZ68fR
	f32zOKBxMDTdL6xCC77UtpWmXm93nuE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-tAAVZqOfPo-DUx5gY0rilA-1; Tue, 08 Oct 2024 08:52:51 -0400
X-MC-Unique: tAAVZqOfPo-DUx5gY0rilA-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cd83f0b2eso590923139f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 05:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728391971; x=1728996771;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g753v0yhlhkzXHZsTX/jO6mJR5g9N4z6zR2aWIfQMVQ=;
        b=q0uS2Ws1zcZWWpbSmUbsMgsvQRNxyu+rXBMWe3oXxIrTtgPfPPiGdWfnj40UstXBuu
         mmYprUlvRKHvG+rsNWoePuyXA2X/uJ+L2prVbf9E/iv9FjCM5DVirNjgr0JncpRMRfHc
         UlGGctwMg4hY5QNuheiSKwlRWIvDfTbZ4g++Sjc3mjG/m9r2gmLB97T8DsMPULcT5mpa
         261HuJETtaaq0ma3LBtUAsrDLhPPu0OGcF1EKLbumw1vI5j7L221iEylaiJ0Bi0t823U
         6UlTvzLb+bEZte8gDsGrt8J0UnhQJBlX3TCjAVIqoASG2Q+KtVW/j4wtnsiTZ7A4psLz
         Wohw==
X-Gm-Message-State: AOJu0Yykbe55UX7To7mDX3GgvYWoGtxMk2NcFAORIPhbHLm+G9KDVGiK
	NZfvzC0+krmTX7UebhO+m2U7qx7UtRpeJmZj60rPpn299ADDnvdWABtYqeM0/na7p6OIIeRIR2e
	go9Q1eqor8vy7utv0Pt0e4VzhHUCbzM3z+DP0zcmeNdNk2Ixgmh2jFSkPYsaOmNW2KeMx2viR52
	rbP0o+lFMW6Ylj/AbxTZqTOr4JtEnhN07GnjuYGXcJzGaJfct8
X-Received: by 2002:a05:6602:48c:b0:82d:2a45:79f6 with SMTP id ca18e2360f4ac-834f7d65548mr1672917539f.11.1728391970524;
        Tue, 08 Oct 2024 05:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPDAlqARkzrAYMYAkAaxOg1y0yLw7FZ2b10zB5utaXzQlrZpUnwqlAAxYfqfJtqK65R3WAlA==
X-Received: by 2002:a05:6602:48c:b0:82d:2a45:79f6 with SMTP id ca18e2360f4ac-834f7d65548mr1672912439f.11.1728391969991;
        Tue, 08 Oct 2024 05:52:49 -0700 (PDT)
Received: from [10.0.0.71] (67-4-202-127.mpls.qwest.net. [67.4.202.127])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503a92f70sm174584139f.13.2024.10.08.05.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 05:52:49 -0700 (PDT)
Message-ID: <66accd3d-b293-4aeb-abdf-483a7d17b963@redhat.com>
Date: Tue, 8 Oct 2024 07:52:48 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V2] hfs: convert hfs to use the new mount api
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert the hfs filesystem to use the new mount API.
Tested by comparing random mount & remount options before and after
the change, and trivial I/O tests.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

V2: attach sb to sbi (sbi->sb = sb) in fill_super as before

Brown paper bag time, I really only tested mount/unmount, and because
I had forgotten to attach sb back to sbi (sbi->sb = sb) in fill_super(),
actual IO failed in flush_mdb() as reported by syzbot at
https://lore.kernel.org/all/6700d799.050a0220.49194.04b3.GAE@google.com/T/

Really sorry about that. Since it's a small functional change, I removed
Jan's RVB for V2. 

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index eeac99765f0d..3bee9b5dba5e 100644
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
@@ -376,29 +310,25 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
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
+	sbi->sb = sb;
 	sb->s_op = &hfs_super_operations;
 	sb->s_xattr = hfs_xattr_handlers;
 	sb->s_flags |= SB_NODIRATIME;
@@ -451,18 +381,56 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
 	return res;
 }
 
-static struct dentry *hfs_mount(struct file_system_type *fs_type,
-		      int flags, const char *dev_name, void *data)
+static int hfs_get_tree(struct fs_context *fc)
+{
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
 {
-	return mount_bdev(fs_type, flags, dev_name, data, hfs_fill_super);
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
 



