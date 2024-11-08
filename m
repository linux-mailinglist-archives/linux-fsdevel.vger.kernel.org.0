Return-Path: <linux-fsdevel+bounces-34069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0D39C2442
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3011FB27622
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764C9219E32;
	Fri,  8 Nov 2024 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JMj52MHi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF41F26C4
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087918; cv=none; b=o+AV3ta3UhQyQTPRdXxtY4D8akVZcZxWpBCCt6v8pihR+gZkMGvdZPbSO7L0I1BKqGiJ5rgrZDLSdZq7FSC7jitgAR28Ea+CE4Ls1AlspXd1SaKPE0zTJpuNiEFDIYmDX8Zl287YiPETx7f3bCIZbLJTyr5D0Uc3TxAkqSq8O0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087918; c=relaxed/simple;
	bh=wdE7j3SXsvf8mZ3WLeO9bDbqT1xBl9uoI5Ta1MifPnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvqRiR0R/KQYClcL6ya1AjCuEpoHxLhaQyDdmBuorURoPif6hxdBkmET6j56pcfTD64HpOTj5drnzQc0Ygwa2OXCJ2X51bNKuez8GMm9L8QmlAGDWqwCAd7c91P0O/+a9xJ9GSeL9oX5vAu1IshYAmWWOYCkpDJdROJT30SHojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JMj52MHi; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e5ffea2699so1540190b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087916; x=1731692716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7YIma1TSdS4GVKncfhre22V8DGIHalzmKUoqzgwI0E=;
        b=JMj52MHiupzV+QyEZ8xQQuhgCgXAUk4SMreGJBReimFtWo7WbHzumZ8skKIG5nMs8s
         8lIjkkEMN2bE2vaekbNtF4hmIhCrPgL7BWlBcejDcpxEnTAnYSXb1coJGpECPxiZ6i44
         TGLKfhpxcqJd+ZhogjATbLP8KhGEp1tw2o0UrpioybOGRfcceoOTRoMpIMbehLlDCYDG
         J5I5bvrpH04WaJ/WQ76sj8WcCzXyrOAGqGCCnY/XdQMpAEJeMBa38QJjyhpIQefp5REn
         xzb2BDJ9ckAb1q1wqZc8s1t/1cGucPE/skLRTNQubDsewS+d4vLFUWA19uRHpvTrtkch
         XuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087916; x=1731692716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7YIma1TSdS4GVKncfhre22V8DGIHalzmKUoqzgwI0E=;
        b=rbnioEvNkv55ME63fbq3k25yCTeHSSDqWQ918kUM3aTDpk/hhoOslDdYkxRTm82LYH
         iHjpXaRuRibmzsZ6wMfnEsTxzri6T5Ms53G5CzWIsgALXc1jYLJ7eo3Ua1ctBZEr/60e
         6UDsvyjeYXFDezG8/Raxd17J5Q5mbgZ/r5CnQ74YN+LgVy0nxmGE1hAfOkkhQxXb6GZ+
         sOnUfNynmSIxKkC7M8xGq0xRb7YQy/1oFqVkG7RfR7AwQL9F6jrL6XKUUaSAb4ZO6Yq6
         h4FIeUODFWrBmd0myyQJu6L+To0gltThzDd6D9swhpsRt5892s0Kx0Ap8IGbFYhgeRt1
         t69Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeMKLEFfGymNBjbDEcgeEFYyI4PcH2Jvt/I9PgsHIo6+3LlTzNP1J0v+4Srwhl98tuxPNEhwc+wNLd6E93@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0TsHR7ySSreRsFpYliWe6Kl1Ov2/93DP1F8FHDYJqel2KTnbE
	z0VFnZ7HdrFyx9k+m4LEjtdhNuilaTQ0YyWYP4uidmGq/s207CKDog6cXCSCCXI6execB/RtLHl
	ONvg=
X-Google-Smtp-Source: AGHT+IE9yyGg7trloxg8/sxB/5Qab0oFpLsLqTwz8oiFcGSIzzHT5q20m9z/5W6tquS0Nz/aDzjCkA==
X-Received: by 2002:a05:6808:148f:b0:3e5:f9e9:43c4 with SMTP id 5614622812f47-3e794dc5b57mr2378031b6e.18.1731087916223;
        Fri, 08 Nov 2024 09:45:16 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/13] mm/readahead: add folio allocation helper
Date: Fri,  8 Nov 2024 10:43:25 -0700
Message-ID: <20241108174505.1214230-3-axboe@kernel.dk>
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


