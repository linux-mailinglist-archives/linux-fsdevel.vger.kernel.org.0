Return-Path: <linux-fsdevel+bounces-37330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A405F9F118C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FC8164ECD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB4D1E47C9;
	Fri, 13 Dec 2024 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gn/n6u5x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F091E378C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105370; cv=none; b=lD8A1dzmIiz8xdPdJlDMxm5M5UWVLMZXv+LWS+7Hzy6X+mc8TTwuMq+fdYW/klD5mp84oDy+OqdYV6mOKojAzrHMkUgelkZ07nbS4vtMKh2xGEhIrbVEkyARaf0GZBoPU10YZbpykAHVUqakL5uioBhZPyP2eSEtNYcpJ4E0sZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105370; c=relaxed/simple;
	bh=VkQhoZOrHyZykna0hJTs0oX+MEpAmUB5ySWSsyus/GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TU6BI/OYE8Gf2K12zci94HMSqrwcx1KN0eCFAlzywynPe8sgx5P26TCHWKBHTMgHSdNLYKN4JQE9ngZITs1kYMc/Rr/wHOWnNQJ76+fyDxqlILnmm10S0cP3HjW4QdNVRFLM9BKg4C1j/CfuCHNN4J+LMsG3kqNY8iN1f+zN0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gn/n6u5x; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a7d7c1b190so6594985ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105367; x=1734710167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpcNvbMq6OW5fN6dnGRgZf80nNArt3mFYuYvhVaSlK4=;
        b=gn/n6u5x+8hDMuHR9n/5QfPXMLgtc2zKUHy8C+LfAqaUiOzmGwTZOzXpER2DEDaeCp
         aCAv0YyN8aZKftlj6NdlPXwUmC1l+aa8oYNf+33hv3rMpHWk9kwA503Yt9fZc5iX3jXj
         dQLybLF63c9Dn8jA2HcluDYFbK6zH4FA/7484s0VSlYmd3YMq9pYKVyuYzFMK00haI+4
         y8QHfpiUia/RXDAakqyqO2974gWkFeBOMDHuObf5MJuKoa9/gXHUxOFeVAFCqeySQR8y
         u5rgZrAp3Y9cIkD0chUiE628vi1g/Kqo1BzRRoI3EBGmWvBPOOL6zOQfq4b4RdzMU44S
         6uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105367; x=1734710167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpcNvbMq6OW5fN6dnGRgZf80nNArt3mFYuYvhVaSlK4=;
        b=m6z2tyBJWFMOJUgVo6jJRfh4eCE3GQ8N/RN9fHoMLFX/A4Ll6KAivQ0yRJXxMNG4IL
         wQK+cSRJFt8KNXPd5WeNEwKKBy8+H4IVNL2SuyJ7vToFjs4cXYsZAOqG9xUmyQd82TAr
         OtEXQvE5NFofxQWatcw+4xS0F7D2YM1/4Nfjt8TcBDn1I09BZ6jq5HnxrT+PSSC/xMHk
         blMD+tmJhN4LMbSO1q76XRtvHI3CtSbcDV+5hYFm4VWEVvufGdnoPGY033M/SvOJVEB3
         pE/Cb0k4CCqaBGokj1lzM9sImI3KbDk+zfRbHT0Vc+1hLpXQzB990ewI0C/muDsuclZv
         JXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTyQD9T50iiUsqyvcuLEP/qYhqZr34TC5ZJHj4s1tWKxIHJAK01AcWG/ZhEK9J3G8W2J5kVkyY4Cfd8js5@vger.kernel.org
X-Gm-Message-State: AOJu0YxWskG3S/UpAodiUjGuTXsdEnMW1lrEYHOPFCDbmXCjaZYctESl
	UdWEsc4b8rLeXABhMI8ETf76p+ye7LBdRC8zyNFhZpJtiItw1eZt1RGRb9XjLmI=
X-Gm-Gg: ASbGncvT9/I3QmHjGYXD3lnnxhCB4Jncx7rgO3tl2zzih0rD8clVSV2DcADSMuXx0Ez
	jdzuf9DO4YQSNCH3hCHPWasep2qLCvx+ks5GMh9MMxAhRMpZqEacxx/RTg/WM+7/ecxjLpmwo/5
	GmweIOprbDnAJmmX7iUkzAiJCupK72tx4b1ixn4WEY+vFp1XdrOMkcalKBty9ox1C91MP0GfhGH
	2fgl49xxgwZobaZ20QxAgVJAlIecOh0Hh9XYzI+b+kFr2KtMlvBTFRMlgMM
X-Google-Smtp-Source: AGHT+IFWkhf2olmYWP9+u8WH9KgVfslThGYwEFiU2/KIyOObE8orPa/AadsJR4yt5f2xYXvlvdRoMg==
X-Received: by 2002:a05:6e02:1a07:b0:3a7:e4c7:ad18 with SMTP id e9e14a558f8ab-3aff80107a2mr31899055ab.18.1734105367708;
        Fri, 13 Dec 2024 07:56:07 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:07 -0800 (PST)
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
Subject: [PATCH 03/11] mm/readahead: add folio allocation helper
Date: Fri, 13 Dec 2024 08:55:17 -0700
Message-ID: <20241213155557.105419-4-axboe@kernel.dk>
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

Just a wrapper around filemap_alloc_folio() for now, but add it in
preparation for modifying the folio based on the 'ractl' being passed
in.

No functional changes in this patch.

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


