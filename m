Return-Path: <linux-fsdevel+bounces-53511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A979AEFA2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4356D16E930
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD8275AE0;
	Tue,  1 Jul 2025 13:21:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD69274661;
	Tue,  1 Jul 2025 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376063; cv=none; b=Z4+10CZK8a63c5i5dhUVZiAMzVN/GEPf6+p7t/qUW6I9AW8PXPE9lgggxvmEENTfZrZQi2Gen+B0ZTxpTIMLhH6BxUlCKpj8iSgzqF2Ru0VGfPhmkGTsIXkNbPxScUVnwbwhwMP3I7jxUtvvuQlNHEl/bk5W9iEcMoSlvR2Vmvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376063; c=relaxed/simple;
	bh=OMzw7fwuDNBES4pa/3F/wT/AyXaB44di+mYgT56ndXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=potTR2kZ1oO6RJEv9xvHPbfx0n8AHdWpLA+5DI+TpWY1oI4D2J+13R+51SLZfWzBKp6VcJebcXN6efHzlWTkuBiICfHs1kbIf3pv9ddIc2n6q4IE+0FRNiSJfdwcsJoxMngUzKm61qBVEScHxCIiasoNSbdEA9qqvee4yIEQ+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bWkDs1dFdzKHN5g;
	Tue,  1 Jul 2025 21:21:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 972C61A0E0A;
	Tue,  1 Jul 2025 21:20:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXeCWu4GNoXmJGAQ--.26904S9;
	Tue, 01 Jul 2025 21:20:59 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	sashal@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 05/10] ext4: restart handle if credits are insufficient during allocating blocks
Date: Tue,  1 Jul 2025 21:06:30 +0800
Message-ID: <20250701130635.4079595-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXeCWu4GNoXmJGAQ--.26904S9
X-Coremail-Antispam: 1UD129KBjvJXoWxCF17Zw4kWw1rCF4DGrWruFg_yoWrCF4Dpr
	WakFy5Gr17Wry3Wanaqw4DXF13W3WxtrWUJF93W3s0vFy8GrnxKFs0yFyYyFWvkrWkWa13
	XF4jkryUWayjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUriihUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

After large folios are supported on ext4, writing back a sufficiently
large and discontinuous folio may consume a significant number of
journal credits, placing considerable strain on the journal. For
example, in a 20GB filesystem with 1K block size and 1MB journal size,
writing back a 2MB folio could require thousands of credits in the
worst-case scenario (when each block is discontinuous and distributed
across different block groups), potentially exceeding the journal size.
This issue can also occur in ext4_write_begin() and ext4_page_mkwrite()
when delalloc is not enabled.

Fix this by ensuring that there are sufficient journal credits before
allocating an extent in mpage_map_one_extent() and
ext4_block_write_begin(). If there are not enough credits, return
-EAGAIN, exit the current mapping loop, restart a new handle and a new
transaction, and allocating blocks on this folio again in the next
iteration.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 31731a732df2..efe778aaf74b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -877,6 +877,25 @@ static void ext4_update_bh_state(struct buffer_head *bh, unsigned long flags)
 	} while (unlikely(!try_cmpxchg(&bh->b_state, &old_state, new_state)));
 }
 
+/*
+ * Make sure that the current journal transaction has enough credits to map
+ * one extent. Return -EAGAIN if it cannot extend the current running
+ * transaction.
+ */
+static inline int ext4_journal_ensure_extent_credits(handle_t *handle,
+						     struct inode *inode)
+{
+	int credits;
+	int ret;
+
+	if (!handle)
+		return 0;
+
+	credits = ext4_chunk_trans_blocks(inode, 1);
+	ret = __ext4_journal_ensure_credits(handle, credits, credits, 0);
+	return ret <= 0 ? ret : -EAGAIN;
+}
+
 static int _ext4_get_block(struct inode *inode, sector_t iblock,
 			   struct buffer_head *bh, int flags)
 {
@@ -1175,7 +1194,9 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			WARN_ON(bh->b_size != blocksize);
-			err = get_block(inode, block, bh, 1);
+			err = ext4_journal_ensure_extent_credits(handle, inode);
+			if (!err)
+				err = get_block(inode, block, bh, 1);
 			if (err)
 				break;
 			if (buffer_new(bh)) {
@@ -1374,8 +1395,9 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 				ext4_orphan_del(NULL, inode);
 		}
 
-		if (ret == -ENOSPC &&
-		    ext4_should_retry_alloc(inode->i_sb, &retries))
+		if (ret == -EAGAIN ||
+		    (ret == -ENOSPC &&
+		     ext4_should_retry_alloc(inode->i_sb, &retries)))
 			goto retry_journal;
 		folio_put(folio);
 		return ret;
@@ -2323,6 +2345,11 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	int get_blocks_flags;
 	int err, dioread_nolock;
 
+	/* Make sure transaction has enough credits for this extent */
+	err = ext4_journal_ensure_extent_credits(handle, inode);
+	if (err < 0)
+		return err;
+
 	trace_ext4_da_write_pages_extent(inode, map);
 	/*
 	 * Call ext4_map_blocks() to allocate any delayed allocation blocks, or
@@ -2450,7 +2477,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 			 * In the case of ENOSPC, if ext4_count_free_blocks()
 			 * is non-zero, a commit should free up blocks.
 			 */
-			if ((err == -ENOMEM) ||
+			if ((err == -ENOMEM) || (err == -EAGAIN) ||
 			    (err == -ENOSPC && ext4_count_free_clusters(sb))) {
 				/*
 				 * We may have already allocated extents for
@@ -2956,6 +2983,8 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 			ret = 0;
 			continue;
 		}
+		if (ret == -EAGAIN)
+			ret = 0;
 		/* Fatal error - ENOMEM, EIO... */
 		if (ret)
 			break;
@@ -6734,7 +6763,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 retry_alloc:
 	/* Start jorunal and allocate blocks */
 	err = ext4_block_page_mkwrite(inode, folio, get_block);
-	if (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+	if (err == -EAGAIN ||
+	    (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries)))
 		goto retry_alloc;
 out_ret:
 	ret = vmf_fs_error(err);
-- 
2.46.1


