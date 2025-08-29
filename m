Return-Path: <linux-fsdevel+bounces-59678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E2DB3C5B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD4C7C1DFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923E1340D8A;
	Fri, 29 Aug 2025 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUl8bMdg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062C2609D9
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510807; cv=none; b=FfuJSYMLCOpfijvtZT3tKjR1WkKXS2g7WGvSyCP6pKFy3+nfxihAARRVnXF9KiEHhxwqHZFjYYe7N6Dq93ouS6fjB07UHu5dn56OanqlNMdvxxvLcTCEkx50av8PghRAbNKJk+22vZxHf43Yo+ur5Cn+6+0mHmVsyy8wH5UqsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510807; c=relaxed/simple;
	bh=VL65NiBgyLsUAGZJz2Y9G+QHDVgWrIhAqYbN4uzZx2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2m17SrfNRJOQT6z84ujtkpYX2hSspgztsqeFlLO4r6siEu21fz1RO6dX5TN78IeVcIFcPUqRXvwbG9eugGlPkIQIM6kBDGsKp+V4oPD5uzeG6qSsQ12oL2dBEoqgC8Y3ar6k08JZOl3IrVfBm3pQpKulxsAEKJU/DxlArTeIjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUl8bMdg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2465cb0e81bso21327395ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510805; x=1757115605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfQECAMLyifBaWnZBOh3XwN8oA8V3Gk1yo9qRqEQKOs=;
        b=XUl8bMdgpNKTiLoczDjzgtdQ9Gz+Y4YkaSyQvGgSNtz1jEk2Yzo4/3TcKcXUCTutWR
         /W4eEMfItw2bur9UgtpuYO47UJzM0cK4vC60fKlaxsH0LEctFYQ+7fvR/6hgB8+n6TmN
         iSycUNLt1eVyLPuDcmdj56RDg2CrcUA7WAQBF3wcNW/oUQGYd6qkUVGeiYwb9iUlWYKK
         K0NH6p0OO+sjCPBXt+yYODRwdY4aHYXKkAIxx6+OFklsvr/MKEbUL8a5vKuunsvjsB4U
         7bkOQXOF/nXqvkBuJgurTXcnY7p6AGwlyrTRXflfeayt8Zst3cU+obTN6N4WT3l/ZJzr
         hbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510805; x=1757115605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfQECAMLyifBaWnZBOh3XwN8oA8V3Gk1yo9qRqEQKOs=;
        b=FPzLA9P4PYdS0iHIOuxiVYMC8JeetN93lmF0uu+ITq+XTT0FWGFZXzYlS+TRz/NYNH
         8yTrMgZC/H01robs+3LQCvLmpKlwKCEPcxG7gXWWaezpd0tsyLQsNSzwmz9fIjQcd8AX
         P9Lx5hTPXRCDmSDktvO0Z6gfM2t95avDG5adwA2k5iJaf+dG+LJ5KJfVe8oLKL+Cp75/
         K/r592d/lLpwNxhH2VEpLNTZYGWVVSZUGalTo5x9FrmuBCVI5rpPnP+cE48IzeF8pqRi
         CTG/Y52Z7sp3QZS8cXzE5GzLhLA8G8++hgoyMsJtbltcypGD9/zYotf3TUB1SnCBQWVg
         mb5A==
X-Forwarded-Encrypted: i=1; AJvYcCXz4JFYuZokyRe30zky8/k5RZ4sfKTiNT33bkaH6lW5lbFUxUyoCUPstwxN+2U1VC/eupmLM61Lc1F2xXXK@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzm+aJh+uJv1ycwRxebYIknGWZIiQRoArA5QK5SN5C9CDzPL8m
	uIL03fMnWulgd2EbbBfipHbaYXYHrcXFlTpH1c/VRZm2+V6SkoP2gbkR
X-Gm-Gg: ASbGncuBKkMGh5GLq9CUe26w9GADK5I4Lo2ZZPKJBtsZzW5UFDODQbZaseoG3HQH2vp
	IyAh5lqvb/015nSl278bo1/8zsAkTF0mfUGw3NGkIxsLJ39sXx1+Qbs0T2PusD3gKOHQUBTLRIN
	TOP9atNmK12hREAbIdR47kyR75tffHPj0rfPJjKi/5EI3fkC1kR2LAhOjXRvjHH183kTiDP1ktd
	+rON/SRauGxHLhElEXR6JRPmWm2zuAwFf4aopkAL7Ok0RSVZ7MDGy1PC04OVavWL9Y5/S40IF4i
	cXu6I5mjYfEoO9FowlBAK46siiSFkLWq7kec98SYDPb/CH2HQwKeZ+VnQXCu5y99JmxT2JYPNzo
	AjkW7UYuf72VxcEz1
