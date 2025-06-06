Return-Path: <linux-fsdevel+bounces-50879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C744AD0A5E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8893B29AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF0E23FC6B;
	Fri,  6 Jun 2025 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA6aDSt9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6AC23F40D;
	Fri,  6 Jun 2025 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253371; cv=none; b=raLBd2U7oxr0v0BN1Cp4eYSDUoh1nGD2ABzuclmAGz4+GY1kK50HVh2QfA6/UI4zD7FfADgdqnd58W9sSBfZ3X7pClmawqbyjGraV4OSdF/kAwIHnq8indXShfNgRhBIFBkASYfzx2UIEDy6ASAs2E993cBOfXwvUmbEY+qRU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253371; c=relaxed/simple;
	bh=6oKmrJOQtDMHUObenrCuvXk96QkzJttENzmMmEaR4I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPycMRJwPGy9XdIFtGMG0DnUeHPXckgt/Es3uIuKyKmzavso/Sfqemn4MEfTH291lUxsG4a6L1XNYyslz5PtSEwAKd4qPcTf1Lot4QzIfXrgcJX2oxYmkATLsTMF4N4+UFzHEh3nX/iIZgFvAn2VnJ8ZO+wXFdoQyUEPCsbTEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CA6aDSt9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so2139099b3a.1;
        Fri, 06 Jun 2025 16:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749253369; x=1749858169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PG98AqFPAd0z7lKlXPkU0RizvJrrGQdXVmmvnPAesQ=;
        b=CA6aDSt9EO169QiAjugctcNKf1hEOV8vQ45TXlPzYjui1D6vdiXEO3vgODSIQPM6mn
         Nwi6M3HK6l4GU23H5n3LXU2J8IjAzW5eDelQ96mEdI2i+xKO47qU+2sAsG9NSU51gl0I
         T4/ad1WYKPGE5819OYYd4BsAh4KdKgJhCSnAgZAuTh+Sqxh62Lp9/kQ1s3SGywHUXds5
         D+zyWom+BGhWi29vzW3ZPmeKng9MnbN6F9PgOIsyc1PrBxW7Ac8BtTX6qVyW9e9wP9hg
         Iy2VnZZau7L+ooGKokItj8504sZr9olBm7smz7uK1MvMvB6UFxVdmv/LFJTrn0Pl3nge
         7Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749253369; x=1749858169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PG98AqFPAd0z7lKlXPkU0RizvJrrGQdXVmmvnPAesQ=;
        b=sTWMctYJEQ2/mp4GHOl7C4A1ctwIdmraETiGLMPtTDMlGfqg5ysg/s2MCbaTLK2O/S
         u4fXzwuLXVrDidpaCHzUvQEsb3rSQ9zYQ86sGh9hlRbrtGJlCGsLCb87S/mXZowwahRz
         uy8u+t0cnnMEY9L4H7WhG80ezBxto8xfVSgMw4pzsqpPG3RCBJrrx2kegj51YTwrJ4X0
         hmYkI6mHt3UURk2dzcCQe2H4U4s7PlG5OWkc8To2vziIDhL24kzD42w05JGb8K2hlqIC
         3GDTn0UD7MKQxu7rcknFx7vIoYmW+QbKzsYGLfVuAxVqTK0KHP5wKUH4fj1g0HOIsmRF
         G77w==
X-Forwarded-Encrypted: i=1; AJvYcCUIa8iy5XgtFN71mk4eBHY97GpmEaWvX2prfy7OAFtQ/+MRqIGm4ArK1ASGTpPIJN2ravzVbP8B42Fe@vger.kernel.org, AJvYcCWT/7W01h6BlEgO5tauSXa+BLxaUQrWHdfKQkrC3wdpLEfbzL4ZYKAc5YQUT9rNweq/xzioN4LBDuv54H7h@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg/VxCYAyZahm8rZ5ixy/73W+NWbuWW7F9RqX6jriyN3a74sz5
	jHKIPib7t8eQb3hIIIUH596iywLDQzB4RN1L7rdL/QtiF7YR4zqi+id1
