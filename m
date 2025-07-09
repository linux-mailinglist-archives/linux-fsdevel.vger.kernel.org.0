Return-Path: <linux-fsdevel+bounces-54396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D91AFF471
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299563A10A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C342248F52;
	Wed,  9 Jul 2025 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmPragNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A665246795
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099063; cv=none; b=pRKcHj6gqVin3dJKIk4qFksIecNm2Y7oVkUCqLetUDcQ5oxnnd6Yr4ngBDXCQ+rQ+SgHaCSHOA9/UOE1uNNLBfC4EUEan7gH0n//48I8AMr3zjuTfVM2U+JfKwm8uyGG9iakALpSQdP5TQN9Gtd80vblTAnC3ItcLvciNkhppko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099063; c=relaxed/simple;
	bh=Hzql4pmTRmUrdYKOXgO5Ks0Q2Zi2QvGBfHwHo146pX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQgu2IcWYkJK7ltw1jlNBx25TLxXgjHw2AcnSJku25sIKy7pViT4yy5WjAWlWMvMJRzaL6ici/sH6Ndr7oBc6PyQ5ECLRP1Xsk4Ae3xq2WlYnzsSILjnOUOyIw9wF5vTkrMIg/iVrcmIUtn9dadw+HkhzgRN4WOCYoUnDq8G2Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmPragNT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-236192f8770so3537855ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 15:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752099061; x=1752703861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRjf4w2//ijsH9YUSlOJ/WrYowHn3sowOTgYjPo6T9E=;
        b=SmPragNThk0fcQRiihaBhDBaKymIyjSRN9SNm0UVkXnBYORM+3KV81OBo3cNKxpVyt
         8d8Y3cN58YZn83w2BLyrswD3MmLf3XvPuBbl2i+ysiuCfaM9+yVMFKtJL2BHUROyn/Yh
         NcdnvHH7Cws6KcR/7BYPgvplF82VR9cp79b83sHMbNUnq/Rcza1hoMhUYSlj0eIjmVqP
         V1nGkgvLdR/kcXoVyFqAIAgp+wYdSbasYTpyxvmETULc/G2xYpnamybncAV+Rfql4cpF
         VL0Fj+26uLcQGDNZNuvdKW3VJuNMvN3hHdLvKTNA1RcPv10jjod9SY8wiIAu5fijXk4+
         y8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099061; x=1752703861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRjf4w2//ijsH9YUSlOJ/WrYowHn3sowOTgYjPo6T9E=;
        b=G48PX3hDijjJx34vcWgfBTnAqWpfNphmJTOjwkPVsvFfeYQhu5KgHpWlmabxh73Wz+
         6vbBoCYRChT07KAmn1Zy/rnEoEZxpb8M659css5GgugCufsirUURVU7b7PdoPS4jEgCG
         2zHqsBbqCATdIJZkrzlyuOVIDjzlCJB8VZHJO3x+yYHlgd+/WiW9uEjMMDSlvU4aT+n6
         Y9L5xhVbhTqp2VI/KFCcybY65NVMwZjy4mNaG/VIEk6Fk1Hlqnkc9CSWIaitzylMOOaE
         unc1d9Nq0XRbOh9OCG9YGnD1XqYbO+yXGI9leHDDLxoJkj7SFFJKjnkna+Cx1DW5KPOW
         cl8w==
X-Gm-Message-State: AOJu0YwT6Fc33plK3IQvycGhq3qZZuC4TQ21jb5Gx46+Ng1kGq7WdZIq
	V9JtJYiKYJvENN4B6UlmQ80x47xrlx8k3r8iSz2hYFXa5i0b+QGUK5jqw67T0A==
X-Gm-Gg: ASbGncu6D1dER/Z8FJBMIMdtzGqWRvwNVjT5XrnreSEdWoRfsWNY7bOhFi6+DIRoHvA
	fwFeUeDug1Z7mcWgO7okCe+c8YAAYyTTxORjX1GbOQsEZgeKeGUB6EvVrSQWgCz4jILgK6rTLcg
	NG1Hq2h7vkVJwKwF1zCGsRQCEivJJ9uj/FZdrUnkPC+S5vd91nQxVg8I3FczJOQHdt/WLZJlxdH
	PiJATlwDBJxrFba+CLcycZgQcVLqa8zbSa0yruXifzHf1RKcMzlql5YE/lsfviYPYCp6JONJ1q6
	IDyX5BVu3sOISTlzzV70i/pEu40g3NeXk22eE/P2mnUfiDblsj4FvVKbvrydyPnZRrQ=
X-Google-Smtp-Source: AGHT+IE2G2F30bDcINcQinp+Dh3CUFwdkXs7kJ0QJIdshQFxLhbs2ip/ENpVC1ZotkHmIPjDH9HbBw==
X-Received: by 2002:a17:902:eb83:b0:234:325:500b with SMTP id d9443c01a7336-23de2fb885dmr16323935ad.22.1752099061311;
        Wed, 09 Jul 2025 15:11:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428b489sm1972175ad.31.2025.07.09.15.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:11:01 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	kernel-team@meta.com
Subject: [PATCH v4 2/5] fuse: use iomap for writeback
Date: Wed,  9 Jul 2025 15:10:20 -0700
Message-ID: <20250709221023.2252033-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250709221023.2252033-1-joannelkoong@gmail.com>
References: <20250709221023.2252033-1-joannelkoong@gmail.com>
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
 fs/fuse/file.c | 127 +++++++++++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 51 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index cadad61ef7df..70bbc8f26459 100644
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
@@ -2100,7 +2101,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	struct inode *inode;
 	unsigned int max_folios;
-	unsigned int nr_pages;
+	unsigned int nr_bytes;
 };
 
 static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
@@ -2141,22 +2142,29 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
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
+	loff_t prev_pos;
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
+	prev_pos = folio_pos(prev_folio) + prev_desc.offset + prev_desc.length;
+	if (prev_pos != pos)
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2166,85 +2174,102 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
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
@@ -3104,7 +3129,7 @@ static const struct address_space_operations fuse_file_aops  = {
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


