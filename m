Return-Path: <linux-fsdevel+bounces-34807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0B39C8E1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75871286EB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4491A16FF4E;
	Thu, 14 Nov 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rYyOesV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9418BBB4
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598091; cv=none; b=Ap2Gu7voh02mo+vMXEafMFM8c5rjsiBoHKydT2oWbkt7hbcGHQ0aOVhsI4w2bLsUuVeB7MILLeBh8o0mnL8/DapYI42XZMaqfePD3dUPatpwyN5Wf15P4iTrckNrEmob/TQABx/gP2KJ2g0QgjHN7oFOfphn1I+/sFx/tagBjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598091; c=relaxed/simple;
	bh=HNesIF4+NCKJRgMS8RJOzPdBmK2CQSC6p10zaqTN28c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfhercN8anO47inWcSVVeejXYrrAJ4QcDsdv5UWCswJucGy9HexB52DrVIsLXqDc34jfyQ3VT7pH8NnPXo1vwqle3DTRGTAGUKzgbmqlxjrVJ4WvJ+93cqrN9slNIofbwWR49VxFIKbkDjDQPDuxA7Q/ej54iQTQOfvpd9pNLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rYyOesV0; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2951f3af3ceso447800fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 07:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598088; x=1732202888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=573A7VIJaN7Phef7EPro6/84rHuXaF2Ar2GUBUbETSc=;
        b=rYyOesV0QfwRWVm1PBYChCs1Y4zCFiNHzH9R1LQaPnj2I8tT1iPTBnN31qKM66drKa
         ztxK7fRNyFXXLM/ckR1TTL3eSG9kYJpCrCGc51hfexhpkcnHvLwcZutL3r1GsGUzsaOH
         dv+7AHgPXl1JMdeWYXi1svCXaQ5X6FSFMOiGdy5M0+ymXDb6scAwHTySb9Xr9WUFmcNC
         BESPCPmyvEuqPgrLOhMtZSKuLRYN0js4dOgSguoXXFLublShL5XNWGbjzgx9Xn58vGUI
         OI7bAdPajtubR/yBEm6NRIkX7iaRt1+zNKye4zI5q+6N/m2lbdzvOJ4IlOP3mrbR6B5V
         x/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598088; x=1732202888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=573A7VIJaN7Phef7EPro6/84rHuXaF2Ar2GUBUbETSc=;
        b=WVgkRX07pA7+hdZdGac76rDRoSoA5HRs9IYYJiRiRaFJ7b9wN6CWk8E452MZOnkRc3
         IoMDsbZA8WyYqjGxIU1t6It0YAtnYX/5fwq1WidKp6cy2FAThGHVd9h+0S6vDFlPbWuQ
         ZJbpq6KIO23b9/f4++rP8kBl+EIwVYlVKADr7s/ggNvGUrladYwBDe9h4QqrADOZz/NZ
         1yvGRI3YO7lbUyklaA3zev6RfeWYq1cySzZAAtVQvwkOgggB2eOLLWraT2+2ck4usNaF
         wc6pbD46t4fW0FlyTaJmWjflgoCV7hrQ4HTYcGEBE1AmqMGBcA6rXVaeepkZ2xTRbT+d
         NQEg==
X-Forwarded-Encrypted: i=1; AJvYcCUbjTH9PrhvvJ23ZXFXEktO5do8PN9vG1XRSwBgbPcn4NtYJ36NrWJAgrdAI0zVWgSk40YTuqm9t9Rc5M+Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0EmiV2h+GmTkZO243D2IiiVowaSOM5qP2g7Y7TgEfwEQFyDN+
	Onmg4rh38QjeQ1DbHz8jNKlvz8ptlUd4SJYyWoBotL//wdbOOJT4hnOAGMHOGCM=
X-Google-Smtp-Source: AGHT+IGRJhbG3Iz8YyLsc6/0RWtRhZhYbcSZVTwigVtxhi/CGcrJEwq+4Kef8lO3NDoSjpzlANfJNQ==
X-Received: by 2002:a05:6870:5312:b0:286:f24f:c232 with SMTP id 586e51a60fabf-29610696786mr2665053fac.42.1731598088623;
        Thu, 14 Nov 2024 07:28:08 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:08 -0800 (PST)
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
Subject: [PATCH 05/17] mm/filemap: use page_cache_sync_ra() to kick off read-ahead
Date: Thu, 14 Nov 2024 08:25:09 -0700
Message-ID: <20241114152743.2381672-7-axboe@kernel.dk>
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

Rather than use the page_cache_sync_readahead() helper, define our own
ractl and use page_cache_sync_ra() directly. In preparation for needing
to modify ractl inside filemap_get_pages().

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 91974308e9bf..02d9cb585195 100644
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


