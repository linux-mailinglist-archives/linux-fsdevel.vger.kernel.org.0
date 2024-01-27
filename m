Return-Path: <linux-fsdevel+bounces-9160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7496C83E94C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD3A1F2978E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC901F927;
	Sat, 27 Jan 2024 02:02:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5F11CA9;
	Sat, 27 Jan 2024 02:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320969; cv=none; b=sbyhiiToIBE74OrqCnS/JhRfSdFgm1n9qllNO1KtVS/oWrNF787FzdfmdTq8xxENEed7hSQfhOaVQoFcTo1aDaSBgo9LeDm/RxNScFSmR+PQiJapInNf7bZmoSFIe9aIYO8QbmzScnbFivd2yWFOZlQSEu7I2iulRp6Zm0DOeV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320969; c=relaxed/simple;
	bh=eqSL2CFLIXiZZNI+yz+FjOzM7KNrAeIFjC+NeUimJEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rlDO0nXGaOop5jveBBarTSB6ASFGw91m5Ij6GFJ1FFTYxc1WBQ75UErCfxKHpc9oVU8HtivmPHNdxX2KI6NJeNQk0xC5/kZ2Hyka50Hxbu2cpz1ntyvmeiVx271TYYOCe20dEsQe6baDzpIjoBD/6HMyfcBHbwEjJGZgDOAqLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TMHrc0D1qz4f3lwb;
	Sat, 27 Jan 2024 10:02:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0910A1A01E9;
	Sat, 27 Jan 2024 10:02:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g40ZLRlGJtmCA--.7377S11;
	Sat, 27 Jan 2024 10:02:43 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v3 07/26] iomap: don't increase i_size if it's not a write operation
Date: Sat, 27 Jan 2024 09:58:06 +0800
Message-Id: <20240127015825.1608160-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g40ZLRlGJtmCA--.7377S11
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWkXr1UuF4fKr18XF4UCFg_yoW5ZFWxpr
	WDK398Crs7JF47Wrn5JF98Xr1Yk34rGrW2kFWxG3y3ZFn0yr47K3W8KayY9F18J3s7Ar4f
	JF4vya4rWr1UCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Increase i_size in iomap_zero_range() and iomap_unshare_iter() is not
needed, the caller should handle it. Especially, when truncate partial
block, we could not increase i_size beyond the new EOF here. It dosn't
affect xfs and gfs2 now because they reset the new file size after zero
out, it doesn't matter that a brief increase in i_size, but it will
affect ext4 because it set file size before truncate. At the same time,
iomap_write_failed() is also not needed for above two cases too, so
let's introduce a new helper iomap_write_end_simple() to replace the
common iomap_write_end() helper which designed for buffer write, and
also move out iomap_write_failed() from iomap_write_begin() to
iomap_write_iter().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e0c9cede82ee..2ae936e5af74 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -834,7 +834,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 
 out_unlock:
 	__iomap_put_folio(iter, pos, 0, folio);
-	iomap_write_failed(iter->inode, pos, len);
 
 	return status;
 }
@@ -881,6 +880,25 @@ static size_t iomap_write_end_inline(const struct iomap_iter *iter,
 	return copied;
 }
 
+static size_t iomap_write_end_simple(struct iomap_iter *iter, loff_t pos,
+		size_t len, struct folio *folio)
+{
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	size_t ret;
+
+	if (srcmap->type == IOMAP_INLINE) {
+		ret = iomap_write_end_inline(iter, folio, pos, len);
+	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
+		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
+				len, &folio->page, NULL);
+	} else {
+		ret = __iomap_write_end(iter->inode, pos, len, len, folio);
+	}
+
+	__iomap_put_folio(iter, pos, ret, folio);
+	return ret;
+}
+
 /* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
 static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
@@ -960,8 +978,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		}
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
-		if (unlikely(status))
+		if (unlikely(status)) {
+			iomap_write_failed(iter->inode, pos, bytes);
 			break;
+		}
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
@@ -1343,7 +1363,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		if (bytes > folio_size(folio) - offset)
 			bytes = folio_size(folio) - offset;
 
-		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		bytes = iomap_write_end_simple(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
@@ -1407,7 +1427,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
-		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		bytes = iomap_write_end_simple(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
-- 
2.39.2


