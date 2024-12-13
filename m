Return-Path: <linux-fsdevel+bounces-37335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B439F119C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF465165F6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7981EE7C2;
	Fri, 13 Dec 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w4XdXwHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C711E3DFE
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105377; cv=none; b=R52eCfEcdmNOAZJgUhpjLSrTWn3b7Q0Q2tEaPZJgMB1LtLacSVGz8tLaMGt4CiqaxcUNtmcH/KWiuh7XahLB+9ebhfKPFEpIgMOq3KGH2+nVwSMm+lJl5fX8f73XHtBpf30X1ohe3FfvXgQzctpBuqjJYhiOD4XJMu4e/1xqCS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105377; c=relaxed/simple;
	bh=vDmNnPIlxbQFCnastmzOm8F+RELQsnyCtSC4KgXE2I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHYlyLLo4eL/DxMztcmLH/VEFrV9mjFMKy+gCxttgBE/8rGjmk/2Q1ccUHGfFs6lTQAMz/HXO4fJAPUUUvUsx7r3WONCNYTiXvSlf73wMM0bbN/fgfmn0oYvhtnrivOpc7+9MGSiLpcurJvAs+NQyj7UidgBclEJlxZOWEs4AIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w4XdXwHr; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a7d7db4d89so5835235ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105374; x=1734710174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IP/eZVPa/Uul8epuK9rEl1xWlFc7aGT1EOVSfKN8LMY=;
        b=w4XdXwHrYVwFTvJ/MqoLN+c2dm61xKQFuUZKIwd9uV037G2HBS2LFfxCmr03/Ijc/j
         Nk7Pg8xdZyUXbbdukjEFXskzc70Vt6AyrAa2OICUAUeoNLIc38lBfL7dcl0M6bdLRTB5
         vgHreqf2XZ/BjsBZ7VEi6YH3OohKGNo4rUEp4ommh6ZZwRLTkwhspRKxquwO4vqbZot1
         ZtAeAxZTV2ChkbXCzL/LZ/iFGR/BtBFpPrBstn0Z618+xcvsV4I0d2L3mOFswtZO6Vib
         omrWpihLU5nNR74wLtz6b7r9AqP8zNMqgvgP7UERlJtQv1582/d5JTge3yGOmWUHfFoT
         iX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105374; x=1734710174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IP/eZVPa/Uul8epuK9rEl1xWlFc7aGT1EOVSfKN8LMY=;
        b=wSiDiOW9kQ0zlxaYVooi2ucH/R+PVVqCwIKOC2j+ge4TxuRn3+ClRbJk2FkgXlsN8U
         xnRPMxyfVvI/QfucXgzXPXm6ZhuKzLJXm8BHEcGtuY33WT8PpMek33RJz7dOixE8zf4A
         6BnMOWClB7keNaZDtslOejfsQUisWoPjHsE8nTUG93OaNXpXatDTtbbmHW2B5+j7HWvx
         w1QYOeS8fV5FMHC63Jj1iMiuAQMzzgndVb/IHC1LcQ/a8ImVqyfSiSfgkJjI5qSqmmUP
         yUfAn+ff8qqs9BuYf0iUAmMD3O3peewkEw53J37D6YR1YvCX9q2o/Y+D5NXzvcactXZH
         gPbg==
X-Forwarded-Encrypted: i=1; AJvYcCV0X0WVkH14knJWborjg2ZE8L6g0h8NHxOw/mLOOV0/BDrWfBwjT/9m0VNJwSivmVzDZI9qJIEHKXna9rzu@vger.kernel.org
X-Gm-Message-State: AOJu0YyvZndbvzD7sXBn0A4CZH4nVJIJ1WUo7qJqMSzJgiGHlap1Wuxq
	oBqL5T2MRqCSU1+d0CNIkzzFZxSPwyu0UL3KRHHt6wRrWquey+DpeZvi1cpen3A=
X-Gm-Gg: ASbGncvYL8fbWp2eDrzqmyU5RkAzJ4SuKyAg2gfmUwx68FA361/LXOLdj+cDXQDdCcW
	AvetMNj6SE0jjbAps8WnEHTYis+MG2MmW/8ZevYJQi8fA0m434WkESauqJBi0ewj4k7gBj0efp7
	S80tUxjAGt7XWJr6B1CcfVPDv1RBCh/Mo+gmYi9NKnhnyWEnSh8gGcpMzP9MataB9NKMmZNMhS6
	XB6AsgV7mlAZbRoWSeVQFJMsIYBtIoA19dB3urP0KqeJ2EEt+00BV0zLigH
X-Google-Smtp-Source: AGHT+IH9sg/APOeVcvmxNi3lc/CaFUy261G7dVBoU1ZPhJ36GVox2hlXSW2u68WXUBo94t1FWfRBpA==
X-Received: by 2002:a05:6e02:168d:b0:3a7:c2ea:1095 with SMTP id e9e14a558f8ab-3aff4615779mr38827345ab.1.1734105374532;
        Fri, 13 Dec 2024 07:56:14 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:13 -0800 (PST)
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
Subject: [PATCH 08/11] mm/filemap: add read support for RWF_DONTCACHE
Date: Fri, 13 Dec 2024 08:55:22 -0700
Message-ID: <20241213155557.105419-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>
References: <20241213155557.105419-1-axboe@kernel.dk>
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
index 220dc7c6e12f..77290ac205dc 100644
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
 
+static void filemap_uncached_read(struct address_space *mapping,
+				  struct folio *folio)
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
+			filemap_uncached_read(mapping, folio);
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