X-Gm-Gg: ASbGncuxOepjplkMra1b2PphzuCwsIYyqm/PzoWH647KB53O6PKgCMgzzOl9NsS5DmM
	CnxmMvaoXUdRYFn34d0Uba6hpkdM0rl1BNBKM/82OixQfO1+SLoghQn+vmuezff5PI8YvcdKfiK
	ASPDVj+sslVvLnGxl/vrEenoetQcIY2fEiIR/W6Asaj6FHtGAvLLuz5/1YWSbhn0d+O+XtdUT0/
	pAmwMWoNB7xWlIKstTd3d8bkm+DsCA4WKRi6/ilWIBZ7KM7YWVhjtgcXYeWHEQ5LpozItNkKdK5
	Wnsc7cE2hdPDNQflUl2aip6+h7DxfOjYi3bXtpVCf9JzRXEJZG4PPnNv
X-Google-Smtp-Source: AGHT+IEW+gx6EeBQkmpZPSo9NdA8UbpFaFQgV+VXfBi/JWur78Lfw8YjklzLbnIr0yt9BrA46kFJFg==
X-Received: by 2002:a05:6a20:7d9d:b0:218:183b:ccaa with SMTP id adf61e73a8af0-21f4884f1d2mr923630637.17.1749253368670;
        Fri, 06 Jun 2025 16:42:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ed593f6sm1439070a12.1.2025.06.06.16.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:42:48 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: djwong@kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v1 1/8] iomap: move buffered io bio logic into separate file
Date: Fri,  6 Jun 2025 16:37:56 -0700
Message-ID: <20250606233803.1421259-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606233803.1421259-1-joannelkoong@gmail.com>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move buffered io bio logic into a separate file, buffered-io-bio.c, so
that callers that do not have CONFIG_BLOCK set and do not depend on bios
can also use iomap and hook into some of its internal features such as
granular dirty tracking for large folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/Makefile          |   5 +-
 fs/iomap/buffered-io-bio.c | 291 ++++++++++++++++++++++++++++++++++
 fs/iomap/buffered-io.c     | 309 ++-----------------------------------
 fs/iomap/internal.h        |  46 ++++++
 4 files changed, 356 insertions(+), 295 deletions(-)
 create mode 100644 fs/iomap/buffered-io-bio.c

diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index 69e8ebb41302..477d78c58807 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -9,8 +9,9 @@ ccflags-y += -I $(src)		# needed for trace events
 obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 
 iomap-y				+= trace.o \
-				   iter.o
-iomap-$(CONFIG_BLOCK)		+= buffered-io.o \
+				   iter.o \
+				   buffered-io.o
+iomap-$(CONFIG_BLOCK)		+= buffered-io-bio.o \
 				   direct-io.o \
 				   ioend.o \
 				   fiemap.o \
