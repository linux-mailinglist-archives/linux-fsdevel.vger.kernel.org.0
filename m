Return-Path: <linux-fsdevel+bounces-66590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C78C2532D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 14:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9261534A076
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 13:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C07434A789;
	Fri, 31 Oct 2025 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W3gwCnNY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808134A797;
	Fri, 31 Oct 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916259; cv=none; b=DmCViNHrhOZ+Hwcu4hfHcbpMhD5/X7NBXVpnkc0aNGjXN4L7tQK5+4WBx79tFHAByK7nf1b9lEPMMrh8R4QYjC4aLzgvC11hAT8yv9zxNLFCmlRZaIih4gyhVOeIbUlrTwKoE7VPY9vdOr/hoMZxe+uZ9GBikOwHM1jZBE4INCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916259; c=relaxed/simple;
	bh=xP+w8bI4i63RusuJ9L26xztN90ebpZHOthuBhNhNRUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpvqYpkzR1mVMVp7iGcm/cLK0f7qXgZ6aUPam2bfhkJ6KkvCHv0Hv8YlrwXq+t6y8FJbp5TahjsalBWYU9vw7pZZB/TDp61hAH1EPTlY5BNKyswEi4mVZmrPsS0B9rE2kcGfz+LfYFDpS2vmQYwoVQLF7RLnZxfsInSQnrZqi/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W3gwCnNY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=p9BotnxIBRB0C2xiHOcC/q08ybkD7wph2IV9C7trHZw=; b=W3gwCnNY3lZz0yh2grVjsSj5J/
	QqdihICSc5om4nrwtElRm8brlm5Oflhsd/Ho7MIG0LL2Q6FCRgUxVz1IXCXYaWR50wnuOXDyhd6ss
	hRU3NU224Pm32ig+Uq47lsVMTXFyq6b0boQcmX3zFHt6PLKIfazZ8zzyTgLLZaH7sbT0wCJsoxdX8
	Zf1k1quwMCn+DRXFStJ+5mAn6eta2iPDaxrLGE9UZrYavUOmN25Gw1rCXhrqZGcG9sKUd8UhqECpR
	KcGtLikJS8tc1DWvGeIlaGMBhp3xoMBewsGWXe0nf4NB/uwatZ0oON8RsBaaIRNCAz1xReEv9rEHs
	mUwdbKSg==;
Received: from [2001:4bb8:2dc:10e5:1f29:7b81:1da3:7ada] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEou8-0000000699Y-2rhn;
	Fri, 31 Oct 2025 13:10:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] xfs: support sub-block aligned vectors in always COW mode
Date: Fri, 31 Oct 2025 14:10:27 +0100
Message-ID: <20251031131045.1613229-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031131045.1613229-1-hch@lst.de>
References: <20251031131045.1613229-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Now that the block layer and iomap have grown support to indicate
the bio sector size explicitly instead of assuming the device sector
size, we can ask for logical block size alignment and thus support
direct I/O writes where the overall size is logical block size
aligned, but the boundaries between vectors might not be.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_file.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 2702fef2c90c..f2ac4115c18b 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -674,8 +674,17 @@ xfs_file_dio_write_aligned(
 	struct xfs_zone_alloc_ctx *ac)
 {
 	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	unsigned int		dio_flags = 0;
 	ssize_t			ret;
 
+	/*
+	 * For always COW inodes, each bio must be aligned to the file system
+	 * block size and not just the device sector size because we need to
+	 * allocate a block-aligned amount of space for each write.
+	 */
+	if (xfs_is_always_cow_inode(ip))
+		dio_flags |= IOMAP_DIO_FSBLOCK_ALIGNED;
+
 	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
 	if (ret)
 		return ret;
@@ -693,7 +702,7 @@ xfs_file_dio_write_aligned(
 		iolock = XFS_IOLOCK_SHARED;
 	}
 	trace_xfs_file_direct_write(iocb, from);
-	ret = iomap_dio_rw(iocb, from, ops, dops, 0, ac, 0);
+	ret = iomap_dio_rw(iocb, from, ops, dops, dio_flags, ac, 0);
 out_unlock:
 	xfs_iunlock(ip, iolock);
 	return ret;
@@ -890,15 +899,7 @@ xfs_file_dio_write(
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
 		return -EINVAL;
 
-	/*
-	 * For always COW inodes we also must check the alignment of each
-	 * individual iovec segment, as they could end up with different
-	 * I/Os due to the way bio_iov_iter_get_pages works, and we'd
-	 * then overwrite an already written block.
-	 */
-	if (((iocb->ki_pos | count) & ip->i_mount->m_blockmask) ||
-	    (xfs_is_always_cow_inode(ip) &&
-	     (iov_iter_alignment(from) & ip->i_mount->m_blockmask)))
+	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
 	if (xfs_is_zoned_inode(ip))
 		return xfs_file_dio_write_zoned(ip, iocb, from);
-- 
2.47.3


