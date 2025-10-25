Return-Path: <linux-fsdevel+bounces-65609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BBFC089F3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9911CC0855
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBDF2DA74D;
	Sat, 25 Oct 2025 03:30:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761EA2BE7AA;
	Sat, 25 Oct 2025 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363013; cv=none; b=BgOyyFuZV3NqUI2ca0w3DbNRBXU2gR+xTaAZbbNxHvYwaXvX10iYvDECe8myZqilX/i8rbr3ElDms+qiewkjf6Cwg4FAARuuVzZu7uzyx+avxeZHWwqFBpG2cY5v1/u7mqCIAavI4SaEQchdtxL54t040JzjkukQ4d9Pwq1OFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363013; c=relaxed/simple;
	bh=tdGmzqmK3vsFjgSp4u1XjHEX9gSZcCKdpe6d8pvVijs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQOkZTsNyw5y33E5ZszqwAYdxXDA6z7nZx8OhbbUkK7VBZAjCZ5azOEddQ/XTXSB8yvuEyvayoocdWBlanVrsYJ9J26N6Ny5uiJ/KbJvqnBKxz6Wl4TjEK6d3VfwJ6brFnTt3Sykh6hUnrAQ9AZVLbORlAZGZEhtqB+8JSKaszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcL2HHKzYQtpV;
	Sat, 25 Oct 2025 11:29:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id ED1331A121D;
	Sat, 25 Oct 2025 11:30:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S25;
	Sat, 25 Oct 2025 11:30:04 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH 21/25] ext4: make online defragmentation support large block size
Date: Sat, 25 Oct 2025 11:22:17 +0800
Message-Id: <20251025032221.2905818-22-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251025032221.2905818-1-libaokun@huaweicloud.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S25
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4kAF48Ww17CFyUCrykKrg_yoW5Wr15pF
	WfAr15Kw45X3ZYgws2grsrZ3s5K3ZrCr48WrW0v34FgFW7tryvga4DA3WkuFyYgrWkJrZ3
	ZFWjkry7W3y5J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAMBWj7UbRJIQAAsW

From: Zhihao Cheng <chengzhihao1@huawei.com>

There are several places assuming that block size <= PAGE_SIZE, modify
them to support large block size (bs > ps).

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/move_extent.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 4b091c21908f..cb55cd9e7eeb 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -270,7 +270,6 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	int i, err2, jblocks, retries = 0;
 	int replaced_count = 0;
 	int from;
-	int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
 	struct super_block *sb = orig_inode->i_sb;
 	struct buffer_head *bh = NULL;
 
@@ -288,11 +287,11 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 		return 0;
 	}
 
-	orig_blk_offset = orig_page_offset * blocks_per_page +
-		data_offset_in_page;
+	orig_blk_offset = EXT4_P_TO_LBLK(orig_inode, orig_page_offset) +
+			  data_offset_in_page;
 
-	donor_blk_offset = donor_page_offset * blocks_per_page +
-		data_offset_in_page;
+	donor_blk_offset = EXT4_P_TO_LBLK(donor_inode, donor_page_offset) +
+			   data_offset_in_page;
 
 	/* Calculate data_size */
 	if ((orig_blk_offset + block_len_in_page - 1) ==
@@ -565,7 +564,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 	struct inode *orig_inode = file_inode(o_filp);
 	struct inode *donor_inode = file_inode(d_filp);
 	struct ext4_ext_path *path = NULL;
-	int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
+	int blocks_per_page = 1;
 	ext4_lblk_t o_end, o_start = orig_blk;
 	ext4_lblk_t d_start = donor_blk;
 	int ret;
@@ -608,6 +607,9 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		return -EOPNOTSUPP;
 	}
 
+	if (i_blocksize(orig_inode) < PAGE_SIZE)
+		blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
+
 	/* Protect orig and donor inodes against a truncate */
 	lock_two_nondirectories(orig_inode, donor_inode);
 
@@ -665,10 +667,8 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		if (o_end - o_start < cur_len)
 			cur_len = o_end - o_start;
 
-		orig_page_index = o_start >> (PAGE_SHIFT -
-					       orig_inode->i_blkbits);
-		donor_page_index = d_start >> (PAGE_SHIFT -
-					       donor_inode->i_blkbits);
+		orig_page_index = EXT4_LBLK_TO_P(orig_inode, o_start);
+		donor_page_index = EXT4_LBLK_TO_P(donor_inode, d_start);
 		offset_in_page = o_start % blocks_per_page;
 		if (cur_len > blocks_per_page - offset_in_page)
 			cur_len = blocks_per_page - offset_in_page;
-- 
2.46.1


