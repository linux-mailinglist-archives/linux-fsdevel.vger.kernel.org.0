Return-Path: <linux-fsdevel+bounces-36358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BADA19E2355
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 16:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B158286F13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A07C1FDE2C;
	Tue,  3 Dec 2024 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HlbZFfOb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464AC1FC0EC
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239973; cv=none; b=edazf/fPlUh4A+3UhTURDqUbhgGVPqztZVGp4Py8zGdOhTVP1sCm7cBhmsChl/B8XT8BFaaajkMBPB00a4EWvAMOZz4XX3axy5TdPzY718+C22/uYUKyVZsi1LFHRFGXvKwdKr2re3p8PdQvat8wxt9der6oomnJ/qu0USi08pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239973; c=relaxed/simple;
	bh=ZgRCLG7Q7PSJRuEf4S9CorJsUog68v6zrN1kia1bNYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miuAwY8KODoywbwaVM4P/C62NkSZ+XgBKJh6BKtecDMhVPkxlBsz0DWxP2MVHxWVpfx/EqdDJl94cGCqi5meMzD2FHdJxpwMnfpNxMf8BrRf7A76bi603qPx8rnfy2wYTtd6i4xx7QEdDEXS9jHUtieNu1FL07+nUtdHMjUwFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HlbZFfOb; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ea4acd3ed2so2426260b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239971; x=1733844771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwN531wgOLFM8EGeUWgrWwcMRYwBcN09BWbzS6SO3q8=;
        b=HlbZFfObU5xPz5v+qTCn8lR2qgozqdYGlOM6PCCDOyas9I5SUWycbDVa/ntlFyBsP7
         Tacye40HugiN1g7Ivs1sfvOw6hcUV3WWcMJIa4YzOCvQSZOgiYlXKyqJMkv2bJ2jx6Mp
         rFeFWrfv8hwWjtYJDXSIazfJvDE3BP9wj7ZW08hxgjnTWTueZ8F3F7q2OURNwyjlcId6
         +kyiwEtLqI7qmrkhimyRvSTNrFnjKXMkBKJMyFWkvPnoZZO2uMtWhL+VlgUSCNaNLTib
         N1p3geFG+eZWKu4UwIl2bfFNsZC8pmu4MC6DYRvW1kvVQZ5my8P3Xc64YrxHhdW/27Qe
         mUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239971; x=1733844771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwN531wgOLFM8EGeUWgrWwcMRYwBcN09BWbzS6SO3q8=;
        b=PE/dr5VD8u12qMFLAls9P+PEmR4iMXGk5a3c1Q7LBGVW+58pPR2MVW8N35Gck+yvrX
         /RGhH369fDOcWbsKuB3k3dnmA9Uo7Qp6L8OPWkRaZJsFhpyfW4z7ZOupZPI+z3DyNNmG
         DG/oYslGF41+5uAEMLahkeCE4SWjb/OnCkYksZ5BfqTiBE0js2dDmfM1+DBvGEDDpmUZ
         PK+YA3fRXcgxF/RV8PonLrbtdbWPnpcZlPuim74W+OX68LY88UyL9fBfwi5f8lHJqYPY
         IZ+Dnl7lkdnbmADNYH38+pv6bIlfLREjALJ8m84rVOFXiWgupmzBBomtuKb0be/xG9s2
         D8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVdvsQA+vUwUbMltozKPbBbq196RZozoMTNjXZyy8d0GpXI9QY9RqKuk0+76Nabjo/iiFK5S6Das9xpUvCa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CXTGEloNYU3QzKs81yWpxKypYXX26N1jV6Iwn3GVxWbjcN8i
	yn2X4Y0iCIcO20N3GahlYsHFcptEsdZYoR1hBDVyHeJmjZ7H4BKXrS27QFM3dfc=
X-Gm-Gg: ASbGnctpmfUjfZXysX/ElA/RNiLbsWSW/ZjEZqX1iCVT1+b5mhU8+RgUCrkIKfwBPYZ
	vRQPvNrEOO6YyitmtQYs4CL71XEnKrZn5/bom0PRFG4anVNAsL6BaavzdN7fo+Fg0EgZ6goOcLq
	nPmNWjEh05HkkBp3wQMrjQ6d0/sW1Ma5Cwrx9wNktLCGEU+lNNOBRaXz4TaTTq4xl1ZqBVF+F72
	8j6iGpHfP0mZd94dmm2BkoIUWCFvgk6HDAutn137Oq5WJM6HwQZSyFHI44=
X-Google-Smtp-Source: AGHT+IF9UmPrglgGWAW3JFFN5BU2DOVhhB7roaz8QIV4CUJFyvDEFcQOUcjiZ4xJCcSYYgdgH9P94g==
X-Received: by 2002:a05:6808:1405:b0:3e0:c13:9837 with SMTP id 5614622812f47-3eaf041efccmr453615b6e.37.1733239971292;
        Tue, 03 Dec 2024 07:32:51 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:50 -0800 (PST)
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
Subject: [PATCH 04/12] mm/readahead: add readahead_control->uncached member
Date: Tue,  3 Dec 2024 08:31:40 -0700
Message-ID: <20241203153232.92224-6-axboe@kernel.dk>
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

If ractl->uncached is set to true, then folios created are marked as
uncached as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 1 +
 mm/readahead.c          | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bcf0865a38ae..72b03b37c265 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1353,6 +1353,7 @@ struct readahead_control {
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
+	bool uncached;
 	bool _workingset;
 	unsigned long _pflags;
 };
diff --git a/mm/readahead.c b/mm/readahead.c
index 8424bf1b67e2..33a2d0feae14 100644
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


