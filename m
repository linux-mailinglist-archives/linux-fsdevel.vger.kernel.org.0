Return-Path: <linux-fsdevel+bounces-59679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408E4B3C5B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5443BA00252
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A024342CA2;
	Fri, 29 Aug 2025 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwYc3cRz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960C313E23
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510808; cv=none; b=tFOgoIeWu0RisncfHLhmYTsgb+d+NMasJ3pv7X/K4qNOluWpienwbyHWt1jFIwKVZKtsg/mKsTkTGdaejwrOeq5RrCHLJYCd5EVC/eugf8noP8Nx1umJ1UwnkjuC6TKdHyR+A/uKYecd+12Qfdb7IHGH1+cCSpG1RuB1zj0cT1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510808; c=relaxed/simple;
	bh=QebTUPMK5hd7K/+uFIqA1nePnROHwcomnA0L5j7p8WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tz2D3JANuv/2/SsHa3oiRBQxlWVAJ6CBq1HOjg1B4fWOLsesVTK5NbNAWrChTV7hVwlrvwYlozSzcIn2pszlcgUtGEBt7vbHQpWZFajTGpmASm/hUcRA86yTbBai0BJRw63no1h79B9NtLJ1AkAvYg8kkbTkhgQ3TWjTs0WnPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwYc3cRz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-770530175b2so2089566b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510806; x=1757115606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+vnHoXREVrw0SidVRfvTvkEdr9pD8iMwbSpz5zwCXo=;
        b=iwYc3cRzK392M+nqBZTuX35ESopn6A/DYndiF97M6eWd+J7N3YAwGHxwpnDoD/KMHI
         ncibnbMzoK2zePfhvPmRIvH7Vvz2zihX7aknADH3BF6wBF9cMD5bEim1OCWozjGm/bBh
         pymK3EkALdtafRlXG5ne3Ot6d2iVR/xS51SX0RSBl8Uqz8X9q5JVtATWFNiR+Z+YPMP+
         eyQ/d+5Wb5EE8NkMfJSRDygUaet3FqYt8LODehCDXdC5ynZhyjko3jMv43jUeQNhhCSG
         oZQ+erzVSjzZsvsDxOT0JtyJM+xib03Nf2IbxqvVxAEQl1P63R7mvonkyr78aWKKsD5p
         8BQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510806; x=1757115606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+vnHoXREVrw0SidVRfvTvkEdr9pD8iMwbSpz5zwCXo=;
        b=GgA7rhx4/Pn4jaMNGQdNBHltpNKa4dhVtJ8hroQVZ3nJVL+0OyKou0nMzwkHUBDU3V
         9w3i4Wu35T4Lf3D36N/EubaK2my+Ps3oAwZndbbX3WSBschRhbfsILL0r51u8tlnGFOd
         OsyJNsgI8lfP3Fusp/pv+iJbT0Or9qSg40x9G/j/O9oNwChNeb1a0GYF6AxxStFxG7Sd
         BknJqSf9rmT9uMVEMPRcjWf7laXZEz8B70JQp6p7tGr/P0fW1O2jQUX9y4JvIrmC370n
         sBkScMgTRXkQcN6BG6cqnbrPwpn2atxxibeD4jQHTTIv0nWqmq6XxLqc5hcoo/wGdgXD
         +XXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8y3Kq0kqxOdpy13ZSeMmgTd6cKHfOEGNxlgP+x41Z60R2+fttub2nNA6iCqlaUJR0XvqSXQeSkrxMOn1a@vger.kernel.org
X-Gm-Message-State: AOJu0YxNH6vUm8SqqK8qQNfjWTmSTLJKBqhaBnKv9+kUoJSfF1yaSEh6
	TvdpYHB9ZH15IqSl3KGFZ+myHYCpumcL29cS4ZZ95/a8gs0tPL3V2I4w
