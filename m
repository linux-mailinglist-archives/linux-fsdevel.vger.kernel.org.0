Return-Path: <linux-fsdevel+bounces-52673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88725AE5A0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBBD1BC1397
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8371925744F;
	Tue, 24 Jun 2025 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUOFCHly"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB023BCF5;
	Tue, 24 Jun 2025 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731799; cv=none; b=tQR45opatUN4p8jbPxCHuKFe2gU9oeztqIEIQyQ6SrrOy2lcNt/Xtec2ELxvfvnqo0awbvGFZQjiGvZsJm0FOLNFGAzDJiTXBHfIKOTk+rc+jM3eez9FmrO8DSEQoOxlMHD3m9Yv9sbqnH50sP2/RHKCrDM7bzfI235Y02Br3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731799; c=relaxed/simple;
	bh=xPI4TWcQbS7M7QVCzpfeAKRtMJX614jM/7cR7a+1Vmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URv31uNftq5s3+/1zkjq5A93j5KBDBCxNFpt613R0ROqrt5GZvw6ipQEz453mc14GQCgNkU4XNz9DS7ikzaF43icWZKlqXreLonmBLYVg6947Myoslu8SQxWBlCQ9dy7lax5d8cxK/4SreND6env0aDJcCakMp//4XIDbHcgxyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUOFCHly; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234b9dfb842so42910225ad.1;
        Mon, 23 Jun 2025 19:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731796; x=1751336596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpKKxlFsnVnwGn9tqqMouy+P4/pVETZ3pfuH3gqobfw=;
        b=KUOFCHlyx7mwpJV4Lq0wXUy9YsgBoDXer/THm1vqKclLGx0xrcxPs1AI8oCu4f64Em
         juzgrMN3kJgJ5lYuGH48jX1VaR9cNjvZ4Ol0m/cNeHRnbK3DD36yHuU3XOJxqhNt0QjU
         ZJZJZjTOE/izaj6g1pvfj27CjIUuL88mfIjv9uykdZRNm5C6wxdx0LcmAl/EDmQ0F9w0
         fAsPgk1CHaIrYLPVXEnBJsZibdMhK8gor/Y5X8iOL4B0BkHLEcYIBLn1O+YK6MgWJr+J
         r/EEh3mZKnKkXFkKajaIDtDDzj/kFMXnqte7ERLdOmr90OXQkfmEXqs7VIIBqayJ4c+A
         +N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731796; x=1751336596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpKKxlFsnVnwGn9tqqMouy+P4/pVETZ3pfuH3gqobfw=;
        b=YTHYCLGZqDP4cwiaZVc7+KfgN1J52ew6hppog6gEiPPGn+XRb1q/QWLDBZkwlJa3Ja
         AwqtpTtGlaz/eiHScE7QfyDOm1U0TwDXmSvrE8cEepmD1b5hWhiBdhNXkeFZOXzcKSp4
         VnZPmgamq5JtBrN+oQGjLH9jBrH4cMicSFFGoQQRsjgIT6HKPrQD2cHlUokquz6TezTD
         WCLKjOFLrFBS8h+MTYf1rXBS2NrCmxSvY8yUoDmZMogWXaI6OOIRj5LCG3wsqiEwMdPq
         rPrikIQ9Bggaf8hOjuuVsZzXdlBLoLPMww7Ok0YrA9dVM4ChI6O3G5P+ykdswnj4xX0t
         Fndw==
X-Forwarded-Encrypted: i=1; AJvYcCVEvNtF0QMZRbilfL2GT1etBOyNhHC/yTRoWFJ8OQC4C260rMkVFddiUjzKLVAaJPPVLR3TGvXt0kL6@vger.kernel.org, AJvYcCVk0RdDtaZsCRfuJZG41E/A/vnt6doQdeQJTbN/HwzcFmI48TdjmP7b4Dwq8neviV8Che1OJVwz8YlY@vger.kernel.org, AJvYcCW4BwDZ6dhzHXbSVFqHc34hEq7FlSTVZYCb4sAC905rkRydBTUn9FZpMjDRgmhFCajCtioPv8Wcn0EJFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYrju355x/4/Ze9qzS7thmtEYoMyNt8D0XYbm1h/ROWqgrxzhS
	fzZlpjPc0MXVchdXbltXFMvoRIzqSJ0dDQwyqyupIxzy/snQ8qi7yfnh1hDGqg==
