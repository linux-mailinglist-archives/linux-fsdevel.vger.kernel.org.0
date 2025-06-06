Return-Path: <linux-fsdevel+bounces-50885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7BFAD0A6A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391143B3817
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA823FC5F;
	Fri,  6 Jun 2025 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCWCZJWz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B146123ED58;
	Fri,  6 Jun 2025 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253380; cv=none; b=IxZ2YCYFFIZ0yNZ7qxIWG6+iobIicbNyGnrl1skuHzno6H9g7zFZeFA2OXkxd5cNLgGfnXSYJinwip1WVNEIZ1GMYF1rTP7mJIq3g+H4gCgBoiGi+/Ou9qRehHloouQ0si5QxaBxv4qkKcD89Z6PIwF7AV7f94FeID1CTYmdwNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253380; c=relaxed/simple;
	bh=y8Oiy0XJKhVuCLOoKbspz4JqEErfzpqHX0ob8vHVr5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8CQicwtHLEhyE8wcxc8o1z9M+Tmh3qOH7HTqHqw87KPzzBBvv+ZcgbBrpyWH4I61V4Z0iedl3PsPmybW/S44Ajn12byLoR6I8/5+APHWkE4OqcT/SSmDqxmEvOj2gzHYhSfwJ/XZBvP55DRig8BswtfBaDQnWFxI19EgKJ3xQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCWCZJWz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-231e8553248so27270195ad.1;
        Fri, 06 Jun 2025 16:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749253378; x=1749858178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPYXyzhTZFKi9rBDasaoQTI8acFeqekIys8TeZ7sPN4=;
        b=hCWCZJWzZxRg1y7adKAqcCXUFvlJOcCnzARd/30W1KqD4q6QcPYXQtxRxOH0M4h2Ya
         pG0f5x2fKspeOEuGeUrCm7Y/bG1QV7dn67tO1/UhPESlkb5FJvoiw0RWPw2JO436Z5i5
         nn5fBp0MzsuVn6ummlbWze2dOPejdB6P6i+nav5w5QRxeLny1xgVe0pYxFYQ14U6IQgv
         +gRh5JwITLq4khpnu4IPEgMH1lYfd4PwwbAD9uV45aWx5qLEGHBRCCf0Iz/aenB84pXN
         XFCwnEyZnQuOF22r3P2aY+OdRrl6Zr2qCQBHcG2tB/NPgYFl3S4rIwR3UUsA/lWVbEl8
         NDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749253378; x=1749858178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPYXyzhTZFKi9rBDasaoQTI8acFeqekIys8TeZ7sPN4=;
        b=hi9RJJJvH3wJ3gIKXRBLQwv7wqM9MTHxNiu61PbE6nikUIjZBSiwt+Y3HbXJwLiN+2
         PK4Q74xoUXdUrdnRUT+ie5eNGlVq5UEMhAn8QLfCtK9jJgC1nbta9Q1YsN9Gc9W+hzMF
         R4vy/57wOtt/BI5fQrtGaSKj6O1QaEMs1SarpBi2R2nBzwitTkZhMUsq4/XkBtTnA2a4
         34nHaB9MrdxrJ8Il+fjAQT6pIpcOE8+NDDpBOQ0zXS/k2nhlfe1MXx5+UooG9vCkpmma
         bKtwBS1vK2M64dzl4T93Demf+rWtIg5ocb11MldW45ztpQiR/SKyPY395fqpddMtzJSD
         1ULA==
X-Forwarded-Encrypted: i=1; AJvYcCXdtmK9xrA6UFyo4aZ72dw4/sxV79k02sA2mMdBq7ergh3+x7Ebhd9ftQ5aw47Z7h2xLjT9zIB3/wdQ@vger.kernel.org, AJvYcCXkFBA9quCTYQX1NYsCdPP114yZn7691PmMN+w6Yt8rGr6hHaVvQrn7dD32fnqgOXgBXOLS1pQOWPRg0unI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7jCwaZIt0r7pDGCeojJIBHzoJYDtv/o6QvqxkbiJh6/vxPrgH
	UJjsJHV52NYzRdxU9wiF8lzxxUmN62GUN3UrfgXWmVzysBQRtfPHHlmHHJV5HQ==
X-Gm-Gg: ASbGncuYIBfGdO3ZOUS4b/RktOlZ6pWDBZC+XiP9q/08mKWmWMAZFohFWW4UutemwCi
	ZeQhQ41LnNQPSpFokQHJLr/y13Q64aBNpkQ8xKl2ZlhgX26OCkggOunuiLyZ6H4fiTVj3bmC1Gx
	Giv6W5F+eSImFEtUr//CcZ3Ws1p8QpuQzjEqe22rmI63dy15YczE0Rl9P9Tx3yXbB7YjHyyuOy+
	Bqd9AWUirHlpzR92DSDrB+kTyKOMqjNHuY6Gx1C7sZNF+gha5AC7iMEAZMqBKkXNIOUfjYcGq8V
	NVhmQiZceLJDfGCqRHCTEZLy5ujdm1aX2zmDLDbus+RRQabL2nLWKncG2hvyRT8vW8A=
X-Google-Smtp-Source: AGHT+IGUGS4I9H6YvQ367gymUVK/EGv5OMqQjxalWdEBILPOfI/4+IT4/p3ehB+oyFHpwx7RuNfL0Q==
X-Received: by 2002:a17:902:da88:b0:235:129e:f649 with SMTP id d9443c01a7336-23601d01ddamr81461735ad.12.1749253377897;
        Fri, 06 Jun 2025 16:42:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fc9ebsm17680165ad.106.2025.06.06.16.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:42:57 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: djwong@kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v1 7/8] fuse: use iomap for writeback
Date: Fri,  6 Jun 2025 16:38:02 -0700
Message-ID: <20250606233803.1421259-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606233803.1421259-1-joannelkoong@gmail.com>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use iomap for dirty folio writeback in ->writepages().
This allows for granular dirty writeback of large folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 114 ++++++++++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 48 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a0118b501880..31842ee1ce0e 100644
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
-	if (folio_next_index(ap->folios[ap->num_folios - 1]) != folio_index(folio))
+	prev_folio = ap->folios[ap->num_folios - 1];
+	prev_desc = ap->descs[ap->num_folios - 1];
+	if ((folio_pos(prev_folio) + prev_desc.offset + prev_desc.length) !=
+	    folio_pos(folio) + offset)
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2169,85 +2177,95 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 	return false;
 }
 
-static int fuse_writepages_fill(struct folio *folio,
-		struct writeback_control *wbc, void *_data)
+static int fuse_iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
+				      struct folio *folio, struct inode *inode,
+				      loff_t offset, unsigned len)
 {
-	struct fuse_fill_wb_data *data = _data;
+	struct fuse_fill_wb_data *data = wpc->private;
 	struct fuse_writepage_args *wpa = data->wpa;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
-	struct inode *inode = data->inode;
-	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	int err;
+	struct fuse_inode *fi = get_fuse_inode(inode);
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
+static int fuse_iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
+{
+	struct fuse_fill_wb_data *data = wpc->private;
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
+	.submit_ioend		= fuse_iomap_submit_ioend,
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
+		.iomap.type = IOMAP_IN_MEM,
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


