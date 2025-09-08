Return-Path: <linux-fsdevel+bounces-60596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06665B49911
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334512000B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40C932145F;
	Mon,  8 Sep 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrOq7K1q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6931DDBA;
	Mon,  8 Sep 2025 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357562; cv=none; b=qfc9dLT8CSak+3r1k37y0DV7lDhZxD4PPif8xxknMACYhRd38TCxT79qcD27We+q/Da8Tqx/rjdn3CuHoblqppEUimOkesNuGartrkB2xGerPbhf++NutRuxPLTI4ceG0xnLdchlM384dvuAk0s2NBj0kkKJbvEkPxY99o+MXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357562; c=relaxed/simple;
	bh=ENwi4DO1DhkFAbdGM8UHbOMn7Ao1iZRX47ZuoN1VdK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lr6+Hz1gDZ+YntC5cdg6JLpZbCrY08iajFnQz7RNclbnldEjsZpVHUWOTGa/LrFvgtUjdyIsXhSQt0/XiZuvTmnJ5pI+Y+mvJii7pzKgolcUPsuHugR0LHdIOpddtlwDU4GVU2JSR2KGwPsak27ifXIouvGtRcg0yhnVVupVDmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrOq7K1q; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-772627dd50aso6248876b3a.1;
        Mon, 08 Sep 2025 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357560; x=1757962360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNhHc1Pq7t/O//ofoKIAyED7To1mRzYJL45Fx5MHeFk=;
        b=GrOq7K1qXhtWrG/FF3AN5sTfzONHseG/V7aEgI+E6jygLatBp7PtvZPjs2sW6G6XkG
         k4XAu2WHtDqoRCdsFazpLMf3nQ24cqckkWAroqfrQ1CVutg4AZ0E/6kFWnN3QSlq/O+9
         V570glutOj/dwWOMYaZbCE+kguEEGhfbrhgskGStl6r5TXYwiPHt7M2+xN/zYXVEqe+h
         ul58ugwipJAixLPLi5q0Pds4UaKrVBrUPBNpaxaTzCLi0JWB6/UBqo5Ln5PwTn2ZTNOu
         VW5ZMjjmO/sdTeblRX6w5xuPJ4PHBbiUtqp0aV5UkCWZlkilnfM+3ojTSxqoDK9f1DAz
         BSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357560; x=1757962360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNhHc1Pq7t/O//ofoKIAyED7To1mRzYJL45Fx5MHeFk=;
        b=aXNPUo/gcFrxSiT2os1SwvwfiJ/znRS9HSHMHndzcuAuN6onDdoGI4DkUbkkSuugyy
         SnklEDz5eY8dE9AnRyT2HEMZeSSErv8n7cWVIEcfGUJb3ee26U2VGOvZqevcMLY3UwLC
         a5weFPjs48cq6aJR+RaSn1b47Dq7bfp/LmUWd/9PA2PjWFsI4wz0/cfafMZid733qVFE
         LKt32fQKSiH++siixcc0cLeNtmVYHommsiCflGZpYsgtcLw3hszGOwHhmlrr7IzUGr0l
         JE7LC480yAjb3enTo4mNoVXXbEaXasUK2m4uRdLd8182OZD0tZKDEfdi0kfk1nMx8wZ7
         aRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKslhPA6gzXV9p7dSntA2bFZqzcv2OJCfkSPY//wKzNbIeLE6bhysAd7J7zN2K3NapFgSA66oWEbG4@vger.kernel.org, AJvYcCUWJEZyFh8KtNUUZAi0P04XluczuaqlQ97koeEUIumOKqOZzqhkkKbAJ1HdwhaolyOKbz8Unup3P6I4@vger.kernel.org, AJvYcCXRmdAIU4eMaQUfjy+mrE3PKUTl9hgSslwx5fYq9bR6SYYY17jbGLiqLNFQpESmWus5PXnPRTDDi4G7qA==@vger.kernel.org, AJvYcCXlFXtZf2ycpW2is1L4sq0iPonASmG8bbpeuEERD1pFgMLDsJ18aUSRwPmrjmNGPQjOa6yGupp+XKUElo7yTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwTeL2GoyRTNi+KRG1SyVfx0HYykzRmy6P5kFq6+2gi5dnClqv
	bV2HUJFX2SC6xnhT+ww7/et49+RHPZJjeGVwNH90O/x8FmjbfI6cLTbccMuwEw==
