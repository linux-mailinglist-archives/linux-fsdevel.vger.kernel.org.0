Return-Path: <linux-fsdevel+bounces-40582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1CDA25620
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 10:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C693A95B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE33200BA8;
	Mon,  3 Feb 2025 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fu1P+0/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C21FF7BE;
	Mon,  3 Feb 2025 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575817; cv=none; b=rQENm62m9L2XSo1MoF3fwv6I+7uMvCZrqxonD3aQuQdfiUlCum3PnDN6Y56ozJx5XCf/PbqYuRp5dzrbv9rq4655CBarezv0b+LXv4NQF4uB9U9T6+AUKowzJX4XOYDOhaNKXYVG8ArWnJu5epe+ppyS+ZQ7qcVUY0ac2s9bFUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575817; c=relaxed/simple;
	bh=dekFVcIuGm6tnqBZrNBZBrUw3En5mjA9/CX0fzauhWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGWn8qVAS7vzcIWxXh21gzN8Ir1kg+T2ZCWFGGNsdvT3LD5uXvtE96XCS2gjbJDZgItbTvT5tDkpi+sL78p98Nv8CNHeYXU2w1CHPzf16/On5ldBnBinnb3ZV3SU3LKQhMuxo/E/unPkgbPDIeBNBkAyx0SEEm2wLlKeGmlRBMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fu1P+0/d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8NmXlknxBJgQexTpKRVq32zBS3NbysG30WlEU8TZT1s=; b=fu1P+0/dYklKsDHT0RwrOxZMKI
	cU4SEhbiUKy7xwDGQetFmANPDkwy/BR3OBlQhW6/Xs8UmUo01YJdHwpDQdW+PoYqcioSdkU8c9bel
	L+/2Ckug55fnorlE8EyU3Cc0ce4YPE33ywOH1AoC7DNBQag0iKWYq25GccOfFs/rf98//9VQXvEMl
	xRCD8gdS62IJkYNGCyh/myRpR41MTkEocB/ka0hFqvUGf6vvyA88EtBwGcpumzlXwB583DYqaS2U4
	SjBs36LKettLZTLjwT3LcGDLoPbZGY0W5r4vnkz7ooikWJXvAuSLjuBX6FjYmO2YKsf7K11b/WREe
	nEQxo3NQ==;
Received: from 2a02-8389-2341-5b80-b79f-eb9e-0b40-3aae.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b79f:eb9e:b40:3aae] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1teszP-0000000F1hy-0P3t;
	Mon, 03 Feb 2025 09:43:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 4/7] iomap: support ioends for reads
Date: Mon,  3 Feb 2025 10:43:08 +0100
Message-ID: <20250203094322.1809766-5-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250203094322.1809766-1-hch@lst.de>
References: <20250203094322.1809766-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Support using the ioend structure to defer I/O completion for
reads in addition to writes.  This requires a check for the operation
to not merge reads and writes, and for buffere I/O a call into the
buffered read I/O completion handler from iomap_finish_ioend.  For
direct I/O the existing call into the direct I/O completion handler
handles reads just fine already.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 23 ++++++++++++++++++-----
 fs/iomap/internal.h    |  3 ++-
 fs/iomap/ioend.c       |  6 +++++-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index eaffa23eb8e4..06990e012884 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -306,14 +306,27 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 		folio_end_read(folio, uptodate);
 }
 
-static void iomap_read_end_io(struct bio *bio)
+static u32 __iomap_read_end_io(struct bio *bio, int error)
 {
-	int error = blk_status_to_errno(bio->bi_status);
 	struct folio_iter fi;
+	u32 folio_count = 0;
 
-	bio_for_each_folio_all(fi, bio)
+	bio_for_each_folio_all(fi, bio) {
 		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
+		folio_count++;
+	}
 	bio_put(bio);
+	return folio_count;
+}
+
+static void iomap_read_end_io(struct bio *bio)
+{
+	__iomap_read_end_io(bio, blk_status_to_errno(bio->bi_status));
+}
+
+u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend)
+{
+	return __iomap_read_end_io(&ioend->io_bio, ioend->io_error);
 }
 
 struct iomap_readpage_ctx {
@@ -1568,7 +1581,7 @@ static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
  * state, release holds on bios, and finally free up memory.  Do not use the
  * ioend after this.
  */
-u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
+u32 iomap_finish_ioend_buffered_write(struct iomap_ioend *ioend)
 {
 	struct inode *inode = ioend->io_inode;
 	struct bio *bio = &ioend->io_bio;
@@ -1600,7 +1613,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
 	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
 
 	ioend->io_error = blk_status_to_errno(bio->bi_status);
-	iomap_finish_ioend_buffered(ioend);
+	iomap_finish_ioend_buffered_write(ioend);
 }
 
 /*
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index f6992a3bf66a..c824e74a3526 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -4,7 +4,8 @@
 
 #define IOEND_BATCH_SIZE	4096
 
-u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
+u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend);
+u32 iomap_finish_ioend_buffered_write(struct iomap_ioend *ioend);
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
 
 #endif /* _IOMAP_INTERNAL_H */
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 18894ebba6db..2dd29403dc10 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -44,7 +44,9 @@ static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 		return 0;
 	if (ioend->io_flags & IOMAP_IOEND_DIRECT)
 		return iomap_finish_ioend_direct(ioend);
-	return iomap_finish_ioend_buffered(ioend);
+	if (bio_op(&ioend->io_bio) == REQ_OP_READ)
+		return iomap_finish_ioend_buffered_read(ioend);
+	return iomap_finish_ioend_buffered_write(ioend);
 }
 
 /*
@@ -83,6 +85,8 @@ EXPORT_SYMBOL_GPL(iomap_finish_ioends);
 static bool iomap_ioend_can_merge(struct iomap_ioend *ioend,
 		struct iomap_ioend *next)
 {
+	if (bio_op(&ioend->io_bio) != bio_op(&next->io_bio))
+		return false;
 	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
 		return false;
 	if (next->io_flags & IOMAP_IOEND_BOUNDARY)
-- 
2.45.2


