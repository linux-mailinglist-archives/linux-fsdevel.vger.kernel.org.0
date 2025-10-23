Return-Path: <linux-fsdevel+bounces-65334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3BAC01A42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 16:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11090567B9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D2C32ABC0;
	Thu, 23 Oct 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="psox57Wm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CF3320CBC;
	Thu, 23 Oct 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227784; cv=none; b=hZbnaq+B63bC7EWzVumpXQ345KldmcNEn7Ge/fdKIh9Crp1h2eE2GYWJHKIRNR+0WeTtZkHFRZhb+zztMX6WIb+G2NkZBm+bx9gnanSFJXjN2MCArNLSpiyfxseYZi8/niruP614F8FUyjKhfMMxlk2UhRexbAsZHlmllyzyv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227784; c=relaxed/simple;
	bh=W2EdmC2/U1gDd0Li49ZYAhxeAf134JxGQDGawGyAqk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyrFJscAkJSD5Pr+sWa+Fwvmyhxc0YB4/U4CPfNznGStY8oH9Z8zOtzpzpL9k/IpOBav8UHh6bPGsc0SpfhEPC9ePQtjGr+O8pu4UYi4eCpJ1NCYP/sNjOsE1ruS2GMtY9op0SX/FJfq/QYWHKTqyZH+Kpl90NWh8R+lULe+7M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=psox57Wm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3nlQNYKh63DZfhqvnbIO/V8BRjwy0Pm04lFLxCF+OHk=; b=psox57WmcssjwYkhGU5JyKb9DJ
	ZNVIfRsNTuYjvHQHnLldbI59k0PJZ1FixGEVP5CcX/9M4VC2StPBaucCxFMRRvy3ca52T57vk1ihh
	un3UhqK/yNdHsjWzKccUDTW34jy2eFcJjQ3ludCLgAvokpv9QGbKAbhKNPu2bVGfT7adMLhWffQRw
	vTYEyIlDWp7i2IvQNH0GJcqTOSAlrvKD8MuDOpVRjBYYOeGJD4hE6uRnDS4ihmwtuXaHn5RqvwfqU
	QSQZiESbnQT+bV9D2ZgAQU173tPsiO1+k15VfCL4+r1kLfmJyfThwYAnd4UroTVMwu2rvguPSpvLf
	/SFAipmA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBvnh-00000006UdW-2s1b;
	Thu, 23 Oct 2025 13:56:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] xfs: support sub-block aligned vectors in always COW mode
Date: Thu, 23 Oct 2025 15:55:45 +0200
Message-ID: <20251023135559.124072-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023135559.124072-1-hch@lst.de>
References: <20251023135559.124072-1-hch@lst.de>
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