X-Gm-Gg: ASbGncuVXzoBV4gwd6Dm9a+lrtWj5iXGkYxQYvwp7TEOJ4Ia8FDD3c7sKOugLbPd4BE
	FXq8JqPyzeNxZ5bZibzmVA3ldVyQwiWmOGD5yNNq8NVcEXiQst7sCWyVBh+Cn6geTxL0GxeL50i
	+dEcOP0eq0AkFL2OxOZw3mHT6dKuNs8YRUIXnUGULmZuOg3tTtuzBORWmhR1hKJFYi4JewdQzc3
	/AZXUQh/rSgNlJP/v5q2hx9USIktngXjVTWYrzLn0Ob0e31cGUor/OMQAf/9mz4tKm9g87klq0+
	MhB/7MYIB37B89OH37xqnVaitlJTIqheaAissaLgTC+LvqkYup1g4GRp0wpLiI+jYXr3tawR+KR
	AdkOBFyXNlEO0e/PP7nVlXg5ZFtlL
X-Google-Smtp-Source: AGHT+IGiI7Qhq5OYluJANV0Nkto+66mAzQa9awlU3cX43aLUBp3N0DTRFQuV6w7zIE2+iBewWEhRUA==
X-Received: by 2002:a17:902:f78f:b0:24c:e9de:ee11 with SMTP id d9443c01a7336-251788fcff7mr113077325ad.17.1757357559846;
        Mon, 08 Sep 2025 11:52:39 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ca63c9e71sm144137415ad.95.2025.09.08.11.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:39 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 15/16] fuse: use iomap for readahead
Date: Mon,  8 Sep 2025 11:51:21 -0700
Message-ID: <20250908185122.3199171-16-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908185122.3199171-1-joannelkoong@gmail.com>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do readahead in fuse using iomap. This gives us granular uptodate
tracking for large folios, which optimizes how much data needs to be
read in. If some portions of the folio are already uptodate (eg through
a prior write), we only need to read in the non-uptodate portions.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 224 ++++++++++++++++++++++++++++---------------------
 1 file changed, 128 insertions(+), 96 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5b75a461f8e1..3f57b5c6e037 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -844,8 +844,68 @@ static const struct iomap_ops fuse_iomap_ops = {
 
 struct fuse_fill_read_data {
 	struct file *file;
+
+	/*
+	 * Fields below are used if sending the read request
+	 * asynchronously.
+	 */
+	struct fuse_conn *fc;
+	struct fuse_io_args *ia;
+	unsigned int nr_bytes;
 };
 
+/* forward declarations */
+static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
+				  unsigned len, struct fuse_args_pages *ap,
+				  unsigned cur_bytes, bool write);
+static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
+				unsigned int count, bool async);
+
+static int fuse_handle_readahead(struct folio *folio,
+				 struct readahead_control *rac,
+				 struct fuse_fill_read_data *data, loff_t pos,
+				 size_t len)
+{
+	struct fuse_io_args *ia = data->ia;
+	size_t off = offset_in_folio(folio, pos);
+	struct fuse_conn *fc = data->fc;
+	struct fuse_args_pages *ap;
+	unsigned int nr_pages;
+
+	if (ia && fuse_folios_need_send(fc, pos, len, &ia->ap, data->nr_bytes,
+					false)) {
+		fuse_send_readpages(ia, data->file, data->nr_bytes,
+				    fc->async_read);
+		data->nr_bytes = 0;
+		data->ia = NULL;
+		ia = NULL;
+	}
+	if (!ia) {
+		if (fc->num_background >= fc->congestion_threshold &&
+		    rac->ra->async_size >= readahead_count(rac))
+			/*
+			 * Congested and only async pages left, so skip the
+			 * rest.
+			 */
+			return -EAGAIN;
+
+		nr_pages = min(fc->max_pages, readahead_count(rac));
+		data->ia = fuse_io_alloc(NULL, nr_pages);
+		if (!data->ia)
+			return -ENOMEM;
+		ia = data->ia;
+	}
+	folio_get(folio);
+	ap = &ia->ap;
+	ap->folios[ap->num_folios] = folio;
+	ap->descs[ap->num_folios].offset = off;
+	ap->descs[ap->num_folios].length = len;
+	data->nr_bytes += len;
+	ap->num_folios++;
+
+	return 0;
+}
+
 static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
 					     struct iomap_read_folio_ctx *ctx,
 					     loff_t pos, size_t len)
