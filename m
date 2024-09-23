Return-Path: <linux-fsdevel+bounces-29870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BFA97EE33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276B8281E70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F197419D062;
	Mon, 23 Sep 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3vJg4i0v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B78199FC6;
	Mon, 23 Sep 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105388; cv=none; b=rKOEEehCTP3UCDs8xY1MdWt1WPx6KtnZq636bm7XbUPD5+nbF4AOltSZOUbGx4WZENpTTtYXa8TUxBKgRMexRfGB1UvJO0HpOxZ3abfyJkaHSEPQguB90tbnuunx+oztDeIO2CtFX7py6zkkuBxRhyV4AcQk4gaR+KudgDKzYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105388; c=relaxed/simple;
	bh=dO7DPx9lr+A6EiTToDNsMt0eMLyFbcysQqhoPY9lCwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlTdkE0aPD0qEatQZHBkU0OiJlQ/zm+QBou15/GptTRx3D19SO4WewYkRWH+1UVFTprModjJkCKbvnJqbQ+tffQZwwSIpgXSUWK6Bqq/41oa5FZQTUkCgYanWr56l1/dxXw5tEFqkBfh+faffr45fFKRMvo43rj+M+6rdQZPQuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3vJg4i0v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YNRHAj4pG2z8wKAOo6HVGGA4NzRephlTf1ufR3qBIbg=; b=3vJg4i0vM214BtReHxm3G8RafI
	+418TqQcNlmwIzKNzgV6OcI9WkuGZFoSxxXux2MO/9IF2OQMY/8t3iquT8JPIAE/N+TyFAFhHNJUY
	5K+zUWrKnTw+Ul9Gs65WmKDc6bNKAmfIAlwO2cbHaBcDWUJnT4rsC6Zc5u4E/vkBDLuqUFkotv0U7
	NmuaGMLZwtJSPY48+WA7kebC5sQ4A3J/ONvPmCNGFJ51muzZFDQX7yahRfTjcAPOSJKlSI/IEOsY6
	1ndDTFnzjiFaBOlpzzwyclpAxCX/IiLML6tFa0ZgouEo+yiHUJIEvYRfjiurndfgpuqYV1xLBVXsn
	oYOZkoog==;
Received: from 2a02-8389-2341-5b80-4c13-f559-77bd-3c36.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c13:f559:77bd:3c36] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ssl0U-0000000HVIB-0cAl;
	Mon, 23 Sep 2024 15:29:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/10] xfs: punch delalloc extents from the COW fork for COW writes
Date: Mon, 23 Sep 2024 17:28:24 +0200
Message-ID: <20240923152904.1747117-11-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923152904.1747117-1-hch@lst.de>
References: <20240923152904.1747117-1-hch@lst.de>
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
index cc768f0139d365..8a4e5f14ec0c77 100644
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


