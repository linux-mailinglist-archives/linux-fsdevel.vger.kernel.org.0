Return-Path: <linux-fsdevel+bounces-34804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CCA9C8EB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E890B30847
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B971865F6;
	Thu, 14 Nov 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WozBdVq6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273121779AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598087; cv=none; b=StYtOD6g2ZRyJsfQ4WJFbmk8SGdLaVuXbqjvMl8DY44y8Lt8l2o8iCIv8D3t175gQpVnLBxendzZFcYn5aMEcUrlBhWx8FL18ceUKkPSXEzWKmGtXTNSSEs6n8hnKn16UlxNrPNF5TjO/Z0EB/j9RbPS4Zlm9trQugAlQNS6AH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598087; c=relaxed/simple;
	bh=wdE7j3SXsvf8mZ3WLeO9bDbqT1xBl9uoI5Ta1MifPnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POXPw8gE8M5qza2KAxYGcbIhGtusosCUnNm0nije6IupbLKWvPJzfhwF1Ylb37blVxUkIWpXuEO55bQa25CKtYmCa30exmVdkeswwLaJKUeMpLyDIgr14VuiglyDwtc+yW9pegUTt9YYMnqAjGUVjYf9bRdxqXznP5jtzoQMn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WozBdVq6; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-28896d9d9deso297151fac.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 07:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598084; x=1732202884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7YIma1TSdS4GVKncfhre22V8DGIHalzmKUoqzgwI0E=;
        b=WozBdVq6+ts64ISVrUD0htZzkJRFsQUGcoy0p5TvGGvhIiOLyPBqdmNS+k2KHBZMO/
         Hj9faRp/lVI0Rw6prHQam9qjedB5YN0Sfcv9tVELjWjt/D5TWHZBYf1vkmszMLaS9zTY
         MvR8g59YCwEU9EPMxOKfY47jRGapmfGsMeVz32H1rPtXP5MxzatQgQ0YGCMvWqZKYxCS
         8YbTAGFJgAOlW7qaRFmWYGRMTlvQIEzCYB3iKGSbNqAM+V52Oar5wGGxtaadoriFkYqj
         vfnC+pgc2735Q5P2/7L2ShYY2bdsVZRFwpeSJMo1t1APojsbG1wG+NFlWYFen0B9YIZ3
         T8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598084; x=1732202884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7YIma1TSdS4GVKncfhre22V8DGIHalzmKUoqzgwI0E=;
        b=NqJbsnNs8CK6RirMz8CaNwFeQ0AbdOmObIIWnfiLN79mdNif/X6m13WvGxXW7WiZ5V
         9SPygP9MaGGfQ1Brkrte0SLKoJvgCIbVrPj5rYLgEESw/dG0u+M/oKDVO2NBfQZeHUlE
         +NS140Nw0l0dSGu/0tnGfABfbw1U2vIlYUh90pVTN0ND5nHPSe7yjQOIY+9uKn3dalyJ
         aO64dFRX8XiArZDtTKziVQSPb52c7mxrcJTg2HejN65jGHGf7riyzo/zY/VXJth0Qxdm
         0jX54UmOrQrvAErACWQrrmBXCmMuKL2f8gT3AJxAmSLUT7R8Mm1JPrSq4iHOFdW5Ewyz
         pACg==
X-Forwarded-Encrypted: i=1; AJvYcCXgBRDkj2qL0YffojKdRXjil66r9z0ivTDf6N0I2I7Tktof8wIG5aj9UxUZR5pCu32lfx5E/txxm4mZ/Xph@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7pD5bhi2wPtCiqA0NjNjWHjpUbJbgv4X4KvXueHyEvBVw+uW8
	wdps9vvex5LXORiKj3A+xd754AbD0RtqlVbTahjjClcUyqM3XhcLs0NZkh5LX4I=
X-Google-Smtp-Source: AGHT+IH6odaDwIdA82zwSIWff/OaVLT9OGNonkILORb6hdBpcBvYTtZBZw+TFEiCAtvLZtie7sKouQ==
X-Received: by 2002:a05:6870:5d8b:b0:277:e512:f27a with SMTP id 586e51a60fabf-295ccfd9242mr11462005fac.16.1731598084309;
        Thu, 14 Nov 2024 07:28:04 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:03 -0800 (PST)
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
Subject: [PATCH 02/17] mm/readahead: add folio allocation helper
Date: Thu, 14 Nov 2024 08:25:06 -0700
Message-ID: <20241114152743.2381672-4-axboe@kernel.dk>
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

Just a wrapper around filemap_alloc_folio() for now, but add it in
preparation for modifying the folio based on the 'ractl' being passed
in.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/readahead.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 3dc6c7a128dd..003cfe79880d 100644
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
@@ -260,8 +266,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask,
-					    mapping_min_folio_order(mapping));
+		folio = ractl_alloc_folio(ractl, gfp_mask,
+					mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 
@@ -431,7 +437,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 		pgoff_t mark, unsigned int order, gfp_t gfp)
 {
 	int err;
-	struct folio *folio = filemap_alloc_folio(gfp, order);
+	struct folio *folio = ractl_alloc_folio(ractl, gfp, order);
 
 	if (!folio)
 		return -ENOMEM;
@@ -753,7 +759,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
@@ -782,7 +788,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
-- 
2.45.2


