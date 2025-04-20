Return-Path: <linux-fsdevel+bounces-46799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42468A95245
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FF03A9AB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238034C8E;
	Mon, 21 Apr 2025 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpwM8I+G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A37C17BB6
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244024; cv=none; b=krLLEGxt8dQi5y9XUwIqTRTYWHYUsZULqk9kiu9LHgDcuhyrxYFQyXXqFRDrADp5IGn+Jl16Y5sxY6nbJZOhiswMaNuIVaCRJFc2rI+xemSjobRwEl59PLTTDC+bTDh/gorRSi4MGB7SdZvMEy4X8TQzV8384WedQRJCm2N7fJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244024; c=relaxed/simple;
	bh=Wflr0JRboHICodhVZ+eecCrJfHLEbBerwAhlm1/xLuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpHPFI56mZHbM3Q3a7cw8Lx/V5GI7FFcDipAidQkoc36wKOs3MTARPpPxVONoMbqW3+3JLtJLz6BYoCjp/I4lIaGPWclkv1tsGPG5sHgaSn+5W1KaqKNpURR0ESe3mOuRyOGULpLgxvXEOyGhvhIHkTOTDFixxRTjWEf4A/SN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpwM8I+G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745244021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnMSRJ92thPAf8d6gJuz/+gg3IPM/ZWNDFscO+AmVK4=;
	b=cpwM8I+GSldufYGeWuzOPoQYUFNInZ0WjIncv/5yzaQLI9hoW2O74FQxAw8btII7bPD7tg
	cmudXRMFdHH7cTWibW+l6Ww7+6ZmTrUCgPPL57uEFBxMtHw6+3P18UKARFS8J/XZfNn6w0
	9FaLkX07SV5DflAYYdyDtAuCNA7YmOs=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-xE0QO6LmPhC_Yzx0Z2mEqA-1; Mon, 21 Apr 2025 10:00:18 -0400
X-MC-Unique: xE0QO6LmPhC_Yzx0Z2mEqA-1
X-Mimecast-MFC-AGG-ID: xE0QO6LmPhC_Yzx0Z2mEqA_1745244018
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85c552b10b9so386432939f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 07:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745244018; x=1745848818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnMSRJ92thPAf8d6gJuz/+gg3IPM/ZWNDFscO+AmVK4=;
        b=FprObWpRmRgo05uCkHoG+uWkkA1/QwtKWEHsc9U3CYXADtsZTzGgjtjo0tOkAnuZpt
         1heSnYrgR03D8KpT18tYXDaX4EPx4ULqDR0oeUGGqOZn+UBCeHx/t+qBNrhQRVEqiPj8
         s2V64I2Jr7JJj6Kug4tnvXdYmK5hZqLR45YHRPM6vtXCPoevJhFsi7cxurFwgqhsjAeI
         p85Arpjc3V1ZwykS2i054XLlkDb2mrv1vDLpTLWptEK058N3RPoLbtQ8GCrfWMsLN6wE
         j2zK8ZLBInYyxov7eoeYRMrE6z61XyeGV3KIaGG+BTB8P0AnKc75ASqKdnpD3Rib5vlX
         ohVw==
X-Gm-Message-State: AOJu0YxUEwcCpCslTaFZQw2zqDs8qUxQoyL7Ixjq1dtNhe0m6WmAUrMS
	vieXnwOQGTpjn5eWCHcSQyLicVNugSn+xzw0aMMHuWLrYX43GbICcgsqYUuFEnn6X/a1Uq7wuv8
	pAN1LgZdZ6Nkc6WIenYxCaFngLRblz+IfJk5BmDgQLXXuX+ZKJt8cte34mA+RyQA=
X-Gm-Gg: ASbGncvIPuvHwIAzxyQLCiYA3o45Mdv/PSmKmeFQz9BvSminX5JidB+BY+YmT+x2NY9
	lvQA/B7BTHg+40sP615IRRsHgxCme/PHFcF55Jbl+WnH9TBoLZY1Z3K1OawaYAbR8BPUs0vEfil
	xJfL/WxoQeLKUiXd3QmbBuDnNyry1n0ACFRBAOWRdjE4a9jz3hd0dRGifxngTY5kvi1Ha/qsEMQ
	G0lCixc/E4WBQfeBEfnXrliODmB5S2N+j/DQlEQ2kPLioy1eMzjnLhdEMHylTUZLPSsjQlMdmeh
	tnvffhnhV1exmpE=
