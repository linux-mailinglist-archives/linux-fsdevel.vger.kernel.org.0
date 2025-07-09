Return-Path: <linux-fsdevel+bounces-54399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63900AFF475
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEC03AA5F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A044924EA90;
	Wed,  9 Jul 2025 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYSMo7l4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7B2494D8
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099068; cv=none; b=XfulVW2kRdZObmAkkQEy2eP4Y8zsPPXZELYytQU7OSwBsygHrkNBf3gNqqHg0CEFogTrEr0rACYtV16Q8TWO4SvP6K9yImAkyQKzKb08O8FUu6B29ewtrjT2j2UqrodKW+9qCLJC6LiAX6paZWNd/GJtaJzaNISqhkdWYQNdbrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099068; c=relaxed/simple;
	bh=PPQHEOH26Df/4UxfcMCdkYImr5bk6AFMOzwegv8qKFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZhwPgvZv6zIoNxXg7qGeVoCc6NNAA3Lo9+xxKuliRjsL9s+vG+fn60EShQrToRB9aCiMY9B+dgvMEskx23aStGHP7L7dcg6Te4d5H2I798yolSaZJv/ixUJBt3GSqFEB6+FZ5zkzqRDjutxy4OzbMrIUUtI/Cvve3fEu+EKdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYSMo7l4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234c5b57557so4307135ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 15:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752099066; x=1752703866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTAAGp/ASAPKv5q5k/IncV2wjLw3f/tp207nHosDpTQ=;
        b=VYSMo7l4linIbW1o0zPaNSLR5MzussQC8gZ+TMVq90TvhcEa+o7zlcqqoIKJ00t6W1
         uBs+6hLzJKW5DQzsKyFDnMXTC2g9w6HROYp1xa5UIfhYYFKsh6mZuamZrN+SWKr0x9GQ
         Ornhz89v15zLB5sNb7ja+wxs6457WmZR9oD3lvSw4aaNrzaEc5QtdqorwGwQXEhsePYP
         3InIMFlP5hl3r54VLFXN2Shw/4liMJSr80uXIjOoHAwJMpy/LIBC9aYPyPTkbWnaQ7sb
         Hp4SjhNOoY891gxiisS+5AJa409RHSxTQYVs+yhHyvr+cfc333Pxek7LLVdM9l3N0lft
         cZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099066; x=1752703866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTAAGp/ASAPKv5q5k/IncV2wjLw3f/tp207nHosDpTQ=;
        b=RCckYcGMJGAkcHtsgdWOT2TZtFCg4hHY+WR5IWWMVwC7H525COJhW83/nr/6AbTeso
         /GZaHd8BDZ70TJHXg2ik+Aop8UDaKbPrtaDBKLTOZRJ8h3ZhuOmeuK9E7J4JAh7iDmD9
         tlS/DHQEhfChH0AbzDk3wMSdjKkL1IqcgjzetCUXp1HaBNM5TLFAPan4qi7vT5KUKk9f
         3uM5foUHgr25hjigQUBZ3xUHMIfBse1lL7BlqxUV64CljVaoS9GWi7Sp0vAEwIatXpzq
         8QbiwFRnVORUYtgPluSe77N5RUNjrPuKILtDqXrJMBTRIlQMA6eh1OKTono0J2/ShrwL
         kF4Q==
X-Gm-Message-State: AOJu0YxC6mKWRBkGfH17A5dua3M4XqOjij5cJoBWBpdIdDUvbqZLP7g/
	tio/HhjFzmC2fMvX318+neFSsMH0GLqSts7IQLqERMZxlpS9VIsLwZW2AiEEbQ==
X-Gm-Gg: ASbGncuuzYfHaFv6LSLSaVqWqXebFHp+0y5o09ufI2KFmK06xpHt02As7xcDn1S7GVO
	6T55kwqjJwDptpzFduxtWnwOGPFElU4brCutRxOwySLkt2rupcgOqbVKydh0R5XuMD1mBuDUJgx
	jibcd8q9unW633Yv3BTeMaela0pEbvlm1j2cHBAtw8Z73YNLCc4kyLVDhawBEKl2sw7s1zJMUAp
	nHFnHkFkWBJ3rx0I1eXx1l/IgufxuumSrr9mxLQec6uZum2C+YwA0j90vZ8OnHux947SnPifpM8
	/4A83JfAsdnIAJybT0epRX0b69xY6vf90U0S7FQPoHORBm+SgtOl0BxC
X-Google-Smtp-Source: AGHT+IFJwzxd5rt/NgAbPo/jPs1mwZjzY/3fWF0IHvNSBAY4KipTRdJChAsbjze8pdFGWrnesNoqoQ==
X-Received: by 2002:a17:902:cf0e:b0:237:f76f:ce21 with SMTP id d9443c01a7336-23de245fdd7mr18368955ad.20.1752099065613;
        Wed, 09 Jul 2025 15:11:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm1839625ad.189.2025.07.09.15.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:11:05 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	kernel-team@meta.com
Subject: [PATCH v4 5/5] fuse: refactor writeback to use iomap_writepage_ctx inode
Date: Wed,  9 Jul 2025 15:10:23 -0700
Message-ID: <20250709221023.2252033-6-joannelkoong@gmail.com>
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
index 669789043a8e..e6745590ef1e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2060,21 +2060,20 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
 struct fuse_fill_wb_data {
 	struct fuse_writepage_args *wpa;
 	struct fuse_file *ff;
-	struct inode *inode;
 	unsigned int max_folios;
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
@@ -2091,10 +2090,10 @@ static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
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
@@ -2129,7 +2128,8 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
-	if (ap->num_folios == data->max_folios && !fuse_pages_realloc(data))
+	if (ap->num_folios == data->max_folios &&
+	    !fuse_pages_realloc(data, fc->max_pages))
 		return true;
 
 	return false;
@@ -2142,7 +2142,7 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 	struct fuse_fill_wb_data *data = wpc->wb_ctx;
 	struct fuse_writepage_args *wpa = data->wpa;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
-	struct inode *inode = data->inode;
+	struct inode *inode = wpc->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	loff_t offset = offset_in_folio(folio, pos);
@@ -2158,7 +2158,7 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 	}
 
 	if (wpa && fuse_writepage_need_send(fc, pos, len, ap, data)) {
-		fuse_writepages_send(data);
+		fuse_writepages_send(inode, data);
 		data->wpa = NULL;
 		data->nr_bytes = 0;
 	}
@@ -2193,7 +2193,7 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
 
 	if (data->wpa) {
 		WARN_ON(!data->wpa->ia.ap.num_folios);
-		fuse_writepages_send(data);
+		fuse_writepages_send(wpc->inode, data);
 	}
 
 	if (data->ff)
@@ -2212,9 +2212,7 @@ static int fuse_writepages(struct address_space *mapping,
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
@@ -2236,9 +2234,7 @@ static int fuse_writepages(struct address_space *mapping,
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


