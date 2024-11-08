Return-Path: <linux-fsdevel+bounces-34075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60F9C244E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA8B285F9F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F2E21F4CC;
	Fri,  8 Nov 2024 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mzGENvrA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D121EBA4
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087927; cv=none; b=t/vkY/sPCUdiaJusB2142EWNZbL0xYoFsoMIs9Jpu2wM+98Fcpwdj+y9urmSkVRlSIpy8+ydSChmFy77qomDGmJJ4tFS5lf8eb9byq8b41n8RRdMWKy3tLZFdXENPnh5/w3BL/p96lAlIBQloOJCg1UogBoELKheH7pbISQEvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087927; c=relaxed/simple;
	bh=HjbXXXZ2QRG/1ZhQXxL5goItns1riItnFEOaINOV5dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TefuIbFIIqcPI/V29JfNzB0OLP2/LYJbMybT1ddnMX0owwZCqMcT3V5XGgK/6AJrh+ishA8ZCwwLsmji4FvkVvEJ3kPbFdbwRJPGfaLod+3ldcEQj3A9Gc+VCG/zHBTLkqDlnrDFngJSAPVNl0OCbcwOcac/h/649J3FGDMGv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mzGENvrA; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e607556c83so1581620b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087924; x=1731692724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tq+ywqpEyPaYsCraC6z/Wa/2p0SbC90MEdwC8hVGLhU=;
        b=mzGENvrAOCh9hnAR00/bEAnahHqDaQJ9ycVQx7MoHypO8YsL3RTCoHfVnApIsib/4U
         Rb1thvsrXx3tmAUaghDndxj/fw1eFeldg9NJRZOGWOR6cpxG4aroEidfl9cZWz/04php
         5YOk0VJiRsJ5c67WGRwYJ9jN0xApw53DmItNNvk5u+P57j7Ne4B2OHHuENjYIOFJbLTQ
         mwgC6Oe6aZiY3Hr6Co0XZxxXcli+y42GwrneNyP8WRUIPxfUyuLnolDAQO1YM5xEjGKC
         YXa7cu8c95s5QppvoAoizbPXhtqhUNfvJADyb3g7kj0DRgkxnabnQ5GwpFsPkoHO/wng
         J56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087924; x=1731692724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tq+ywqpEyPaYsCraC6z/Wa/2p0SbC90MEdwC8hVGLhU=;
        b=SbcAvwXrRKTMrcJNd5T3fyt/t0eiuNudAU/Pr1R6JAZAjCUqYIutPf5Ftpb9Fom6OT
         6S2quFhktuHCK7H6noI/V8jt0BZuHsCn4KplQufym/bAFZt73SXU68WNUGq5ph9wLt34
         JicHBgUVMBgDdzgJVcfb995IYY301y98moP+Kn5+YjIhlINIk/cDIm2ihvDPfWUhZ0zf
         RquL+73+Z2oCRuGK73VUL1DpUos8RzXZj58f+CSgP1A5dcQJCFT1ZpgwgUbbfwyqGCEz
         kD0cq0EotAW/FX8DpMb0M7ZZcUf6GhrbwX1QbdasAJtLmKfWLn2EMKxt5X6jDgiy12Fs
         dr/g==
X-Forwarded-Encrypted: i=1; AJvYcCXdqzwrlSyIPNSWofXPqWh4VEkOJ+YXBwFIXYmcGGoqMjtn4sCMNJazBlp6VMK3o+KGx5iD1Tq4npwXrzXY@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3xEFR8Dj7sDdngpQByIJ2OvtPKCfOpmULmfMq2o8eK629m6u
	+D/cqI/3gT4Z87db5wG42KJGPeXNKjY7ShmwbqShbl18IAORCoLH9vduwmaejN0=
X-Google-Smtp-Source: AGHT+IHYb37IuRL+rD3E4bWkVAGE9ioVB03ZuysIUbDHqe4Odg9KTg4FuyvIzrjyhDZyIdkBKG8ezw==
X-Received: by 2002:a05:6808:1819:b0:3e6:3205:1a71 with SMTP id 5614622812f47-3e794699f41mr4284876b6e.15.1731087924649;
        Fri, 08 Nov 2024 09:45:24 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/13] fs: add read support for RWF_UNCACHED
Date: Fri,  8 Nov 2024 10:43:31 -0700
Message-ID: <20241108174505.1214230-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108174505.1214230-1-axboe@kernel.dk>
References: <20241108174505.1214230-1-axboe@kernel.dk>
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
 include/linux/fs.h      |  4 +++-
 include/uapi/linux/fs.h |  6 +++++-
 mm/filemap.c            | 18 ++++++++++++++++--
 mm/swap.c               |  2 ++
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 491eeb73e725..5abc53991cd0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -320,6 +320,7 @@ struct readahead_control;
 #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
 #define IOCB_APPEND		(__force int) RWF_APPEND
 #define IOCB_ATOMIC		(__force int) RWF_ATOMIC
+#define IOCB_UNCACHED		(__force int) RWF_UNCACHED
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
@@ -354,7 +355,8 @@ struct readahead_control;
 	{ IOCB_SYNC,		"SYNC" }, \
 	{ IOCB_NOWAIT,		"NOWAIT" }, \
 	{ IOCB_APPEND,		"APPEND" }, \
-	{ IOCB_ATOMIC,		"ATOMIC"}, \
+	{ IOCB_ATOMIC,		"ATOMIC" }, \
+	{ IOCB_UNCACHED,	"UNCACHED" }, \
 	{ IOCB_EVENTFD,		"EVENTFD"}, \
 	{ IOCB_DIRECT,		"DIRECT" }, \
 	{ IOCB_WRITE,		"WRITE" }, \
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..dc77cd8ae1a3 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -332,9 +332,13 @@ typedef int __bitwise __kernel_rwf_t;
 /* Atomic Write */
 #define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
 
+/* buffered IO that drops the cache after reading or writing data */
+#define RWF_UNCACHED	((__force __kernel_rwf_t)0x00000080)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC)
+			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
+			 RWF_UNCACHED)
 
 #define PROCFS_IOCTL_MAGIC 'f'
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 7f8d13f06c04..6f65025782bb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2471,6 +2471,8 @@ static int filemap_create_folio(struct kiocb *iocb,
 	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
 	if (!folio)
 		return -ENOMEM;
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		folio_set_uncached(folio);
 
 	/*
 	 * Protect against truncate / hole punch. Grabbing invalidate_lock
@@ -2516,6 +2518,8 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
 
 	if (iocb->ki_flags & IOCB_NOIO)
 		return -EAGAIN;
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		ractl.uncached = 1;
 	page_cache_async_ra(&ractl, folio, last_index - folio->index);
 	return 0;
 }
@@ -2545,6 +2549,8 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			return -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags = memalloc_noio_save();
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			ractl.uncached = 1;
 		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			memalloc_noio_restore(flags);
@@ -2705,8 +2711,16 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
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


