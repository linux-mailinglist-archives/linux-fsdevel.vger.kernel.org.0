Return-Path: <linux-fsdevel+bounces-50144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BE6AC884D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 08:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0945C18890B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 06:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB5B20E33F;
	Fri, 30 May 2025 06:41:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417CA10E4;
	Fri, 30 May 2025 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748587294; cv=none; b=aT3nWzh5qV2xoEFazSFc4azjpoBxsAJS0ZzH6UPfznMMoHZ8+7aJRXr2pxBj0FUjeweoBR70k7ZCQH9admoNTpEJdWgCMH+BOp+pfssGaHExnBNFamOCXJHGe4PK1dDTpMm84BHTJV2ZITx7XxJOtHcEIP0HFzWWMT0kfWq6xUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748587294; c=relaxed/simple;
	bh=tUMQBqe6r5aCm9KVSgtfKgYNRS9LTGVsv46mlBlMcDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkPHdCh86yQr2ot3Wt4yh5HZN6XuxoSnI5Wpjbc76E9CHHvWra9eUz3eiQjfqXtmmgPXFcDm61I0EQD01OwHtEcRkf2iLygsv7SzaTiuEMi2bDH/EZUGOgnFCo/U16HwgtlXdIkrqlzX1k/lRxqLxnAoEaZoXJWRczreqTPMoZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b7ttg3yhyzKHLw5;
	Fri, 30 May 2025 14:41:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EBAEA1A0CC7;
	Fri, 30 May 2025 14:41:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl8PUzlo_wXRNw--.6893S5;
	Fri, 30 May 2025 14:41:29 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 1/5] ext4: restart handle if credits are insufficient during writepages
Date: Fri, 30 May 2025 14:28:54 +0800
Message-ID: <20250530062858.458039-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
References: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl8PUzlo_wXRNw--.6893S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw47Kw13XFyrAw17tryDGFg_yoWxXw13pr
	W7C3s8Ca17W3WagF4fZa1kAF1fCw18JrWUJa43KFZ0g3Z8KF97KFy8tFyYyFWjyrs3Za43
	ZF4jk34DGa17AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU4OJ5UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

After large folios are supported on ext4, writing back a sufficiently
large and discontinuous folio may consume a significant number of
journal credits, placing considerable strain on the journal. For
example, in a 20GB filesystem with 1K block size and 1MB journal size,
writing back a 2MB folio could require thousands of credits in the
worst-case scenario (when each block is discontinuous and distributed
across different block groups), potentially exceeding the journal size.

Fix this by making the write-back process first reserves credits for one
page and attempts to extend the transaction if the credits are
insufficient. In particular, if the credits for a transaction reach
their upper limit, stop the handle and initiate a new transaction.