diff --git a/fs/iomap/buffered-io-bio.c b/fs/iomap/buffered-io-bio.c
new file mode 100644
index 000000000000..03841bed72e7
--- /dev/null
+++ b/fs/iomap/buffered-io-bio.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bio.h>
+#include <linux/buffer_head.h>
+#include <linux/iomap.h>
+#include <linux/writeback.h>
+
+#include "internal.h"
+
+static void iomap_finish_folio_read(struct folio *folio, size_t off,
+		size_t len, int error)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	bool uptodate = !error;
+	bool finished = true;
+
+	if (ifs) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&ifs->state_lock, flags);
+		if (!error)
+			uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
+		ifs->read_bytes_pending -= len;
+		finished = !ifs->read_bytes_pending;
+		spin_unlock_irqrestore(&ifs->state_lock, flags);
+	}
+
+	if (finished)
+		folio_end_read(folio, uptodate);
+}
+
+static void iomap_read_end_io(struct bio *bio)
+{
+	int error = blk_status_to_errno(bio->bi_status);
+	struct folio_iter fi;
+
+	bio_for_each_folio_all(fi, bio)
+		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
+	bio_put(bio);
+}
+
+int iomap_bio_readpage(const struct iomap *iomap, loff_t pos,
+		       struct iomap_readpage_ctx *ctx,
+		       size_t poff, size_t plen,
+		       loff_t length)
+{
+	struct folio *folio = ctx->cur_folio;
+	sector_t sector;
+
+	sector = iomap_sector(iomap, pos);
+	if (!ctx->bio ||
+	    bio_end_sector(ctx->bio) != sector ||
+	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
+		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
+		gfp_t orig_gfp = gfp;
+		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
+
+		if (ctx->bio)
+			submit_bio(ctx->bio);
+
+		if (ctx->rac) /* same as readahead_gfp_mask */
+			gfp |= __GFP_NORETRY | __GFP_NOWARN;
+		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
+				     REQ_OP_READ, gfp);
+		/*
+		 * If the bio_alloc fails, try it again for a single page to
+		 * avoid having to deal with partial page reads.  This emulates
+		 * what do_mpage_read_folio does.
+		 */
+		if (!ctx->bio) {
+			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
+					     orig_gfp);
+		}
+		if (ctx->rac)
+			ctx->bio->bi_opf |= REQ_RAHEAD;
+		ctx->bio->bi_iter.bi_sector = sector;
+		ctx->bio->bi_end_io = iomap_read_end_io;
+		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
+	}
+	return 0;
+}
+
+void iomap_submit_bio(struct bio *bio)
+{
+	submit_bio(bio);
+}
+
+int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio, size_t poff,
+			      size_t plen, const struct iomap *iomap) {
+	struct bio_vec bvec;
+	struct bio bio;
+
+	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
+	bio_add_folio_nofail(&bio, folio, plen, poff);
+	return submit_bio_wait(&bio);
+}
+
+static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
+		size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
+	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
+
+	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
+		folio_end_writeback(folio);
+}
+
+/*
+ * We're now finished for good with this ioend structure.  Update the page
+ * state, release holds on bios, and finally free up memory.  Do not use the
+ * ioend after this.
+ */
+u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
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
+static void iomap_writepage_end_bio(struct bio *bio)
+{
+	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
+
+	ioend->io_error = blk_status_to_errno(bio->bi_status);
+	iomap_finish_ioend_buffered(ioend);
+}
+
+void iomap_bio_ioend_error(struct iomap_writepage_ctx *wpc, int error)
+{
+	wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
+	bio_endio(&wpc->ioend->io_bio);
+}
+
+static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
+					     struct writeback_control *wbc,
+					     struct inode *inode, loff_t pos,
+					     u16 ioend_flags)
+{
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
+			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
+			       GFP_NOFS, &iomap_ioend_bioset);
+	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
+	bio->bi_end_io = iomap_writepage_end_bio;
+	bio->bi_write_hint = inode->i_write_hint;
+	wbc_init_bio(wbc, bio);
+	wpc->nr_folios = 0;
+	return iomap_init_ioend(inode, bio, pos, ioend_flags);
+}
+
+static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
+		u16 ioend_flags)
+{
+	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
+		return false;
+	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
+	    (wpc->ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
+		return false;
+	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
+		return false;
+	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
+	    iomap_sector(&wpc->iomap, pos) !=
+	    bio_end_sector(&wpc->ioend->io_bio))
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
+int iomap_bio_add_to_ioend(struct iomap_writepage_ctx *wpc,
+			   struct writeback_control *wbc, struct folio *folio,
+			   struct inode *inode, loff_t pos, loff_t end_pos,
+			   unsigned len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	size_t poff = offset_in_folio(folio, pos);
+	unsigned int ioend_flags = 0;
+	int error;
+
+	if (wpc->iomap.type == IOMAP_UNWRITTEN)
+		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
+	if (wpc->iomap.flags & IOMAP_F_SHARED)
+		ioend_flags |= IOMAP_IOEND_SHARED;
+	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
+		ioend_flags |= IOMAP_IOEND_BOUNDARY;
+
+	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
+new_ioend:
+		error = iomap_submit_ioend(wpc, 0);
+		if (error)
+			return error;
+		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos,
+				ioend_flags);
+		if (!wpc->ioend)
+			return -ENOTSUPP;
+	}
+
+	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
+		goto new_ioend;
+
+	if (ifs)
+		atomic_add(len, &ifs->write_bytes_pending);
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
+	wpc->ioend->io_size += len;
+	if (wpc->ioend->io_offset + wpc->ioend->io_size > end_pos)
+		wpc->ioend->io_size = end_pos - wpc->ioend->io_offset;
+
+	wbc_account_cgroup_owner(wbc, folio, len);
+	return 0;
+}
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 31553372b33a..1caeb4921035 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -13,7 +13,6 @@
 #include <linux/dax.h>
 #include <linux/writeback.h>
 #include <linux/swap.h>