@@ -856,18 +916,41 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
 	struct file *file = data->file;
 	int ret;
 
-	/*
-	 *  for non-readahead read requests, do reads synchronously since
-	 *  it's not guaranteed that the server can handle out-of-order reads
-	 */
 	iomap_start_folio_read(folio, len);
-	ret = fuse_do_readfolio(file, folio, off, len);
-	iomap_finish_folio_read(folio, off, len, ret);
+	if (ctx->rac) {
+		ret = fuse_handle_readahead(folio, ctx->rac, data, pos, len);
+		/*
+		 * If fuse_handle_readahead was successful, fuse_readpages_end
+		 * will do the iomap_finish_folio_read, else we need to call it
+		 * here
+		 */
+		if (ret)
+			iomap_finish_folio_read(folio, off, len, ret);
+	} else {
+		/*
+		 *  for non-readahead read requests, do reads synchronously
+		 *  since it's not guaranteed that the server can handle
+		 *  out-of-order reads
+		 */
+		ret = fuse_do_readfolio(file, folio, off, len);
+		iomap_finish_folio_read(folio, off, len, ret);
+	}
 	return ret;
 }
 
+static int fuse_iomap_read_submit(struct iomap_read_folio_ctx *ctx)
+{
+	struct fuse_fill_read_data *data = ctx->private;
+
+	if (data->ia)
+		fuse_send_readpages(data->ia, data->file, data->nr_bytes,
+				    data->fc->async_read);
+	return 0;
+}
+
 static const struct iomap_read_ops fuse_iomap_read_ops = {
 	.read_folio_range = fuse_iomap_read_folio_range_async,
+	.read_submit = fuse_iomap_read_submit,
 };
 
 static int fuse_read_folio(struct file *file, struct folio *folio)
@@ -930,7 +1013,8 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	}
 
 	for (i = 0; i < ap->num_folios; i++) {
-		folio_end_read(ap->folios[i], !err);
+		iomap_finish_folio_read(ap->folios[i], ap->descs[i].offset,
+					ap->descs[i].length, err);
 		folio_put(ap->folios[i]);
 	}
 	if (ia->ff)
@@ -940,7 +1024,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 }
 
 static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
-				unsigned int count)
+				unsigned int count, bool async)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
@@ -962,7 +1046,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
 
 	fuse_read_args_fill(ia, file, pos, count, FUSE_READ);
 	ia->read.attr_ver = fuse_get_attr_version(fm->fc);
