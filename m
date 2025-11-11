Return-Path: <linux-fsdevel+bounces-67987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F885C4F9F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E38934ADFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B84D329E7E;
	Tue, 11 Nov 2025 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk88bnyC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54839329E6B
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889934; cv=none; b=jsSQ52c2erPA9mcGbtlaiqr5/cSHILn8pfH1LTflsQQUZ25C3FxtUiXTrCn0q6967Q9wAbHZoEw5oNTpuS9jcX74dkFGeuJeSxxbTNtHRoXcg1kuTo+cyCqozwIcMFiwQw5tesxnf4eAR9aBmTBOIHFVW7e1UaKeE9qfo05BmqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889934; c=relaxed/simple;
	bh=w0+Usrt+E4IkYrlx9xM/SBoFel2ABVw1pwzQZiOYtLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4nMhBcwxwMBv7YzL5iTTSU5wC/I8oJT4mYVIdXp+KPomGE3O6863RAJ6QleIJQlAO4Tg+7Lpk75RmQVE/m791nlwskXGTzeJitD0nH+l+s9hMguszLBx3rGXpP/bL4Q0OLKYzwj+n/aEwoGwRIyln2/HLDPtUjhRhte4CiRz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xk88bnyC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3436a328bbbso118611a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762889931; x=1763494731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AH8x9dSzIDpYdpuz0OzOcYPg14tgoaNAIfg1B3VbWNs=;
        b=Xk88bnyCt5S2iqvgsPghsdwXV1LODVNp/jrDH8d16ZPulAsjFsRhnMm37+/DI1EB68
         L+BdX4TsbPRM7YIWx+Rb98PQBd4/w30kQvj9Fy5XIJ1uu3bGQlw04xjAK4cN/lfO6x7X
         +bhebDYSkYiT3PGyS1Wq5ILYDXC8aStBLasEfiIxKgBLllyjvKQ4vc4KKKI/YOzVbG1X
         QqgjEnXgpf7iP7DcIbS2gcd6C2mQyqa2Umo2AklXMoHOXSQ6Gd+/kzVqZ6QxPXE9xqEy
         CFEece+2pfZYN+hCb5tCuoSAyKQK+g5l19q9TRluHahoXUAXec+/TJiGmmTvUFgrNEmK
         DKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889931; x=1763494731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AH8x9dSzIDpYdpuz0OzOcYPg14tgoaNAIfg1B3VbWNs=;
        b=WingVl2BN47PxcJliSBI6sU78ZLkpZtVPQDi9AYDupYsFCxXH6rwSkUBIP+whpZM+u
         gZJzPTnkkVr0GTZCte036IBfCooGjvV6XGhwfy0CVr661YWacaD1n/m+eOiGUl/db9SG
         UYWmrUhiMyukNh1RwFvWURZpBawcC0cc/6K0naiAGh9UXZ3+/SJTshGKfxrtuZrTR/bP
         KrTaVezALw1DhJAeC7WrYcUaiVox27HelTHOig+/Bv7c1S+2l4SO3AltaVUoo9aVoVWd
         BWG2GU2WFoc/WyK0dtkBhUKtJwf0dfLqHGdpAgnMy1caM7HxgHL8XgOK+Oek9EXtQrFo
         ebqA==
X-Forwarded-Encrypted: i=1; AJvYcCW1HD4LkPpo+VRur7wwjFNM5R0CAcpBt+6GbDmQt0wc6XllCh0m48OepqKuKw52D5+ItotjwZGuesgLSXi9@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFtdS/69NrPN3iTBJhU72TBdQs+EizO/kbLfO7FHEeWpPtOsZ
	iMGx7nrA9WvSPoYFqfYa+XZ5XSTIF7syKM2ZrH0q1Oj4j1Dkv3CJAEbM
X-Gm-Gg: ASbGncvfZte+Sz+XPZMfCLXlNFPJQYsblWb9lHtKHjHE/oHRrlyY0jxmrrW2wJnKcsq
	lWj+s5QMRXZuVSNUdUCFPv5jV8cNilJ1E7QltZQPbu2O06JCZvyx1+Nugmow/z1TAhzqazym/kT
	0INurOqReQW9o5T4WGelgPapVpjDixVfYjdr+6t/qJDc4EE8+530mnRsAydoj9SpR+proRhQlOh
	MkIdz62QJc4lXjYgOMofviCnyWOwbw1MWhwn/umMCuiyTyQZrfC49Xh/1HI4ZR6kilYwkG2JWLu
	QLzYQTgjeIJfsPnpqtpu58cqKfyl4AMacpfH6WD32PtqhF07coMNGlAr1vSBtuqUJJ027uu43Qg
	QP+fU3C+2kmNXm2IsPomdeEXXi8fgas/9axCaoHbkFlrfRmlayvMfXMrk7AhnuMLU2ADcooNQnb
	GpkfMOUxddxyyKf47n+E+3rjdRpQ4=
