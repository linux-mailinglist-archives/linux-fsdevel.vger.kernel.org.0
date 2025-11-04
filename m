Return-Path: <linux-fsdevel+bounces-66998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9540FC32F8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D24B4EF0EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B222580D7;
	Tue,  4 Nov 2025 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHnfAYh9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E652C0F8E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289515; cv=none; b=mG4FHGvIgyq/XcpadYCkPPU5yYa+DH7x4ebg+Lra4d+YhILLWsY88spVs038ErWLXbU88AW6Kqg8ZdIZbdCqv83s6FxVrYSMK6Yvycv/mLp+m+W/lJgwyZV0F8cf1BzV1M31YInKNAdUI1fhgTqkn6ZEFxl8++z3V08M5bovFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289515; c=relaxed/simple;
	bh=PZI/zzg1c+c0mQJrvYPWkhrfW3rQsw3025WRnGSx0+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6alSos6Z73njs4Ahi5VCTOf5vxQbTWXPTL6wR/6meKEjBdoRWpCOamQYXaggbX/Be5MaVK28ph2hzQY83aeJxLZgz5V/XGqiSy+yWeYmje3dg5dAm/oGVWMqY2mHJPR2jmYOD2TxpHaIVkvUW65iFQVGVcRHteihZ6RKRiSAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHnfAYh9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso3544073b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 12:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762289513; x=1762894313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTyzfLx8TEsl2eL9XuoecrFhDUeutW7qJTpjGosWpIc=;
        b=lHnfAYh9m31k+42N6D1SE/SIjInS8RA2YQgyLYBufxdCKrREFHm+Ux8L9KMtb6k3Wt
         0K4a3CAHI3bP1gL/TRPQK3KGKPfgjUeeKA50wKzanMNb4UqcNOnOK7Vps802Ju7TFcPa
         m/SsfP65A9v74rHoNMCEkIaHK3rhzqERCQ+zm8fsE1szc3no5WzwErf2G6KSBNXebSC7
         RXH/L5yzV5wyxKGYVyMNfd5e6tFcd3ZrRjbab8PWVjXIAywlfCCKe+lnlT6xLFm6/GVH
         Vh9Y1GOjto0iO2ZGWQaTEj/FvPwSjZYME2vDMJSlz6CRzX4oOB6vO4twfpma88hWzH+N
         sb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762289513; x=1762894313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTyzfLx8TEsl2eL9XuoecrFhDUeutW7qJTpjGosWpIc=;
        b=Jrfsq/7k9O7o1MMPHtpN117Qk3SzDU/kbOeBT05lgJyl1lLd0spBDN3NQR0NTChHE7
         e3WdzcMhQGKyIBocr/GDZqS3Ee2hBS0RyBYPqZYaLn48pKzHZ+byRnBjqZwDC4qPhRTg
         aMEPhn/kf7HCldOgJqeo6hZvgnxkxLX25zod6RWLX8MT0Aw71sZAl7D8etJqNFMo+WFb
         0ENxOk/a+Z9w5+kIUsFMEgK3NwvWykxHwyHaDmTOfezauARnJXDQR3vB1VCwjY1wKDE5
         G5qsg/s2YcObxn2s/0zFucDDup+VWfuWkxZF909qEJZxAbFCUPqSJiJfnV7cDCRBguDo
         U/mw==
X-Forwarded-Encrypted: i=1; AJvYcCVpDPnYi7r8KrFh/6jWo2ELRgbgGsIqBDPK1kpr4moGhEuYJIEi/VK5iUVnrH+9JOZSL6YueIU0gHq/Nd5a@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPHXTKtUoGnvJ7UpQbpCxcXSk9cT6L9/V2CxYHm6Ffmk7atn0
	PDdO1DQ5cyIGxT1pUtJi2vdzf1JgHU0hOQproQGIstb3DGIUMhArLr4C
X-Gm-Gg: ASbGncuWWIyu/aEw0tXm397ZdXnfgN2cafqn4xNcycVuE1B+cBiIovaDIQGAAc6GS5i
	d2R8gKWeCSLjrqGCS6QWYlTUYNuq76HCWT/2WYjwtzS3oind0/7zojRGDCxa61GFNbcXP0AG9Yj
	g2+NoixTFTbUQ07qoXlweF92vxDGGgl2u2KNKb5oXrno6hU7qwlKETrgiPp3Ti/iPhj2gEXWRSt
	vnCqCJ+9MPw9AykG0r2dRKSEDRs1ZI4Mbh61g4C9d1EEOXIozBN0HDvst9b3yj951vLjihTszf0
	CyE8TWS9iNsvzuVNfIasG5qEV8lmog1UEhAG+hBIxr1egqZHGQsV8kUcwgad3bfnRtwQQwgifgS
	qUy5ku3IFXjl+zT2lx3JgSpiAYRSoTiCJqla90fWJimvoTEZWECVGYG1e4n3EsWFj61wFQTJJbB
	xX/k/CfkEgoFU1CQwpFlGjBcmL1GU=
X-Google-Smtp-Source: AGHT+IHKu1xdeThvBGfOjpr6TWOyuMFcSdqHcRWFiD9pIDM8LTgNsQI1RXsbT4gr1wSWZI1s+iAowA==
X-Received: by 2002:a05:6a00:99a:b0:7a2:7f1e:f2dd with SMTP id d2e1a72fcca58-7ae1d7353e9mr713658b3a.11.1762289512806;
        Tue, 04 Nov 2025 12:51:52 -0800 (PST)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3246e7bsm3990983b3a.8.2025.11.04.12.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 12:51:52 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 7/8] iomap: use find_next_bit() for dirty bitmap scanning
Date: Tue,  4 Nov 2025 12:51:18 -0800
Message-ID: <20251104205119.1600045-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104205119.1600045-1-joannelkoong@gmail.com>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
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
---
 fs/iomap/buffered-io.c | 61 ++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 420fe2865927..3c9a4b773186 100644
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
@@ -1161,7 +1181,7 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
 		struct folio *folio, loff_t start_byte, loff_t end_byte,
 		struct iomap *iomap, iomap_punch_t punch)
 {
-	unsigned int first_blk, last_blk, i;
+	unsigned int first_blk, last_blk;
 	loff_t last_byte;
 	u8 blkbits = inode->i_blkbits;
 	struct iomap_folio_state *ifs;
@@ -1180,10 +1200,11 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
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


