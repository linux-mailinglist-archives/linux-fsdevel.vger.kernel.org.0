Return-Path: <linux-fsdevel+bounces-46800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63868A95246
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567203ABE5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9B238DE9;
	Mon, 21 Apr 2025 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buaH2NJD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC6B18B03
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244026; cv=none; b=on237kbTYks8wqwdt9+nAgxkPDc5+fbojIE87R7/WE8+1+lLOE1LKSjZNEgoobzpLMSDtJm7f17jRWSmPqsgp9ehdvRZ/0Qo/6syI6iKghvoHp/So45BoEiAdt6GxcSGgBipB7ByasLsjGtZ+kEl69c4DKRZ9zPT2sye5aldzhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244026; c=relaxed/simple;
	bh=T4CYkAi3jzDP8lBDM/QvkHEdTvc8sSX6OJj5c47xnvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szK0GBcOYJQl3tpE964WrnnH/1ULR88H3hby5qB9bFNfKvu3tETCR5Hb/+osWzGGdav/GSgdW+VoQH9hLa/xmGV0dXyH46KvLX0ppu+uAg3i+VgbV41acSg/Wb/vGfIYNZNIUH7fGuJOmtHCvM0U5/CTlORKdwNvkAV9MqOhUOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=buaH2NJD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745244023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZemooXzBmCB9xX4ZitlTfSWvN1M40kyBD1Fl2rGdnZc=;
	b=buaH2NJDcxsJ0erY3yIMP8gs1P2+xCsgYk42aPAZdA9UUtQIHD6qWMSjM0f8N21chQTPub
	jIeXq4YrjvRfR93IOWMgrmkEb4CEhU5KBTprlvUYqiXfA0LKRrsShEvBWYpl6405OQ2qDH
	4G9XC4i6QkQFj5fDDR9hIKC4HELCePk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-cmqSBwvuPPGFAK-oCcY-nQ-1; Mon, 21 Apr 2025 10:00:20 -0400
X-MC-Unique: cmqSBwvuPPGFAK-oCcY-nQ-1
X-Mimecast-MFC-AGG-ID: cmqSBwvuPPGFAK-oCcY-nQ_1745244020
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b3888569bso341855539f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 07:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745244020; x=1745848820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZemooXzBmCB9xX4ZitlTfSWvN1M40kyBD1Fl2rGdnZc=;
        b=ZTJe/dvkvwanM4IkPLhpWuR96EX2YUpE3YAjqDL6rdsYPhWb64vYTky5ps/HVuGonn
         Nsp9Oq5ToVxB2UUqkOqCWFd770nbMggHHOS/OW4JrIhpH4jMhsi61GGtSG03a2VTffz+
         Vr9hnqVLIUquel/1mI+v9A7iIT43tDVhuNrJs2Z0wcef7p4r4TZUB0kP1TvQ3NapWQn1
         1RoVYwdDXPBSiCnDnH6tN3nOJ83v10l17ZXvjskxkVOMc3wzAOip/EaXYoMjyiDjTh1P
         Mrr9iL111fTwdhFozRN8LYyD+GhwHjiQg0ntREK5DAlXlZvxPX5h07vksIrs4CblKiK0
         8TMw==
X-Gm-Message-State: AOJu0YyfOrcrLsGGlhasMW/R2E/i++Wbo3Nr9V2UQgibnbHwlnRUbHQb
	K/VD3MC4qIZDXrRn69xxpE07bNd36F3B0Jo44+UwZHPFIuzgUqkF4He5LVm0Kzbq3o6KKM2CA9A
	zXEcvOM47DpMLSk3UEFHT6+hauSyy8CEY65hYVDjcT8mzSHo92SH1c0GoYmRZjWI=
X-Gm-Gg: ASbGncv/Lh92kcI1dadGj3pYV8gVXR2CL787hknpQ1MRM2w2Vsl7GeGEthAq3cokGJZ
	cnZ7g86TjPIMyNkmIB75sC6FeaZhcAeL655j1jiJmn/J0TE0DHMCEbAiS6Rt4XwpXZkp9qX0HmV
	1bA+i+F54xHOeC/YtJL680mOhB0Uvr1MJkBx0tkyIURjq5vhiu2G3FCrX5OGPE0RJzQDa4ZPXRF
	zpM/BTOY8bNkm+XZ3tfKJaVhIfFbfTZ9Ux09q8BSiq+Wu0JfdLw5JQeFQedxo4Pt/F9glIafop+
	TSf9znJd5Kpbn3U=
X-Received: by 2002:a6b:4e0b:0:b0:858:7b72:ec89 with SMTP id ca18e2360f4ac-861d89f12d9mr1065682239f.5.1745244019707;
        Mon, 21 Apr 2025 07:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ6SSLDQLW//k8veqFYQTshX2KgkWx0xnluXF+mev8GEmfas5PmCoD/JvRQ2E09J2az5Qc/g==
