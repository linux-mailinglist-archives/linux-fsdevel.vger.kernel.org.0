Return-Path: <linux-fsdevel+bounces-17777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C48B2295
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB701F277CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50A3149DFF;
	Thu, 25 Apr 2024 13:23:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F9A14A615;
	Thu, 25 Apr 2024 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051392; cv=none; b=shk3ieeLQThKWFvgfqswYFivEkMIklKmY6TKZRRv5iciQFmoZR14CfKqHSFvwAtWWmlJE43mLNg6KPLDZTFcLbQE7swWKWEGfow9yNKeYGdjkkiWkYA6RcB1smScfcV6rToVljlU2WSPgHg+zpyYRdckpZiSDim6rJm5ktsRK2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051392; c=relaxed/simple;
	bh=j2xIiE3AY5vB90b1oFVvadTR9sNvBchDafZ+psVCxPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBdxy3ukzt2zp1CH6dW2D8XhtGkZqwz7T/b6VJN2pnOk+ddh9qrUvwdg+N0qJXN9SpXLi23dyDrxooHWt9lESr0jqOZWQIsdyjJnvsPx7+qzyvciVqj3JSjocUy6f66ZM/KT2f2ygFdgyiM4caug6qhUEaKGOTjSrVhaPo6pLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQGkZ4QvZz4f3kpF;
	Thu, 25 Apr 2024 21:23:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7E7931A016E;
	Thu, 25 Apr 2024 21:23:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBEqWSpmHu+2Kw--.61462S12;
	Thu, 25 Apr 2024 21:23:07 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	tytso@mit.edu,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v5 8/9] iomap: make iomap_write_end() return a boolean
Date: Thu, 25 Apr 2024 21:13:34 +0800
Message-Id: <20240425131335.878454-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
References: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBEqWSpmHu+2Kw--.61462S12
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy3JFW3GrWDZF1kKFW3Wrg_yoW7JrWUpr
	yDK398CFs7Ja17urn5JFy3Zr1Yk34fGrW2krW7G3y3AFn0yrW7K3WrGa4jvF1rJ3s7Ar1f
	JF4vya4rWF1UAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

For now, we can make sure iomap_write_end() always return 0 or copied
bytes, so instead of return written bytes, convert to return a boolean
to indicate the copied bytes have been written to the pagecache.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 48 +++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 854fa3d4b1c8..176a9ea502ba 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -828,7 +828,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	return status;
 }
 
-static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
+static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	flush_dcache_folio(folio);
@@ -845,14 +845,14 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 * redo the whole thing.
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
-		return 0;
+		return false;
 	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
 	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
 	filemap_dirty_folio(inode->i_mapping, folio);
-	return copied;
+	return true;
 }
 
-static size_t iomap_write_end_inline(const struct iomap_iter *iter,
+static void iomap_write_end_inline(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t copied)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -867,20 +867,31 @@ static size_t iomap_write_end_inline(const struct iomap_iter *iter,
 	kunmap_local(addr);
 
 	mark_inode_dirty(iter->inode);
-	return copied;
 }
 
-/* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
-static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
+/*
+ * Returns true if all copied bytes have been written to the pagecache,
+ * otherwise return false.
+ */
+static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 
-	if (srcmap->type == IOMAP_INLINE)
-		return iomap_write_end_inline(iter, folio, pos, copied);
-	if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
-		return block_write_end(NULL, iter->inode->i_mapping, pos, len,
-				       copied, &folio->page, NULL);
+	if (srcmap->type == IOMAP_INLINE) {
+		iomap_write_end_inline(iter, folio, pos, copied);
+		return true;
+	}
+
+	if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
+		size_t bh_written;
+
+		bh_written = block_write_end(NULL, iter->inode->i_mapping, pos,
+					len, copied, &folio->page, NULL);
+		WARN_ON_ONCE(bh_written != copied && bh_written != 0);
+		return bh_written == copied;
+	}
+
 	return __iomap_write_end(iter->inode, pos, len, copied, folio);
 }
 
@@ -945,7 +956,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			flush_dcache_folio(folio);
 
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
-		written = iomap_write_end(iter, pos, bytes, copied, folio);
+		written = iomap_write_end(iter, pos, bytes, copied, folio) ?
+			  copied : 0;
 
 		/*
 		 * Update the in-memory inode size after copying the data into
@@ -1323,6 +1335,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		int status;
 		size_t offset;
 		size_t bytes = min_t(u64, SIZE_MAX, length);
+		bool ret;
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
 		if (unlikely(status))
@@ -1334,9 +1347,9 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		if (bytes > folio_size(folio) - offset)
 			bytes = folio_size(folio) - offset;
 
-		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
 		__iomap_put_folio(iter, pos, bytes, folio);
-		if (WARN_ON_ONCE(bytes == 0))
+		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
 		cond_resched();
@@ -1385,6 +1398,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		int status;
 		size_t offset;
 		size_t bytes = min_t(u64, SIZE_MAX, length);
+		bool ret;
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
 		if (status)
@@ -1399,9 +1413,9 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
-		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
 		__iomap_put_folio(iter, pos, bytes, folio);
-		if (WARN_ON_ONCE(bytes == 0))
+		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
 		pos += bytes;
-- 
2.39.2


