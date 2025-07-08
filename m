Return-Path: <linux-fsdevel+bounces-54254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C38AFCC94
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303AA16CE50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF52E03FA;
	Tue,  8 Jul 2025 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KNKdadql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6E12DECBF;
	Tue,  8 Jul 2025 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982720; cv=none; b=DCXK5HUeOLA1hNEMogp3LwNqdxzLluhF61aDgc0sL7k+TpcZe+Pv5PzVh3K8aRpxC0rGtgTnwN849aDaTFvcZ74q8uJKCtdWcFdvak6V0T5clKgm56lw2qbVAmlu5jZ1dREPdXLBXHBMCPF0+jdAB1peAR5AXbomcQnne/khQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982720; c=relaxed/simple;
	bh=tlHiEJHHNQkM4DosyglS8C2VugS3dp9ntwGpJk6CDao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tnzpso9xnQFzKat3CbHSVi/e0JAN32jKGdLpKOc1gS23p6owkbSZR/HCYB5jXqDCOVdheV/EixWqzk2tdd4XwEq5c5jq9h8KZ6DYtXpT+++UL1jjBJ8hpTLXqZaEtBJX7gkMpFqEVxVYUiJRkd7zz+7RP6d6sbsLUZn/c8Mi8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KNKdadql; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=73aZR6iK+5wpy1H/slYy3sWYlzqj6t3nYkVEXO26EoE=; b=KNKdadqlNif7b6YdYfHedoNsFN
	X3GPs0P95RofVgx3SErHc4HJNd+ycQjH+/2uy8DOm9rSDqGVyvONpwkSegm4H9iUUxAtUlDpP8jC0
	w2XNnMUbSTKluIeL7VTIN/3IOd9ADbaRwmxnzXUhtBotafAN4LRHJTZ1o/XicBjLzF5MZCKxy9O5B
	hpT+VEf+hY2RvQOcyEav1YKeUIE/VyRALPjRckq+/zypBOGJZskVnUIybfQHXA3geidfw+ppuKDu5
	tbOLWOxsToO82Z0b1rCgVk+NnIxjOvx/i1m2VgVm0xGB7o4vNxsmevXRbwbUvv2J6AJryj6qmWOBg
	JQAUNUgw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ8jl-00000005URn-1LPT;
	Tue, 08 Jul 2025 13:51:57 +0000
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
Subject: [PATCH 07/14] iomap: move all ioend handling to ioend.c
Date: Tue,  8 Jul 2025 15:51:13 +0200
Message-ID: <20250708135132.3347932-8-hch@lst.de>
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

Now that the writeback code has the proper abstractions, all the ioend
code can be self-contained in ioend.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 215 ----------------------------------------
 fs/iomap/internal.h    |   1 -
 fs/iomap/ioend.c       | 220 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 219 insertions(+), 217 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index aaeaceba8adc..6c29c5043309 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1549,221 +1549,6 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 }
 EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
