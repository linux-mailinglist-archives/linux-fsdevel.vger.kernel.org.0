Return-Path: <linux-fsdevel+bounces-63697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C205EBCB27E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 00:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B3B34E61BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 22:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F81628726C;
	Thu,  9 Oct 2025 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0D42yTK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474E26A0BD
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050673; cv=none; b=KFxNP55DnqHSSlpa2qlLMzdsocIs89xtZEULaxQsZ3bhTBWX/GmAvKXrj5VN3QPpAf7FdA4JB20X7cQvp9aM4Hnnhdc73/D3qPJA1FTVTeTQ4izDhb7vOQYUoERh+JSNAwedCQF+QgNyqF7Be3KbHNVZhS2dMECAA19BoL2maRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050673; c=relaxed/simple;
	bh=SvNQyF4Iwqk9M1fddOnJE29j0XWhZHoSNlkH3OddWh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEaX17Zn/8dD8E+HwI9oPQ7lhTk53e+GXPMeUkwawatBZpMAWfBr72Dls4p1QImpjpvLuV02QlngTKbsZqsPoOYA6FTxcnNJec+G733MmatPBf9UsmKsd8f2nsz4vUs1I8l0XVi50iwaFPx63kkoArLOaWa7kHOUByG4UA3bMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0D42yTK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b554bb615dcso970625a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 15:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760050671; x=1760655471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rs5pVXR9kMeeh944yMdIzgzZFscpFY7U3/sj81a//fU=;
        b=e0D42yTKw75TV/dsvprXcXlTivAIsF//Bis7b0JYf8F1bqPE4EUUacpkwT4LOvgXiU
         0wNEpeQGYa7F14h/1aBxsFu2h2cAkZkxpxZSZzjFfdvv/zBF7JulbJsfjA4kY4nskRx1
         6KLne95ElVTOW69Xu/EN0kcA4jLy7JBQoLsMAZ3PVp3pKEr2CoGtoJ33JWDf18iy9/4i
         nM9KbMALLdO31hDA3EebzA9gSC63DX46RWtoma9ReY2kIwVnigEjNj3jRxjRxdDmRTMb
         C5znaJgN/8yWkX5kW/PZPvOIe//51my4vtW5JT6FqZmcHVen+qXJFWBYGHiuVHXEDM3K
         FY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050671; x=1760655471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rs5pVXR9kMeeh944yMdIzgzZFscpFY7U3/sj81a//fU=;
        b=KbhpQIg0M/H8AvuyL1FQWYIolUArv0Y8PRAj45kWa2wfEVyv8ELJEcImy9uj2rPcvV
         y3KyfUeVYQmSjKRl0plK/TCJSEbWahad3B8UNFeFdVx5PHzpfVYjg3+kejGPL9ONAiHc
         8b8gb/037BqlwIBbfEzQW5GaXtLom2dSyXGpj+apAQ2wVGrjmSlrzzS+OluZdITZsTtO
         nU4pGikg8Mkhmb70EYsuSqgJ7ON4BqPpM/QcUTLljuVStAWBUPSYyreQA5gOrEHGhFmZ
         DZrNnPCefdYTuhumh70UucWyUf/aPGGkYdK3OdCnU53t/b4TlAn1orP9qemBY5zpdQaF
         /w5w==
X-Forwarded-Encrypted: i=1; AJvYcCXCjRuMIZ48RtxjSBCVcDn+XjvMggOrkJx9EmLKpVcwZ8S/ilrQORTETcsVE/8nv5nmfNFdS5GWXyB4h9so@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3P3O0/wKgJpajQzumpdYq6NYuK2mi3LUEhMRboncDQAsL/B6
	Gzuk57EehEeEvh5v0W0JQrqrI0Lg6IN7JRRknNWROh80Pepw860MsJ3u
