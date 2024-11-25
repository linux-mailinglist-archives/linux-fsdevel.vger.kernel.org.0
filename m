Return-Path: <linux-fsdevel+bounces-35860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097609D8E4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9E8B23BC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940631CD219;
	Mon, 25 Nov 2024 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7giM3nf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5A1CEAB4
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572375; cv=none; b=l5iWLd5sEOmrOCThWhy9Oe0KO/yRVqc0OOzETSU2RPjpNbvLY9AkzZAppREbeLKb2dBFBU7PeLjEkLpDP5ebzqcHTBKyiyg88TmHzo4SOc8NJvfbZNhFcdHRKrx9ffdYe1sWoAp3dPIivJMUGlLS7fWy0d3kJzc2LGTMylmt5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572375; c=relaxed/simple;
	bh=mU2yOWacqm4aochUABwzvevW+gPKN7vO7SaINU3bDQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMENw7UcIEHG0tE7TuVSJPsTfKa4wHVaoc7LNf5p92L7h+JuEpuk7xo5lCdW4Txu5pFIlkSRomHf14pp+Llp1ibkcXyB/75+WiT82JuBg0if9ZGtCNYiSAsMq/fRegK2fKd+UJq1fKGl7RjD2txVEs7ZlJXMGBl7ZgMcJ/xmayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7giM3nf; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso4090216276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572372; x=1733177172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3flqs/1oGaqZeRwYKdCfmq0tSLx0cLwL6PDx3Ge2z4=;
        b=f7giM3nfkUE77skYUxU/Hxsit2oFw8rCSpPvzXH3pdVm/xT0W6H64ZAlCFv2Dk6aXu
         s1cVOb6Ep7DbIDK6caCNgBqYlj9WlNQuChMwX/+WnvpcmA2dkLjJUTEFKjgD9dBGswx1
         pNbGevKwvu6EdqXxJFV4cpEGEGfbQUr7vMGc150qTBFR/wq7p4SfvDFQRSqYYHSqV8B2
         iRWiGLRMtLO/0abGYIzXDu5If5N45gw4u+ii2656mf1Eael0EvLBzZ4ovZQa3PH0zcyZ
         Y54rRqKPnP08uGDTGTbI8hvtVWSisrZyfAs9WuQ5EjbB0+bi99Kt8k1lubMjXguIsHS8
         U4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572372; x=1733177172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3flqs/1oGaqZeRwYKdCfmq0tSLx0cLwL6PDx3Ge2z4=;
        b=Dp6j85MX3/6bX78RSF/E1SI3BPHvEPqgeRYqL3Cjy9wWPWswAjQe+W+q6of1+jHiYk
         C8wxjteNx29bpxFIsDlJ4Vqb3olwlJgWhVdZcPHNRkTeSHtxS2aiEQABK/+ZQfsHqhMI
         4o4LisF4PCg+MhwyvJMmsRcR8TQQOnD6GnMrVN9/j2jBZ8LccRpHkTKhIc4Q/sgOqRLk
         op3jy7K9vvV4vYydgVt49eTnUcqkmRbkLTwZz4PAphV8vnIT52kkdH5LR3HYHbFQdUhF
         EhYLxl0fQF2UwiUPbgMez8rpgSdvnYLC6pPvD11N/iNVGLC7LQ2H0Jtzzgt37lf8psNX
         FNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKYh++IdxcYkEsxZd0+oj/jY7rTX0lG9R3MdqFvdftmvnmpRhxTB5WPSnHO+ImUV9/gXo12bc73hyDs4zW@vger.kernel.org
X-Gm-Message-State: AOJu0YxH4jnsYZmnfWi1rFLL6hyWMVDAXg6rIJrNCTlX1NwB2rfVLR0r
	HQjlwwglAIGdeEljHTpSdTLzaBtcQX7k9+3aHDeXqud+34oTCwZj
X-Gm-Gg: ASbGncsuNv23bbzI5TIpcmEvB9L4prLX9ydsG0gCHajU2F9pQ4XAxARyr27ER4Af4EO
	loczjZjlrtC4p0ypySAmX1cNIZpi51Q98zCFLwpNniJW2qGZ7SnF9wNP2W3jQ8mYTd3RwHYITWP
	DryHXCcg+7gac63FSN4cHE59ShGt4vEYTEdhEfplCpMzNTCtEEVU1p5y67GPoWpzS21jX7DHlIs
	q16cjK4yJCR/QK39KD/zSL5KWHsfbVy8ZYhRjrdU5k4PW5jiIM8t1OVHK76iVlkYAyqAuMHLb34
	SDqqof1pxw==
X-Google-Smtp-Source: AGHT+IF1b59dEmsjXTtNsQAB02ulejfbryC79U5BfCVpaurDeQl6h4TUAAEs6t1E3vMJX8+LT056Kw==
X-Received: by 2002:a05:6902:2303:b0:e38:d1e5:c247 with SMTP id 3f1490d57ef6-e38f8b0c24fmr12574929276.19.1732572372541;
        Mon, 25 Nov 2024 14:06:12 -0800 (PST)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f6378034sm2638618276.60.2024.11.25.14.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:06:12 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH v2 12/12] fuse: enable large folios
Date: Mon, 25 Nov 2024 14:05:37 -0800
Message-ID: <20241125220537.3663725-13-joannelkoong@gmail.com>
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

Enable folios larger than one page size.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 487e68b59e1a..b4c4f3575c42 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3164,12 +3164,17 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	unsigned int max_pages, max_order;
 
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
 	if (fc->writeback_cache)
 		mapping_set_writeback_may_block(&inode->i_data);
 
+	max_pages = min(fc->max_write >> PAGE_SHIFT, fc->max_pages);
+	max_order = ilog2(max_pages);
+	mapping_set_folio_order_range(inode->i_mapping, 0, max_order);
+
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
 	fi->writectr = 0;
-- 
2.43.5


