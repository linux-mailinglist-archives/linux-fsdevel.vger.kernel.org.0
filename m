Return-Path: <linux-fsdevel+bounces-59695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE795B3C5F1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7608BA08C7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2486B3148DD;
	Fri, 29 Aug 2025 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ituyD8/U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107235E4F7;
	Fri, 29 Aug 2025 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511918; cv=none; b=QuNnO9Xqr5v46nxMxkVwRXtCE6C7VWFitMEGD1oaPXGAVnTyNkYB1xWYTkEknc8FHM3/Gm7bEwxmGJlraP0O0CjnuUhSeVaxYvHqCTUi5UCN35b8uZArtHg1En7HWlaOSh8vW5MciPdg1oZ/kjAOllUqpR2/OT+HEMTVBeo5790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511918; c=relaxed/simple;
	bh=lLMu7HkclQ06pgT8t3oFq1rd8yN0L2swSVCm8922iWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWQ4SjxXj5IF6X3i3MwLcF+pB3RyjsT0tdaAr+J8MGs3EMzvdpeIpObbgvcYlOpa+ax1Yfk/xbtgdlU2eyvunfL8RpzWmMzofxj7uTHM6jPONBqpsZ+fzpiRJugRAWb2/dbSQh5dVVwCru7zAabdY7t3iD97N0OZ7GgtYC16a20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ituyD8/U; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2403578b3a.1;
        Fri, 29 Aug 2025 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511916; x=1757116716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AY6KBnE0XEYPJjIMTiYQ0yEJg8W1cIwHqSm7hKrUTCI=;
        b=ituyD8/UGDeWZ9TctOa/XpZ96CVKO2K4NBvYwVNZaWBOFDa5e/5nWhUkuNkCMZ1P13
         mTRm+KxlOF0JxMGRv9lFMd/Y10f0By6QzAFNIojwYHQIonWlAtKGg+j/2cVceiyVydcK
         tJeOJ5cVModFMC0RX74HQM5QNBmKocAbjBT4v9dpsJWflkzKUcrBU7D5yEiqp7EMxaca
         AIkJd/ywVgNFD6zhUVaSPJRnFX/5X/UYIwDV+mkcLAlYxnB7iDaix2Gj918/B/nq+uEs
         ddeFNLy6FrkttYa3v09+LSt19L4ErwL/jDv381+OjgBz7JWTJPCUOccAD4zfaopdJG1p
         neGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511916; x=1757116716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AY6KBnE0XEYPJjIMTiYQ0yEJg8W1cIwHqSm7hKrUTCI=;
        b=MsSgS7bGTWyz7Y+vA8+w2efPnBgFcbCJMhxPTq9J9D3lGDUANkYd1v/RsYduecXl2X
         jHh/fC/WNk+z0RBtDMNA9Px+5xhG/2RlFHSSjvQm1/6s/GrfcBTrg/oAbtRPJJDqEjhv
         pj/F8N5IJYCINn3XZO3ownPIAiiYf9ZRhvEd5e8P8pQX/h7sxyJfaJSwNjd4V6IXFNPj
         gZqY2XTyZcrNpVtGYuIF9NrCQ6JKoyEAvKMRv/cKxrBUCCxxjJmDx4NIJ/x3KWLAKP7y
         RdV7ha4gUPBL08/bB6t838/naAh4Dkh7Ca/wysI3uElOPoENYEO2oC0BaQVcfHKp49IN
         meSw==
X-Forwarded-Encrypted: i=1; AJvYcCU56YJ+D9rGzgPo1jjq7mznMzb5KpHDo4LyMEU3ZXzcoFri9BHJ6ZKfUuGZpXzVLA2cO5g3z8+IE+Ro@vger.kernel.org, AJvYcCWDc8S07OS6qBF+8VYGjlDTMjR1NHdfZ5qQeYjGlKsIWswTpE6oA0f3q0xCExCs1K2zTstmZAgFIYORiMRVZg==@vger.kernel.org, AJvYcCWql/SNIxdStrcsi6J/Myz5Nqr6QuHiM0z9Ru/EJqvig5kUPi7Nczf+bKkk84Yb68KmU9772nT16oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ65A3A6JdY/B+YwxMx/m5NbtAFI8rR5Ws6hDw9TOLnAbD4lSm
	Gqcsta4zWylN44OxkmCL/4RcpkcBRL39k1Erk1g4rvFlC9QfF/SH4QHE
X-Gm-Gg: ASbGncuzfd86b7igyQ/UXcDKfCSxjK78IpDYl1tYo2e+ZAkO3Z/b6VgsU1loNL7MhHh
	haA8if9HVswBFEBujiAFsTaGFOaxLQpx30Yr32wkjeoHNf+TpsZGylsAyKkcaXcM8Z065MamBkF
	vHF0SzI+frGthy7UBYD2zy/ij/yRzQuFT37S/oE7ATL1nZSA+ue1thv+VJ7W/LiYI5k+RRZXeHH
	HyRpxIC/q/F3WOxiZ278PujV2vpPRal8yb8qnyp5b7r4i3DWmQ5ybLpJN6a/sK+Q43kWsHPB+3T
	FZUq6hN2vj065c/Mhwq6m4c6iDuZSjjuNjVfz4WfgGt5tRqyfYcYjhGd5yzhtKr7myagoqbRqKy
	PpDlbfDfGWrG8yUFh5kK341ano+Y=
X-Google-Smtp-Source: AGHT+IFphesjVE1k74ptpW/6hpiNoz+olo5rn3W8pwCW6PBW46HaeUve0BkG+b7KQckgpeAZdfxZEA==
X-Received: by 2002:a05:6a20:3948:b0:243:be3f:9b97 with SMTP id adf61e73a8af0-243d6e3c0ccmr536829637.13.1756511916298;
        Fri, 29 Aug 2025 16:58:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b2f56sm3487996b3a.26.2025.08.29.16.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:36 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 14/16] fuse: use iomap for read_folio
Date: Fri, 29 Aug 2025 16:56:25 -0700
Message-ID: <20250829235627.4053234-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829235627.4053234-1-joannelkoong@gmail.com>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
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
---
 fs/fuse/file.c | 72 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5525a4520b0f..bdfb13cdee4b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -828,22 +828,62 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio,
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
+					     struct folio *folio, loff_t pos,
+					     size_t len)
+{
+	struct fuse_fill_read_data *data = iter->private;
+	struct file *file = data->file;
+	size_t off = offset_in_folio(folio, pos);
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
+	struct fuse_fill_read_data data = {
+		.file = file,
+	};
 	int err;
 
-	err = -EIO;
-	if (fuse_is_bad(inode))
-		goto out;
-
-	err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
-	if (!err)
-		folio_mark_uptodate(folio);
+	if (fuse_is_bad(inode)) {
+		folio_unlock(folio);
+		return -EIO;
+	}
 
+	err = iomap_read_folio(folio, &fuse_iomap_ops, &fuse_iomap_read_ops, &data);
 	fuse_invalidate_atime(inode);
- out:
-	folio_unlock(folio);
 	return err;
 }
 
@@ -1394,20 +1434,6 @@ static const struct iomap_write_ops fuse_iomap_write_ops = {
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


