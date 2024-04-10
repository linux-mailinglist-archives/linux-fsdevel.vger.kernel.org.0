Return-Path: <linux-fsdevel+bounces-16602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887FF89FB2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 17:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41057288108
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA3716E873;
	Wed, 10 Apr 2024 15:11:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B916DEB3;
	Wed, 10 Apr 2024 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761915; cv=none; b=F/ixcgKAfcp5OUoT2bdbcm3UOubK+YTksr4QeRrpz8j8FnoqdI6PXL80A+e6aiinnCFophoJjq6da8WZAu6N/W2N9vnhDa30D7FuCL6EeI3eaORy8U1wfXPlcfNbgu3o+/4hQnME+Uj8CfbcdoRcUFeJhEmIidvnOlB3z32mPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761915; c=relaxed/simple;
	bh=2L9ruEgKU7GYbMGJOT2FsQxcS+TeocaV5OhumlCSjAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCqamYHrAB0mpIKw3hFH/mHRRNw+5gaFOegCxju5VhCwt/YvzskFZ9GSN2DP+LHTvwZIZ6WelQm5tHsoDqciccUWGEL/MK3ojCZNPIE2Gr4+7VaqRRen1ZbZ4pqBAw4pqKatUcdcsz17euUnNQL2wCRb2ROa0Nz9/+aFK+EGhbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VF5rs57vfz4f3khg;
	Wed, 10 Apr 2024 23:11:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8B4C61A0175;
	Wed, 10 Apr 2024 23:11:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g4orBZmFSt+Jg--.51485S4;
	Wed, 10 Apr 2024 23:11:48 +0800 (CST)
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
Subject: [RFC PATCH v4 29/34] ext4: fall back to buffer_head path for defrag
Date: Wed, 10 Apr 2024 23:03:08 +0800
Message-Id: <20240410150313.2820364-1-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn9g4orBZmFSt+Jg--.51485S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw45KryfZr4UWr15ZF1xuFg_yoW8Kry5pr
	9Ikr15Kr4DXas29Fn3ta4UZr1rKa10g3y7urWfW3WxJFWDA34IgFyjkF1UAFW5trZ7JrWa
	qF40kr17W347G3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r
	4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG6xCI17CEII8v
	rVW3JVW8Jr1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7Mx
	kF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AK
	xVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxU0dgAUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Online defrag doesn't support iomap path yet, we have to fall back to
buffer_head path for the inode which has been using iomap. Changing
active inode is dangerous, before we start, we must hold the inode lock
and the mapping->invalidate_lock, and writeback all dirty folios and
drop the inode's pagecache.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/move_extent.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 7cd4afa4de1d..3db255385367 100644
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


