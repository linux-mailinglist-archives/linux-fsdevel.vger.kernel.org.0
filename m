Return-Path: <linux-fsdevel+bounces-54257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05031AFCCAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EA83ACB79
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC12E0910;
	Tue,  8 Jul 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQRsignt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D02E0904;
	Tue,  8 Jul 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982726; cv=none; b=YNwOCoI2r73H1mYt8als34eSeRgGfc71WamRkvoJHn8c9J7Xbbp/6ZynneOMYqAqes2P/tJTIvUnJRWb3STf26u8U46LozVrDErHq1tzZJ9DDHaQ1IA8mj4NMuLDYrvpjT8Q3rBpHzMpKa04O5EWvSMUwfuFGpjg/sRXfc6/H5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982726; c=relaxed/simple;
	bh=VAPoL+k7RHxF6ECVTn+9oDvz3eLC2I8M+RIOcrbqG88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/W7S+wtcW5RfDAEUog9wH/2XXcAT1TEp7Dmx8UK+o/HZaWUfmQDyBTC2kzU+ychZvNa/4f+t5PIcgNR72MWHEo8BrvhWHjicGPwgLwW6DGbwUPLeFSWzOKYlVRq6q9Y5FpGS//aZIJeGh2kHcUpo6w4GXDmgkbAtzXe0JHT8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nQRsignt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vXce8sLVsloQa7YW3TOHQIHpw2IFtnPlFPdC0kpA5QQ=; b=nQRsigntr/sukROn6kD9sXApAl
	3hoKi5TCegV4CcIeRVHJcCPj4qk7hDbvTwNWR5ya90KhHdxfynX/JyZ9Fb0W61wVhf8U3mYl0/Mg4
	AoMuifc8aD/SIWJoyWGfTEZQyROCfNPLoeKa/ZBJIpTmnEzRj5j6VF6AtKoO3gOQ3P4djPzgik70l
	I2p48N+3BfP5UZAIVPv8vcL25cJjdj3VPv0CofNUafAkI4q3gButAALQGbGqMGoP2UweYg54rXLl4
	9wKmXZeR1bZIermnTYGW6l00c04GpxsLfBhZgrzYBhzX0pXKEL0L7F3iA2mJ+fludWQ1RCN+VWBZE
	Mhc2KYLQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ8js-00000005UVJ-1UmJ;
	Tue, 08 Jul 2025 13:52:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 10/14] iomap: export iomap_writeback_folio
Date: Tue,  8 Jul 2025 15:51:16 +0200
Message-ID: <20250708135132.3347932-11-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250708135132.3347932-1-hch@lst.de>
References: <20250708135132.3347932-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Allow fuse to use iomap_writeback_folio for folio laundering.  Note
that the caller needs to manually submit the pending writeback context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 4 ++--
 include/linux/iomap.h  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1c18925070ca..ddb4363359e2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1633,8 +1633,7 @@ static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
-		struct folio *folio)
+int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = wpc->inode;
@@ -1716,6 +1715,7 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 	mapping_set_error(inode->i_mapping, error);
 	return error;
 }
+EXPORT_SYMBOL_GPL(iomap_writeback_folio);
 
 int
 iomap_writepages(struct iomap_writepage_ctx *wpc)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index cbf9d299a616..b65d3f063bb0 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -466,6 +466,7 @@ void iomap_start_folio_write(struct inode *inode, struct folio *folio,
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 
+int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio);
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
 /*
-- 
2.47.2


