Return-Path: <linux-fsdevel+bounces-34077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CA69C2452
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BCF1C26DFB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992A121FDB5;
	Fri,  8 Nov 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VZU/qT8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9B21EBA4
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087930; cv=none; b=GWJIwfVYx7Crrn0ZncgcLL8vH+HORGKqbonrdLQ/L6yKlg/z1vysgHH9nKE9bm8LA+5fufGswEVP88H7lCrclKjneOnEPm7jPrZl8IB5onllLXNV6EApFDzbGYJizxb7sU7fsnZWrRrH+LmR9l5Ob1Xm/A8PllOw7fpSZd6ElJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087930; c=relaxed/simple;
	bh=h/dX79Ug9Oi3tujE3kBQvUZhpb3YBGEldYjvJeJj7aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5s7ZTkgIjQIgEXgdW7a+62drEJs22wm/5vyERjn8B23pnynl4XGMQCd+QHduzJEiEjSuojMuAF0xVyH+6HwDbdEnv4YXLD+rXjcbJba7HmzcpYkE2d0kj3xe67eAObYOz240/XCb6bNzE92U+YYi0GgyZNDiXXuKfu8yJfxft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VZU/qT8j; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e5fbc40239so1444392b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087927; x=1731692727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUX+L5JwxoRfm7kNG+SFpzZJbOBH//rHSLdNBno0i1Q=;
        b=VZU/qT8jfM7UKd24qGemIn5WxcnpKaeCOMFNBN8OmayrRBIHFiIwd9+93PuaVMpQBu
         XMnWCpFPKTbt9mq+1A7H1kijoTdfbL4+T9rII7mrxs6ZoUbE1gp3MuLVfJrlX1gezUC3
         yGoUItauFIepN7uRqMKR2p/W90YUDDOpDMjM0aGZlqbsHos3FDCgcfnlBjek900Hl9nF
         Z/1+IScrJ2TIKAAS/Evcva5gcA1/ANLNPnOUpzeSWt3AshRY54+Lc3WO+Qp4MYNSIS2z
         gecTAK7aqM7uIoOuf+LzHQXWJVncodbGpeRllHTGBGCftP9vclTsF0TakK2ZeRb/V22T
         k9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087927; x=1731692727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUX+L5JwxoRfm7kNG+SFpzZJbOBH//rHSLdNBno0i1Q=;
        b=iPEclkQotTSXyXHox0fkMfvpqP+MfV8arVv2YEPPQ8TZtxhL7ntxU3Inwq0KXKYFxw
         shXRmUbAJKRozNTP8Q1fCciLUtE09XLYnUXcuOwUMv2ssgJJZqKUdqsRx/p2GpsZ/kGp
         +EXWysx72nv0yIeJ2n9oHV/FoEeiB6WaEuso6NhUywD1JkpsSQ+b0QNUKe7yMVz3gZu+
         6EdOxtQCDl9zSQ9bv6idhaxDJrEuoC6ysBzAiDLjfaFkED0b3eCZoQGrjWpQa3z8futQ
         J376eMT5fByTV2/p37UlSeYBI5fxgQRVo9OxLrpfEaNvsaEyPT/HsG9hXNGKSQGVWt1m
         4NNw==
X-Forwarded-Encrypted: i=1; AJvYcCXoHeatzLfrQAdgCLI4Lf+mge2uhm1j/7Kjr+hUx+KmV94crwyB/IvYnEuLtdBcfSEEGDggdq6KFeQqg3WV@vger.kernel.org
X-Gm-Message-State: AOJu0YzOEJfWl+0U8ioKO3ps9CH9wdorspzsOvVhhMZFtZySsm5xY/YH
	wlUdHGSvOuyvA0bauwrPJya/wHXwd5oDvXjDvCAgxBePn30gA9IXqYeSYB4wH5o=
X-Google-Smtp-Source: AGHT+IEeKABK38xxsKod0vZKixk/J7Qylyl5MmSX7mHW/jyfME5Ez4w2eu08IqUOJbkoLHt8qw1oZw==
X-Received: by 2002:a05:6808:16a1:b0:3e7:63ce:1f26 with SMTP id 5614622812f47-3e7946a678fmr4543740b6e.24.1731087927472;
        Fri, 08 Nov 2024 09:45:27 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/13] mm/filemap: make buffered writes work with RWF_UNCACHED