X-Received: by 2002:a6b:4e0b:0:b0:858:7b72:ec89 with SMTP id ca18e2360f4ac-861d89f12d9mr1065677839f.5.1745244019204;
        Mon, 21 Apr 2025 07:00:19 -0700 (PDT)
Received: from fedora.. ([65.128.104.55])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3839336sm1788866173.73.2025.04.21.07.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:00:18 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	lihongbo22@huawei.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 3/7] f2fs: Allow sbi to be NULL in f2fs_printk
Date: Sun, 20 Apr 2025 10:25:02 -0500
Message-ID: <20250420154647.1233033-4-sandeen@redhat.com>
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

At the parsing phase of the new mount api, sbi will not be
available. So here allows sbi to be NULL in f2fs log helpers
and use that in handle_mount_opt().

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
[sandeen: forward port]
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/f2fs/super.c | 90 +++++++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8343dc2a515d..aeb8e9a48bf6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -321,11 +321,19 @@ void f2fs_printk(struct f2fs_sb_info *sbi, bool limit_rate,
 	vaf.fmt = printk_skip_level(fmt);
 	vaf.va = &args;
 	if (limit_rate)
-		printk_ratelimited("%c%cF2FS-fs (%s): %pV\n",
-			KERN_SOH_ASCII, level, sbi->sb->s_id, &vaf);
+		if (sbi)
+			printk_ratelimited("%c%cF2FS-fs (%s): %pV\n",
+				KERN_SOH_ASCII, level, sbi->sb->s_id, &vaf);
+		else
+			printk_ratelimited("%c%cF2FS-fs: %pV\n",
+				KERN_SOH_ASCII, level, &vaf);
 	else
-		printk("%c%cF2FS-fs (%s): %pV\n",
-			KERN_SOH_ASCII, level, sbi->sb->s_id, &vaf);
+		if (sbi)
+			printk("%c%cF2FS-fs (%s): %pV\n",
+				KERN_SOH_ASCII, level, sbi->sb->s_id, &vaf);
+		else
+			printk("%c%cF2FS-fs: %pV\n",
+				KERN_SOH_ASCII, level, &vaf);
 
 	va_end(args);
 }
