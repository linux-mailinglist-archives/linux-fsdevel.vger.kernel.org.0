Return-Path: <linux-fsdevel+bounces-28993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B097287C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7358E1F24ACF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D33E17E472;
	Tue, 10 Sep 2024 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oop2GWAX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9963D16A92E;
	Tue, 10 Sep 2024 04:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943234; cv=none; b=ZvZXHoeEPTYoit1NICXqJguOKUzhN5mJ4uTfpQGR7ZOSim9T3tROKEz6PZ4ZW4P8adNbbim+RDVCx7mQDWN2Y0hnxLVRtT2u15tHtsYLAqE57HSHHdrTKFzp2o9FtfclgKwgfWPHgxDHSGErkQn3U3eiiZdaWDsNqSyde7TKe98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943234; c=relaxed/simple;
	bh=B5+CjjInj5OAwpnDeETV1l6i+X93vBAxRbowkxicpYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYt2UMOlx48aOT9VwYJmTrnX6Tk4ek95YRgfcIy+wiEWw94XLdWRWggtz0h5FbsjIyWdJSlkkY7iUEpa3cimQZo/JrgM4Rk9ZVShju9QU3Ve+e7v3+DDH8jBezM3NlFjTT3Iib1PozohTerKGAolC7aBSAGOTPjuazPEh5c1kTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oop2GWAX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=24KLlLmJ9PErSovSdCZ8lOu4ZzuDC5SkhFhDuikF6n4=; b=oop2GWAX0JCG72nNKaDF9Hlbli
	nUY91XjITU4POdpik7QpIZlMRZTd4Bk6EK+8GpomQII0MvO7KL3ah6mpEoW/+11DEysxkZBZOvI/Z
	9tiuAKsia4kdYtJWHd3lDGNTT74bw5KwyJAlnQzlJ9Nf8nywVFmy4Qv6w3lVQuiUPV9hQcMMUcS+W
	gQs6lNGAH83Z2maouGze2DsJ853qrlpHY2b5+CwyD5ZAnnDI87WC/qkTNkh92yj4xe0zjhGcWRl21
	3zBvNcudfWCa1Uq4GLRcHohklhPKHsILTDCfMqwGutESca6/JSewC3XPqjv2reasAQg7UzfG+C6iR
	exTdKTSQ==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsg3-00000004Ewc-0vj8;
	Tue, 10 Sep 2024 04:40:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/12] iomap: zeroing already holds invalidate_lock
Date: Tue, 10 Sep 2024 07:39:10 +0300
Message-ID: <20240910043949.3481298-9-hch@lst.de>
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

All callers of iomap_zero_range already hold invalidate_lock, so we can't
take it again in iomap_file_buffered_write_punch_delalloc.

Use the passed in flags argument to detect if we're called from a zeroing
operation and don't take the lock again in this case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 52f285ae4bddcb..3d7e69a542518a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1188,8 +1188,13 @@ static void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 	 * folios and dirtying them via ->page_mkwrite whilst we walk the
 	 * cache and perform delalloc extent removal. Failing to do this can
 	 * leave dirty pages with no space reservation in the cache.
+	 *
+	 * For zeroing operations the callers already hold invalidate_lock.
 	 */
-	filemap_invalidate_lock(inode->i_mapping);
+	if (flags & IOMAP_ZERO)
+		rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);
+	else
+		filemap_invalidate_lock(inode->i_mapping);
 	while (start_byte < scan_end_byte) {
 		loff_t		data_end;
 
@@ -1240,7 +1245,8 @@ static void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 		punch(inode, punch_start_byte, end_byte - punch_start_byte,
 				iomap);
 out_unlock:
-	filemap_invalidate_unlock(inode->i_mapping);
+	if (!(flags & IOMAP_ZERO))
+		filemap_invalidate_unlock(inode->i_mapping);
 }
 
 /*
-- 
2.45.2


