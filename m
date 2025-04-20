Return-Path: <linux-fsdevel+bounces-46803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76964A95249
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFFE172F5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3317BB6;
	Mon, 21 Apr 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHXmAKPE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA34400
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244029; cv=none; b=rPDV16vo+1cTos+Q3DKRa1QcKu0wuxc4cViBp4VdTGf4Xq1YZ35pYJzk2carsEDRiFXVczRx5iqqE+AIdBeYRledmCYVECAQhrVjoxqavooMW5c4OvpNgwW0elnueNYhoVwt/QiTX954w4cQTbdv2t9VEHpg02LNlep749LaC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244029; c=relaxed/simple;
	bh=AbLw78dwK1rfLEfMaFjQnPjdS2LxUfMhpYxepMUg1Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHSyAFZgIq3dgelBa3hIMq4pAvxI4xk4tgKg3jTBFg/e86Xl5z7eTDrb/XxSqhIeY0x5UWRS/svSb/hFoWX8uS3qiHQoyHDxWpG8suHJuwqzRRxWki4fUDy1+pN33HM3L9u+3jpODW8XBYONtPa/pbeLCnybATv5gyHbjrG1L9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHXmAKPE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745244025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oz6orWq85v/g4CnD9yQWiJU78nGGwRt26sK50BhnXLY=;
	b=RHXmAKPEHCmzm6bRwW2TCC63pg0Up9AfJr9o9opxGWmAHHf/u2Bf8l1PzoILhnc83iKXby
	TSLbgnsLMqE7PXgAnsPnmRvM+ilnn/t26hfNCtiDnXZgEYJpvTSaV3565mBiVWwcQmfF/W
	pkUVMSpu3Nhbcri8v7d+xm6D47QtiaE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-h88B5TbYOoOSuH66DBM6Aw-1; Mon, 21 Apr 2025 10:00:24 -0400
X-MC-Unique: h88B5TbYOoOSuH66DBM6Aw-1
X-Mimecast-MFC-AGG-ID: h88B5TbYOoOSuH66DBM6Aw_1745244023
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b3b781313so866919139f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 07:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745244023; x=1745848823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oz6orWq85v/g4CnD9yQWiJU78nGGwRt26sK50BhnXLY=;
        b=rO7rru2fZSoa4S/2qUf7Q5KduKMxd3xX/cXaHMIjZO4VdjPaEs/jYhbYCr4XvQz4CP
         nzpUgBTABN9hOdLbVWBTusA2Kn6YKD74u7s7uqLioFBG24It20Ajp3Mw8M08LGRSPbg5
         acNkhznjS6nE+6R9pBgXvksfExJshbvuL0IbunMfckqWSB4BztTxOp3kq0O3u4EStQI3
         deK9ERIrQcfMPBg2L+AcUGKRU1RtnTB/wo3BOcmVH/+ODnD486PxBQl2kiGPeuLjoNAz
         pQE6KbRCvv8cl2Ds7Vah1cWlxdF365msuoJluhIZX5I0rFFdVGYwJECyg+Y2Wt9SSfL/
         jXhg==
X-Gm-Message-State: AOJu0Yxn7jrZpW24B2C/TWtFHojpaGH9acFNTxLZhDtQpi/nerarcaIX
	PT9/jTuExFKVxRIv1Me2QxmEUpWu2cyvdqq+JlnbCS/B6VOLrThYKW09yEfA62g/wmyp/t4LQHB
	Y6o+KKbZjo1NMbiPgP4k83C0MNoBg9I/sqs5elmVlDZ3kNTtxbrMZP6VVtqTtBcU=
X-Gm-Gg: ASbGncvFQBPlJE4wXr0eX/yvBB9xmmEa7u428qx6ViAddlS3K5DnmOs4zNg8f3dUnSR
	evd58FzZPhLMFREAlQpiN9/Yi7D0feh8QTH0dgEDCCC+220NAAnWqa2QS2OYUHDnOJCVxhXAZQF
	XW3wPDD3jvHc6PFCPw+j2VKqOhmMS1R9cY9+aVVpnLKgH4pO4z4IhQbnZzqAw6pYc1aeOOrVKLP
	6tGCL1Eca0heBz/KPApY6QcIln9dgEtWSUFzXJgImAw53k4A35yt5Tj8Xyrq3dSydWMQ5wCoUaA
	9XAW/JODVcFT41k=
X-Received: by 2002:a05:6602:4899:b0:85d:a1c4:ee03 with SMTP id ca18e2360f4ac-861dbe31e91mr1177725539f.7.1745244022775;
        Mon, 21 Apr 2025 07:00:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzylVVP9XKawygNsulIxgoE5m/ogJs4fxxX6k6RJjJnN7Jnb4vszVxJBFALR22FBxm93YbYg==
X-Received: by 2002:a05:6602:4899:b0:85d:a1c4:ee03 with SMTP id ca18e2360f4ac-861dbe31e91mr1177716339f.7.1745244021835;
        Mon, 21 Apr 2025 07:00:21 -0700 (PDT)
Received: from fedora.. ([65.128.104.55])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3839336sm1788866173.73.2025.04.21.07.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:00:21 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	lihongbo22@huawei.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 5/7] f2fs: separate the options parsing and options checking
Date: Sun, 20 Apr 2025 10:25:04 -0500
Message-ID: <20250420154647.1233033-6-sandeen@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250420154647.1233033-1-sandeen@redhat.com>
References: <20250420154647.1233033-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongbo Li <lihongbo22@huawei.com>

The new mount api separates option parsing and super block setup
into two distinct steps and so we need to separate the options
parsing out of the parse_options().

In order to achieve this, here we handle the mount options with
three steps:
  - Firstly, we move sb/sbi out of handle_mount_opt.
    As the former patch introduced f2fs_fs_context, so we record
    the changed mount options in this context. In handle_mount_opt,
    sb/sbi is null, so we should move all relative code out of
    handle_mount_opt (thus, some check case which use sb/sbi should
    move out).
  - Secondly, we introduce the some check helpers to keep the option
    consistent.
    During filling superblock period, sb/sbi are ready. So we check
    the f2fs_fs_context which holds the mount options base on sb/sbi.
  - Thirdly, we apply the new mount options to sb/sbi.
    After checking the f2fs_fs_context, all changed on mount options
    are valid. So we can apply them to sb/sbi directly.

