Return-Path: <linux-fsdevel+bounces-28997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0092C972884
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327A81C23919
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5426617ADF1;
	Tue, 10 Sep 2024 04:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2bgrmPoR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599B166307;
	Tue, 10 Sep 2024 04:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943257; cv=none; b=NQr5GYW3EQeMG7ObajTs3wRH0Qp4CYYyGpKl7ulxXnrrMAddZ6RYVYPIbDEzAwXCaSPrFjIOvzesLJSn4WSY5b/IIZ7yTarToxk/9knjkDia7cWj5x+CC6OMb/PO6RMs2ST9hGge/xX+xb3rY3He1Lphs5oISzKLFRewzBeLASY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943257; c=relaxed/simple;
	bh=OBpXqUdNhr/0Fcc1Y3Vy8mclOwc9VkDE4mkLJp40Zh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OF24sdId/dlzpUpTx/ueKuWqKS7fA+TxcG+oA1xUd4xq36IjTY7nveJM7EYOebcF0FBQh0NTbWnutMPEnuUnTczV4PkErvPdLJ8XtURiG3gRyM599Lzv32ifMHS2YumyUCSwR2MJC1NwX5fBGhG8MbzcwtTu6KVcG1O4djEqI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2bgrmPoR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mJHyUZPaaThGbMBaVY5D5dP+EKYPp87bUH2nNS7Cd7U=; b=2bgrmPoRT8dDH/VZXndIlpAJ8E
	uPwuHXJ2hYpHcWNO7VggLuWL4KMgJ4UhqkjCWDF09mgjRjSQIB4DN/KDkZplcjlErtuM9xXGaTOs/
	YNdKnahuiA8M+bj4gJa5CyfGarIjI1zyCNkDnHBSPf4bZYqg3A03VATMDxpWDv07vWAJlRB28+iRV
	4hRnBL0bUwMQvBrcS3SSWzzzt3aWQifA1anCIXK6/pBLXfTdhdax/CFQqguM3mUeSpTTbiSBcs/4a
	F7woVk+lYmqK52XxB0vNCGKlmbjEuhPeL+KkdK8bI6syJ9TpsbSN3cgi1ezLuX4ldvgSI/O6B8hxC
	GTcLwing==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsgR-00000004F5o-1a5n;
	Tue, 10 Sep 2024 04:40:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/12] xfs: punch delalloc extents from the COW fork for COW writes
Date: Tue, 10 Sep 2024 07:39:14 +0300
Message-ID: <20240910043949.3481298-13-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910043949.3481298-1-hch@lst.de>
References: <20240910043949.3481298-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

When ->iomap_end is called on a short write to the COW fork it needs to
punch stale delalloc data from the COW fork and not the data fork.

Ensure that IOMAP_F_NEW is set for new COW fork allocations in
xfs_buffered_write_iomap_begin, and then use the IOMAP_F_SHARED flag
in xfs_buffered_write_delalloc_punch to decide which fork to punch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 844368b592f94f..5b071f36874318 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1195,7 +1195,7 @@ xfs_buffered_write_iomap_begin(
 		xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
 	}
 
-	iomap_flags = IOMAP_F_SHARED;
+	iomap_flags |= IOMAP_F_SHARED;
 	seq = xfs_iomap_inode_sequence(ip, iomap_flags);
 	xfs_iunlock(ip, lockmode);
 	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, iomap_flags, seq);
@@ -1212,8 +1212,10 @@ xfs_buffered_write_delalloc_punch(
 	loff_t			length,
 	struct iomap		*iomap)
 {
-	xfs_bmap_punch_delalloc_range(XFS_I(inode), XFS_DATA_FORK, offset,
-			offset + length);
+	xfs_bmap_punch_delalloc_range(XFS_I(inode),
+			(iomap->flags & IOMAP_F_SHARED) ?
+				XFS_COW_FORK : XFS_DATA_FORK,
+			offset, offset + length);
 }
 
 static int
-- 
2.45.2


