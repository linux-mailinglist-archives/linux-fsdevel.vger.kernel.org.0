Return-Path: <linux-fsdevel+bounces-55031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F61B067B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 22:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3EA3503B79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B88628000A;
	Tue, 15 Jul 2025 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHVsnZLA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E42BE63B
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610976; cv=none; b=EcglpEWT9le3nJgOS9awbmiTynMAu+ufsN7Diw9DiFaxxLoF5OHvN/jSiaaep7be2N11WLgPhhtN/hZkDBg4leK0kUM0qQKGmyiTW8Qte1fIPcOvmTU9ZG0hD5/X5TCo6zplSd7WhpaEExu276xdqOvIHZ+L1BxRS+zIXaWCcwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610976; c=relaxed/simple;
	bh=ToC7BwlT3e6kglleNMbT9iYIAN+Dk9YUmAKffXUa7k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxeuqygadtmUXQbxG/ciRasy/UGyDevc/DZBFpn/ZMwQmFhVwK+uK14xVPJQltIR6CnAjqrvEX6m2VwkXFNu5si1bFZHB79RXNdUpqL3JDILHvMXFUx9CB6p4+3gxvSWPqil3jjo/j/yiHcpSCF3yxptbSf3q2Giy3AzjXFK5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHVsnZLA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23aeac7d77aso46668475ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752610973; x=1753215773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCGQa9oaDKqa0rTm7odh/boh43EHPo6Nat4+86P3W2A=;
        b=iHVsnZLAFzZDgj0J236FBkdKBOUFzeWqBCxyM2ex/n6MvePe3+Y4eeO21OJ8VY4UpQ
         0o199h8teqXMbsi3Jbx+X5kdeWg17zPqmX1UkKb1WBU4aSiLcX2Dj2t1dZQSbuvRoYEc
         /5MrtFja4himSOO3QK6ufDVe72fqUQM/iSGJaHhuAtVZs6PJVMuEPuuhfa+j5iRnuJAQ
         Sflfyt0sxWq8HqtFO5tzKay0dBRyOgzEn9Hf6lAcK3IdlqjQpnAIBM4S0qJ/5gaNcdS6
         zXWrc/JDZxIeCyz5bqO8t5H+/AmLUSQcA360J4Pz/o5ioAFV5QlfcIJBImmO2UWKi6yp
         m8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752610973; x=1753215773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCGQa9oaDKqa0rTm7odh/boh43EHPo6Nat4+86P3W2A=;
        b=kR+BQk9HncVvhHvKuynHdSFx6t766e/E0434C8CUNKiCpL+fnUW//bOCcHOjanrn3h
         5h36Fsd7IxtvyBGCYK0GC38w9hXIM3tuFsIwdQC9BJ0jZpk2A1cNBW80mWIsu3tvICeA
         BKTehVGl4gTTlw6koA469UoN5EOWwo7guIhfgA2S4MbS/5gRyWWTLhPwhZoSXeQPrM4d
         p3kUul659jsmy6ZJulMedMN4+JsMNrveRztCd5dQIG0VNJyLA4gYs1zoEviU5rOlCA7R
         AdEflpP7MM9iaBb6VhpJiV2wWxPdy20igXsrkYOq4YipsGlBH2ZoeHNqOSmH1vA+hLkT
         r9mw==
X-Gm-Message-State: AOJu0YzaE0GMimgaJYGWCA5o61Rva79nJaNlDCyb4wGyoxe28tBkNxaQ
	rAlyRqZzY8NIY5UM+ij9e+j2LkqFV0/F3avNJNkuzjI+D5q8iMnt5/B53IJEZA==
X-Gm-Gg: ASbGncvaBJU2f8G164gg749x96p6pcDyGshzqYQhSUFgubpcwOIDeZL/dJbzIzgTsJs
	/OFDZEzx+epz8u5xPIMm+7Czyo776V4+IknsWA3ZWNJqxOjpfI+HLQYbRVkxLNsHVU0+j9bCsZZ
	YXtjKqdAeWRm4/iTrK6eopVEcJgsYiT2BomY1C+SFyBrOyjGXoIWngRDvlfsa1lFxperHfrzrYq
	F0WxGarPQuetzk7DsiHRrzZKUsNA22idRsVh/Yv0Jq9hvrN1SIv4G7CNTlRpeG6GwAzSg8LvPQr
	4l3QsE/e/OpVM66ZOPJYYjEoLT+sIGXsMQEg89PHg/dRBhbaUAgFQE5LsMkQz4ZClit/L1gAzFW
	VsnNtgJepTEsFIoB3
X-Google-Smtp-Source: AGHT+IGZpRdAQGr5n9Tcdpp5JTJ5tlIHJhtItMoHldBTlcM9yLWnWpvxWDGs72R2Yhm+5FGThV40Ug==
X-Received: by 2002:a17:902:e743:b0:235:e76c:4353 with SMTP id d9443c01a7336-23e25000edfmr3968895ad.51.1752610973351;
        Tue, 15 Jul 2025 13:22:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42849d7sm114211715ad.21.2025.07.15.13.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:22:53 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	kernel-team@meta.com
Subject: [PATCH v5 5/5] fuse: refactor writeback to use iomap_writepage_ctx inode
Date: Tue, 15 Jul 2025 13:21:22 -0700
Message-ID: <20250715202122.2282532-6-joannelkoong@gmail.com>
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

struct iomap_writepage_ctx includes a pointer to the file inode. In
writeback, use that instead of also passing the inode into
fuse_fill_wb_data.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 096c5ffc6a57..617fd1b562fd 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2060,7 +2060,6 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
 struct fuse_fill_wb_data {
 	struct fuse_writepage_args *wpa;
 	struct fuse_file *ff;
-	struct inode *inode;
 	unsigned int max_folios;
 	/*
 	 * nr_bytes won't overflow since fuse_writepage_need_send() caps
@@ -2070,16 +2069,16 @@ struct fuse_fill_wb_data {
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
@@ -2096,10 +2095,10 @@ static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
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
@@ -2135,7 +2134,8 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
-	if (ap->num_folios == data->max_folios && !fuse_pages_realloc(data))
+	if (ap->num_folios == data->max_folios &&
+	    !fuse_pages_realloc(data, fc->max_pages))
 		return true;
 
 	return false;
@@ -2148,7 +2148,7 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 	struct fuse_fill_wb_data *data = wpc->wb_ctx;
 	struct fuse_writepage_args *wpa = data->wpa;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
-	struct inode *inode = data->inode;
+	struct inode *inode = wpc->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	loff_t offset = offset_in_folio(folio, pos);
@@ -2164,7 +2164,7 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 	}
 
 	if (wpa && fuse_writepage_need_send(fc, pos, len, ap, data)) {
-		fuse_writepages_send(data);
+		fuse_writepages_send(inode, data);
 		data->wpa = NULL;
 		data->nr_bytes = 0;
 	}
@@ -2199,7 +2199,7 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
 
 	if (data->wpa) {
 		WARN_ON(!data->wpa->ia.ap.num_folios);
-		fuse_writepages_send(data);
+		fuse_writepages_send(wpc->inode, data);
 	}
 
 	if (data->ff)
@@ -2218,9 +2218,7 @@ static int fuse_writepages(struct address_space *mapping,
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
@@ -2242,9 +2240,7 @@ static int fuse_writepages(struct address_space *mapping,
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


