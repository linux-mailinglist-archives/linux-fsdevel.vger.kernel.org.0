Return-Path: <linux-fsdevel+bounces-51621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B867CAD97A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F621BC23C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AD428DB46;
	Fri, 13 Jun 2025 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1aRwRCR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C221FA15E;
	Fri, 13 Jun 2025 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851441; cv=none; b=mgQMbfRGZXNiXvwS5JcvOxL0EcH+yvCmS+G1XeNlp+pf3UGMS6VVwf/3Xu8tteDUbZWJA8iFnbVzszeCoNq2wKfb77vJYyj9eFwI8sDXOzVxESW1SiyhkokFpeu6ifJih0zDJK65r18lDaVcWRjhM9HURKWi4KUg7bvBF8XQDOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851441; c=relaxed/simple;
	bh=0vuiONlTKTGLWpons2srUx16ccNuo3JtSb1fw2oGBNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffJazTH83+8P7PtSPtTI3wNOzYzzzJY2tRxQX2x3IsEW6JvuOW8D+U+kxV7HWP++6UoKc6DYgKDisG2Baba0wWRGfExOoQiyguUddqG7RkQuz26gOYN+n7XZZC+08+eU2PYBlYUOjKMFFv/3bWCZR+OZgahE/KIOzC8yAKfUAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1aRwRCR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2363616a1a6so22332385ad.3;
        Fri, 13 Jun 2025 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851438; x=1750456238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqUfWHDTzMRd0g3NuYCJds+g1ddg0kt7VK1bpZ2xp4w=;
        b=P1aRwRCRAcvut0DY5B1dO55Aq7qOmNZUJCWfkW7nTb+2z2wDUs+fYMzaa6Yvq4fmN4
         +otqi3/TOvsmzyAk8p6ljxEnpBWJ4wY33dMdjwJMHiBR5/DXQrvhrFgm80cCAlsh1K6F
         ws2pKWPuMjNjxrXjnp9YvugGYMfUXXGRgoAHctRHtPnPSRPh5bwrEADx6ifaEwGoWo89
         oJOuYRxxV8b8MZXzz27NygzeqMZKTPWSj0Sn76il6oaSeH2P3mBfySRd+oJ3eO0DJnwd
         Txt55C/ato4GZvpBPLni5hwVZBJf8LFXpBNwpvSbDI1M7vSQ/nITUgVcedZEp3T8/RBi
         4a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851438; x=1750456238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqUfWHDTzMRd0g3NuYCJds+g1ddg0kt7VK1bpZ2xp4w=;
        b=ejmSotJMjakC5PFBHbPVoOeqYVqjE21BPV6KexZEpM2PqtbulPmuTXI9XDAWlkF03K
         h/P6kNoXRhgCcnlK/+PzXKSOS7zNFzQwRgh2VgoNQFGWdjlsAxT1DPtOxwmTB+SiEjKO
         PAb9K+LrXknqOo6UselboU7I2gBbbU9X+mMd68L7u/6IUtSrA+0LsNVWnME4QRNlnFhz
         2Uhz+fzg73RpOtFe0PC81lbXY49vEhGQFT5+jANpHuZ5NfhTZ7YflF+2Dt5oigLqlGRu
         RwruVj/XidbMbGyBKP3Q13efnQTP1hL13Y8XeTjDq1SUgXS3v6Embkt2mDqRcWH9dwR3
         RG4g==
X-Forwarded-Encrypted: i=1; AJvYcCXuJbDl6F+OIeuamrZJm+pB5idNk4rQTNZknNQ2OJlbLTcgPs+Reaf6/JiPolh3ASziTb90KY34NU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9TOQ0nOjCUekZSoLvMMG9xLQY+cik5g4ggBvIz6uwmX9N2XT
	Jy6Zs/dojOahMTcmGNCpXowA2Y5Ankg/gIQcrFirITmox4gdpjbQKQg3D+1QSw==
X-Gm-Gg: ASbGncvugxqY3nYmbuMEICsv3IdLpADRyVniisbtzUdm09/yCmOmGBI2TAVcjjuG12s
	h8ZFO762h3sa7LemhBodoViLufl69VNxVXIRt+uMsc3629+X/7n6Rh5e5zOqFf+ND9/eY2pci2A
	YGvt9u6g2xI0wou/BgD5a+L2SE7HUth5UNZ759JDaK4WCuMkYrSvSRFmo41BEEAtBPEJ3QYSoG3
	X3ZijBlXnaPN6WoE+mLguC6EV5m20uh3XDKlfDzAPjVQCaJkFrt3Po3MCYmapI0bm/zCnn+GWyo
	YKZS8t42tv7kweHPp5KTd8OIrSqtIwi49ABl69tvqQ4rSHqglkeIFOWxJczOG6Tn5TY=
