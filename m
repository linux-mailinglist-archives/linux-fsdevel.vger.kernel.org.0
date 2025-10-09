Return-Path: <linux-fsdevel+bounces-63696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D14B3BCB280
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 00:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674AE3AE8B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 22:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664312874F9;
	Thu,  9 Oct 2025 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJxr1jIP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAEC28726F
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050671; cv=none; b=q9Zm+WahFv3sOjgDQUoEIqez68108elM7RErwXJ79ND6H+Z7reZOUV+xbx/JF5xYsMx+rzkpBkNt3/K4+YdTGcvRJTEWxHat6UxAaZKLse6Xe0/MAf8N76ty7CRRBRo/BNPIBBsMkLAutAPAgW+nSP9GUgAlo+muWAugm2wACAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050671; c=relaxed/simple;
	bh=zV9EcZWp7Z9DRJPSuBnxFs00p0L4puw2KZXd9cYWEuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvdfWAvtf9ZbhQZ0Z+0CcM9Nsva4bQxqmV7aSCoU08p1emBwISMfga7ErjDcRjF1N7oox5N0BxYYg8Q06ZOxO1pkTQN53HF4DGDBLeYLX+v+B9PmRfIrYuRTOoq88VwOmapjoedvITI8094a0oQSLCqgZ9Dfk5faRfTNZV0Um9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJxr1jIP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-279e2554b5fso12044705ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 15:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760050669; x=1760655469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+Wk5GKqbgjiqltcw+/xk/q5DMdbIMz3dRfJBR1Loqw=;
        b=LJxr1jIPqOMqC/0Y+iRQXrLVWi0P/9qjyx44VVQOh3hfH83/lR6lO5emjOFq1L1UFo
         2RYkV7FLwHoLk4MOG5Pbd3qGesBRL4KjCcEBqNwbWP5T2bR7gTFeB2tpKk2TrdoKFljh
         qFBiMKPip5TxuYT9pjTfrzmh7ogmAMjKlOVU4bib9NWcPkH063JOqImEpH2K/7oNGKXd
         dI9PMbZ3NktSiX3jDBlZa6m6EfZqGFeY7rwFmNw+odt0A92Elnv7DiHUJ9YtA2tTCfsW
         1fbLDCgDFd2IxkRVMu/fs/TRDyaYr1xg5U+MFFFMRZFzjUeo/8n0SjyLUkSxp5jJGqQX
         VoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050669; x=1760655469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+Wk5GKqbgjiqltcw+/xk/q5DMdbIMz3dRfJBR1Loqw=;
        b=LAM/truNTiOW9tyzE0GfMNBk7ShBRiW9bv7Rgf4Pxpm4oI0UM1Ye8lmtN8yIEUXbk9
         nkiEcK8ODgBpC7Op/6mQQqjDySdV6nPDcTnLk/yBMdBzuoy5gto4z7GYqWyqIMlh/7el
         uHb1gnvpr44sh3qYZ2FZxtAQwUfLJ/FVcDhcNW4KkIQw5Q9tzWSpVCRLmQy3wPBLPM6f
         ADOI7a5cmYlscskzUpziWlm9xqDuB5lMnC2BBR1rUh46+0oNcduknYAZaAImXZDA/AqI
         3TdtJqD96Hk7Rjw8SQ6EwIDasUTobIwHVnDGEu+msDwZQRP1O3w0EgNC2VxKqVwGuqmy
         OCkg==
X-Forwarded-Encrypted: i=1; AJvYcCV2GdbUMaeG77F8YJ5jwxbwDrEYAu8j9ro0W5yvMBCfc4JxZZyhbboo1JqdR1OECecGnE8IwEej4qKJZl6X@vger.kernel.org
X-Gm-Message-State: AOJu0YwlzDBqagOPNDqhIP27u5h9E+zDqB2SvDYaYdjf+NQoDGoqFCkg
	ymq2o9tq/V3vFdCauVX4aUZkNwYiirUK2EPnkXrPR1xTTYBDUaLVrtax
X-Gm-Gg: ASbGncsPHjY6Lt3L/D5KNshgSdBxM1yWfrrYKFwOwLfoywoaPy4eFw1DVZhJ+bSoX3G
	x8k8w8pUqXyR2dDJMrTyhBKy1rXBwGjNV2Xhqnrfmlo9fY7Z8OAjE5NmESNEUSI6XcnUZDsW1B+
	snjoSc4GKVMsnONHy8dIHuZL/twuD3zqlCQbi+nXxagJhVMVAUKfd+NUzsntLnOHYxVKGJkEmLW
	xXDtxLcG0EcKfyjK4bSJLig5NKFUV+/E37vd25vj4pGrInLMsYv5dTklFItS903d54n9Vbsh7rR
	Q8PdwKHQgimM/yIif2ffqm8vgInKzmjBjmhW3GYhse8qcaGVbW/5BPZeWC7DbOp+Wcqq6nnOCtb
	4BN8hvwf+Xu7s86lQNOcB6wvo99kZZJladoATYQF/55a4HG48RiZ8oXvzpdeSGotU/OjWKJJT2X
	tSpx6F47A=
