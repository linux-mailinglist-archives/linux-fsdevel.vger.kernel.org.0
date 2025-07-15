Return-Path: <linux-fsdevel+bounces-55029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECE3B067B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 22:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD6D4E84AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62BE2727E5;
	Tue, 15 Jul 2025 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ+obPOz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81B277CBD
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610970; cv=none; b=u2GjzTiOFGN9pOhd5laTXPn+G7T/OACcvSatOxO+PmMa4JzELSECzsrSbsYIQypfJxWVUUpLiQ7pg5Ln0NBiY4ifCxaNEJx2R2shzdQxGltzr/etFpNW1wl82duFUe8N/rFeyZgkJeXu/8witw++RebL+DDFpBhSrKJOeZN/1g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610970; c=relaxed/simple;
	bh=78CE4D/Hqdt9Vwyz03oL3pHy7+aznp6bdmdCKxooDHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQZQUSJ5XaSASyJz+ojw4rytbnitYG9m+9MKih9UK6miylmmYvrtKPaYfn1n+SbhYZb0tLPAVsNZ7Yj1cWpMZscmWI3fU7Euvl9guoQIHQsFdek5rJJySpOGB9ZDI+aCdlFcQYJqskuj5C+cvNwOywqJrKsNUwlqZkZsxFDXCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ+obPOz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so5902882a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752610968; x=1753215768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbM4zj2BR4Hp8L+ytw4ZF+hhyUVA3XJSlSpv61QpcgE=;
        b=YZ+obPOz7w0W6bs+6Usg8Bshu2bUKAQeZKTfweU7E1/L7d9HV3KgxqJlqoN/f3nc+R
         KLaERH07Kt308z0cY4YeYYu2xqwXQXPu6uSLcQANOsS4Qu6hDqXWhqJWOAg9ZDQOoRrT
         fhUwgCFvqEqNYuhElAJoylro6R/8qibEWUyCBcblnOpGsJtqWWDLpLPrVodmw/jXRoE4
         KakK3ZJvQnJZ9x6QBfQ9qddIa3OsWs4ip6uZR3KgTAHpLm+ISxklgbAqKenVI4XwYLkk
         aa6q54crOZe+YH3pKaDGoSgC/BtltZ17ao4PulfMKKwMKdTErdwj50CmcviQKL1pWJQ2
         xI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752610968; x=1753215768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbM4zj2BR4Hp8L+ytw4ZF+hhyUVA3XJSlSpv61QpcgE=;
        b=m1HPIEBhnZ6AblfQJjfPLqHHmLYwfbEjJidkgyHhh60+hTpbaF+5K4zTpNSntOGerZ
         OhUApX8tb6CJbffnUTN/4/5nFuPv9O5d24dyxNDXdRDVjrNI5/QXfAtW5pHXSHztmD1Z
         NBZNsYj/14WUmnSoIcruW/5wewFen2etP59zI1rUYiOF0hK+MdYUueRywgEWqr7PclqO
         n6HR7q2dPJMkCSF1aTvNLR9RHPJ0sD4bkdcydD+zArc9jar7+ARMt92WdpVdIee5swC2
         fAR2+yi7Q/z1GuWQzfxBJhNgsK5qeHVAiAh5FW7di4oUOjEr9OXPD+tP1cLLA9h55+XM
         2Teg==
X-Gm-Message-State: AOJu0YztduilFE9+nh9P6EBEH7K1jVD9Gfc/5fpQLEKk/IkeG5H6++VQ
	xdUPCkmvPAcWVtqTDvWTbJC/V8mT1k1v0ID/nEoKfokZppD5TmgnyWs4YbA5bA==
X-Gm-Gg: ASbGnculsaBLH9QDKiHu1WrQ/pg8XA2rkwY3vC/4gJzIwZYPxhz3JsuLAwaEeFIB+OC
	9l+3sryNs8urmOGHE7361rNbTHXYOP50i7Bgrh9/a0+suUoXbMm+ZwXwast+aUxqvgqMsDztsSK
	bxN5LHIEHSnbP5Rwlk4zAlks9Pr9efrtAoQK9mFOh1S9eaN4n+L/RHjYpn9cUQi6so2zwTpGmQp
	ys0PGFAAOoe4xoFL8VzsoA9IVrsNn/j8zSXJFP/NHsxW7sdJ98gsjX01JzVfzktWosEtlsz/n3m
	7VwyIcUI+i5isK70yg/oCECoYky8tDnxhoo3xdZcgbgryztQpEMv2PtZIBLxF94EVTvC4PnSNg2
	ysl4U+SsAAdbPAwJeGV7z6xfEcp8g
