Return-Path: <linux-fsdevel+bounces-63694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E958BCB27A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 00:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD8219E7DA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 22:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61FD286D7D;
	Thu,  9 Oct 2025 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx3heo1+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6D28726F
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050669; cv=none; b=eolC8G+dGWfTuuSh+eSVAvAHOYUgQCuWolXsaVLfkqQ9YPjrKXXdvH4aLTgAKp35IZxxub1rQ4CrOGImDxtStCYxH/ARoLDsfFp3pN10PY8sPMQ9g5wpEjGALAxmXmWA4uKbWgCbsQKNL1QJu+0td9whyAmPV5hLNXQHOtb+ZZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050669; c=relaxed/simple;
	bh=JaFvCpxJt7H698xSWoXCZVEBV03S81oZLDdZxi6thhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fORb0tdLXnOIYUFxh8w+BFh8oK6w4wMCWSAXWhXdN7tCCtkCtFIQR/7AvZFLvaX7KF30sDSXrhYXTl7hXwpPhLJIlVQc1H6mhkvaiUAyLYOjHpGaZlD1LkZpcfE6r7thHYbe4Dg0oEa7V1a7XvVSAA81GleTRktpyyyfEBRSt4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cx3heo1+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso1475942b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 15:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760050667; x=1760655467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+mFPrP6JU0Ki+CeJVAHJiJ12z0FVj6CtZixcmlczTE=;
        b=Cx3heo1+VOE1mjW9lNFM6mC5DAdW4yJuZJyjvFmvEPvJYQ2jhtUXTET13L/3o1Xz0D
         jLp4KpAHK8QVUgV2OMf40cF5ZE8UFYDa1ok9Fxm3OO/HbxRIGG4uOVf0J8E4bjlvG6Sa
         yBJ9dXmrNTXsM1O+addQvaL7JxYVEA/Tln+EKGZRk01zQET2R+umwn2I1UJ48IM3rCZ7
         wVWnJEcjACxy1YEBfLBqIEqphjjpcACoqbdtgpSH6v98wSkrrl26YfZxJLjrPQf+nwVX
         dvSEZGtHvg26qSbU6955FFO3prIu5IYOggW4g+mVwxoDFyHo46Gev/4ENMqb+2VBYtnE
         AcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050667; x=1760655467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+mFPrP6JU0Ki+CeJVAHJiJ12z0FVj6CtZixcmlczTE=;
        b=FWm2XXrnE64V1b2BcQzDvyht661i+XCD47r3+ItLP9aM6hfycsfBlYY/x6wl4dZv3z
         WyRHM96ij7+xaCbIV/DK7bPWfa5W5GIwjF0n5WjXLDi9aJKk4d2POHZ0RyGXUaSMrMlT
         JCbkaw2SoHNJov9So7XYSSq5Qdyit2Mqz2a8WNl5W1msqdyN51jr7AT/OWKlOSlH1I/r
         tekGmOEljnWs4uq4yDYCo3cTtCpmQo2Y7dnHxL+ngNpb+0WOJBxVzeoLjjTp/8AAfbWR
         SVnDXi3JWOgPFTNVriWuTDhzvHhsNjOze4ZOWe/4xbom54N4HOJwmVrjGuO+RKjAy11Y
         kaSg==
X-Forwarded-Encrypted: i=1; AJvYcCV8uSCTlHAiUgBHMzMMl12LdPKG3sigDiMBLIYacUj4UVvPQ1+tCJt8Li5P5z7e1UyfUW9yjjyn2ntNzp9O@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0tZ1VNEVVYY+UB3m0vYl1sXUWk7gVNTgxAN7c/kiSDgVLV2Tw
	PvESkuMGrwkop0nnmqP2obz94gmg8ScZfAqDkap49lQvowwOkAvYRtQOFsVuyg==
