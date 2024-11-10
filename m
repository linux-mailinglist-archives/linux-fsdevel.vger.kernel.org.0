Return-Path: <linux-fsdevel+bounces-34150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4869C332A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 16:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9F91C20A5E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6655D13F43B;
	Sun, 10 Nov 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qmYWEuXR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E0139579
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252562; cv=none; b=sfhne75USlmyfsGSEArQn5eHGiXEFcDt3pc+im2MJwdyo3V4/lJui/IEDoFwp0q1FJeopRkPCqUp/Fta9cFZVHieOvjP+vn3Y5wbHOn/Ym6ppz9xbUS4UOJI1tR4cFHL8e0NzK9XrzcNw1TiR2PAkNwXMw+/mD82DkHhrLF9Km8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252562; c=relaxed/simple;
	bh=FAuL9fA2byaQyHKz3osLBcHrpXlsfUGCQq+TdYUSPV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxQSxlbbo44Ile806WCvZDyghMJfPfJualYo1VsIXgIYcOAmistEikXJZHDagopgGFHgqtn2NHdUvU1Kc8+W9fEghn43Frdgfccz8yCavdscSpUvH9maDMFso0hnlCnmspiw+ZIU7uGmK7wM6DpHgzuBgGexG5pC//hcrFmYmLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qmYWEuXR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c803787abso30229965ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252560; x=1731857360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uN7tjL2s/tmxM6CJqz4ta5HuqLPCPNJgi5Uvj68apZw=;
        b=qmYWEuXR0dF4ao1qm23FHBkC1KFFPpXHCNxeCrVBSTu51G7sJ5NGRSHFiR/HEauAil
         1bKE3AArI9plvFqdKod2vE1CxWBDCIPEvDdX8U3IE6Gmpu8W726qKIzA2pAqf75aHTw0
         jNvaw6j86lAd8mX/79Ko2mKpI/5phTJOF7cGf+OA/QgV8fCts5OTxY7Ij3SYr3YQocl7
         yPhrMab/vSExHReUDUim/U3rWGDLxsxkQe2y6fpSqhCE+A4Kd2ksgIayFprt4TuRAMJn
         XZsVkotq+HbOlVYdMp721vkbPTcIAWNiF1Bh5o8yvOOcoriMu5eu4xtCMNtFkWxUhsie
         d6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252560; x=1731857360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN7tjL2s/tmxM6CJqz4ta5HuqLPCPNJgi5Uvj68apZw=;
        b=m9LNQpIWIyEnAv5p8uhr1h+nJpFkVyD0Gn7Hf9BnIoUmBZrVjaHKDtBhgi1ETiOVPR
         dMCx2rxDLkXEYZQ2aB8evIVZHCMSw3pawYmbXzpLLljctFwO1BLvW/bTrOT68ZGCNTmQ
         yzo/c4V9UkKI0O9zCtZAcXh6qQbwM184WwCoOKA+rMTwDZFFehaiJSqSlDgjAQNWBqQL
         3HAizXbKHx/8nSd830l4fnhk1ta77oP2MczGaW/Ibd7ygut4H8dt8BUnQYOB25kJwyTz
         NbEb6QmRxvq5OHqY07oOTXT0gI5PAt23wGvBHI6fKE2Tcyb1X+qGRLCjPasQQoqJ2jME
         ZHyg==
X-Forwarded-Encrypted: i=1; AJvYcCWPCAp2KdStbQ8FQqQwVtMSL5d5zluPqg0Hp0BHwoNtV8GtZ2+Y3vXCFNvXbvqUiGRMNiNH/6qxRXscFc9z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Pyd0UbxQttSWJ4teyMQCJ27iIzgFX3m9zHO0AXIz7KmdPuGW
	vGI33uGGuBszGiR4CsLsLcWbuzuiEzDcBpGG/Cnrhs81JKykrFuV+9AKnS7wkR4=
X-Google-Smtp-Source: AGHT+IEPVPrIsvzVKM9BRnKywqUBY+49ysTGl3h3gnVcSq9byO4UW1dwGcp/l7t7WWnOfvV7vMqjdA==
X-Received: by 2002:a17:902:e812:b0:20c:f6c5:7f6c with SMTP id d9443c01a7336-211821c4546mr156324045ad.16.1731252560665;
        Sun, 10 Nov 2024 07:29:20 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/15] mm/filemap: use page_cache_sync_ra() to kick off read-ahead
Date: Sun, 10 Nov 2024 08:27:57 -0700
Message-ID: <20241110152906.1747545-6-axboe@kernel.dk>
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

Rather than use the page_cache_sync_readahead() helper, define our own
ractl and use page_cache_sync_ra() directly. In preparation for needing
to modify ractl inside filemap_get_pages().

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0b187938b999..38dc94b761b7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2528,7 +2528,6 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
-	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
 	struct folio *folio;
@@ -2543,12 +2542,13 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 
 	filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	if (!folio_batch_count(fbatch)) {
+		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
+
 		if (iocb->ki_flags & IOCB_NOIO)
 			return -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags = memalloc_noio_save();
-		page_cache_sync_readahead(mapping, ra, filp, index,
-				last_index - index);
+		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			memalloc_noio_restore(flags);
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
-- 
2.45.2


