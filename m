Return-Path: <linux-fsdevel+bounces-31297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED94994362
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF5A28F838
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27CC1C1AD6;
	Tue,  8 Oct 2024 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PxZZHbYx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDDF1C0DFA;
	Tue,  8 Oct 2024 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378013; cv=none; b=S3LiLxt5k7Iy1qaQXT8IoF8um/NKsV5EcEBr+UhH2s40gDfFtpDeTIUYr9BNsBcmIff0n28mvr3TBBEU66FEdwJ5g07GOTPCudn/Qml55/MChKFxLSWfGEZ7D9AjtK8Q9ftAS31uBJyAAuVKHmBFQMwQE+N5NvFuo7KYuLBQ1c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378013; c=relaxed/simple;
	bh=eM4fkuNs74Wifu0SwS2UEDZaWem66XEq7FhtCToZNgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHq204h0mezXloa+Ed4IS3RSRxFxGoNdvs0lEcN845nZazgb9U74sazkj/LET0No3MG2mhl4OxrFidPFQ2U7f0BbC2tj1pIavFWId8TVZqDtf7CzzoZ0RGOnr9RpqsN7ItdR00A8ayUBpXLML5pMQiHvbQ6UHCX9XQwINRjVuUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PxZZHbYx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rcjb6y5lgHJS/KNA/ph5iqfIqPYUIGcWxQO2hMT29Tw=; b=PxZZHbYxhdgxlqnJXda5sIu+lb
	18Tkd7g+MrZcnaRlzLMgo6HXx/xGAIF/LnPolWHGC5B/xmYp1nL1+mMs6DiWsnFTANt56QsBXg/l7
	rISl6zKpGJlI8pEm7nZnvaKJ3fhuWWFiZfSvWVDYDYkaVceg0E6VbVm2+qgi9YH0vBJxdgWqquRb4
	bvSKBE864SdUF/3aBV7XXLYGlZWF49zBkmzLaXOLH+P3uK4A/7DI96deZjFUgdNwJ8ej4Vgmj7JQn
	UjNIcEPTV918j561KEtAovwBOrNw3BK5G79CQ/iRoNrSESAgXgaz/MBeRlnXB53EIUs59unZSLHmq
	TTb3ovjw==;
Received: from 2a02-8389-2341-5b80-a172-fba5-598b-c40c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a172:fba5:598b:c40c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy64g-00000005BkR-3aza;
	Tue, 08 Oct 2024 09:00:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/10] xfs: punch delalloc extents from the COW fork for COW writes
Date: Tue,  8 Oct 2024 10:59:21 +0200
Message-ID: <20241008085939.266014-11-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241008085939.266014-1-hch@lst.de>
References: <20241008085939.266014-1-hch@lst.de>
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
index 0317bbfeeb38f3..916531d9f83c2f 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1196,7 +1196,7 @@ xfs_buffered_write_iomap_begin(
 				imap.br_startoff - offset_fsb);
 	}
 
-	iomap_flags = IOMAP_F_SHARED;
+	iomap_flags |= IOMAP_F_SHARED;
 	seq = xfs_iomap_inode_sequence(ip, iomap_flags);
 	xfs_iunlock(ip, lockmode);
 	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, iomap_flags, seq);
@@ -1213,8 +1213,10 @@ xfs_buffered_write_delalloc_punch(
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