X-Gm-Gg: ASbGncu66vMB/jwnbm4vhWp3KnwtIoWbva/d5e2RrgJl3RdDQpmh4FXBYJsUwzbIoxR
	q6RCw5h2HunZpcugEch2iz6APZcb7mQYAweBDwS5MzqnHpvX0gim0gR2tNKVUeg/igMZp/I7A1e
	CnkIR0Owx0RkMI88IcNTROiOChntgzd0YJqcXc5IBh84D0Vns4iDuGGbRR0lNcuw5e0O2q85JZS
	B77qzmm6lKx4HLSP7VjQEK16EVo0gzBv6uiWypzlK3gkSMEMZoMGb7Ai66r95NLbpsIxuH09q/v
	mvEHOd+/bVzkogM1gA5/O55vxhi5XFFaLODww6rF0idaw+ecvz8QwZg/MTIZOtSyU9DY1N8wwla
	PkrypnP1uMCNOqTfGf6Z0TffxlkgapHFswrA8Y58D6WEtPLfaLKtCFiZPcDriDpRN/YlSNPljWw
	==
X-Google-Smtp-Source: AGHT+IFUHjZGH+SjHRh7TXg0yNcqvVp2cSs+oghKJArgrBCNgJPpe+mYTpo/Ik7hD0MiUsxybWB4uQ==
X-Received: by 2002:a05:6a20:3d86:b0:2ec:4146:6a0f with SMTP id adf61e73a8af0-32da83db568mr12601028637.35.1760050666799;
        Thu, 09 Oct 2025 15:57:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678de01aadsm660270a12.17.2025.10.09.15.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:57:46 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1 6/9] iomap: optimize reads for non-block-aligned writes
Date: Thu,  9 Oct 2025 15:56:08 -0700
Message-ID: <20251009225611.3744728-7-joannelkoong@gmail.com>
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

If a write is block-aligned (i.e., write offset and length are both
block-aligned), no reads should be necessary.

If the write starts or ends at a non-block-aligned offset, the write
should only need to read in at most two blocks, the starting block and
the ending block. Any intermediary blocks should be skipped since they
will be completely overwritten.

Currently for non-block-aligned writes, the entire range gets read in
including intermediary blocks.

Optimize the logic to read in only the necessary blocks.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0ad8c8a218f3..372e14f7ab57 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -686,6 +686,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 	loff_t block_size = i_blocksize(iter->inode);
 	loff_t block_start = round_down(pos, block_size);
 	loff_t block_end = round_up(pos + len, block_size);
+	unsigned int block_bits = iter->inode->i_blkbits;
 	unsigned int nr_blocks = i_blocks_per_folio(iter->inode, folio);
 	size_t from = offset_in_folio(folio, pos), to = from + len;
 	size_t poff, plen;
@@ -714,13 +715,37 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 		if (plen == 0)
 			break;
 
-		/*
-		 * If the read range will be entirely overwritten by the write,
-		 * we can skip having to zero/read it in.
-		 */
-		if (!(iter->flags & IOMAP_UNSHARE) &&
-		    (from <= poff && to >= poff + plen))
-			continue;
+		if (!(iter->flags & IOMAP_UNSHARE)) {
+			/*
+			 * If the read range will be entirely overwritten by the
+			 * write, we can skip having to zero/read it in.
+			 */
+			if (from <= poff && to >= poff + plen)
+				continue;
+
+			/*
+			 * If the write starts at a non-block-aligned offset
+			 * (from > poff), read only the first block. Any
+			 * intermediate blocks will be skipped in the next
+			 * iteration.
+			 *
+			 * Exception: skip this optimization if the write spans
+			 * only two blocks and ends at a non-block-aligned
+			 * offset.
+			 */
+			if (from > poff) {
+			       if ((plen >> block_bits) > 2 ||
+						to >= poff + plen)
+					plen = block_size;
+			} else if (to < poff + plen) {
+				/*
+				 * Else if the write ends at an offset into the
+				 * last block, read in just the last block.
+				 */
+				poff = poff + plen - block_size;
+				plen = block_size;
+			}
+		}
 
 		if (iomap_block_needs_zeroing(iter, block_start)) {
 			if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
-- 
2.47.3