X-Google-Smtp-Source: AGHT+IGl/nrA1NhiCBo0utac595YLJMgeTGbnPfnfMA9hCNyLUzbtSjSEhdLF27zRZpruwQDFR7uIQ==
X-Received: by 2002:a17:902:f68b:b0:234:8c64:7875 with SMTP id d9443c01a7336-2366b14e5a0mr16413925ad.38.1749851437957;
        Fri, 13 Jun 2025 14:50:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c09dsm19683465ad.33.2025.06.13.14.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:50:37 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 01/16] iomap: move buffered io CONFIG_BLOCK dependent logic into separate file
Date: Fri, 13 Jun 2025 14:46:26 -0700
Message-ID: <20250613214642.2903225-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the bulk of buffered io logic that depends on CONFIG_BLOCK into a
separate file, buffered-io-bio.c, in the effort to make it so that
callers that do not have CONFIG_BLOCK set may also use iomap for
buffered io to hook into some of its internal features such as granular
dirty and uptodate tracking for large folios.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/Makefile          |   1 +
 fs/iomap/buffered-io-bio.c | 210 +++++++++++++++++++++++++++++++++++
 fs/iomap/buffered-io.c     | 222 +------------------------------------
 fs/iomap/internal.h        |  25 +++++
 4 files changed, 239 insertions(+), 219 deletions(-)
 create mode 100644 fs/iomap/buffered-io-bio.c

diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index 69e8ebb41302..fb7e8a7a3da4 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 iomap-y				+= trace.o \
 				   iter.o
 iomap-$(CONFIG_BLOCK)		+= buffered-io.o \
+				   buffered-io-bio.o \
 				   direct-io.o \
 				   ioend.o \
 				   fiemap.o \
diff --git a/fs/iomap/buffered-io-bio.c b/fs/iomap/buffered-io-bio.c
new file mode 100644
index 000000000000..24f5ede7af3d
--- /dev/null
+++ b/fs/iomap/buffered-io-bio.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (C) 2016-2023 Christoph Hellwig.
+ */
+#include <linux/bio.h>
+#include <linux/buffer_head.h>
+#include <linux/iomap.h>
+#include <linux/writeback.h>
+
+#include "internal.h"
+
+int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
+		size_t poff, size_t plen, const struct iomap *iomap)
+{
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
+static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
+		struct writeback_control *wbc, struct inode *inode, loff_t pos,
+		u16 ioend_flags)
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
+int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
+		struct writeback_control *wbc, struct folio *folio,
+		struct inode *inode, loff_t pos, loff_t end_pos,
+		unsigned len)
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
+	if (folio_test_dropbehind(folio))
+		ioend_flags |= IOMAP_IOEND_DONTCACHE;
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
index 3729391a18f3..47e27459da4d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -21,23 +21,6 @@
 
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
@@ -52,8 +35,8 @@ static inline bool ifs_block_is_uptodate(struct iomap_folio_state *ifs,
 	return test_bit(block, ifs->state);
 }
 
-static bool ifs_set_range_uptodate(struct folio *folio,
-		struct iomap_folio_state *ifs, size_t off, size_t len)
+bool ifs_set_range_uptodate(struct folio *folio, struct iomap_folio_state *ifs,
+		size_t off, size_t len)
 {
 	struct inode *inode = folio->mapping->host;
 	unsigned int first_blk = off >> inode->i_blkbits;
@@ -667,18 +650,6 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 					 pos + len - 1);
 }
 
-static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
-		size_t poff, size_t plen, const struct iomap *iomap)
-{
-	struct bio_vec bvec;
-	struct bio bio;
-
-	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
-	bio_add_folio_nofail(&bio, folio, plen, poff);
-	return submit_bio_wait(&bio);
-}
-
 static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
 		struct folio *folio)
 {
@@ -1535,58 +1506,6 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
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
@@ -1596,7 +1515,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
  * with the error status here to run the normal I/O completion handler to clear
  * the writeback bit and let the file system proess the errors.
  */
-static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
+int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 {
 	if (!wpc->ioend)
 		return error;
@@ -1625,141 +1544,6 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
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
-	if (folio_test_dropbehind(folio))
-		ioend_flags |= IOMAP_IOEND_DONTCACHE;
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
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index f6992a3bf66a..2fc1796053da 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -4,7 +4,32 @@
 
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
 u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
+bool ifs_set_range_uptodate(struct folio *folio, struct iomap_folio_state *ifs,
+		size_t off, size_t len);
+int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error);
+int iomap_read_folio_sync(loff_t block_start, struct folio *folio, size_t poff,
+		size_t plen, const struct iomap *iomap);
+int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
+		struct writeback_control *wbc, struct folio *folio,
+		struct inode *inode, loff_t pos, loff_t end_pos, unsigned len);
 
 #endif /* _IOMAP_INTERNAL_H */
-- 
2.47.1