-/*
- * We're now finished for good with this ioend structure.  Update the page
- * state, release holds on bios, and finally free up memory.  Do not use the
- * ioend after this.
- */
-u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
-{
-	struct inode *inode = ioend->io_inode;
-	struct bio *bio = &ioend->io_bio;
-	struct folio_iter fi;
-	u32 folio_count = 0;
-
-	if (ioend->io_error) {
-		mapping_set_error(inode->i_mapping, ioend->io_error);
-		if (!bio_flagged(bio, BIO_QUIET)) {
-			pr_err_ratelimited(
-"%s: writeback error on inode %lu, offset %lld, sector %llu",
-				inode->i_sb->s_id, inode->i_ino,
-				ioend->io_offset, ioend->io_sector);
-		}
-	}
-
-	/* walk all folios in bio, ending page IO on them */
-	bio_for_each_folio_all(fi, bio) {
-		iomap_finish_folio_write(inode, fi.folio, fi.length);
-		folio_count++;
-	}
-
-	bio_put(bio);	/* frees the ioend */
-	return folio_count;
-}
-
-static void ioend_writeback_end_bio(struct bio *bio)
-{
-	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
-
-	ioend->io_error = blk_status_to_errno(bio->bi_status);
-	iomap_finish_ioend_buffered(ioend);
-}
-
-/*
- * We cannot cancel the ioend directly in case of an error, so call the bio end
- * I/O handler with the error status here to run the normal I/O completion
- * handler.
- */
-int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
-{
-	struct iomap_ioend *ioend = wpc->wb_ctx;
-
-	if (!ioend->io_bio.bi_end_io)
-		ioend->io_bio.bi_end_io = ioend_writeback_end_bio;
-
-	if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
-		error = -EIO;
-
-	if (error) {
-		ioend->io_bio.bi_status = errno_to_blk_status(error);
-		bio_endio(&ioend->io_bio);
-		return error;
-	}
-
-	submit_bio(&ioend->io_bio);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iomap_ioend_writeback_submit);
-
-static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
-		loff_t pos, u16 ioend_flags)
-{
-	struct bio *bio;
-
-	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
-			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
-			       GFP_NOFS, &iomap_ioend_bioset);
-	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
-	bio->bi_write_hint = wpc->inode->i_write_hint;
-	wbc_init_bio(wpc->wbc, bio);
-	wpc->nr_folios = 0;
-	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
-}
-
-static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
-		u16 ioend_flags)
-{
-	struct iomap_ioend *ioend = wpc->wb_ctx;
-
-	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
-		return false;
-	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
-	    (ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
-		return false;
-	if (pos != ioend->io_offset + ioend->io_size)
-		return false;
-	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
-	    iomap_sector(&wpc->iomap, pos) != bio_end_sector(&ioend->io_bio))
-		return false;
-	/*
-	 * Limit ioend bio chain lengths to minimise IO completion latency. This
-	 * also prevents long tight loops ending page writeback on all the
-	 * folios in the ioend.
-	 */
-	if (wpc->nr_folios >= IOEND_BATCH_SIZE)
-		return false;
-	return true;
-}
-
-/*
- * Test to see if we have an existing ioend structure that we could append to
- * first; otherwise finish off the current ioend and start another.
- *
- * If a new ioend is created and cached, the old ioend is submitted to the block
- * layer instantly.  Batching optimisations are provided by higher level block
- * plugging.
- *
- * At the end of a writeback pass, there will be a cached ioend remaining on the
- * writepage context that the caller will need to submit.
- */
-ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
-		loff_t pos, loff_t end_pos, unsigned int dirty_len)
-{
-	struct iomap_ioend *ioend = wpc->wb_ctx;
-	size_t poff = offset_in_folio(folio, pos);
-	unsigned int ioend_flags = 0;
-	unsigned int map_len = min_t(u64, dirty_len,
-		wpc->iomap.offset + wpc->iomap.length - pos);
-	int error;
-
-	trace_iomap_add_to_ioend(wpc->inode, pos, dirty_len, &wpc->iomap);
-
-	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
-
-	switch (wpc->iomap.type) {
-	case IOMAP_INLINE:
-		WARN_ON_ONCE(1);
-		return -EIO;
-	case IOMAP_HOLE:
-		return map_len;
-	default:
-		break;
-	}
-
-	if (wpc->iomap.type == IOMAP_UNWRITTEN)
-		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
-	if (wpc->iomap.flags & IOMAP_F_SHARED)
-		ioend_flags |= IOMAP_IOEND_SHARED;
-	if (folio_test_dropbehind(folio))
-		ioend_flags |= IOMAP_IOEND_DONTCACHE;
-	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
-		ioend_flags |= IOMAP_IOEND_BOUNDARY;
-
-	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
-new_ioend:
-		if (ioend) {
-			error = wpc->ops->writeback_submit(wpc, 0);
-			if (error)
-				return error;
-		}
-		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
-	}
-
-	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
-		goto new_ioend;
-
-	iomap_start_folio_write(wpc->inode, folio, map_len);
-
-	/*
-	 * Clamp io_offset and io_size to the incore EOF so that ondisk
-	 * file size updates in the ioend completion are byte-accurate.
-	 * This avoids recovering files with zeroed tail regions when
-	 * writeback races with appending writes:
-	 *
-	 *    Thread 1:                  Thread 2:
-	 *    ------------               -----------
-	 *    write [A, A+B]
-	 *    update inode size to A+B
-	 *    submit I/O [A, A+BS]
-	 *                               write [A+B, A+B+C]
-	 *                               update inode size to A+B+C
-	 *    <I/O completes, updates disk size to min(A+B+C, A+BS)>
-	 *    <power failure>
-	 *
-	 *  After reboot:
-	 *    1) with A+B+C < A+BS, the file has zero padding in range
-	 *       [A+B, A+B+C]
-	 *
-	 *    |<     Block Size (BS)   >|
-	 *    |DDDDDDDDDDDD0000000000000|
-	 *    ^           ^        ^
-	 *    A          A+B     A+B+C
-	 *                       (EOF)
-	 *
-	 *    2) with A+B+C > A+BS, the file has zero padding in range
-	 *       [A+B, A+BS]
-	 *
-	 *    |<     Block Size (BS)   >|<     Block Size (BS)    >|
-	 *    |DDDDDDDDDDDD0000000000000|00000000000000000000000000|
-	 *    ^           ^             ^           ^
-	 *    A          A+B           A+BS       A+B+C
-	 *                             (EOF)
-	 *
-	 *    D = Valid Data
-	 *    0 = Zero Padding
-	 *
-	 * Note that this defeats the ability to chain the ioends of
-	 * appending writes.
-	 */
-	ioend->io_size += map_len;
-	if (ioend->io_offset + ioend->io_size > end_pos)
-		ioend->io_size = end_pos - ioend->io_offset;
-
-	wbc_account_cgroup_owner(wpc->wbc, folio, map_len);
-	return map_len;
-}
-EXPORT_SYMBOL_GPL(iomap_add_to_ioend);
-
 static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
 		bool *wb_pending)
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index f6992a3bf66a..d05cb3aed96e 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -4,7 +4,6 @@
 
 #define IOEND_BATCH_SIZE	4096
 