-#include <linux/bio.h>
 #include <linux/sched/signal.h>
 #include <linux/migrate.h>
 #include "internal.h"
@@ -21,23 +20,6 @@
 
 #include "../internal.h"
 
-/*
- * Structure allocated for each folio to track per-block uptodate, dirty state
- * and I/O completions.
- */
-struct iomap_folio_state {
-	spinlock_t		state_lock;
-	unsigned int		read_bytes_pending;
-	atomic_t		write_bytes_pending;
-
-	/*
-	 * Each block has two bits in this bitmap:
-	 * Bits [0..blocks_per_folio) has the uptodate status.
-	 * Bits [b_p_f...(2*b_p_f))   has the dirty status.
-	 */
-	unsigned long		state[];
-};
-
 static inline bool ifs_is_fully_uptodate(struct folio *folio,
 		struct iomap_folio_state *ifs)
 {
@@ -52,8 +34,8 @@ static inline bool ifs_block_is_uptodate(struct iomap_folio_state *ifs,
 	return test_bit(block, ifs->state);
 }
 
-static bool ifs_set_range_uptodate(struct folio *folio,
-		struct iomap_folio_state *ifs, size_t off, size_t len)
+bool ifs_set_range_uptodate(struct folio *folio, struct iomap_folio_state *ifs,
+			    size_t off, size_t len)
 {
 	struct inode *inode = folio->mapping->host;
 	unsigned int first_blk = off >> inode->i_blkbits;
@@ -284,45 +266,6 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	*lenp = plen;
 }
 
-static void iomap_finish_folio_read(struct folio *folio, size_t off,
-		size_t len, int error)
-{
-	struct iomap_folio_state *ifs = folio->private;
-	bool uptodate = !error;
-	bool finished = true;
-
-	if (ifs) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&ifs->state_lock, flags);
-		if (!error)
-			uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
-		ifs->read_bytes_pending -= len;
-		finished = !ifs->read_bytes_pending;
-		spin_unlock_irqrestore(&ifs->state_lock, flags);
-	}
-
-	if (finished)
-		folio_end_read(folio, uptodate);
-}
-
-static void iomap_read_end_io(struct bio *bio)
-{
-	int error = blk_status_to_errno(bio->bi_status);
-	struct folio_iter fi;
-
-	bio_for_each_folio_all(fi, bio)
-		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
-	bio_put(bio);
-}
-
-struct iomap_readpage_ctx {
-	struct folio		*cur_folio;
-	bool			cur_folio_in_bio;
-	struct bio		*bio;
-	struct readahead_control *rac;
-};
-
 /**
  * iomap_read_inline_data - copy inline data into the page cache
  * @iter: iteration structure
@@ -371,7 +314,6 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	struct folio *folio = ctx->cur_folio;
 	struct iomap_folio_state *ifs;
 	size_t poff, plen;
-	sector_t sector;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -394,43 +336,17 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	}
 
 	ctx->cur_folio_in_bio = true;
+
+	ret = iomap_bio_readpage(iomap, pos, ctx, poff, plen, length);
+	if (ret)
+		return ret;
+
 	if (ifs) {
 		spin_lock_irq(&ifs->state_lock);
 		ifs->read_bytes_pending += plen;
 		spin_unlock_irq(&ifs->state_lock);
 	}
 
-	sector = iomap_sector(iomap, pos);
-	if (!ctx->bio ||
-	    bio_end_sector(ctx->bio) != sector ||
-	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
-		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
-		gfp_t orig_gfp = gfp;
-		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
-
-		if (ctx->bio)
-			submit_bio(ctx->bio);
-
-		if (ctx->rac) /* same as readahead_gfp_mask */
-			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				     REQ_OP_READ, gfp);
-		/*
-		 * If the bio_alloc fails, try it again for a single page to
-		 * avoid having to deal with partial page reads.  This emulates
-		 * what do_mpage_read_folio does.
-		 */
-		if (!ctx->bio) {
-			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
-					     orig_gfp);
-		}
-		if (ctx->rac)
-			ctx->bio->bi_opf |= REQ_RAHEAD;
-		ctx->bio->bi_iter.bi_sector = sector;
-		ctx->bio->bi_end_io = iomap_read_end_io;
-		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
-	}
-
 done:
 	/*
 	 * Move the caller beyond our range so that it keeps making progress.
@@ -474,7 +390,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	if (ctx.bio) {
-		submit_bio(ctx.bio);
+		iomap_submit_bio(ctx.bio);
 		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
 	} else {
 		WARN_ON_ONCE(ctx.cur_folio_in_bio);
@@ -546,7 +462,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 		iter.status = iomap_readahead_iter(&iter, &ctx);
 
 	if (ctx.bio)
-		submit_bio(ctx.bio);
+		iomap_submit_bio(ctx.bio);
 	if (ctx.cur_folio) {
 		if (!ctx.cur_folio_in_bio)
 			folio_unlock(ctx.cur_folio);
@@ -670,13 +586,7 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
 		size_t poff, size_t plen, const struct iomap *iomap)
 {
-	struct bio_vec bvec;
-	struct bio bio;
-
-	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
-	bio_add_folio_nofail(&bio, folio, plen, poff);
-	return submit_bio_wait(&bio);
+	return iomap_bio_read_folio_sync(block_start, folio, poff, plen, iomap);
 }
 
 static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
@@ -1519,58 +1429,6 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
-static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
-		size_t len)
-{
-	struct iomap_folio_state *ifs = folio->private;
-
-	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
-	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
-
-	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
-		folio_end_writeback(folio);
-}
-
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
-static void iomap_writepage_end_bio(struct bio *bio)
-{
-	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
-
-	ioend->io_error = blk_status_to_errno(bio->bi_status);
-	iomap_finish_ioend_buffered(ioend);
-}
-
 /*
  * Submit an ioend.
  *
@@ -1580,7 +1438,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
  * with the error status here to run the normal I/O completion handler to clear
  * the writeback bit and let the file system proess the errors.
  */