-	if (fm->fc->async_read) {
+	if (async) {
 		ia->ff = fuse_file_get(ff);
 		ap->args.end = fuse_readpages_end;
 		err = fuse_simple_background(fm, &ap->args, GFP_KERNEL);
@@ -979,81 +1063,20 @@ static void fuse_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	unsigned int max_pages, nr_pages;
-	struct folio *folio = NULL;
+	struct fuse_fill_read_data data = {
+		.file = rac->file,
+		.fc = fc,
+	};
+	struct iomap_read_folio_ctx ctx = {
+		.ops = &fuse_iomap_read_ops,
+		.rac = rac,
+		.private = &data
+	};
 
 	if (fuse_is_bad(inode))
 		return;
 
-	max_pages = min_t(unsigned int, fc->max_pages,
-			fc->max_read / PAGE_SIZE);
-
-	/*
-	 * This is only accurate the first time through, since readahead_folio()
-	 * doesn't update readahead_count() from the previous folio until the
-	 * next call.  Grab nr_pages here so we know how many pages we're going
-	 * to have to process.  This means that we will exit here with
-	 * readahead_count() == folio_nr_pages(last_folio), but we will have
-	 * consumed all of the folios, and read_pages() will call
-	 * readahead_folio() again which will clean up the rac.
-	 */
-	nr_pages = readahead_count(rac);
-
-	while (nr_pages) {
-		struct fuse_io_args *ia;
-		struct fuse_args_pages *ap;
-		unsigned cur_pages = min(max_pages, nr_pages);
-		unsigned int pages = 0;
-
-		if (fc->num_background >= fc->congestion_threshold &&
-		    rac->ra->async_size >= readahead_count(rac))
-			/*
-			 * Congested and only async pages left, so skip the
-			 * rest.
-			 */
-			break;
-
-		ia = fuse_io_alloc(NULL, cur_pages);
-		if (!ia)
-			break;
-		ap = &ia->ap;
-
-		while (pages < cur_pages) {
-			unsigned int folio_pages;
-
-			/*
-			 * This returns a folio with a ref held on it.
-			 * The ref needs to be held until the request is
-			 * completed, since the splice case (see
-			 * fuse_try_move_page()) drops the ref after it's
-			 * replaced in the page cache.
-			 */
-			if (!folio)
-				folio =  __readahead_folio(rac);
-
-			folio_pages = folio_nr_pages(folio);
-			if (folio_pages > cur_pages - pages) {
-				/*
-				 * Large folios belonging to fuse will never
-				 * have more pages than max_pages.
-				 */
-				WARN_ON(!pages);
-				break;
-			}
-
-			ap->folios[ap->num_folios] = folio;
-			ap->descs[ap->num_folios].length = folio_size(folio);
-			ap->num_folios++;
-			pages += folio_pages;
-			folio = NULL;
-		}
-		fuse_send_readpages(ia, rac->file, pages << PAGE_SHIFT);
-		nr_pages -= pages;
-	}
-	if (folio) {
-		folio_end_read(folio, false);
-		folio_put(folio);
-	}
+	iomap_readahead(&fuse_iomap_ops, &ctx);
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -2084,7 +2107,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	unsigned int max_folios;
 	/*
-	 * nr_bytes won't overflow since fuse_writepage_need_send() caps
+	 * nr_bytes won't overflow since fuse_folios_need_send() caps
 	 * wb requests to never exceed fc->max_pages (which has an upper bound
 	 * of U16_MAX).
 	 */
@@ -2129,14 +2152,15 @@ static void fuse_writepages_send(struct inode *inode,
 	spin_unlock(&fi->lock);
 }
 
-static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
-				     unsigned len, struct fuse_args_pages *ap,
-				     struct fuse_fill_wb_data *data)
+static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
+				  unsigned len, struct fuse_args_pages *ap,
+				  unsigned cur_bytes, bool write)
 {
 	struct folio *prev_folio;
 	struct fuse_folio_desc prev_desc;
-	unsigned bytes = data->nr_bytes + len;
+	unsigned bytes = cur_bytes + len;
 	loff_t prev_pos;
+	size_t max_bytes = write ? fc->max_write : fc->max_read;
 
 	WARN_ON(!ap->num_folios);
 
@@ -2144,8 +2168,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
 	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
 		return true;
 
-	/* Reached max write bytes */
-	if (bytes > fc->max_write)
+	if (bytes > max_bytes)
 		return true;
 
 	/* Discontinuity */
@@ -2155,11 +2178,6 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
 	if (prev_pos != pos)
 		return true;
 
-	/* Need to grow the pages array?  If so, did the expansion fail? */
-	if (ap->num_folios == data->max_folios &&
-	    !fuse_pages_realloc(data, fc->max_pages))
-		return true;
-
 	return false;
 }
 
@@ -2183,10 +2201,24 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 			return -EIO;
 	}
 
-	if (wpa && fuse_writepage_need_send(fc, pos, len, ap, data)) {
-		fuse_writepages_send(inode, data);
-		data->wpa = NULL;
-		data->nr_bytes = 0;
+	if (wpa) {
+		bool send = fuse_folios_need_send(fc, pos, len, ap,
+						  data->nr_bytes, true);
+
+		if (!send) {
+			/*
+			 * Need to grow the pages array?  If so, did the
+			 * expansion fail?
+			 */
+			send = (ap->num_folios == data->max_folios) &&
+				!fuse_pages_realloc(data, fc->max_pages);
+		}
+
+		if (send) {
+			fuse_writepages_send(inode, data);
+			data->wpa = NULL;
+			data->nr_bytes = 0;
+		}
 	}
 
 	if (data->wpa == NULL) {
-- 
2.47.3


