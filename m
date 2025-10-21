Return-Path: <linux-fsdevel+bounces-64977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85909BF7C38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4C355024CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9A6347765;
	Tue, 21 Oct 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b039sXKj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6603473FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065121; cv=none; b=YVsJu/EPETHxyf3KgNCuU4gbfWSRoL9HtO/CMoDqLmzRx/464+uQm7S3pMj7eFUsFdnI3VJmrI+o2PESxMA76TDHh3LVIjWrK2X2refoKACq2UQQ9pXorZ78wdvtcsJJWe2z6tAHpay3qjf4+3fcPgDzWQzlCGg28xY5VTjBpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065121; c=relaxed/simple;
	bh=4LYCymae02S+Y5J5+r+eSpq0kTxJYnrRJIyFhngEMd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsMnJRGgxEfwVcze150HaINIvbyl41EeDdMfems7wbWblVIZOsZCX/6QKovpOEnl9MFQfRSsa7S2oLE0Ax2q+hPhhPHbOILSKu9UDDRd0xjGkuS+LF9SbmkguUzfRjhXr5g+EI0C5GoiGWsstkFUERzWvCU/NL9eDtfT99dC9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b039sXKj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-26e68904f0eso57551345ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065119; x=1761669919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jm46iD0ply32Zewtt5ifhNeF9evXZWGPjc9eNGj66jk=;
        b=b039sXKjlI91xSwUukRzpSN3DI4nLfu+hQnJWiLZ5ASbj/spDjs330GdtLaa5IWbDd
         vYIX7hRYnt6a9N2glcKbdTim8lpEcJxncXqaskVOGd/me3WoCfuXmWCQY/U0Mzt0jDx7
         PnjSpUt6IYIyWdAhFYs3IizvuwAskQFf1s1mpMdB+G86pUmMA3pvOfjV10dLe0/vZo5G
         llWplXYSMfXAAg1iARBJypB+GbZFpZVPazciBWqUmu1sl16nNfWzUegKFmblw2V0iGPx
         9M/XZUbiCteGamxgvaVkvQPZhas8xyl8UutGtik4Vd6Lvq9x0oqxthAtOFBpHFbtUZRu
         pFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065119; x=1761669919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm46iD0ply32Zewtt5ifhNeF9evXZWGPjc9eNGj66jk=;
        b=CpaAooolCiJVMWRrELxtkDv1cdPbGFI9wGm5DW2ewP7B2EXf1GxT4irBKEtWsn/K7W
         GDwLfxwZ5vzyRFmXDQQuxxNGqhsVpqbfBLtWwLYiLHJkfUZRazp53RnWXgQHm2gaxzba
         hCFM1APMV0KN4onr3ZxI0fjhBA7bI7804ClyWXGDe1x+pfm2+isckwjtlAzs/MPl1RQf
         tNIPvwU493isiHxcYKCZwrzVbhK89+IttfQDUamG+jt01s9esxjOMJbcfbntIkpq0bq2
         mzTBRONn9Bcjapgycozvzb8+glW+RgdZmCBHJ6mwXLumTi3m2rk9v5J1ZoJPv3hrrpS7
         gAPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcgsS3qTRrTl2FpdJg1JOO0Q3QT/mjYnigLeMcqMuGPkCjQE1OijgLYT+SEY53hxHQ+mrqUv45XX9QkLPk@vger.kernel.org
X-Gm-Message-State: AOJu0YzLuRRA+LjiA2wpGxidenjda/4gWUoHncT+dSs6qjUedEcoBS/6
	K107nJNP4F8Q59l9UEpeQ1LXJ1aGlg+Dj7OkLru/KSTwpxtyApL9Sm0m
X-Gm-Gg: ASbGncs2QGRDoc3VLgylAD56NifbNIbvrEx58uUJRtkHIOl0Dgyb/S8YmRSi6zsz9y+
	JFiaSBbvVB3oPUVzEtBz8TV3CpuhWgzU7ejS1lk1gD7eQhj0PfJdqvdW17M8qnALLt/s9XbAsCu
	HP7A+vLD/L0+AUdkUpQDqOwfwwaIoTGb7NoYdWU9QFLSbqPjBfB7syxia0lU4UeQjO6mXoYLDpC
	YeJza4ZmD9I+8Zl6dz5m+84BN9+lewrSoBUZALqlEOUvwl3Z5RE+Mvx4GJXynrvZd/aJhkL1pss
	0bF8ydQHfXTiXBXu42Efrt0EdAtHrHe9fDBSE/j1DOjYIhf+u88IFn96NsR5Rckl4n1tEBaTVxo
	1WTXGm4SqQXlzwT38fiIK/RPGyG3PTspYJVok5zgoqkyZCPwRmoQO6x/pJ7UXA6vjteqhkx9taE
	JbrRdrpSSYVEEoTXeTYHVfXDALvq7rvM00cF1ztQ==
X-Google-Smtp-Source: AGHT+IHYNI5Ils+Rs1YW+r0IvhnUx+n5sVu3aF1v3fxSqXfrzlNpB6qg0wJd7zY88zJ0+5T4w2fEmQ==
X-Received: by 2002:a17:902:d484:b0:290:a8fe:24e5 with SMTP id d9443c01a7336-290cb65c662mr236884265ad.55.1761065119149;
        Tue, 21 Oct 2025 09:45:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcce8sm114535385ad.18.2025.10.21.09.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:45:18 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 7/8] iomap: use find_next_bit() for dirty bitmap scanning
Date: Tue, 21 Oct 2025 09:43:51 -0700
Message-ID: <20251021164353.3854086-8-joannelkoong@gmail.com>
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
index a8baf62fef30..156ec619b1e5 100644
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
@@ -1122,7 +1142,7 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
 		struct folio *folio, loff_t start_byte, loff_t end_byte,
 		struct iomap *iomap, iomap_punch_t punch)
 {
-	unsigned int first_blk, last_blk, i;
+	unsigned int first_blk, last_blk;
 	loff_t last_byte;
 	u8 blkbits = inode->i_blkbits;
 	struct iomap_folio_state *ifs;
@@ -1141,10 +1161,11 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
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


