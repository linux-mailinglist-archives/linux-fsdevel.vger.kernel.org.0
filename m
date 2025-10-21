Return-Path: <linux-fsdevel+bounces-64978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D998FBF7C5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F30D3A4791
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD85D34776D;
	Tue, 21 Oct 2025 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A50nYHbe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BAC34740D
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065123; cv=none; b=GLcVgbhLxJtBldJmBb+M7gBMk8GjPSFGvso0eYXTzNN7y+j5Xm5kCLXZ0BbGrhPNRuE97102BQx4MSrtl+f8Wz3BgcfZtyOVJ+z1uYZAK/eDbWkUzGhl1csyTjBEeUY83GGq2QigPD2yp16PcVXSwVJWwTxM4FqSZ8TfaHpD61I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065123; c=relaxed/simple;
	bh=kBNf9m9ouv4wqNUD7CYYvggf8qGbAMWrBYmbKHQtNyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4Uyq2MOJ3KR5Ia8XfLV0C2yamivWOkZKFvu+6AM9gCqKn/DjHG0vjyVm4TcCVGogebwBNHRUdSUrL9tH2+B7nU/j0r01/3VMWA5of8TD1CPqs1QHPJO5IF0QVzKQjJHcQC94U2OPyQn0JPEBgzOlbWasod2pz//TzrIdWXHTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A50nYHbe; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a1603a098eso3625435b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065121; x=1761669921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiN5f1rb4c0P2a2HgGb0QpwQDu4GhG8zjS5OoJhoANE=;
        b=A50nYHbekLlZs5xIVhbnvNC/Xss/Dqxgv62O0T4ciwKXIUPRd4kuj0J2MSbhgzqgUS
         mP++K/hQcD3dKYKTEfLEytsTdwMAdUERHxAJes+fnx7vh13Tlp+r+VVy4Mj2j9YhDpxo
         Noi7T68aehK9zTbAIsH8nnYQE4dK1nRixX8FKNH/wFkjU+7pFoGQjJfxqFoLxpnqQmVX
         wGG8PdekhRjuaxJYXScSe9VANXTOQfY7x/dmQFB/J156w/HxkuuM0+/oDtqUwbmzifu6
         uO44jqRMg0Nyizlanhy4g4rqff8FS9YdDYFT82PRzK9Dxe+vFqIW0IIeS48xD81f7jXO
         9/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065121; x=1761669921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiN5f1rb4c0P2a2HgGb0QpwQDu4GhG8zjS5OoJhoANE=;
        b=LChVd4U16p6hqDEGL6VIsfD427GoD4ux69n9IOGiqHf12kBr0jNLBzFEzR/6I6slif
         bR25P+b9pGusZ7PLFIXyZ98sfwp6AiUCBSTH19oFUZCymiOzXr4E8J05nxcFIvkVq+dq
         kV89Zrq0J//gWY6+nxyMu9GotCFs+wt2MLadSj7iXv4B0owmwj6wQ5t0RvmVqcM446y0
         V4CRDOyajtEojEPW7OcR4uGqe2HTyTqsyA/cEPBhqVQ8eyK/ewlKu+U8CJKWuSXgKRmU
         bG+FUfAX1mPKbkiUsw0R6fUQpX8aIbd30tgB1gCXVGtj4gZs95+2mjawnQDQxyiSY8Vk
         /ldA==
X-Forwarded-Encrypted: i=1; AJvYcCWXl9Ryb4/Pu8j5LVJkVanINyZw4AmRFELHQHbGsY972+5H4CFjZzGAQA1CKStZV0q0BrNbsyyygy/iysQm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2lmFlLukCwfui/CcAPiFCG1jkuwyLWoI7PUYGeBlREVRXav+o
	nU7BhQ05reDVAqVG01YzqRfEXI5O0kqIBR6GdDyeABIa364lZghS98bQ
X-Gm-Gg: ASbGncsSP/sxRqxrECaD785XBbrLs29bi3RUFnNSmbz9Q/v3nDr4Ar50aQ8vNQaIZOL
	kpON6C5kf69OOzzz4vTpAFMaqfQBuZMj+zp8ZOqeLOHIhfGSEzp9ZZUCk/xqsnTeFDu6GAzLu2v
	J+2E5eLlNINdN1aZhTjjrpWTmZQCTttBCLxk5DirlhREBuOzt/IJy6GzCYXPbP2Yi/0xyR0IZiA
	biitsaxHfTa0JDXb3Aw3Y2tAEqTzu37vjfVAfbG1o4dbBQBo5vQRv9P4ttal3PlDeVEVothk/UN
	gwHbjpC+2sjLmKzODkCbFmZnzopq3Ao9S3MT/MFKENl8i5bcQYlDgN3aYhh09tbh0q+wzv2N0il
	B+tQ9wh773nuUSITlfsEvBMbokI1g7xwgdxbi1FwCxsj8iNN5i8KgVR7eX3+TZRadALLjYEbwIC
	corhwD4g4sdGWpV3EbWCFujf3TNlEnKTjR0u2d
X-Google-Smtp-Source: AGHT+IGJtNlc2qBVg5LRIXsZppg4OvIbiheblgSjxz0L7qCm9GB8y21liE4CjcHez+u4By2BzZQFQA==
X-Received: by 2002:a05:6a20:2443:b0:303:8207:eb51 with SMTP id adf61e73a8af0-334a864aaf2mr24496991637.55.1761065120687;
        Tue, 21 Oct 2025 09:45:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:c::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b349b2sm11019030a12.23.2025.10.21.09.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:45:20 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 8/8] iomap: use find_next_bit() for uptodate bitmap scanning
Date: Tue, 21 Oct 2025 09:43:52 -0700
Message-ID: <20251021164353.3854086-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021164353.3854086-1-joannelkoong@gmail.com>
References: <20251021164353.3854086-1-joannelkoong@gmail.com>
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
---
 fs/iomap/buffered-io.c | 52 ++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 156ec619b1e5..0b842f350eec 100644
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
@@ -596,7 +611,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = folio->mapping->host;
-	unsigned first, last, i;
+	unsigned first, last;
 
 	if (!ifs)
 		return false;
@@ -608,10 +623,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
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


