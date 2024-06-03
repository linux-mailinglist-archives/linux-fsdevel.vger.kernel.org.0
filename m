Return-Path: <linux-fsdevel+bounces-20808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE208D8116
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00CC1C21CE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D2484A58;
	Mon,  3 Jun 2024 11:22:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807884A35;
	Mon,  3 Jun 2024 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413759; cv=none; b=R8FHZW4LB2oMjNFMYDOXOR7aR7DWvPpFB+id0DpLY44vmqNq5sdUfYpE8U9U5E8YsF04gW3N3AHNJS4Kr1iuSP1qWGKuQksFnt/dGEX4Hea0WwJTnG6U512IHHGUYeviFL4Tyz0Ofeyl1UWnCSRVgDThmwyA9wwW556p7+gZe7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413759; c=relaxed/simple;
	bh=+1yO6XiLifIlUjN1yQiYVIst+aMZZ4COwNUTz0Nb4JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e02K0Jag1NgQHjgYMpB/LNV2NGaqT+KmxdhAH8zQCtfJnNWpp9yPtuqaqZ2sQV5dru3dkmFb8ju7C6Tm1oK1ejdFGHz4rZn/CM3gdwJBosuG5UlAafEU0X4wWTwaRV/vCkqvdWyX9BPwFKM6u80jMFsu3zIMHIQfoRwMC+IStnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VtBCL0Pmlz4f3nbl;
	Mon,  3 Jun 2024 19:22:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 195A01A0A25;
	Mon,  3 Jun 2024 19:22:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAXKwRop11mWbbQOQ--.26657S4;
	Mon, 03 Jun 2024 19:22:31 +0800 (CST)
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
Subject: [PATCH] iomap: keep on increasing i_size in iomap_write_end()
Date: Mon,  3 Jun 2024 19:22:22 +0800
Message-Id: <20240603112222.2109341-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXKwRop11mWbbQOQ--.26657S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1kZFyUtw1xKr4xuF4UArb_yoWrtr47pr
	ZF93y8CFs7tw47Wr1kAF98ZryYya4fKrW7Cry7Wr4avFn0yr17Kr1rWayYkFyrJ3srCr4S
	qF4kA348WF1UAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	E_M3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Commit '943bc0882ceb ("iomap: don't increase i_size if it's not a write
operation")' breaks xfs with realtime device on generic/561, the problem
is when unaligned truncate down a xfs realtime inode with rtextsize > 1
fs block, xfs only zero out the EOF block but doesn't zero out the tail
blocks that aligned to rtextsize, so if we don't increase i_size in
iomap_write_end(), it could expose stale data after we do an append
write beyond the aligned EOF block.

xfs should zero out the tail blocks when truncate down, but before we
finish that, let's fix the issue by just revert the changes in
iomap_write_end().

Fixes: 943bc0882ceb ("iomap: don't increase i_size if it's not a write operation")
Reported-by: Chandan Babu R <chandanbabu@kernel.org>
Link: https://lore.kernel.org/linux-xfs/0b92a215-9d9b-3788-4504-a520778953c2@huaweicloud.com
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c | 53 +++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c5802a459334..bd70fcbc168e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -877,22 +877,37 @@ static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	loff_t old_size = iter->inode->i_size;
+	size_t written;
 
 	if (srcmap->type == IOMAP_INLINE) {
 		iomap_write_end_inline(iter, folio, pos, copied);
-		return true;
+		written = copied;
+	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
+		written = block_write_end(NULL, iter->inode->i_mapping, pos,
+					len, copied, &folio->page, NULL);
+		WARN_ON_ONCE(written != copied && written != 0);
+	} else {
+		written = __iomap_write_end(iter->inode, pos, len, copied,
+					    folio) ? copied : 0;
 	}
 
-	if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
-		size_t bh_written;
-
-		bh_written = block_write_end(NULL, iter->inode->i_mapping, pos,
-					len, copied, &folio->page, NULL);
-		WARN_ON_ONCE(bh_written != copied && bh_written != 0);
-		return bh_written == copied;
+	/*
+	 * Update the in-memory inode size after copying the data into the page
+	 * cache.  It's up to the file system to write the updated size to disk,
+	 * preferably after I/O completion so that no stale data is exposed.
+	 * Only once that's done can we unlock and release the folio.
+	 */
+	if (pos + written > old_size) {
+		i_size_write(iter->inode, pos + written);
+		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
 	}
+	__iomap_put_folio(iter, pos, written, folio);
 
-	return __iomap_write_end(iter->inode, pos, len, copied, folio);
+	if (old_size < pos)
+		pagecache_isize_extended(iter->inode, old_size, pos);
+
+	return written == copied;
 }
 
 static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
@@ -907,7 +922,6 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 	do {
 		struct folio *folio;
-		loff_t old_size;
 		size_t offset;		/* Offset into folio */
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
@@ -959,23 +973,6 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		written = iomap_write_end(iter, pos, bytes, copied, folio) ?
 			  copied : 0;
 
-		/*
-		 * Update the in-memory inode size after copying the data into
-		 * the page cache.  It's up to the file system to write the
-		 * updated size to disk, preferably after I/O completion so that
-		 * no stale data is exposed.  Only once that's done can we
-		 * unlock and release the folio.
-		 */
-		old_size = iter->inode->i_size;
-		if (pos + written > old_size) {
-			i_size_write(iter->inode, pos + written);
-			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
-		}
-		__iomap_put_folio(iter, pos, written, folio);
-
-		if (old_size < pos)
-			pagecache_isize_extended(iter->inode, old_size, pos);
-
 		cond_resched();
 		if (unlikely(written == 0)) {
 			/*
@@ -1346,7 +1343,6 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 			bytes = folio_size(folio) - offset;
 
 		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
-		__iomap_put_folio(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
@@ -1412,7 +1408,6 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_mark_accessed(folio);
 
 		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
-		__iomap_put_folio(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
-- 
2.39.2


