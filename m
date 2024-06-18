Return-Path: <linux-fsdevel+bounces-21886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1D90D576
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 16:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28B91C224DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 14:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6715EFB3;
	Tue, 18 Jun 2024 14:22:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD715E5DC;
	Tue, 18 Jun 2024 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720532; cv=none; b=EmhW9YvNVc2tieWkY5s+U/7ajYbbbKfWy1E8WvAwf1ndgEX7AlvE4mQVirZyIIlHBlJcO39c0sHTdOsByMxVsB47FuJSPLL4ek4/dAjLhUg5mjAjrLpOfmXi0LvdcQQlw0Xp1rxHwJbROlKie409ZINifFlVVzWjaJHqg0/iRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720532; c=relaxed/simple;
	bh=ug/qQNK60ThJr6Wmrm9eMouW+oYEz5AG/qVXhu9+0z0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5gEblcsy0DmZOExhEtm/XUp4gNDze89pBUF8GvRLLAZRQNvSJ6HY7Zbq5+Pv6FLDyE9kL8dBVcva6C3S6mgG3HKwvAAix2AnFOUnFLKKW6DN2QCFiV8OXBX7DJVBXPXnnmtskc9Wht+K60q2B5KUJGZX6BUnTNc1N/9qgQvvns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W3TTb6Vt2z4f3nTP;
	Tue, 18 Jun 2024 22:21:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A7CA01A112A;
	Tue, 18 Jun 2024 22:22:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB34A0ImHFmVDEoAQ--.31709S6;
	Tue, 18 Jun 2024 22:22:07 +0800 (CST)
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
Subject: [PATCH -next v6 2/2] iomap: don't increase i_size in iomap_write_end()
Date: Tue, 18 Jun 2024 22:21:12 +0800
Message-Id: <20240618142112.1315279-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618142112.1315279-1-yi.zhang@huaweicloud.com>
References: <20240618142112.1315279-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB34A0ImHFmVDEoAQ--.31709S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW3CFWxCFWUWr48Cw4DJwb_yoWrAF45pr
	9F9ayrCan7tw17Wr1kAF98ZryYkayfKFW7CrW7WrWavFn0yr1xKF1ruayYyFyrJ3s3AF4f
	Xr4kA34rWF1UAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAGYLUUUUU
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

This reverts commit '0841ea4a3b41 ("iomap: keep on increasing i_size in
iomap_write_end()")'.

After xfs could zero out the tail blocks aligned to the allocation
unitsize and convert the tail blocks to unwritten for realtime inode on
truncate down, it couldn't expose any stale data when unaligned truncate
down realtime inodes, so we could keep on keeping i_size for
IOMAP_UNSHARE and IOMAP_ZERO in iomap_write_end().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c | 53 +++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d46558990279..99bedc3f7c39 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -878,37 +878,22 @@ static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
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
@@ -923,6 +908,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 	do {
 		struct folio *folio;
+		loff_t old_size;
 		size_t offset;		/* Offset into folio */
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
@@ -974,6 +960,23 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
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
@@ -1344,6 +1347,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 			bytes = folio_size(folio) - offset;
 
 		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
+		__iomap_put_folio(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
@@ -1409,6 +1413,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_mark_accessed(folio);
 
 		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
+		__iomap_put_folio(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
-- 
2.39.2