-static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
+int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 {
 	if (!wpc->ioend)
 		return error;
@@ -1597,151 +1455,16 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 		if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
 			error = -EIO;
 		if (!error)
-			submit_bio(&wpc->ioend->io_bio);
+			iomap_submit_bio(&wpc->ioend->io_bio);
 	}
 
-	if (error) {
-		wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
-		bio_endio(&wpc->ioend->io_bio);
-	}
+	if (error)
+		iomap_bio_ioend_error(wpc, error);
 
 	wpc->ioend = NULL;
 	return error;
 }
 
-static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct inode *inode, loff_t pos,
-		u16 ioend_flags)
-{
-	struct bio *bio;
-
-	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
-			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
-			       GFP_NOFS, &iomap_ioend_bioset);
-	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
-	bio->bi_end_io = iomap_writepage_end_bio;
-	bio->bi_write_hint = inode->i_write_hint;
-	wbc_init_bio(wbc, bio);
-	wpc->nr_folios = 0;
-	return iomap_init_ioend(inode, bio, pos, ioend_flags);
-}
-
-static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
-		u16 ioend_flags)
-{
-	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
-		return false;
-	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
-	    (wpc->ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
-		return false;
-	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
-		return false;
-	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
-	    iomap_sector(&wpc->iomap, pos) !=
-	    bio_end_sector(&wpc->ioend->io_bio))
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
-static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, loff_t pos, loff_t end_pos,
-		unsigned len)
-{
-	struct iomap_folio_state *ifs = folio->private;
-	size_t poff = offset_in_folio(folio, pos);
-	unsigned int ioend_flags = 0;
-	int error;
-
-	if (wpc->iomap.type == IOMAP_UNWRITTEN)
-		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
-	if (wpc->iomap.flags & IOMAP_F_SHARED)
-		ioend_flags |= IOMAP_IOEND_SHARED;
-	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
-		ioend_flags |= IOMAP_IOEND_BOUNDARY;
-
-	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
-new_ioend:
-		error = iomap_submit_ioend(wpc, 0);
-		if (error)
-			return error;
-		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos,
-				ioend_flags);
-	}
-
-	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
-		goto new_ioend;
-
-	if (ifs)
-		atomic_add(len, &ifs->write_bytes_pending);
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
-	wpc->ioend->io_size += len;
-	if (wpc->ioend->io_offset + wpc->ioend->io_size > end_pos)
-		wpc->ioend->io_size = end_pos - wpc->ioend->io_offset;
-
-	wbc_account_cgroup_owner(wbc, folio, len);
-	return 0;
-}
-
 static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio,
 		struct inode *inode, u64 pos, u64 end_pos,
