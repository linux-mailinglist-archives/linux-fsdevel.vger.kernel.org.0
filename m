Return-Path: <linux-fsdevel+bounces-37960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9619F95D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6133A16FF7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7D421D00B;
	Fri, 20 Dec 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pTwLuQKR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75EA218EA8
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709729; cv=none; b=lCnEWkpkvKzRfE71x+ZMMTlFwkFY0PknDXelQuVLgviuC/wqP7IjJUpbp9JgkKxiUCaBMdGi+Nc+18MfP+ZI6j6xHz1nXX1E1hzrQspaclBaa/ucLu6I20y9gJT5B9U36+xyXebDNxxT39kHCSAqbGs4tyCAbJsTc4Vi+Z3ocTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709729; c=relaxed/simple;
	bh=sLgD25Nhzbud83QHSsVSAK9UDdaoG1oUsOEMQEZOwUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUslldes83cq3IF/HO565J++R2E+oecXWvzL1e3vB0LGyupNm7Z5eL67dOGEd6W/fjB5/6MrgRE5y+a80Gf5VjvXdwS1di9kRSfWgufXlBvEDQnrD5CMK8ps30Wzhgh7ldGT/e5LAxrT5HuII6EDkXim+jjY77G8yIzvwbliCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pTwLuQKR; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a7dd54af4bso7540895ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734709726; x=1735314526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks2mp2gCJ77yF3ZCGIs6WN32l2VaUGiu+2pglDT6eiI=;
        b=pTwLuQKRV9/Q3bq6gpmLR//R6ym34L5m6oW8S1GwoSYILJ9wTgck8/oITVcsgXUSCD
         AOe+Yn9S9UTOb61p7PakQV49SOm5f5Zh0torgzxBycAnzBFSPkUQ3RyhwmIzR484EQ1l
         HXsJMt9DQeyDf2YN0a6iDqkWCNiyK1CshRFATM84Nc/bzVIdX1QUcuqMpjLZ+aIfVfpJ
         xJCFHfxNzb7PrHh/G4gxmKippkxR4AeAvi9FydrVqS8XMbLrBhgjvXBu4CjgKuZGVqIH
         FssnBsxyRamd41o2MX9tkArMzab4R8c3DI1zWxfyxpTwVVD2PXqSrEuyVCeZR6sst1iA
         8/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709726; x=1735314526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ks2mp2gCJ77yF3ZCGIs6WN32l2VaUGiu+2pglDT6eiI=;
        b=RJPVgWURj7eVIh3hAjzsw97nToiSnGfUi42KH6kG+pT/3+c6ZMezzBwWFkocDysGmy
         mQXkf7T33OsneLmTu8mGYtIOss8FzRsSOIYMs/2kY6sHxlUtHUuCK4FF5mcnsJch6MAd
         w9LCJj4wXQBTrcRn+xcgqRKJvRz4YABTyhfsqQzNwnRCpPzAN1oK5xq8p4kxt0swMi2K
         YVosFkgdq6wOhKumti2NmmZ6FFMY3V6jt0/jCLSgJKjoZQLJDol+tTk9uryrhJaWURwt
         kK8Iuu0kaG5IVuFCucd6yTAuLwJG+EYNKz9SR56xB3cuw6oxfrTvxzaxcUYEXDdKvT5N
         rNlg==
X-Forwarded-Encrypted: i=1; AJvYcCUIGp+l7CJ8wy6W+a3l/IT31IilkgMiRt8DejnvlFwYk5za3RTsG2HKStd0yElVq+VHMLnjBfuxsRAWU01r@vger.kernel.org
X-Gm-Message-State: AOJu0Yymerwbn2DgKn/yNMCBnpC6QCtCKbpa29k9YTuhX3LWSoCkLnea
	BMSFMomyq2bK97RNLb5llARLZ60UDuQIZ6ZDBJdtPi7kBlbv42t92sIFwDxJu3w=
