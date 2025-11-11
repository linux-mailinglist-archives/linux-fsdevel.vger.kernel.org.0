Return-Path: <linux-fsdevel+bounces-67988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43AC4F9F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA4004E3691
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB4232ABC4;
	Tue, 11 Nov 2025 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcPH9y5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AED329E60
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889935; cv=none; b=t54OOTNf0D8ivkPObXSFIE55e9rjc7JR2XPDl/i23YQcnS8OVAt9kQJGTLUpoiRXe5/XKdF6vVmIXtMlQLZYOlMdTFoTFguWh9dpbjxs6naYeB9UOK+tkrdod7fs0Rky0NMhvfh1/I4AUvA+tprePGMb6rC78oKGyKJVecmPAAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889935; c=relaxed/simple;
	bh=9nZVIepa3DDFWiaB2LbsMB++tRhzwqO90Si+ZVb4geg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh1gl+yKNxZxj6UWjSQtzoHLkHgksdKy0A3toI+X0boWxKUgN7/J/ZOUdb/slHwsNtYU3nfT8Hhl4HOxYo55Vx9osrNhpZ5AboGdqAN9sbgWzQ2hg5eiMrcnbSmd7/obIKtswRfjwJjGca922psh0RFLNg8QRZqZ+QCokTbjUcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcPH9y5t; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3436d6aa66dso977535a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762889933; x=1763494733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0ncL4R2zk6s6B7KYTY9YZceUgKlRnM/SCAT7RRqscs=;
        b=VcPH9y5tPJyFk07MqcwjarYyf3CgB05JUmtib4D5oSlAh6qUNL1JRdwBTmI+eaH0t/
         c7YGh+vGxrEXzGX6rFDaCBjzJkuc50HLtENhCeB/+aPtaN3c+5PIXLGAtefQxGWALDNZ
         bX2kqJJCUcdk9FZZIisD3KAl8IGMeMgLUvljUn4g9IEQ/rDHYoJ+tbGIEz7yuIkzMnxn
         HAqWlOy4563FIVeiTsDcfLLILsBKA4mVsfqbm0jM2jVOt8RP7kvMg859SoksIUZ4zM0H
         sdRJDFaRlthnPX5k4tT0fyfzqPMd6rOgzHkHwccXh6Ix/Ll9jKAYAG3tyr9+s0btruiR
         62fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889933; x=1763494733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d0ncL4R2zk6s6B7KYTY9YZceUgKlRnM/SCAT7RRqscs=;
        b=Z9auYjpi45GfHFO82EBoS0/Tc1YQh0VfDL1HkNWAX1Jjxf9iAjMegHOSmKMbU/WigB
         K+3KAx2HeresnSWqufqih5XhHeEQUyCOnccrvxghQYBLnBByWbsU0vwnQ9fpTxxn/tfX
         D2fGuNjIIV6vO8J1jz6g4mprEkBQXutr/nCy4TqoE5SD2xCagzG4X7xnxOIBy/DnVok6
         iw1W0Um/FRCkunXMuQTtj/x4oBbLKnlD5nR4672BKjpelhsVXVkYosbzFkAkOvx7Uj7X
         euGLODQluDgI9r4wJ+fxJj8pvQpvofwtWATR8WC+HRHZLUSjdokh7i9kIA3mU4asAIPO
         O9lQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8Qil9YWuA0UFYq0+o13Eb2cGCXyJ5cFwclBde1oHF6CL1hSsec3/sTKUwrB2j7cbmG9D1KbxI+4yFDqF3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwlt8dBMI2JsLea4oddWJgNOwzEXPX4ryvPVKJyW0Lh7EFHF+e
	ZNVX8zkTTPWrjT/69pGUkOo/UxmJvmCvoaR2PXILlzdn8rgvC1hEP9c2
X-Gm-Gg: ASbGncswvk8DEeUevqLLXfdWx+vsHfSHwm4LYprFcSW2AY2NXLAoMfSFyip3n6hZ+Dx
	tPrNH/F15P7H+0j8AAS8o+A5WFBT7Jf0Z69gGZ8tZXFKDSadf1K2u82/QQ6gMvO8m/KifIU9M9J
	Cr8GwRfuF2bWPIRtKupOQj6wnyQEqUcLV0AVvrTLntU58P5O3sbQJjP226ke0Dvp6jXuaWWbeeb
	rTREoQhKJ0BNZWVW+RhIOH7iFex5CAgcMmpqtUGg8d+aU9qbDwascda+0FItgnk74CtdlHdFXtI
	FQ0t/3jSwFm4qYgpuy6ZyNTFK3ACthh/zFKKcgkR9ciLZYmL5cX00r85vL9dYtCnC9mBG9042mK
	Bnd0mJ+Kt0e++mD6ZGHs65EZU16qugruEXn7BCc8eCaYqertOf1oZMs7QKhTQlU9Bzl9h63Rvcs
	/UXyZx4/xZCOS5D7+9GliDGGQHrjk=
