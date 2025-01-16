Return-Path: <linux-fsdevel+bounces-39432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62638A141D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 19:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51D93A24D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F4C22D4ED;
	Thu, 16 Jan 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+cWSDIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5160E15530B
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737053434; cv=none; b=hrAJ6BW18bR3UxqdSCHVvN9uWWBl2EED9y7rktD7ms6z2j1iBQZyOtiCdEmJbckYLDwU71ajKFBxjqStTZ1UdU5MdG9lJZpDPsK4zcfY5LVDtAXMNe3VC2ts+3jUBNmND9R4iYY+T/uq5Mvuih8KOAFjR30CQQp51KJOKZtqxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737053434; c=relaxed/simple;
	bh=xdu+K0hLFIbZTJTx/t8J445AWI/Vk1shnHKMpwayCgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGPX8sm+x3SjZOJCqCZ+jOihnYLqXdNlX3O3qBF9Bv60tKpeVk+bwkiGcDU4+rkX+URBp0xwZXGn6IU2c/756PFqH37i5ehnMgXeT6djiVroxPlAZv6xqvuo+l6T96OdAYM0KqJIj+puNLBXjm+6tyHGw5XDCTzG7v/pn4L5JEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+cWSDIM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737053431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HOJpdcGfsCovXRIBOxirzadND8MYr95q/pnu65gPyBk=;
	b=P+cWSDIMRvRgEzQ3Hc6c/XVDMzX310WpGulkzT6e8FErlNnqrFp+rtotjSD/jg1PC60ZTt
	bgVgrslvobCl2P1fq9s8jNmDx+MTCBaFUTFt9e7o1SAQWyU0qRYN/Ka7Cbs/Fexqb+KB7D
	zDDba0wedjlofInxNS93i06WAtzEZ0o=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-NjPAj25mOdiolo8xEfIc3A-1; Thu, 16 Jan 2025 13:50:30 -0500
X-MC-Unique: NjPAj25mOdiolo8xEfIc3A-1
X-Mimecast-MFC-AGG-ID: NjPAj25mOdiolo8xEfIc3A
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ac005db65eso9373025ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 10:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737053426; x=1737658226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOJpdcGfsCovXRIBOxirzadND8MYr95q/pnu65gPyBk=;
        b=eLw/K9CyzJfEdEtI7s839fq9Bp5ZCCDaPGe1LSClS6XSmRIfC0Vrn0vqEARFsIfaYU
         2314YrMvRj7yhd9iIF6iAtSGax4bk6Cp53Kghm9J6zFiVhhr8g1xKoeXj8g3QVj1+Z2q
         eV4OdbJMwiPRQ+d+Cq52kWd8n8NUGMTlOowsnfL+rraTyobDQnur4HZsFDFYWfD6j5dB
         75nSfqfyndc6Foin1mTpC+9ZIKr02ryV8uYNIyNzyMD8PRICtXV7UA9EQl6VKy3oyPGX
         NliNwCbcpAIGC3TwiOzyK2Tq3dEpbyW9g02SfyB3pwVTRw+VERTZHsoj6PTCtTUn5vzQ
         uH8Q==
X-Gm-Message-State: AOJu0YxnGNnLYGp56Eq3vgCTPEJwLjOVkfzQMAW/nG6ZPKbM0aHoTDAn
	J8ij9uvX+o4ZwR5e6H/yjQZwtgr3leSTYWCvpKdDjqjcM4gYmnjJqLYooCvl/MHogx63ZSfFj9T
	94N0N+dzAF0PUubA9SsdjSfM+G73EvwYTyBP6ZHXauWvnQA6rYJdVWkYX4hfX/SyRYy1fVf0rWy
	zsfCRz8PbUoLb9+L/6jZIvkN58Rpj/POYWeHZxLC5ZO0yHhzbg
X-Gm-Gg: ASbGncvWQ9v4UaEaRh+Ss2PJGS4H2PvGVXIB0SDFfRPtl1R4asZ1qgbuq2Te2D+o0J2
	ajnQ9WyBmhCKq/EuOCJBJYL2hpFlcyE+IhwBDM9ndV7iYlGHJyQmHb1vXzkPXi/H5kw+bKYlCwf
	1ilucVXSM714YdPD3a+Mj7fvVaRO5J0N39HiLQ0F4aVTMtbgllyqGHdbxnNNZFIoIdaovzxAuQk
	m2HVtZnlxNguSVmRb7qTTqnL4DncEeuaJs0UEONqgN88zRn4l5ncW/UuIuoNb2meO80T8fRy8H4
	vuysVKeyLJipcfuFV3nZXLYJSf90Yw==
