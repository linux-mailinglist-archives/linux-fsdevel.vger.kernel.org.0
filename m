Return-Path: <linux-fsdevel+bounces-62452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955B4B93BBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 02:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504AF2E0D88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 00:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF722A1C5;
	Tue, 23 Sep 2025 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp47NlUm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80B218AD4
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587654; cv=none; b=bSEzbhDcBwZbWLGlETSkX0vnl+iewC4w9EOU3WZMqHuN3vEqbNjjJ7GZLUP9aDT1Sqj3mIdpgRTTleHi7MsXxf2+R6+EqEeAxWDl8VWvmkAkB+iHA3ufesXn59l7WFT9u2X96ehaPn4/ngkbeMyhYu6eqqQ7eN9S87fPa+qPeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587654; c=relaxed/simple;
	bh=ypJmsZZzQIjX9Jq67MbXjygiUgCiFlBIq0xxOSgSvWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTvp014is+K3wWqx4cgqaaXhf8H++/kdQ0TYOzWFvl758DtbQNIEl3Acr5hW5hX6HJvYIGIeVLZF56IwuScJiOlcLGiscLI8/EOlvHVd9Ag1syGwYOLfmHOFNLAhRsiMloTBdDjPng0PcdOiBky5ph4Z/EORjr2dnunE/BJU69w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jp47NlUm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-273a0aeed57so23268665ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 17:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587652; x=1759192452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kU0v0iMEgBcJDAoZfP+lYeEChpfW5wvYAmw79VihDg0=;
        b=Jp47NlUmcJeGbv32fPfjTj0xf58KZEIEp34eBAcKNNxPVypNYXf8qKS1+44lKyfHvb
         ghWrBdwFAPsu9qMQUe9eTM+GBJ3e0n6krS8qUyOPFSyJRntV4cZMyl7dejsCqbtB/bJI
         nf6y+Amc6woDmzi3e5WKx+SBnFFFA2HNkjmQ/rwNcTEYXzjuqprWoCRurne4zIotUMN1
         BQfxWiji85PWtSpK6brOf4qL2Zx+39p/XEGf7QgUPD8RyXh3IX0QvGiRf6bYosKYsEz9
         0AraJMS6uV4K7vnw8uv4GFA48I0ecQEpmWntQ7sqE2qCkP5o7Zhk8kJQO4BtzlowYQ1B
         pJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587652; x=1759192452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kU0v0iMEgBcJDAoZfP+lYeEChpfW5wvYAmw79VihDg0=;
        b=CCL2amLp+icpSwhyp0F5Pn+Yr1WTCdw9GKCl5o4yiEoo0k1qHuNQwS6NW4tu5WI4cP
         4v6PMRSxsjLIABFOWazU0bw2MUKY8+ExjqRuSPIl7BULFI5YFe+9VlVAqO7SkiKgmraP
         aGR5H54fs2q1c/yJyWZeU8S7dle3yTk1crJgtsbBaPu6N5NX0oXquVIfl4x/kiroD8Of
         9LOJu/R1KoK1/HHY5XLeVzV7dvshLp/JnFyUkEHuq/dPYhKLaoQEZkmQgcAjoxC0tUFb
         jyntCtYppyrPEiA3eO2pl4UXxvjZCl78ulcLDT603BeVzS6RfWHFcU0uF5Uq/7D8x1xT
         fH0w==
X-Forwarded-Encrypted: i=1; AJvYcCXeb4YPgg+dPY1R//aPS3E/GVmtySUw97vQO75Oi2dCWpUnY9/pERjDaFp+qj9MCbD82joRCCSU/HJ+PHsq@vger.kernel.org
X-Gm-Message-State: AOJu0YyN7iK7s2ecnWn5sc/AKgebH4N9RgDzNx3Kj0Ebq8NQeVWL3xdp
	HhOt/LnRtLhNgRSm/n2kFK8It4K4Je1r2iuY/DdS+lgLGplZh0VVWSmA
