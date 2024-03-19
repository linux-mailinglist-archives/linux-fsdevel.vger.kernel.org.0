Return-Path: <linux-fsdevel+bounces-14790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776D587F509
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 02:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40A1B21EAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 01:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46956657B3;
	Tue, 19 Mar 2024 01:36:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD519626DB;
	Tue, 19 Mar 2024 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812179; cv=none; b=Lfb+dBCSpUKwPqMsm3E/wwqUNSQVK0gadTPe+JJO/SuYZin/eQsrbuuenkSVbSnyxtB3mVatdM3niPpDlwIbJHX9XuIcfTVhbTMPSWswmKyJISf2jxAzk3fLV+BdE0P95udWCRyf0STBwmfTG/HBjTfyvphiq/foyZZLtRNaTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812179; c=relaxed/simple;
	bh=ZOxNZGH26T44uDLSlzArozK/NQN/N5Xe4V3oIK/SBNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m6dI6UlGq5wJ8aze/gmETTqaMDvm1aw9WUZhDeodqHw5G6fR/ygcAr9JNO0qZJr7HJdiG5S7q+PDkp273ViFYZDXATbki3ZIMpFRz1HHvQu9e7+wAr0l31E8MEjBAyi+EYQ8lFM7kH8otAW8xBYimVXjEbS8nuFQYpJQmIrxfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TzDPg3GGTz4f3kKG;
	Tue, 19 Mar 2024 09:18:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4ADFC1A017A;
	Tue, 19 Mar 2024 09:18:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7O5_hlUIGNHQ--.34497S10;
	Tue, 19 Mar 2024 09:18:35 +0800 (CST)
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
Subject: [PATCH v3 6/9] iomap: don't increase i_size if it's not a write operation
Date: Tue, 19 Mar 2024 09:10:59 +0800
Message-Id: <20240319011102.2929635-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
References: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7O5_hlUIGNHQ--.34497S10
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyxtF4xGF1UXF4DKFy8Krg_yoWrAF1Upr
	Wa9a98Can7tF47Wr1kJF98XryYka4rKrW7CrW7G3y3ZFn0yr17KF1rGa4Yvas8J3sxAr4f
	tF4kAayrWF1UCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
	UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Increase i_size in iomap_zero_range() and iomap_unshare_iter() is not
needed, the caller should handle it. Especially, when truncate partial
block, we should not increase i_size beyond the new EOF here. It doesn't
affect xfs and gfs2 now because they set the new file size after zero
out, it doesn't matter that a transient increase in i_size, but it will
affect ext4 because it set file size before truncate. So move the i_size
updating logic to iomap_write_iter().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 50 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7e32a204650b..e9112dc78d15 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -837,32 +837,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
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
-
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
 
-	if (old_size < pos)
-		pagecache_isize_extended(iter->inode, old_size, pos);
-	return ret;
+	if (srcmap->type == IOMAP_INLINE)
+		return iomap_write_end_inline(iter, folio, pos, copied);
+	if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
+		return block_write_end(NULL, iter->inode->i_mapping, pos, len,
+				       copied, &folio->page, NULL);
+	return __iomap_write_end(iter->inode, pos, len, copied, folio);
 }
 
 static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
@@ -877,6 +858,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 	do {
 		struct folio *folio;
+		loff_t old_size;
 		size_t offset;		/* Offset into folio */
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
@@ -926,6 +908,22 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		status = iomap_write_end(iter, pos, bytes, copied, folio);
 
+		/*
+		 * Update the in-memory inode size after copying the data into
+		 * the page cache.  It's up to the file system to write the
+		 * updated size to disk, preferably after I/O completion so that
+		 * no stale data is exposed.  Only once that's done can we
+		 * unlock and release the folio.
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
 		if (status < bytes)
 			iomap_write_failed(iter->inode, pos + status,
 					   bytes - status);
@@ -1298,6 +1296,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 			bytes = folio_size(folio) - offset;
 
 		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		__iomap_put_folio(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
@@ -1362,6 +1361,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_mark_accessed(folio);
 
 		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		__iomap_put_folio(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
-- 
2.39.2