@@ -735,13 +743,13 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_discard:
 		if (result.negated) {
 			if (f2fs_hw_should_discard(sbi)) {
-				f2fs_warn(sbi, "discard is required for zoned block devices");
+				f2fs_warn(NULL, "discard is required for zoned block devices");
 				return -EINVAL;
 			}
 			clear_opt(sbi, DISCARD);
 		} else {
 			if (!f2fs_hw_support_discard(sbi)) {
-				f2fs_warn(sbi, "device does not support discard");
+				f2fs_warn(NULL, "device does not support discard");
 				break;
 			}
 			set_opt(sbi, DISCARD);
@@ -749,7 +757,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_noheap:
 	case Opt_heap:
-		f2fs_warn(sbi, "heap/no_heap options were deprecated");
+		f2fs_warn(NULL, "heap/no_heap options were deprecated");
 		break;
 #ifdef CONFIG_F2FS_FS_XATTR
 	case Opt_user_xattr:
@@ -772,7 +780,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_user_xattr:
 	case Opt_inline_xattr:
 	case Opt_inline_xattr_size:
-		f2fs_info(sbi, "%s options not supported", param->key);
+		f2fs_info(NULL, "%s options not supported", param->key);
 		break;
 #endif
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
@@ -784,7 +792,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		break;
 #else
 	case Opt_acl:
-		f2fs_info(sbi, "%s options not supported", param->key);
+		f2fs_info(NULL, "%s options not supported", param->key);
 		break;
 #endif
 	case Opt_active_logs:
@@ -838,7 +846,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_reserve_root:
 		if (test_opt(sbi, RESERVE_ROOT)) {
-			f2fs_info(sbi, "Preserve previous reserve_root=%u",
+			f2fs_info(NULL, "Preserve previous reserve_root=%u",
 				  F2FS_OPTION(sbi).root_reserved_blocks);
 		} else {
 			F2FS_OPTION(sbi).root_reserved_blocks = result.int_32;
@@ -870,7 +878,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 #else
 	case Opt_fault_injection:
 	case Opt_fault_type:
-		f2fs_info(sbi, "%s options not supported", param->key);
+		f2fs_info(NULL, "%s options not supported", param->key);
 		break;
 #endif
 	case Opt_lazytime:
@@ -933,7 +941,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_usrjquota:
 	case Opt_grpjquota:
 	case Opt_prjjquota:
-		f2fs_info(sbi, "quota operations not supported");
+		f2fs_info(NULL, "quota operations not supported");
 		break;
 #endif
 	case Opt_alloc:
@@ -951,7 +959,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
 		set_opt(sbi, INLINECRYPT);
 #else
-		f2fs_info(sbi, "inline encryption not supported");
+		f2fs_info(NULL, "inline encryption not supported");
 #endif
 		break;
 	case Opt_checkpoint:
@@ -991,7 +999,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	case Opt_compress_algorithm:
 		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(sbi, "Image doesn't support compression");
+			f2fs_info(NULL, "Image doesn't support compression");
 			break;
 		}
 		name = param->string;
@@ -1000,7 +1008,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			F2FS_OPTION(sbi).compress_level = 0;
 			F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZO;
 #else
-			f2fs_info(sbi, "kernel doesn't support lzo compression");
+			f2fs_info(NULL, "kernel doesn't support lzo compression");
 #endif
 		} else if (!strncmp(name, "lz4", 3)) {
 #ifdef CONFIG_F2FS_FS_LZ4
@@ -1009,7 +1017,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 				return -EINVAL;
 			F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
 #else
-			f2fs_info(sbi, "kernel doesn't support lz4 compression");
+			f2fs_info(NULL, "kernel doesn't support lz4 compression");
 #endif
 		} else if (!strncmp(name, "zstd", 4)) {
 #ifdef CONFIG_F2FS_FS_ZSTD
@@ -1018,26 +1026,26 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 				return -EINVAL;
 			F2FS_OPTION(sbi).compress_algorithm = COMPRESS_ZSTD;
 #else
-			f2fs_info(sbi, "kernel doesn't support zstd compression");
+			f2fs_info(NULL, "kernel doesn't support zstd compression");
 #endif
 		} else if (!strcmp(name, "lzo-rle")) {
 #ifdef CONFIG_F2FS_FS_LZORLE
 			F2FS_OPTION(sbi).compress_level = 0;
 			F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZORLE;
 #else
-			f2fs_info(sbi, "kernel doesn't support lzorle compression");
+			f2fs_info(NULL, "kernel doesn't support lzorle compression");
 #endif
 		} else
 			return -EINVAL;
 		break;
 	case Opt_compress_log_size:
 		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(sbi, "Image doesn't support compression");
+			f2fs_info(NULL, "Image doesn't support compression");
 			break;
 		}
 		if (result.uint_32 < MIN_COMPRESS_LOG_SIZE ||
 		    result.uint_32 > MAX_COMPRESS_LOG_SIZE) {
-			f2fs_err(sbi,
+			f2fs_err(NULL,
 				"Compress cluster log size is out of range");
 			return -EINVAL;
 		}
@@ -1045,7 +1053,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_compress_extension:
 		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(sbi, "Image doesn't support compression");
+			f2fs_info(NULL, "Image doesn't support compression");
 			break;
 		}
 		name = param->string;
@@ -1054,7 +1062,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 
 		if (strlen(name) >= F2FS_EXTENSION_LEN ||
 		    ext_cnt >= COMPRESS_EXT_NUM) {
-			f2fs_err(sbi, "invalid extension length/number");
+			f2fs_err(NULL, "invalid extension length/number");
 			return -EINVAL;
 		}
 
@@ -1068,7 +1076,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_nocompress_extension:
 		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(sbi, "Image doesn't support compression");
+			f2fs_info(NULL, "Image doesn't support compression");
 			break;
 		}
 		name = param->string;
@@ -1077,7 +1085,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 
 		if (strlen(name) >= F2FS_EXTENSION_LEN ||
 			noext_cnt >= COMPRESS_EXT_NUM) {
-			f2fs_err(sbi, "invalid extension length/number");
+			f2fs_err(NULL, "invalid extension length/number");
 			return -EINVAL;
 		}
 
@@ -1091,21 +1099,21 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_compress_chksum:
 		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(sbi, "Image doesn't support compression");
+			f2fs_info(NULL, "Image doesn't support compression");
 			break;
 		}
 		F2FS_OPTION(sbi).compress_chksum = true;
 		break;
 	case Opt_compress_mode:
 		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(sbi, "Image doesn't support compression");
+			f2fs_info(NULL, "Image doesn't support compression");
 			break;
 		}
 		F2FS_OPTION(sbi).compress_mode = result.uint_32;
 		break;
 	case Opt_compress_cache:
 		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(sbi, "Image doesn't support compression");
+			f2fs_info(NULL, "Image doesn't support compression");
 			break;
 		}
 		set_opt(sbi, COMPRESS_CACHE);
@@ -1118,7 +1126,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_compress_chksum:
 	case Opt_compress_mode:
 	case Opt_compress_cache:
-		f2fs_info(sbi, "compression options not supported");
+		f2fs_info(NULL, "compression options not supported");
 		break;
 #endif
 	case Opt_atgc:
