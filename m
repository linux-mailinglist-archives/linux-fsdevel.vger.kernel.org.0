Return-Path: <linux-fsdevel+bounces-54504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71162B00390
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761A2167912
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB0C25FA06;
	Thu, 10 Jul 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+tFtX6T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F29325A328;
	Thu, 10 Jul 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154447; cv=none; b=P5V/d8B8dK1gjWUBV6pj8XL5dbL4DAvj3wExmsHFubVmHKbqP/vAlpoN6tcoo5s6GOlM82fE8OfFJA51Fuh9j90b2K3C/cplqCYFGJyaYOiEvqIpyw2WZeW+ZiZE4EVDIguxnd1FNPlazQo+dOf8H1SAjAYoP9D/lh54NneGizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154447; c=relaxed/simple;
	bh=70e1vtR09iH51pxisMVQGGH4QrytO9PjpMbIN4H2wmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1SJG/VGe9mmIVdonKNW7GuIvvSJZcq9PdaDeiPzEomiCw3P+8doGx/CaxQ6vyPBvygrudgIxxZ0BZmmLEgacvo79GfAO/sTr8c8qh8taRdHobgwAZ8MQiZQX8wSleqO/i69y2JBEdkjUzE3fo2gL98dVqdOLUoMjTmHVvxkQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j+tFtX6T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9d4aPGP7VwuTzMSKeThtLAhWIYq+625AbIzLtHiTZkQ=; b=j+tFtX6T6nQsq6iwxIjyBsfu/T
	0RB1QcMUO/gw2P9KekjywcF8VWSDEllwKS3ubNz4oLAfcLM2sQPZwK6vp0j3PnU0Vr+6gcGdo4F+i
	V+IYgYKjMX13nQ5/UTvqFDQL593fwMYm/NZYe+O2KHU4ZB2jiT4ZsVRiymsYHSoJ1Glkkhv9JzmXM
	CU2X7Gv0Xirq62qmIgIHfzUvS6CVO6Dtj8NmkOT8Ntb0TZ7GjHr7eL2vagkli9db2aBjwi6w+nC2I
	EUiiqaf3YeAqI84RX+pbaOJT0QtDXW+wx55sbkk5DeNgguYqok8eVPcJVRjFBUxPB1/zDcAcpGyHI
	d+J15rbg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZrPZ-0000000BwTo-2Ngx;
	Thu, 10 Jul 2025 13:34:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	Brian Foster <bfoster@redhat.com>
Subject: [PATCH 06/14] iomap: add public helpers for uptodate state manipulation
Date: Thu, 10 Jul 2025 15:33:30 +0200
Message-ID: <20250710133343.399917-7-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710133343.399917-1-hch@lst.de>
References: <20250710133343.399917-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: Joanne Koong <joannelkoong@gmail.com>

Add a new iomap_start_folio_write helper to abstract away the
write_bytes_pending handling, and export it and the existing
iomap_finish_folio_write for non-iomap writeback in fuse.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 20 +++++++++++++++-----
 include/linux/iomap.h  |  5 +++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 650a67b7d223..060bfcc353da 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1527,7 +1527,18 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
-static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
+void iomap_start_folio_write(struct inode *inode, struct folio *folio,
+		size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
+	if (ifs)
+		atomic_add(len, &ifs->write_bytes_pending);
+}
+EXPORT_SYMBOL_GPL(iomap_start_folio_write);
+
+void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -1538,6 +1549,7 @@ static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
 		folio_end_writeback(folio);
 }
+EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
 /*
  * We're now finished for good with this ioend structure.  Update the page
@@ -1660,7 +1672,6 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len)
 {
 	struct iomap_ioend *ioend = wpc->wb_ctx;
-	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	unsigned int ioend_flags = 0;
 	unsigned int map_len = min_t(u64, dirty_len,
@@ -1703,8 +1714,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
 		goto new_ioend;
 
-	if (ifs)
-		atomic_add(map_len, &ifs->write_bytes_pending);
+	iomap_start_folio_write(wpc->inode, folio, map_len);
 
 	/*
 	 * Clamp io_offset and io_size to the incore EOF so that ondisk
@@ -1877,7 +1887,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		 * all blocks.
 		 */
 		WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending) != 0);
-		atomic_inc(&ifs->write_bytes_pending);
+		iomap_start_folio_write(inode, folio, 1);
 	}
 
 	/*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 9f32dd8dc075..cbf9d299a616 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -461,6 +461,11 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len);
 int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
 
+void iomap_start_folio_write(struct inode *inode, struct folio *folio,
+		size_t len);
+void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
+		size_t len);
+
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
 /*
-- 
2.47.2


