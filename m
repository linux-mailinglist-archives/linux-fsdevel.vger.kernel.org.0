Return-Path: <linux-fsdevel+bounces-52676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173CAAE5A0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3480C4475F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AE7261585;
	Tue, 24 Jun 2025 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3Np+LOZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3A257444;
	Tue, 24 Jun 2025 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731803; cv=none; b=dLhu9DJDh0KEEDmImlUyF3DzN37DIVRMaz9/mshplJNLoCsf0d1jqYchgXRCOvXCvHjwX1fKgBJ+rI3CxaZnrg+Ovx4eqq7JI2GeQkBMk8wRKXk5bMpsfNl2+manooE4lHPc4yN4ZHQ4jeMzwJXZFNUQuaEInTBRE0APhVfTjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731803; c=relaxed/simple;
	bh=PoerR/K4ms0GxJO2Pm9kIrVTcdNfydFhWRhcSG1UbLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hl9wic+klN8rUtH6v6ujnI7BUgtWRAd7ejZWtF3mRJ/qveWoN6LZv5mbRIb/8f3LW1BWXcOyV8InjHxAfpeQEbXsvr/HSi7Oqp6dBIcH+EBS75djw7QVnN062BhNYY7rT5EOF4M2nofjzTNU60U0NsmXgdyXWjKi+mcWTRNNmOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3Np+LOZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b31d0dcfea3so3413223a12.3;
        Mon, 23 Jun 2025 19:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731800; x=1751336600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjrDdY1Jsc+m41Z52NB47+T+tcVMCALvPxP8ZmViS1E=;
        b=P3Np+LOZ+mXa9fsAD2PvvyCntOEM5akBXwh6f6G/Y4nejQSSLBlfgGr9ll0JcSuDD2
         GzCyPaEkjINAzCU9nKDFDc51qIuJv8OEZd2T/p8OoQ3kIq/VgOcfNvdSeuDewvNhru5J
         myaVb6jF6pyPNzWArE0QLtabsdyLz5m4Hrf64ysiH6/sBC9g+LIiamMxrL5gLK66bSRV
         TDmRJ6lSsHtYW/Zw2rP1ti077PTE51CGYC+wpbzIB9zBm8NDuWR21fX+mj425izcMsF5
         mVZ6ej2r3dSo8yDldcj12+9lyuThu/jJFXgdI8xQA/B7JoVGUipcL9IYPABD9obv9Q/U
         oDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731800; x=1751336600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjrDdY1Jsc+m41Z52NB47+T+tcVMCALvPxP8ZmViS1E=;
        b=g14TXRunqrOXdLYJzwfIjEmS5SHqE+Y+upzTZUvminsUbguaMky0PY2H0xGL//HAkU
         jMlC9DWcIwZLuX1HYoKaMN/SY6io+y+Cw4dWO+VditXulRMiCJ0RtyHA25z0/7aM1STe
         06bja6U37x/zfMBFtsASvBZgK929Qa3HFvprYSTLbdtrRdDFqskexM24QHXF4uowdCxv
         5hzmFG4BESFEbphylwYsXZK85gwDllCfHO+8HIadB5Cu9h0il1swjkV2o/d0v8HpacUV
         AdzHsiF9nkX9RHgrwOW2/OThKoArqeShfyKw4o/rgIUlNIXOqZsDYe6NUYrhkibG1atj
         GEvg==
X-Forwarded-Encrypted: i=1; AJvYcCWkS+1YwYxOWMKYBbtz2IJiiWQGKtr2SNDVZwzbTkSheKzM4LE2fxhaNHFBxpo3NO776eLJ7H0UF2rO@vger.kernel.org, AJvYcCXRlxU923GUE4Rsm/ET7DMGxagZxZZqmxNK1p56SF5abh7BnS2EaD54crYDA/NrJu31AKQE/XarPpvI@vger.kernel.org, AJvYcCXrzHqtvmgaHy6eYDEx9vzgfuZ7h+p452oqbTl+oqW9n94qryVCS71y6gfG0z9AA7ptY122Lp+F2mTg7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF/SsYrYvEhMUM83tyk/+Ou4nVZRfoC6QNJQbsn5Y8MpRog9Ja
	w1Ngv43iIPdLFn9alZ6KccmkWh7W/VRw4Kt46WLzHLahDouGWF5UTF2i77K5cQ==