@@ -1203,17 +1211,17 @@ static int f2fs_validate_options(struct f2fs_sb_info *sbi)
 		return -EINVAL;
 #else
 	if (f2fs_sb_has_quota_ino(sbi) && !f2fs_readonly(sbi->sb)) {
-		f2fs_info(sbi, "Filesystem with quota feature cannot be mounted RDWR without CONFIG_QUOTA");
+		f2fs_info(NULL, "Filesystem with quota feature cannot be mounted RDWR without CONFIG_QUOTA");
 		return -EINVAL;
 	}
 	if (f2fs_sb_has_project_quota(sbi) && !f2fs_readonly(sbi->sb)) {
-		f2fs_err(sbi, "Filesystem with project quota feature cannot be mounted RDWR without CONFIG_QUOTA");
+		f2fs_err(NULL, "Filesystem with project quota feature cannot be mounted RDWR without CONFIG_QUOTA");
 		return -EINVAL;
 	}
 #endif
 
 	if (!IS_ENABLED(CONFIG_UNICODE) && f2fs_sb_has_casefold(sbi)) {
-		f2fs_err(sbi,
+		f2fs_err(NULL,
 			"Filesystem with casefold feature cannot be mounted without CONFIG_UNICODE");
 		return -EINVAL;
 	}
@@ -1227,24 +1235,24 @@ static int f2fs_validate_options(struct f2fs_sb_info *sbi)
 #ifdef CONFIG_BLK_DEV_ZONED
 		if (F2FS_OPTION(sbi).discard_unit !=
 						DISCARD_UNIT_SECTION) {
-			f2fs_info(sbi, "Zoned block device doesn't need small discard, set discard_unit=section by default");
+			f2fs_info(NULL, "Zoned block device doesn't need small discard, set discard_unit=section by default");
 			F2FS_OPTION(sbi).discard_unit =
 					DISCARD_UNIT_SECTION;
 		}
 
 		if (F2FS_OPTION(sbi).fs_mode != FS_MODE_LFS) {
-			f2fs_info(sbi, "Only lfs mode is allowed with zoned block device feature");
+			f2fs_info(NULL, "Only lfs mode is allowed with zoned block device feature");
 			return -EINVAL;
 		}
 #else
-		f2fs_err(sbi, "Zoned block device support is not enabled");
+		f2fs_err(NULL, "Zoned block device support is not enabled");
 		return -EINVAL;
 #endif
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_test_compress_extension(sbi)) {
-		f2fs_err(sbi, "invalid compress or nocompress extension");
+		f2fs_err(NULL, "invalid compress or nocompress extension");
 		return -EINVAL;
 	}
 #endif
@@ -1254,11 +1262,11 @@ static int f2fs_validate_options(struct f2fs_sb_info *sbi)
 
 		if (!f2fs_sb_has_extra_attr(sbi) ||
 			!f2fs_sb_has_flexible_inline_xattr(sbi)) {
-			f2fs_err(sbi, "extra_attr or flexible_inline_xattr feature is off");
+			f2fs_err(NULL, "extra_attr or flexible_inline_xattr feature is off");
 			return -EINVAL;
 		}
 		if (!test_opt(sbi, INLINE_XATTR)) {
-			f2fs_err(sbi, "inline_xattr_size option should be set with inline_xattr option");
+			f2fs_err(NULL, "inline_xattr_size option should be set with inline_xattr option");
 			return -EINVAL;
 		}
 
@@ -1267,24 +1275,24 @@ static int f2fs_validate_options(struct f2fs_sb_info *sbi)
 
 		if (F2FS_OPTION(sbi).inline_xattr_size < min_size ||
 				F2FS_OPTION(sbi).inline_xattr_size > max_size) {
-			f2fs_err(sbi, "inline xattr size is out of range: %d ~ %d",
+			f2fs_err(NULL, "inline xattr size is out of range: %d ~ %d",
 				 min_size, max_size);
 			return -EINVAL;
 		}
 	}
 
 	if (test_opt(sbi, ATGC) && f2fs_lfs_mode(sbi)) {
-		f2fs_err(sbi, "LFS is not compatible with ATGC");
+		f2fs_err(NULL, "LFS is not compatible with ATGC");
 		return -EINVAL;
 	}
 
 	if (f2fs_is_readonly(sbi) && test_opt(sbi, FLUSH_MERGE)) {
-		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
+		f2fs_err(NULL, "FLUSH_MERGE not compatible with readonly mode");
 		return -EINVAL;
 	}
 
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
-		f2fs_err(sbi, "Allow to mount readonly mode only");
+		f2fs_err(NULL, "Allow to mount readonly mode only");
 		return -EROFS;
 	}
 
-- 
2.47.0


