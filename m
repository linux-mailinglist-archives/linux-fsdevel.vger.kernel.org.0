Return-Path: <linux-fsdevel+bounces-51758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D81ADB0F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 15:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB9B1889DC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F652DF3E1;
	Mon, 16 Jun 2025 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xwswsye5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B8629B78F;
	Mon, 16 Jun 2025 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078823; cv=none; b=OAHDupofCcYkBNE3V5YWr1M+9R/MKfn6QAerBx5ExEcqQxg+ONPC7NI/h97J1kGVoTLPUiCADLROt3gAuinZw7Ju5F6xqHN4LvIaEhkVHQ6jpSYEmfTQVaJTyi3bn+xTtozgvB2UtbDKPONDTbZ9tCLIqu37Jp8/kqixe/d3pqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078823; c=relaxed/simple;
	bh=3UKXXwrB0GHE/tWdic+hAZ1jR3qh8U1mA0zC9TvcuDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=co/LuCM8M3/qLlRMVBPASl0rEwxuCNjNQlzzr78/RwDIp/W5IGv+Q6juZY5jd3vP76RjK8lHTW4e4UYx/BdgtduEQlVVFstVw4CA3KGE2eGVQI6q/NhYJyEpZ1hVOW1eJ87HTAeEylSy2d1rd7xPxKshLCVuWsNoiGDAS6isVac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xwswsye5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WMv0bF8JBTYeAjHknzjIrrcOZh1ySX6+t/1/LQG+mQ8=; b=xwswsye5hRSc9aZsULNwJM53Vi
	YIDZlbkhuQ9/N+88i3HGUCOZLoo6Qo72Hu6QBf9PGO6GpnEWrb14AZeWWDg8nQL5x6rKqhwlFCGy8
	dFzNmIMJtWcjG4ktyDkxSmE5goAPboqY/PZB7TU0hlBm4Q3gAkNG0tdSlesFIxslONipYJ52OTKMZ
	su5DHpnnDJPu8ulbvp74c3RIzq1wFGnSXr9K14R8UeibEtZ9HAisSfN82Rj00YJCO23O7o3Z8ivg5
	ppBZEmGsAUfZIIZqIIIvllTLEv/HcaB+DSYyBq76d2ThyaNpOlnYevGihRLbTzAaS7BjI5ervePac
	gPUOMWbQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9Rk-00000004Sf5-29Cd;
	Mon, 16 Jun 2025 13:00:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 5/6] iomap: add public helpers for uptodate state manipulation
Date: Mon, 16 Jun 2025 14:59:06 +0200
Message-ID: <20250616125957.3139793-6-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250616125957.3139793-1-hch@lst.de>
References: <20250616125957.3139793-1-hch@lst.de>
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
---
 fs/iomap/buffered-io.c | 20 +++++++++++++++-----
 include/linux/iomap.h  |  5 +++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d8d4950d4a31..507aadf3ec6b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1535,7 +1535,18 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
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
@@ -1546,6 +1557,7 @@ static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
 		folio_end_writeback(folio);
 }
+EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
 /*
  * We're now finished for good with this ioend structure.  Update the page
@@ -1668,7 +1680,6 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len)
 {
 	struct iomap_ioend *ioend = wpc->wb_ctx;
-	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	unsigned int ioend_flags = 0;
 	unsigned int map_len = min_t(u64, dirty_len,
@@ -1711,8 +1722,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
 		goto new_ioend;
 
-	if (ifs)
-		atomic_add(map_len, &ifs->write_bytes_pending);
+	iomap_start_folio_write(wpc->inode, folio, map_len);
 
 	/*
 	 * Clamp io_offset and io_size to the incore EOF so that ondisk
@@ -1880,7 +1890,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		 * all blocks.
 		 */
 		WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending) != 0);
-		atomic_inc(&ifs->write_bytes_pending);
+		iomap_start_folio_write(inode, folio, 1);
 	}
 
 	/*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 047100f94092..bfd178fb7cfc 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -460,6 +460,11 @@ void iomap_sort_ioends(struct list_head *ioend_list);
 ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len);
 int ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
+
+void iomap_start_folio_write(struct inode *inode, struct folio *folio,
+		size_t len);
+void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
+		size_t len);
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
 /*
-- 
2.47.2


