Return-Path: <linux-fsdevel+bounces-37955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A3E9F95C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE3D16A6CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D192F21A931;
	Fri, 20 Dec 2024 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nQV3wjDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5D219A77
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709722; cv=none; b=B2zSuThE9QnnYRcMTCJgq9aOYqA5ftsAz9R7MrMVBP7/xhgJA8vZNJc7YWBZ0oCpaSae15EehxMx9vymT9Jj0lFEU4kuwsvAfOX3Ysz5n5coHCrhDsniCuNCd2tj+37t+26T867F7nyqJ6EQjClJsu83uXrLy7bBtyD3HgKKa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709722; c=relaxed/simple;
	bh=gjkhKuIh/F81dbqkaKljfYc7jS3icLdyh4zFI+rhjmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASudJ0V5XA/MYqCU2KPvamDWJ2FZOEVYv6HYLXmMdAkcfdp+HZtHpph6YZoh/dd99oFMAU+L+gC/XDYOhh0iYIyavhXV4Bim45l8PDGSXPG8DHOme7FhJYmLe9q9q+vfr++Dvdgf37ErKc3rxnbRF3bz5kMB1pPK3VEuZ8P5OFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nQV3wjDc; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a9cee9d741so13093275ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734709719; x=1735314519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1i1r3ArZkX2vgdPDoEq+WK9gDY1/MkPULwwiAP9Trg=;
        b=nQV3wjDcNTgJ4GchyVBCil7RWw3kEBcqovSCDdq407h+Fp4OUxJAHtkRzl7caMbOCW
         QUQRa9it6AvF+DPyJKC/Ng6Z4LxF7LYXb+fH1HP/8nLspS7vc3ZXjwC5ajUz6lVsIiCb
         waUtyWQBb+MkdhbP45bVZvLRmdt7yUnioSorXOs7kFcjTfDlw/5Z3RAkJRxGSPf0dXRx
         4nL3ElUqrA7V22XHs9Ce1OtmnqPRTrETi53u+6od7ScPx3Yq+9UlkO+rMKBMzBN5N/ee
         GShvNHmHpXUyQfioJXe2VWYi+wLENkEgj/k3X2561CHf2sI0cTpR8qcX9UIxsHNGWxG9
         JEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709719; x=1735314519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1i1r3ArZkX2vgdPDoEq+WK9gDY1/MkPULwwiAP9Trg=;
        b=MzGirhVMc8vJj+9ALlNRkWNeYfiolnV1tB5g521i6hp5thSJUBinRLSOjMDy+OTRCN
         HbJD9hvHRpNU5ZBBDAIGJbrUFAHYOs6ioApuoqPk1j55cuYMqNrqcsMCwWnVUDOg+W3J
         /UnxnJaoyRq1JxF1uzzO97d9YCc8GAAvY7GZHP+4msQmgM5Yb0TtloT3Vmx54KufIKQi
         JxzfD9JAzdHvvzc0qLStZZ4/g8FoTDRT6yGZthFEzFX4AKJWzn1MnB3n/E9bjuViKWZ4
         CTDiAaD6e6NBG0FC0x0BLKB0a3q1m88VarEfDjTvGCbSQ5QNvW1WCKTe1nj+xJn0oh56
         H6yg==
X-Forwarded-Encrypted: i=1; AJvYcCUNZff0HTDz5908KeYzIIJM0LNJqgihB3Yf3FQgc2d9keTfwfiNNBFqLA4vsS/jpxKlValcjanlRPp30N88@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3z5Gws/MChkU9TJy2DGASs2DUAtAanMoKODqGMN0tY84Z5kns
	IPjB/a/D8fWnKKJPa8usNuLrZW7xHVCT/RfWjXbBJYQE8+cusBRmdk6mVwhdt/o=
X-Gm-Gg: ASbGncuIaO7e5KfLL5jCJ5IoOUbSPry4k8DjQaT8CUhFdrKPVUatpo3U0ZbopxfSTTD
	Z+IPPzjgZH2VFEbMH7gH/ysyzRJ4P5VOxUYeVSIfzXkwGXRvGZsvMc3QQuIINqrP0TiFQIWEKLs
	T6vyvhlMWl+4IREtZT2nrglS0r996yN0AxQwSnA9DeROyFcpsWj5jPMOC9lOiN/no8hVBQAwQvG
	WGQfY+mITJQOJwcFviRVpw1Mjws8UcEUDuyueHYZHITYj3v1KzA/+2+L2GL
X-Google-Smtp-Source: AGHT+IEQ+rQahAFsMNf0wBgiaHc3ybkwynnm3ue1l0Cc7XmizswXF3l+0I9aVhCYoLyroOrTRrUFJg==
X-Received: by 2002:a05:6e02:1ca5:b0:3a7:88f2:cfa9 with SMTP id e9e14a558f8ab-3c2d2d50b1emr32075375ab.11.1734709719216;
        Fri, 20 Dec 2024 07:48:39 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66ed9sm837821173.45.2024.12.20.07.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:48:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 03/12] mm/readahead: add folio allocation helper
Date: Fri, 20 Dec 2024 08:47:41 -0700
Message-ID: <20241220154831.1086649-4-axboe@kernel.dk>
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

Just a wrapper around filemap_alloc_folio() for now, but add it in
preparation for modifying the folio based on the 'ractl' being passed
in.

No functional changes in this patch.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/readahead.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index ea650b8b02fb..8a62ad4106ff 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -188,6 +188,12 @@ static void read_pages(struct readahead_control *rac)
 	BUG_ON(readahead_count(rac));
 }
 
+static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
+				       gfp_t gfp_mask, unsigned int order)
+{
+	return filemap_alloc_folio(gfp_mask, order);
+}
+
 /**
  * page_cache_ra_unbounded - Start unchecked readahead.
  * @ractl: Readahead control.
@@ -265,8 +271,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask,
-					    mapping_min_folio_order(mapping));
+		folio = ractl_alloc_folio(ractl, gfp_mask,
+					mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 
@@ -436,7 +442,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 		pgoff_t mark, unsigned int order, gfp_t gfp)
 {
 	int err;
-	struct folio *folio = filemap_alloc_folio(gfp, order);
+	struct folio *folio = ractl_alloc_folio(ractl, gfp, order);
 
 	if (!folio)
 		return -ENOMEM;
@@ -750,7 +756,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
@@ -779,7 +785,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
-- 
2.45.2