X-Gm-Gg: ASbGncsVO7Y14n2OQtmxZG+luyHEeIJJ9+8Wm9TmfEjFInlHGqY7bGiXgsuEsJsyUU1
	642BBGtQQG45W7RcYtnw032lqi1tQhfQ/ktYXTCiABCqVoiuLL9IbZjTi3NXqJn0cJkg7oc75Cs
	Ny3RtoY/bVVF2M7Id6Gzsh6Dw24/b+Rlm9pA1cKnN1DlYAvbqTtQZ0CEeUEP+UT0T5pFYPje3jR
	VyacWTUX0ZSCMMpvVbtFtTw5O79BCLSehlV1EL6+9A3ztvx1LJnh5N4bKAfXYiHGpdn8myAn51h
	VJtK2ZiivPEqynhe5NM3bxyaMFI5iTO3jeQbFhEY1Pt8lud4VDtWFPVr
X-Google-Smtp-Source: AGHT+IHyOQ/+PMnBaCWpHdXh0kkik6NWpgz9bIa4pG6Fcdcb1I1Efz19MvlCcAblBRm5gyV4SxJNEg==
X-Received: by 2002:a17:902:f68b:b0:236:6f5f:cab4 with SMTP id d9443c01a7336-237d9875dffmr251963385ad.5.1750731796353;
        Mon, 23 Jun 2025 19:23:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1258b55sm7693494a12.61.2025.06.23.19.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:16 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 13/16] fuse: use iomap for writeback
Date: Mon, 23 Jun 2025 19:21:32 -0700
Message-ID: <20250624022135.832899-14-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use iomap for dirty folio writeback in ->writepages().
This allows for granular dirty writeback of large folios.

Only the dirty portions of the large folio will be written instead of
having to write out the entire folio. For example if there is a 1 MB
large folio and only 2 bytes in it are dirty, only the page for those
dirty bytes will be written out.

.dirty_folio needs to be set to iomap_dirty_folio so that the bitmap
iomap uses for dirty tracking correctly reflects dirty regions that need
to be written back.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 124 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 75 insertions(+), 49 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a7f11c1a4f89..2b4b950eaeed 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1837,7 +1837,7 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 		 * scope of the fi->lock alleviates xarray lock
 		 * contention and noticeably improves performance.
 		 */
-		folio_end_writeback(ap->folios[i]);
+		iomap_finish_folio_write(inode, ap->folios[i], 1);
 		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
 		wb_writeout_inc(&bdi->wb);
 	}
@@ -2024,19 +2024,20 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
 }
 
 static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
-					  uint32_t folio_index)
+					  uint32_t folio_index, loff_t offset, unsigned len)
 {
 	struct inode *inode = folio->mapping->host;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 
 	ap->folios[folio_index] = folio;
-	ap->descs[folio_index].offset = 0;
-	ap->descs[folio_index].length = folio_size(folio);
+	ap->descs[folio_index].offset = offset;
+	ap->descs[folio_index].length = len;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 }
 
 static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
+							     size_t offset,
 							     struct fuse_file *ff)
 {
 	struct inode *inode = folio->mapping->host;
@@ -2049,7 +2050,7 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
 		return NULL;
 
 	fuse_writepage_add_to_bucket(fc, wpa);
-	fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio), 0);
+	fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio) + offset, 0);
 	wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
 	wpa->inode = inode;
 	wpa->ia.ff = ff;
@@ -2075,7 +2076,7 @@ static int fuse_writepage_locked(struct folio *folio)
 	if (!ff)
 		goto err;
 
-	wpa = fuse_writepage_args_setup(folio, ff);
+	wpa = fuse_writepage_args_setup(folio, 0, ff);
 	error = -ENOMEM;
 	if (!wpa)
 		goto err_writepage_args;
@@ -2084,7 +2085,7 @@ static int fuse_writepage_locked(struct folio *folio)
 	ap->num_folios = 1;
 
 	folio_start_writeback(folio);
-	fuse_writepage_args_page_fill(wpa, folio, 0);
+	fuse_writepage_args_page_fill(wpa, folio, 0, 0, folio_size(folio));
 
 	spin_lock(&fi->lock);
 	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
@@ -2105,7 +2106,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	struct inode *inode;
 	unsigned int max_folios;
-	unsigned int nr_pages;
+	unsigned int nr_bytes;
 };
 
 static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
@@ -2147,21 +2148,28 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 }
 
 static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
+				     loff_t offset, unsigned len,
 				     struct fuse_args_pages *ap,
 				     struct fuse_fill_wb_data *data)
 {
+	struct folio *prev_folio;
+	struct fuse_folio_desc prev_desc;
+
 	WARN_ON(!ap->num_folios);
 
 	/* Reached max pages */
-	if (data->nr_pages + folio_nr_pages(folio) > fc->max_pages)
+	if ((data->nr_bytes + len) / PAGE_SIZE > fc->max_pages)
 		return true;
 
 	/* Reached max write bytes */
-	if ((data->nr_pages * PAGE_SIZE) + folio_size(folio) > fc->max_write)
+	if (data->nr_bytes + len > fc->max_write)
 		return true;
 
 	/* Discontinuity */
-	if (folio_next_index(ap->folios[ap->num_folios - 1]) != folio->index)
+	prev_folio = ap->folios[ap->num_folios - 1];
+	prev_desc = ap->descs[ap->num_folios - 1];
+	if ((folio_pos(prev_folio) + prev_desc.offset + prev_desc.length) !=
+	    folio_pos(folio) + offset)
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2171,85 +2179,103 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 	return false;
 }
 