Note that since we do not support partial folio writeouts, some blocks
within this folio may have been allocated. These allocated extents are
submitted through the current transaction, but the folio itself is not
submitted. To prevent stale data and potential deadlocks in ordered
mode, only the dioread_nolock mode supports this solution, as it always
allocate unwritten extents.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 57 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index be9a4cba35fd..5ef34c0c5633 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1680,6 +1680,7 @@ struct mpage_da_data {
 	unsigned int do_map:1;
 	unsigned int scanned_until_end:1;
 	unsigned int journalled_more_data:1;
+	unsigned int continue_map:1;
 };
 
 static void mpage_release_unused_pages(struct mpage_da_data *mpd,
@@ -2367,6 +2368,8 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
  *
  * @handle - handle for journal operations
  * @mpd - extent to map
+ * @needed_blocks - journal credits needed for one writepages iteration
+ * @check_blocks - journal credits needed for map one extent
  * @give_up_on_write - we set this to true iff there is a fatal error and there
  *                     is no hope of writing the data. The caller should discard
  *                     dirty pages to avoid infinite loops.
@@ -2383,6 +2386,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
  */
 static int mpage_map_and_submit_extent(handle_t *handle,
 				       struct mpage_da_data *mpd,
+				       int needed_blocks, int check_blocks,
 				       bool *give_up_on_write)
 {
 	struct inode *inode = mpd->inode;
@@ -2393,6 +2397,8 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 	ext4_io_end_t *io_end = mpd->io_submit.io_end;
 	struct ext4_io_end_vec *io_end_vec;
 
+	mpd->continue_map = 0;
+
 	io_end_vec = ext4_alloc_io_end_vec(io_end);
 	if (IS_ERR(io_end_vec))
 		return PTR_ERR(io_end_vec);
@@ -2439,6 +2445,34 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 		err = mpage_map_and_submit_buffers(mpd);
 		if (err < 0)
 			goto update_disksize;
+		if (!map->m_len)
+			goto update_disksize;
+
+		/*
+		 * For mapping a folio that is sufficiently large and
+		 * discontinuous, the current handle credits may be
+		 * insufficient, try to extend the handle.
+		 */
+		err = __ext4_journal_ensure_credits(handle, check_blocks,
+				needed_blocks, 0);
+		if (err < 0)
+			goto update_disksize;
+		/*
+		 * The credits for the current handle and transaction have
+		 * reached their upper limit, stop the handle and initiate a
+		 * new transaction. Note that some blocks in this folio may
+		 * have been allocated, and these allocated extents are
+		 * submitted through the current transaction, but the folio
+		 * itself is not submitted. To prevent stale data and
+		 * potential deadlock in ordered mode, only the
+		 * dioread_nolock mode supports this.
+		 */
+		if (err > 0) {
+			WARN_ON_ONCE(!ext4_should_dioread_nolock(inode));
+			mpd->continue_map = 1;
+			err = 0;
+			goto update_disksize;
+		}
 	} while (map->m_len);
 
 update_disksize:
@@ -2467,6 +2501,9 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 		if (!err)
 			err = err2;
 	}
+	if (!err && mpd->continue_map)
+		ext4_get_io_end(io_end);
+
 	return err;
 }
 
@@ -2703,7 +2740,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	handle_t *handle = NULL;
 	struct inode *inode = mpd->inode;
 	struct address_space *mapping = inode->i_mapping;
-	int needed_blocks, rsv_blocks = 0, ret = 0;
+	int needed_blocks, check_blocks, rsv_blocks = 0, ret = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
 	struct blk_plug plug;
 	bool give_up_on_write = false;
@@ -2825,10 +2862,13 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 
 	while (!mpd->scanned_until_end && wbc->nr_to_write > 0) {
 		/* For each extent of pages we use new io_end */
-		mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
 		if (!mpd->io_submit.io_end) {
-			ret = -ENOMEM;
-			break;
+			mpd->io_submit.io_end =
+					ext4_init_io_end(inode, GFP_KERNEL);
+			if (!mpd->io_submit.io_end) {
+				ret = -ENOMEM;
+				break;
+			}
 		}
 
 		WARN_ON_ONCE(!mpd->can_map);
@@ -2841,10 +2881,13 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		 */
 		BUG_ON(ext4_should_journal_data(inode));
 		needed_blocks = ext4_da_writepages_trans_blocks(inode);
+		check_blocks = ext4_chunk_trans_blocks(inode,
+				MAX_WRITEPAGES_EXTENT_LEN);
 
 		/* start a new transaction */
 		handle = ext4_journal_start_with_reserve(inode,
-				EXT4_HT_WRITE_PAGE, needed_blocks, rsv_blocks);
+				EXT4_HT_WRITE_PAGE, needed_blocks,
+				mpd->continue_map ? 0 : rsv_blocks);
 		if (IS_ERR(handle)) {
 			ret = PTR_ERR(handle);
 			ext4_msg(inode->i_sb, KERN_CRIT, "%s: jbd2_start: "
@@ -2861,6 +2904,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		ret = mpage_prepare_extent_to_map(mpd);
 		if (!ret && mpd->map.m_len)
 			ret = mpage_map_and_submit_extent(handle, mpd,
+					needed_blocks, check_blocks,
 					&give_up_on_write);
 		/*
 		 * Caution: If the handle is synchronous,
@@ -2894,7 +2938,8 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 			ext4_journal_stop(handle);
 		} else
 			ext4_put_io_end(mpd->io_submit.io_end);
-		mpd->io_submit.io_end = NULL;
+		if (ret || !mpd->continue_map)
+			mpd->io_submit.io_end = NULL;
 
 		if (ret == -ENOSPC && sbi->s_journal) {
 			/*
-- 
2.46.1


