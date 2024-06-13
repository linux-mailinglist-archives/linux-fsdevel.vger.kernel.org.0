Return-Path: <linux-fsdevel+bounces-21625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9710E90680F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04CFFB27221
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4635142629;
	Thu, 13 Jun 2024 09:01:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186413F44A;
	Thu, 13 Jun 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269275; cv=none; b=o3CO+1+ktR+s7EnNQI8crWZ/saJQB5J6UPV50jWtgD22sz2MEMZ5DzxN+OU+Iv0h4BI4PzhwHqVB2LmeArGK7B/uwb7fuJw6QeJknw3HnYSw8Y719WV1ZucMI9/ytcdA58RoPuygJVa73+sjSPNjkgfTli0Wae4MaiQAhpZaccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269275; c=relaxed/simple;
	bh=pBXZbUm/Jl5grb2RKQ/TbHzbCh4rKjcU503dKpopY5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyKczP33hp1+0c8KuLNEJT5PpaSjyDVl0PCMtoZG/NV+eBvPsWUVmq1R+QtbSMstJg9eaKDhxOVL96PrMmVwx1crnkdeOt95yGeHrWC2j0oaO10eN7yLSx2gbsW1ZOLJs0827sVw7edx3FUMKWnth1XhUlCThuqJ+Pi1nel1AIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W0Gbh0CLKz4f3kkY;
	Thu, 13 Jun 2024 17:01:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9CD191A0568;
	Thu, 13 Jun 2024 17:01:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFOtWpmHK1uPQ--.16895S12;
	Thu, 13 Jun 2024 17:01:10 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH -next v5 8/8] iomap: don't increase i_size in iomap_write_end()
Date: Thu, 13 Jun 2024 17:00:33 +0800
Message-Id: <20240613090033.2246907-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
References: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFOtWpmHK1uPQ--.16895S12
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW3CFWxCFWUWr48Cw4DJwb_yoWrAF4kpr
	y293yrCan7tw17Wr1kAF98ZryYka4fKFW7CrW7GrWavFn0yr1xKF1rWayYyF95J3srCF4S
	qr4kA3yrWF1UAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUA
	rcfUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

This reverts commit '0841ea4a3b41 ("iomap: keep on increasing i_size in
iomap_write_end()")'.

After xfs could zero out the tail blocks aligned to the allocation
unitsize and convert the tail blocks to unwritten for realtime inode on
truncate down, it couldn't expose any stale data when unaligned truncate
down realtime inodes, so we could keep on stop increasing i_size for
IOMAP_UNSHARE and IOMAP_ZERO in iomap_write_end().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c | 53 +++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4a23c3950a47..75360128f1da 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -891,37 +891,22 @@ static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	loff_t old_size = iter->inode->i_size;
-	size_t written;
 
 	if (srcmap->type == IOMAP_INLINE) {
 		iomap_write_end_inline(iter, folio, pos, copied);
-		written = copied;
-	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
-		written = block_write_end(NULL, iter->inode->i_mapping, pos,
-					len, copied, &folio->page, NULL);
-		WARN_ON_ONCE(written != copied && written != 0);
-	} else {
-		written = __iomap_write_end(iter->inode, pos, len, copied,
-					    folio) ? copied : 0;
+		return true;
 	}
 
-	/*
-	 * Update the in-memory inode size after copying the data into the page
-	 * cache.  It's up to the file system to write the updated size to disk,
-	 * preferably after I/O completion so that no stale data is exposed.
-	 * Only once that's done can we unlock and release the folio.
-	 */
-	if (pos + written > old_size) {
-		i_size_write(iter->inode, pos + written);
-		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
-	}
-	__iomap_put_folio(iter, pos, written, folio);
+	if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
+		size_t bh_written;
 
-	if (old_size < pos)
-		pagecache_isize_extended(iter->inode, old_size, pos);
+		bh_written = block_write_end(NULL, iter->inode->i_mapping, pos,
+					len, copied, &folio->page, NULL);
+		WARN_ON_ONCE(bh_written != copied && bh_written != 0);
+		return bh_written == copied;
+	}
 
-	return written == copied;
+	return __iomap_write_end(iter->inode, pos, len, copied, folio);
 }
 
 static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
@@ -936,6 +921,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 	do {
 		struct folio *folio;
+		loff_t old_size;
 		size_t offset;		/* Offset into folio */
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
@@ -987,6 +973,23 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		written = iomap_write_end(iter, pos, bytes, copied, folio) ?
 			  copied : 0;
 
+		/*
+		 * Update the in-memory inode size after copying the data into
+		 * the page cache.  It's up to the file system to write the
+		 * updated size to disk, preferably after I/O completion so that
+		 * no stale data is exposed.  Only once that's done can we
+		 * unlock and release the folio.
+		 */
+		old_size = iter->inode->i_size;
+		if (pos + written > old_size) {
+			i_size_write(iter->inode, pos + written);
+			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
+		}
+		__iomap_put_folio(iter, pos, written, folio);
+
+		if (old_size < pos)
+			pagecache_isize_extended(iter->inode, old_size, pos);
+
 		cond_resched();
 		if (unlikely(written == 0)) {
 			/*
@@ -1357,6 +1360,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 			bytes = folio_size(folio) - offset;
 
 		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
+		__iomap_put_folio(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
@@ -1422,6 +1426,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_mark_accessed(folio);
 
 		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
+		__iomap_put_folio(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
-- 
2.39.2