-static int fuse_writepages_fill(struct folio *folio,
-		struct writeback_control *wbc, void *_data)
+static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
+					  struct folio *folio, u64 pos,
+					  unsigned len, u64 end_pos)
 {
-	struct fuse_fill_wb_data *data = _data;
+	struct fuse_fill_wb_data *data = wpc->wb_ctx;
 	struct fuse_writepage_args *wpa = data->wpa;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = data->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	int err;
+	loff_t offset = offset_in_folio(folio, pos);
+
+	WARN_ON_ONCE(!data);
+	/* len will always be page aligned */
+	WARN_ON_ONCE(len & (PAGE_SIZE - 1));
 
 	if (!data->ff) {
-		err = -EIO;
 		data->ff = fuse_write_file_get(fi);
 		if (!data->ff)
-			goto out_unlock;
+			return -EIO;
 	}
 
-	if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
+	iomap_start_folio_write(inode, folio, 1);
+
+	if (wpa && fuse_writepage_need_send(fc, folio, offset, len, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
-		data->nr_pages = 0;
+		data->nr_bytes = 0;
 	}
 
 	if (data->wpa == NULL) {
-		err = -ENOMEM;
-		wpa = fuse_writepage_args_setup(folio, data->ff);
+		wpa = fuse_writepage_args_setup(folio, offset, data->ff);
 		if (!wpa)
-			goto out_unlock;
+			return -ENOMEM;
 		fuse_file_get(wpa->ia.ff);
 		data->max_folios = 1;
 		ap = &wpa->ia.ap;
 	}
-	folio_start_writeback(folio);
 
-	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios);
-	data->nr_pages += folio_nr_pages(folio);
+	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios,
+				      offset, len);
+	data->nr_bytes += len;
 
-	err = 0;
 	ap->num_folios++;
 	if (!data->wpa)
 		data->wpa = wpa;
-out_unlock:
-	folio_unlock(folio);
 
-	return err;
+	return len;
 }
 
+static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
+				       int error)
+{
+	struct fuse_fill_wb_data *data = wpc->wb_ctx;
+
+	WARN_ON_ONCE(!data);
+
+	if (data->wpa) {
+		WARN_ON(!data->wpa->ia.ap.num_folios);
+		fuse_writepages_send(data);
+	}
+
+	if (data->ff)
+		fuse_file_put(data->ff, false);
+
+	return error;
+}
+
+static const struct iomap_writeback_ops fuse_writeback_ops = {
+	.writeback_range	= fuse_iomap_writeback_range,
+	.writeback_submit	= fuse_iomap_writeback_submit,
+};
+
 static int fuse_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
 	struct inode *inode = mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_fill_wb_data data;
-	int err;
+	struct fuse_fill_wb_data data = {
+		.inode = inode,
+	};
+	struct iomap_writepage_ctx wpc = {
+		.inode = inode,
+		.iomap.type = IOMAP_MAPPED,
+		.wbc = wbc,
+		.ops = &fuse_writeback_ops,
+		.wb_ctx	= &data,
+	};
 
-	err = -EIO;
 	if (fuse_is_bad(inode))
-		goto out;
+		return -EIO;
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
 	    fc->num_background >= fc->congestion_threshold)
 		return 0;
 
-	data.inode = inode;
-	data.wpa = NULL;
-	data.ff = NULL;
-	data.nr_pages = 0;
-
-	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
-	if (data.wpa) {
-		WARN_ON(!data.wpa->ia.ap.num_folios);
-		fuse_writepages_send(&data);
-	}
-	if (data.ff)
-		fuse_file_put(data.ff, false);
-
-out:
-	return err;
+	return iomap_writepages(&wpc);
 }
 
 static int fuse_launder_folio(struct folio *folio)
@@ -3109,7 +3135,7 @@ static const struct address_space_operations fuse_file_aops  = {
 	.readahead	= fuse_readahead,
 	.writepages	= fuse_writepages,
 	.launder_folio	= fuse_launder_folio,
-	.dirty_folio	= filemap_dirty_folio,
+	.dirty_folio	= iomap_dirty_folio,
 	.release_folio	= iomap_release_folio,
 	.migrate_folio	= filemap_migrate_folio,
 	.bmap		= fuse_bmap,
-- 
2.47.1


