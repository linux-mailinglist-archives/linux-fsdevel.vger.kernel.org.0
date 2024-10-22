Return-Path: <linux-fsdevel+bounces-32573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344669A96E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597411C24FC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5DF20409E;
	Tue, 22 Oct 2024 03:13:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5570E200109;
	Tue, 22 Oct 2024 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566791; cv=none; b=RcRw68I1MAid/0YhzUg9G12DApj7fBrxGxqxAUT9ZbXZFq4B4FmoyJLQTzwgqF3wUD2zrkxmJ+rOnY9hyCHqdHVdru+9kvsnDKpfsZDDOAfB9w0mC/mgRoOrPBq6sIdqwO21NUD5Vq3RJvZb9vN+yZmG3CBrELCd0J5CQ0l9PUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566791; c=relaxed/simple;
	bh=OAzCCl3m2q23m1U+qcLkhExvUHjt8Ff1nVP57Z12V6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISr+Zrdmrj/8Fcl4/paJCjDmHkYROINytjIcGVczotiiYIuVgDxxxFMMu9w+7sTG0yLRUUnK/F/81M2z+StNahAdRYW/WVwYDnow8hW4CrJLqCgGhdpkWfGAbymqfqlyc97KJliDmQWe2Zdk+gB41hLQ1MglNKbIKOHvhGNPqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcgN1lZBz4f3lVx;
	Tue, 22 Oct 2024 11:12:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 67C5D1A058E;
	Tue, 22 Oct 2024 11:13:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S31;
	Tue, 22 Oct 2024 11:13:06 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 27/27] ext4: introduce a mount option for iomap buffered I/O path
Date: Tue, 22 Oct 2024 19:10:58 +0800
Message-ID: <20241022111059.2566137-28-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S31
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW3WFyrtryxWF4xKw1rWFg_yoW5Cr18p3
	sYkFy8Gr1kZr1F93y8CF48Wr1FkF4Yka1UuFWYgw17WFZrAryxXFyfKF1rCF42qrW8XryI
	gF1rWw17WF43CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I64
	8v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRio7uDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Introduce the buffered_iomap and the nobuffered_iomap mount options to
enable the iomap buffered I/O path for regular files. This option is
currently disabled by default until we can support more comprehensive
features along this path.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  | 1 +
 fs/ext4/inode.c | 2 ++
 fs/ext4/super.c | 7 +++++++
 3 files changed, 10 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0096191b454c..c2a44530e026 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1257,6 +1257,7 @@ struct ext4_inode_info {
 						    * scanning in mballoc
 						    */
 #define EXT4_MOUNT2_ABORT		0x00000100 /* Abort filesystem */
+#define EXT4_MOUNT2_BUFFERED_IOMAP	0x00000200 /* Use iomap for buffered IO */
 
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 97abc88e6658..b6e041a423f9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5153,6 +5153,8 @@ bool ext4_should_use_buffered_iomap(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
+	if (!test_opt2(sb, BUFFERED_IOMAP))
+		return false;
 	if (ext4_has_feature_inline_data(sb))
 		return false;
 	if (ext4_has_feature_verity(sb))
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 89955081c4fe..435a866359d9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1675,6 +1675,7 @@ enum {
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
 	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
+	Opt_buffered_iomap, Opt_nobuffered_iomap,
 	Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
 #ifdef CONFIG_EXT4_DEBUG
 	Opt_fc_debug_max_replay, Opt_fc_debug_force
@@ -1806,6 +1807,8 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_flag("no_prefetch_block_bitmaps",
 						Opt_no_prefetch_block_bitmaps),
 	fsparam_s32("mb_optimize_scan",		Opt_mb_optimize_scan),
+	fsparam_flag("buffered_iomap",		Opt_buffered_iomap),
+	fsparam_flag("nobuffered_iomap",	Opt_nobuffered_iomap),
 	fsparam_string("check",			Opt_removed),	/* mount option from ext2/3 */
 	fsparam_flag("nocheck",			Opt_removed),	/* mount option from ext2/3 */
 	fsparam_flag("reservation",		Opt_removed),	/* mount option from ext2/3 */
@@ -1900,6 +1903,10 @@ static const struct mount_opts {
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_no_prefetch_block_bitmaps, EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
+	{Opt_buffered_iomap, EXT4_MOUNT2_BUFFERED_IOMAP,
+	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
+	{Opt_nobuffered_iomap, EXT4_MOUNT2_BUFFERED_IOMAP,
+	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
 #ifdef CONFIG_EXT4_DEBUG
 	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
-- 
2.46.1


