Return-Path: <linux-fsdevel+bounces-34153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AB09C3330
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 16:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457E71F21412
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 15:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5849115852F;
	Sun, 10 Nov 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HHaWkcpa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3034156F4A
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252568; cv=none; b=gSzDvJJLJW5H3Fsx6DooVCcXJUb6At9GrAR9xpXPCVYeSv/9/9C/RhZLhv4lFcoPWB3pRVO58g46ydt/fm7pIsFLn0mSngUf11ss1dnftyThHs3yKFCColxbCZ0yOKo2YsCQiUkVuCJ2ph2Vxm8My23n15gwgGnVnM87Qi2VH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252568; c=relaxed/simple;
	bh=GtEZ1vh2U+C3BSovAlp6aWdv1IA1Yxh/R7JebXsMPYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gM5MTfU2yRUqR/IoVrNWsNH8yyxyfv0pfgN7eqmJ+9n6GzT7A4Nc2hzBTXVWidqHwiye/Z5ML5MUgwdnNM00lAl2q3ysjejzC9QeZV0eqAP3LloXbJ9YvR6IA1IXmUXRz3XTY2M3v9oLE5SK2uiBg969tKlqsSlOT7mJYh7BYbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HHaWkcpa; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso2982971a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252565; x=1731857365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2GrDSrtQqt8cMSioXW5eWMYaGSDX9LD8WbU7yXVjqU=;
        b=HHaWkcpaZkDLnKu53ZAGR9OB/MAQgZlLs61GpZhp9XOUDwp0vjTxEsTwscDQ9z9Gnp
         SOgjDyWlUXTFMieY/hjSZM2vRS51GGsBObOTwjUP4AWPbHxmJA1Tx1Q7EIuPfXwXcRTs
         /s9HKiYJMd5pH8ng5ngieLvwhWmkMCwguQy2yyPDTNMTXvy+9Rhqr8IOOwLHNr0aB73x
         KwWJHy7Owdp77qRB5HtDHb+MlhHt6GBFjfk/DtpKHW2oxSAOhmFQetclgajE1hrUR1j3
         ryEa+/KaaacpqB3fo9+k3R+ZlkuIHuxJOkT8dXl/rsz6rAwHE7FO6ITIQqSv+1P+6TxN
         n8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252565; x=1731857365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2GrDSrtQqt8cMSioXW5eWMYaGSDX9LD8WbU7yXVjqU=;
        b=h3cbpK9WmqGLl0SZudXpdR6mDMHQz0klw6B0VOHSkoSQB+H581KHosu5EauDf+/2jC
         uYcHC9uInehibOuzbnyGbSKufnxc6uzATbEl2dMjJubdfXja04SVxw2moOkcpys7eupX
         pEllIQe1qLIjg/3o1iodj4rdxcjieQVd/DGI5I67kQGXQ3rSXR82VVveNA6CBbyvDIZg
         8v0OvibAaJ0hbmtLu9VfCM62Zs44wbzbMK8mF0oS0MPyXJfxm5n6iy7JEE8sr0RGToII
         L3ADBaXc/rhC3CE37ONad3DgLFQ4GGjL0M/bafGp8O7j8/Mh/IiBidScFtTRtd68Raz1
         7hBw==
X-Forwarded-Encrypted: i=1; AJvYcCXDQ/lBAvt04ukqOFAtZKP1pFwxIRSi4itAKQaIbUr/RnV9eBjhvA8rcVHVa6gFREsnZXEGQDLODEw7oH2Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1dI4ILueIj5obVNEo5mODUF3zda+agLjPiNNPtOkYaSYSuTm
	S0CZ5URZCy/PajK93Zuw2DI19W705vdr3yr3VdDRH02yp3mLqBcq4tXpWhapvpY=
X-Google-Smtp-Source: AGHT+IHD5ZOaM1/ydWmKI6E2td5s5ih4bl0qHFridFSAcX9UJ78BlPPQ+BWJS6tide+7RYqVyEL5yA==
X-Received: by 2002:a17:90b:2748:b0:2d8:840b:9654 with SMTP id 98e67ed59e1d1-2e9b1754affmr13371709a91.34.1731252565293;
        Sun, 10 Nov 2024 07:29:25 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
Date: Sun, 10 Nov 2024 08:28:00 -0700
Message-ID: <20241110152906.1747545-9-axboe@kernel.dk>
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

Add RWF_UNCACHED as a read operation flag, which means that any data
read wil be removed from the page cache upon completion. Uses the page
cache to synchronize, and simply prunes folios that were instantiated
when the operation completes. While it would be possible to use private
pages for this, using the page cache as synchronization is handy for a
variety of reasons:

1) No special truncate magic is needed
2) Async buffered reads need some place to serialize, using the page
   cache is a lot easier than writing extra code for this
3) The pruning cost is pretty reasonable

and the code to support this is much simpler as a result.

You can think of uncached buffered IO as being the much more attractive
cousing of O_DIRECT - it has none of the restrictions of O_DIRECT. Yes,
it will copy the data, but unlike regular buffered IO, it doesn't run
into the unpredictability of the page cache in terms of reclaim. As an
example, on a test box with 32 drives, reading them with buffered IO
looks as follows:

