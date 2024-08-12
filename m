Return-Path: <linux-fsdevel+bounces-25671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D385694ECA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951A828332F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFE317BB35;
	Mon, 12 Aug 2024 12:16:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FF517B4FD;
	Mon, 12 Aug 2024 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464986; cv=none; b=KGpISuUdI38FuXlzxpTiLUSvLZ4zabVakk3HMRbOBjOK86dEMf0aZkxEPA68xHNZBvIGN9w9m+AOVHSVH9d0OBXSNLNrWkCFgPq36PCJHfps3crdS3ZmQVxrteOKHPF5NXl9XW/x01qgN5rXU5bcG9zHlJGEwIE0q1AnTjzbtDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464986; c=relaxed/simple;
	bh=51TeY73ZfcfHsbXKyd+uQriWs57Uk1pq+S2vwwDi1Lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NZEZmiZ8BC8+WOSStZiI/CqwjzA+Seju/m4KvfVRbIETGf20fxBY9VPQUfekm9pFd6RJSBSmNPtB4dfUZ634PuNswnjV8dpkF+jev/NVYFv4vTf2bYrALrRSk0rpZMLW9KHJjJF/U8l4zODY5qFAa7/qFPyAwJlZJg0kZ0Y+rSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjD4y58L1z4f3mJ5;
	Mon, 12 Aug 2024 20:16:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 534B51A1535;
	Mon, 12 Aug 2024 20:16:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgDHeLcD_blmHhy7BQ--.21435S10;
	Mon, 12 Aug 2024 20:16:17 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	jack@suse.cz,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v2 6/6] iomap: reduce unnecessary state_lock when setting ifs uptodate and dirty bits
Date: Mon, 12 Aug 2024 20:11:59 +0800
Message-Id: <20240812121159.3775074-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHeLcD_blmHhy7BQ--.21435S10
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4kGFykJF4DKF15Ww17ZFb_yoW5Ar4DpF
	W5Ka98KrZ8Xw17uw1fXF18Zr1Yk34xXr48CayfGwn3CF45Ary2gF18ua4jyFW8Xrn7Ar1v
	qF1DtFy8WF4jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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

When doing buffered write, we set uptodate and drity bits of the written
range separately, it holds the ifs->state_lock twice when blocksize <
folio size, which is redundant. After large folio is supported, the
spinlock could affect more about the performance, merge them could
reduce some unnecessary locking overhead and gets some performance gain.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 96600405dbb5..67d7c1c22c98 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -182,6 +182,37 @@ static void iomap_set_range_dirty(struct folio *folio, size_t off, size_t len)
 		ifs_set_range_dirty(folio, ifs, off, len);
 }
 
+static void ifs_set_range_dirty_uptodate(struct folio *folio,
+		struct iomap_folio_state *ifs, size_t off, size_t len)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+	unsigned int first_blk = (off >> inode->i_blkbits);
+	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
+	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ifs->state_lock, flags);
+	bitmap_set(ifs->state, first_blk, nr_blks);
+	if (ifs_is_fully_uptodate(folio, ifs))
+		folio_mark_uptodate(folio);
+	bitmap_set(ifs->state, first_blk + blks_per_folio, nr_blks);
+	spin_unlock_irqrestore(&ifs->state_lock, flags);
+}
+
+static void iomap_set_range_dirty_uptodate(struct folio *folio,
+		size_t off, size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (ifs)
+		ifs_set_range_dirty_uptodate(folio, ifs, off, len);
+	else
+		folio_mark_uptodate(folio);
+
+	filemap_dirty_folio(folio->mapping, folio);
+}
+
 static struct iomap_folio_state *ifs_alloc(struct inode *inode,
 		struct folio *folio, unsigned int flags)
 {
@@ -851,6 +882,8 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
+	size_t from = offset_in_folio(folio, pos);
+
 	flush_dcache_folio(folio);
 
 	/*
@@ -866,9 +899,8 @@ static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return false;
-	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
-	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
-	filemap_dirty_folio(inode->i_mapping, folio);
+
+	iomap_set_range_dirty_uptodate(folio, from, copied);
 	return true;
 }
 
-- 
2.39.2


