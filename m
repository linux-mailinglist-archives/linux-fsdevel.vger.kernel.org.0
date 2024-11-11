Return-Path: <linux-fsdevel+bounces-34344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6AD9C49FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 00:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368C11F22D8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38701BD517;
	Mon, 11 Nov 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1XtdPxEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192C1BD9DC
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368931; cv=none; b=cqCtH8fyI5CM4TYkYRHuSkUUWZIe08ANOxKA83zeMs+E5lnomigWPZUEEZWyCH5eww+XCVPQWEDqoI4wenMW848NWYc7TFCp07OgEYaO7V7WBs0K5xoDTOGzTganxVvg/gtgADjmIYHe0NUwnNGjcw6GmZZ4SSOQjC5ADvU3Wvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368931; c=relaxed/simple;
	bh=8sfKwyActgC+UFgrCv8AbW1Vz+K4ykiNjF4V6I33E+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfJoq7zDEpSjtD1TdfNMxEUlFsDPj2t53ILgUj+x0A29hxOYJ+FKkaGrLc8z9YndNgdqr56Qwh9xc5AdDiPBgOK47N8/1EoVvMbGb4QmfLU1tEgQJFVaVsOI2NutZzSaNtWlB9pOMjDB2tGz5sJsDdC7LDAXN6ZyQA1XQgLzru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1XtdPxEX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso3638433b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368928; x=1731973728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzX2IvmAROGBANn6HEgih/p/Joy2MXPhit7EzvqeXZU=;
        b=1XtdPxEXJTmPsu32YnbH6YQeaTMAo+Ak38XEsETxOrV8Npg7jWx8/6GSBlZkGNTPgG
         7DqJMZaJC1NtZLHip/no8SpalHLNny28xCpwp1BgXLGqth0JzVhKgbhw7YN9Bq3yTlQP
         pyM8K/Yugg/Ii055VtI2mAnFh0JoCX97OdIUn3E1xfnnbPuIBwq6k2PHa2UN8l/EGHM1
         VUjlmNAciQxi2SKh0TfDSzWVi9L0P8wt1zx/nduENXrEQfiE0AbHwwL2uP8/P+/pXmew
         mOozAjra/akldPSVosyR+lmYBuC5GsqK6THkwaNA/mjw6477NUBP/WuuwINJclnK5aaU
         0Z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368928; x=1731973728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzX2IvmAROGBANn6HEgih/p/Joy2MXPhit7EzvqeXZU=;
        b=JrzlKDZ+VY+8CKhnl15fMzIprlS09+5b8D9f0Mi9efNA6HbUDASEPokxp2vdwDbTTh
         G98q1dJWUYr+7XFmaMDif+SM8ySbHehShv15IAk4LSwm1WkPWrBFSUV/68wnht5/ZXry
         ZfVNcRwKZXvPPNDo3zRvOZXtz+EHWboRVht+vCYHmBmX7ee/I7PaFdAH3/JDBN2FROUC
         g7ywYuG7qlv0vd+Hk7Q9NoCEabCkwNfh9M6IzgSH8Wd72iKoW0Nlqg3Y/XGq685dw7Yt
         4KkK63toZ2sPccrVzYAFEkNdSoVdA6Q38H7MR//NPSpj3UEl5xlX2WdxUGlhmda/J0gY
         OLWA==
X-Forwarded-Encrypted: i=1; AJvYcCXJysa0wIwBhcwgg443Jy65p/yVXAh2pExfmuIlkYm0x9BYKKsRr0Z+yDksMRsqedQ4BomLcFLUjRnHLAn5@vger.kernel.org
X-Gm-Message-State: AOJu0YzY2yGmR9R1lrZFryUOFe1kiDrSTxzLGrp0k6JVeCCyL4eWtate
	tZhxaFBIbaY/jARRfiQgF6aD8VOAPiGVWTvT7V9HT3sCJsdMWuXanH4Vnc4AI7s=
X-Google-Smtp-Source: AGHT+IFPjohwvXk7XeJJhxpW4zvvN4HHe41fbVtZtFFrzITrw1kyHBpDFfhvHRsSHEkN13Wz8BpfRA==
X-Received: by 2002:a05:6a20:12ce:b0:1d9:15b2:83e with SMTP id adf61e73a8af0-1dc23322093mr23031517637.7.1731368928327;
        Mon, 11 Nov 2024 15:48:48 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:48:47 -0800 (PST)
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
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/16] mm/filemap: change filemap_create_folio() to take a struct kiocb
Date: Mon, 11 Nov 2024 16:37:28 -0700
Message-ID: <20241111234842.2024180-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
References: <20241111234842.2024180-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than pass in both the file and position directly from the kiocb,
just take a struct kiocb instead. While doing so, move the ki_flags
checking into filemap_create_folio() as well. In preparation for actually
needing the kiocb in the function.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 56fa431c52af..91974308e9bf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2460,15 +2460,17 @@ static int filemap_update_page(struct kiocb *iocb,
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
 	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t index;
 
+	if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
+		return -EAGAIN;
+
 	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
 	if (!folio)
 		return -ENOMEM;
@@ -2487,7 +2489,7 @@ static int filemap_create_folio(struct file *file,
 	 * well to keep locking rules simple.
 	 */
 	filemap_invalidate_lock_shared(mapping);
-	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
+	index = (iocb->ki_pos >> (PAGE_SHIFT + min_order)) << min_order;
 	error = filemap_add_folio(mapping, folio, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2495,7 +2497,8 @@ static int filemap_create_folio(struct file *file,
 	if (error)
 		goto error;
 
-	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
+	error = filemap_read_folio(iocb->ki_filp, mapping->a_ops->read_folio,
+					folio);
 	if (error)
 		goto error;
 
@@ -2551,9 +2554,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	}
 	if (!folio_batch_count(fbatch)) {
-		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
-			return -EAGAIN;
-		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
+		err = filemap_create_folio(iocb, mapping, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
-- 
2.45.2


