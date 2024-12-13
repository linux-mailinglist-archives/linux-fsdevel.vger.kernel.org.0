Return-Path: <linux-fsdevel+bounces-37328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8C89F1188
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51DA164A6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDBE1E3DD7;
	Fri, 13 Dec 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rA2TyAiT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581C1E32B9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105368; cv=none; b=nATTqOTbiMrzDhzCNVun1wefJcfgNfSmfCC0Bh6OL1TQOOY+qiCHsZBJyDpuSKC/iZDKEGlej33HyszcGX69eF/ZHhAIEFiNd/GWcRs+lth9tlhKykY4btTQju61NYf2Q8MGgXHI4lbj6ZT5dTDZzyuEWBHY0yf6kbKzcHz9P1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105368; c=relaxed/simple;
	bh=CQHljKL0HvF5DjNsL/7Q8SjdRe1DhHG7gJBg0F4F8y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rfe9OrZdU6j68OImPwA0V5jCw9TNhoJz9zZED2rZE4hkjyoQnsC3+v67m8zY90IvFB/BA9xRNXQGl/I6HLrOZE9lnLsE0rd1nAU+Bfc41Ys5gMioyktnkZHCAD7MD3MqqQQ5hX0mM2kZdOiI6TXNAUeQkomxZEihaWfYybU7VSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rA2TyAiT; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a815ed5acfso6552375ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105365; x=1734710165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJTsU8FOCztsZChrgynI/se4Hg526H6WFOVyatkHjPA=;
        b=rA2TyAiTEnZDuJUEzMLUg7pzz4q8wsMtXMQ2nso5c9/p5yCYWDwsrcSh98ibhdDugo
         QYV5xGrQopJndH/3afNqdFjHohTuwzsGMkT761zJSNSavteA9lV4LtZy3bVeWeEALQC7
         y2U5OgpUZOM/ilJDz/2vlhIHaKxNy7YNbaHa0Y6V1CvSFxFSqL0Zed5VpY7KA2Mbm13b
         RIPhV06nHYQpDmJvWZLtjsFn9pkXVnRcIJ/wY0tu4icjeX7eaBnpKohIA8TsfsH9ZdF4
         g8AAiof2EMeyErrAX30lLtyacgcuzUBw4bCRybt59rq1NmeuU/eLUcwz7Tcm0Zh4oVim
         BvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105365; x=1734710165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJTsU8FOCztsZChrgynI/se4Hg526H6WFOVyatkHjPA=;
        b=ks0U1PAU4Y7+JIWIlt/OKfy0EW6jb4oDaDzdMZ21100Cq/JU/L9T66Qnq4iN9akIeC
         iB3/1anDzGClvQ670Qh3YETr3FFBCobVxQ++/dVT3rvhQ1TDmeIG6fShf+Bl42Zj6L2m
         L3qWs3+QsPnm0QDtA2cdVkAfBDIVpQBEqwlRmOQG+0QeF7MqR5e4g4eI/3fDyCPoduAp
         hBWb5hauex0QNZ30kUwYqW5Ypt359241JdxAHNJrDj0MqXKBvR22n+Ag2JuaI5ltk9tA
         QOTgtAeiaXoEluY/EL6aT0Cr2L2EqKRptcydFSxH+GSjXjyrsQ9i/NaX7tkqZodbDsSn
         e8Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUJasr3D/GaIUoocE6mHUXrBo2eoP3ObKr7Vwa9vbMu1XasMJnsvB4hS310YEqDkITeAaUxT6IZRxLmxvGO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6myom9X3/HDebwfYswpDpdN/3Bh2IWZrW29vmVOqqgRsi2h0t
	K2EnKoFh9OajZdPeAjx3+Qhr8rb6UVR9LtFPEUhmQGh7aM1Gx8HKY4BtjGHKslA=
X-Gm-Gg: ASbGncs4eTJaaW02jwp5gJkTwxnSrPzmidsJQCOZk3Plv5+Pf3HUgtxTXQHdbD7zNk0
	d2vGCEZBE7Jvgb3mv+ebY5UDF8cftY+hDdk5cGoIKyRTuw0vp8lWhPPdldEcKY5k0FPeusvc85g
	VQkRIOaxg5Nu65qaoZQp5+wfhzyVq+O7aojq8weLlqZKcJXVTJrKFLid3ZJg2kp/5yzRC4JWO6C
	2qupT50gV/QDa1QiWmvYIQpenUshTJC20mooR7AfydWeHZ8QqYr6Ug40WAv
X-Google-Smtp-Source: AGHT+IHzvgK4Rw98UmNxw7TWkyvAABSCjKuo4ks1FFrTwghvSS0Ll84bbCaOcol8J/RzXzpmHkduIA==
X-Received: by 2002:a05:6e02:1a8b:b0:3a7:7124:bd2c with SMTP id e9e14a558f8ab-3affab62206mr35203095ab.19.1734105365052;
        Fri, 13 Dec 2024 07:56:05 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:03 -0800 (PST)
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
Subject: [PATCH 01/11] mm/filemap: change filemap_create_folio() to take a struct kiocb
Date: Fri, 13 Dec 2024 08:55:15 -0700
Message-ID: <20241213155557.105419-2-axboe@kernel.dk>
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

Rather than pass in both the file and position directly from the kiocb,
just take a struct kiocb instead. With the kiocb being passed in, skip
passing in the address_space separately as well. While doing so, move the
ki_flags checking into filemap_create_folio() as well. In preparation for
actually needing the kiocb in the function.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f61cf51c2238..8b29323b15d7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2459,15 +2459,17 @@ static int filemap_update_page(struct kiocb *iocb,
 	return error;
 }
 
-static int filemap_create_folio(struct file *file,
-		struct address_space *mapping, loff_t pos,
-		struct folio_batch *fbatch)
+static int filemap_create_folio(struct kiocb *iocb, struct folio_batch *fbatch)
 {
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct folio *folio;
 	int error;
 	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t index;
 
+	if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
+		return -EAGAIN;
+
 	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
 	if (!folio)
 		return -ENOMEM;
@@ -2486,7 +2488,7 @@ static int filemap_create_folio(struct file *file,
 	 * well to keep locking rules simple.
 	 */
 	filemap_invalidate_lock_shared(mapping);
-	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
+	index = (iocb->ki_pos >> (PAGE_SHIFT + min_order)) << min_order;
 	error = filemap_add_folio(mapping, folio, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2494,7 +2496,8 @@ static int filemap_create_folio(struct file *file,
 	if (error)
 		goto error;
 
-	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
+	error = filemap_read_folio(iocb->ki_filp, mapping->a_ops->read_folio,
+					folio);
 	if (error)
 		goto error;
 
@@ -2550,9 +2553,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	}
 	if (!folio_batch_count(fbatch)) {
-		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
-			return -EAGAIN;
-		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
+		err = filemap_create_folio(iocb, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
-- 
2.45.2


