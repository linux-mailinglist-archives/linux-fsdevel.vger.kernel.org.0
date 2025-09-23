Return-Path: <linux-fsdevel+bounces-62451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52702B93BB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 02:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7762B1889F99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 00:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC0D224AF7;
	Tue, 23 Sep 2025 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNyewmMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF621E0BA
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587652; cv=none; b=NzjXe7bXAdLmKQYX/8mx+oT5LSWwkTbnlJIH/AOQKXhpJ84CUw/bDhPgoJl1oq3v5tPheikWWOS1FJfs9gN+IEJuBpsNSyZp2WY9NfeuILvmTney/YDoSnNGz4mQi6yR2iuj3oPYymHSCxHeQuH69iJUTwE2RT0MI2Xye6jKam0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587652; c=relaxed/simple;
	bh=LyOsg2Bu1m9/Q4KGCsDW7iDLciMuCVOGZhuLWbBDsng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkfvMpzsJEE2sc9dI+zyjd8tSSR9sFiD5EMvgd4v7qEzVBCTDjEj6gTPkwR67f39abCO2PJlBE55v8sLQMDsslt/+d7gOyoOeyJcfc9K0Sg5x3jk1GcpUDYu2kDalnlaNi51qjrka6jakhCRGmsQTnvuyDMwsaGebsQAgMs1aIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNyewmMu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f2e960728so2283603b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587650; x=1759192450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGUNyWs1OxmiVEgLdMH+/qyYZ15HscPzayJVEDJfjsE=;
        b=nNyewmMubgRg/htQHWcoavsVoAEtwnHksZchXXcjCh8pGiO6/RA/jhA95xj28ze9ti
         ha7PXccL8GJc1KpuE7wJtBUQzRcuTRqJsw4Q3W+aMGjLPnPqWJhlGd2uidjWQDOibyqd
         R9s0L2wL7P6diNmseMM5ataaEeG3aGPKvbsDT9+TIHUgg1PfUfv1pWOXZZ6zWkplstj+
         91WDVQbeLw/5wF1FECC5FbakEnRa4/4Z8Q5TTlYeXlVQyJ+wrquxMC4WY8KC0wCXaqtR
         R9b7YIbqpX5leriFdiNvyIT9Ot6LOg1ZTZ/SC1LPShsg41EDtTU/SrRddcABgXuwAos1
         RPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587650; x=1759192450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGUNyWs1OxmiVEgLdMH+/qyYZ15HscPzayJVEDJfjsE=;
        b=os2ynJmC53lWkf3EG303sE6zRVyl9sGMXBf+VL/eAmjKVEJ7moh9L01gF1l89Oln3t
         y9wP0DrFTp7knwie/yUYH/ja2lYWd1CpLBs5vng1uWWapOEmzvMPc6OjBCyk/RJG0FT/
         D+0f2nvFrxyyRw7vETBKYf9AWqVEa8MP6ySfva6/W5D4n+TMzStQDWnckr5mdMtxqKZQ
         JvOHYbkcs+LBxkcmTcAaJ7gPHf2Lao+h1wTaMEdMSF6bklW5N6f6727tAnYLzie4gQgK
         8e8CIXMRfi4xjVonHzeciGZDPuKkWWkq2OLBXx2ItqNRha8z9mGVF9KAwH0bIGIPNx4q
         7irg==
X-Forwarded-Encrypted: i=1; AJvYcCXWqVVhdxlEvn7tAFzbpLUNmOTwuptzhZWcTcFWKsk/2ix1KfbC1x1SMeh51tfnK+jVJ05iaCA+UKr64pMc@vger.kernel.org
X-Gm-Message-State: AOJu0YyxzV6rtEusjbXnd6SD3R0ATaka9ovoX6xexOnTu3wdQ2CdT9YP
	Aenw2rp5hLNpUYA0xqrEDSawuN1ngjOGn+A1SBhtDShf4Ei9wwL/+WaxC+7p+w==