X-Gm-Gg: ASbGncvzqQqAgX7UA7n2Au6ML7C5+kbF6B2yaDPvxz2dSNQXbl9/qv2qj3RkED+W6HS
	kXkd6p3kPgKITMQzuV7teXl6jGuQa1J4+IQHl2z5qr0X6FptHQhwbMjqc4aCy2PXnZ4TXmHAY0B
	Hrl7dHZdqxehbAQfG5w0gZiykbLWHZNws2XUmCLBik5/888IcoEksAEXljnOAgoDpnorbe+L2Kk
	V3qE64tP7dtqdyq/3UZgZpXG+oj6BislPxN4Cy9m5sCzvbAIdM5Ij9YCxF9
X-Google-Smtp-Source: AGHT+IG1Q5MpgKTbxJc/Yphg2SqFQXSKzJLSB4ruy07feq+/t9lmMQDAi0QHm0P3EjCYdC27xoRmeQ==
X-Received: by 2002:a05:6e02:3201:b0:3a7:be5e:e22d with SMTP id e9e14a558f8ab-3c2d1aa3e86mr30848135ab.2.1734709725732;
        Fri, 20 Dec 2024 07:48:45 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66ed9sm837821173.45.2024.12.20.07.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:48:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/12] mm/filemap: add read support for RWF_DONTCACHE
Date: Fri, 20 Dec 2024 08:47:46 -0700
Message-ID: <20241220154831.1086649-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220154831.1086649-1-axboe@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RWF_DONTCACHE as a read operation flag, which means that any data
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

If the same test case is run with RWF_DONTCACHE set for the buffered read,
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
index 220dc7c6e12f..dd563208d09d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2473,6 +2473,8 @@ static int filemap_create_folio(struct kiocb *iocb, struct folio_batch *fbatch)
 	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
 	if (!folio)
 		return -ENOMEM;
+	if (iocb->ki_flags & IOCB_DONTCACHE)
+		__folio_set_dropbehind(folio);
 
 	/*
 	 * Protect against truncate / hole punch. Grabbing invalidate_lock
@@ -2518,6 +2520,8 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
 
 	if (iocb->ki_flags & IOCB_NOIO)
 		return -EAGAIN;
+	if (iocb->ki_flags & IOCB_DONTCACHE)
+		ractl.dropbehind = 1;
 	page_cache_async_ra(&ractl, folio, last_index - folio->index);
 	return 0;
 }
@@ -2547,6 +2551,8 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			return -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags = memalloc_noio_save();
+		if (iocb->ki_flags & IOCB_DONTCACHE)
+			ractl.dropbehind = 1;
 		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			memalloc_noio_restore(flags);
@@ -2594,6 +2600,20 @@ static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
 	return (pos1 >> shift == pos2 >> shift);
 }
 
+static void filemap_end_dropbehind_read(struct address_space *mapping,
+					struct folio *folio)
+{
+	if (!folio_test_dropbehind(folio))
+		return;
+	if (folio_test_writeback(folio) || folio_test_dirty(folio))
+		return;
+	if (folio_trylock(folio)) {
+		if (folio_test_clear_dropbehind(folio))
+			folio_unmap_invalidate(mapping, folio, 0);
+		folio_unlock(folio);
+	}
+}
+
 /**
  * filemap_read - Read data from the page cache.
  * @iocb: The iocb to read.
@@ -2707,8 +2727,12 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			}
 		}
 put_folios:
-		for (i = 0; i < folio_batch_count(&fbatch); i++)
-			folio_put(fbatch.folios[i]);
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
+
+			filemap_end_dropbehind_read(mapping, folio);
+			folio_put(folio);
+		}
 		folio_batch_init(&fbatch);
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
diff --git a/mm/swap.c b/mm/swap.c
index 10decd9dffa1..ba02bd5ba145 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -427,6 +427,8 @@ static void folio_inc_refs(struct folio *folio)
  */
 void folio_mark_accessed(struct folio *folio)
 {
+	if (folio_test_dropbehind(folio))
+		return;
 	if (lru_gen_enabled()) {
 		folio_inc_refs(folio);
 		return;
-- 
2.45.2


