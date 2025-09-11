Return-Path: <linux-fsdevel+bounces-60906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD0FB52C9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83E7174D5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 09:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94E12E7659;
	Thu, 11 Sep 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="AiV/ui8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [211.125.139.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769061F5851
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581554; cv=none; b=h9zT8IDBBQzJPEecTi3WTWA3jOCYC+82nP9ApUxuXCO+jnb5Kr0lcKdx6jRurVfZUctdKTQkjFUUq01dnOxJE+oMKk2ba7hIQFgTxx36mlna1BMEbdE4PK83LX2HG1FNn/1UuG2YsN+gip7l9mV3/jHFl/mD/l/1DHbAtIUP4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581554; c=relaxed/simple;
	bh=96RbpWqEUk3KAJI0CRe2vr0irB7Sl8Eb+vZwxU96948=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dtLFDAoj+oDx0lFiFaw4JLGZ806KhzbDBX1dPqINVBn6lN5ynPc62cwAKNcdfESe0dxEIPRyfMWaCDa9vG+XVdToCeRGDhLHL+KPLAvu+07nH/KmlQHfT4FHrZHu8LekzrBa9thbjXXyev6UHZmPlP+CBxdJTE/KV9ZZpbldtOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=AiV/ui8H; arc=none smtp.client-ip=211.125.139.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1757581551; x=1789117551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/rpyll2HCvBdI5xCgwUZOU6JQIUKjDDXqIxsJP75zZQ=;
  b=AiV/ui8HuG6B9tYZzArQJXy1ieo68J3uDDUOw9fJdb4v/gj9Nr/GX3EN
   ryupNDou34wtxkplg8kg5Kvx/OtfT57JURbKk7j3wIut/zTNtoQN4ojvw
   mnszbqEdR2f2Fv7iHQCWp51Tumxl6YYs1UQOH3VmNKDzgkI5E9MmGzTSR
   KANbgmuEnFnWB3bPGsF/HcSEgymjI698LDnQpLIyFyXN1koxJpGZI6bsv
   qWLQ2Bp5nS6lebAdNPY5w9yRCBa+rd2yd6R/aNpUfBdS6AtTtxbcpf13C
   PhKFEW4Y4xbrge534IpT5iXsD8yAuytXXEQL/pM1C5zYoBNHFPry8JM9m
   A==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 17:55:41 +0900
X-IronPort-AV: E=Sophos;i="6.18,256,1751209200"; 
   d="scan'208";a="31377955"
Received: from unknown (HELO cscsh-7000014390..) ([43.82.111.225])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 11 Sep 2025 17:55:40 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1] exfat: support modifying mount options via remount
Date: Thu, 11 Sep 2025 16:54:31 +0800
Message-ID: <20250911085430.939450-2-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before this commit, all exfat-defined mount options could not be
modified dynamically via remount, and no error was returned.

After this commit, these three exfat-defined mount options
(discard, zero_size_dir, and errors) can be modified dynamically
via remount. While other exfat-defined mount options cannot be
modified dynamically via remount because their old settings are
cached in inodes or dentries, modifying them will be rejected with
an error.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
---
 fs/exfat/super.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 7ed858937d45..9e2e8c1e9609 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -243,11 +243,11 @@ static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_u32oct("allow_utime",		Opt_allow_utime),
 	fsparam_string("iocharset",		Opt_charset),
 	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
-	fsparam_flag("discard",			Opt_discard),
+	fsparam_flag_no("discard",		Opt_discard),
 	fsparam_flag("keep_last_dots",		Opt_keep_last_dots),
 	fsparam_flag("sys_tz",			Opt_sys_tz),
 	fsparam_s32("time_offset",		Opt_time_offset),
-	fsparam_flag("zero_size_dir",		Opt_zero_size_dir),
+	fsparam_flag_no("zero_size_dir",	Opt_zero_size_dir),
 	__fsparam(NULL, "utf8",			Opt_utf8, fs_param_deprecated,
 		  NULL),
 	__fsparam(NULL, "debug",		Opt_debug, fs_param_deprecated,
@@ -299,7 +299,7 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		opts->errors = result.uint_32;
 		break;
 	case Opt_discard:
-		opts->discard = 1;
+		opts->discard = !result.negated;
 		break;
 	case Opt_keep_last_dots:
 		opts->keep_last_dots = 1;
@@ -317,7 +317,7 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		opts->time_offset = result.int_32;
 		break;
 	case Opt_zero_size_dir:
-		opts->zero_size_dir = true;
+		opts->zero_size_dir = !result.negated;
 		break;
 	case Opt_utf8:
 	case Opt_debug:
@@ -732,12 +732,44 @@ static void exfat_free(struct fs_context *fc)
 static int exfat_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
+	struct exfat_sb_info *remount_sbi = fc->s_fs_info;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_mount_options *new_opts = &remount_sbi->options;
+	struct exfat_mount_options *cur_opts = &sbi->options;
+
 	fc->sb_flags |= SB_NODIRATIME;
 
 	sync_filesystem(sb);
-	mutex_lock(&EXFAT_SB(sb)->s_lock);
+	mutex_lock(&sbi->s_lock);
 	exfat_clear_volume_dirty(sb);
-	mutex_unlock(&EXFAT_SB(sb)->s_lock);
+	mutex_unlock(&sbi->s_lock);
+
+	if (new_opts->allow_utime == (unsigned short)-1)
+		new_opts->allow_utime = ~new_opts->fs_dmask & 0022;
+
+	/*
+	 * Since the old settings of these mount options are cached in
+	 * inodes or dentries, they cannot be modified dynamically.
+	 */
+	if (strcmp(new_opts->iocharset, cur_opts->iocharset) ||
+	    new_opts->keep_last_dots != cur_opts->keep_last_dots ||
+	    new_opts->sys_tz != cur_opts->sys_tz ||
+	    new_opts->time_offset != cur_opts->time_offset ||
+	    !uid_eq(new_opts->fs_uid, cur_opts->fs_uid) ||
+	    !gid_eq(new_opts->fs_gid, cur_opts->fs_gid) ||
+	    new_opts->fs_fmask != cur_opts->fs_fmask ||
+	    new_opts->fs_dmask != cur_opts->fs_dmask ||
+	    new_opts->allow_utime != cur_opts->allow_utime)
+		return -EINVAL;
+
+	if (new_opts->discard != cur_opts->discard &&
+	    new_opts->discard &&
+	    !bdev_max_discard_sectors(sb->s_bdev)) {
+		exfat_warn(sb, "remounting with \"discard\" option, but the device does not support discard");
+		return -EINVAL;
+	}
+
+	swap(*cur_opts, *new_opts);
 
 	return 0;
 }
-- 
2.43.0


