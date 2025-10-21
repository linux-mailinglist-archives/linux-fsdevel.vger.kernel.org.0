Return-Path: <linux-fsdevel+bounces-64970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA4BBF7C3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04D8544C1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0BC344CF0;
	Tue, 21 Oct 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqnB1sTC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC4393DF2
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065112; cv=none; b=Kq9K7AGhkRLtY+lBhnLtSaGr21ksXxq+DfdZdZi//Glvl2WD1ttV98XR9QZWzU0/WMImb63J3kRmSZ11DKf2F35Ycja9XpshIlzpFD4CKzlsjYI0ixusMpfjwjs087d1RlYrr0VzvzPEb4cLLRhwjkcta1wK7HwhUF9ey2p3DYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065112; c=relaxed/simple;
	bh=qll0PaqAOuewoL6wPLco+HP6x5ZIaal/f0SCSDs50mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFpYL87uBjfKJVekDKPgi/7/WS5AAxixImR4mnFGJVQaHl6iha9T9xFcmSOuFV/pSUdgAg42H38O3KxOdhBoBy5lKDuzae2KbfmsufDhNmMECgztfCifHGZaGdxrbpHt+sAF4NMPQnWZdxQXdbqQdYx8ScSWNRV/mVRPRpK1AuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqnB1sTC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso5130681a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065110; x=1761669910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxOUv7xJCrseul+79ijuKLFLYyjjBg4kZ9kZDbAKHIs=;
        b=gqnB1sTCGHu1KrsU9cNIFYhwVq/bstAW147rK2+unNL2hKFAdz8QQBfuesSdjRXZjy
         Ah7UDLxQoXl/QTIeLO5p8eTLRbT0qZ9x+ig/bHEjVX9ZuwrQhNqGigxUvakf2fVWGRQW
         CTa+zviAxYu+TZ5jMJLqZ675HH6DlIT+4c6wTrW0rzOlW+uT1gLPjexPR2JNfRLFF0Ds
         uuKe+ZelT/gtdknCULInFiaTMRreZ7b+qJ5ELsXpBJpoABvkIbbcYKYEkNeklXSzlV4n
         O+zeWeVczoMeaYCDUBbqX+8+qiEm3QERrU9R3//EmYXRw+lqrM+mw7hHd2Z1GE40myZe
         x28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065110; x=1761669910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxOUv7xJCrseul+79ijuKLFLYyjjBg4kZ9kZDbAKHIs=;
        b=ugaI34lBc4hnXQFlMcksItZQZShn73hMXJ0gEn6mSPDjINoUEpt2A4fGaXhV2dckSq
         IWCwuxcG+ATOAVkfGysDE8ycAcjxN4/B2jQ45UcO2EK+GJOEq83bi+Wy2NDrSUmLouYq
         MYwZB5N2DSljL3TIeUHD0fRO7JgPXPiaHx4N9/G2J3RBtD3d+9HrDn7oL+db8oWM8A6J
         4skcpNIIWm65dUfhdvWpUd3zAUKx9irDtw/UJfg3+csXNuYrYOH4xnCZAncXKJcWm4zC
         gJ8H2qheEEdcnym7Z7zTImgtywLpxRc0LiAuVaCFx49nMOQw4ev6ys4SdB1vIVzRdwae
         5hcw==
X-Forwarded-Encrypted: i=1; AJvYcCUim9DRA/+dH1wku85OSj0ldu9609CEG5CLGbRE/jai5evklRMh1vTddc6t8T6R5WOiiYaiiGzozaG8h1ca@vger.kernel.org
X-Gm-Message-State: AOJu0YyY3ird+XdStyDH+5Gtiz9ZXkqG4EYtTxkeSY4edt/r8agunWR5
	17EBesX+FC9RMj23nmavsuyYXFjtnRxd9ziRhQdUVrHazrMrFReB9qvB
X-Gm-Gg: ASbGncvnTHpw2q57mAslyy2Y9Rdd/+KSb1mX6tmLsujV4UOGfdF58zSM+akfCehr5vY
	MXOmejGDC6r/MuO4qE1HNuYoLOj9AYJJnkJJ0sHQULbb9Cb1NrPwygvMPD64+3PBWcT1SDmPE2M
	ZxH+BBsC8bQJy5OW9Rwyc6e5ZE7gLm060nIHJ01Oq4b/ULDT2Qdu80t7qAwzDV0t0OuwPczbxlH
	C7uiCP7051AazTaHndBPEiyWN0UmuSeKxa+kNlmzKAjtqkIutT3YV9FcyUtkWcPSkOjtmI9iwn2
	gjuFcF6KXR7fl5FfnXucuzIbqUBlxgG8/ovSNADn/tHwrfIuDeiWYuKxKF5M2vvvSgUqlbhnmYZ
	HSgLqBeosmnyQkMPYRtjQ5ej+LXTE6Q1hHPDvnztGE/zWBb6tKJzg66IUwbfQv7aD3MU9WF3/Bg
	KvgW8lc8nexLxzPjJOcXUMhTjIpfc5do+CSOPOsw==
X-Google-Smtp-Source: AGHT+IEQpOw/ZU146SSrGxVXuIz4ee9qM+LXBgGI+xUZik36lWgykjPsA7ZeROLMyR+b9Z/I/AzjFA==
X-Received: by 2002:a17:90b:4ccd:b0:327:734a:ae7a with SMTP id 98e67ed59e1d1-33bcf87ac05mr21975841a91.11.1761065109629;
        Tue, 21 Oct 2025 09:45:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224a2f28sm38885a91.19.2025.10.21.09.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:45:09 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/8] iomap: account for unaligned end offsets when truncating read range
Date: Tue, 21 Oct 2025 09:43:45 -0700
Message-ID: <20251021164353.3854086-2-joannelkoong@gmail.com>
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

The end position to start truncating from may be at an offset into a
block, which under the current logic would result in overtruncation.

Adjust the calculation to account for unaligned end offsets.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 72196e5021b1..636d2398c9b4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -218,6 +218,22 @@ static void ifs_free(struct folio *folio)
 	kfree(ifs);
 }
 
+/*
+ * Calculate how many bytes to truncate based off the number of blocks to
+ * truncate and the end position to start truncating from.
+ */
+static size_t iomap_bytes_to_truncate(loff_t end_pos, unsigned block_bits,
+		unsigned blocks_truncated)
+{
+	unsigned block_size = 1 << block_bits;
+	unsigned block_offset = end_pos & (block_size - 1);
+
+	if (!block_offset)
+		return blocks_truncated << block_bits;
+
+	return ((blocks_truncated - 1) << block_bits) + block_offset;
+}
+
 /*
  * Calculate the range inside the folio that we actually need to read.
  */
@@ -263,7 +279,8 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		/* truncate len if we find any trailing uptodate block(s) */
 		while (++i <= last) {
 			if (ifs_block_is_uptodate(ifs, i)) {
-				plen -= (last - i + 1) * block_size;
+				plen -= iomap_bytes_to_truncate(*pos + plen,
+						block_bits, last - i + 1);
 				last = i - 1;
 				break;
 			}
@@ -279,7 +296,8 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;
 
 		if (first <= end && last > end)
-			plen -= (last - end) * block_size;
+			plen -= iomap_bytes_to_truncate(*pos + plen, block_bits,
+					last - end);
 	}
 
 	*offp = poff;
-- 
2.47.3