X-Google-Smtp-Source: AGHT+IGu/sl5mi15VB+XkpiRtVu4UhCuKFm54IJdcH7aqdr0s7EbEBqyb+7BX9WrcVgDnwtkm1abuQ==
X-Received: by 2002:a17:90b:52:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-343ddebefbemr544761a91.26.1762889931646;
        Tue, 11 Nov 2025 11:38:51 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343614818f5sm13387942a91.15.2025.11.11.11.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:38:51 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 8/9] iomap: use find_next_bit() for dirty bitmap scanning
Date: Tue, 11 Nov 2025 11:36:57 -0800
Message-ID: <20251111193658.3495942-9-joannelkoong@gmail.com>
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

Use find_next_bit()/find_next_zero_bit() for iomap dirty bitmap
scanning. This uses __ffs() internally and is more efficient for
finding the next dirty or clean bit than iterating through the bitmap
range testing every bit.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 61 ++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 98c4665addb2..1a7146d6ba49 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -76,13 +76,34 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 		folio_mark_uptodate(folio);
 }
 
-static inline bool ifs_block_is_dirty(struct folio *folio,
-		struct iomap_folio_state *ifs, int block)
+/*
+ * Find the next dirty block in the folio. end_blk is inclusive.
+ * If no dirty block is found, this will return end_blk + 1.
+ */
+static unsigned ifs_next_dirty_block(struct folio *folio,
+		unsigned start_blk, unsigned end_blk)
 {
+	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = folio->mapping->host;
-	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+	unsigned int blks = i_blocks_per_folio(inode, folio);
+
+	return find_next_bit(ifs->state, blks + end_blk + 1,
+			blks + start_blk) - blks;
+}
+
+/*
+ * Find the next clean block in the folio. end_blk is inclusive.
+ * If no clean block is found, this will return end_blk + 1.
+ */
+static unsigned ifs_next_clean_block(struct folio *folio,
+		unsigned start_blk, unsigned end_blk)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks = i_blocks_per_folio(inode, folio);
 
-	return test_bit(block + blks_per_folio, ifs->state);
+	return find_next_zero_bit(ifs->state, blks + end_blk + 1,
+			blks + start_blk) - blks;
 }
 
 static unsigned ifs_find_dirty_range(struct folio *folio,
@@ -94,18 +115,17 @@ static unsigned ifs_find_dirty_range(struct folio *folio,
 		offset_in_folio(folio, *range_start) >> inode->i_blkbits;
 	unsigned end_blk = min_not_zero(
 		offset_in_folio(folio, range_end) >> inode->i_blkbits,
-		i_blocks_per_folio(inode, folio));
-	unsigned nblks = 1;
-
-	while (!ifs_block_is_dirty(folio, ifs, start_blk))
-		if (++start_blk == end_blk)
-			return 0;
+		i_blocks_per_folio(inode, folio)) - 1;
+	unsigned nblks;
 
-	while (start_blk + nblks < end_blk) {
-		if (!ifs_block_is_dirty(folio, ifs, start_blk + nblks))
-			break;
-		nblks++;
-	}
+	start_blk = ifs_next_dirty_block(folio, start_blk, end_blk);
+	if (start_blk > end_blk)
+		return 0;
+	if (start_blk == end_blk)
+		nblks = 1;
+	else
+		nblks = ifs_next_clean_block(folio, start_blk + 1, end_blk) -
+				start_blk;
 
 	*range_start = folio_pos(folio) + (start_blk << inode->i_blkbits);
 	return nblks << inode->i_blkbits;
@@ -1167,7 +1187,7 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
 		struct folio *folio, loff_t start_byte, loff_t end_byte,
 		struct iomap *iomap, iomap_punch_t punch)
 {
-	unsigned int first_blk, last_blk, i;
+	unsigned int first_blk, last_blk;
 	loff_t last_byte;
 	u8 blkbits = inode->i_blkbits;
 	struct iomap_folio_state *ifs;
@@ -1186,10 +1206,11 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
 			folio_pos(folio) + folio_size(folio) - 1);
 	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
 	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
-	for (i = first_blk; i <= last_blk; i++) {
-		if (!ifs_block_is_dirty(folio, ifs, i))
-			punch(inode, folio_pos(folio) + (i << blkbits),
-				    1 << blkbits, iomap);
+	while ((first_blk = ifs_next_clean_block(folio, first_blk, last_blk))
+		       <= last_blk) {
+		punch(inode, folio_pos(folio) + (first_blk << blkbits),
+				1 << blkbits, iomap);
+		first_blk++;
 	}
 }
 
-- 
2.47.3


