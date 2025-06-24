Return-Path: <linux-fsdevel+bounces-52666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F85AAE59E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451601B605D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC3E235044;
	Tue, 24 Jun 2025 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNj8fEI3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384BB22F74D;
	Tue, 24 Jun 2025 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731789; cv=none; b=pmls5MsZPXVIl8m06BTehSFCpzqW7Su0gcv/5YUzzMMxBRNA7PZQ9HTR2fFXcMqvg16vkVJMXpq+vntkLpwE97vyAkfPC2JInOp2l6kJGJYIDd/Mc3rOXno4kVY/f21k929rtm8XvbIcraLtG+GYmzjH9g0G0YAce+sR9o/TNYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731789; c=relaxed/simple;
	bh=3nKlE5VC0LlEbV7ukou8eVdPj4LvKIiAtYaDhhdxxPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THRPhxORsdPsZu/sPdXAXvlmnhzOFSk8XwDBfnj12ZhJ0sW2RCosxbbVaxMU9BI6F2Z7SLoBLq4SDqFHzv+BRLoySBUDPeHcXOY6+Op0X+vpZ7uCYg1hvdgm3bD9LE4/G28jRN8+Vo7p5Qmfi1QNlY4tZfSQHHTH5jfAUXmCTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNj8fEI3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23694cec0feso45202145ad.2;
        Mon, 23 Jun 2025 19:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731786; x=1751336586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNOybouhKwFglQApl9HPGZaZZkkV0YHgnyDvNFgjI7c=;
        b=QNj8fEI3cdNpm8JM37SbO/o4KCPioUDw399Bw/XfFCDKqEka5+YcI0YkS/GDt1LMsX
         dxrl+TsQvnlq/AW7cuZu9Tsr+teqibmWVah++MFSQujpS8QzmUlWrfIG/OeY1I6/iiJ6
         KA4yl06OE2eMAkL7jM+UskymeH5J9c6zww1swA6aUUUngxZIeCMDPVZvTh+Ws8FUl8pF
         5VEFBvJ5hU4YRZ+1n6WXLlWTgUGFe91U2JnLnv2nN/3Hw8rZI7i5MbxgAtPX2nNxox/F
         uL86Aegnk022u06TEYTFKbVoBNzoQs6OWvDYjdS6nb+gBoGREESYnI7f98JpuKRNrk3+
         +OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731786; x=1751336586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNOybouhKwFglQApl9HPGZaZZkkV0YHgnyDvNFgjI7c=;
        b=RoUghD85b43XrzjssYSsOLWeKLOTdWLbOJwquamWoidhb7okUH+HSKISkFpJ5ao1L+
         8+e6zk1hMZn2OJGHPjtX4djm9iR6xHlUkQrjIJQExw/wUK0O0/1q8E/by1Qg6P8vKqHB
         eTiG1eA/ylJSacyDMNiVpUNZrTs+T3r+NnufYJ11+HtIeAJNRQIzJlz7orQ9GnhE1KT8
         0qL0gprOnPH3sho+2f7mG/YU9XKGV19GXhSkxQ9+DNOjlVSsXmMtAgDWcYLB0lIXFEZb
         wyCxelqCRm1QCZnZ9A2kZaNb80pi7DMsmMkLkY6yadJ8bnZix3X2h04Gf0adedELWqhB
         1BUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2lM3TjA0oYJnCzyUV+tvzvmFpaJzPF4XwibAIlL3Kkm3UEu6VePPkL7+OCDetB4vIUCK6RpJtF9Wj@vger.kernel.org, AJvYcCWHwgfd4pqEcmzPX2OIDxpKIdpRWPyxd0MhWS3hmMvbjT+qNWPjbJHMURlBa+Y0r3L/fG54V/wpkd9T@vger.kernel.org, AJvYcCXLp29vShl0LzOGv96S8BOVOoWM5QkXcG791asIcQyTEQpOwUDhKlS3n8FCbLEUZalFCEKNls7V//AnSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDGxFdmZILJNRyaOLisP39EXXZWfnHlen5S8g5eadJ9BYqkqB
	Pm/KEEQIhhZKu/0LcJ58OqC95Xrnt5mNljiy3RzNANdZd/CA1LqMLb5k0pU1Sg==
X-Gm-Gg: ASbGncv5WrKXaWkp539RwhxwmT7tSeAu3eKU4Uhj1VaBGEsSbd/RuSZ4pOOAF+Z6STN
	L7KAy6z+UnzwpT9cyMN5xRFsSXzeyBTiwpPpztACOhxK2dgtwWePzM39m4sb7dvalhZmpJ2gNh2
	5+cV1ycnNNOoMLQkyIsNppbr0vmaEIo7Yi1JjO8WmFlgts51AAJrETgFlkYqyT6hWJ7vzYqF00L
	ctoYTxv1Ytt02FKlVcSG15PZ7UwEYss10i4BubOmry9CAsAgr3JUrZlmo8hZbB1Kryed2jvHZza
	VNqfZ4Bn8PE+OnmJifVoLhmAoUQkoUNL6ofbeSODQVz5Uvh8Ks8PTdLd
X-Google-Smtp-Source: AGHT+IFjWXyeSBB4vEagfFJo66emyHzDoUCphjpNXBVkkpqo5GR1of5TgEWph3TLmAvUPBoNfbYFHQ==
X-Received: by 2002:a17:903:2d0:b0:220:ea90:191e with SMTP id d9443c01a7336-237d96dfe20mr224271575ad.4.1750731786251;
        Mon, 23 Jun 2025 19:23:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d867df7asm93037765ad.178.2025.06.23.19.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:05 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 06/16] iomap: move all ioend handling to ioend.c
Date: Mon, 23 Jun 2025 19:21:25 -0700
Message-ID: <20250624022135.832899-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

Now that the writeback code has the proper abstractions, all the ioend
code can be self-contained in ioend.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 215 ----------------------------------------
 fs/iomap/internal.h    |   1 -
 fs/iomap/ioend.c       | 220 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 219 insertions(+), 217 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b4a8d2241d70..c262f883f9f9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1559,221 +1559,6 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
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
-int ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
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
-EXPORT_SYMBOL_GPL(ioend_writeback_submit);
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
index 18894ebba6db..81f4bac5a3a9 100644
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
+int ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
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
+EXPORT_SYMBOL_GPL(ioend_writeback_submit);
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
2.47.1


