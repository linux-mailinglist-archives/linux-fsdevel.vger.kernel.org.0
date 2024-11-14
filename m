Return-Path: <linux-fsdevel+bounces-34810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE69C8E2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F08D1F217CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF231A256C;
	Thu, 14 Nov 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qqHMLA/+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFDD19340E
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598095; cv=none; b=RNdFsaA4FMZbzrzEy/7UYj0IvqyTl8YaseJ2YFVtDmYPwJScOXkz6sDZFy85Rkcpu6LVl3/m1e9pTLEVsQcVxAW9Vth2eqNfr6U3FAp/T3vdL2YcTl5mKnVR/4iQQqd05BNdx1oNCnfhfwhiNyaDh9ky+Ms43VoTKFzpjvmnPZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598095; c=relaxed/simple;
	bh=+LBI8Q/JaILudpg11KeqvJRORHez4jw0F0mptlAAtjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hn7/za5P2ot1YSjJmslMyGYwQ02ugILnLR11hHbPFWYZsYzJQIRpbfMmR0UjoFACbg1KeM/YIeHSAL9IYEHpP897t4UOFN1n15ZytssnqYTxVC+fCwej8HZwCdmT4uFjANF3+tohUrsl3G22FHgHmR4kTjGJ6tKDou/wzZoOCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qqHMLA/+; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ebc4e89240so309452eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 07:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598093; x=1732202893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7749KjgMy6eatM2VSy2jowDIab8tvoATfJQmYOPl1pc=;
        b=qqHMLA/+W3MXqoe3ZgYdwBG52pjmWMZyuV8lwyc+PPBVuO95iwCtFK8QcXnHEAD7G4
         BPOHvQNQDiuYxHHrey6bptacw0CysLM+9YltKZlw9rN/Q7sL1l7tzZqcaDOycr9ad9IG
         x+s7RUoPvXpmfRMUATWTgDCiqbxsUys1HKePsVFn02vGwPkXLT618oEbdgxmGKY8ERY7
         e6uFsqBx49ueZZ58a1PftC3GzO0H2ld794uhYdjV3rnEWqQQIJ93GjnjY825XTESeCGS
         VAFJ4zW9XPoHevGcTpqJHI4AVF0PnV71G59h57bbIyd2pLA4ySu46pBP64POBRTYzHkd
         wD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598093; x=1732202893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7749KjgMy6eatM2VSy2jowDIab8tvoATfJQmYOPl1pc=;
        b=gQI/snR6El35rpulBeObsDAk7230zMx3oj9KMajDSkgvuU3K2XTlJrBbkQl27UK0nn
         FLt2EPeAL+fnnX1OtmJR3MyEXPxPgK37g1R0zUyWK0JFTaK/qkaPNtpWS+AKUryMb7a+
         WLaMhnT42S87o7GXDeFu1pcoD+ag9LulNtqQErNZuzqUe4AufHunCQ+OlihEAj0U4M5l
         0ADA8AVgcc6EA3M5yPN7VBLH/ZM6M118E/6JQrc5f6ROD0vCuYTz/k+u+4LfbjdQGvDF
         Wh4pu90KB06U9UjwxNltXfkIO2VHp6nl5KM4DsaqhP6TZONrBpPIZAH6OXXrjhxUh25m
         OPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCDbZxSnNNzOhX1GlGaWkh8RjeWGeZBGPfizZpfQnhe4+5c7o2HKnQq3xFo7HM/5atIukCWNv/16OxDzWy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtuljal/hQfwQD3tdlJkQCHzji0L86r1i0n/oAdNNSL8bKOb40
	0TF/Yl8/YKIiyKUaHLf3U75ONQFuVL/9JQr4YjnuYrUJbTMItSoB86os+yJ7G/w=
X-Google-Smtp-Source: AGHT+IHV4oSrYqhQg8SNV67NfRcdIlRE7mzCITp5FLKpYfj2Lpw4MvYi01EsizY0Kl5ORLV8Nbza+Q==
X-Received: by 2002:a05:6820:8cc:b0:5eb:6a67:6255 with SMTP id 006d021491bc7-5ee9ec3bae1mr2681521eaf.1.1731598092948;
        Thu, 14 Nov 2024 07:28:12 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:12 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/17] mm/filemap: add read support for RWF_UNCACHED
Date: Thu, 14 Nov 2024 08:25:12 -0700
Message-ID: <20241114152743.2381672-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
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
cousin of O_DIRECT - it has none of the restrictions of O_DIRECT. Yes,
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
 mm/filemap.c | 28 ++++++++++++++++++++++++++--
 mm/swap.c    |  2 ++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 02d9cb585195..3d0614ea5f59 100644
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
@@ -2595,6 +2601,20 @@ static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
 	return (pos1 >> shift == pos2 >> shift);
 }
 
+static void filemap_uncached_read(struct address_space *mapping,
+				  struct folio *folio)
+{
+	if (!folio_test_uncached(folio))
+		return;
+	if (folio_test_writeback(folio))
+		return;
+	if (folio_test_clear_uncached(folio)) {
+		folio_lock(folio);
+		folio_unmap_invalidate(mapping, folio, 0);
+		folio_unlock(folio);
+	}
+}
+
 /**
  * filemap_read - Read data from the page cache.
  * @iocb: The iocb to read.
@@ -2706,8 +2726,12 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			}
 		}
 put_folios:
-		for (i = 0; i < folio_batch_count(&fbatch); i++)
-			folio_put(fbatch.folios[i]);
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
+
+			filemap_uncached_read(mapping, folio);
+			folio_put(folio);
+		}
 		folio_batch_init(&fbatch);
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
diff --git a/mm/swap.c b/mm/swap.c
index b8e3259ea2c4..542f298d3dcd 100644
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


