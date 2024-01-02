Return-Path: <linux-fsdevel+bounces-7111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69B6821BFE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA2E1C21EF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEF3F9FC;
	Tue,  2 Jan 2024 12:42:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769A154BB;
	Tue,  2 Jan 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4CD73xCcz4f3l8D;
	Tue,  2 Jan 2024 20:42:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 442EF1A6C6A;
	Tue,  2 Jan 2024 20:42:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnwUGUBJRl+EvDFQ--.31823S26;
	Tue, 02 Jan 2024 20:42:17 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v2 22/25] ext4: fall back to buffer_head path for defrag
Date: Tue,  2 Jan 2024 20:39:15 +0800
Message-Id: <20240102123918.799062-23-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnwUGUBJRl+EvDFQ--.31823S26
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1fCrW7Jw1fXw17JrykAFb_yoW8Krykpr
	9Ikr15Kr4UXas29rs3tF1UZr15Ka18W3y7uryfW3WxCF4DA34IgFWjkF18Aay5trZ7JrWa
	qF48Cr17Wry7G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Online defrag doesn't support iomap path yet, so we have to fall back to
buffer_head path for inodes which have been useing iomap. Fall back
active inode is dangerous, we must writeback and drop all dirty pages
under inode lock and mapping->invalidate_lock, those can protect us from
adding new folios into mapping.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/move_extent.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 3aa57376d9c2..7a9ca71d4cac 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -538,6 +538,34 @@ mext_check_arguments(struct inode *orig_inode,
 	return 0;
 }
 
+/*
+ * Disable buffered iomap path for the inode that requiring move extents,
+ * fallback to buffer_head path.
+ */
+static int ext4_disable_buffered_iomap_aops(struct inode *inode)
+{
+	int err;
+
+	/*
+	 * The buffered_head aops don't know how to handle folios
+	 * dirtied by iomap, so before falling back, flush all dirty
+	 * folios the inode has.
+	 */
+	filemap_invalidate_lock(inode->i_mapping);
+	err = filemap_write_and_wait(inode->i_mapping);
+	if (err < 0) {
+		filemap_invalidate_unlock(inode->i_mapping);
+		return err;
+	}
+	truncate_inode_pages(inode->i_mapping, 0);
+
+	ext4_clear_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+	ext4_set_aops(inode);
+	filemap_invalidate_unlock(inode->i_mapping);
+
+	return 0;
+}
+
 /**
  * ext4_move_extents - Exchange the specified range of a file
  *
@@ -609,6 +637,12 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 	inode_dio_wait(orig_inode);
 	inode_dio_wait(donor_inode);
 
+	/* Fallback to buffer_head aops for inodes with buffered iomap aops */
+	if (ext4_test_inode_state(orig_inode, EXT4_STATE_BUFFERED_IOMAP))
+		ext4_disable_buffered_iomap_aops(orig_inode);
+	if (ext4_test_inode_state(donor_inode, EXT4_STATE_BUFFERED_IOMAP))
+		ext4_disable_buffered_iomap_aops(donor_inode);
+
 	/* Protect extent tree against block allocations via delalloc */
 	ext4_double_down_write_data_sem(orig_inode, donor_inode);
 	/* Check the filesystem environment whether move_extent can be done */
-- 
2.39.2


