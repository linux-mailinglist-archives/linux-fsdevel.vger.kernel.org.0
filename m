Return-Path: <linux-fsdevel+bounces-14440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C83887CD8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5D0284625
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2013C28E02;
	Fri, 15 Mar 2024 13:01:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69624B2B;
	Fri, 15 Mar 2024 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507669; cv=none; b=RHfkARIa39gi3pOwwjgGy3GYW8iZ3aTqdhOGe+2GZxjXntkVic6IGnmxL8ZDjyANe2Im6znY0iqFxD/YExvcna3eiVfJUJHeuRsmn7ItPEbXvj4AnoIPDXrkszv8yI4702hGhr+q9FZRUV2LcXcTIqLmhPr7REwdzfdRzekOzUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507669; c=relaxed/simple;
	bh=5KY2Ma2lHy9rGkgAfDoGPA/NG9qONKe8ZaT2COQGmFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJeu4NjfsQUQiPwhtBS4QrLHunOGuGTYdg802kkWrnKb6BlKiTQGdTlVHqsGeYx1zSIOETOfQ+E1wTgXqcMAN6nJC6UlssPtp1kAcSXoLltpnLWqHaBfYWC7n+cwicOOg9itWvQ/RHpXlTb1jewGdRV2RRr8+ePVrV+jCYIl9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tx4B2072Zz4f3kFb;
	Fri, 15 Mar 2024 21:00:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C76371A016E;
	Fri, 15 Mar 2024 21:01:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBF9RvRldVMfHA--.12032S9;
	Fri, 15 Mar 2024 21:01:03 +0800 (CST)
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
Subject: [PATCH v2 05/10] xfs: convert delayed extents to unwritten when zeroing post eof blocks
Date: Fri, 15 Mar 2024 20:53:49 +0800
Message-Id: <20240315125354.2480344-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
References: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBF9RvRldVMfHA--.12032S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4ktry7GF4Utw4UurW8Crg_yoW5AF15pF
	Z3Kwn8GrsxGw13Zwn3AFn3Kw1F9wn5Cw4UJry3Wwn3Xa4Dtr1Ig34Iy3WYgw18ArZ7A3Wj
	gF4YgF1I934UuaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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

Current clone operation could be non-atomic if the destination of a file
is beyond EOF, user could get a file with corrupted (zeroed) data on
crash.

The problem is about to pre-alloctions. If you write some data into a
file [A, B) (the position letters are increased one by one), and xfs
could pre-allocate some blocks, then we get a delayed extent [A, D).
Then the writeback path allocate blocks and convert this delayed extent
[A, C) since lack of enough contiguous physical blocks, so the extent
[C, D) is still delayed. After that, both the in-memory and the on-disk
file size are B. If we clone file range into [E, F) from another file,
xfs_reflink_zero_posteof() would call iomap_zero_range() to zero out the
range [B, E) beyond EOF and flush range. Since [C, D) is still a delayed
extent, it will be zeroed and the file's in-memory && on-disk size will
be updated to D after flushing and before doing the clone operation.
This is wrong, because user can user can see the size change and read
zeros in the middle of the clone operation.

We need to keep the in-memory and on-disk size before the clone
operation starts, so instead of writing zeroes through the page cache
for delayed ranges beyond EOF, we convert these ranges to unwritten and
invalidating any cached data over that range beyond EOF.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/xfs/xfs_iomap.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index ccf83e72d8ca..1a6d05830433 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1035,6 +1035,24 @@ xfs_buffered_write_iomap_begin(
 	}
 
 	if (imap.br_startoff <= offset_fsb) {
+		/*
+		 * For zeroing out delayed allocation extent, we trim it if
+		 * it's partial beyonds EOF block, or convert it to unwritten
+		 * extent if it's all beyonds EOF block.
+		 */
+		if ((flags & IOMAP_ZERO) &&
+		    isnullstartblock(imap.br_startblock)) {
+			xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
+
+			if (offset_fsb >= eof_fsb)
+				goto convert_delay;
+			if (end_fsb > eof_fsb) {
+				end_fsb = eof_fsb;
+				xfs_trim_extent(&imap, offset_fsb,
+						end_fsb - offset_fsb);
+			}
+		}
+
 		/*
 		 * For reflink files we may need a delalloc reservation when
 		 * overwriting shared extents.   This includes zeroing of
@@ -1158,6 +1176,17 @@ xfs_buffered_write_iomap_begin(
 	xfs_iunlock(ip, lockmode);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
 
+convert_delay:
+	xfs_iunlock(ip, lockmode);
+	truncate_pagecache(inode, offset);
+	error = xfs_bmapi_convert_delalloc(ip, XFS_DATA_FORK, offset,
+					iomap, NULL);
+	if (error)
+		return error;
+
+	trace_xfs_iomap_alloc(ip, offset, count, XFS_DATA_FORK, &imap);
+	return 0;
+
 found_cow:
 	seq = xfs_iomap_inode_sequence(ip, 0);
 	if (imap.br_startoff <= offset_fsb) {
-- 
2.39.2


