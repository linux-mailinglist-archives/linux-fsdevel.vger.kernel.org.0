Return-Path: <linux-fsdevel+bounces-57496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 925C0B222D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 11:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1692B623E86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B622E9EB4;
	Tue, 12 Aug 2025 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+SzDVgS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097E2E54C4;
	Tue, 12 Aug 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990163; cv=none; b=rty7R2IDtGGzAAD4YiDlFhtGqfURmGpobmxxzJTE6UR3H8bl7aNd5ed9sXOnrnmsWvAEXuIHv+/VRfC+OiFvcdIJqAlXFNxG8hceLJ5y6ZXaJ+h9SbazzKtpIJi7IAptDMPIlhsH/mgLDDH96Ec3APNRKD1UQffBb3wInPedOVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990163; c=relaxed/simple;
	bh=ELWvW+M2jADaIZWOkli/FMGFEI1EmtXEE0T6HI5+TdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTwrYsu0snWmTiJXF9ulCMDy8CWr0ALzMQIdim+AWPGKrmcVOBM0JRR1pPSx98VdNzll49jN1tjXaiR0TNLjLPKBno/1MMkHaVuDhGrCrg+HubA6BEHFyRdfPzUEs66I4NxoKPEmoDceXmPsJ37i4anvA2KcPtyKULGalHNbSP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+SzDVgS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2403ceef461so44066195ad.3;
        Tue, 12 Aug 2025 02:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754990161; x=1755594961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETsvnaYYTYssQSdiqD1pneEVq8m5ZOm8thK8WL38Gi8=;
        b=Y+SzDVgSonJRg8Pur3nQMAv1y9pltRLTUeUp93UT+wqmBhO8AHUiDY/aqAng4dZJau
         9KJZyFDfJ/g7XuMal8/RzkMhmvDe8Z2ONKvochzrTLW9kW6fvkFkP41KXnC/solT7hu1
         mWn0AXTN9DUDNW1w5+yXPEQw0iWWI/bzzO5JiX2KmnZfd9WQeeyeU7vuyvg4dB93wQaH
         1KHv4JyFUOF3zckfeEl9oTJLFP4H5UaRqvkeZzd+zBCJSfd2ivFTLZ1jNSOFRhCm5+Za
         l6K+RNBjsQZJVc5PQdYrJcc6OME2d6MmVtJECmkBaSiJtUlpho4n8aah39NANY+Buid3
         i7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990161; x=1755594961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETsvnaYYTYssQSdiqD1pneEVq8m5ZOm8thK8WL38Gi8=;
        b=MC0r073XP9CwfEGbAHsCRcvJRvGOxM8RDniimMELzLCrPFIq1g20XKeX1Q0y4iXzyv
         P8HbG5iKgI2s+1vqgWGJWYTfotk0SZkquiqvTYXW7+qcWkJjsNiWEhiiRqZ3DbffJD8O
         fY2pe/Koysp19lkntXLF3K3WkFtV7Y6bongZdpqBppEnD/hlEW2IHECN1BYCx45kc1zT
         6PQdYeFkXRkhUAGWH5NMN7DGPbFamzAVTrV/3nOj7OIPsc+Gk749r4g7hBA4YjvlafXy
         WS5X9EejIuP1E+0OcT77ymp40NRh4DNSbR0S0fUt5CWSmPzU287LOP7Ukte7JPWnxIXv
         QIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW89OpX5vfwLjz9AZOfRCNHk3PQ51nOAP2MsOCsmK3fvaiW4KHPth0EbU25C/uTcek7pFHw9sd46WwD2EtK@vger.kernel.org, AJvYcCWbtR0kmGsapxLEXvPZiCV8BEWBwvbku3a0Kot4wEhtdB3qXy6HBMYgWfgagxJQ/rGmCo+ODUlJMeInlhmP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj3a+Qoen5OMAS5fg1ssJDOmsAiOYmcltjaXm2cSftDXDCRWEw
	TY9G1f04XSFxSdag7ZKu/ePazEZaTnyo5jPOu+t/0ux5mcaZczkwbzmTjU7VavyM
