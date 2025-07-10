Return-Path: <linux-fsdevel+bounces-54483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF1B00165
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 14:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FFB3AE2C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87172255F22;
	Thu, 10 Jul 2025 12:15:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97131226CFC
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149749; cv=none; b=El9pSkKo48W57WG9y4htVvfg92IreKiGdz14+pnBfXOCgyZvqrZ8G859y/voLuCvXlz6bUv7sL+/O6cWT6qkGTyA6VNxglfgIzN9Rg2guBQ2NXlwtKCczvO5wPxqrafAqLh2L4fcFNJwbXs/sEbsgOzf2R88HO9c+93iqNtzkOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149749; c=relaxed/simple;
	bh=21xJj5J11uclfAAgas18S/GRWY4uzXr4y29pggQGKgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyDLqYwoNDnbQBe3dyN+0qeZbpqD5aRVeuUzqE/AnwAT9umwBrJuOLsLWoArCobb7JcpQWGLGm73qPGT+KGiBHCUxY3l8IdagzgQf3syYMPLLs7mKDf/3M7HbPvZGE2fAPpQKTWWKgHOX5fcIk9oYHdG5cf+oqRIUCadrDGLN4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bdDJH2h1zz1d1h5;
	Thu, 10 Jul 2025 20:13:03 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 792A2140118;
	Thu, 10 Jul 2025 20:15:43 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Jul
 2025 20:15:42 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>, <sandeen@redhat.com>
Subject: [PATCH v5 1/7] f2fs: Add fs parameter specifications for mount options
Date: Thu, 10 Jul 2025 12:14:09 +0000
Message-ID: <20250710121415.628398-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250710121415.628398-1-lihongbo22@huawei.com>
References: <20250710121415.628398-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

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
index 73492270ea93..713dc55f086b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -27,6 +27,7 @@
 #include <linux/part_stat.h>
 #include <linux/zstd.h>
 #include <linux/lz4.h>
+#include <linux/fs_parser.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -196,9 +197,130 @@ enum {
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
2.33.0


