Return-Path: <linux-fsdevel+bounces-14124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7C8877FFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 13:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F65282833
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873293FB21;
	Mon, 11 Mar 2024 12:30:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402A0383A4;
	Mon, 11 Mar 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160205; cv=none; b=W6M+0+XBwoW3rlHbH1myph7OJeNaChZZIBwmA0KUEQheGr8dN1zVzrhXOQlM18HwTKm4QvmZTUUcg8NzkLYYcq2B2qRP2rrtmWvdZbHiHNOhrKStyYRIjlN6OINymxXI/95hKmu/Az5tI7vIWVMNEqUWzCpGpnPk3fURW4FE5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160205; c=relaxed/simple;
	bh=/YSJHjj7P48+t3yJnDuYkKpzjQlsCrX2SUkLiFTSPKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IsCc7Q57eJtsWcXPZEeIhLYu8X7FenwkAF6uGl1eLjkBHVplyzuDvh0+gksKKp1jzohp66wLY+h4zs8tXfPhfwfrGr4VNn7TjTnC+4dbWk+Q0GyuMPxRmmCESaDdqeeEcmhnxr4sRRuQOBRlLidn/sUTOvImJXfvQef7rsoQO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ttbh31Vzlz4f3jkk;
	Mon, 11 Mar 2024 20:29:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CF65A1A0172;
	Mon, 11 Mar 2024 20:29:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAt+e5lAE9+Gg--.62739S7;
	Mon, 11 Mar 2024 20:29:58 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	tytso@mit.edu,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH 3/4] iomap: don't increase i_size if it's not a write operation
Date: Mon, 11 Mar 2024 20:22:54 +0800
Message-Id: <20240311122255.2637311-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAt+e5lAE9+Gg--.62739S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWkXr13tryfAFy8CFWrGrg_yoW7Jr1fpr
	ZFk3yDCan7JF47Wrn5JF98ZryYkFyrKrW7Cry7G3y3ZFn0yr17K3WrGa4YvF98J3s3Ar4f
	tF4kAa4rWF1UCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFfHUDUUU
	U
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Increase i_size in iomap_zero_range() and iomap_unshare_iter() is not
needed, the caller should handle it. Especially, when truncate partial
block, we could not increase i_size beyond the new EOF here. It doesn't
affect xfs and gfs2 now because they set the new file size after zero
out, it doesn't matter that a transient increase in i_size, but it will
affect ext4 because it set file size before truncate. At the same time,
iomap_write_failed() is also not needed for above two cases too, so
factor them out and move them to iomap_write_iter() and
iomap_zero_iter().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c | 59 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 093c4515b22a..19f91324c690 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -786,7 +786,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 
 out_unlock:
 	__iomap_put_folio(iter, pos, 0, folio);
-	iomap_write_failed(iter->inode, pos, len);
 
 	return status;
 }
@@ -838,34 +837,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	loff_t old_size = iter->inode->i_size;
-	size_t ret;
-
-	if (srcmap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(iter, folio, pos, copied);
-	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
-		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
-				copied, &folio->page, NULL);
-	} else {
-		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
-	}
 
-	/*
-	 * Update the in-memory inode size after copying the data into the page
-	 * cache.  It's up to the file system to write the updated size to disk,
-	 * preferably after I/O completion so that no stale data is exposed.
-	 */
-	if (pos + ret > old_size) {
-		i_size_write(iter->inode, pos + ret);
-		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
-	}
-	__iomap_put_folio(iter, pos, ret, folio);
-
-	if (old_size < pos)
-		pagecache_isize_extended(iter->inode, old_size, pos);
-	if (ret < len)
-		iomap_write_failed(iter->inode, pos + ret, len - ret);
-	return ret;
+	if (srcmap->type == IOMAP_INLINE)
+		return iomap_write_end_inline(iter, folio, pos, copied);
+	if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
+		return block_write_end(NULL, iter->inode->i_mapping, pos, len,
+				       copied, &folio->page, NULL);
+	return __iomap_write_end(iter->inode, pos, len, copied, folio);
 }
 
 static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
@@ -880,6 +858,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 	do {
 		struct folio *folio;
+		loff_t old_size;
 		size_t offset;		/* Offset into folio */
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
@@ -912,8 +891,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		}
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
-		if (unlikely(status))
+		if (unlikely(status)) {
+			iomap_write_failed(iter->inode, pos, bytes);
 			break;
+		}
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
@@ -927,6 +908,24 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		status = iomap_write_end(iter, pos, bytes, copied, folio);
 
+		/*
+		 * Update the in-memory inode size after copying the data into
+		 * the page cache.  It's up to the file system to write the
+		 * updated size to disk, preferably after I/O completion so that
+		 * no stale data is exposed.
+		 */
+		old_size = iter->inode->i_size;
+		if (pos + status > old_size) {
+			i_size_write(iter->inode, pos + status);
+			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
+		}
+		__iomap_put_folio(iter, pos, status, folio);
+
+		if (old_size < pos)
+			pagecache_isize_extended(iter->inode, old_size, pos);
+		if (status < bytes)
+			iomap_write_failed(iter->inode, pos + status,
+					   bytes - status);
 		if (unlikely(copied != status))
 			iov_iter_revert(i, copied - status);
 
@@ -1296,6 +1295,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 			bytes = folio_size(folio) - offset;
 
 		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		__iomap_put_folio(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
@@ -1360,6 +1360,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_mark_accessed(folio);
 
 		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		__iomap_put_folio(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
-- 
2.39.2


