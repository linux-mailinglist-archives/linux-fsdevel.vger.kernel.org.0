Return-Path: <linux-fsdevel+bounces-9176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAE783E983
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80659B28878
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B36731A9D;
	Sat, 27 Jan 2024 02:03:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393E2D056;
	Sat, 27 Jan 2024 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320979; cv=none; b=Ov3pV9RqkVS3z4i0cbf5rpBvvqX+CKR5k8NamLE6CtFuO0YVenP1toTFWkfjlWRplBKAZJFi41C7co6/HD1fw7OQP+eVSCNFV6zHLZjoTKQScrUlirBIluA02ISG8HbwTBLZYjCF8Wz99RUP9uswgmNjhn2Ob/zSYvmCYD2vHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320979; c=relaxed/simple;
	bh=fXpHGrGCIvVOJTo670XC+3UC20y5KS96E2/JbIIohrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXvxtlnMHzsj7po1xRjRlrIwlXsgNFIYaNNUzidI3OVqzVcdlFLlQT9IuvTbkNFN4Biei8pU4hN0S5ErB7AvMPPUXvsc7o/ttPpocKJNknz7+qdAdg8Q5NvBwvdcqyZpSun020qtAWJgIhpHpR8j0t3MjdWAfQkkTMRjilrPi/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TMHrp4Z3Bz4f3lxD;
	Sat, 27 Jan 2024 10:02:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9D66F1A0172;
	Sat, 27 Jan 2024 10:02:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g40ZLRlGJtmCA--.7377S27;
	Sat, 27 Jan 2024 10:02:54 +0800 (CST)
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
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v3 23/26] ext4: fall back to buffer_head path for defrag
Date: Sat, 27 Jan 2024 09:58:22 +0800
Message-Id: <20240127015825.1608160-24-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g40ZLRlGJtmCA--.7377S27
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1fCrW7Jw1fXw17JrykAFb_yoW8Krykpr
	9Ikr15Kr4UXas29rs3tF1UZr15Ka18W3y7uryfW3WxCF4DA34IgFWjkF18Aay5trZ7JrWa
	qF48Cr17Wry7G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbCe
	HDUUUUU==
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