X-Gm-Gg: ASbGncuNZuDIptOlT3Wmp8X3Fh41sj+L4SDYNehhPxK0WZ41gPRcDSPrR/tlOl5WrXm
	6y3amSwFiGUSTtDyRj2wSDx3BUCRnroKEDlqu6u6s3uSxnHHbG7B3qwc85I1nYt/lyltmiRCkCn
	qojMo8SMPLo3p1uYmTwA0Yr5zzHlKN7RF1PYNhEB5O7+oIKVZE+dRx3U9c25mu23puUG0KePSq9
	xBeCqqcP5c+xt3p/CrV30TAnunSsrgUzUHXIlWSgwLA0KyGpDZoV1utVt7EXk9/fUpaXTI4x1JI
	rR4qidUfpU205ZzpCUDO/r/g0Y0Wg6NX70xVhg/B+B1jxWq88cKi0hkVXHaDsiFjJu1J/Ccxbh4
	Oj5OImHAy7WNNxBtLxeZpNSyXG41a
X-Google-Smtp-Source: AGHT+IGUC8tYoEWl9cRnzhp1CoqWk60f7qfxgsYVEWKJABEj1hf6h+rHiKHA4Ucd3Clfcw8GiV+kfQ==
X-Received: by 2002:a05:6a20:2589:b0:243:a96a:2c83 with SMTP id adf61e73a8af0-243d6f8a2e3mr466476637.53.1756510806401;
        Fri, 29 Aug 2025 16:40:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcd48cesm9361902a91.19.2025.08.29.16.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:40:06 -0700 (PDT)
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
Subject: [PATCH v2 11/12] iomap: refactor uptodate bitmap iteration
Date: Fri, 29 Aug 2025 16:39:41 -0700
Message-ID: <20250829233942.3607248-12-joannelkoong@gmail.com>
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

Use find_next_bit()/find_next_zero_bit() for iomap uptodate bitmap
iteration. This uses __ffs() internally and is more efficient for
finding the next uptodate or non-uptodate bit than manually iterating
through the bitmap range testing every bit.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
---
 fs/iomap/buffered-io.c | 74 +++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 26 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dc1a1f371412..4f021dcaaffe 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -37,10 +37,36 @@ static inline bool ifs_is_fully_uptodate(struct folio *folio,
 	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
 }
 
-static inline bool ifs_block_is_uptodate(struct iomap_folio_state *ifs,
-		unsigned int block)
+/**
+ * ifs_next_uptodate_block - find the next uptodate block in the folio
+ * @folio: The folio
+ * @start_blk: Block number to begin searching at
+ * @end_blk: Last block number (inclusive) to search
+ *
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
+/**
+ * ifs_next_nonuptodate_block - find the next non-uptodate block in the folio
+ * @folio: The folio
+ * @start_blk: Block number to begin searching at
+ * @end_blk: Last block number (inclusive) to search
+ *
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
@@ -266,24 +292,23 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	 * to avoid reading in already uptodate ranges.
 	 */
 	if (ifs) {
-		unsigned int i;
-
-		/* move forward for each leading block marked uptodate */
-		for (i = first; i <= last; i++) {
-			if (!ifs_block_is_uptodate(ifs, i))
-				break;
-			*pos += block_size;
-			poff += block_size;
-			plen -= block_size;
-			first++;
-		}
-
-		/* truncate len if we find any trailing uptodate block(s) */
-		while (++i <= last) {
-			if (ifs_block_is_uptodate(ifs, i)) {
-				plen -= (last - i + 1) * block_size;
-				last = i - 1;
-				break;
+		unsigned next, bytes;
+
+		/* find the next non-uptodate block */
+		next = ifs_next_nonuptodate_block(folio, first, last);
+		bytes = (next - first) << block_bits;
+		*pos += bytes;
+		poff += bytes;
+		WARN_ON_ONCE(bytes > plen);
+		plen -= bytes;
+		first = next;
+
+		if (++next <= last) {
+			/* truncate len if we find any trailing uptodate block(s) */
+			next = ifs_next_uptodate_block(folio, next, last);
+			if (next <= last) {
+				plen -= (last - next + 1) << block_bits;
+				last = next - 1;
 			}
 		}
 	}
@@ -607,7 +632,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = folio->mapping->host;
-	unsigned first, last, i;
+	unsigned first, last;
 
 	if (!ifs)
 		return false;
@@ -619,10 +644,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
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