X-Received: by 2002:a05:6602:2744:b0:85e:2eba:20ad with SMTP id ca18e2360f4ac-861dbdd0e20mr971645039f.2.1745244017880;
        Mon, 21 Apr 2025 07:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjZceBrnW6io/Db5jF8/ovuchTlZqkVCfiBdzbHOG2ADRJhEmL1Qeigz6S80PUNL/BPwvlow==
X-Received: by 2002:a05:6602:2744:b0:85e:2eba:20ad with SMTP id ca18e2360f4ac-861dbdd0e20mr971641339f.2.1745244017383;
        Mon, 21 Apr 2025 07:00:17 -0700 (PDT)
Received: from fedora.. ([65.128.104.55])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3839336sm1788866173.73.2025.04.21.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:00:17 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	lihongbo22@huawei.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 1/7] f2fs: Add fs parameter specifications for mount options
Date: Sun, 20 Apr 2025 10:25:00 -0500
Message-ID: <20250420154647.1233033-2-sandeen@redhat.com>
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

Use an array of `fs_parameter_spec` called f2fs_param_specs to
hold the mount option specifications for the new mount api.

Add constant_table structures for several options to facilitate
parsing.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
[sandeen: forward port, minor fixes and updates, more fsparam_enum]
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/f2fs/super.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f087b2b71c89..c3623e052cde 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -27,6 +27,7 @@
 #include <linux/part_stat.h>
 #include <linux/zstd.h>
 #include <linux/lz4.h>
+#include <linux/fs_parser.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -192,9 +193,130 @@ enum {
 	Opt_age_extent_cache,
 	Opt_errors,
 	Opt_nat_bits,
+	Opt_jqfmt,
+	Opt_checkpoint,
 	Opt_err,
 };
 
