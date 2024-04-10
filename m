Return-Path: <linux-fsdevel+bounces-16607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC1989FB3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 17:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07B51F2B71E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EFE17335F;
	Wed, 10 Apr 2024 15:11:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B216E86D;
	Wed, 10 Apr 2024 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761918; cv=none; b=NpVPGmPM0khC8QPlIHBhr8ZOS3KH0XEHwfgOYi86YaIjSwrP0VGC6IWfW80O8lARyR6W7nziakFqw+u0QtAFdJgPV7u2MIun3npDJYyZzhUhFU+1RT7Xzius/iCkSJ81azTk63cLSOnFj9QLjkxZ15rYWL0eoHQ4rlWGrA8y2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761918; c=relaxed/simple;
	bh=Py1SPSnSmM02LNWBuDSfAjgXNIjhNrL3rfUfwdnJBrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YVOWR7apHBEkCLnAWoEGBoO3etQ9MMyJcE+DBGa9wu0pma5PiNTeIYWLqJIbySyhw1+40+gJB773w9wIfwEVXYSGz/ZF/VFpW1a1VGSp0fayVx+SxJIbLBOzl4IjinvWPWf7M4J97Mkq1MaatMQ8eLdBeD5DEujgF18fl8DfRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VF5rx0bFsz4f3kjK;
	Wed, 10 Apr 2024 23:11:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E3E851A0E02;
	Wed, 10 Apr 2024 23:11:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g4orBZmFSt+Jg--.51485S9;
	Wed, 10 Apr 2024 23:11:51 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v4 34/34] ext4: add mount option for buffered IO iomap path
Date: Wed, 10 Apr 2024 23:03:13 +0800
Message-Id: <20240410150313.2820364-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g4orBZmFSt+Jg--.51485S9
X-Coremail-Antispam: 1UD129KBjvJXoWxCw13GF15ur4fGw47KF4kWFg_yoWrJr4xp3
	s0gFWrGw1vvryj9FWI9Fs3Xr1Sya1Fka1UCrW09w17XFZrAryIgFyfKF1akF4aqrW8XFyI
	qF1rKF17WFW2krDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UM4x0x7Aq67
	IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E
	14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x0ziBWlDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add buffered_io_iomap mount option to enable buffered IO iomap path for
regular file, this option is disabled by default now.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/inode.c |  2 ++
 fs/ext4/super.c | 16 +++++++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4e7667b21c2f..fef609e6ba7d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1254,6 +1254,7 @@ struct ext4_inode_info {
 						    * scanning in mballoc
 						    */
 #define EXT4_MOUNT2_ABORT		0x00000100 /* Abort filesystem */
+#define EXT4_MOUNT2_BUFFERED_IOMAP	0x00000200 /* Use iomap for buffered IO */
 
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 269503749ef5..c930108f11dd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5120,6 +5120,8 @@ bool ext4_should_use_buffered_iomap(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
+	if (!test_opt2(sb, BUFFERED_IOMAP))
+		return false;
 	if (ext4_has_feature_inline_data(sb))
 		return false;
 	if (ext4_has_feature_verity(sb))
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6410918161a0..c8b691e605f1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1685,7 +1685,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
-	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
+	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan, Opt_buffered_iomap,
 	Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
 #ifdef CONFIG_EXT4_DEBUG
 	Opt_fc_debug_max_replay, Opt_fc_debug_force
@@ -1828,6 +1828,7 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_flag	("no_prefetch_block_bitmaps",
 						Opt_no_prefetch_block_bitmaps),
 	fsparam_s32	("mb_optimize_scan",	Opt_mb_optimize_scan),
+	fsparam_flag	("buffered_iomap",	Opt_buffered_iomap),
 	fsparam_string	("check",		Opt_removed),	/* mount option from ext2/3 */
 	fsparam_flag	("nocheck",		Opt_removed),	/* mount option from ext2/3 */
 	fsparam_flag	("reservation",		Opt_removed),	/* mount option from ext2/3 */
@@ -1922,6 +1923,8 @@ static const struct mount_opts {
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_no_prefetch_block_bitmaps, EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
+	{Opt_buffered_iomap, EXT4_MOUNT2_BUFFERED_IOMAP,
+	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
 #ifdef CONFIG_EXT4_DEBUG
 	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
@@ -2408,6 +2411,11 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		}
 		return 0;
+	case Opt_buffered_iomap:
+		ext4_msg(NULL, KERN_WARNING,
+			 "iomap for buffered enabled. Warning: EXPERIMENTAL, use at your own risk");
+		ctx_set_mount_opt2(ctx, EXT4_MOUNT2_BUFFERED_IOMAP);
+		return 0;
 	}
 
 	/*
@@ -2838,6 +2846,12 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 			    !(sbi->s_mount_opt2 & EXT4_MOUNT2_DAX_INODE))) {
 			goto fail_dax_change_remount;
 		}
+
+		if (ctx_test_mount_opt2(ctx, EXT4_MOUNT2_BUFFERED_IOMAP) &&
+		    !test_opt2(sb, BUFFERED_IOMAP)) {
+			ext4_msg(NULL, KERN_ERR, "can't enable iomap for buffered IO on remount");
+			return -EINVAL;
+		}
 	}
 
 	return ext4_check_quota_consistency(fc, sb);
-- 
2.39.2