X-Received: by 2002:a05:6e02:1a08:b0:3ce:89db:6c3a with SMTP id e9e14a558f8ab-3ce89db6eedmr57146775ab.1.1737053425928;
        Thu, 16 Jan 2025 10:50:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXPXGSrHXh1Y+eoNt8BOIUuE3Yt0ub1EUrbxv6erD+9l09coxwNquEMHB1goxo6W7Iu54sYA==
X-Received: by 2002:a05:6e02:1a08:b0:3ce:89db:6c3a with SMTP id e9e14a558f8ab-3ce89db6eedmr57146485ab.1.1737053425452;
        Thu, 16 Jan 2025 10:50:25 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-180-154.mpls.qwest.net. [97.116.180.154])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea756c0a5dsm161834173.145.2025.01.16.10.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 10:50:25 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] ufs: convert ufs to the new mount API
Date: Thu, 16 Jan 2025 12:49:32 -0600
Message-ID: <20250116184932.1084286-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ufs to the new mount API

ufs_set/clear/test_opt macros are changed to take the full option,
to facilitate setting in parse_param.

ufstype option changes during remount are rejected during parsing,
rather than after the fact as they were before.

Removed a BUG_ON from show_options(); worst case, it prints
a null string where the BUG_ON would have fired.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/ufs/super.c | 280 +++++++++++++++++++++----------------------------
 fs/ufs/ufs.h   |   6 +-
 2 files changed, 125 insertions(+), 161 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 762699c1bcf6..6654dd50c031 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -83,11 +83,11 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/init.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
 #include <linux/log2.h>
-#include <linux/mount.h>
 #include <linux/seq_file.h>
 #include <linux/iversion.h>
 
