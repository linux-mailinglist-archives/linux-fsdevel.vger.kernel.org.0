Return-Path: <linux-fsdevel+bounces-59696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41362B3C5F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 02:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE217BC286
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD1D1D5CDE;
	Fri, 29 Aug 2025 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6itFLTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F023148B2;
	Fri, 29 Aug 2025 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511920; cv=none; b=lxmLHBJMmvIZpkyC4fqdTocXBr1HaNr6TddvjSHGpj//RFFdW9PFeyvLhGFZBygNPInSp/GRroRSF4ZpS4AOHu+csuIIZ84l2oE1AXaDbjvQDKlhieRVrmo6OXtYsQk6z+rmAYRcOxu2fiSqUV4VQ8wIyYNohPcjiTcnNVDGfPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511920; c=relaxed/simple;
	bh=SX6UBnNuLVvp38i751PCm+t1eGfiEsq6fUYt3wZ1Qrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVudVrHLOstLfk8Edx1ByQUMt5kV5am9JN6LavOOfGVFrtgBcgiReSYgKR6qWZ7nXA6Pe4JcJ7QMKMwMW9dKRnjN+Xi8VLuGWvxUxUdI40yFzJHc75QKASs6RUWbCkl/LoGsfRT/Oo4vCr1dxoR4/wfFBy2Q8ZEpN6aCPgGdA7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6itFLTw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso1819676a12.1;
        Fri, 29 Aug 2025 16:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511918; x=1757116718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSK6KszMPq5vSxZnOVYprkCfKLdpk/a+d6NMuni1H1Y=;
        b=B6itFLTwNstsQLoUyzindd4qAMtTb2Ul3a3E4me10JEcRtNyw+cKd2KspS9+rxnurW
         v2Xg8wpi5Hz+74Kos0tSa1E+78SBjyV4ax03jBzshPmMKrUeJqSXY4+w7eG333thWTJf
         K4H6PZDsWHCc64UZbgIA+cC9C+S3A81T28CLh1QfQobHuxXv6uM6S9Ksb8GrozQeMuxZ
         Ogx+RvUZtBPdDVBbipPs/IUDqNWtqXbSGfUOVe6KTMCTkbgU/taDy1Vafu/A6Dtiq3uk
         piC8UTZkRkicFZdPpbAQVXmUEZJ51N5ZB63lBJqOtIk9rj/Tav4DLkvonkqHZ79Ulvhm
         Rq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511918; x=1757116718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSK6KszMPq5vSxZnOVYprkCfKLdpk/a+d6NMuni1H1Y=;
        b=e0nMt2KpnTr0bJlVyPnVT7/DmDv7/lpaP2+B8zyyVZbof7CDE2nswogOqLqYcIoOS9
         0JhobJaUM8M8yc1C6GTJ/pl1zLIfzEhs6xkgqQdbfxCpoJNdQ4lqDIZSbFeTrL4W690z
         nEgwo+dsTwoE4Bgm4/WtXCy+GgP/8rLcsy8wNBXGnF/BcqvN1WjHZQDys2dBgESWyIa/
         CC1igMhmtuTzn/vpXK3E7GlB67MfjAa9+zHA1Ugkaex6SCy0wE7pbd2zUAFEOg6g6RZG
         VqvBATc7qEtcJ5fqax7QcGSj3LlsnUg9NcOq4DCUv3PG6XIw6m/nUxc1ezYv+Nj2AsA1
         pm5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5qYX9Gl4v4yyQKaPwkWkGMPKv7tzemBZNQWlSU5vllnBr2guT6nTNiB5opqLGbzDcVHOgcHPwAD9vg3Ug8Q==@vger.kernel.org, AJvYcCVRSbYPiX7u2j9Vw3+1xLTbnCH/ia0MjktoSTZkXmlqxxGTXwGxFlvUefhY/z7W5/vjLWpO0ho6kp0=@vger.kernel.org, AJvYcCXh31xjei3QK2D0Q50U4E2urMVQc0RlUFXmYSJ/qdUthWooTo0y0Hw9Z6QlxlnoK/ejHsgZ19oPj6m1@vger.kernel.org