@@ -1769,8 +1492,8 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		case IOMAP_HOLE:
 			break;
 		default:
-			error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos,
-					end_pos, map_len);
+			error = iomap_bio_add_to_ioend(wpc, wbc, folio, inode,
+						       pos, end_pos, map_len);
 			if (!error)
 				(*count)++;
 			break;
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index f6992a3bf66a..8e59950ad8d6 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -4,7 +4,53 @@
 
 #define IOEND_BATCH_SIZE	4096
 
+/*
+ * Structure allocated for each folio to track per-block uptodate, dirty state
+ * and I/O completions.
+ */
+struct iomap_folio_state {
+	spinlock_t		state_lock;
+	unsigned int		read_bytes_pending;
+	atomic_t		write_bytes_pending;
+
+	/*
+	 * Each block has two bits in this bitmap:
+	 * Bits [0..blocks_per_folio) has the uptodate status.
+	 * Bits [b_p_f...(2*b_p_f))   has the dirty status.
+	 */
+	unsigned long		state[];
+};
+
+struct iomap_readpage_ctx {
+	struct folio		*cur_folio;
+	bool			cur_folio_in_bio;
+	struct bio		*bio;
+	struct readahead_control *rac;
+};
+
 u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
+bool ifs_set_range_uptodate(struct folio *folio, struct iomap_folio_state *ifs,
+			    size_t off, size_t len);
+int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error);
+
+#ifdef CONFIG_BLOCK
+int iomap_bio_readpage(const struct iomap *iomap, loff_t pos,
+		       struct iomap_readpage_ctx *ctx, size_t poff,
+		       size_t plen, loff_t length);
+void iomap_submit_bio(struct bio *bio);
+int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio, size_t poff,
+			       size_t plen, const struct iomap *iomap);
+void iomap_bio_ioend_error(struct iomap_writepage_ctx *wpc, int error);
+int iomap_bio_add_to_ioend(struct iomap_writepage_ctx *wpc, struct writeback_control *wbc,
+			   struct folio *folio, struct inode *inode, loff_t pos,
+			   loff_t end_pos, unsigned len);
+#else
+#define iomap_bio_readpage(...)		(-ENOSYS)
+#define iomap_submit_bio(...)			((void)0)
+#define iomap_bio_read_folio_sync(...)		(-ENOSYS)
+#define iomap_bio_ioend_error(...)		((void)0)
+#define iomap_bio_add_to_ioend(...)		(-ENOSYS)
+#endif /* CONFIG_BLOCK */
 
 #endif /* _IOMAP_INTERNAL_H */
-- 
2.47.1


