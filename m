Return-Path: <linux-fsdevel+bounces-14893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B878810AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 12:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFAA284B9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755E34879E;
	Wed, 20 Mar 2024 11:13:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C043FB82;
	Wed, 20 Mar 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933197; cv=none; b=QtTUq7rBUD0skqZsLj1yTVhnuvx1B1/G3GPGP4DwHYggX9sM8tvozmZ7+//e3o8FDNaP3q4ciNfGU6kPErOydAAWVJKIT98PxaKTbx4MsH+zx/1jnvcRPMXRq5iPF0D2bVc7IoM/Z8e/JiGy08imQ3UqS+ucQ/aNyKWyccmN4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933197; c=relaxed/simple;
	bh=+2+F9+MEvsmtcE0qu/7DE+bBgJCe28zdqAJjgGrin9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nx6LBFh1AwOvYuq9O5oKgW75A+Faeovi+Q/KC1ftMg8IwsQBWiyQutBygiwhfHZy1qEb6UERzINSoQvzRxScdJK+frlPLdaFK6kp2WcNZBVNon3V4/TKiBuGin6RT3PyiTer9+r13ftT8ZlaKE0JzS2zP9cKsv2MSXxDAdZ3fzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V05YJ3vwGz4f3lXS;
	Wed, 20 Mar 2024 19:13:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 682861A0D04;
	Wed, 20 Mar 2024 19:13:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBG5xPplGX0fHg--.18516S12;
	Wed, 20 Mar 2024 19:13:12 +0800 (CST)
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
Subject: [PATCH v4 8/9] iomap: make iomap_write_end() return a boolean
Date: Wed, 20 Mar 2024 19:05:47 +0800
Message-Id: <20240320110548.2200662-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320110548.2200662-1-yi.zhang@huaweicloud.com>
References: <20240320110548.2200662-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBG5xPplGX0fHg--.18516S12
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy3JFW7CrWDtr43CF45KFg_yoW7JrWUpr
	yqg398CFs7Ja17Wrn5JFy3Zr1Yk34fKrW2krW7G3y3AFn0yrW7K3WrGa4YvF18J3s7Ar4f
	JF4kAa4rWF1UAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
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
index 291648c61a32..dc863a76c72a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -790,7 +790,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	return status;
 }
 
-static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
+static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	flush_dcache_folio(folio);
@@ -807,14 +807,14 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
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
@@ -829,20 +829,31 @@ static size_t iomap_write_end_inline(const struct iomap_iter *iter,
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
 
@@ -907,7 +918,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			flush_dcache_folio(folio);
 
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
-		written = iomap_write_end(iter, pos, bytes, copied, folio);
+		written = iomap_write_end(iter, pos, bytes, copied, folio) ?
+			  copied : 0;
 
 		/*
 		 * Update the in-memory inode size after copying the data into
@@ -1285,6 +1297,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		int status;
 		size_t offset;
 		size_t bytes = min_t(u64, SIZE_MAX, length);
+		bool ret;
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
 		if (unlikely(status))
@@ -1296,9 +1309,9 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		if (bytes > folio_size(folio) - offset)
 			bytes = folio_size(folio) - offset;
 
-		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
 		__iomap_put_folio(iter, pos, bytes, folio);
-		if (WARN_ON_ONCE(bytes == 0))
+		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
 		cond_resched();
@@ -1347,6 +1360,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		int status;
 		size_t offset;
 		size_t bytes = min_t(u64, SIZE_MAX, length);
+		bool ret;
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
 		if (status)
@@ -1361,9 +1375,9 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
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