X-Gm-Message-State: AOJu0YzXrDIjxQve4jQh33wouM9VgJmZNW4WTDlz70fn45blg9EW7M/F
	6HflkxZGkRwTuyD34UM1DPg1B8PwUpdQTekfSlsouxEMSY7M8TAXXClg
X-Gm-Gg: ASbGncs5H0xhqSw5gI61k0nnTxsaUylOdNFRXZkuqWKeBDcVP4mOjh1cNIZc2FL3WSf
	3AFaWvfrVRbDzhaO4XNWajt4rTCCRA3KLxr4RjM3C2VxVyyt0GGR/d/SdhZR4m/0DEm3pzPymDg
	oemvw3DvqRuKBGM84jTSX1OoS5qzIhKwQyVvdgb8fkhT/TJUCkv4lw3xkqUZQOxtGcDY/NqCl/c
	rVwGyVe/t+sGZfwCNIpcPcDyMVYnQE7qcNk2KPHi5DIbF6Ky8qvW0NpXWaZsO01D3Q17j6q7WgJ
	fGi7VHaTrZtrHa1xIa6ybmsW5UPbF/RnsFnf+Ei9XBl57/d3AeRxJljT1AA1Wg65Mp4W4aGdjsT
	vjg0abpDRoSi9tGFX+KLRRHi+NXsZ
X-Google-Smtp-Source: AGHT+IFCdp9N0O3aBk7e9o7MqDJ5teN4tmcpvOymBpdjxOFiLSzLyq/qzEOn2DRbw/lzIzXeZt3qCA==
X-Received: by 2002:a17:903:2342:b0:248:cd0b:3462 with SMTP id d9443c01a7336-2494488a6ddmr4776875ad.4.1756511917663;
        Fri, 29 Aug 2025 16:58:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da478fsm36337965ad.65.2025.08.29.16.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:37 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 15/16] fuse: use iomap for readahead
Date: Fri, 29 Aug 2025 16:56:26 -0700
Message-ID: <20250829235627.4053234-16-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829235627.4053234-1-joannelkoong@gmail.com>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
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
 fs/fuse/file.c | 214 +++++++++++++++++++++++++++----------------------
 1 file changed, 118 insertions(+), 96 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bdfb13cdee4b..1659603f4cb6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -844,8 +844,73 @@ static const struct iomap_ops fuse_iomap_ops = {
 
 struct fuse_fill_read_data {
 	struct file *file;
+	/*
+	 * We need to track this because non-readahead requests can't be sent
+	 * asynchronously.
+	 */
+	bool readahead : 1;
+
+	/*
+	 * Fields below are used if sending the read request
+	 * asynchronously.
+	 */
+	struct fuse_conn *fc;
+	struct readahead_control *rac;
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
+				 struct fuse_fill_read_data *data, loff_t pos,
+				 size_t len)
+{
+	struct fuse_io_args *ia = data->ia;
+	size_t off = offset_in_folio(folio, pos);
+	struct fuse_conn *fc = data->fc;
+	struct fuse_args_pages *ap;
+
+	if (ia && fuse_folios_need_send(fc, pos, len, &ia->ap, data->nr_bytes,
+					false)) {
+		fuse_send_readpages(ia, data->file, data->nr_bytes,
+				    fc->async_read);
+		data->nr_bytes = 0;
+		ia = NULL;
+	}
+	if (!ia) {
+		struct readahead_control *rac = data->rac;
+		unsigned nr_pages = min(fc->max_pages, readahead_count(rac));
+
+		if (fc->num_background >= fc->congestion_threshold &&
+		    rac->ra->async_size >= readahead_count(rac))
+			/*
+			 * Congested and only async pages left, so skip the
+			 * rest.
+			 */
+			return -EAGAIN;
+
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
 					     struct folio *folio, loff_t pos,
 					     size_t len)
@@ -855,13 +920,24 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
 	size_t off = offset_in_folio(folio, pos);
 	int ret;
 
-	/*
-	 *  for non-readahead read requests, do reads synchronously since
-	 *  it's not guaranteed that the server can handle out-of-order reads
-	 */
 	iomap_start_folio_read(folio, len);
-	ret = fuse_do_readfolio(file, folio, off, len);
-	iomap_finish_folio_read(folio, off, len, ret);
+	if (data->readahead) {
+		ret = fuse_handle_readahead(folio, data, pos, len);
+		/*
+		 * If fuse_handle_readahead was successful, fuse_readpages_end
+		 * will do the iomap_finish_folio_read, else we need to call it
+		 * here
+		 */
+		if (ret)
+			iomap_finish_folio_read(folio, off, len, ret);
+	} else {
+		/*
+		 *  for non-readahead read requests, do reads synchronously since
+		 *  it's not guaranteed that the server can handle out-of-order reads
+		 */
+		ret = fuse_do_readfolio(file, folio, off, len);
+		iomap_finish_folio_read(folio, off, len, ret);
+	}
 	return ret;
 }
 
@@ -923,7 +999,8 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	}
 
 	for (i = 0; i < ap->num_folios; i++) {
-		folio_end_read(ap->folios[i], !err);
+		iomap_finish_folio_read(ap->folios[i], ap->descs[i].offset,
+					ap->descs[i].length, err);
 		folio_put(ap->folios[i]);
 	}
 	if (ia->ff)
