Return-Path: <linux-fsdevel+bounces-62834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A79BA2171
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BDB1C21A24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 00:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A657B1534EC;
	Fri, 26 Sep 2025 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPyWRK44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D61DFE26
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846586; cv=none; b=SgwzKYzQNlWQw4zb2yBwv3Wa9ijtTwChjwZN77l4JDXlH12o58BSDuQs9xhB9ahJU4jYlPPQuw0JDPJjo4F3gJPpyicawrl3Er6ct6Eyb/QxRxYL7ttkZucEK5Wstr+n3UCml/vhiPKCM6GCo1QbvqvEbGQaZcNX82AInvczAuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846586; c=relaxed/simple;
	bh=K4U/CA7tbg/bUek9YcVC9Q6ozcjFrUj/3jdxNsXhIUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEBFOIoFlUM+qetEqKTSPyYIlUlwoDn2C4RkdHGZXRGvFki97Te5rEBfXNMc2hfjAaOq2Hcefd9wtRUm+Yk9rcaCtfXFK1DTlIN8myzAAgRGf+GpllHhwFpQ1qwKLgp1+ZWlQ+xf6AVvQIHnhc8T6DwgdA5Njm8HCn9eMDyBObw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPyWRK44; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso1660826a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 17:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846583; x=1759451383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnw5A92oVT9gS4E1+yrEsisFkg+/g1YXgFVE1vK/hEw=;
        b=QPyWRK44jKM9h0nlW1qwvNRtnVA/3vxNlJ9vaOftxKLhmrMhpKm1x+0pigvVHGLmTJ
         a8pKU6/KthmMGAZXtD2MppiVcrpADe/1w0rIqTgucSvHsaav0TdakPXHfoKPbZkQNb/u
         PMxZGc+qH261BK70S6EJrDKQXTo9k3LZvX5Z1vm5ZLtiSvHVd1KaiJ656MiINaCcmz+9
         DGBf+xMlfzPbWxwwjRi2sDAY1++wSs7Rldv2k9pB0mtAo/F8XKb+wfTLG5k9cSPPSfEd
         a5VKxgfIE+zLPiq/avRCLsU+s/Z1N1EUz6TclKq8e3rFsJVBH6YmcqTst7nT9Me0U81Q
         K3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846583; x=1759451383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnw5A92oVT9gS4E1+yrEsisFkg+/g1YXgFVE1vK/hEw=;
        b=iSO7Nf13uB7aA+S59tJm1JBX34N3ziWnrcFyCM0q4Ree+fwhcXkv1ctBYQQuztMg7k
         13MjCSBER9cEmeaM2fZZX/oUAus84Wff9Dn9RT3vgSYNLcftcF8eLJbv/aSdF7z41oAO
         AGf2wC0T+f4VD8MpXR3OQAKMAyytLDlIuZOad6DL/zMxN/XCwiurqntZSW9zF4Ng/6lj
         2r8KpdhpG0hRqM6biX4mog0UOaFBR3gBd8KoPZLmahiPccmgftuvSVHoXS1ZQqigZlOy
         RGsphq72NQrmI0DoEMNrSJT5q5BwrFWXCY9rxhtQDmQIaPstqIzYlh7ouRCXNcFWdD7l
         LrBA==
X-Forwarded-Encrypted: i=1; AJvYcCVKiPaclwkbSCacGYpT+0drlJHFpYC8d9JVvopJBDFfRtyPDjCjZ5+l3EXOCxQ8wVFs5xtVf6UaoU9fciRe@vger.kernel.org
X-Gm-Message-State: AOJu0YxgX046m0rSJXXskUTd83ww/HMzONJ5+3gL6F/WOv1r8ZVd+wFS
	+/sRqeASldTZtTouJOGGZ8q+YqJ0CP8YNMbdmh/w69mtvRjyYxnhc8b/
X-Gm-Gg: ASbGnctw04/kwHmtRKzlonNozNFKp1tCO9njsdzAZpFVKdSATp19k3Y9Yznp7wKWcz1
	T93aF00oKeDhq1uqDkq7uHPN4CT6DIA6iiBof+psFrftOePUybPdx474R/IpDI+3Nw7JP2GQCsk
	N2YbMhaAdPGH6x3H+RUtBwIi+hRycU+Ht6kipsrzmunQsPa0yE/IiXE5wIFNC9x8XGgbLJon16G
	hmjvyuRApismEkjI/xhXsqZc0wz/Okf3CYOrLsCy7H5CnHmvdZUVrTSyeX/Ww5b88uVd6MnR8sj
	xmnV8WkwQfwObGq32VAz+cRpjVDMW8/UA04AoWtmC0eHViJ+mS6ula0ynqeNgAvCCuhtwQpZ1ev
	ZYlifZSzn6gjLYxOCHJ1Eaz64s85rnHmn6UljQyzOihaaIiCU
X-Google-Smtp-Source: AGHT+IFgIIl1rPGc21eAT8naPz071UhBkST8ixc2RolNH6OJ4L9deyZJbJu4MjaCN5pTwkxEVsJ2zA==
X-Received: by 2002:a17:90b:1808:b0:32d:4187:7bc8 with SMTP id 98e67ed59e1d1-3342a2b11acmr5934143a91.27.1758846582994;
        Thu, 25 Sep 2025 17:29:42 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347472e49esm3605217a91.21.2025.09.25.17.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:42 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 12/14] fuse: use iomap for read_folio
Date: Thu, 25 Sep 2025 17:26:07 -0700
Message-ID: <20250926002609.1302233-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926002609.1302233-1-joannelkoong@gmail.com>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
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
 fs/fuse/file.c | 80 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4adcf09d4b01..db93c83ee4a3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -828,23 +828,69 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio,
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
@@ -1394,20 +1440,6 @@ static const struct iomap_write_ops fuse_iomap_write_ops = {
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