+static const struct constant_table f2fs_param_background_gc[] = {
+	{"on",		BGGC_MODE_ON},
+	{"off",		BGGC_MODE_OFF},
+	{"sync",	BGGC_MODE_SYNC},
+	{}
+};
+
+static const struct constant_table f2fs_param_mode[] = {
+	{"adaptive",		FS_MODE_ADAPTIVE},
+	{"lfs",			FS_MODE_LFS},
+	{"fragment:segment",	FS_MODE_FRAGMENT_SEG},
+	{"fragment:block",	FS_MODE_FRAGMENT_BLK},
+	{}
+};
+
+static const struct constant_table f2fs_param_jqfmt[] = {
+	{"vfsold",	QFMT_VFS_OLD},
+	{"vfsv0",	QFMT_VFS_V0},
+	{"vfsv1",	QFMT_VFS_V1},
+	{}
+};
+
+static const struct constant_table f2fs_param_alloc_mode[] = {
+	{"default",	ALLOC_MODE_DEFAULT},
+	{"reuse",	ALLOC_MODE_REUSE},
+	{}
+};
+static const struct constant_table f2fs_param_fsync_mode[] = {
+	{"posix",	FSYNC_MODE_POSIX},
+	{"strict",	FSYNC_MODE_STRICT},
+	{"nobarrier",	FSYNC_MODE_NOBARRIER},
+	{}
+};
+
+static const struct constant_table f2fs_param_compress_mode[] = {
+	{"fs",		COMPR_MODE_FS},
+	{"user",	COMPR_MODE_USER},
+	{}
+};
+
+static const struct constant_table f2fs_param_discard_unit[] = {
+	{"block",	DISCARD_UNIT_BLOCK},
+	{"segment",	DISCARD_UNIT_SEGMENT},
+	{"section",	DISCARD_UNIT_SECTION},
+	{}
+};
+
+static const struct constant_table f2fs_param_memory_mode[] = {
+	{"normal",	MEMORY_MODE_NORMAL},
+	{"low",		MEMORY_MODE_LOW},
+	{}
+};
+
+static const struct constant_table f2fs_param_errors[] = {
+	{"remount-ro",	MOUNT_ERRORS_READONLY},
+	{"continue",	MOUNT_ERRORS_CONTINUE},
+	{"panic",	MOUNT_ERRORS_PANIC},
+	{}
+};
+
+static const struct fs_parameter_spec f2fs_param_specs[] = {
+	fsparam_enum("background_gc", Opt_gc_background, f2fs_param_background_gc),
+	fsparam_flag("disable_roll_forward", Opt_disable_roll_forward),
+	fsparam_flag("norecovery", Opt_norecovery),
+	fsparam_flag_no("discard", Opt_discard),
+	fsparam_flag("no_heap", Opt_noheap),
+	fsparam_flag("heap", Opt_heap),
+	fsparam_flag_no("user_xattr", Opt_user_xattr),
+	fsparam_flag_no("acl", Opt_acl),
+	fsparam_s32("active_logs", Opt_active_logs),
+	fsparam_flag("disable_ext_identify", Opt_disable_ext_identify),
+	fsparam_flag_no("inline_xattr", Opt_inline_xattr),
+	fsparam_s32("inline_xattr_size", Opt_inline_xattr_size),
+	fsparam_flag_no("inline_data", Opt_inline_data),
+	fsparam_flag_no("inline_dentry", Opt_inline_dentry),
+	fsparam_flag_no("flush_merge", Opt_flush_merge),
+	fsparam_flag_no("barrier", Opt_barrier),
+	fsparam_flag("fastboot", Opt_fastboot),
+	fsparam_flag_no("extent_cache", Opt_extent_cache),
+	fsparam_flag("data_flush", Opt_data_flush),
+	fsparam_u32("reserve_root", Opt_reserve_root),
+	fsparam_gid("resgid", Opt_resgid),
+	fsparam_uid("resuid", Opt_resuid),
+	fsparam_enum("mode", Opt_mode, f2fs_param_mode),
+	fsparam_s32("fault_injection", Opt_fault_injection),
+	fsparam_u32("fault_type", Opt_fault_type),
+	fsparam_flag_no("lazytime", Opt_lazytime),
+	fsparam_flag_no("quota", Opt_quota),
+	fsparam_flag("usrquota", Opt_usrquota),
+	fsparam_flag("grpquota", Opt_grpquota),
+	fsparam_flag("prjquota", Opt_prjquota),
+	fsparam_string_empty("usrjquota", Opt_usrjquota),
+	fsparam_string_empty("grpjquota", Opt_grpjquota),
+	fsparam_string_empty("prjjquota", Opt_prjjquota),
+	fsparam_flag("nat_bits", Opt_nat_bits),
+	fsparam_enum("jqfmt", Opt_jqfmt, f2fs_param_jqfmt),
+	fsparam_enum("alloc_mode", Opt_alloc, f2fs_param_alloc_mode),
+	fsparam_enum("fsync_mode", Opt_fsync, f2fs_param_fsync_mode),
+	fsparam_string("test_dummy_encryption", Opt_test_dummy_encryption),
+	fsparam_flag("test_dummy_encryption", Opt_test_dummy_encryption),
+	fsparam_flag("inlinecrypt", Opt_inlinecrypt),
+	fsparam_string("checkpoint", Opt_checkpoint),
+	fsparam_flag_no("checkpoint_merge", Opt_checkpoint_merge),
+	fsparam_string("compress_algorithm", Opt_compress_algorithm),
+	fsparam_u32("compress_log_size", Opt_compress_log_size),
+	fsparam_string("compress_extension", Opt_compress_extension),
+	fsparam_string("nocompress_extension", Opt_nocompress_extension),
+	fsparam_flag("compress_chksum", Opt_compress_chksum),
+	fsparam_enum("compress_mode", Opt_compress_mode, f2fs_param_compress_mode),
+	fsparam_flag("compress_cache", Opt_compress_cache),
+	fsparam_flag("atgc", Opt_atgc),
+	fsparam_flag_no("gc_merge", Opt_gc_merge),
+	fsparam_enum("discard_unit", Opt_discard_unit, f2fs_param_discard_unit),
+	fsparam_enum("memory", Opt_memory_mode, f2fs_param_memory_mode),
+	fsparam_flag("age_extent_cache", Opt_age_extent_cache),
+	fsparam_enum("errors", Opt_errors, f2fs_param_errors),
+	{}
+};
+
 static match_table_t f2fs_tokens = {
 	{Opt_gc_background, "background_gc=%s"},
 	{Opt_disable_roll_forward, "disable_roll_forward"},
-- 
2.47.0