X-Gm-Gg: ASbGnctGNwef71NFwQQhuNwfFZSAVgTUH4XeCWcoP3ZS4gF8ILUT1/rpDJJM90egdi3
	bEhlGDJ4TBZ0z0IuS4KyLMv+o0NMgnMmYaKAoknysz+tfLcN6tALXxfPgEUOxxClgtpXQGrEFh9
	NTyc/h0ajXwAn464LoB6Qi7/4q/9G95heaVtVIQidbEU3Qjh7drSdjYdlGbrjyaKrjLK+NENxi2
	EGPa2URRj5PvrZ+4X0hx0Eq3/lyV813CF8wNGDS4jgMWSVpqJnecZeOE5y8y2lO9FA0oeH9cf3k
	NoVyCXjuIuuvRuloMTdlnxYEsGCTQUY+I2HRQ9kl17asm21Phhi+UlZygYNEQOKmOEvUi1foWj5
	Hu+HH1ia6Zu1shabUHWccz7sqqC8tlFugMoJvt1vKeU3rVw==
X-Google-Smtp-Source: AGHT+IHPnPWiYSaXaV0zUa1cKXWI5MwMCHYaCm7ZlRbK6uLcbEU1rYhEf47LkLOcZUOOYIGCc4NPpg==
X-Received: by 2002:a17:902:ec8b:b0:224:23be:c569 with SMTP id d9443c01a7336-242c201115amr257867705ad.22.1754990160846;
        Tue, 12 Aug 2025 02:16:00 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1efe8sm291670665ad.69.2025.08.12.02.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:16:00 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v3 4/4] iomap: don't abandon the whole copy when we have iomap_folio_state
Date: Tue, 12 Aug 2025 17:15:38 +0800
Message-ID: <20250812091538.2004295-5-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812091538.2004295-1-alexjlzheng@tencent.com>
References: <20250812091538.2004295-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

With iomap_folio_state, we can identify uptodate states at the block
level, and a read_folio reading can correctly handle partially
uptodate folios.

Therefore, when a partial write occurs, accept the block-aligned
partial write instead of rejecting the entire write.

For example, suppose a folio is 2MB, blocksize is 4kB, and the copied
bytes are 2MB-3kB.

Without this patchset, we'd need to recopy from the beginning of the
folio in the next iteration, which means 2MB-3kB of bytes is copy
duplicately.

 |<-------------------- 2MB -------------------->|
 +-------+-------+-------+-------+-------+-------+
 | block |  ...  | block | block |  ...  | block | folio
 +-------+-------+-------+-------+-------+-------+
 |<-4kB->|

 |<--------------- copied 2MB-3kB --------->|       first time copied
 |<-------- 1MB -------->|                          next time we need copy (chunk /= 2)
                         |<-------- 1MB -------->|  next next time we need copy.

 |<------ 2MB-3kB bytes duplicate copy ---->|

With this patchset, we can accept 2MB-4kB of bytes, which is block-aligned.
This means we only need to process the remaining 4kB in the next iteration,
which means there's only 1kB we need to copy duplicately.

 |<-------------------- 2MB -------------------->|
 +-------+-------+-------+-------+-------+-------+
 | block |  ...  | block | block |  ...  | block | folio
 +-------+-------+-------+-------+-------+-------+
 |<-4kB->|

 |<--------------- copied 2MB-3kB --------->|       first time copied
                                         |<-4kB->|  next time we need copy

                                         |<>|
                              only 1kB bytes duplicate copy

Although partial writes are inherently a relatively unusual situation and do
not account for a large proportion of performance testing, the optimization
here still makes sense in large-scale data centers.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7b9193f8243a..743e369b64d4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -873,6 +873,25 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	return status;
 }
 
+static int iomap_trim_tail_partial(struct inode *inode, loff_t pos,
+		size_t copied, struct folio *folio)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	unsigned block_size, last_blk, last_blk_bytes;
+
+	if (!ifs || !copied)
+		return 0;
+
+	block_size = 1 << inode->i_blkbits;
+	last_blk = offset_in_folio(folio, pos + copied - 1) >> inode->i_blkbits;
+	last_blk_bytes = (pos + copied) & (block_size - 1);
+
+	if (!ifs_block_is_uptodate(ifs, last_blk))
+		copied -= min(copied, last_blk_bytes);
+
+	return copied;
+}
+
 static int __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
@@ -886,12 +905,15 @@ static int __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 * read_folio might come in and destroy our partial write.
 	 *
 	 * Do the simplest thing and just treat any short write to a
-	 * non-uptodate page as a zero-length write, and force the caller to
-	 * redo the whole thing.
+	 * non-uptodate block as a zero-length write, and force the caller to
+	 * redo the things begin from the block.
 	 */
-	if (unlikely(copied < len && !folio_test_uptodate(folio)))
-		return 0;
-	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
+	if (unlikely(copied < len && !folio_test_uptodate(folio))) {
+		copied = iomap_trim_tail_partial(inode, pos, copied, folio);
+		if (!copied)
+			return 0;
+	}
+	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), copied);
 	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
-- 
2.49.0


