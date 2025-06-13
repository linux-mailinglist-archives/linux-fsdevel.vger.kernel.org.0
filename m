Return-Path: <linux-fsdevel+bounces-51635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF8DAD97C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CCD1BC3111
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E8F28ECE3;
	Fri, 13 Jun 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLpNIYRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCD201255;
	Fri, 13 Jun 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851474; cv=none; b=XHhPfvoc/MbMdRRCsQiSbJtU5HVbwiTqzi0/oU2dQkQ3Nk4G48H5RsyutnR0tYfDs44hMkHWz3i2F13xG3TJ2RluU5F+fGzHCrWHU5e2VjXEQwAMrC1MCecdnEKHOBHt8q3hIuE66vbRvZoYc6sjxdEA1jv7HQ9CCCKlJRn7UEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851474; c=relaxed/simple;
	bh=U3qz7fly7LAD+q2q3SFyMIsaTOEbWPvn4RsEVJFxfiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s60UGvpBg1LBGmH22pFNO16vka7VROZpbQouNudEZ6OYLb62Tf6BSF4j5O0EoFH7nSueCaCxPzAISAahM5Xlwczx/kxvBCa1aYNCBxFXSC+dSHGH72Nv2U5UM74M0L55rKH8lCKOhLGnGPvY+VHD/VxBXXBwRzSC9a9eu47MDeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLpNIYRT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234d3261631so19288125ad.1;
        Fri, 13 Jun 2025 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851472; x=1750456272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CO8qja0muGQy184cvKsRKL9YcUdeUHs2eXhOYAYeAE=;
        b=YLpNIYRT2iOB58zgCaiZ2rjG2Tp8gYQU5hdQQDROHwe2rIkS3jHUVONKIM9ccRW3nV
         vyy9eSpM0KK5plZevESbNHpuPNVuaVlKaTuZC+d9tHg+lVRqchNXagA2zDKED6TivwE5
         d0W0QJ/Ggs+ij5gQ4nyCWfq5ZHnFy4x/8/ztZkvsulogA6s9Xt230yr7hcKEzQqBFBNE
         0HcoCTOyj5EfQZedwLxxyIc7MBAKHAPLSi9K0xokKzqrIrsAXa+wvaI7FTSz383ObY+C
         YLGBbESEo6xfQxMiIguvk8jdvk8SgXYpEwGiFBY7tlD3C7oInBQeYlZTHrrBBW/AssHQ
         x2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851472; x=1750456272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CO8qja0muGQy184cvKsRKL9YcUdeUHs2eXhOYAYeAE=;
        b=rcnadqSoM0fBiKwu2TW7jAK567SNiTuF2SB9h3QUTBFC3bH4Yq4hVlAQn39+Z0c32J
         GBqs7FQ2E1idEFUsIdQbYhadNZo6AJWotz5uir/7jp3mrQzproeJKATeZsELO8gcxJGz
         lG08RBbNjONg7jqaW/Mk8WfJyXfTr9TueoNQ7Nva06VNx+qSkAqYjPVqsI+AognrvKPt
         QG5FjF/aamNuKME09VQ739uOtwJLKAv6s6j2MbmN6om8ADwe9fLVnvmSIE2sowx0uxZ7
         wboIMHyBPz1/AychnVwdURoerPb4qnJRxZQ7gcZThUkej3hf32RoGZ4dXY3KpQd7iOsn
         /e7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4/CXfnfi03jKokpgzjkFw7EB7J4Ishbw1QtK6zz4jw1wk9HT83Xvan8NLjQr2/6e6qevtT2D00UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcSDkVlvNxWOUfjrEWavLOZYOp1uFJw8LUne4ykbHjBIWFyY/l
	bp+E7KnlZgsIJHdCU/Rb5uKjzR0+7P4K9svpQh6l063ddWywVZ0MAHcY9cMSlQ==