Reading bs 65536, uncached 0
  1s: 145945MB/sec
  2s: 158067MB/sec
  3s: 157007MB/sec
  4s: 148622MB/sec
  5s: 118824MB/sec
  6s: 70494MB/sec
  7s: 41754MB/sec
  8s: 90811MB/sec
  9s: 92204MB/sec
 10s: 95178MB/sec
 11s: 95488MB/sec
 12s: 95552MB/sec
 13s: 96275MB/sec

where it's quite easy to see where the page cache filled up, and
performance went from good to erratic, and finally settles at a much
lower rate. Looking at top while this is ongoing, we see:

 PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
7535 root      20   0  267004      0      0 S  3199   0.0   8:40.65 uncached
3326 root      20   0       0      0      0 R 100.0   0.0   0:16.40 kswapd4
3327 root      20   0       0      0      0 R 100.0   0.0   0:17.22 kswapd5
3328 root      20   0       0      0      0 R 100.0   0.0   0:13.29 kswapd6
3332 root      20   0       0      0      0 R 100.0   0.0   0:11.11 kswapd10
3339 root      20   0       0      0      0 R 100.0   0.0   0:16.25 kswapd17
3348 root      20   0       0      0      0 R 100.0   0.0   0:16.40 kswapd26
3343 root      20   0       0      0      0 R 100.0   0.0   0:16.30 kswapd21
3344 root      20   0       0      0      0 R 100.0   0.0   0:11.92 kswapd22
3349 root      20   0       0      0      0 R 100.0   0.0   0:16.28 kswapd27
3352 root      20   0       0      0      0 R  99.7   0.0   0:11.89 kswapd30
3353 root      20   0       0      0      0 R  96.7   0.0   0:16.04 kswapd31
3329 root      20   0       0      0      0 R  96.4   0.0   0:11.41 kswapd7
3345 root      20   0       0      0      0 R  96.4   0.0   0:13.40 kswapd23
3330 root      20   0       0      0      0 S  91.1   0.0   0:08.28 kswapd8
3350 root      20   0       0      0      0 S  86.8   0.0   0:11.13 kswapd28
3325 root      20   0       0      0      0 S  76.3   0.0   0:07.43 kswapd3
3341 root      20   0       0      0      0 S  74.7   0.0   0:08.85 kswapd19
3334 root      20   0       0      0      0 S  71.7   0.0   0:10.04 kswapd12
3351 root      20   0       0      0      0 R  60.5   0.0   0:09.59 kswapd29
3323 root      20   0       0      0      0 R  57.6   0.0   0:11.50 kswapd1
[...]

which is just showing a partial list of the 32 kswapd threads that are
running mostly full tilt, burning ~28 full CPU cores.

If the same test case is run with RWF_UNCACHED set for the buffered read,
the output looks as follows:

Reading bs 65536, uncached 0
  1s: 153144MB/sec
  2s: 156760MB/sec
  3s: 158110MB/sec
  4s: 158009MB/sec
  5s: 158043MB/sec
  6s: 157638MB/sec
  7s: 157999MB/sec
  8s: 158024MB/sec
  9s: 157764MB/sec
 10s: 157477MB/sec
 11s: 157417MB/sec
 12s: 157455MB/sec
 13s: 157233MB/sec
 14s: 156692MB/sec

which is just chugging along at ~155GB/sec of read performance. Looking
at top, we see:

 PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
7961 root      20   0  267004      0      0 S  3180   0.0   5:37.95 uncached
8024 axboe     20   0   14292   4096      0 R   1.0   0.0   0:00.13 top

where just the test app is using CPU, no reclaim is taking place outside
of the main thread. Not only is performance 65% better, it's also using
half the CPU to do it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 18 ++++++++++++++++--
 mm/swap.c    |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 38dc94b761b7..bd698340ef24 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2474,6 +2474,8 @@ static int filemap_create_folio(struct kiocb *iocb,
 	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
 	if (!folio)
 		return -ENOMEM;
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		__folio_set_uncached(folio);
 
 	/*
 	 * Protect against truncate / hole punch. Grabbing invalidate_lock
@@ -2519,6 +2521,8 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
 
 	if (iocb->ki_flags & IOCB_NOIO)
 		return -EAGAIN;
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		ractl.uncached = 1;
 	page_cache_async_ra(&ractl, folio, last_index - folio->index);
 	return 0;
 }
@@ -2548,6 +2552,8 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			return -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags = memalloc_noio_save();
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			ractl.uncached = 1;
 		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			memalloc_noio_restore(flags);
@@ -2706,8 +2712,16 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			}
 		}
 put_folios:
-		for (i = 0; i < folio_batch_count(&fbatch); i++)
-			folio_put(fbatch.folios[i]);
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
+
+			if (folio_test_uncached(folio)) {
+				folio_lock(folio);
+				invalidate_complete_folio2(mapping, folio, 0);
+				folio_unlock(folio);
+			}
+			folio_put(folio);
+		}
 		folio_batch_init(&fbatch);
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
diff --git a/mm/swap.c b/mm/swap.c
index 835bdf324b76..f2457acae383 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -472,6 +472,8 @@ static void folio_inc_refs(struct folio *folio)
  */
 void folio_mark_accessed(struct folio *folio)
 {
+	if (folio_test_uncached(folio))
+		return;
 	if (lru_gen_enabled()) {
 		folio_inc_refs(folio);
 		return;
-- 
2.45.2