X-Google-Smtp-Source: AGHT+IF2bR5318yk3LnrBxyoujWhW0I30BzJZc58KJsh8YufSMsN0bMJpyML6eBa43+Slys5PmwJOQ==
X-Received: by 2002:a17:90b:2689:b0:343:3898:e7c9 with SMTP id 98e67ed59e1d1-343befa52a0mr5086995a91.2.1762889933028;
        Tue, 11 Nov 2025 11:38:53 -0800 (PST)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343c4f61e50sm1727583a91.5.2025.11.11.11.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:38:52 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 9/9] iomap: use find_next_bit() for uptodate bitmap scanning
Date: Tue, 11 Nov 2025 11:36:58 -0800
Message-ID: <20251111193658.3495942-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111193658.3495942-1-joannelkoong@gmail.com>
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use find_next_bit()/find_next_zero_bit() for iomap uptodate bitmap
scanning. This uses __ffs() internally and is more efficient for
finding the next uptodate or non-uptodate bit than iterating through the
the bitmap range testing every bit.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 52 ++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1a7146d6ba49..0475d949e5a0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -38,10 +38,28 @@ static inline bool ifs_is_fully_uptodate(struct folio *folio,
 	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
 }
 
-static inline bool ifs_block_is_uptodate(struct iomap_folio_state *ifs,
-		unsigned int block)
+/*
+ * Find the next uptodate block in the folio. end_blk is inclusive.
+ * If no uptodate block is found, this will return end_blk + 1.
+ */
+static unsigned ifs_next_uptodate_block(struct folio *folio,
+		unsigned start_blk, unsigned end_blk)
 {
-	return test_bit(block, ifs->state);
+	struct iomap_folio_state *ifs = folio->private;
+
+	return find_next_bit(ifs->state, end_blk + 1, start_blk);
+}
+
+/*
+ * Find the next non-uptodate block in the folio. end_blk is inclusive.
+ * If no non-uptodate block is found, this will return end_blk + 1.
+ */
+static unsigned ifs_next_nonuptodate_block(struct folio *folio,
+		unsigned start_blk, unsigned end_blk)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	return find_next_zero_bit(ifs->state, end_blk + 1, start_blk);
 }
 
 static bool ifs_set_range_uptodate(struct folio *folio,
@@ -278,14 +296,11 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	 * to avoid reading in already uptodate ranges.
 	 */
 	if (ifs) {
-		unsigned int i, blocks_skipped;
+		unsigned int next, blocks_skipped;
 
-		/* move forward for each leading block marked uptodate */
-		for (i = first; i <= last; i++)
-			if (!ifs_block_is_uptodate(ifs, i))
-				break;
+		next = ifs_next_nonuptodate_block(folio, first, last);
+		blocks_skipped = next - first;
 
-		blocks_skipped = i - first;
 		if (blocks_skipped) {
 			unsigned long block_offset = *pos & (block_size - 1);
 			unsigned bytes_skipped =
@@ -295,15 +310,15 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 			poff += bytes_skipped;
 			plen -= bytes_skipped;
 		}
-		first = i;
+		first = next;
 
 		/* truncate len if we find any trailing uptodate block(s) */
-		while (++i <= last) {
-			if (ifs_block_is_uptodate(ifs, i)) {
+		if (++next <= last) {
+			next = ifs_next_uptodate_block(folio, next, last);
+			if (next <= last) {
 				plen -= iomap_bytes_to_truncate(*pos + plen,
-						block_bits, last - i + 1);
-				last = i - 1;
-				break;
+						block_bits, last - next + 1);
+				last = next - 1;
 			}
 		}
 	}
@@ -640,7 +655,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = folio->mapping->host;
-	unsigned first, last, i;
+	unsigned first, last;
 
 	if (!ifs)
 		return false;
@@ -652,10 +667,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	first = from >> inode->i_blkbits;
 	last = (from + count - 1) >> inode->i_blkbits;
 
-	for (i = first; i <= last; i++)
-		if (!ifs_block_is_uptodate(ifs, i))
-			return false;
-	return true;
+	return ifs_next_nonuptodate_block(folio, first, last) > last;
 }
 EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 
-- 
2.47.3