-u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
 
 #endif /* _IOMAP_INTERNAL_H */
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 18894ebba6db..b49fa75eab26 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2024-2025 Christoph Hellwig.
+ * Copyright (c) 2016-2025 Christoph Hellwig.
  */
 #include <linux/iomap.h>
 #include <linux/list_sort.h>
+#include <linux/pagemap.h>
+#include <linux/writeback.h>
 #include "internal.h"
+#include "trace.h"
 
 struct bio_set iomap_ioend_bioset;
 EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
@@ -28,6 +31,221 @@ struct iomap_ioend *iomap_init_ioend(struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(iomap_init_ioend);
 
+/*
+ * We're now finished for good with this ioend structure.  Update the folio
+ * state, release holds on bios, and finally free up memory.  Do not use the
+ * ioend after this.
+ */
+static u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
+{
+	struct inode *inode = ioend->io_inode;
+	struct bio *bio = &ioend->io_bio;
+	struct folio_iter fi;
+	u32 folio_count = 0;
+
+	if (ioend->io_error) {
+		mapping_set_error(inode->i_mapping, ioend->io_error);
+		if (!bio_flagged(bio, BIO_QUIET)) {
+			pr_err_ratelimited(
+"%s: writeback error on inode %lu, offset %lld, sector %llu",
+				inode->i_sb->s_id, inode->i_ino,
+				ioend->io_offset, ioend->io_sector);
+		}
+	}
+
+	/* walk all folios in bio, ending page IO on them */
+	bio_for_each_folio_all(fi, bio) {
+		iomap_finish_folio_write(inode, fi.folio, fi.length);
+		folio_count++;
+	}
+
+	bio_put(bio);	/* frees the ioend */
+	return folio_count;
+}
+
+static void ioend_writeback_end_bio(struct bio *bio)
+{
+	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
+
+	ioend->io_error = blk_status_to_errno(bio->bi_status);
+	iomap_finish_ioend_buffered(ioend);
+}
+
+/*
+ * We cannot cancel the ioend directly in case of an error, so call the bio end
+ * I/O handler with the error status here to run the normal I/O completion
+ * handler.
+ */
+int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
+{
+	struct iomap_ioend *ioend = wpc->wb_ctx;
+
+	if (!ioend->io_bio.bi_end_io)
+		ioend->io_bio.bi_end_io = ioend_writeback_end_bio;
+
+	if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
+		error = -EIO;
+
+	if (error) {
+		ioend->io_bio.bi_status = errno_to_blk_status(error);
+		bio_endio(&ioend->io_bio);
+		return error;
+	}
+
+	submit_bio(&ioend->io_bio);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iomap_ioend_writeback_submit);
+
+static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
+		loff_t pos, u16 ioend_flags)
+{
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
+			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
+			       GFP_NOFS, &iomap_ioend_bioset);
+	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
+	bio->bi_write_hint = wpc->inode->i_write_hint;
+	wbc_init_bio(wpc->wbc, bio);
+	wpc->nr_folios = 0;
+	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
+}
+
+static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
+		u16 ioend_flags)
+{
+	struct iomap_ioend *ioend = wpc->wb_ctx;
+
+	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
+		return false;
+	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
+	    (ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
+		return false;
+	if (pos != ioend->io_offset + ioend->io_size)
+		return false;
+	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
+	    iomap_sector(&wpc->iomap, pos) != bio_end_sector(&ioend->io_bio))
+		return false;
+	/*
+	 * Limit ioend bio chain lengths to minimise IO completion latency. This
+	 * also prevents long tight loops ending page writeback on all the
+	 * folios in the ioend.
+	 */
+	if (wpc->nr_folios >= IOEND_BATCH_SIZE)
+		return false;
+	return true;
+}
+
+/*
+ * Test to see if we have an existing ioend structure that we could append to
+ * first; otherwise finish off the current ioend and start another.
+ *
+ * If a new ioend is created and cached, the old ioend is submitted to the block
+ * layer instantly.  Batching optimisations are provided by higher level block
+ * plugging.
+ *
+ * At the end of a writeback pass, there will be a cached ioend remaining on the
+ * writepage context that the caller will need to submit.
+ */
+ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
+		loff_t pos, loff_t end_pos, unsigned int dirty_len)
+{
+	struct iomap_ioend *ioend = wpc->wb_ctx;
+	size_t poff = offset_in_folio(folio, pos);
+	unsigned int ioend_flags = 0;
+	unsigned int map_len = min_t(u64, dirty_len,
+		wpc->iomap.offset + wpc->iomap.length - pos);
+	int error;
+
+	trace_iomap_add_to_ioend(wpc->inode, pos, dirty_len, &wpc->iomap);
+
+	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
+
+	switch (wpc->iomap.type) {
+	case IOMAP_INLINE:
+		WARN_ON_ONCE(1);
+		return -EIO;
+	case IOMAP_HOLE:
+		return map_len;
+	default:
+		break;
+	}
+
+	if (wpc->iomap.type == IOMAP_UNWRITTEN)
+		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
+	if (wpc->iomap.flags & IOMAP_F_SHARED)
+		ioend_flags |= IOMAP_IOEND_SHARED;
+	if (folio_test_dropbehind(folio))
+		ioend_flags |= IOMAP_IOEND_DONTCACHE;
+	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
+		ioend_flags |= IOMAP_IOEND_BOUNDARY;
+
+	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
+new_ioend:
+		if (ioend) {
+			error = wpc->ops->writeback_submit(wpc, 0);
+			if (error)
+				return error;
+		}
+		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
+	}
+
+	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
+		goto new_ioend;
+
+	iomap_start_folio_write(wpc->inode, folio, map_len);
+
+	/*
+	 * Clamp io_offset and io_size to the incore EOF so that ondisk
+	 * file size updates in the ioend completion are byte-accurate.
+	 * This avoids recovering files with zeroed tail regions when
+	 * writeback races with appending writes:
+	 *
+	 *    Thread 1:                  Thread 2:
+	 *    ------------               -----------
+	 *    write [A, A+B]
+	 *    update inode size to A+B
+	 *    submit I/O [A, A+BS]
+	 *                               write [A+B, A+B+C]
+	 *                               update inode size to A+B+C
+	 *    <I/O completes, updates disk size to min(A+B+C, A+BS)>
+	 *    <power failure>
+	 *
+	 *  After reboot:
+	 *    1) with A+B+C < A+BS, the file has zero padding in range
+	 *       [A+B, A+B+C]
+	 *
+	 *    |<     Block Size (BS)   >|
+	 *    |DDDDDDDDDDDD0000000000000|
+	 *    ^           ^        ^
+	 *    A          A+B     A+B+C
+	 *                       (EOF)
+	 *
+	 *    2) with A+B+C > A+BS, the file has zero padding in range
+	 *       [A+B, A+BS]
+	 *
+	 *    |<     Block Size (BS)   >|<     Block Size (BS)    >|
+	 *    |DDDDDDDDDDDD0000000000000|00000000000000000000000000|
+	 *    ^           ^             ^           ^
+	 *    A          A+B           A+BS       A+B+C
+	 *                             (EOF)
+	 *
+	 *    D = Valid Data
+	 *    0 = Zero Padding
+	 *
+	 * Note that this defeats the ability to chain the ioends of
+	 * appending writes.
+	 */
+	ioend->io_size += map_len;
+	if (ioend->io_offset + ioend->io_size > end_pos)
+		ioend->io_size = end_pos - ioend->io_offset;
+
+	wbc_account_cgroup_owner(wpc->wbc, folio, map_len);
+	return map_len;
+}
+EXPORT_SYMBOL_GPL(iomap_add_to_ioend);
+
 static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 {
 	if (ioend->io_parent) {
-- 
2.47.2