X-Gm-Gg: ASbGncvdUpWLChHc+TfX7hiOA1JDwjWcFrCsare9AkLf7gJWFN5eilOe04gJyHsI26Q
	kO5n4D0GBRt03knL+pfVqoFdVRIb4rngSE3O/1FkOzeOQo8jBVj8IpBFhst/KY3n47t6rH6GEfH
	/IpPCUmnqUlBDh07FN5ngBkuPdQbn2s8T9cp4DOR1+yGwovGRQolo7otFLv0YHREUwtlYuH9kqp
	0YdHuFf+ZGEGuKlNsHPtDW8+EH4p7a34yT3rHYB3aYupPhfDsxKLqPPTHYtk9LDQa8m0tI3IHf2
	47Zlb91q6VXBdmE0hiyDKs8lma1rfse3SbuiVfhZTeti3eytGHJzHiaCWtmi1E1d/3ofsVIsYY+
	0gQbV3kgJcyWBgzJVHK93qk/8YgGfjw/HH5CILfImCfgmdVSf
X-Google-Smtp-Source: AGHT+IFDRYIdyBl04iBYoDUtSI9mRjhTN7zVi/dDiSEIGK216VfDG1RkUSAPcnJWtf4ohk7umhb2Jg==
X-Received: by 2002:a05:6a00:a93:b0:77f:4306:d248 with SMTP id d2e1a72fcca58-77f53ab8044mr872603b3a.22.1758587650623;
        Mon, 22 Sep 2025 17:34:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f0ef2db80sm9374730b3a.24.2025.09.22.17.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:10 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 13/15] fuse: use iomap for read_folio
Date: Mon, 22 Sep 2025 17:23:51 -0700
Message-ID: <20250923002353.2961514-14-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read folio data into the page cache using iomap. This gives us granular
uptodate tracking for large folios, which optimizes how much data needs
to be read in. If some portions of the folio are already uptodate (eg
through a prior write), we only need to read in the non-uptodate
portions.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c | 81 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4adcf09d4b01..4f27a3b0c20a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -828,23 +828,70 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio,
 	return 0;
 }
 
+static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+			    unsigned int flags, struct iomap *iomap,
+			    struct iomap *srcmap)
+{
+	iomap->type = IOMAP_MAPPED;
+	iomap->length = length;
+	iomap->offset = offset;
+	return 0;
+}
+
+static const struct iomap_ops fuse_iomap_ops = {
+	.iomap_begin	= fuse_iomap_begin,
+};
+
+struct fuse_fill_read_data {
+	struct file *file;
+};
+
+static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
+					     struct iomap_read_folio_ctx *ctx,
+					     size_t len)
+{
+	struct fuse_fill_read_data *data = ctx->read_ctx;
+	struct folio *folio = ctx->cur_folio;
+	loff_t pos =  iter->pos;
+	size_t off = offset_in_folio(folio, pos);
+	struct file *file = data->file;
+	int ret;
+
+	/*
+	 *  for non-readahead read requests, do reads synchronously since
+	 *  it's not guaranteed that the server can handle out-of-order reads
+	 */
+	iomap_start_folio_read(folio, len);
+	ret = fuse_do_readfolio(file, folio, off, len);
+	iomap_finish_folio_read(folio, off, len, ret);
+	return ret;
+}
+
+static const struct iomap_read_ops fuse_iomap_read_ops = {
+	.read_folio_range = fuse_iomap_read_folio_range_async,
+};
+
 static int fuse_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *inode = folio->mapping->host;
-	int err;
+	struct fuse_fill_read_data data = {
+		.file = file,
+	};
+	struct iomap_read_folio_ctx ctx = {
+		.cur_folio = folio,
+		.ops = &fuse_iomap_read_ops,
+		.read_ctx = &data,
 
-	err = -EIO;
-	if (fuse_is_bad(inode))
-		goto out;
+	};
 
-	err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
-	if (!err)
-		folio_mark_uptodate(folio);
+	if (fuse_is_bad(inode)) {
+		folio_unlock(folio);
+		return -EIO;
+	}
 
+	iomap_read_folio(&fuse_iomap_ops, &ctx);
 	fuse_invalidate_atime(inode);
- out:
-	folio_unlock(folio);
-	return err;
+	return 0;
 }
 
 static int fuse_iomap_read_folio_range(const struct iomap_iter *iter,
@@ -1394,20 +1441,6 @@ static const struct iomap_write_ops fuse_iomap_write_ops = {
 	.read_folio_range = fuse_iomap_read_folio_range,
 };
 
-static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
-			    unsigned int flags, struct iomap *iomap,
-			    struct iomap *srcmap)
-{
-	iomap->type = IOMAP_MAPPED;
-	iomap->length = length;
-	iomap->offset = offset;
-	return 0;
-}
-
-static const struct iomap_ops fuse_iomap_ops = {
-	.iomap_begin	= fuse_iomap_begin,
-};
-
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-- 
2.47.3