X-Gm-Gg: ASbGncu8A4DNMySAUXEohCR2Y/TjIlR2b0Y0uXG2ST2QsFFzevCu6mXAS8EXJrF7unM
	Q1Xum1kY8Hvt6dH2PqxiZGh9In+oIU295vTDSLc8C+nqqQ41qFRh/1Usg64Hu0JlMWK363Hx0y/
	aBHnKLPRnU5Pw6SM5stWSb1Fy5vuGS810A1U+kkw2zQbJDDgFWAbPkj1Jxc3DT1L+f0EuTZd9aH
	jaOIC57LlQ56SouY0b2EGKTsJg7cbxpzy0tltAxztqCX5AhjHzdmKZQ90AlU+VWGCBSmy01Kfg3
	AVJFZYDEm+VrmmBNmweUQMo9PttLYvSrerUDz/ZrUaO9tDHLfyvH9fSOK+kK6rZZ8nNnPkCDdDC
	10v9CYdl5nFaM1SmQptv47VWOI+TYKOxhITNlDiiSmEXU/rPY6jnzidQ4auFc6DOsD9077vTSwj
	TEaG19APo=
X-Google-Smtp-Source: AGHT+IGnOEc9lV3yHpLj0rmyQ2Gxh5m/m2GtuDAZDg2t+N/Nj7XtXxW3LbalqFV9nKtPYcpK9lA5Uw==
X-Received: by 2002:a17:903:120c:b0:26c:4085:e3f5 with SMTP id d9443c01a7336-29027391377mr112115885ad.50.1760050671001;
        Thu, 09 Oct 2025 15:57:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f837dcsm38758095ad.111.2025.10.09.15.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:57:50 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1 9/9] iomap: use find_next_bit() for uptodate bitmap scanning
Date: Thu,  9 Oct 2025 15:56:11 -0700
Message-ID: <20251009225611.3744728-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251009225611.3744728-1-joannelkoong@gmail.com>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use find_next_bit()/find_next_zero_bit() for iomap uptodate bitmap
scanning. This uses __ffs() internally and is more efficient for
finding the next uptodate or non-uptodate bit than manually iterating
through the bitmap range testing every bit.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
---
 fs/iomap/buffered-io.c | 62 ++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 37d2b76ca230..043c10d22db9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -38,10 +38,36 @@ static inline bool ifs_is_fully_uptodate(struct folio *folio,
 	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
 }
 
-static inline bool ifs_block_is_uptodate(struct iomap_folio_state *ifs,
-		unsigned int block)
+/**
+* ifs_next_uptodate_block - find the next uptodate block in the folio
+* @folio: The folio
+* @start_blk: Block number to begin searching at
+* @end_blk: Last block number (inclusive) to search
+*
+* If no uptodate block is found, this will return end_blk + 1.
+*/
+static unsigned ifs_next_uptodate_block(struct folio *folio,
+		unsigned start_blk, unsigned end_blk)
 {
-	return test_bit(block, ifs->state);
+	struct iomap_folio_state *ifs = folio->private;
+
+	return find_next_bit(ifs->state, end_blk + 1, start_blk);
+}
+
+/**
+* ifs_next_nonuptodate_block - find the next non-uptodate block in the folio
+* @folio: The folio
+* @start_blk: Block number to begin searching at
+* @end_blk: Last block number (inclusive) to search
+*
+* If no non-uptodate block is found, this will return end_blk + 1.
+*/
+static unsigned ifs_next_nonuptodate_block(struct folio *folio,
+		unsigned start_blk, unsigned end_blk)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	return find_next_zero_bit(ifs->state, end_blk + 1, start_blk);
 }
 
 static bool ifs_set_range_uptodate(struct folio *folio,
@@ -291,14 +317,11 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
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
@@ -308,15 +331,15 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 			poff += bytes_skipped;
 			plen -= bytes_skipped;
 		}
-		first = i;
+		first = next;
 
-		/* truncate len if we find any trailing uptodate block(s) */
-		while (++i <= last) {
-			if (ifs_block_is_uptodate(ifs, i)) {
+		/* find any trailing uptodate block(s) */
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
@@ -609,7 +632,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = folio->mapping->host;
-	unsigned first, last, i;
+	unsigned first, last;
 
 	if (!ifs)
 		return false;
@@ -621,10 +644,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
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


