Return-Path: <linux-fsdevel+bounces-32565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D92E9A96CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0DA286396
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CCD1E9070;
	Tue, 22 Oct 2024 03:13:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2476318EFF8;
	Tue, 22 Oct 2024 03:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566786; cv=none; b=DU7hX21GsFTxXGciC/BvnuumhvtkETkWsaki2yBqLy4BL642bMCYp84C/9q8VAMiSO3/YkwV0qYIXI4KvN55Pf/5R7JOnGwG5MuCAvD4YXsglcHCKsRotSYRVT/gEhYQ24XMh+4i6AKxaESFdSkVIzFkhcSoz5PsugTHipLOt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566786; c=relaxed/simple;
	bh=4NoQniKGHNdVBDky4VIHNSuSe3OHkt9IWIU1DQzi2tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpGIJaF3il8JrNppxXV4fFlnQFpmSYX4erSGAJmWH63IKFMKe/eeMd2CuCvLuFuBJzRynBEaIId8Vsm6Ck1nvy71uybDZ7pcJD6h/Euvh8Z0maBuYV6SoEzxRNoN1wZcFftgJseCfqXFQDdkQohUGKDvr95rf2tkjLlTBCpSYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcgH13tZz4f3lVs;
	Tue, 22 Oct 2024 11:12:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 50B7E1A058E;
	Tue, 22 Oct 2024 11:13:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S23;
	Tue, 22 Oct 2024 11:13:01 +0800 (CST)
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
Subject: [PATCH 19/27] ext4: do not always order data when partial zeroing out a block
Date: Tue, 22 Oct 2024 19:10:50 +0800
Message-ID: <20241022111059.2566137-20-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S23
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr13WFW3JrWDKr4xAry5urg_yoW7Ar13pr
	y5tw45ur47ua4q9F4xWF1DXr1ak3Z3GFW8WrW7G3sYv3s3X3WxKFy5K3WFyF4jgw4xXay0
	qF4YyrWjgw1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRio7uDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When zeroing out a partial block during a partial truncate, zeroing
range, or punching a hole, it is essential to order the data only during
the partial truncate. This is necessary because there is a risk of
exposing stale data. Consider a scenario in which a crash occurs just
after the i_disksize transaction has been submitted but before the
zeroed data is written out. In this case, the tail block will retain
stale data, which could be exposed on the next expand truncate
operation. However, partial zeroing range and punching hole don not have
this risk. Therefore, we could move the ext4_jbd2_inode_add_write() out
to ext4_truncate(), only order data for the partial truncate.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 50 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0a9b73534257..97be75cde481 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4038,7 +4038,9 @@ void ext4_set_aops(struct inode *inode)
  * racing writeback can come later and flush the stale pagecache to disk.
  */
 static int __ext4_block_zero_page_range(handle_t *handle,
-		struct address_space *mapping, loff_t from, loff_t length)
+					struct address_space *mapping,
+					loff_t from, loff_t length,
+					bool *did_zero)
 {
 	ext4_fsblk_t index = from >> PAGE_SHIFT;
 	unsigned offset = from & (PAGE_SIZE-1);
@@ -4116,14 +4118,16 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 
 	if (ext4_should_journal_data(inode)) {
 		err = ext4_dirty_journalled_data(handle, bh);
+		if (err)
+			goto unlock;
 	} else {
 		err = 0;
 		mark_buffer_dirty(bh);
-		if (ext4_should_order_data(inode))
-			err = ext4_jbd2_inode_add_write(handle, inode, from,
-					length);
 	}
 
+	if (did_zero)
+		*did_zero = true;
+
 unlock:
 	folio_unlock(folio);
 	folio_put(folio);
@@ -4138,7 +4142,9 @@ static int __ext4_block_zero_page_range(handle_t *handle,
  * that corresponds to 'from'
  */
 static int ext4_block_zero_page_range(handle_t *handle,
-		struct address_space *mapping, loff_t from, loff_t length)
+				      struct address_space *mapping,
+				      loff_t from, loff_t length,
+				      bool *did_zero)
 {
 	struct inode *inode = mapping->host;
 	unsigned offset = from & (PAGE_SIZE-1);
@@ -4156,7 +4162,8 @@ static int ext4_block_zero_page_range(handle_t *handle,
 		return dax_zero_range(inode, from, length, NULL,
 				      &ext4_iomap_ops);
 	}
-	return __ext4_block_zero_page_range(handle, mapping, from, length);
+	return __ext4_block_zero_page_range(handle, mapping, from, length,
+					    did_zero);
 }
 
 /*
@@ -4166,12 +4173,15 @@ static int ext4_block_zero_page_range(handle_t *handle,
  * of that block so it doesn't yield old data if the file is later grown.
  */
 static int ext4_block_truncate_page(handle_t *handle,
-		struct address_space *mapping, loff_t from)
+				    struct address_space *mapping, loff_t from,
+				    loff_t *zero_len)
 {
 	unsigned offset = from & (PAGE_SIZE-1);
 	unsigned length;
 	unsigned blocksize;
 	struct inode *inode = mapping->host;
+	bool did_zero = false;
+	int ret;
 
 	/* If we are processing an encrypted inode during orphan list handling */
 	if (IS_ENCRYPTED(inode) && !fscrypt_has_encryption_key(inode))
@@ -4180,7 +4190,13 @@ static int ext4_block_truncate_page(handle_t *handle,
 	blocksize = inode->i_sb->s_blocksize;
 	length = blocksize - (offset & (blocksize - 1));
 
-	return ext4_block_zero_page_range(handle, mapping, from, length);
+	ret = ext4_block_zero_page_range(handle, mapping, from, length,
+					 &did_zero);
+	if (ret)
+		return ret;
+
+	*zero_len = length;
+	return 0;
 }
 
 int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
@@ -4203,13 +4219,14 @@ int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 	if (start == end &&
 	    (partial_start || (partial_end != sb->s_blocksize - 1))) {
 		err = ext4_block_zero_page_range(handle, mapping,
-						 lstart, length);
+						 lstart, length, NULL);
 		return err;
 	}
 	/* Handle partial zero out on the start of the range */
 	if (partial_start) {
 		err = ext4_block_zero_page_range(handle, mapping,
-						 lstart, sb->s_blocksize);
+						 lstart, sb->s_blocksize,
+						 NULL);
 		if (err)
 			return err;
 	}
@@ -4217,7 +4234,7 @@ int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 	if (partial_end != sb->s_blocksize - 1)
 		err = ext4_block_zero_page_range(handle, mapping,
 						 byte_end - partial_end,
-						 partial_end + 1);
+						 partial_end + 1, NULL);
 	return err;
 }
 
@@ -4517,6 +4534,7 @@ int ext4_truncate(struct inode *inode)
 	int err = 0, err2;
 	handle_t *handle;
 	struct address_space *mapping = inode->i_mapping;
+	loff_t zero_len = 0;
 
 	/*
 	 * There is a possibility that we're either freeing the inode
@@ -4560,7 +4578,15 @@ int ext4_truncate(struct inode *inode)
 	}
 
 	if (inode->i_size & (inode->i_sb->s_blocksize - 1))
-		ext4_block_truncate_page(handle, mapping, inode->i_size);
+		ext4_block_truncate_page(handle, mapping, inode->i_size,
+					 &zero_len);
+
+	if (zero_len && ext4_should_order_data(inode)) {
+		err = ext4_jbd2_inode_add_write(handle, inode, inode->i_size,
+						zero_len);
+		if (err)
+			goto out_stop;
+	}
 
 	/*
 	 * We add the inode to the orphan list, so that if this
-- 
2.46.1


