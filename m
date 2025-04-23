Return-Path: <linux-fsdevel+bounces-47246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC63FA9AFD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C751B8351A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA0C19D8A7;
	Thu, 24 Apr 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOdb90vc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A5219ABAC
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502674; cv=none; b=YBV+yU2kTxzGsCQBXM8sKGT++S8FN22BMnsjwUu9dV2/kG3nphqEBvf8bjF7MR6KCYp5yMWimU860HeGHvc3QfefriMU/bmr9AsMW4OOfTS4uMU7NUzpUDHcR2wNbcuwvLmtZgQ/MjJZzf6492IlowW0/pG0a57FIroJpUKn0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502674; c=relaxed/simple;
	bh=f7q6swJ4m4I+0V3DQiBLsYs7Iq+r4GB9c2yjY0lzLuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fszfSJ9RJS3TYwW7osbCBDr2kgusKTtU2TWSlVAomfvFJBmSoQkeMoM377S0KfxijNdJ5KbRDGlLy23pddR79MjmaMhjKaIlh0j3u9FvwLmr3jVY9dXj4Tsb+9mIiLVrh2lMBvG5u+hOBpgkoXQQcakUwEX6MnF43ME1b2nfz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOdb90vc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745502671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20X8W8gEmww41Q7n61pHQxjGF1NcC1fUPUqP1znWNZ8=;
	b=GOdb90vcW4r0/Ywequ2P2m8AEiP7D2pzKkkH46vk+ZpvMPslKs6c7A595h6u1KSG1jhH/s
	7MlnDvfvuHYCyg50DWjPOzgkT6wNQRcnFOALRxbPWa9/4S9voxMTJPQMduU6y/kcfdT39M
	md/DOUtiMehCBUXg+s4mNp+5SP2GCRk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-44nQ2sHOOPKqWjPxLzXIqw-1; Thu, 24 Apr 2025 09:51:08 -0400
X-MC-Unique: 44nQ2sHOOPKqWjPxLzXIqw-1
X-Mimecast-MFC-AGG-ID: 44nQ2sHOOPKqWjPxLzXIqw_1745502667
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-72c316b7bfbso349232a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 06:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745502667; x=1746107467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20X8W8gEmww41Q7n61pHQxjGF1NcC1fUPUqP1znWNZ8=;
        b=VQ/7W/KsJcrqYm73vnHjHL1j5OIHlXcsTYjXnDSgvRWxXL+Qcqcqeb0V4UrcZlPB3f
         rK9pLCLixUXA/VGTR1bXQfzc6R7MBemw6bkjueVzlX2BocGjbMwd5tgZcuGLM1RDZLKz
         KCM5POZN0wCRygdzeqle3/Jy+KcDKGmyi4FwwEkKkNkO6qGfPIkt3dyqLw/exK9DVOcP
         DsCgS5pv2J6iyqHT/HeVWo/maUlAZ0qInoO+vbzu50Ou+AFLACjTRvcPHsMBpzCIxH/H
         /m4Ax98wm7UnDZ3Pg0G8kUuCFujuXKkhUuxb1yv053JbMWBazT8F3dEIzhni3cNFa7MG
         rF0w==
X-Gm-Message-State: AOJu0YypWi1Qejbch0oMDeKs5EEOCw65rCIzBtk4Ob+JWr2OrB9vzXkd
	91kkYOhoIrGBiAPrEFu0Cq/iGzzM1n8eKp6zhOVabDkAlbjyfFOMw/J5NyPk5MOw+PAezIxu4WH
	YVneF9Gvuvs9zQzr/AaF8+mn7fes82Z6WHu8N4NdwG/jIz6GcEfhH1xugj/Fpe+3imhgz2oLucg
	==
X-Gm-Gg: ASbGnctEpV7oHJ6I2Y4RKfEoRuGhnjjBYLAoxANgKyWIr0SSptKfdyqxYSio+VBTErl
	VMHC3/ogCa7j8cvknX/gQAYXcuySZdnzo0mAxkpg9+Wgd7N8wWUn5sw/W8ihqLD4D7ArNq3XDTM
	dixdIMlDkAaDf+RwLwVch5HDSmZcUUatZsI49JcMdjO+OI8URzoSYgKR4kg2wn7fssmUXq/hF/o
	m+LP9SLBw3/nw+rX/MUVb2p0cJNHuqdH6maEhJcRTVV8TNl14sCaoXItOBb29HwGk3lDQKVzyC8
	OgjPpqSBlOCnwuFBBL6ncz9q4xhiemXozSXhUlPsXCFD12QUzr52Wnw=
X-Received: by 2002:a05:6830:369b:b0:72b:99eb:7ce3 with SMTP id 46e09a7af769-7304dbcd9admr1458742a34.18.1745502667357;
        Thu, 24 Apr 2025 06:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUBkT8IuBa3hPdLMhwDATE3HSR3z4HwnotaHQjVHnEdLznwt0jtuOY3c4oz91usD9ZH5XVCA==
X-Received: by 2002:a05:6830:369b:b0:72b:99eb:7ce3 with SMTP id 46e09a7af769-7304dbcd9admr1458729a34.18.1745502666931;
        Thu, 24 Apr 2025 06:51:06 -0700 (PDT)
Received: from localhost.localdomain (nwtn-09-2828.dsl.iowatelecom.net. [67.224.43.12])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f37b158sm233595a34.49.2025.04.24.06.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 06:51:06 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	lihongbo22@huawei.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V3 1/7] f2fs: Add fs parameter specifications for mount options
Date: Wed, 23 Apr 2025 12:08:45 -0500
Message-ID: <20250423170926.76007-2-sandeen@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423170926.76007-1-sandeen@redhat.com>
References: <20250423170926.76007-1-sandeen@redhat.com>
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
index 22f26871b7aa..ebea03bba054 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -27,6 +27,7 @@
 #include <linux/part_stat.h>
 #include <linux/zstd.h>
 #include <linux/lz4.h>
+#include <linux/fs_parser.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -194,9 +195,130 @@ enum {
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
2.49.0


