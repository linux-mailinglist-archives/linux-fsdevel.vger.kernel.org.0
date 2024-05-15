Return-Path: <linux-fsdevel+bounces-19493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C0B8C5F2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 04:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5C0280E2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 02:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3621B3B293;
	Wed, 15 May 2024 02:39:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6B2C69B;
	Wed, 15 May 2024 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715740746; cv=none; b=t6RUq4j09f17QSDd2HOQnv6UaSFOLBnd42wSUTAIlVRmLZKnJYivKhWgEmJYLCtul1IMqtJAgI7L8aRubi0xOh1r7MpdrOU7IJBl8iLDLSQ5vhdZyCFerGAMf1vqtZrl2Pi42wSIUiCArT6TFyQtKLAfblcGR6vP2R2K4xgOLgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715740746; c=relaxed/simple;
	bh=xuIlfY/3HVCtD8t5rWUv44jPGANtnz30uK1KfBywpWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ggYy1zNQs8YTtMF8ruK0s0i5iXymkpJ7xSYLvKs2IJD4aUc2iyFtZdnNU4PJ7cbtOfIK692P4NLaAZw20APN+WiEZw8zM426GDnrQjVHzAq2qAX4+3FFGoCmpHyXqEnOWd9srRjjDM3HQHOqy8EdC1u58VcIqOl3bgB0vAGRV9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VfHV72Cpjz4f3jjk;
	Wed, 15 May 2024 10:38:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D10301A0D99;
	Wed, 15 May 2024 10:39:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBE8IERmRFzIMg--.49754S7;
	Wed, 15 May 2024 10:39:00 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
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
Subject: [PATCH 3/3] xfs: correct the zeroing truncate range
Date: Wed, 15 May 2024 10:28:29 +0800
Message-Id: <20240515022829.2455554-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515022829.2455554-1-yi.zhang@huaweicloud.com>
References: <20240515022829.2455554-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBE8IERmRFzIMg--.49754S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW7uF4UAw1DCr4fGFW8Xrb_yoWrGry5pr
	s7K3Z8CrsrK347ZF1kXF1jvw1Fy3WrAF409ryfGrn7Za4DXr1Iyrn2gF4rKa1Utr4DXw4Y
	qFs5tayUuas5AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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

When truncating a realtime file unaligned to a shorter size,
xfs_setattr_size() only flush the EOF page before zeroing out, and
xfs_truncate_page() also only zeros the EOF block. This could expose
stale data since 943bc0882ceb ("iomap: don't increase i_size if it's not
a write operation").

If the sb_rextsize is bigger than one block, and we have a realtime
inode that contains a long enough written extent. If we unaligned
truncate into the middle of this extent, xfs_itruncate_extents() could
split the extent and align the it's tail to sb_rextsize, there maybe
have more than one blocks more between the end of the file. Since
xfs_truncate_page() only zeros the trailing portion of the i_blocksize()
value, so it may leftover some blocks contains stale data that could be
exposed if we append write it over a long enough distance later.

xfs_truncate_page() should flush, zeros out the entire rtextsize range,
and make sure the entire zeroed range have been flushed to disk before
updating the inode size.

Fixes: 943bc0882ceb ("iomap: don't increase i_size if it's not a write operation")
Reported-by: Chandan Babu R <chandanbabu@kernel.org>
Link: https://lore.kernel.org/linux-xfs/0b92a215-9d9b-3788-4504-a520778953c2@huaweicloud.com
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/xfs/xfs_iomap.c | 35 +++++++++++++++++++++++++++++++----
 fs/xfs/xfs_iops.c  | 10 ----------
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 4958cc3337bc..fc379450fe74 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1466,12 +1466,39 @@ xfs_truncate_page(
 	loff_t			pos,
 	bool			*did_zero)
 {
+	struct xfs_mount	*mp = ip->i_mount;
 	struct inode		*inode = VFS_I(ip);
 	unsigned int		blocksize = i_blocksize(inode);
+	int			error;
+
+	if (XFS_IS_REALTIME_INODE(ip))
+		blocksize = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize);
+
+	/*
+	 * iomap won't detect a dirty page over an unwritten block (or a
+	 * cow block over a hole) and subsequently skips zeroing the
+	 * newly post-EOF portion of the page. Flush the new EOF to
+	 * convert the block before the pagecache truncate.
+	 */
+	error = filemap_write_and_wait_range(inode->i_mapping, pos,
+					     roundup_64(pos, blocksize));
+	if (error)
+		return error;
 
 	if (IS_DAX(inode))
-		return dax_truncate_page(inode, pos, blocksize, did_zero,
-					&xfs_dax_write_iomap_ops);
-	return iomap_truncate_page(inode, pos, blocksize, did_zero,
-				   &xfs_buffered_write_iomap_ops);
+		error = dax_truncate_page(inode, pos, blocksize, did_zero,
+					  &xfs_dax_write_iomap_ops);
+	else
+		error = iomap_truncate_page(inode, pos, blocksize, did_zero,
+					    &xfs_buffered_write_iomap_ops);
+	if (error)
+		return error;
+
+	/*
+	 * Write back path won't write dirty blocks post EOF folio,
+	 * flush the entire zeroed range before updating the inode
+	 * size.
+	 */
+	return filemap_write_and_wait_range(inode->i_mapping, pos,
+					    roundup_64(pos, blocksize));
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 66f8c47642e8..baeeddf4a6bb 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -845,16 +845,6 @@ xfs_setattr_size(
 		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
 				&did_zeroing);
 	} else {
-		/*
-		 * iomap won't detect a dirty page over an unwritten block (or a
-		 * cow block over a hole) and subsequently skips zeroing the
-		 * newly post-EOF portion of the page. Flush the new EOF to
-		 * convert the block before the pagecache truncate.
-		 */
-		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
-						     newsize);
-		if (error)
-			return error;
 		error = xfs_truncate_page(ip, newsize, &did_zeroing);
 	}
 
-- 
2.39.2


