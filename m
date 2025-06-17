Return-Path: <linux-fsdevel+bounces-51885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4720DADC8D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 12:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E843117199D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 10:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213B92DF3C4;
	Tue, 17 Jun 2025 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R5h2B2vs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB542DBF73;
	Tue, 17 Jun 2025 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157731; cv=none; b=aCkCxeiM7zWK92yvYTOdXYZ2/N43NVC8XgG/2i0Mabn2/iBiuKviE49V1kkD018LNwZj1NT4p68qb1o6qvvJzSzYs+MpXATu0plhLjnbLDMkyVDkNM7TFvtdMyd2Ezw/XQj35Fm/ucHNrYkXhF5rouWsm21umaFJLnBGRDmHYlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157731; c=relaxed/simple;
	bh=VLE5fqMpHgdVXG72DkkMI7RuadmkblnoG8RjarNhfxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/6XguyJP97KvaK/FYOlGEIRv1eBLXywyrVIMf578et1UU+jYdAW3HFvVPRR8MLo0fmEgoFf0GYpa/cxwUFv60dfOpR050mh795FsLlLCXQaO5ukUDH9sJvQmSh30Le1r0+o3hYHp67x36o0AA4ttmeUzRiWVwzt+63mdfjltbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R5h2B2vs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GnQIF0/b8yzTjPbQWLGeeWc+dybjrI5xxXTa08AGECM=; b=R5h2B2vs64WspZmCXgw79CSaot
	fbsqvLEXALq2ydOt2j+pUkxr2p51x/c+7bFqnik+2B0969gkvOcHdME2pAO5oxUlI5pjhkQNEjMja
	PDgNegGaX9W1VKNDw+j2YkguC4gXqiJeZIeN3pGvtmqNtzklQRsve15ltLDBy7ljname8T0ooxUPJ
	59azrGjpUD7KriODMY18Wo8E3dbx/NoSh2jr7ayjREkhrLGgqO/2bAYvClAeYtiy6hgZlUcTn+f9O
	zSdVYfvDCBN6eUuinnQRCME95Tnun9uNBswW0RPH8Obi3XWdxcAZA+LGj6eYvbA/heZGEB/8V6LCo
	//jEJ7BA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRTyT-00000006ymf-1ZbM;
	Tue, 17 Jun 2025 10:55:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 05/11] iomap: add public helpers for uptodate state manipulation
Date: Tue, 17 Jun 2025 12:55:04 +0200
Message-ID: <20250617105514.3393938-6-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617105514.3393938-1-hch@lst.de>
References: <20250617105514.3393938-1-hch@lst.de>
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
index 50cfddff1393..b4a8d2241d70 100644
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