@@ -933,7 +1010,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 }
 
 static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
-				unsigned int count)
+				unsigned int count, bool async)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
@@ -955,7 +1032,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
 
 	fuse_read_args_fill(ia, file, pos, count, FUSE_READ);
 	ia->read.attr_ver = fuse_get_attr_version(fm->fc);
-	if (fm->fc->async_read) {
+	if (async) {
 		ia->ff = fuse_file_get(ff);
 		ap->args.end = fuse_readpages_end;
 		err = fuse_simple_background(fm, &ap->args, GFP_KERNEL);
@@ -972,81 +1049,20 @@ static void fuse_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	unsigned int max_pages, nr_pages;
-	struct folio *folio = NULL;
+	struct fuse_fill_read_data data = {
+		.file = rac->file,
+		.readahead = true,
+		.fc = fc,
+		.rac = rac,
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
+	iomap_readahead(rac, &fuse_iomap_ops, &fuse_iomap_read_ops, &data);
+	if (data.ia)
+		fuse_send_readpages(data.ia, data.file, data.nr_bytes,
+				    fc->async_read);
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -2077,7 +2093,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	unsigned int max_folios;
 	/*
-	 * nr_bytes won't overflow since fuse_writepage_need_send() caps
+	 * nr_bytes won't overflow since fuse_folios_need_send() caps
 	 * wb requests to never exceed fc->max_pages (which has an upper bound
 	 * of U16_MAX).
 	 */
@@ -2122,14 +2138,15 @@ static void fuse_writepages_send(struct inode *inode,
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
 
@@ -2137,8 +2154,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
 	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
 		return true;
 
-	/* Reached max write bytes */
-	if (bytes > fc->max_write)
+	if (bytes > max_bytes)
 		return true;
 
 	/* Discontinuity */
@@ -2148,11 +2164,6 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
 	if (prev_pos != pos)
 		return true;
 
-	/* Need to grow the pages array?  If so, did the expansion fail? */
-	if (ap->num_folios == data->max_folios &&
-	    !fuse_pages_realloc(data, fc->max_pages))
-		return true;
-
 	return false;
 }
 
@@ -2176,10 +2187,21 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 			return -EIO;
 	}
 
-	if (wpa && fuse_writepage_need_send(fc, pos, len, ap, data)) {
-		fuse_writepages_send(inode, data);
-		data->wpa = NULL;
-		data->nr_bytes = 0;
+	if (wpa) {
+		bool send = fuse_folios_need_send(fc, pos, len, ap, data->nr_bytes,
+						  true);
+
+		if (!send) {
+			/* Need to grow the pages array?  If so, did the expansion fail? */
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