X-Gm-Gg: ASbGnct4qakm/8sE8YOLJE54gdxSXoqHNHNx+TEUEoXpWPXhguuJA1Di3l8nndRtZ/1
	q8/uwzgk61350q8oxO+7WNOFHa5XcvNhEuJmvC8sOpN7TvEZw8nwhc+WAnL4Q3qoiuHP5wewzn8
	n0ZqRVAVsMFbrTINlT3NCSvZZSaNUOY0ZnlkjXGAY3jsZq9PLVP8yEqjjSsmOovc9XUR+2YWhOd
	It2/LLjgAqZiYoYS+xsnyO7kD5KkQG6AzjAv+vZQmHCf6CykJR6WGMWyh1rasWV1fbog7+YCIUD
	YWahturathLOtImJR3EH9MWjepKgQCsDhVVb5C3f52MN8KuMaUuWkVlV
X-Google-Smtp-Source: AGHT+IG87S4yoqcIWNxElC6u13fXrMt/nV7cjqhpB1zvdKJmHCLYWfio3y1z0ctV9KIAPZysoVRI3g==
X-Received: by 2002:a05:6a20:a108:b0:216:1476:f71 with SMTP id adf61e73a8af0-22026f13166mr22674077637.39.1750731800489;
        Mon, 23 Jun 2025 19:23:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:c::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f118f205sm7770446a12.13.2025.06.23.19.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:20 -0700 (PDT)
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
Subject: [PATCH v3 16/16] fuse: refactor writeback to use iomap_writepage_ctx inode
Date: Mon, 23 Jun 2025 19:21:35 -0700
Message-ID: <20250624022135.832899-17-joannelkoong@gmail.com>
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

struct iomap_writepage_ctx includes a pointer to the file inode. In
writeback, use that instead of also passing the inode into
fuse_fill_wb_data.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 865d04b8ef31..4f17ba69ddfc 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2070,16 +2070,16 @@ struct fuse_fill_wb_data {
 	unsigned int nr_bytes;
 };
 
-static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
+static bool fuse_pages_realloc(struct fuse_fill_wb_data *data,
+			       unsigned int max_pages)
 {
 	struct fuse_args_pages *ap = &data->wpa->ia.ap;
-	struct fuse_conn *fc = get_fuse_conn(data->inode);
 	struct folio **folios;
 	struct fuse_folio_desc *descs;
 	unsigned int nfolios = min_t(unsigned int,
 				     max_t(unsigned int, data->max_folios * 2,
 					   FUSE_DEFAULT_MAX_PAGES_PER_REQ),
-				    fc->max_pages);
+				    max_pages);
 	WARN_ON(nfolios <= data->max_folios);
 
 	folios = fuse_folios_alloc(nfolios, GFP_NOFS, &descs);
@@ -2096,10 +2096,10 @@ static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
 	return true;
 }
 
-static void fuse_writepages_send(struct fuse_fill_wb_data *data)
+static void fuse_writepages_send(struct inode *inode,
+				 struct fuse_fill_wb_data *data)
 {
 	struct fuse_writepage_args *wpa = data->wpa;
-	struct inode *inode = data->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	spin_lock(&fi->lock);
@@ -2134,7 +2134,8 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
-	if (ap->num_folios == data->max_folios && !fuse_pages_realloc(data))
+	if (ap->num_folios == data->max_folios &&
+	    !fuse_pages_realloc(data, fc->max_pages))
 		return true;
 
 	return false;
@@ -2147,7 +2148,7 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 	struct fuse_fill_wb_data *data = wpc->wb_ctx;
 	struct fuse_writepage_args *wpa = data->wpa;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
-	struct inode *inode = data->inode;
+	struct inode *inode = wpc->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	loff_t offset = offset_in_folio(folio, pos);
@@ -2165,7 +2166,7 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 	iomap_start_folio_write(inode, folio, 1);
 
 	if (wpa && fuse_writepage_need_send(fc, folio, offset, len, ap, data)) {
-		fuse_writepages_send(data);
+		fuse_writepages_send(inode, data);
 		data->wpa = NULL;
 		data->nr_bytes = 0;
 	}
@@ -2199,7 +2200,7 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
 
 	if (data->wpa) {
 		WARN_ON(!data->wpa->ia.ap.num_folios);
-		fuse_writepages_send(data);
+		fuse_writepages_send(wpc->inode, data);
 	}
 
 	if (data->ff)
@@ -2218,9 +2219,7 @@ static int fuse_writepages(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_fill_wb_data data = {
-		.inode = inode,
-	};
+	struct fuse_fill_wb_data data = {};
 	struct iomap_writepage_ctx wpc = {
 		.inode = inode,
 		.iomap.type = IOMAP_MAPPED,
@@ -2242,9 +2241,7 @@ static int fuse_writepages(struct address_space *mapping,
 static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
-	struct fuse_fill_wb_data data = {
-		.inode = folio->mapping->host,
-	};
+	struct fuse_fill_wb_data data = {};
 	struct iomap_writepage_ctx wpc = {
 		.inode = folio->mapping->host,
 		.iomap.type = IOMAP_MAPPED,
-- 
2.47.1