X-Gm-Gg: ASbGnculJKGz83tlnweZEcQFYXYAGOVLJfaAFoIv6Alu6kaeWka4CJmYaZ1rsLePM8Z
	BHwFLPT4ZEWIm34YnsX25AXFSsWPKW2beqqrdCmWwjwXz8MVoB8UYqV4/wjZQGxpiloHF2vOQqR
	Dpsn1tvlp/PUfSJtAjyHr+hLLboYthwJ95SuCRWNjsxgsWsQ6jzl0+1OO/rYqDIW0b9JhPgS0cC
	CK/BiocVAcjE2OeRIjGM7XDdNTqTH/emlt/6vkbxCtK+D0BGuV5aEYYlHNkL8qgQ5x1vGxN3TW2
	v2lghnBsNMZNfnTRqnthu4JpSQdDTblzxMcdMO8d7zk2XcF0jk1Jbqa4xA==
X-Google-Smtp-Source: AGHT+IFwUCu11ourH1acNzAFt13xoYEkH8uuGNTlAhL8mcCEbh8tJN9iQV7IQYILdM95JxxeQOTOSg==
X-Received: by 2002:a17:902:da2d:b0:235:2375:7ead with SMTP id d9443c01a7336-2366b14d317mr15105395ad.28.1749851471952;
        Fri, 13 Jun 2025 14:51:11 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365decad5fsm19484275ad.211.2025.06.13.14.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:51:11 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 15/16] fuse: use iomap for writeback
Date: Fri, 13 Jun 2025 14:46:40 -0700
Message-ID: <20250613214642.2903225-16-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
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

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 118 +++++++++++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 48 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 59ff1dfd755b..db6804f6cc1d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1835,7 +1835,7 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 		 * scope of the fi->lock alleviates xarray lock
 		 * contention and noticeably improves performance.
 		 */
-		folio_end_writeback(ap->folios[i]);
+		iomap_finish_folio_write(inode, ap->folios[i], 1);
 		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
 		wb_writeout_inc(&bdi->wb);
 	}
@@ -2022,19 +2022,20 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
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
@@ -2047,7 +2048,7 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
 		return NULL;
 
 	fuse_writepage_add_to_bucket(fc, wpa);
-	fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio), 0);
+	fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio) + offset, 0);
 	wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
 	wpa->inode = inode;
 	wpa->ia.ff = ff;
@@ -2103,7 +2104,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	struct inode *inode;
 	unsigned int max_folios;
-	unsigned int nr_pages;
+	unsigned int nr_bytes;
 };
 
 static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
@@ -2145,21 +2146,28 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
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
@@ -2169,85 +2177,99 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 	return false;
 }
 
-static int fuse_writepages_fill(struct folio *folio,
-		struct writeback_control *wbc, void *_data)
+static int fuse_iomap_writeback_folio(struct iomap_writeback_folio_range *ctx)
 {
-	struct fuse_fill_wb_data *data = _data;
+	struct fuse_fill_wb_data *data = ctx->wpc->private;
 	struct fuse_writepage_args *wpa = data->wpa;
+	struct folio *folio = ctx->folio;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
-	struct inode *inode = data->inode;
-	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct inode *inode = folio->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	int err;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	loff_t offset = offset_in_folio(folio, ctx->pos);
+	unsigned len = ctx->dirty_len;
+
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
+	ctx->async_writeback = true;
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
+	return 0;
+}
+
+static int fuse_iomap_writeback_complete(struct iomap_writepage_ctx *wpc, int error)
+{
+	struct fuse_fill_wb_data *data = wpc->private;
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
+	.writeback_folio	= fuse_iomap_writeback_folio,
+	.writeback_complete	= fuse_iomap_writeback_complete,
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
+		.iomap.type = IOMAP_MAPPED,
+		.private = &data,
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
+	return iomap_writepages(mapping, wbc, &wpc, &fuse_writeback_ops);
 }
 
 static int fuse_launder_folio(struct folio *folio)
-- 
2.47.1


