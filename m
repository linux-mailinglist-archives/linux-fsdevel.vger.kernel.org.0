Return-Path: <linux-fsdevel+bounces-37953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6C69F95BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10556168E96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332D5219EAB;
	Fri, 20 Dec 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jkL83Moh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FC2C190
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709720; cv=none; b=sjdpwYFuxrfyi7arkWl000SfQbRwK05Pb+CnvlqG1IdYbI5WOLKFxJFNdcbo9e2YZMwiiYQj8bossNgS9JVwz1ETykOKjOelzIOM4O4bXcVKYaxKkA99028ljzFTx2kGgt/9zQdkx5xBR5qHW6ign1bO6BoTOHGBoa2QX2R2JOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709720; c=relaxed/simple;
	bh=b/y5rN0twqq/ec0xNXkKmKx5Y1U8KwWxvQTbJi27mNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncZpZLrlqKu4PkQPoIYvOPHQtjh8mnl4yAPwMe3wbB0KS4Cta89Aaba5OL/5b88tSRA4R/CBXuO1Ua+lSMy2eNiMBxTRKtsRHcl3XOWV22A+dKLbNVNNW9yFoK/MnZ4YjC4OVRu2Ex7yvSbi+vyvd9MJLKc/DICFWpQc7BDq5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jkL83Moh; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a7d7db4d89so6533095ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734709716; x=1735314516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VCPzs6l+RtFDMTSDAiMfSmCwqht+PTO7Juc8Thzg3k=;
        b=jkL83MohDYhQY4bjlZQSU/5NzrH55KTXCTdEjCvqC5zm0NEGSuy+axb4CHoLYS0nw3
         JXqDzqCPAezo31DUrtnls2EAQvQfLgiq30e+/5VUFDmd5imZQrpDb0z+tCq6llMaYR65
         +/0SyHyRerEpNYWGu/H8L2gyTbX6eFxapOUk4VsJ7yNuxKj6qm293RAD+e+rYul672Xw
         HkgT1ta3CnX/hqtIrm0FAPNmRuts9AEg3nS5RzgGiJOpfcROP/zcauIbQAdRg7wu9pzs
         cGGpS2BBJ9DX8SehPlElyHtvi92P7y/lwDLGrLjoeyt3Gx5UkJXjCeGo7gNLEC9hcfJp
         RTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709716; x=1735314516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VCPzs6l+RtFDMTSDAiMfSmCwqht+PTO7Juc8Thzg3k=;
        b=AmHgUNr0UE0xFWs9eO64NR0+ZccQvfRwYHimUh8Oe8OnlPYDpsX+fryzXGLWjINQ2r
         k8FXUg3JnTHuPdhDIyFfs5EbMwbmy5Q7h6Uifoofi1xCgas91ctWKGLHWoHxs6zB0D8L
         btFYjDOjzgI7hSHHBN0urFH7Ub4Y/s87eogsrD0J8mb/VA7EcBgdKfqbvz/1mEQyYM7F
         fGAbSH/c56xBQ7AxGjZRODlIblMeD3mQZTuzSh4Xsg5xSFV0dVq3jHcNIbxyOM3DYg3W
         vou05LaB1LOZ93E4q/TkCQqonxHsfiME4D7Ozp5SMnlTWwq7aE6xqv+Sku+FMuctrxg2
         oHrA==
X-Forwarded-Encrypted: i=1; AJvYcCV2jxyQGZmgCDd0CyrmfkYji3qk9ehMu45R1X0uBEoebI6PljrDCdpXEZVNQsg7AuXtbKhoqqYBYdK4f40U@vger.kernel.org
X-Gm-Message-State: AOJu0YymY5hGzJyRg4grQ9JsG88CS0D7CwOBWTSVYqeCy1JXg597/jfQ
	fvsFOJj5eiwzOI2JipoH2hfXWsuX/Htfmodcx4Z6lXiKdkS2ZU5KzxZdsuCru3vJkWzJWS23zLu
	s
X-Gm-Gg: ASbGncsJlCccjnt02smKh6PSLE5fuqahim0gqFs6mVhGo1HVCI7w4xLCygu0o3v1e1V
	5xgPog00NuAO4kGdazcYBJpZrkxJejcSS0cyAcovmyaHLulqcxp7O7+bG5kMA6+y+ddmkqbXhF0
	O0uEOPYYA2JC88nhyToJkwxIBBcRB3/+nC7Zed0BhIVrix5LvBkS5y+2WSjvyasN4ytmAb+z8TX
	DSAqhQERtEYun67wJKXp9u+/fmNgrDi6RtMBxMVZvpANcTztxnILR3eAy7c
X-Google-Smtp-Source: AGHT+IHcbw9zIKJRxdjYyzhRRbFlhvov/fILoOcF1iNDb9M6UqXSGlIvkLvTLfoaxOcUHsgp350Srg==
X-Received: by 2002:a05:6e02:1e08:b0:3a7:8720:9deb with SMTP id e9e14a558f8ab-3c2d2d50993mr23190015ab.11.1734709716455;
        Fri, 20 Dec 2024 07:48:36 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66ed9sm837821173.45.2024.12.20.07.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:48:35 -0800 (PST)
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
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 01/12] mm/filemap: change filemap_create_folio() to take a struct kiocb
Date: Fri, 20 Dec 2024 08:47:39 -0700
Message-ID: <20241220154831.1086649-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220154831.1086649-1-axboe@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk>
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

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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