X-Google-Smtp-Source: AGHT+IEc9ZHU+gnzs268+QcgurHyfBD8OsMkb5igTSS/wc4rJ1iP9uFrL7dvxIfpXo4L4ntKoVG79w==
X-Received: by 2002:a17:903:1d2:b0:234:a139:11fb with SMTP id d9443c01a7336-24944a0e8f3mr5573865ad.27.1756510804856;
        Fri, 29 Aug 2025 16:40:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490658999fsm34959625ad.112.2025.08.29.16.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:40:04 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 10/12] iomap: refactor dirty bitmap iteration
Date: Fri, 29 Aug 2025 16:39:40 -0700
Message-ID: <20250829233942.3607248-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829233942.3607248-1-joannelkoong@gmail.com>
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use find_next_bit()/find_next_zero_bit() for iomap dirty bitmap
iteration. This uses __ffs() internally and is more efficient for
finding the next dirty or clean bit than manually iterating through the
bitmap range testing every bit.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
---
 fs/iomap/buffered-io.c | 67 ++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..dc1a1f371412 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -75,13 +75,42 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 		folio_mark_uptodate(folio);
 }
 
-static inline bool ifs_block_is_dirty(struct folio *folio,
-		struct iomap_folio_state *ifs, int block)
+/**
+ * ifs_next_dirty_block - find the next dirty block in the folio
+ * @folio: The folio
+ * @start_blk: Block number to begin searching at
+ * @end_blk: Last block number (inclusive) to search
+ *
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
+		blks + start_blk) - blks;
+}
+
+/**
+ * ifs_next_clean_block - find the next clean block in the folio
+ * @folio: The folio
+ * @start_blk: Block number to begin searching at
+ * @end_blk: Last block number (inclusive) to search
+ *
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
+		blks + start_blk) - blks;
 }
 
 static unsigned ifs_find_dirty_range(struct folio *folio,
@@ -92,18 +121,15 @@ static unsigned ifs_find_dirty_range(struct folio *folio,
 		offset_in_folio(folio, *range_start) >> inode->i_blkbits;
 	unsigned end_blk = min_not_zero(
 		offset_in_folio(folio, range_end) >> inode->i_blkbits,
-		i_blocks_per_folio(inode, folio));
-	unsigned nblks = 1;
+		i_blocks_per_folio(inode, folio)) - 1;
+	unsigned nblks;
 
-	while (!ifs_block_is_dirty(folio, ifs, start_blk))
-		if (++start_blk == end_blk)
-			return 0;
+	start_blk = ifs_next_dirty_block(folio, start_blk, end_blk);
+	if (start_blk > end_blk)
+		return 0;
 
-	while (start_blk + nblks < end_blk) {
-		if (!ifs_block_is_dirty(folio, ifs, start_blk + nblks))
-			break;
-		nblks++;
-	}
+	nblks = ifs_next_clean_block(folio, start_blk + 1, end_blk)
+		- start_blk;
 
 	*range_start = folio_pos(folio) + (start_blk << inode->i_blkbits);
 	return nblks << inode->i_blkbits;
@@ -1077,7 +1103,7 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
 		struct folio *folio, loff_t start_byte, loff_t end_byte,
 		struct iomap *iomap, iomap_punch_t punch)
 {
-	unsigned int first_blk, last_blk, i;
+	unsigned int first_blk, last_blk;
 	loff_t last_byte;
 	u8 blkbits = inode->i_blkbits;
 	struct iomap_folio_state *ifs;
@@ -1096,10 +1122,13 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
 			folio_pos(folio) + folio_size(folio) - 1);
 	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
 	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
-	for (i = first_blk; i <= last_blk; i++) {
-		if (!ifs_block_is_dirty(folio, ifs, i))
-			punch(inode, folio_pos(folio) + (i << blkbits),
-				    1 << blkbits, iomap);
+	while (first_blk <= last_blk) {
+		first_blk = ifs_next_clean_block(folio, first_blk, last_blk);
+		if (first_blk > last_blk)
+			break;
+		punch(inode, folio_pos(folio) + (first_blk << blkbits),
+			1 << blkbits, iomap);
+		first_blk++;
 	}
 }
 
-- 
2.47.3


