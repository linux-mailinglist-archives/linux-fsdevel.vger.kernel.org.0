Return-Path: <linux-fsdevel+bounces-35859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E53609D8E4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D12CAB239AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DA51CEAB2;
	Mon, 25 Nov 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL/Ne2y5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3AA1CDA2E
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572372; cv=none; b=Le7qNiZZrVnvFrfBg2VKi7Nduv78G/seZ2O9giw40WnVvNVvOC/IeAIpMWTgukGznVwXZ5MGuV9D6XUOMJsr2PqrkQN1rkzXfEF+KCyREX1tB9cXrP3tG8HFMFtrm/LIQgd5RaYMggxSURIG5iuf5iXk4lyjh6YjQFd0lgoUaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572372; c=relaxed/simple;
	bh=uGadmU71ezOXX+APshoRWLPoSpUb4f78MrogvK1o5q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggKMizF1/HPXEIR/JuR/sadm2XSrYal0b2WywJQFhfQrEN3SPczFj6nsXB0qdonm84vOWagMnMMo3jE8SGEoPlvNfhP7zsI0lHb+yze/0swOL1a/DK4D8+0x6b2eLMlWhzy2jz4PQQKc5lBmfi/HhuvVUMfw/yIaJIYG2kDWHeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL/Ne2y5; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e387e50d98eso3956909276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572370; x=1733177170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfCSBpznMAK6j3q01cs9xGyQFYsoUP8X0DJraJrblDQ=;
        b=WL/Ne2y5c6KcjMYE+UEaVv5yKylUf0xxYezdbmbM/HoNdX4aEEHqb9BZvm9XMuMV4J
         +jxX47t5kmTnHEhhqoeYYf9wOdNXBwmWYLIqEaRwFoAoeY/RsMPX+MilJthPArc4SSfO
         Ck+2Nwlzd23Q+Wxm98uAGglAKyUUkjmQndEPp3pvbKFu1vTFc8+sSfV/lASytB9rtt5D
         s+D4bROvC4HdydFieRVJZqhRykd4rlvN9ZoXsV4Dq2NjT51YgJEO3SDtgALqUBeng7hy
         9/hW0QxFmDrowOx+w2gXTR4Lb3H4Q/QnnryQXYd5QTfP+9LmM4faMwFV4J3lEFeYQBat
         Y4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572370; x=1733177170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfCSBpznMAK6j3q01cs9xGyQFYsoUP8X0DJraJrblDQ=;
        b=gcZd3rAfPRQa8vHWIymUkzLKA0FSknM4cyNsOBum2q6/zR5wQV6l+mbSn0sUcAODDx
         XUnGRKgl73NJbNmR4oRFBtwAU0wadbPPSK1MXuFoHEPxLWUCZdvAWfOfUbV9tTmJmVHf
         umqTQW5JjTZVH1jcIkwj/8sRFyAMNHC2NmXopvjqZcfT/xZgONRX7bhPlDsyETCdGfHZ
         w8LDO630H/TOuFUWD9MGhIX9laS95JPDDMmWxlmJWGFmI4R/A2wEmNwqnBMDBtRwOw4h
         6k4Qg4xqEqng/XAzJVMnqvTnLCTEWjjpmPhwWXVyVh2Unqg32xL/gqZAR9OoIwMCFObe
         XvLg==
X-Forwarded-Encrypted: i=1; AJvYcCX3Ila3yHfDXOLhQY00olk6cQ2n3DHUEn6YKYa4GlspI0SUcRAYjdsmbDJQ8Q5IsuqkI3jzFzVhBC1VyBmT@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIOfnGM30NgEe/teh5P1uDjd/6cS5MZcWBQfGzvpvkkbUckoG
	kK6AZGM8mkEyzx6nSJU/+DYCagLkh5WqjyQK/T0PTpbD8VlvN/H6
X-Gm-Gg: ASbGncvFPxS+1MEQ8gPxHombi2AWO3wx8c5df73SCJwVPo/3uq9l/FkUyWpp+Lkyvmp
	MEsMxBNTEcBRz8cwL/OiI71izB56poDhiDRQVE8uZyAMCE8T0lCLvbzXZB9xD+IUQ9TAsNbTBJ4
	BRAB53qKVIvsRS9BGuazD8aplaKixOUI2n42zPwuZAfeUj6WwAmSy0wHDXnaBHmfjRgbKX9sC0m
	tyk4DIFMSs16QhXgjDGleRwnp7vLHgapyLSKaLC8Lit63KbD6SrO21k8njeJvuKeVH/sYLpfK22
	KI0Zo1Cb3w==
X-Google-Smtp-Source: AGHT+IHEo4v/VvOi5+q1aAXzccXZ6KBYOTvYzUQpRzVQ1at4dxUs0M4yo9vThAt839+iVlDBbg5FQQ==
X-Received: by 2002:a05:6902:140f:b0:e38:a15d:409d with SMTP id 3f1490d57ef6-e38f8b0b7bbmr14295959276.13.1732572370385;
        Mon, 25 Nov 2024 14:06:10 -0800 (PST)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f604b594sm2743707276.18.2024.11.25.14.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:06:10 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH v2 11/12] fuse: support large folios for writeback
Date: Mon, 25 Nov 2024 14:05:36 -0800
Message-ID: <20241125220537.3663725-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125220537.3663725-1-joannelkoong@gmail.com>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for writeback.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a907848f387a..487e68b59e1a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1991,7 +1991,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 	folio_get(folio);
 	ap->folios[folio_index] = folio;
 	ap->descs[folio_index].offset = 0;
-	ap->descs[folio_index].length = PAGE_SIZE;
+	ap->descs[folio_index].length = folio_size(folio);
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 	node_stat_add_folio(folio, NR_WRITEBACK);
@@ -2066,6 +2066,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	struct inode *inode;
 	unsigned int max_folios;
+	unsigned int nr_pages;
 };
 
 static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
@@ -2113,15 +2114,15 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
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
@@ -2152,6 +2153,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
+		data->nr_pages = 0;
 	}
 
 	if (data->wpa == NULL) {
@@ -2166,6 +2168,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	folio_start_writeback(folio);
 
 	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios);
+	data->nr_pages += folio_nr_pages(folio);
 
 	err = 0;
 	ap->num_folios++;
@@ -2196,6 +2199,7 @@ static int fuse_writepages(struct address_space *mapping,
 	data.inode = inode;
 	data.wpa = NULL;
 	data.ff = NULL;
+	data.nr_pages = 0;
 
 	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
 	if (data.wpa) {
-- 
2.43.5


