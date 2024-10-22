Return-Path: <linux-fsdevel+bounces-32600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3D39AB63E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE16B245A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC71CB316;
	Tue, 22 Oct 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckwSqXmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3171CC164
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623293; cv=none; b=IlOmfZpP8ppIMcl1WFWkp8zWI4BwnhDSdYWt0W7BS9S0MVSBkuf7WvuXixCoyfOj9USpLqQDfMExxOgGNZ9LQDQ4KoAnRmwIg/9WhnbjoOO212cKgMrrGNKToFdLqunHYrB8lxnXTpeYrZaWUCBV/3N1Xb72G3F/rtvI5nrxODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623293; c=relaxed/simple;
	bh=aCBS0E8uI/g2bfKdlxec+OEaLI9quKfamNOOdj4G1rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5XTIJXbNavY+As3NBW4ufXuycTLMz75zY9KYH7y4ZDo6WwcBKde0Nw/0tNw8E0j7ZgJeJ9KLWhjqoEgLls7pEE5omkM3pfRmwDU8+jyF6YT6QT6EW76Y60IHrYak4VqS/eTcUCVaeamnb+jw5GGIXjKND2tuKZWizEJToZ6dnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckwSqXmG; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e34339d41bso53021027b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623290; x=1730228090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgB3T3HXxfx+orA1DK8znN5gB3bUWbsMmvZklQRTvig=;
        b=ckwSqXmG8iVZGQnoYVvct4XAXkIm85o5bM8vP4GHPr1QewLNJFE/Qt8Wz8zTLFz0WT
         /6Iz/0Eh/xxKlc51dNw7oVlC6Eh/IFS3/Ya9XVRTMTucIcG36QjSrcT+O/heBNGQ5e+L
         tWSCXObxevEpo07rSwf3vMADpmx9YtdA+0Qn3BkZy2iFHh6PrkN0GxxfW22aPDuldp6F
         0zjOvxqLSZvZsIkuU21JIwoYjYNPaC0exCrK2n4QzrIZEreY84dEydtTN6VjbIvczcek
         374MKXOe53Y5z/kl8AF2c4uPjYVKzdWFoIaAmPB6TJtQYmbZghZsfIOafIS1FfmWc8E+
         WU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623290; x=1730228090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgB3T3HXxfx+orA1DK8znN5gB3bUWbsMmvZklQRTvig=;
        b=PVKaZzy02nubV2OmzHkhKaabunTq0fKrxQz3sY3wem6Xnrab05azxRR/sJI+oxxldx
         5rytiXCEvlTWQMYpsfSB3Psm+Mz6pLWLZbGjl6SOl8rmUjyyTrywXd+0qfBjcZWWWTHP
         YDo89veg39yssJFk2aeFZQyTGss0SR/C4eCKSqOjg8xc/G5CA7nTVs6AaG/oxd5vobvK
         0u8wZoCW4saUWQDFd6SqowZhwmyEFDduVrgAJYgZfyTq3jNfv5V+VFs7auh8tj5pCHWc
         p5qJzhyL2t2xizKlng10w+J8zn9FifYAFJV82Mtx+L3mX5CRJgmx1NJq2wEC3LxQ32dp
         77zw==
X-Forwarded-Encrypted: i=1; AJvYcCUO+dFXKbmPXeoWkgP1nCNa5JDnFv2I6vePyHKXKIFFM0v4cj7jtDZyDcZUQ4WHMgGIciicx/vwvyB1rxnL@vger.kernel.org
X-Gm-Message-State: AOJu0YxNWMa7gFoxmKyRbAwdM7OqcBZtEOIZ0MaRtRWZWRlpcya8sscu
	zMgNIjvDAzmB/lmisKDX2SkiPPQm6Y/yNmW01I3EZenEh6YJlN9S
X-Google-Smtp-Source: AGHT+IF5LXW4xHNU3PRuNVFjdFWJZcu9Fkq+OcytC94wHPYg19OgOXAo4NhbAuBl4II/C/vw184k+Q==
X-Received: by 2002:a05:690c:d91:b0:6e2:ef1:2558 with SMTP id 00721157ae682-6e7f0dafa1amr68597b3.8.1729623290308;
        Tue, 22 Oct 2024 11:54:50 -0700 (PDT)