After do these, option parsing and super block setting have been
decoupled. Also it should have retained the original execution
flow.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
[sandeen: forward port, minor fixes and updates]
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/f2fs/super.c | 694 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 510 insertions(+), 184 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 11bf936b0d3c..818db1e9549b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -358,6 +358,12 @@ static inline void ctx_clear_opt(struct f2fs_fs_context *ctx,
 	ctx->opt_mask |= flag;
 }
 
+static inline bool ctx_test_opt(struct f2fs_fs_context *ctx,
+				unsigned int flag)
+{
+	return ctx->info.opt & flag;
+}
+
 static inline void ctx_set_flags(struct f2fs_fs_context *ctx,
 				 unsigned int flag)
 {
@@ -531,51 +537,6 @@ static int f2fs_unnote_qf_name(struct fs_context *fc, int qtype)
 	ctx->qname_mask |= 1 << qtype;
 	return 0;
 }
-
-static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
-{
-	/*
-	 * We do the test below only for project quotas. 'usrquota' and
-	 * 'grpquota' mount options are allowed even without quota feature
-	 * to support legacy quotas in quota files.
-	 */
-	if (test_opt(sbi, PRJQUOTA) && !f2fs_sb_has_project_quota(sbi)) {
-		f2fs_err(sbi, "Project quota feature not enabled. Cannot enable project quota enforcement.");
-		return -1;
-	}
-	if (F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
-			F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
-			F2FS_OPTION(sbi).s_qf_names[PRJQUOTA]) {
-		if (test_opt(sbi, USRQUOTA) &&
-				F2FS_OPTION(sbi).s_qf_names[USRQUOTA])
-			clear_opt(sbi, USRQUOTA);
-
-		if (test_opt(sbi, GRPQUOTA) &&
-				F2FS_OPTION(sbi).s_qf_names[GRPQUOTA])
-			clear_opt(sbi, GRPQUOTA);
-
-		if (test_opt(sbi, PRJQUOTA) &&
-				F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
-			clear_opt(sbi, PRJQUOTA);
-
-		if (test_opt(sbi, GRPQUOTA) || test_opt(sbi, USRQUOTA) ||
-				test_opt(sbi, PRJQUOTA)) {
-			f2fs_err(sbi, "old and new quota format mixing");
-			return -1;
-		}
-
-		if (!F2FS_OPTION(sbi).s_jquota_fmt) {
-			f2fs_err(sbi, "journaled quota format not specified");
-			return -1;
-		}
-	}
-
-	if (f2fs_sb_has_quota_ino(sbi) && F2FS_OPTION(sbi).s_jquota_fmt) {
-		f2fs_info(sbi, "QUOTA feature is enabled, so ignore jquota_fmt");
-		F2FS_OPTION(sbi).s_jquota_fmt = 0;
-	}
-	return 0;
-}
 #endif
 
 static int f2fs_parse_test_dummy_encryption(const struct fs_parameter *param,
@@ -634,28 +595,28 @@ static bool is_compress_extension_exist(struct f2fs_mount_info *info,
  * extension will be treated as special cases and will not be compressed.
  * 3. Don't allow the non-compress extension specifies all files.
  */
-static int f2fs_test_compress_extension(struct f2fs_sb_info *sbi)
+static int f2fs_test_compress_extension(unsigned char (*noext)[F2FS_EXTENSION_LEN],
+					int noext_cnt,
+					unsigned char (*ext)[F2FS_EXTENSION_LEN],
+					int ext_cnt)
 {
-	unsigned char (*ext)[F2FS_EXTENSION_LEN];
-	unsigned char (*noext)[F2FS_EXTENSION_LEN];
-	int ext_cnt, noext_cnt, index = 0, no_index = 0;
-
-	ext = F2FS_OPTION(sbi).extensions;
-	ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
-	noext = F2FS_OPTION(sbi).noextensions;
-	noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
+	int index = 0, no_index = 0;
 
 	if (!noext_cnt)
 		return 0;
 
 	for (no_index = 0; no_index < noext_cnt; no_index++) {
+		if (strlen(noext[no_index]) == 0)
+			continue;
 		if (!strcasecmp("*", noext[no_index])) {
-			f2fs_info(sbi, "Don't allow the nocompress extension specifies all files");
+			f2fs_info(NULL, "Don't allow the nocompress extension specifies all files");
 			return -EINVAL;
 		}
 		for (index = 0; index < ext_cnt; index++) {
+			if (strlen(ext[index]) == 0)
+				continue;
 			if (!strcasecmp(ext[index], noext[no_index])) {
-				f2fs_info(sbi, "Don't allow the same extension %s appear in both compress and nocompress extension",
+				f2fs_info(NULL, "Don't allow the same extension %s appear in both compress and nocompress extension",
 						ext[index]);
 				return -EINVAL;
 			}
@@ -747,7 +708,6 @@ static int f2fs_set_zstd_level(struct f2fs_fs_context *ctx, const char *str)
 static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct f2fs_fs_context *ctx = fc->fs_private;
-	struct f2fs_sb_info *sbi = fc->s_fs_info;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	unsigned char (*ext)[F2FS_EXTENSION_LEN];
 	unsigned char (*noext)[F2FS_EXTENSION_LEN];
@@ -755,7 +715,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 #endif
 	substring_t args[MAX_OPT_ARGS];
 	struct fs_parse_result result;
-	int is_remount;
 	char *name;
 	int token, ret, arg;
 
@@ -763,8 +722,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	if (token < 0)
 		return token;
 
-	is_remount = fc->purpose == FS_CONTEXT_FOR_RECONFIGURE;
-
 	switch (token) {
 	case Opt_gc_background:
 		F2FS_CTX_INFO(ctx).bggc_mode = result.uint_32;
@@ -778,19 +735,10 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		ctx_set_opt(ctx, F2FS_MOUNT_NORECOVERY);
 		break;
 	case Opt_discard:
-		if (result.negated) {
-			if (f2fs_hw_should_discard(sbi)) {
-				f2fs_warn(NULL, "discard is required for zoned block devices");
-				return -EINVAL;
-			}
+		if (result.negated)
 			ctx_clear_opt(ctx, F2FS_MOUNT_DISCARD);
-		} else {
-			if (!f2fs_hw_support_discard(sbi)) {
-				f2fs_warn(NULL, "device does not support discard");
-				break;
-			}
+		else
 			ctx_set_opt(ctx, F2FS_MOUNT_DISCARD);
-		}
 		break;
 	case Opt_noheap:
 	case Opt_heap:
@@ -810,6 +758,12 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			ctx_set_opt(ctx, F2FS_MOUNT_INLINE_XATTR);
 		break;
 	case Opt_inline_xattr_size:
+		if (result.int_32 < MIN_INLINE_XATTR_SIZE ||
+			result.int_32 > MAX_INLINE_XATTR_SIZE) {
+			f2fs_err(NULL, "inline xattr size is out of range: %lu ~ %lu",
+				MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
+			return -EINVAL;
+		}
 		ctx_set_opt(ctx, F2FS_MOUNT_INLINE_XATTR_SIZE);
 		F2FS_CTX_INFO(ctx).inline_xattr_size = result.int_32;
 		ctx->spec_mask |= F2FS_SPEC_inline_xattr_size;
@@ -871,27 +825,18 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		ctx_set_opt(ctx, F2FS_MOUNT_FASTBOOT);
 		break;
 	case Opt_extent_cache:
-		if (result.negated) {
-			if (f2fs_sb_has_device_alias(sbi)) {
-				f2fs_err(sbi, "device aliasing requires extent cache");
-				return -EINVAL;
-			}
+		if (result.negated)
 			ctx_clear_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE);
-		} else
+		else
 			ctx_set_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE);
 		break;
 	case Opt_data_flush:
 		ctx_set_opt(ctx, F2FS_MOUNT_DATA_FLUSH);
 		break;
 	case Opt_reserve_root:
-		if (test_opt(sbi, RESERVE_ROOT)) {
-			f2fs_info(NULL, "Preserve previous reserve_root=%u",
-				  F2FS_OPTION(sbi).root_reserved_blocks);
-		} else {
-			ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
-			F2FS_CTX_INFO(ctx).root_reserved_blocks = result.uint_32;
-			ctx->spec_mask |= F2FS_SPEC_reserve_root;
-		}
+		ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
+		F2FS_CTX_INFO(ctx).root_reserved_blocks = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_reserve_root;
 		break;
 	case Opt_resuid:
 		F2FS_CTX_INFO(ctx).s_resuid = result.uid;
@@ -907,8 +852,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		break;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	case Opt_fault_injection:
-		if (f2fs_build_fault_attr(sbi, result.int_32,
-				F2FS_ALL_FAULT_TYPE))
+		if (result.int_32 > INT_MAX)
 			return -EINVAL;
 		F2FS_CTX_INFO(ctx).fault_info.inject_rate = result.int_32;
 		ctx->spec_mask |= F2FS_SPEC_fault_injection;
@@ -916,7 +860,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		break;
 
 	case Opt_fault_type:
-		if (f2fs_build_fault_attr(sbi, 0, result.int_32))
+		if (result.uint_32 > BIT(FAULT_MAX))
 			return -EINVAL;
 		F2FS_CTX_INFO(ctx).fault_info.inject_type = result.uint_32;
 		ctx->spec_mask |= F2FS_SPEC_fault_type;
@@ -1050,10 +994,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		break;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	case Opt_compress_algorithm:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			break;
-		}
 		name = param->string;
 		if (!strcmp(name, "lzo")) {
 #ifdef CONFIG_F2FS_FS_LZO
@@ -1097,10 +1037,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		break;
 	case Opt_compress_log_size:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			break;
-		}
 		if (result.uint_32 < MIN_COMPRESS_LOG_SIZE ||
 		    result.uint_32 > MAX_COMPRESS_LOG_SIZE) {
 			f2fs_err(NULL,
@@ -1111,10 +1047,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		ctx->spec_mask |= F2FS_SPEC_compress_log_size;
 		break;
 	case Opt_compress_extension:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			break;
-		}
 		name = param->string;
 		ext = F2FS_CTX_INFO(ctx).extensions;
 		ext_cnt = F2FS_CTX_INFO(ctx).compress_ext_cnt;
@@ -1135,10 +1067,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		ctx->spec_mask |= F2FS_SPEC_compress_extension;
 		break;
 	case Opt_nocompress_extension:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			break;
-		}
 		name = param->string;
 		noext = F2FS_CTX_INFO(ctx).noextensions;
 		noext_cnt = F2FS_CTX_INFO(ctx).nocompress_ext_cnt;
@@ -1159,26 +1087,14 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		ctx->spec_mask |= F2FS_SPEC_nocompress_extension;
 		break;
 	case Opt_compress_chksum:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			break;
-		}
 		F2FS_CTX_INFO(ctx).compress_chksum = true;
 		ctx->spec_mask |= F2FS_SPEC_compress_chksum;
 		break;
 	case Opt_compress_mode:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			break;
-		}
 		F2FS_CTX_INFO(ctx).compress_mode = result.uint_32;
 		ctx->spec_mask |= F2FS_SPEC_compress_mode;
 		break;
 	case Opt_compress_cache:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			break;
-		}
 		ctx_set_opt(ctx, F2FS_MOUNT_COMPRESS_CACHE);
 		break;
 #else
@@ -1223,24 +1139,15 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
-static int parse_options(struct f2fs_sb_info *sbi, char *options, bool is_remount)
+static int parse_options(struct fs_context *fc, char *options)
 {
 	struct fs_parameter param;
-	struct fs_context fc;
-	struct f2fs_fs_context ctx;
 	char *key;
 	int ret;
 
 	if (!options)
 		return 0;
 
-	memset(&fc, 0, sizeof(fc));
-	fc.s_fs_info = sbi;
-	fc.fs_private = &ctx;
-
-	if (is_remount)
-		fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
-
 	while ((key = strsep(&options, ",")) != NULL) {
 		if (*key) {
 			size_t v_len = 0;
@@ -1264,7 +1171,7 @@ static int parse_options(struct f2fs_sb_info *sbi, char *options, bool is_remoun
 			param.key = key;
 			param.size = v_len;
 
-			ret = handle_mount_opt(&fc, &param);
+			ret = handle_mount_opt(fc, &param);
 			kfree(param.string);
 			if (ret < 0)
 				return ret;
@@ -1273,24 +1180,293 @@ static int parse_options(struct f2fs_sb_info *sbi, char *options, bool is_remoun
 	return 0;
 }
 
-static int f2fs_validate_options(struct f2fs_sb_info *sbi)
+/*
+ * Check quota settings consistency.
+ */
+static int f2fs_check_quota_consistency(struct fs_context *fc,
+					struct super_block *sb)
 {
-#ifdef CONFIG_QUOTA
-	if (f2fs_check_quota_options(sbi))
+ #ifdef CONFIG_QUOTA
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	bool quota_feature = f2fs_sb_has_quota_ino(sbi);
+	bool quota_turnon = sb_any_quota_loaded(sb);
+	char *old_qname, *new_qname;
+	bool usr_qf_name, grp_qf_name, prj_qf_name, usrquota, grpquota, prjquota;
+	int i;
+
+	/*
+	 * We do the test below only for project quotas. 'usrquota' and
+	 * 'grpquota' mount options are allowed even without quota feature
+	 * to support legacy quotas in quota files.
+	 */
+	if (ctx_test_opt(ctx, F2FS_MOUNT_PRJQUOTA) &&
+			!f2fs_sb_has_project_quota(sbi)) {
+		f2fs_err(sbi, "Project quota feature not enabled. Cannot enable project quota enforcement.");
 		return -EINVAL;
+	}
+
+	if (ctx->qname_mask) {
+		for (i = 0; i < MAXQUOTAS; i++) {
+			if (!(ctx->qname_mask & (1 << i)))
+				continue;
+
+			old_qname = F2FS_OPTION(sbi).s_qf_names[i];
+			new_qname = F2FS_CTX_INFO(ctx).s_qf_names[i];
+			if (quota_turnon &&
+				!!old_qname != !!new_qname)
+				goto err_jquota_change;
+
+			if (old_qname) {
+				if (strcmp(old_qname, new_qname) == 0) {
+					ctx->qname_mask &= ~(1 << i);
+					continue;
+				}
+				goto err_jquota_specified;
+			}
+
+			if (quota_feature) {
+				f2fs_info(sbi, "QUOTA feature is enabled, so ignore qf_name");
+				ctx->qname_mask &= ~(1 << i);
+				kfree(F2FS_CTX_INFO(ctx).s_qf_names[i]);
+				F2FS_CTX_INFO(ctx).s_qf_names[i] = NULL;
+			}
+		}
+	}
+
+	/* Make sure we don't mix old and new quota format */
+	usr_qf_name = F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
+			F2FS_CTX_INFO(ctx).s_qf_names[USRQUOTA];
+	grp_qf_name = F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
+			F2FS_CTX_INFO(ctx).s_qf_names[GRPQUOTA];
+	prj_qf_name = F2FS_OPTION(sbi).s_qf_names[PRJQUOTA] ||
+			F2FS_CTX_INFO(ctx).s_qf_names[PRJQUOTA];
+	usrquota = test_opt(sbi, USRQUOTA) ||
+			ctx_test_opt(ctx, F2FS_MOUNT_USRQUOTA);
+	grpquota = test_opt(sbi, GRPQUOTA) ||
+			ctx_test_opt(ctx, F2FS_MOUNT_GRPQUOTA);
+	prjquota = test_opt(sbi, PRJQUOTA) ||
+			ctx_test_opt(ctx, F2FS_MOUNT_PRJQUOTA);
+
+	if (usr_qf_name) {
+		ctx_clear_opt(ctx, F2FS_MOUNT_USRQUOTA);
+		usrquota = false;
+	}
+	if (grp_qf_name) {
+		ctx_clear_opt(ctx, F2FS_MOUNT_GRPQUOTA);
+		grpquota = false;
+	}
+	if (prj_qf_name) {
+		ctx_clear_opt(ctx, F2FS_MOUNT_PRJQUOTA);
+		prjquota = false;
+	}
+	if (usr_qf_name || grp_qf_name || prj_qf_name) {
+		if (grpquota || usrquota || prjquota) {
+			f2fs_err(sbi, "old and new quota format mixing");
+			return -EINVAL;
+		}
+		if (!(ctx->spec_mask & F2FS_SPEC_jqfmt ||
+				F2FS_OPTION(sbi).s_jquota_fmt)) {
+			f2fs_err(sbi, "journaled quota format not specified");
+			return -EINVAL;
+		}
+	}
+	return 0;
+
+err_jquota_change:
+	f2fs_err(sbi, "Cannot change journaled quota options when quota turned on");
+	return -EINVAL;
+err_jquota_specified:
+	f2fs_err(sbi, "%s quota file already specified",
+		 QTYPE2NAME(i));
+	return -EINVAL;
+
 #else
-	if (f2fs_sb_has_quota_ino(sbi) && !f2fs_readonly(sbi->sb)) {
-		f2fs_info(NULL, "Filesystem with quota feature cannot be mounted RDWR without CONFIG_QUOTA");
+	if (f2fs_readonly(sbi->sb))
+		return 0;
+	if (f2fs_sb_has_quota_ino(sbi)) {
+		f2fs_info(sbi, "Filesystem with quota feature cannot be mounted RDWR without CONFIG_QUOTA");
 		return -EINVAL;
 	}
-	if (f2fs_sb_has_project_quota(sbi) && !f2fs_readonly(sbi->sb)) {
-		f2fs_err(NULL, "Filesystem with project quota feature cannot be mounted RDWR without CONFIG_QUOTA");
+	if (f2fs_sb_has_project_quota(sbi)) {
+		f2fs_err(sbi, "Filesystem with project quota feature cannot be mounted RDWR without CONFIG_QUOTA");
 		return -EINVAL;
 	}
+
+	return 0;
 #endif
+}
+
+static int f2fs_check_test_dummy_encryption(struct fs_context *fc,
+					    struct super_block *sb)
+{
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+
+	if (!fscrypt_is_dummy_policy_set(&F2FS_CTX_INFO(ctx).dummy_enc_policy))
+		return 0;
+
+	if (!f2fs_sb_has_encrypt(sbi)) {
+		f2fs_err(sbi, "Encrypt feature is off");
+		return -EINVAL;
+	}
+
+	/*
+	 * This mount option is just for testing, and it's not worthwhile to
+	 * implement the extra complexity (e.g. RCU protection) that would be
+	 * needed to allow it to be set or changed during remount.  We do allow
+	 * it to be specified during remount, but only if there is no change.
+	 */
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		if (fscrypt_dummy_policies_equal(&F2FS_OPTION(sbi).dummy_enc_policy,
+				&F2FS_CTX_INFO(ctx).dummy_enc_policy))
+			return 0;
+		f2fs_warn(sbi, "Can't set or change test_dummy_encryption on remount");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static inline bool test_compression_spec(unsigned int mask)
+{
+	return mask & (F2FS_SPEC_compress_algorithm
+			| F2FS_SPEC_compress_log_size
+			| F2FS_SPEC_compress_extension
+			| F2FS_SPEC_nocompress_extension
+			| F2FS_SPEC_compress_chksum
+			| F2FS_SPEC_compress_mode);
+}
+
+static inline void clear_compression_spec(struct f2fs_fs_context *ctx)
+{
+	ctx->spec_mask &= ~(F2FS_SPEC_compress_algorithm
+						| F2FS_SPEC_compress_log_size
+						| F2FS_SPEC_compress_extension
+						| F2FS_SPEC_nocompress_extension
+						| F2FS_SPEC_compress_chksum
+						| F2FS_SPEC_compress_mode);
+}
+
+static int f2fs_check_compression(struct fs_context *fc,
+				  struct super_block *sb)
+{
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	int i, cnt;
+
+	if (!f2fs_sb_has_compression(sbi)) {
+		if (test_compression_spec(ctx->opt_mask) ||
+			ctx_test_opt(ctx, F2FS_MOUNT_COMPRESS_CACHE))
+			f2fs_info(sbi, "Image doesn't support compression");
+		clear_compression_spec(ctx);
+		ctx->opt_mask &= ~F2FS_MOUNT_COMPRESS_CACHE;
+		return 0;
+	}
+	if (ctx->spec_mask & F2FS_SPEC_compress_extension) {
+		cnt = F2FS_CTX_INFO(ctx).compress_ext_cnt;
+		for (i = 0; i < F2FS_CTX_INFO(ctx).compress_ext_cnt; i++) {
+			if (is_compress_extension_exist(&F2FS_OPTION(sbi),
+					F2FS_CTX_INFO(ctx).extensions[i], true)) {
+				F2FS_CTX_INFO(ctx).extensions[i][0] = '\0';
+				cnt--;
+			}
+		}
+		if (F2FS_OPTION(sbi).compress_ext_cnt + cnt > COMPRESS_EXT_NUM) {
+			f2fs_err(sbi, "invalid extension length/number");
+			return -EINVAL;
+		}
+	}
+	if (ctx->spec_mask & F2FS_SPEC_nocompress_extension) {
+		cnt = F2FS_CTX_INFO(ctx).nocompress_ext_cnt;
+		for (i = 0; i < F2FS_CTX_INFO(ctx).nocompress_ext_cnt; i++) {
+			if (is_compress_extension_exist(&F2FS_OPTION(sbi),
+					F2FS_CTX_INFO(ctx).noextensions[i], false)) {
+				F2FS_CTX_INFO(ctx).noextensions[i][0] = '\0';
+				cnt--;
+			}
+		}
+		if (F2FS_OPTION(sbi).nocompress_ext_cnt + cnt > COMPRESS_EXT_NUM) {
+			f2fs_err(sbi, "invalid noextension length/number");
+			return -EINVAL;
+		}
+	}
+
+	if (f2fs_test_compress_extension(F2FS_CTX_INFO(ctx).noextensions,
+				F2FS_CTX_INFO(ctx).nocompress_ext_cnt,
+				F2FS_CTX_INFO(ctx).extensions,
+				F2FS_CTX_INFO(ctx).compress_ext_cnt)) {
+		f2fs_err(sbi, "invalid compress or nocompress extension");
+		return -EINVAL;
+	}
+	if (f2fs_test_compress_extension(F2FS_CTX_INFO(ctx).noextensions,
+				F2FS_CTX_INFO(ctx).nocompress_ext_cnt,
+				F2FS_OPTION(sbi).extensions,
+				F2FS_OPTION(sbi).compress_ext_cnt)) {
+		f2fs_err(sbi, "invalid compress or nocompress extension");
+		return -EINVAL;
+	}
+	if (f2fs_test_compress_extension(F2FS_OPTION(sbi).noextensions,
+				F2FS_OPTION(sbi).nocompress_ext_cnt,
+				F2FS_CTX_INFO(ctx).extensions,
+				F2FS_CTX_INFO(ctx).compress_ext_cnt)) {
+		f2fs_err(sbi, "invalid compress or nocompress extension");
+		return -EINVAL;
+	}
+#endif
+	return 0;
+}
+
+static int f2fs_check_opt_consistency(struct fs_context *fc,
+				      struct super_block *sb)
+{
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	int err;
+
+	if (ctx_test_opt(ctx, F2FS_MOUNT_NORECOVERY) && !f2fs_readonly(sb))
+		return -EINVAL;
+
+	if (f2fs_hw_should_discard(sbi) && (ctx->opt_mask & F2FS_MOUNT_DISCARD)
+				&& !ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
+		f2fs_warn(sbi, "discard is required for zoned block devices");
+		return -EINVAL;
+	}
+
+	if (f2fs_sb_has_device_alias(sbi)) {
+		f2fs_err(sbi, "device aliasing requires extent cache");
+		return -EINVAL;
+	}
+
+	if (!f2fs_hw_support_discard(sbi) && (ctx->opt_mask & F2FS_MOUNT_DISCARD)
+				&& ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
+		f2fs_warn(sbi, "device does not support discard");
+		ctx_clear_opt(ctx, F2FS_MOUNT_DISCARD);
+		ctx->opt_mask &= ~F2FS_MOUNT_DISCARD;
+	}
+
+	if (test_opt(sbi, RESERVE_ROOT) && (ctx->opt_mask & F2FS_MOUNT_RESERVE_ROOT)
+				&& ctx_test_opt(ctx, F2FS_MOUNT_RESERVE_ROOT)) {
+		f2fs_info(sbi, "Preserve previous reserve_root=%u",
+			F2FS_OPTION(sbi).root_reserved_blocks);
+		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
+		ctx->opt_mask &= ~F2FS_MOUNT_RESERVE_ROOT;
+	}
+
+	err = f2fs_check_test_dummy_encryption(fc, sb);
+	if (err)
+		return err;
+
+	err = f2fs_check_compression(fc, sb);
+	if (err)
+		return err;
+
+	err = f2fs_check_quota_consistency(fc, sb);
+	if (err)
+		return err;
 
 	if (!IS_ENABLED(CONFIG_UNICODE) && f2fs_sb_has_casefold(sbi)) {
-		f2fs_err(NULL,
+		f2fs_err(sbi,
 			"Filesystem with casefold feature cannot be mounted without CONFIG_UNICODE");
 		return -EINVAL;
 	}
@@ -1302,75 +1478,210 @@ static int f2fs_validate_options(struct f2fs_sb_info *sbi)
 	 */
 	if (f2fs_sb_has_blkzoned(sbi)) {
 #ifdef CONFIG_BLK_DEV_ZONED
-		if (F2FS_OPTION(sbi).discard_unit !=
-						DISCARD_UNIT_SECTION) {
-			f2fs_info(NULL, "Zoned block device doesn't need small discard, set discard_unit=section by default");
-			F2FS_OPTION(sbi).discard_unit =
-					DISCARD_UNIT_SECTION;
+		if ((ctx->spec_mask & F2FS_SPEC_discard_unit) &&
+		F2FS_CTX_INFO(ctx).discard_unit != DISCARD_UNIT_SECTION) {
+			f2fs_info(sbi, "Zoned block device doesn't need small discard, set discard_unit=section by default");
+			F2FS_CTX_INFO(ctx).discard_unit = DISCARD_UNIT_SECTION;
 		}
 
-		if (F2FS_OPTION(sbi).fs_mode != FS_MODE_LFS) {
-			f2fs_info(NULL, "Only lfs mode is allowed with zoned block device feature");
+		if ((ctx->spec_mask & F2FS_SPEC_mode) &&
+		F2FS_CTX_INFO(ctx).fs_mode != FS_MODE_LFS) {
+			f2fs_info(sbi, "Only lfs mode is allowed with zoned block device feature");
 			return -EINVAL;
 		}
 #else
-		f2fs_err(NULL, "Zoned block device support is not enabled");
+		f2fs_err(sbi, "Zoned block device support is not enabled");
 		return -EINVAL;
 #endif
 	}
 
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (f2fs_test_compress_extension(sbi)) {
-		f2fs_err(NULL, "invalid compress or nocompress extension");
-		return -EINVAL;
-	}
-#endif
-
-	if (test_opt(sbi, INLINE_XATTR_SIZE)) {
-		int min_size, max_size;
-
+	if (ctx_test_opt(ctx, F2FS_MOUNT_INLINE_XATTR_SIZE)) {
 		if (!f2fs_sb_has_extra_attr(sbi) ||
 			!f2fs_sb_has_flexible_inline_xattr(sbi)) {
-			f2fs_err(NULL, "extra_attr or flexible_inline_xattr feature is off");
-			return -EINVAL;
-		}
-		if (!test_opt(sbi, INLINE_XATTR)) {
-			f2fs_err(NULL, "inline_xattr_size option should be set with inline_xattr option");
+			f2fs_err(sbi, "extra_attr or flexible_inline_xattr feature is off");
 			return -EINVAL;
 		}
-
-		min_size = MIN_INLINE_XATTR_SIZE;
-		max_size = MAX_INLINE_XATTR_SIZE;
-
-		if (F2FS_OPTION(sbi).inline_xattr_size < min_size ||
-				F2FS_OPTION(sbi).inline_xattr_size > max_size) {
-			f2fs_err(NULL, "inline xattr size is out of range: %d ~ %d",
-				 min_size, max_size);
+		if (!ctx_test_opt(ctx, F2FS_MOUNT_INLINE_XATTR)) {
+			f2fs_err(sbi, "inline_xattr_size option should be set with inline_xattr option");
 			return -EINVAL;
 		}
 	}
 
-	if (test_opt(sbi, ATGC) && f2fs_lfs_mode(sbi)) {
-		f2fs_err(NULL, "LFS is not compatible with ATGC");
+	if (ctx_test_opt(ctx, F2FS_MOUNT_ATGC) &&
+	    F2FS_CTX_INFO(ctx).fs_mode == FS_MODE_LFS) {
+		f2fs_err(sbi, "LFS is not compatible with ATGC");
 		return -EINVAL;
 	}
 
-	if (f2fs_is_readonly(sbi) && test_opt(sbi, FLUSH_MERGE)) {
-		f2fs_err(NULL, "FLUSH_MERGE not compatible with readonly mode");
+	if (f2fs_is_readonly(sbi) && ctx_test_opt(ctx, F2FS_MOUNT_FLUSH_MERGE)) {
+		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
 		return -EINVAL;
 	}
 
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
-		f2fs_err(NULL, "Allow to mount readonly mode only");
+		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
 	}
+	return 0;
+}
 
-	if (test_opt(sbi, NORECOVERY) && !f2fs_readonly(sbi->sb)) {
-		f2fs_err(sbi, "norecovery requires readonly mount");
-		return -EINVAL;
+static void f2fs_apply_quota_options(struct fs_context *fc,
+				     struct super_block *sb)
+{
+#ifdef CONFIG_QUOTA
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	bool quota_feature = f2fs_sb_has_quota_ino(sbi);
+	char *qname;
+	int i;
+
+	if (quota_feature)
+		return;
+
+	for (i = 0; i < MAXQUOTAS; i++) {
+		if (!(ctx->qname_mask & (1 << i)))
+			continue;
+
+		qname = F2FS_CTX_INFO(ctx).s_qf_names[i];
+		if (qname)
+			set_opt(sbi, QUOTA);
+		F2FS_OPTION(sbi).s_qf_names[i] = qname;
+		F2FS_CTX_INFO(ctx).s_qf_names[i] = NULL;
 	}
 
-	return 0;
+	if (ctx->spec_mask & F2FS_SPEC_jqfmt)
+		F2FS_OPTION(sbi).s_jquota_fmt = F2FS_CTX_INFO(ctx).s_jquota_fmt;
+
+	if (quota_feature && F2FS_OPTION(sbi).s_jquota_fmt) {
+		f2fs_info(sbi, "QUOTA feature is enabled, so ignore jquota_fmt");
+		F2FS_OPTION(sbi).s_jquota_fmt = 0;
+	}
+#endif
+}
+
+static void f2fs_apply_test_dummy_encryption(struct fs_context *fc,
+					     struct super_block *sb)
+{
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+
+	if (!fscrypt_is_dummy_policy_set(&F2FS_CTX_INFO(ctx).dummy_enc_policy) ||
+		/* if already set, it was already verified to be the same */
+		fscrypt_is_dummy_policy_set(&F2FS_OPTION(sbi).dummy_enc_policy))
+		return;
+	F2FS_OPTION(sbi).dummy_enc_policy = F2FS_CTX_INFO(ctx).dummy_enc_policy;
+	memset(&F2FS_CTX_INFO(ctx).dummy_enc_policy, 0,
+		sizeof(F2FS_CTX_INFO(ctx).dummy_enc_policy));
+	f2fs_warn(sbi, "Test dummy encryption mode enabled");
+}
+
+static void f2fs_apply_compression(struct fs_context *fc,
+				   struct super_block *sb)
+{
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	unsigned char (*ctx_ext)[F2FS_EXTENSION_LEN];
+	unsigned char (*sbi_ext)[F2FS_EXTENSION_LEN];
+	int ctx_cnt, sbi_cnt, i;
+
+	if (ctx->spec_mask & F2FS_SPEC_compress_level)
+		F2FS_OPTION(sbi).compress_level =
+					F2FS_CTX_INFO(ctx).compress_level;
+	if (ctx->spec_mask & F2FS_SPEC_compress_algorithm)
+		F2FS_OPTION(sbi).compress_algorithm =
+					F2FS_CTX_INFO(ctx).compress_algorithm;
+	if (ctx->spec_mask & F2FS_SPEC_compress_log_size)
+		F2FS_OPTION(sbi).compress_log_size =
+					F2FS_CTX_INFO(ctx).compress_log_size;
+	if (ctx->spec_mask & F2FS_SPEC_compress_chksum)
+		F2FS_OPTION(sbi).compress_chksum =
+					F2FS_CTX_INFO(ctx).compress_chksum;
+	if (ctx->spec_mask & F2FS_SPEC_compress_mode)
+		F2FS_OPTION(sbi).compress_mode =
+					F2FS_CTX_INFO(ctx).compress_mode;
+	if (ctx->spec_mask & F2FS_SPEC_compress_extension) {
+		ctx_ext = F2FS_CTX_INFO(ctx).extensions;
+		ctx_cnt = F2FS_CTX_INFO(ctx).compress_ext_cnt;
+		sbi_ext = F2FS_OPTION(sbi).extensions;
+		sbi_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
+		for (i = 0; i < ctx_cnt; i++) {
+			if (strlen(ctx_ext[i]) == 0)
+				continue;
+			strscpy(sbi_ext[sbi_cnt], ctx_ext[i]);
+			sbi_cnt++;
+		}
+		F2FS_OPTION(sbi).compress_ext_cnt = sbi_cnt;
+	}
+	if (ctx->spec_mask & F2FS_SPEC_nocompress_extension) {
+		ctx_ext = F2FS_CTX_INFO(ctx).noextensions;
+		ctx_cnt = F2FS_CTX_INFO(ctx).nocompress_ext_cnt;
+		sbi_ext = F2FS_OPTION(sbi).noextensions;
+		sbi_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
+		for (i = 0; i < ctx_cnt; i++) {
+			if (strlen(ctx_ext[i]) == 0)
+				continue;
+			strscpy(sbi_ext[sbi_cnt], ctx_ext[i]);
+			sbi_cnt++;
+		}
+		F2FS_OPTION(sbi).nocompress_ext_cnt = sbi_cnt;
+	}
+#endif
+}
+
+static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
+{
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+
+	F2FS_OPTION(sbi).opt &= ~ctx->opt_mask;
+	F2FS_OPTION(sbi).opt |= F2FS_CTX_INFO(ctx).opt;
+	sb->s_flags &= ~ctx->sflags_mask;
+	sb->s_flags |= ctx->sflags;
+
+	if (ctx->spec_mask & F2FS_SPEC_background_gc)
+		F2FS_OPTION(sbi).bggc_mode = F2FS_CTX_INFO(ctx).bggc_mode;
+	if (ctx->spec_mask & F2FS_SPEC_inline_xattr_size)
+		F2FS_OPTION(sbi).inline_xattr_size =
+					F2FS_CTX_INFO(ctx).inline_xattr_size;
+	if (ctx->spec_mask & F2FS_SPEC_active_logs)
+		F2FS_OPTION(sbi).active_logs = F2FS_CTX_INFO(ctx).active_logs;
+	if (ctx->spec_mask & F2FS_SPEC_reserve_root)
+		F2FS_OPTION(sbi).root_reserved_blocks =
+					F2FS_CTX_INFO(ctx).root_reserved_blocks;
+	if (ctx->spec_mask & F2FS_SPEC_resgid)
+		F2FS_OPTION(sbi).s_resgid = F2FS_CTX_INFO(ctx).s_resgid;
+	if (ctx->spec_mask & F2FS_SPEC_resuid)
+		F2FS_OPTION(sbi).s_resuid = F2FS_CTX_INFO(ctx).s_resuid;
+	if (ctx->spec_mask & F2FS_SPEC_mode)
+		F2FS_OPTION(sbi).fs_mode = F2FS_CTX_INFO(ctx).fs_mode;
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (ctx->spec_mask & F2FS_SPEC_fault_injection)
+		(void)f2fs_build_fault_attr(sbi,
+		F2FS_CTX_INFO(ctx).fault_info.inject_rate, F2FS_ALL_FAULT_TYPE);
+	if (ctx->spec_mask & F2FS_SPEC_fault_type)
+		(void)f2fs_build_fault_attr(sbi,
+			0, F2FS_CTX_INFO(ctx).fault_info.inject_type);
+#endif
+	if (ctx->spec_mask & F2FS_SPEC_alloc_mode)
+		F2FS_OPTION(sbi).alloc_mode = F2FS_CTX_INFO(ctx).alloc_mode;
+	if (ctx->spec_mask & F2FS_SPEC_fsync_mode)
+		F2FS_OPTION(sbi).fsync_mode = F2FS_CTX_INFO(ctx).fsync_mode;
+	if (ctx->spec_mask & F2FS_SPEC_checkpoint_disable_cap)
+		F2FS_OPTION(sbi).unusable_cap = F2FS_CTX_INFO(ctx).unusable_cap;
+	if (ctx->spec_mask & F2FS_SPEC_checkpoint_disable_cap_perc)
+		F2FS_OPTION(sbi).unusable_cap_perc =
+					F2FS_CTX_INFO(ctx).unusable_cap_perc;
+	if (ctx->spec_mask & F2FS_SPEC_discard_unit)
+		F2FS_OPTION(sbi).discard_unit = F2FS_CTX_INFO(ctx).discard_unit;
+	if (ctx->spec_mask & F2FS_SPEC_memory_mode)
+		F2FS_OPTION(sbi).memory_mode = F2FS_CTX_INFO(ctx).memory_mode;
+	if (ctx->spec_mask & F2FS_SPEC_errors)
+		F2FS_OPTION(sbi).errors = F2FS_CTX_INFO(ctx).errors;
+
+	f2fs_apply_compression(fc, sb);
+	f2fs_apply_test_dummy_encryption(fc, sb);
+	f2fs_apply_quota_options(fc, sb);
 }
 
 static struct inode *f2fs_alloc_inode(struct super_block *sb)
@@ -2272,6 +2583,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct f2fs_mount_info org_mount_opt;
+	struct f2fs_fs_context ctx;
+	struct fs_context fc;
 	unsigned long old_sb_flags;
 	int err;
 	bool need_restart_gc = false, need_stop_gc = false;
@@ -2328,11 +2641,22 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 	default_options(sbi, true);
 
+	memset(&fc, 0, sizeof(fc));
+	memset(&ctx, 0, sizeof(ctx));
+	fc.fs_private = &ctx;
+	fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
+
 	/* parse mount options */
-	err = parse_options(sbi, data, true);
+	err = parse_options(&fc, data);
 	if (err)
 		goto restore_opts;
 
+	err = f2fs_check_opt_consistency(&fc, sb);
+	if (err < 0)
+		goto restore_opts;
+
+	f2fs_apply_options(&fc, sb);
+
 #ifdef CONFIG_BLK_DEV_ZONED
 	if (f2fs_sb_has_blkzoned(sbi) &&
 		sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
@@ -2343,11 +2667,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 #endif
-
-	err = f2fs_validate_options(sbi);
-	if (err)
-		goto restore_opts;
-
 	/* flush outstanding errors before changing fs state */
 	flush_work(&sbi->s_error_work);
 
@@ -4426,6 +4745,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct f2fs_sb_info *sbi;
 	struct f2fs_super_block *raw_super;
+	struct f2fs_fs_context ctx;
+	struct fs_context fc;
 	struct inode *root;
 	int err;
 	bool skip_recovery = false, need_fsck = false;
@@ -4442,6 +4763,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	raw_super = NULL;
 	valid_super_block = -1;
 	recovery = 0;
+	memset(&fc, 0, sizeof(fc));
+	memset(&ctx, 0, sizeof(ctx));
+	fc.fs_private = &ctx;
 
 	/* allocate memory for f2fs-specific super block info */
 	sbi = kzalloc(sizeof(struct f2fs_sb_info), GFP_KERNEL);
@@ -4499,14 +4823,16 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_sb_buf;
 	}
 
-	err = parse_options(sbi, options, false);
+	err = parse_options(&fc, options);
 	if (err)
 		goto free_options;
 
-	err = f2fs_validate_options(sbi);
-	if (err)
+	err = f2fs_check_opt_consistency(&fc, sb);
+	if (err < 0)
 		goto free_options;
 
+	f2fs_apply_options(&fc, sb);
+
 	sb->s_maxbytes = max_file_blocks(NULL) <<
 				le32_to_cpu(raw_super->log_blocksize);
 	sb->s_max_links = F2FS_LINK_MAX;
-- 
2.47.0


