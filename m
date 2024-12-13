Return-Path: <linux-fsdevel+bounces-37329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 832F69F118B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D62A188422F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7E71E47A8;
	Fri, 13 Dec 2024 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="t+ltFlte"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9DD1E3769
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105369; cv=none; b=RTPiG/yICS01Z8H+0sHzcRdOXCnDTwnpmQsNtxU59P6crgeE83ofYv75CV3Zbqxa5ot+/Zk0Mdw6KmV/gt74RWW9UL4uwO3SiyB3pZPO6KugGuys2HvWHPjcs+Cshs+IkWA4Q1+/gL15DcSUIrD9Rhg6waNkjNEdrhKjPJF97dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105369; c=relaxed/simple;
	bh=QAWYGVCQ4XEJ3pXTfPeihz8wMx0MW0Etgn545GbAEGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knLKEhdGtjF45znDRosGCuI0geUfCMPUh2/ErrkXYraF+8d5e3oenlyTN69CMDdqr1/CSKBArrrNWh1NCOqN4fbGk6yfQ4rh7N787pl+gQU4hndHzlpBvEvnRUnj78L94vsLD1P6kcyCYiY3qdnbmMQzT53B7nMImnj/cx4mPFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=t+ltFlte; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844e12f702dso56956439f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105366; x=1734710166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hANs0KTrn4AbTh3ILmowq5bBaAQVBAkU7MnXkJd6Hic=;
        b=t+ltFlteBGcA0UWWo45gjFMi5F6YPSar7cOq/L5NtqarY+9zPmveE/IW4vEek6yAUb
         QlstFsbxAIu9kEt0zwXjNGD88a9t3fWpCAZpiZUmrG49S4IaVM1WmlpK85VlP3rg5XV/
         kMwNchTRlDJ12UPl0JzyglzdszaKdN9d81I9v7cFM02VYogMGZAtiTOvqbgnIkb1iN1e
         AGmN29i9WDOTh0IGhZqjmiUgwP/YGL7zkZdN0tf0mN8GKf9/vgeDbKYExIw4tkFb15EY
         AdPfmvt+7GErjc501iosLF4jFlpzJPiyobSzkfAB68bBhxVlpp0WLJLXaOrVlhxZAwuh
         3wpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105366; x=1734710166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hANs0KTrn4AbTh3ILmowq5bBaAQVBAkU7MnXkJd6Hic=;
        b=DOpXXLb3dsgK27/Azemnrh/EfcpbBAZ+dOW5lE+uqzd2Dt/f2KSr2LrEBdlH5iFZUS
         F8RyydGIqqFz0+z29yLFBRj9DoKC+OAN0kBK7Ajg+dPWvzf626oknacf7oCGur4BHgcn
         S+k7T+dQK6A1z/szKU55MdZ5vkk5GTMGwFd0l9Ted3BT+LYu0Lr2iNwnMV0KE4SMTjyO
         3Gz5onGTzDM4Qs6kIkg4XSQFtDUz3ZxHgI0Z4BTtS3ms+80eLTkoYjCZhoRl3vIkgLEe
         gjMCjA5FgpXD/3VMk514JgA5DyhTlm+FVh+U+bumOB2V/sY7DgUexHilJf4uOmt2GgJz
         RACA==
X-Forwarded-Encrypted: i=1; AJvYcCWZB8bpwruwSV1479tTSZGhztYxMVjRVZCHisgp3LsClme4j6wlKNnpZ2bKo6SDHLWUZX+EPsIf4e7z4qnK@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/z3d/eP1TQXkXXJiUqeaOrE20S8gSVZv0QitgOrTc0BLzgg3
	NMpufP2StBDPU8PDfVG/U7wStOdSk+EPvQb5sz0HDg/fUgp/KRstfuzbOlmJnDuOiuRgxA3qley
	3
X-Gm-Gg: ASbGncvyEWHRhfGe40Vr5f1yMUS8wV718tupdi7/W+sKDWSuQTvfHPK8TwWwsnaoDFS
	4r40mubQIvBrW07XWh1nUnkmXfuL66EXVBz5vchLSWtPS8Iw52OCgEpmGoZKd9ubbqfsUI05+FS
	plrjpDh0FTN6BNIzXkTMq9pgaIEu5nPnNTh0Evzw0swCWF2S4Yt0XSCkHBdQDz/20yiooibPUn6
	fjB1uCm1ua/L4NT+wdcGME24zDgSYkbt/jWpz4BU5sYffQJpCtuWFykwdub
X-Google-Smtp-Source: AGHT+IFVLcWwM0MIr7oz/Yvc9CHKROeMGY95g0ljJ88B+/rBynMSTGl1ysoTz/aE+AP7fUiTK21pEQ==
X-Received: by 2002:a05:6e02:1a07:b0:3a7:8040:595b with SMTP id e9e14a558f8ab-3aff50b64a0mr26251175ab.9.1734105366472;
        Fri, 13 Dec 2024 07:56:06 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:05 -0800 (PST)
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
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/11] mm/filemap: use page_cache_sync_ra() to kick off read-ahead
Date: Fri, 13 Dec 2024 08:55:16 -0700
Message-ID: <20241213155557.105419-3-axboe@kernel.dk>
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

Rather than use the page_cache_sync_readahead() helper, define our own
ractl and use page_cache_sync_ra() directly. In preparation for needing
to modify ractl inside filemap_get_pages().

No functional changes in this patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8b29323b15d7..220dc7c6e12f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2527,7 +2527,6 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
-	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
 	struct folio *folio;
@@ -2542,12 +2541,13 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 
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