X-Google-Smtp-Source: AGHT+IGHiwftZbnOe4lfAI1QQLVzLoGm+QWZCzlhs/zfKWyj5R75R6UUGiqZASdBpalfe6F+b4MpRQ==
X-Received: by 2002:a17:902:c947:b0:272:d27d:48de with SMTP id d9443c01a7336-29027f0ce63mr132981825ad.18.1760050669545;
        Thu, 09 Oct 2025 15:57:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de7871sm39202115ad.16.2025.10.09.15.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:57:49 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1 8/9] iomap: use find_next_bit() for dirty bitmap scanning
Date: Thu,  9 Oct 2025 15:56:10 -0700
Message-ID: <20251009225611.3744728-9-joannelkoong@gmail.com>
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

Use find_next_bit()/find_next_zero_bit() for iomap dirty bitmap
scanning. This uses __ffs() internally and is more efficient for
finding the next dirty or clean bit than manually iterating through the
bitmap range testing every bit.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
---
 fs/iomap/buffered-io.c | 73 ++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 66c47404787f..37d2b76ca230 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -76,15 +76,49 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 		folio_mark_uptodate(folio);
 }
 
-static inline bool ifs_block_is_dirty(struct folio *folio,
-		struct iomap_folio_state *ifs, int block)
+/**
+* ifs_next_dirty_block - find the next dirty block in the folio
+* @folio: The folio
+* @start_blk: Block number to begin searching at
+* @end_blk: Last block number (inclusive) to search
+*
+* If no dirty block is found, this will return end_blk + 1.
+*/
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
+/**
+* ifs_next_clean_block - find the next clean block in the folio
+* @folio: The folio
+* @start_blk: Block number to begin searching at
+* @end_blk: Last block number (inclusive) to search
+*
+* If no clean block is found, this will return end_blk + 1.
+*/
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
 
+#define for_each_clean_block(folio, blk, last_blk) \
+	for ((blk) = ifs_next_clean_block((folio), (blk), (last_blk)); \
+	     (blk) <= (last_blk); \
+	     (blk) = ifs_next_clean_block((folio), (blk) + 1, (last_blk)))
+
 static unsigned ifs_find_dirty_range(struct folio *folio,
 		struct iomap_folio_state *ifs, loff_t *range_start,
 		loff_t range_end)
@@ -94,18 +128,17 @@ static unsigned ifs_find_dirty_range(struct folio *folio,
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
-
-	while (start_blk + nblks < end_blk) {
-		if (!ifs_block_is_dirty(folio, ifs, start_blk + nblks))
-			break;
-		nblks++;
-	}
+	start_blk = ifs_next_dirty_block(folio, start_blk, end_blk);
+	if (start_blk > end_blk)
+		return 0;
+	else if (start_blk == end_blk)
+		nblks = 1;
+	else
+		nblks = ifs_next_clean_block(folio, start_blk + 1, end_blk)
+				- start_blk;
 
 	*range_start = folio_pos(folio) + (start_blk << inode->i_blkbits);
 	return nblks << inode->i_blkbits;
@@ -1102,7 +1135,7 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
 		struct folio *folio, loff_t start_byte, loff_t end_byte,
 		struct iomap *iomap, iomap_punch_t punch)
 {
-	unsigned int first_blk, last_blk, i;
+	unsigned int first_blk, last_blk;
 	loff_t last_byte;
 	u8 blkbits = inode->i_blkbits;
 	struct iomap_folio_state *ifs;
@@ -1121,11 +1154,9 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
 			folio_pos(folio) + folio_size(folio) - 1);
 	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
 	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
-	for (i = first_blk; i <= last_blk; i++) {
-		if (!ifs_block_is_dirty(folio, ifs, i))
-			punch(inode, folio_pos(folio) + (i << blkbits),
-				    1 << blkbits, iomap);
-	}
+	for_each_clean_block(folio, first_blk, last_blk)
+		punch(inode, folio_pos(folio) + (first_blk << blkbits),
+			    1 << blkbits, iomap);
 }
 
 static void iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
-- 
2.47.3