X-Gm-Gg: ASbGncv8jctu4JON+Poi9xDPpLJvx2fqMIWb1EEUba9gaHTihcTaTl4GRIKx1ohy+3A
	Yelse1CWgCniJN10pMkOS/n6lzzIPkbm7FbVLtYijT/wJDALNq2LbQCHBqu/Z9fIQSEbaqSSl/g
	t4lt9CX7pBp+8BXYSrVVIi0wWCqABMLf7mwAcGOwEpcuhNMJR5iqEEY+8hPbaHe8MjXZszEXosm
	c5Z0SrRWOcV0ed2uqz2Ry0UfffnM7HulQCSItLTRExvjbbgFLnV+1OheVnUIQAZVkYgo/z91cFx
	WBJIFI1weswHspQN3D2OHsF8WAadm0rsDqLKeNcAWQ9ViSJHThMLOWFP0E5Rqpp+jwMuiwyEV4k
	wINdcx18/x/4Yh3sDzujSkoyKkv0nMY6tKPKPi32buaTpcA==
X-Google-Smtp-Source: AGHT+IE45u2AYSpZ/X+cz2viGS2dv7UoQyroi7dyjRLlhnY6SpTjWwNuikdhHg9scMFwgtSnwaChlA==
X-Received: by 2002:a17:902:da8f:b0:24c:db7c:bc34 with SMTP id d9443c01a7336-27cd7e15068mr8534075ad.13.1758587652136;
        Mon, 22 Sep 2025 17:34:12 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698035ddcasm144967435ad.142.2025.09.22.17.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:11 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 14/15] fuse: use iomap for readahead
Date: Mon, 22 Sep 2025 17:23:52 -0700
Message-ID: <20250923002353.2961514-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c | 220 ++++++++++++++++++++++++++++---------------------
 1 file changed, 124 insertions(+), 96 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4f27a3b0c20a..db0b1f20fee4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -844,8 +844,65 @@ static const struct iomap_ops fuse_iomap_ops = {
 
 struct fuse_fill_read_data {
 	struct file *file;
+
+	/* Fields below are used if sending the read request asynchronously */
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
 					     size_t len)
@@ -857,18 +914,40 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
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
 
+static void fuse_iomap_read_submit(struct iomap_read_folio_ctx *ctx)
+{
+	struct fuse_fill_read_data *data = ctx->read_ctx;
+
+	if (data->ia)
+		fuse_send_readpages(data->ia, data->file, data->nr_bytes,
+				    data->fc->async_read);
+}
+
 static const struct iomap_read_ops fuse_iomap_read_ops = {
 	.read_folio_range = fuse_iomap_read_folio_range_async,
+	.submit_read = fuse_iomap_read_submit,
 };
 
 static int fuse_read_folio(struct file *file, struct folio *folio)
@@ -930,7 +1009,8 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	}
 
 	for (i = 0; i < ap->num_folios; i++) {
-		folio_end_read(ap->folios[i], !err);
+		iomap_finish_folio_read(ap->folios[i], ap->descs[i].offset,
+					ap->descs[i].length, err);
 		folio_put(ap->folios[i]);
 	}
 	if (ia->ff)
@@ -940,7 +1020,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 }
 
 static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
-				unsigned int count)
+				unsigned int count, bool async)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
@@ -962,7 +1042,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
 
 	fuse_read_args_fill(ia, file, pos, count, FUSE_READ);
 	ia->read.attr_ver = fuse_get_attr_version(fm->fc);
-	if (fm->fc->async_read) {
+	if (async) {
 		ia->ff = fuse_file_get(ff);
 		ap->args.end = fuse_readpages_end;
 		err = fuse_simple_background(fm, &ap->args, GFP_KERNEL);
@@ -979,81 +1059,20 @@ static void fuse_readahead(struct readahead_control *rac)
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
+		.read_ctx = &data
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
@@ -2084,7 +2103,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	unsigned int max_folios;
 	/*
-	 * nr_bytes won't overflow since fuse_writepage_need_send() caps
+	 * nr_bytes won't overflow since fuse_folios_need_send() caps
 	 * wb requests to never exceed fc->max_pages (which has an upper bound
 	 * of U16_MAX).
 	 */
@@ -2129,14 +2148,15 @@ static void fuse_writepages_send(struct inode *inode,
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
 
@@ -2144,8 +2164,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
 	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
 		return true;
 
-	/* Reached max write bytes */
-	if (bytes > fc->max_write)
+	if (bytes > max_bytes)
 		return true;
 
 	/* Discontinuity */
@@ -2155,11 +2174,6 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
 	if (prev_pos != pos)
 		return true;
 
-	/* Need to grow the pages array?  If so, did the expansion fail? */
-	if (ap->num_folios == data->max_folios &&
-	    !fuse_pages_realloc(data, fc->max_pages))
-		return true;
-
 	return false;
 }
 
@@ -2183,10 +2197,24 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
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


