Return-Path: <linux-fsdevel+bounces-34067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828359C243E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473992831B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9013219E41;
	Fri,  8 Nov 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OWe0BsWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130141EBA1A
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087918; cv=none; b=nIAhA/vaKbb6ABkWJc+894EyzrmdX1HSkJ3iaM9udsoTH+d4NNUZdok+rSumxKhUGCp4bkF9tcLotx/2X/s2Y74Eed0g5Cugbgh4Bpq08jymlfPDvlin3082yh/FHxxNcrgdpLdzVnkKsTwdEOcIW9PfA8kVD6cfWaZcQAvVdG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087918; c=relaxed/simple;
	bh=RlKjacUZys9CzUs88jCGaGTWGkptV948qQSd9Cz5KPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftq5lWKKsqBl3HjqT8YNJghNRGCqeXnIOu+8sUELJ8iEK+5I6J9Z5F32cX1bujf9DsHlC2+jM0r00hXE9A3b0M+qc7koUgo89UVrAExyUyjegJ0AJoG8u1Em8PyB7jLxcaeoS96kDVw2WsmeNmAAkKM1FNcXiwRD7A1h3wgoCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OWe0BsWf; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e6010a3bbfso1610379b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087915; x=1731692715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZxELLVFDjwUYsFIGQEeVxILEzmt3BirwJxOvJB40G4=;
        b=OWe0BsWf3HiSed1r6ptVYceXWgt7yTZ9toOJCy82z1ZpRduRdKVEOQmEFSZfDD1sWT
         J3EaxVOZdewoQsKNPhshWULaWv1Q19Du5aGl5gqi6ts9sKgYYTTNXUIUELB2ZE5cwvXL
         AULq4hZoO0z4yWPVStnWMQnqDeOaFUah66oycklJ724rq6WA/urwuOgaMqmXckjfGxSw
         TtHYfTkDWMMhIv1dU+t7fUdoxQ3Bdx48PtMvluQR9rqR7btk+7Cr6syT0VU3qE0KnQ21
         FT6eS3QuSgZKjaW2QEkeQPur+fC4ssRyK3K9lJ68meL9LobEWIPEdn2a6HvZHttWeQjd
         jmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087915; x=1731692715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZxELLVFDjwUYsFIGQEeVxILEzmt3BirwJxOvJB40G4=;
        b=ABJX/AyFaFehTwUS14naEfvsaPYv94JRw9KZmYTr60wq0QHlpPMg1iZEdHkM8ftmor
         hseIe87a4OmgGkhgNTP+V6iG2JMMb+Ice0JVdUs+4DKQl1wTp7ZTsHMzi6qfH/CeUFoO
         LJ8XX6po3edoLsFI1NBNooZxNDE/9qN16B5Cxq/gx667PwG244Nv3CLaA1CNoWgvVV80
         LP6PI0fZ62DLVPzoeJojF2rdZsax75JkeFBC9nmSjlHiCBqQUEfhdrdv0K+FE/4fqHAr
         Gaktzekw6iH29rJ1KlG8NDmLYBaPKtgIqgmurVEjNyV7o+0cb5JoYG6CNqbqbBHlSVU8
         K8nw==
X-Forwarded-Encrypted: i=1; AJvYcCVjo4MtyEPI191WWGsj8sIJUXjUvuLIdyc7FSt1Wn8PYvHhrDNCJSQoE2mMy6SEDDsHCboEVZJa4Dwd0CMk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3HRmBsTeOO/ohdC11OkqpTPtAN/XuTH1iU1QxudWG3YTytbqz
	Vg/FZ5d8ZowVMzS82TcK4FCxw7AHxqTY/fYpjV9Vl8BHdIEC894pyN4t7suBxOsvkBHg3x/pLvA
	kQq0=
X-Google-Smtp-Source: AGHT+IES+vxslMkWIJ9Qt53dufEtarFT3S5DaOvldgjpcVbvhQDjZUhL8AdkSUoXq58a5ka/shhJOA==
X-Received: by 2002:a05:6808:1524:b0:3e0:7005:3f86 with SMTP id 5614622812f47-3e7946c80d6mr4180469b6e.28.1731087914910;
        Fri, 08 Nov 2024 09:45:14 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/13] mm/filemap: change filemap_create_folio() to take a struct kiocb
Date: Fri,  8 Nov 2024 10:43:24 -0700
Message-ID: <20241108174505.1214230-2-axboe@kernel.dk>
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

Rather than pass in both the file and position directly from the kiocb,
just take a struct kiocb instead. In preparation for actually needing
the kiocb in the function.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 36d22968be9a..2ae26a0f961b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2460,9 +2460,8 @@ static int filemap_update_page(struct kiocb *iocb,
 	return error;
 }
 
-static int filemap_create_folio(struct file *file,
-		struct address_space *mapping, loff_t pos,
-		struct folio_batch *fbatch)
+static int filemap_create_folio(struct kiocb *iocb,
+		struct address_space *mapping, struct folio_batch *fbatch)
 {
 	struct folio *folio;
 	int error;
@@ -2487,7 +2486,7 @@ static int filemap_create_folio(struct file *file,
 	 * well to keep locking rules simple.
 	 */
 	filemap_invalidate_lock_shared(mapping);
-	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
+	index = (iocb->ki_pos >> (PAGE_SHIFT + min_order)) << min_order;
 	error = filemap_add_folio(mapping, folio, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2495,7 +2494,8 @@ static int filemap_create_folio(struct file *file,
 	if (error)
 		goto error;
 
-	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
+	error = filemap_read_folio(iocb->ki_filp, mapping->a_ops->read_folio,
+					folio);
 	if (error)
 		goto error;
 
@@ -2553,7 +2553,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	if (!folio_batch_count(fbatch)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
-		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
+		err = filemap_create_folio(iocb, mapping, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
-- 
2.45.2