Date: Fri,  8 Nov 2024 10:43:33 -0700
Message-ID: <20241108174505.1214230-11-axboe@kernel.dk>
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

If RWF_UNCACHED is set for a write, mark the folios being written with
drop_writeback. Then writeback completion will drop the pages. The
write_iter handler simply kicks off writeback for the pages, and
writeback completion will take care of the rest.

This provides similar benefits to using RWF_UNCACHED with reads. Testing
buffered writes on 32 files:

writing bs 65536, uncached 0
  1s: 196035MB/sec, MB=196035
  2s: 132308MB/sec, MB=328147
  3s: 132438MB/sec, MB=460586
  4s: 116528MB/sec, MB=577115
  5s: 103898MB/sec, MB=681014
  6s: 108893MB/sec, MB=789907
  7s: 99678MB/sec, MB=889586
  8s: 106545MB/sec, MB=996132
  9s: 106826MB/sec, MB=1102958
 10s: 101544MB/sec, MB=1204503
 11s: 111044MB/sec, MB=1315548
 12s: 124257MB/sec, MB=1441121
 13s: 116031MB/sec, MB=1557153
 14s: 114540MB/sec, MB=1671694
 15s: 115011MB/sec, MB=1786705
 16s: 115260MB/sec, MB=1901966
 17s: 116068MB/sec, MB=2018034
 18s: 116096MB/sec, MB=2134131

where it's quite obvious where the page cache filled, and performance
dropped from to about half of where it started, settling in at around
115GB/sec. Meanwhile, 32 kswapds were running full steam trying to
reclaim pages.

Running the same test with uncached buffered writes:

writing bs 65536, uncached 1
  1s: 198974MB/sec
  2s: 189618MB/sec
  3s: 193601MB/sec
  4s: 188582MB/sec
  5s: 193487MB/sec
  6s: 188341MB/sec
  7s: 194325MB/sec
  8s: 188114MB/sec
  9s: 192740MB/sec
 10s: 189206MB/sec
 11s: 193442MB/sec
 12s: 189659MB/sec
 13s: 191732MB/sec
 14s: 190701MB/sec
 15s: 191789MB/sec
 16s: 191259MB/sec
 17s: 190613MB/sec
 18s: 191951MB/sec

and the behavior is fully predictable, performing the same throughout
even after the page cache would otherwise have fully filled with dirty
data. It's also about 65% faster, and using half the CPU of the system
compared to the normal buffered write.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1e455ca872b5..d4c5928c5e2a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1610,6 +1610,8 @@ EXPORT_SYMBOL(folio_wait_private_2_killable);
  */
 void folio_end_writeback(struct folio *folio)
 {
+	bool folio_uncached;
+
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
 	/*
@@ -1631,6 +1633,7 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
+	folio_uncached = folio_test_clear_uncached(folio);
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 	acct_reclaim_writeback(folio);
@@ -1639,12 +1642,10 @@ void folio_end_writeback(struct folio *folio)
 	 * If folio is marked as uncached, then pages should be dropped when
 	 * writeback completes. Do that now.
 	 */
-	if (folio_test_uncached(folio)) {
-		folio_lock(folio);
-		if (invalidate_complete_folio2(folio->mapping, folio, 0))
-			folio_clear_uncached(folio);
+	if (folio_uncached && folio_trylock(folio)) {
+		if (folio->mapping)
+			invalidate_complete_folio2(folio->mapping, folio, 0);
 		folio_unlock(folio);
-
 	}
 	folio_put(folio);
 }
@@ -4082,6 +4083,9 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 		if (unlikely(status < 0))
 			break;
 
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			folio_set_uncached(folio);
+
 		offset = offset_in_folio(folio, pos);
 		if (bytes > folio_size(folio) - offset)
 			bytes = folio_size(folio) - offset;
@@ -4122,6 +4126,12 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 
 	if (!written)
 		return status;
+	if (iocb->ki_flags & IOCB_UNCACHED) {
+		/* kick off uncached writeback, completion will drop it */
+		__filemap_fdatawrite_range(mapping, iocb->ki_pos,
+						iocb->ki_pos + written,
+						WB_SYNC_NONE);
+	}
 	iocb->ki_pos += written;
 	return written;
 }
-- 
2.45.2