Received: from localhost (fwdproxy-nha-004.fbsv.net. [2a03:2880:25ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ad5a1asm11769207b3.69.2024.10.22.11.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:54:49 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v2 02/13] fuse: add support in virtio for requests using folios
Date: Tue, 22 Oct 2024 11:54:32 -0700
Message-ID: <20241022185443.1891563-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022185443.1891563-1-joannelkoong@gmail.com>
References: <20241022185443.1891563-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until all requests have been converted to use folios instead of pages,
virtio will need to support both types. Once all requests have been
converted, then virtio will support just folios.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/virtio_fs.c | 87 +++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 31 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f68527891929..9f0d98cc20d3 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -766,6 +766,7 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	struct fuse_args_pages *ap;
 	unsigned int len, i, thislen;
 	struct page *page;
+	struct folio *folio;
 
 	/*
 	 * TODO verify that server properly follows FUSE protocol
@@ -777,15 +778,29 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	if (args->out_pages && args->page_zeroing) {
 		len = args->out_args[args->out_numargs - 1].size;
 		ap = container_of(args, typeof(*ap), args);
-		for (i = 0; i < ap->num_pages; i++) {
-			thislen = ap->descs[i].length;
-			if (len < thislen) {
-				WARN_ON(ap->descs[i].offset);
-				page = ap->pages[i];
-				zero_user_segment(page, len, thislen);
-				len = 0;
-			} else {
-				len -= thislen;
+		if (ap->uses_folios) {
+			for (i = 0; i < ap->num_folios; i++) {
+				thislen = ap->folio_descs[i].length;
+				if (len < thislen) {
+					WARN_ON(ap->folio_descs[i].offset);
+					folio = ap->folios[i];
+					folio_zero_segment(folio, len, thislen);
+					len = 0;
+				} else {
+					len -= thislen;
+				}
+			}
+		} else {
+			for (i = 0; i < ap->num_pages; i++) {
+				thislen = ap->descs[i].length;
+				if (len < thislen) {
+					WARN_ON(ap->descs[i].offset);
+					page = ap->pages[i];
+					zero_user_segment(page, len, thislen);
+					len = 0;
+				} else {
+					len -= thislen;
+				}
 			}
 		}
 	}
@@ -1272,16 +1287,22 @@ static void virtio_fs_send_interrupt(struct fuse_iqueue *fiq, struct fuse_req *r
 }
 
 /* Count number of scatter-gather elements required */
-static unsigned int sg_count_fuse_pages(struct fuse_page_desc *page_descs,
-				       unsigned int num_pages,
-				       unsigned int total_len)
+static unsigned int sg_count_fuse_pages(struct fuse_args_pages *ap,
+					unsigned int total_len)
 {
 	unsigned int i;
 	unsigned int this_len;
 
-	for (i = 0; i < num_pages && total_len; i++) {
-		this_len =  min(page_descs[i].length, total_len);
-		total_len -= this_len;
+	if (ap->uses_folios) {
+		for (i = 0; i < ap->num_folios && total_len; i++) {
+			this_len =  min(ap->folio_descs[i].length, total_len);
+			total_len -= this_len;
+		}
+	} else {
+		for (i = 0; i < ap->num_pages && total_len; i++) {
+			this_len =  min(ap->descs[i].length, total_len);
+			total_len -= this_len;
+		}
 	}
 
 	return i;
@@ -1299,8 +1320,7 @@ static unsigned int sg_count_fuse_req(struct fuse_req *req)
 
 	if (args->in_pages) {
 		size = args->in_args[args->in_numargs - 1].size;
-		total_sgs += sg_count_fuse_pages(ap->descs, ap->num_pages,
-						 size);
+		total_sgs += sg_count_fuse_pages(ap, size);
 	}
 
 	if (!test_bit(FR_ISREPLY, &req->flags))
@@ -1313,28 +1333,35 @@ static unsigned int sg_count_fuse_req(struct fuse_req *req)
 
 	if (args->out_pages) {
 		size = args->out_args[args->out_numargs - 1].size;
-		total_sgs += sg_count_fuse_pages(ap->descs, ap->num_pages,
-						 size);
+		total_sgs += sg_count_fuse_pages(ap, size);
 	}
 
 	return total_sgs;
 }
 
-/* Add pages to scatter-gather list and return number of elements used */
+/* Add pages/folios to scatter-gather list and return number of elements used */
 static unsigned int sg_init_fuse_pages(struct scatterlist *sg,
-				       struct page **pages,
-				       struct fuse_page_desc *page_descs,
-				       unsigned int num_pages,
+				       struct fuse_args_pages *ap,
 				       unsigned int total_len)
 {
 	unsigned int i;
 	unsigned int this_len;
 
-	for (i = 0; i < num_pages && total_len; i++) {
-		sg_init_table(&sg[i], 1);
-		this_len =  min(page_descs[i].length, total_len);
-		sg_set_page(&sg[i], pages[i], this_len, page_descs[i].offset);
-		total_len -= this_len;
+	if (ap->uses_folios) {
+		for (i = 0; i < ap->num_folios && total_len; i++) {
+			sg_init_table(&sg[i], 1);
+			this_len =  min(ap->folio_descs[i].length, total_len);
+			sg_set_folio(&sg[i], ap->folios[i], this_len,
+				     ap->folio_descs[i].offset);
+			total_len -= this_len;
+		}
+	} else {
+		for (i = 0; i < ap->num_pages && total_len; i++) {
+			sg_init_table(&sg[i], 1);
+			this_len =  min(ap->descs[i].length, total_len);
+			sg_set_page(&sg[i], ap->pages[i], this_len, ap->descs[i].offset);
+			total_len -= this_len;
+		}
 	}
 
 	return i;
@@ -1358,9 +1385,7 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 		sg_init_one(&sg[total_sgs++], argbuf, len);
 
 	if (argpages)
-		total_sgs += sg_init_fuse_pages(&sg[total_sgs],
-						ap->pages, ap->descs,
-						ap->num_pages,
+		total_sgs += sg_init_fuse_pages(&sg[total_sgs], ap,
 						args[numargs - 1].size);
 
 	if (len_used)
-- 
2.43.5