@@ -342,124 +342,72 @@ void ufs_warning (struct super_block * sb, const char * function,
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
+enum { Opt_type, Opt_onerror };
+
+static const struct constant_table ufs_param_ufstype[] = {
+	{"old",		UFS_MOUNT_UFSTYPE_OLD},
+	{"sunx86",	UFS_MOUNT_UFSTYPE_SUNx86},
+	{"sun",		UFS_MOUNT_UFSTYPE_SUN},
+	{"sunos",	UFS_MOUNT_UFSTYPE_SUNOS},
+	{"44bsd",	UFS_MOUNT_UFSTYPE_44BSD},
+	{"ufs2",	UFS_MOUNT_UFSTYPE_UFS2},
+	{"5xbsd",	UFS_MOUNT_UFSTYPE_UFS2},
+	{"hp",		UFS_MOUNT_UFSTYPE_HP},
+	{"nextstep-cd",	UFS_MOUNT_UFSTYPE_NEXTSTEP_CD},
+	{"nextstep",	UFS_MOUNT_UFSTYPE_NEXTSTEP},
+	{"openstep",	UFS_MOUNT_UFSTYPE_OPENSTEP},
+	{}
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
+static const struct constant_table ufs_param_onerror[] = {
+	{"panic",	UFS_MOUNT_ONERROR_PANIC},
+	{"lock",	UFS_MOUNT_ONERROR_LOCK},
+	{"umount",	UFS_MOUNT_ONERROR_UMOUNT},
+	{"repair",	UFS_MOUNT_ONERROR_REPAIR},
+	{}
 };
 
-static int ufs_parse_options (char * options, unsigned * mount_options)
+static const struct fs_parameter_spec ufs_param_spec[] = {
+	fsparam_enum	("ufstype",	Opt_type, ufs_param_ufstype),
+	fsparam_enum	("onerror",	Opt_onerror, ufs_param_onerror),
+	{}
+};
+
+struct ufs_fs_context {
+	unsigned int mount_options;
+};
+
+static int ufs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char * p;
-	
+	struct ufs_fs_context *ctx = fc->fs_private;
+	int reconfigure = (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE);
+	struct fs_parse_result result;
+	int opt;
+
 	UFSD("ENTER\n");
-	
-	if (!options)
-		return 1;
 
-	while ((p = strsep(&options, ",")) != NULL) {
-		substring_t args[MAX_OPT_ARGS];
-		int token;
-		if (!*p)
-			continue;
+	opt = fs_parse(fc, ufs_param_spec, param, &result);
+	if (opt < 0)
+		return opt;
 
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
+	switch (opt) {
+	case Opt_type:
+		if (reconfigure &&
+		    (ctx->mount_options & UFS_MOUNT_UFSTYPE) != result.uint_32) {
+			pr_err("ufstype can't be changed during remount\n");
+			return -EINVAL;
 		}
+		ufs_clear_opt(ctx->mount_options, UFS_MOUNT_UFSTYPE);
+		ufs_set_opt(ctx->mount_options, result.uint_32);
+		break;
+	case Opt_onerror:
+		ufs_clear_opt(ctx->mount_options, UFS_MOUNT_ONERROR);
+		ufs_set_opt(ctx->mount_options, result.uint_32);
+		break;
+	default:
+		return -EINVAL;
 	}
-	return 1;
+	return 0;
 }
 
 /*
@@ -764,8 +712,10 @@ static u64 ufs_max_bytes(struct super_block *sb)
 	return res << uspi->s_bshift;
 }
 
-static int ufs_fill_super(struct super_block *sb, void *data, int silent)
+static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct ufs_fs_context *ctx = fc->fs_private;
+	int silent = fc->sb_flags & SB_SILENT;
 	struct ufs_sb_info * sbi;
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
@@ -803,16 +753,9 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	mutex_init(&sbi->s_lock);
 	spin_lock_init(&sbi->work_lock);
 	INIT_DELAYED_WORK(&sbi->sync_work, delayed_sync_fs);
-	/*
-	 * Set default mount options
-	 * Parse mount options
-	 */
-	sbi->s_mount_opt = 0;
-	ufs_set_opt (sbi->s_mount_opt, ONERROR_LOCK);
-	if (!ufs_parse_options ((char *) data, &sbi->s_mount_opt)) {
-		pr_err("wrong mount options\n");
-		goto failed;
-	}
+
+	sbi->s_mount_opt = ctx->mount_options;
+
 	if (!(sbi->s_mount_opt & UFS_MOUNT_UFSTYPE)) {
 		if (!silent)
 			pr_err("You didn't specify the type of your ufs filesystem\n\n"
@@ -820,7 +763,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 			"sun|sunx86|44bsd|ufs2|5xbsd|old|hp|nextstep|nextstep-cd|openstep ...\n\n"
 			">>>WARNING<<< Wrong ufstype may corrupt your filesystem, "
 			"default is ufstype=old\n");
-		ufs_set_opt (sbi->s_mount_opt, UFSTYPE_OLD);
+		ufs_set_opt(sbi->s_mount_opt, UFS_MOUNT_UFSTYPE_OLD);
 	}
 
 	uspi = kzalloc(sizeof(struct ufs_sb_private_info), GFP_KERNEL);
@@ -1290,13 +1233,16 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	return -ENOMEM;
 }
 
-static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
+static int ufs_reconfigure(struct fs_context *fc)
 {
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
 	struct ufs_super_block_third * usb3;
-	unsigned new_mount_opt, ufstype;
-	unsigned flags;
+	struct ufs_fs_context *ctx = fc->fs_private;
+	struct super_block *sb = fc->root->d_sb;
+	unsigned int new_mount_opt;
+	unsigned int ufstype;
+	unsigned int flags;
 
 	sync_filesystem(sb);
 	mutex_lock(&UFS_SB(sb)->s_lock);
@@ -1304,27 +1250,11 @@ static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
 	flags = UFS_SB(sb)->s_flags;
 	usb1 = ubh_get_usb_first(uspi);
 	usb3 = ubh_get_usb_third(uspi);
-	
-	/*
-	 * Allow the "check" option to be passed as a remount option.
-	 * It is not possible to change ufstype option during remount
-	 */
+
+	new_mount_opt = ctx->mount_options;
 	ufstype = UFS_SB(sb)->s_mount_opt & UFS_MOUNT_UFSTYPE;
-	new_mount_opt = 0;
-	ufs_set_opt (new_mount_opt, ONERROR_LOCK);
-	if (!ufs_parse_options (data, &new_mount_opt)) {
-		mutex_unlock(&UFS_SB(sb)->s_lock);
-		return -EINVAL;
-	}
-	if (!(new_mount_opt & UFS_MOUNT_UFSTYPE)) {
-		new_mount_opt |= ufstype;
-	} else if ((new_mount_opt & UFS_MOUNT_UFSTYPE) != ufstype) {
-		pr_err("ufstype can't be changed during remount\n");
-		mutex_unlock(&UFS_SB(sb)->s_lock);
-		return -EINVAL;
-	}
 
-	if ((bool)(*mount_flags & SB_RDONLY) == sb_rdonly(sb)) {
+	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb)) {
 		UFS_SB(sb)->s_mount_opt = new_mount_opt;
 		mutex_unlock(&UFS_SB(sb)->s_lock);
 		return 0;
@@ -1333,7 +1263,7 @@ static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
 	/*
 	 * fs was mouted as rw, remounting ro
 	 */
-	if (*mount_flags & SB_RDONLY) {
+	if (fc->sb_flags & SB_RDONLY) {
 		ufs_put_super_internal(sb);
 		usb1->fs_time = ufs_get_seconds(sb);
 		if ((flags & UFS_ST_MASK) == UFS_ST_SUN
@@ -1377,19 +1307,20 @@ static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
 static int ufs_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct ufs_sb_info *sbi = UFS_SB(root->d_sb);
-	unsigned mval = sbi->s_mount_opt & UFS_MOUNT_UFSTYPE;
-	const struct match_token *tp = tokens;
+	unsigned int mval;
+	const struct constant_table *tp;
 
-	while (tp->token != Opt_onerror_panic && tp->token != mval)
+	tp = ufs_param_ufstype;
+	mval = sbi->s_mount_opt & UFS_MOUNT_UFSTYPE;
+	while (tp->value && tp->value != mval)
 		++tp;
-	BUG_ON(tp->token == Opt_onerror_panic);
-	seq_printf(seq, ",%s", tp->pattern);
+	seq_printf(seq, ",ufstype=%s", tp->name);
 
+	tp = ufs_param_onerror;
 	mval = sbi->s_mount_opt & UFS_MOUNT_ONERROR;
-	while (tp->token != Opt_err && tp->token != mval)
+	while (tp->value && tp->value != mval)
 		++tp;
-	BUG_ON(tp->token == Opt_err);
-	seq_printf(seq, ",%s", tp->pattern);
+	seq_printf(seq, ",onerror=%s", tp->name);
 
 	return 0;
 }
@@ -1483,21 +1414,54 @@ static const struct super_operations ufs_super_ops = {
 	.put_super	= ufs_put_super,
 	.sync_fs	= ufs_sync_fs,
 	.statfs		= ufs_statfs,
-	.remount_fs	= ufs_remount,
 	.show_options   = ufs_show_options,
 };
 
-static struct dentry *ufs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int ufs_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, ufs_fill_super);
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
+	if (!ctx)
+		return -ENOMEM;
+
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		struct super_block *sb = fc->root->d_sb;
+		struct ufs_sb_info *sbi = UFS_SB(sb);
+
+		ctx->mount_options = sbi->s_mount_opt;
+	} else
+		ufs_set_opt(ctx->mount_options, UFS_MOUNT_ONERROR_LOCK);
+
+	fc->fs_private = ctx;
+	fc->ops = &ufs_context_ops;
+
+	return 0;
 }
 
 static struct file_system_type ufs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "ufs",
-	.mount		= ufs_mount,
 	.kill_sb	= kill_block_super,
+	.init_fs_context = ufs_init_fs_context,
+	.parameters	= ufs_param_spec,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ufs");
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index e7df65dd4351..79afc8fe70ae 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -70,9 +70,9 @@ struct ufs_inode_info {
 #define UFS_MOUNT_UFSTYPE_UFS2		0x00001000
 #define UFS_MOUNT_UFSTYPE_SUNOS		0x00002000
 
-#define ufs_clear_opt(o,opt)	o &= ~UFS_MOUNT_##opt
-#define ufs_set_opt(o,opt)	o |= UFS_MOUNT_##opt
-#define ufs_test_opt(o,opt)	((o) & UFS_MOUNT_##opt)
+#define ufs_clear_opt(o, opt)	(o &= ~(opt))
+#define ufs_set_opt(o, opt)	(o |= (opt))
+#define ufs_test_opt(o, opt)	((o) & opt)
 
 /*
  * Debug code
-- 
2.48.0


