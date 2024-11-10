Return-Path: <linux-fsdevel+bounces-34149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857289C3329
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 16:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAA51C20A3E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0831013C695;
	Sun, 10 Nov 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ARRTGlBZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81C132139
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252562; cv=none; b=hGVuGXjipt5ge/X2Ze55EqU3ufbUfWqw59s246HtgxYOVqvcgXoog4ztP998B0DIGGlDhjQuIl94kMPVaklU1K9rxXTJ6Zzc6fcQjGB3xhcVfHL53Ijuh7WXqR+8enpH60qLQ48xJeAQsnPCJ/H7G63Vzg0VFkUALxgT4z5f9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252562; c=relaxed/simple;
	bh=AFLrZl3fH+/hMhwZTjgZ0OWM0ndgzDi220n1zUDQffQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBAh30OH2l+fiWXiTk83FMK+TKGQgv0/xz46TVKUZfMJny5lCPodkz/KWVZZaYz2BQs0tvYNBM9Bp0tct5OxJvAzk9WVxi8RO/dUOHedGX3D7WMCKrcv0iFx+Da8EkjA/0SyZZf4de3TsKVgT/Pz21A2ayDtcNBsOPlmnXzC9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ARRTGlBZ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso2824179a91.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252559; x=1731857359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvfAlDie45/dO/q2Oa4nMUlSYRbUQddnQckYeJvFoiA=;
        b=ARRTGlBZxa5PHUsy9Q2tvu9pwq5hBq6iX1QXmL76/dMi8cd4bCAVhakos3YMhFgzxM
         8L0F5BfA/KXHRhfZ+5fXXW3wO+YH7oZiJbghZtvvdOF1Zg0dWlXnAQOckFK6uHIOrq3z
         3NMgg2Uk3HgKDmBEeCB/W4yVCBuF5a4ovwOgYDiEaoqon8TL8jt9CPezX4OQe6P6/tzM
         ikqmm5eCnG3bBlPI7w9H0f6sQLZGCByWLUs7u9Oyw2wdxEPovJEXROlrYoUZnbU5Fdqa
         nQXK9H8GE4ofJDQVp3nVL/DVlViWOayXNDNydyF2FEB4EBCB1nAUJ48JW2/o7aE3jkDA
         OFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252559; x=1731857359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvfAlDie45/dO/q2Oa4nMUlSYRbUQddnQckYeJvFoiA=;
        b=NY6WbXU8SQuEblIpVqs2DU73IC4huhtGGWSq4Nr47kYIUcF1bMuaH1d5Eq1Of2Z99T
         uBSaePQTwzyEpCec5ESciD9czIE+Hvquiy97Q/ZEqwwFV8e8Vx397K2Kmoi9rsUshJiX
         pdiJSU3n+nwlIvDlrsWDGh++jhAZdU6+PTfgQSJXSZbw/aV6y6b4Zd2eN8s/CUcl0M9b
         BHj/u3Hvs9lnmvZGfmpWoVMhWRvIQH8OdLlaXAW2hgYVjQN5tYPMA23XoCz42Fkf9L0z
         i1s1NoPkrRTXtutX7wLWaMO9+jTamErmVJo3vjeeGsLqEe+YXB5hD5S+eYgaPNbukrgf
         xJtg==
X-Forwarded-Encrypted: i=1; AJvYcCVuTA3R0viYhYP3b0Xfo9P8vnbHec7aw22q91YPjH6a2XCtzlI/4LyoaDY7cZ2GDx0RlfmuqVzyOWF+pkHK@vger.kernel.org
X-Gm-Message-State: AOJu0YxuwosVx7o3RE2rs+zjY7klUpQb0RpWhWm158KSq/D2xI4pC3tj
	i2jiySLsLFKJjdkUi8Utr6xMu4l5VVWz/cs1XxhQWgI63MUzrwijKNG/sB1kZAM=
X-Google-Smtp-Source: AGHT+IGu/u+FhGsz3wBr1Zsic2L7vJ+0uwzRrgnEJRvL3npe1QZdpxBowle6ldDc43UF6F8F8hYjFQ==
X-Received: by 2002:a17:90b:2ecb:b0:2e5:5ab5:ba52 with SMTP id 98e67ed59e1d1-2e9b173f1ddmr13558707a91.20.1731252559257;
        Sun, 10 Nov 2024 07:29:19 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:18 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/15] mm/readahead: add readahead_control->uncached member
Date: Sun, 10 Nov 2024 08:27:56 -0700
Message-ID: <20241110152906.1747545-5-axboe@kernel.dk>
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

If ractl->uncached is set to true, then folios created are marked as
uncached as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 1 +
 mm/readahead.c          | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 68a5f1ff3301..8afacb7520d4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1350,6 +1350,7 @@ struct readahead_control {
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
+	bool uncached;
 	bool _workingset;
 	unsigned long _pflags;
 };
diff --git a/mm/readahead.c b/mm/readahead.c
index 003cfe79880d..8dbeab9bc1f0 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -191,7 +191,13 @@ static void read_pages(struct readahead_control *rac)
 static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 				       gfp_t gfp_mask, unsigned int order)
 {
-	return filemap_alloc_folio(gfp_mask, order);
+	struct folio *folio;
+
+	folio = filemap_alloc_folio(gfp_mask, order);
+	if (folio && ractl->uncached)
+		__folio_set_uncached(folio);
+
+	return folio;
 }
 
 /**
-- 
2.45.2