X-Google-Smtp-Source: AGHT+IEQhDnhrZiN2nNpdVYJ6N1ynWasizdB9rDg5ICCaJrkUoQqkjhNhKOw1nTWCGw2d1a0L7e8LA==
X-Received: by 2002:a17:90b:5610:b0:2ff:6167:e92d with SMTP id 98e67ed59e1d1-31c9e7a3087mr666456a91.32.1752610967454;
        Tue, 15 Jul 2025 13:22:47 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9159ec07sm1141216a91.0.2025.07.15.13.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:22:47 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	kernel-team@meta.com
Subject: [PATCH v5 2/5] fuse: use iomap for writeback
Date: Tue, 15 Jul 2025 13:21:19 -0700
Message-ID: <20250715202122.2282532-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250715202122.2282532-1-joannelkoong@gmail.com>
References: <20250715202122.2282532-1-joannelkoong@gmail.com>
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
 fs/fuse/file.c | 133 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 82 insertions(+), 51 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index cadad61ef7df..93a96cdf56e1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1832,7 +1832,7 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 		 * scope of the fi->lock alleviates xarray lock
 		 * contention and noticeably improves performance.
 		 */
-		folio_end_writeback(ap->folios[i]);
+		iomap_finish_folio_write(inode, ap->folios[i], 1);
 		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
 		wb_writeout_inc(&bdi->wb);
 	}
@@ -2019,19 +2019,20 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
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
@@ -2044,7 +2045,7 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
 		return NULL;
 
 	fuse_writepage_add_to_bucket(fc, wpa);
-	fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio), 0);
+	fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio) + offset, 0);
 	wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
 	wpa->inode = inode;
 	wpa->ia.ff = ff;
@@ -2070,7 +2071,7 @@ static int fuse_writepage_locked(struct folio *folio)
 	if (!ff)
 		goto err;
 
-	wpa = fuse_writepage_args_setup(folio, ff);
+	wpa = fuse_writepage_args_setup(folio, 0, ff);
 	error = -ENOMEM;
 	if (!wpa)
 		goto err_writepage_args;
@@ -2079,7 +2080,7 @@ static int fuse_writepage_locked(struct folio *folio)
 	ap->num_folios = 1;
 
 	folio_start_writeback(folio);
-	fuse_writepage_args_page_fill(wpa, folio, 0);
+	fuse_writepage_args_page_fill(wpa, folio, 0, 0, folio_size(folio));
 
 	spin_lock(&fi->lock);
 	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
@@ -2100,7 +2101,12 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	struct inode *inode;
 	unsigned int max_folios;
-	unsigned int nr_pages;
+	/*
+	 * nr_bytes won't overflow since fuse_writepage_need_send() caps
+	 * wb requests to never exceed fc->max_pages (which has an upper bound
+	 * of U16_MAX).
+	 */
+	unsigned int nr_bytes;
 };
 
 static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
@@ -2141,22 +2147,30 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 	spin_unlock(&fi->lock);
 }
 
-static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
-				     struct fuse_args_pages *ap,
+static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
+				     unsigned len, struct fuse_args_pages *ap,
 				     struct fuse_fill_wb_data *data)
 {
+	struct folio *prev_folio;
+	struct fuse_folio_desc prev_desc;
+	unsigned bytes = data->nr_bytes + len;
+	loff_t prev_pos;
+
 	WARN_ON(!ap->num_folios);
 
 	/* Reached max pages */
-	if (data->nr_pages + folio_nr_pages(folio) > fc->max_pages)
+	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
 		return true;
 
 	/* Reached max write bytes */
-	if ((data->nr_pages * PAGE_SIZE) + folio_size(folio) > fc->max_write)
+	if (bytes > fc->max_write)
 		return true;
 
 	/* Discontinuity */
-	if (folio_next_index(ap->folios[ap->num_folios - 1]) != folio->index)
+	prev_folio = ap->folios[ap->num_folios - 1];
+	prev_desc = ap->descs[ap->num_folios - 1];
+	prev_pos = folio_pos(prev_folio) + prev_desc.offset + prev_desc.length;
+	if (prev_pos != pos)
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2166,85 +2180,102 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
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
+	if (wpa && fuse_writepage_need_send(fc, pos, len, ap, data)) {
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
+	iomap_start_folio_write(inode, folio, 1);
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
+}
+
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
 }
 
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
@@ -3104,7 +3135,7 @@ static const struct address_space_operations fuse_file_aops  = {
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


