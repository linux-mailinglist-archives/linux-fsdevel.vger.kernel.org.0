Return-Path: <linux-fsdevel+bounces-34121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C1C9C28B5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7161F22B52
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B504A07;
	Sat,  9 Nov 2024 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMlchaQ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502EEEBB
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111237; cv=none; b=nMCyw+GDWiqYMJtJ2/Ddv4fVosHcpc1BXx5GT00qIzF5hFA7BgAwFt8Z3342teQePmOZq/mceLVjxASfv358dsr+MFndvX1UdEZ9Hqmp7yxJ638fUvkb/rYx75uSZXW6ibvZDRCVjgVOO36Q2t5wrdipTMg5WB6lk7qP/97Oqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111237; c=relaxed/simple;
	bh=rBDbDvmoteZdm2ODXBKD6VhgXC5D4u68dpFFvBE3ReU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lmt8A0cgoRGJFaEsVkfPyOw4CtkIHSqS/u+b7dev5/XWQWxXxbDGnpR1r6I9MwqHgLIZUTLtW2/Tw5pGsai7VqC7VtDuK650hO/wrfcujYofSFII6TA9+xpUiRGLDFUDaF5o3xl9Y8Xw2KUM+fBz7IArwHQBUTMthbTi9JMr+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMlchaQ3; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e2918664a3fso2499328276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111234; x=1731716034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LqRa3Ne28mxlZ5do6PIs/3q1kOvHUbDyTO4HkVund0=;
        b=DMlchaQ3iuGwOWRZ8SvMqsvslgID0aJS7G6K0IvBbgksSAkQxSswXRZn295oHgKLAK
         6Z9SAo1GEmMKT2qI2qVo66DpmiWSbR1IWLDNdwiKG48l7aloiOkJmgU4EJ1i8xmIYusz
         xvP+apXO0AsY024QdBYb0QYvDQrZJYXAOqhx8oi3vjPlXYlk06sjhW286KVGW9fTGj2D
         WiAOF5yl9TWpegZNz8eeUhKHjTTdqPPeDEi5/xnnkEjuzN5nZBlrYXhOcqTkQdIv+sWh
         0z3m8Cnr9soZgUtfZqNBm7WlT2SjqZeAeXqgFuVxnrbNZmQL0/xlBj+h7eR6pK7fwMEK
         oZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111234; x=1731716034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LqRa3Ne28mxlZ5do6PIs/3q1kOvHUbDyTO4HkVund0=;
        b=ma+TP4XXba5HaOv5fzuvzC/dEkNdK9LRKPS0LxbkNVoahdx081lb442PVLPnT4mAZP
         1Mm8pH3Rbdb9p93xuuNEyMyMZ4KTGhh04E+6A8gtDCQLLllWY99I2NcsirVvq3Xh+sZl
         Lt+0l2e/qY9OlLt/gIw6pumMx4pd/LN6+AGl8nGpobm6SRhwe4n0A+A6p6tOhKW5uPGo
         yEWAYb7GPIfE49vTHCZUoGPViOJrRKUf/h5LEczg89yoFymX9UbsH+Io+3e+qQqOrlCr
         +2T3Wr+dFTtQw4XfwigkAdwt1smBVrzqX/ko+h2IRCYj31X5M76HLoZ8bLTHiaNEAAxM
         kmDg==
X-Forwarded-Encrypted: i=1; AJvYcCXM13k/vsIiQdpLEu6rE+fyUUd6Fu+3Pzvg/EKi+4k/Q4hXe9JYsWfs4WS1kqlov9t29IlJux7ZT1hDsRzm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+pfEJfQlxQWvGX2d5Hgxc81FlA1lWiLpUaWVchcmOi49NGGhu
	ZdG6bFM8ioZYMd9cFWkiXJm/gJlt2UoLa1lQkyy3lgepprfxGE+G
X-Google-Smtp-Source: AGHT+IERxBntk1/jJECFPdV/xa7mm6lAAiIKRiFyqsxreUqi2rsUtQb4OISY0W/FQI2u+OAb193QqA==
X-Received: by 2002:a25:850e:0:b0:e2b:d28a:5be with SMTP id 3f1490d57ef6-e337e17cbf9mr4957273276.19.1731111234525;
        Fri, 08 Nov 2024 16:13:54 -0800 (PST)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ba835sm940485276.47.2024.11.08.16.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:13:54 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 11/12] fuse: support large folios for writeback
Date: Fri,  8 Nov 2024 16:12:57 -0800
Message-ID: <20241109001258.2216604-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109001258.2216604-1-joannelkoong@gmail.com>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for writeback.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 54e2b58df82f..a542f16d5a69 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1993,7 +1993,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 	folio_get(folio);
 	ap->folios[folio_index] = folio;
 	ap->descs[folio_index].offset = 0;
-	ap->descs[folio_index].length = PAGE_SIZE;
+	ap->descs[folio_index].length = folio_size(folio);
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 	node_stat_add_folio(folio, NR_WRITEBACK);
@@ -2068,6 +2068,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	struct inode *inode;
 	unsigned int max_folios;
+	unsigned int nr_pages;
 };
 
 static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
@@ -2115,15 +2116,15 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 	WARN_ON(!ap->num_folios);
 
 	/* Reached max pages */
-	if (ap->num_folios == fc->max_pages)
+	if (data->nr_pages + folio_nr_pages(folio) > fc->max_pages)
 		return true;
 
 	/* Reached max write bytes */
-	if ((ap->num_folios + 1) * PAGE_SIZE > fc->max_write)
+	if ((data->nr_pages * PAGE_SIZE) + folio_size(folio) > fc->max_write)
 		return true;
 
 	/* Discontinuity */
-	if (ap->folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
+	if (folio_next_index(ap->folios[ap->num_folios - 1]) != folio_index(folio))
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2154,6 +2155,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
+		data->nr_pages = 0;
 	}
 
 	if (data->wpa == NULL) {
@@ -2168,6 +2170,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	folio_start_writeback(folio);
 
 	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios);
+	data->nr_pages += folio_nr_pages(folio);
 
 	err = 0;
 	ap->num_folios++;
@@ -2198,6 +2201,7 @@ static int fuse_writepages(struct address_space *mapping,
 	data.inode = inode;
 	data.wpa = NULL;
 	data.ff = NULL;
+	data.nr_pages = 0;
 
 	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
 	if (data.wpa) {
-- 
2.43.5


