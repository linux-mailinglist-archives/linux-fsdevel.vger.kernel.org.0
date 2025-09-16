Return-Path: <linux-fsdevel+bounces-61852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1200DB7EE29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90C23AF568
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAA22F3C08;
	Tue, 16 Sep 2025 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkVuVp4v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884F92F39C3
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066649; cv=none; b=qiyc31jtfnHwizAgM3TZx9AdJT9AjpXVzrnSfG7cQaLO9cduewiLzg+f35/geV6P76jEMUyYYbrqdlDQVH5TET1kRNbZoCPpyX+tF4gHtHWucyTdAIRp0giZB0GUTsb2y4lc7AT5hy4OB4QjyeKN087ffDWWKAs82jXJmdYNIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066649; c=relaxed/simple;
	bh=LyOsg2Bu1m9/Q4KGCsDW7iDLciMuCVOGZhuLWbBDsng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYwoIQUNfC4oooItoNXONGursZEZxX+/VURKHI/V2F7MMIvjhDH6YECVfvg939v+leTfu3+T0tZFZI1lYlttWBp/pNWlCQyZaLPwp1gY49xlQK2OK8QJni7XwztgghjnwBQyynbJS+RpGzd8X6BdJ2dvItfI4VUEivHZmfp3Qvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkVuVp4v; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so3575278a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066647; x=1758671447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGUNyWs1OxmiVEgLdMH+/qyYZ15HscPzayJVEDJfjsE=;
        b=bkVuVp4vM9nZkstX93tbmtvmp8fmXylyozjHXX+nfwo7jlhWbc+O2joE8gayybxBRX
         v2arqopH7u1Ob+GfUuGPm5vLyVfoE/B0WRSZdKFZ+Z5WIW0utF1SArFDT0j/iCqAtybK
         deVuD+1tT62Bf7nq/BFrZykP4jYN6MF2GnUmKfjsE7M5zLO3K9fipa8jnzSW1y+l0Haz
         8k2HBZ1+x3kBA+Ja194Sxy345waPZbFG/BO0siMkPJV9zvufHfFLA3f9GRO4T5gm96rr
         27eZHvm71fcUG3r4QH2l7M2eNR6sRUZc9sRKIE+gKvsuBV/t4Cy8aErO259zJJXh8Xdu
         0dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066647; x=1758671447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGUNyWs1OxmiVEgLdMH+/qyYZ15HscPzayJVEDJfjsE=;
        b=r/HEopOjkEUIp723NXRlLblvqzElBCcusJwb4HW5TAuVT4B9uMpWVSZH48FkViNeib
         z5mwCbAmip+KvDfLB9Js+Rkj/BIFH8sHVGT1FIR0b88z3dMSUOUrYpC8iQ3Ui4376txH
         tBVcgUHwym5mYWZOQwEv8e7cqST3oQ9hFepcMiYU1AnZN/r2LrzfVVmBFgVuliqGZ4ym
         oYgV0BhcK1Rg+z+mglMYYfxGkiHdA7o1lMA6Gr2jdtL7bGzrGMPmN/qXCgT1avijAjRI
         teSdvc0fEG3+9TkxD/3SY+kxPysTaRvgxQc7u7T0DhS83Giv35W1cD8JukWOMPaey7S/
         Ng2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLd+1U5LyAU99LChVT3WKTazBkdAhx8UOoN10+7eO8XNfepWHEYmGBcCYU/BcRYdn80N1ZHE8pY6u3cymi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/j/UQBiRQMdv5e8gYdclt/JwGEAcVwH4EDznRgB6/xfqnxbde
	a/LoQcwwcg2rrdX7FeKakDt5Rt5riro0UEGJ8Cl9XVn56kRdkQwmnQUb
X-Gm-Gg: ASbGncv+k8gSeameLhSUTia1x7CuN4i0z9M0509JpeVgmu9kTsL63DFLU5IYx29MOUX
	30ssoVE9JkDJN98ZLczPVf49eJuvDc5rij49N3I9x5+iLxWPMfqQzZ30pkeZWlDbHh0reCRr3Hq
	Dwc8HXxVYa5wzYu4rPAvIYcYVhyo4bHBG7Aphi9vCIkPbpdxp+SZiejdVzGOpxBimAXVHmsfdvI
	NRWpGkIdu/GOPyzs00CPLCCcY4tilnpvaz0lTTPPdsAw2nvuHcE1GlXXGogjfMsy5lTNJUkf6g4
	9Bw62P/8FdaAOWfU3ImvuMAhZ5W9Eipe4VrMllKIny5zr6C/pUD+++mMBblVWHWybUnIGYKRHCp
	Zk0BGlYdykegL+aK8hxA+DHDrkzTb0BdIuNzEeW7m2LKqtWgP0A==
X-Google-Smtp-Source: AGHT+IEDsgdnT7+nNQrDhXR5m+p9OqwQpqgyiqsnD7pJqTnVO6zC/tJ8dk2Wmo0J+/77Bc7uR5fcOA==
X-Received: by 2002:a17:903:1a68:b0:267:b2fc:8a2 with SMTP id d9443c01a7336-268121808e6mr1290225ad.23.1758066646820;
        Tue, 16 Sep 2025 16:50:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267e52d1621sm22110075ad.40.2025.09.16.16.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:46 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 13/15] fuse: use iomap for read_folio
Date: Tue, 16 Sep 2025 16:44:23 -0700
Message-ID: <20250916234425.1274735-14-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916234425.1274735-1-joannelkoong@gmail.com>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
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


