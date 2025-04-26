Return-Path: <linux-fsdevel+bounces-47434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61475A9D697
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C7D925C9A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0D218DB05;
	Sat, 26 Apr 2025 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqp/enAh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4271865E5
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626228; cv=none; b=THpN94T6hdlGmtbctFDzKiDNQz+wfMYLB6AlWEO/unxtD3NhqEedr9N3HCrJeFZfHYsWde0HjPA8iJMhgNMbptx30xx+tLJX+nrMVcs6Y3fN8ztU779Ldx5FAbba/+I9VFZIW3julnF0EsTy5HUUSQi8mGi3T6nQyTFNoju4vRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626228; c=relaxed/simple;
	bh=9VtlaZD+FG+agIIGrwxJ9agJjeWVCg+MXM2mzIvt+CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqTSqJ19jhZrMnefmIw0yOF6irM0O8f5AW0i8xPtou3g1CI2UCdYcPfPuP4SwMwBmh+xmF1MfDZTM5E5b1Kl0f7dTMMR0AwRwc/kM4ORFcbLjd1zOxvqIvenFxyOGZCnN8buoblNo1RbD32KDVffg6KDj3xwJe5WuOHR2LD6UP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqp/enAh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so2818293b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 17:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745626226; x=1746231026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMNRMuSH2EJGmSZ+bv18TFewiiEMEEc1BteF+0jQ5HQ=;
        b=fqp/enAhAq+a2qyCmt/tjKix2FHTZZhHFY/kiCUfe+iEJ+7JrIFWNmyfTn3NDfSXEs
         40oNGf83btrycDbq7NeWczmm6QBCKsFApj09tEC+5KvPQDzKLZmyoGgw7WMxCvpsPTze
         X77f812DU1jDiZJed8Kh2pvZhL2JaRIpXGLunnbcrpiQfrMV4QUFbVHf8JmnAv15gEea
         MYMbr8TR1Q3N2VaZif+T37fHC/bl6aTAo4urwKASYjSTgGt2Kmga017bAMVUi7ry2ybC
         RKZVAAA/Rgc8zbebk7nb4tOqUXs0/MGeprYfw6YbCGWKs2mjkFoW4a3EzdtL872tex1k
         YkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626226; x=1746231026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMNRMuSH2EJGmSZ+bv18TFewiiEMEEc1BteF+0jQ5HQ=;
        b=bmiCWWBZJFgdss21FMC6nn8DcukOjQxeb1pw1DMY0BNZoLH5L3dyEH7iTjE1SKH+5G
         ctP2zeJf2FdRBHDNzoPfq+pj4pS860XHc5A/jPO6+DRmJ/5s69nPvzqCrYLiu5xuZzWY
         6Z1ZodClrxy1L4ch48w+Xy+jExwmQbkhsITmqdH3R0qDb2u1eJ5b4XVW3BhyRl8H85tu
         f+2DJhMPQHOb7fmMiZNNuWERMepVSMdGALBwOfyek81OII2wgZgekmKrzjSDyVVu6R5f
         KTzeMWSjIktL+8CC4CjP/EsdWh+wHZ7BwV18yFoKxZniYsbXkkm8ulHD5g4cJNKsEZd6
         Aadg==
X-Gm-Message-State: AOJu0YyqPo2F/ZujGZqQOpqUhjYZ9LM8J+8Q2o59KQptrkvwoaO5WeAX
	X65+JbFa3Jgww68VMTkvy31E7YMkj8pezwNeu2C5z6LAWSILOJ1m
X-Gm-Gg: ASbGncsIqsQzhZZtKx4WjET5mI8X+7aKXj8941fTm/sPPTigW6h14SADWU5oqdqq+MG
	jrhiPO9JnxO4ir4iQH2+RRNEzfdST/nN4zoO0G4c5R1Uo3JFMFyTcd2Aw9VJWcuBai3ZDpu5Hfc
	eQ6Knok4+jeyq0JkZQN1jxgpcn07ZyzyvB+1SlQHFdiZl4KfViKFknwBvM8C4SqwLw3ZBmR8HZZ
	bPtu8hMMi4NQukA+vdX//8qyGvn18td2aYURPRwr8x5mEmPcYZZJ9sWHXihBh43/MohN+AhNsJG
	zwFIPl09sHi8m9z4cUv3TlEjp83dLRtob2w=
X-Google-Smtp-Source: AGHT+IHHX/6mjfyQCZ748IujuZn/vmN+Q9FR/BDQExLoSaD+RX6UpLbgYh3Mb3NTLNqYellXcoN56w==
X-Received: by 2002:a05:6a00:2f44:b0:736:53f2:87bc with SMTP id d2e1a72fcca58-73ff72e4075mr1227569b3a.13.1745626225776;
        Fri, 25 Apr 2025 17:10:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e259134d5sm3935036b3a.19.2025.04.25.17.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 17:10:25 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v5 11/11] fuse: support large folios for writeback
Date: Fri, 25 Apr 2025 17:08:28 -0700
Message-ID: <20250426000828.3216220-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250426000828.3216220-1-joannelkoong@gmail.com>
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 61eaec1c993b..5e7187446730 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2014,7 +2014,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 
 	ap->folios[folio_index] = folio;
 	ap->descs[folio_index].offset = 0;
-	ap->descs[folio_index].length = PAGE_SIZE;
+	ap->descs[folio_index].length = folio_size(folio);
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 }
@@ -2088,6 +2088,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	struct inode *inode;
 	unsigned int max_folios;
+	unsigned int nr_pages;
 };
 
 static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
@@ -2135,15 +2136,15 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
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
@@ -2174,6 +2175,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
+		data->nr_pages = 0;
 	}
 
 	if (data->wpa == NULL) {
@@ -2188,6 +2190,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	folio_start_writeback(folio);
 
 	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios);
+	data->nr_pages += folio_nr_pages(folio);
 
 	err = 0;
 	ap->num_folios++;
@@ -2218,6 +2221,7 @@ static int fuse_writepages(struct address_space *mapping,
 	data.inode = inode;
 	data.wpa = NULL;
 	data.ff = NULL;
+	data.nr_pages = 0;
 
 	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
 	if (data.wpa) {
-- 
2.47.1


