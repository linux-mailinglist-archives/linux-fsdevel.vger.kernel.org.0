Return-Path: <linux-fsdevel+bounces-34156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB49C3336
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 16:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE71C209FC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A1115B971;
	Sun, 10 Nov 2024 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Wy+4sM/C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD981586F2
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252571; cv=none; b=DER+ZwzIYc3p9faWrFU8QHSn5S1XhW9FTKrjNQ1sFjxU8jhqjO0YcmtcgmIHA6oIGY48MJ14ZXQnn2pwnkHXVtYuBYCJ7WlieuZc/pn0SKTokBX9U+Km9ChwBqFAvJUJlATRzspUUwzw4IEo37b1lwE98acyXmVX4ZfVUAUZvvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252571; c=relaxed/simple;
	bh=7n4q+dbKFb0eQ3Qygk7Z+kektGylKUoxfQQqH74ekkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C51dOXtY+xI0+lkhWzv4na5anAsdf7Z5HPbfS+mwZIEaiZDjE08Dck4dDbyk8epBQ01iKmcFAJJais+4zDKSZFURon12HS1UW4q1xWdnh8FQZAv2cpGWZddlzz0cX6LJuLtUrsvXOnkXaKQ/tQHBacp+wbI6HTEZ3Yla9rpty6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Wy+4sM/C; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so2713895a91.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252569; x=1731857369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ft1nD1O8TW6ajHAbmpyRJ7eqllXRgDsj9KVxLudGNI=;
        b=Wy+4sM/Cvbe99m987p/3qS0IogzcZGYbEAMzNhAT4Eaj0llnpLqnLvEMmp5lJJHWJA
         zyaq38zy5wPRH0tnH7L+Y5YJKpTO1ZFJYv3tnOvys6EvpbVMao+xkiACAmkS0MoKYbuP
         WuTlPbhxGXVtjRWii2iAcJeS0eI+eKiTgHhuJ/3Wqhd7ad3KJRHuOhFVueF6SDVDU7Vj
         LDHQvPS3vVIymeGFiMUdlJjHVyqDzvlWd6znEyUeWK285+L77j+Bv+aNGUahC6fy1WTG
         gKZ8c22qIckzpA1GNJAhs5lHilnHB3AdkzruNGxnEzUCX/P0Kr6hmZ9cd45FoCWBeSNF
         7+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252569; x=1731857369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ft1nD1O8TW6ajHAbmpyRJ7eqllXRgDsj9KVxLudGNI=;
        b=AM1X/l6k/ji317uMm1ZIbdUbbuwUL5/jwAixmqUddJl0Zar17Z/moCdJC6OKuJfPv7
         Whjb6VMcuEBMO5inGcJeatJdRZFV0BEa3iNBe4DVGQ8JJN9h27WV1B3bKQWzEmopLDUz
         pYL8NXihefrqKoEfGvYOkev1X5341VUEF1mOvlPFbOo/N+6pqj5YVUkqUwyOg6Ngv9Ek
         vYD6Q6vzK9QWrQxuJ08iB5zwiz1qcTCFh2pKpPZ7v06lrf4zbOVR02BYaepfxjcz1BOy
         5XrZAcyy+lr/WEuNCFDL83X4rU/xznhooSq2ExrmkeGdR24FFuJUvNzfg93AZnBD+pOp
         8YEw==
X-Forwarded-Encrypted: i=1; AJvYcCWInWRpXRvqBBSQEZFgGlWs1wCyPu72OBwvWj07k+IZJMRbeJTfaU1bYpNudU9RVN+F3cm+lSe/sBqztIGh@vger.kernel.org
X-Gm-Message-State: AOJu0YyFegzKwJgs3RH7J+lggecm3qgXpB4/3k4C8syb6khQyvPMF7mU
	9nRAEpu8S9RTNXXIAAU3fCrjlqaSgzhY8OMtlKlHjayoD5HrfKDo0GGaHLtthbI=
X-Google-Smtp-Source: AGHT+IGnzg2hDaZ2lVFGocJncR7soOdtnLL/Yc809zXi6ImqKmn+BDcRSWipzylZxh/jlIYcFDHDiw==
X-Received: by 2002:a17:90b:1bc3:b0:2e0:7b03:1908 with SMTP id 98e67ed59e1d1-2e9b0a57d33mr14506762a91.10.1731252569648;
        Sun, 10 Nov 2024 07:29:29 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/15] mm: add FGP_UNCACHED folio creation flag
Date: Sun, 10 Nov 2024 08:28:03 -0700
Message-ID: <20241110152906.1747545-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>
References: <20241110152906.1747545-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers can pass this in for uncached folio creation, in which case if
a folio is newly created it gets marked as uncached. If a folio exists
for this index and lookup succeeds, then it will not get marked as
uncached.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 2 ++
 mm/filemap.c            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 5469664f66c3..de0ed906cd2d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -741,6 +741,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
  * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
  * * %FGP_NOWAIT - Don't block on the folio lock.
  * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
+ * * %FGP_UNCACHED - Uncached buffered IO
  * * %FGP_WRITEBEGIN - The flags to use in a filesystem write_begin()
  *   implementation.
  */
@@ -754,6 +755,7 @@ typedef unsigned int __bitwise fgf_t;
 #define FGP_NOWAIT		((__force fgf_t)0x00000020)
 #define FGP_FOR_MMAP		((__force fgf_t)0x00000040)
 #define FGP_STABLE		((__force fgf_t)0x00000080)
+#define FGP_UNCACHED		((__force fgf_t)0x00000100)
 #define FGF_GET_ORDER(fgf)	(((__force unsigned)fgf) >> 26)	/* top 6 bits */
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
diff --git a/mm/filemap.c b/mm/filemap.c
index cfbfc8b14b1f..4fdf3c4ae00f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1987,6 +1987,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			/* Init accessed so avoid atomic mark_page_accessed later */
 			if (fgp_flags & FGP_ACCESSED)
 				__folio_set_referenced(folio);
+			if (fgp_flags & FGP_UNCACHED)
+				__folio_set_uncached(folio);
 
 			err = filemap_add_folio(mapping, folio, index, gfp);
 			if (!err)
-- 
2.45.2


