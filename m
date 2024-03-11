Return-Path: <linux-fsdevel+bounces-14123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9EE877FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 13:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DC7282579
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67433D978;
	Mon, 11 Mar 2024 12:30:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032239AE3;
	Mon, 11 Mar 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160204; cv=none; b=OQswMvSaTvVqHzxMV05LXmylbAKRh8VPUTDLXnS5n93EpgUJz7nFP9jG/pFgCNOpYyJAIEWXKzGa7fc6cCLADPQSS7YAwOgLLoowuUkbLksmPxoSZ0gdcCLWuRICbYams198Pa7fBDA5kZ+4AM3HQXi04nQHwKdNaK/nB2Eiu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160204; c=relaxed/simple;
	bh=rXLAzQ+ucmDQz9YniwFLAZ4a/zSlJaidZ4o+lEJyuPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JGYiiECIJsvJGfHcNpXnM559AcI4LdzsNy+/Vl43ALdL5d1GuMSrI9RGTXCtlI3+WJzUu9rob8sgXOCkfgVivu2klk2XCFltJclHx8lqPfAmyhs4NFu3Cm1dovBk4kopIE5k8GIxL42idDvWocat1x4UYz/1ijQiN/40PHuqOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ttbgy4Zwsz4f3lgD;
	Mon, 11 Mar 2024 20:29:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4A8261A0172;
	Mon, 11 Mar 2024 20:29:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAt+e5lAE9+Gg--.62739S6;
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
Subject: [PATCH 2/4] xfs: convert delayed extents to unwritten when zeroing post eof blocks
Date: Mon, 11 Mar 2024 20:22:53 +0800
Message-Id: <20240311122255.2637311-3-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDHlxAt+e5lAE9+Gg--.62739S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4ktry7GF4Utw4UurW8Crg_yoW5tFW8pF
	Z3Kwn8Grs3Gw1avws3AFn8Ww1Fvwn5Cw48Xry3Wwn3Xas8tr42ga4xA3WYgw18Gwsay3ZF
	9F4YgFyI9w1UZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1489tUUUUU=
	=
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
index ccf83e72d8ca..2b2aace25355 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -957,6 +957,7 @@ xfs_buffered_write_iomap_begin(
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
+	xfs_fileoff_t		eof_fsb = XFS_B_TO_FSBT(mp, XFS_ISIZE(ip));
 	struct xfs_bmbt_irec	imap, cmap;
 	struct xfs_iext_cursor	icur, ccur;
 	xfs_fsblock_t		prealloc_blocks = 0;
@@ -1035,6 +1036,22 @@ xfs_buffered_write_iomap_begin(
 	}
 
 	if (imap.br_startoff <= offset_fsb) {
+		/*
+		 * For zeroing out delayed allocation extent, we trim it if
+		 * it's partial beyonds EOF block, or convert it to unwritten
+		 * extent if it's all beyonds EOF block.
+		 */
+		if ((flags & IOMAP_ZERO) &&
+		    isnullstartblock(imap.br_startblock)) {
+			if (offset_fsb > eof_fsb)
+				goto convert_delay;
+			if (end_fsb > eof_fsb) {
+				end_fsb = eof_fsb + 1;
+				xfs_trim_extent(&imap, offset_fsb,
+						end_fsb - offset_fsb);
+			}
+		}
+
 		/*
 		 * For reflink files we may need a delalloc reservation when
 		 * overwriting shared extents.   This includes zeroing of
@@ -1158,6 +1175,18 @@ xfs_buffered_write_iomap_begin(
 	xfs_iunlock(ip, lockmode);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
 
+convert_delay:
+	end_fsb = min(end_fsb, imap.br_startoff + imap.br_blockcount);
+	xfs_iunlock(ip, lockmode);
+	truncate_pagecache_range(inode, offset, XFS_FSB_TO_B(mp, end_fsb));
+	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
+				       flags, &imap, &seq);
+	if (error)
+		return error;
+
+	trace_xfs_iomap_alloc(ip, offset, count, XFS_DATA_FORK, &imap);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
+
 found_cow:
 	seq = xfs_iomap_inode_sequence(ip, 0);
 	if (imap.br_startoff <= offset_fsb) {
-- 
2.39.2


