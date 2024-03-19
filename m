Return-Path: <linux-fsdevel+bounces-14794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F36FF87F515
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 02:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83FDAB21D7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 01:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9BD664B2;
	Tue, 19 Mar 2024 01:36:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0D64CE6;
	Tue, 19 Mar 2024 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812191; cv=none; b=JVD5VFaMbR7vnoXhfo9aN+/v5O15tcfe+UH15U9rAJvdicqnYxCIIXmk/+ugFbCj07kH96jpoSLxvtQq2fkysMrrYsRaq4BiWebTZN6LUDynyZ/8NjzdgSLiNQBwRv+EDhdWB6puYV1cxzerTwl7ofsY/KMzlCgmSnJrASlh3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812191; c=relaxed/simple;
	bh=o4H8PrhpY77bG69iFjnWF46CIYn0Hh8JwxDCfzb70ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QbIk05Hg3F1D06VpG6LMlus5mKb78vWPB94qJGqCS13Jb4MWi3HTMtvsL+5nWUA6IwFaly1z8QZrCX3VTV4uh5EyfOEJN5JFUo4Bzsg1jb7J8klmXl6ET6OkvhXnWXGYkInuUIDvgC+GvymNI+bcff0JDdknJv8Tehp+GhG/3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TzDPZ2LBvz4f3mJ1;
	Tue, 19 Mar 2024 09:18:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 338D31A0E78;
	Tue, 19 Mar 2024 09:18:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7O5_hlUIGNHQ--.34497S8;
	Tue, 19 Mar 2024 09:18:33 +0800 (CST)
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
Subject: [PATCH v3 4/9] xfs: convert delayed extents to unwritten when zeroing post eof blocks
Date: Tue, 19 Mar 2024 09:10:57 +0800
Message-Id: <20240319011102.2929635-5-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn9g7O5_hlUIGNHQ--.34497S8
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4ktry7GF4Utw4UurW8Crg_yoW5Aw15pF
	Z3Kwn8GrsxGw13Zws3AFnagw1F9wn5Cw4UJryfWwn3Xas8tr1IgryIy3WYgw18ArZ3A3Wj
	gF4YgF1I934UuaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


