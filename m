Return-Path: <linux-fsdevel+bounces-47078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD4AA984B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 11:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8EC443DF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEEA269817;
	Wed, 23 Apr 2025 09:03:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780DF244680;
	Wed, 23 Apr 2025 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399015; cv=none; b=lPbzKcTHqJFIC6zDTIbe4BNq/fc0632EemtE/tH5R2GGh2S+vn0mzjd2IfeZJ0k6r/UmA+eB6NCmoUPh7CYp/f9mZgHalwvTExEVtLkP9k2wpR5wmUOubZgt3uMipP3eHWQyuiHO4yLQBGUjvPkEHLCgeZxoeh7tKeTaVkKqlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399015; c=relaxed/simple;
	bh=5qonOrAsfTrMiV50stYsopM8z5sSlvXvSkRIkGbDMIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rvz8AXIJp5CshxP9LIlXWT+9CzktbbD9yn7lp09JMiH/dHJPncITzxESjk92ISaIcM2PFcbay/HHc3jAVJh+mw+vFRSBizl391swmXzzBLNvVwb3fXkhWvpPp4JXrYkqluhSbheTZtNT5xysgxdw5epeeq5UiANlGnf2KBC0tjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZjCn01nxKz4f3jdH;
	Wed, 23 Apr 2025 17:03:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 356981A1D38;
	Wed, 23 Apr 2025 17:03:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacPQrAhoJkGrKA--.8976S12;
	Wed, 23 Apr 2025 17:03:24 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 8/9] ext4: check env when mapping and modifying extents
Date: Wed, 23 Apr 2025 16:52:56 +0800
Message-ID: <20250423085257.122685-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
References: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacPQrAhoJkGrKA--.8976S12
X-Coremail-Antispam: 1UD129KBjvJXoWxZw43CF1fJF4kZF1fur4rXwb_yoW5Kr15p3
	sxAr1rWw4rW34v9392qF1DZr1rKa18KrW7Ga4xur4qqa4UJr1fKF15tFyIvF1FgrW8Ar4Y
	vF4Fkry7Xw4fG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUo73vUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add ext4_check_map_extents_env() to the places where loading extents,
mapping blocks, removing blocks, and modifying extents, excluding the
I/O writeback context. This function will verify whether the locking
mechanisms in place are adequate.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c |  6 ++++++
 fs/ext4/inode.c   | 14 +++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b5eb89ef7ae2..52bfc042bf4e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -611,6 +611,8 @@ int ext4_ext_precache(struct inode *inode)
 	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		return 0;	/* not an extent-mapped inode */
 
+	ext4_check_map_extents_env(inode);
+
 	down_read(&ei->i_data_sem);
 	depth = ext_depth(inode);
 
@@ -5342,6 +5344,8 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	start_lblk = offset >> inode->i_blkbits;
 	end_lblk = (offset + len) >> inode->i_blkbits;
 
+	ext4_check_map_extents_env(inode);
+
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ext4_discard_preallocations(inode);
 	ext4_es_remove_extent(inode, start_lblk, EXT_MAX_BLOCKS - start_lblk);
@@ -5443,6 +5447,8 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	start_lblk = offset >> inode->i_blkbits;
 	len_lblk = len >> inode->i_blkbits;
 
+	ext4_check_map_extents_env(inode);
+
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ext4_discard_preallocations(inode);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 74c7a902a41d..1211ad7fa98d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -650,11 +650,14 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		return -EFSCORRUPTED;
 
 	/*
-	 * Do not allow caching of unrelated ranges of extents during I/O
-	 * submission.
+	 * Callers from the context of data submission are the only exceptions
+	 * for regular files that do not hold the i_rwsem or invalidate_lock.
+	 * However, caching unrelated ranges is not permitted.
 	 */
 	if (flags & EXT4_GET_BLOCKS_IO_SUBMIT)
 		WARN_ON_ONCE(!(flags & EXT4_EX_NOCACHE));
+	else
+		ext4_check_map_extents_env(inode);
 
 	/* Lookup extent status tree firstly */
 	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
@@ -1799,6 +1802,8 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 	ext_debug(inode, "max_blocks %u, logical block %lu\n", map->m_len,
 		  (unsigned long) map->m_lblk);
 
+	ext4_check_map_extents_env(inode);
+
 	/* Lookup extent status tree firstly */
 	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
 		map->m_len = min_t(unsigned int, map->m_len,
@@ -4110,6 +4115,8 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (end_lblk > start_lblk) {
 		ext4_lblk_t hole_len = end_lblk - start_lblk;
 
+		ext4_check_map_extents_env(inode);
+
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode);
 
@@ -4262,8 +4269,9 @@ int ext4_truncate(struct inode *inode)
 	if (err)
 		goto out_stop;
 
-	down_write(&EXT4_I(inode)->i_data_sem);
+	ext4_check_map_extents_env(inode);
 
+	down_write(&EXT4_I(inode)->i_data_sem);
 	ext4_discard_preallocations(inode);
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-- 
2.46.1


