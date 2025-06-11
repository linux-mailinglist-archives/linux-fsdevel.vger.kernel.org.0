Return-Path: <linux-fsdevel+bounces-51311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E08D2AD53FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB51A1890698
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AB325BF07;
	Wed, 11 Jun 2025 11:29:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9212609C7;
	Wed, 11 Jun 2025 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641385; cv=none; b=IRm6Wde78xYIItcBqJ0GobOv+u8PkQXVp+FiRz7fAydVE0I/4ubrPw+Uwffm4U2nyNAhagxhkvKN7rq18XyOyMil/RYBERBrrSKg2Iw68TVkFtPPbf3NL01/inDOm92i7PQf55c1RkDj5gLArwu+kAq4eoa35+vzXlFedgKkXrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641385; c=relaxed/simple;
	bh=rzOMd1WZj1UyrCqbzZ7rp3KTElt1HVNQRYgATXSj3u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNnUU1++vmlfpIdqwwra5LiRtR4Dc2gVDSQspWMWmAiVXTmytDoK3CfK7wPTq+i/1q/Y7QFAI3dhhUlnq0j0qQyj6Lo1J2XVXSQOVtYGR9CUXRYzfF0+RTMrmATaZ3Nft8yZDyUMSevGz9719f/6vOjIa/3xaZyvQnTVXDDFYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bHNjd182rzYQvvR;
	Wed, 11 Jun 2025 19:29:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 288EE1A123A;
	Wed, 11 Jun 2025 19:29:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacOXaElofvDPOw--.32023S7;
	Wed, 11 Jun 2025 19:29:39 +0800 (CST)
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
Subject: [PATCH v2 3/6] ext4: restart handle if credits are insufficient during allocating blocks
Date: Wed, 11 Jun 2025 19:16:22 +0800
Message-ID: <20250611111625.1668035-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacOXaElofvDPOw--.32023S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCF17Zw4kWw1rCF4DGr4rXwb_yoWruryxpr
	W3CFy5Gr1jgryfWF4Sqw4DXF1a93W8trWUJF9xW3sYvayDJry3KF4rtFyYya9YkrW8W3W3
	ZF4jkryjga1jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JULBMNUUUUU=
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
allocating an extent in mpage_map_one_extent() and _ext4_get_block(). If
there are not enough credits, return -EAGAIN, exit the current mapping
loop, restart a new handle and a new transaction, and allocating blocks
on this folio again in the next iteration.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d0db6e3bf158..b51de58518b2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -877,20 +877,44 @@ static void ext4_update_bh_state(struct buffer_head *bh, unsigned long flags)
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
+	int needed_credits;
+	int ret;
+
+	needed_credits = ext4_chunk_trans_blocks(inode, 1);
+	ret = __ext4_journal_ensure_credits(handle, needed_credits,
+					    needed_credits, 0);
+	return ret <= 0 ? ret : -EAGAIN;
+}
+
 static int _ext4_get_block(struct inode *inode, sector_t iblock,
 			   struct buffer_head *bh, int flags)
 {
 	struct ext4_map_blocks map;
+	handle_t *handle = ext4_journal_current_handle();
 	int ret = 0;
 
 	if (ext4_has_inline_data(inode))
 		return -ERANGE;
 
+	/* Make sure transaction has enough credits for this extent */
+	if (flags & EXT4_GET_BLOCKS_CREATE) {
+		ret = ext4_journal_ensure_extent_credits(handle, inode);
+		if (ret)
+			return ret;
+	}
+
 	map.m_lblk = iblock;
 	map.m_len = bh->b_size >> inode->i_blkbits;
 
-	ret = ext4_map_blocks(ext4_journal_current_handle(), inode, &map,
-			      flags);
+	ret = ext4_map_blocks(handle, inode, &map, flags);
 	if (ret > 0) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		ext4_update_bh_state(bh, map.m_flags);
@@ -1374,8 +1398,9 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
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
@@ -2324,6 +2349,11 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
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
@@ -2446,7 +2476,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 			 * In the case of ENOSPC, if ext4_count_free_blocks()
 			 * is non-zero, a commit should free up blocks.
 			 */
-			if ((err == -ENOMEM) ||
+			if ((err == -ENOMEM) || (err == -EAGAIN) ||
 			    (err == -ENOSPC && ext4_count_free_clusters(sb))) {
 				/*
 				 * We may have already allocated extents for
@@ -2953,6 +2983,8 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 			ret = 0;
 			continue;
 		}
+		if (ret == -EAGAIN)
+			ret = 0;
 		/* Fatal error - ENOMEM, EIO... */
 		if (ret)
 			break;
@@ -6722,7 +6754,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		}
 	}
 	ext4_journal_stop(handle);
-	if (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+	if (err == -EAGAIN ||
+	    (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries)))
 		goto retry_alloc;
 out_ret:
 	ret = vmf_fs_error(err);
-- 
2.46.1


