Return-Path: <linux-fsdevel+bounces-25857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F3A951270
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0B41F23B1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7F622EEF;
	Wed, 14 Aug 2024 02:32:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212C182B5
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602763; cv=none; b=J1W6KcJak+Wwowtdk5vBWl7lwVbL5bU632DJMH2ChoHUhWZ9C9Cks8TFcaED+nlH3escfNNGH440+/BHzU/iw0zTBYQx632KtVl839y0Qpkkf+mCbh0H7p5t+mlp78dHRx3sSSw3SaLEQBxURbTTZikxMfaclWh1PdZS5atZs1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602763; c=relaxed/simple;
	bh=FwYa3QgulE6sPjneJ3UxwfZoums8ehlg3mYaOR2ms+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmKJ1V0doAkegnijfNuIPgV7yON4L+4SRooAepNGgRidcM6JmffShC8LxpGDd4Ka4PNxBfRt2wpHQxozyQ0j7VYPgpAy1V/QMXTVf5UH/vP6A7w1pTsy75BC5J24K+Ld1vjyovxHipWN7LRpAKbwmmxoTNqKJWFnhKGnsl/yFRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WkBxH3Sh3z1j6Pv;
	Wed, 14 Aug 2024 10:27:47 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id D8CDC140109;
	Wed, 14 Aug 2024 10:32:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 10:32:38 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <brauner@kernel.org>,
	<lczerner@redhat.com>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH 1/9] f2fs: Add fs parameter specifications for mount options
Date: Wed, 14 Aug 2024 10:39:04 +0800
Message-ID: <20240814023912.3959299-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814023912.3959299-1-lihongbo22@huawei.com>
References: <20240814023912.3959299-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Use an array of `fs_parameter_spec` called f2fs_param_specs to
hold the mount option specifications for the new mount api.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/f2fs/super.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3959fd137cc9..1bd923a73c1f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -28,6 +28,7 @@
 #include <linux/part_stat.h>
 #include <linux/zstd.h>
 #include <linux/lz4.h>
+#include <linux/fs_parser.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -189,9 +190,87 @@ enum {
 	Opt_memory_mode,
 	Opt_age_extent_cache,
 	Opt_errors,
+	Opt_jqfmt,
+	Opt_checkpoint,
 	Opt_err,
 };
 
+static const struct constant_table f2fs_param_jqfmt[] = {
+	{"vfsold",	QFMT_VFS_OLD},
+	{"vfsv0",	QFMT_VFS_V0},
+	{"vfsv1",	QFMT_VFS_V1},
+	{}
+};
+
+static const struct fs_parameter_spec f2fs_param_specs[] = {
+	fsparam_string("background_gc", Opt_gc_background),
+	fsparam_flag("disable_roll_forward", Opt_disable_roll_forward),
+	fsparam_flag("norecovery", Opt_norecovery),
+	fsparam_flag("discard", Opt_discard),
+	fsparam_flag("nodiscard", Opt_nodiscard),
+	fsparam_flag("no_heap", Opt_noheap),
+	fsparam_flag("heap", Opt_heap),
+	fsparam_flag("user_xattr", Opt_user_xattr),
+	fsparam_flag("nouser_xattr", Opt_nouser_xattr),
+	fsparam_flag("acl", Opt_acl),
+	fsparam_flag("noacl", Opt_noacl),
+	fsparam_s32("active_logs", Opt_active_logs),
+	fsparam_flag("disable_ext_identify", Opt_disable_ext_identify),
+	fsparam_flag("inline_xattr", Opt_inline_xattr),
+	fsparam_flag("noinline_xattr", Opt_noinline_xattr),
+	fsparam_s32("inline_xattr_size", Opt_inline_xattr_size),
+	fsparam_flag("inline_data", Opt_inline_data),
+	fsparam_flag("inline_dentry", Opt_inline_dentry),
+	fsparam_flag("noinline_dentry", Opt_noinline_dentry),
+	fsparam_flag("flush_merge", Opt_flush_merge),
+	fsparam_flag("noflush_merge", Opt_noflush_merge),
+	fsparam_flag("barrier", Opt_barrier),
+	fsparam_flag("nobarrier", Opt_nobarrier),
+	fsparam_flag("fastboot", Opt_fastboot),
+	fsparam_flag("extent_cache", Opt_extent_cache),
+	fsparam_flag("noextent_cache", Opt_noextent_cache),
+	fsparam_flag("noinline_data", Opt_noinline_data),
+	fsparam_flag("data_flush", Opt_data_flush),
+	fsparam_u32("reserve_root", Opt_reserve_root),
+	fsparam_u32("resgid", Opt_resgid),
+	fsparam_u32("resuid", Opt_resuid),
+	fsparam_string("mode", Opt_mode),
+	fsparam_s32("fault_injection", Opt_fault_injection),
+	fsparam_u32("fault_type", Opt_fault_type),
+	fsparam_flag("quota", Opt_quota),
+	fsparam_flag("noquota", Opt_noquota),
+	fsparam_flag("usrquota", Opt_usrquota),
+	fsparam_flag("grpquota", Opt_grpquota),
+	fsparam_flag("prjquota", Opt_prjquota),
+	fsparam_string_empty("usrjquota", Opt_usrjquota),
+	fsparam_string_empty("grpjquota", Opt_grpjquota),
+	fsparam_string_empty("prjjquota", Opt_prjjquota),
+	fsparam_enum("jqfmt", Opt_jqfmt, f2fs_param_jqfmt),
+	fsparam_string("alloc_mode", Opt_alloc),
+	fsparam_string("fsync_mode", Opt_fsync),
+	fsparam_string("test_dummy_encryption", Opt_test_dummy_encryption),
+	fsparam_flag("test_dummy_encryption", Opt_test_dummy_encryption),
+	fsparam_flag("inlinecrypt", Opt_inlinecrypt),
+	fsparam_string("checkpoint", Opt_checkpoint),
+	fsparam_flag("checkpoint_merge", Opt_checkpoint_merge),
+	fsparam_flag("nocheckpoint_merge", Opt_nocheckpoint_merge),
+	fsparam_string("compress_algorithm", Opt_compress_algorithm),
+	fsparam_u32("compress_log_size", Opt_compress_log_size),
+	fsparam_string("compress_extension", Opt_compress_extension),
+	fsparam_string("nocompress_extension", Opt_nocompress_extension),
+	fsparam_flag("compress_chksum", Opt_compress_chksum),
+	fsparam_string("compress_mode", Opt_compress_mode),
+	fsparam_flag("compress_cache", Opt_compress_cache),
+	fsparam_flag("atgc", Opt_atgc),
+	fsparam_flag("gc_merge", Opt_gc_merge),
+	fsparam_flag("nogc_merge", Opt_nogc_merge),
+	fsparam_string("discard_unit", Opt_discard_unit),
+	fsparam_string("memory", Opt_memory_mode),
+	fsparam_flag("age_extent_cache", Opt_age_extent_cache),
+	fsparam_string("errors", Opt_errors),
+	{}
+};
+
 static match_table_t f2fs_tokens = {
 	{Opt_gc_background, "background_gc=%s"},
 	{Opt_disable_roll_forward, "disable_roll_forward"},
-- 
2.34.1


