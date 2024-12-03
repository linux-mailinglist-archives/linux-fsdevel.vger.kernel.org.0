Return-Path: <linux-fsdevel+bounces-36356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A519E2393
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 16:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A639216D608
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 15:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E941FBCB5;
	Tue,  3 Dec 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vI3+LtaN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432171F9418
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239970; cv=none; b=i42mc3z9nFbbCmTk9Y5T/a8qsbSPAG+nkiSIaDWRsjZ+EFo//luaPvPZeofYZaULB8//nX0fIcFdvqbt6y1ddSEevVW77kQAhgr6SpEEJHyHP53toYamD5W2N6Tu+hKnpBL6Hrzkl8yaAFMFGBGWS93iD1rAvDhrFV+4IdO8Q/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239970; c=relaxed/simple;
	bh=8Bb0MfS/J32mJVu/hCpTfSTIXsQUeZKlcznJ/+p92u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/FCSpcd7YV6WcaOrcu0z9UnZSDueDqmHrCniihuCCLzdD8yJxx1tPNpAvKrAC31zU6UobWiGgumMGRLLKWNAVyj5IIAohUTa6Vd77iJchTGPkpUAlpikV3yLa6HMESjU+JDf1J8osG5sYblXNJV06yEsb5lwJ7q3OGhBqq0XjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vI3+LtaN; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ea47869282so3048698b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 07:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239968; x=1733844768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mQz2vdNaN9LdJ9L4qyJBm7ibQRSfX5SzH0nqDyaIZA=;
        b=vI3+LtaNq/TnQ0w9S52h9H8vdWp5zjIWm4vmECGM4OLUaQkVfjYLWSZeBzwm8RkN+t
         QZBOBOs37SFN0AXY4lgL8QvsA+LIbBOvJy3jYzYBEf0DFjOW2Or/4MqeT4sUsqcdyKxH
         krxdvKTFDTUK4+uMvXVKGrP0QdooVKLGOdsjyPFAGiaROrSAHqUKPQqb2Esm7zmu755q
         L3snlWcVxQRYPSKR05GHn/anLu77M0zcXS+LauovAaCJGM/WjuKY9xah6ct2oTdUJ2vf
         7xoXj9DChXxJKIhOnduYaKYh1Aiuwk/HeB70IdkRDyMFoj6lCcMhzdBpqWm16E2K/Wkb
         URNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239968; x=1733844768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mQz2vdNaN9LdJ9L4qyJBm7ibQRSfX5SzH0nqDyaIZA=;
        b=nRvbfH523Rw3aQpTfdxVUYtuzoa9n8GosVTojJHarC7kY2ERMO1H/ZwIRYtf5MdL8F
         S0ovucfYjqD3VPeJpdu/xzxqXyHsyjUh9e7IRdrsEzzRLp0sOXm02sG+Hqg8fUaSuR6O
         MQF2yT5GXddJClnCBoSdSyFFXjfIcKKubHW7Wn0yuUNB1Nsg6V5jG4zZ3zadhUCl5Lsa
         x/8mX7ZmH27Q/Q0EjnaCKAfyM8gIJsnOEcjrRVj7o4i9rTs2fpydqVKcsIR1N3FYLM8T
         djcjY27S6ILtVjFaVT6DYldckO4iPxrM1j2hXqTDo9Rm7WWxPMpxnn1uL4x2PM9BHAC/
         9aLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4hfpXAF2x32mFk28ReMErE3Wf1BBIyQmkh0EYPQmtQVNvMqAjupARDxBONpioHuEloX8U167U6ZPxhSfM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZMVR/d7X0vts5rrfJxD3SO9tSDH1cdK06ve0wA5/4t5tE2vm
	cQ2yoDtb3PW55ru3mskwKH0qU3U5SMtOt/Dp4rWVHegwoYZjbmaFHzz0uwmmPzkFnmw4BR3BGxk
	3
X-Gm-Gg: ASbGncsajcP2UujNb7A+Upk+1IlW2cybxgjzxS70DkyPf9xb8VTAcHFKBygsA/iWrie
	0ZKjs/zrsE+Sx3Tka50gp7PsSJDBEpNqCnfhncHGON4iOazg59bVvolIBz0TGZkul6aliBjzVhq
	modlQRL2NJi5TJM5aShJ4TOMFHdO2kX7+JCdTYteJPe6lxfrZ7RFi5zLmIWqngGFY6qjeGHEtnu
	V3RPSSWBjyT5GMF3Yf6tuglynQ/2cSQWo/We2+fYdEkR9wyYAo5PaINkcM=
X-Google-Smtp-Source: AGHT+IFPC3QIjfGmFueYpArbFjHsCE/nJs1cTRfjgQkZc7hdX+t3EH5eMgGO4h5vvPNqW5LyAgQfEA==
X-Received: by 2002:a05:6808:1454:b0:3ea:45d1:de13 with SMTP id 5614622812f47-3eae499b2b5mr1606169b6e.11.1733239968341;
        Tue, 03 Dec 2024 07:32:48 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:47 -0800 (PST)
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
Subject: [PATCH 02/12] mm/readahead: add folio allocation helper
Date: Tue,  3 Dec 2024 08:31:38 -0700
Message-ID: <20241203153232.92224-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203153232.92224-2-axboe@kernel.dk>
References: <20241203153232.92224-2-axboe@kernel.dk>
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
index 8f1cf599b572..8424bf1b67e2 100644
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
@@ -751,7 +757,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
@@ -780,7 +786,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
-- 
2.45.2


