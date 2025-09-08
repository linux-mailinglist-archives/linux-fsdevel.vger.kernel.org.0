Return-Path: <linux-fsdevel+bounces-60595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A276DB4990B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2483B3B81A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742A831C59E;
	Mon,  8 Sep 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeP/an+C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70D32142C;
	Mon,  8 Sep 2025 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357560; cv=none; b=ac63iDS0GycHo/EanfVyFkFkasO6fhSzKAFgra40Vys6RqBTrFcdVpZ3GmDM2pHf20yEijMaNlVnzowsm6GmP4xzkza1EZLstu0ytNfwlREjpqmHrr9L2dciQVoqXY3eL6P2VygpV+yn/YvFzM7gsrYQ8nk33CUZJNYg+/7Fhrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357560; c=relaxed/simple;
	bh=tepfHzH5hZwS5wTpe51uts0VZgTsorR+gn3Z+N6t91w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQWYvIgw78cJ7LNNJz+j3pu+IyAkG6E1wf5ydT9UlLJ+IDw6zvcdVo4W0cg1uW0vHchV02UxHh/cDj9lmTZaHYom5qBAPVIWFm3+bmZXJNX0qZoqJ61oFQm9NkCMfBcAEi1ZbxU2NHm2Yt0PPvloTV6QSHibaIvjwuoFtsdMmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeP/an+C; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47173749dbso3191746a12.1;
        Mon, 08 Sep 2025 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357558; x=1757962358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Eb8aM+Y/JVeKEnqwZVjBjPkl+JL1qOEt3ClFoOdOx0=;
        b=TeP/an+CBjKxxrynyjAqfQeryEgn3WXA9hBDZjG/6oxY0AY3X5c4uG8WoY/9vs1LNf
         QbDUFmY251xke92+fgYLD22lmGNsRszPL5vpI9y4pk3vSqO3kRqLkw4Urn/12lpPjLOl
         D/DB6EwTDKzJ5VQw4Ga8CmkUV1lsRvR1gmqDDwUZlKDeeRXa9TBdyby+S8vmzcjOv8dy
         M0UQH35drQRA7re1YfET89TBIDqI9HBwuMgn17Grx/mnFHj/YU6VJAHMJDX6VTfRaNIR
         2M/A1aWNAfcJA4M8wEmqFk2BUrSeqVIhZhi4+vI+OpaDRimyAFDVahb5+YoZUJBAPIlF
         LUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357558; x=1757962358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Eb8aM+Y/JVeKEnqwZVjBjPkl+JL1qOEt3ClFoOdOx0=;
        b=E6HR3hWjpqmyYEpvXqTRXUuY10BubC1ZZkkITlU+4uB/Cl64OAGNI5Qt+zehYM1xD8
         j7UxO7WbKZMEjMUGGegudW5DADzfBDw26xGIJ3C0dGKXBgYYmaPz/zzJmRU9mmD2hndR
         yLx3qSRT2aHQ2bxTDBCicV1v0xYtS5JhnF5PiMOSsmxZvLzDZDuQxquRbBDj/FJi1NQ5
         2Pp7Ad0U45JwXY0wGrJ0KEdD9XoCN8nnaZgZs9W60yBlpCdDyBLIcds9LqbmUeD99vlz
         QbWEUwmJB+tWbLFBpKXDJ3v1ld6Bd1xRANe2ZmXBq0NkRPwe2QGT/996nyISu0tmofgF
         X5PA==
X-Forwarded-Encrypted: i=1; AJvYcCU/uLs5DalXxrhu7l32KZ3kMSm/ZoIiIcRe9TGhDXr3sMAgE1FZ8wgBKyp1k4YG15jqBcTyr6/qI+tAjQ==@vger.kernel.org, AJvYcCUf37KVeod0tQExtBYAaKxHq3XAoJmJqrtwj73YWLmRUquGNsBnYqLIeL8oec1X729/AHBpjKF4cdS3@vger.kernel.org, AJvYcCUy9sN5RHU8rW/+FZ8RKU236RU67wlSN8PGhZgkj9RUY3FbndQfzaw8Mcr1AEPLhpUxyOPpZzVEIDFG@vger.kernel.org, AJvYcCWW1vUGmdPjoYRA79fLxIESnIWpAPk6EYhF2fmvZPwmMQ+0wKmuJP8AOw/Fr1FaaQuaZiAOclxjjLBk0hpnSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwKwXNV0xLtL9PDSn2PyRa70tMIU1ZuZ53Hq7Z5DLSiqA3tZhJ
	44m1r84lf36cDfxRJFDFjFA7xn9pgqTA186jG4mbxNnhsiIxSX63CPVg
X-Gm-Gg: ASbGncv+P2+1jpeDR4VY+IoCHnbqsZ+nS2WtJrHriklPL4X7zNqJ7VNi9OBhMvQ4acE
	ZsZC640mZc6CrAqOAYDmgdnA+wjA2J6pVpk/3mpkeDpNThWPXxgAIMFW6WM7SVyohsuzn9VNZgm
	vJxA7O++kaAXeGbMQUZiFeYI6v0GqGKlDT37ExEbATSbfw3/4nr4AW5D4TilpyJTULEMbGzGzBo
	EArqLIqCjlPd2QyLjhfJOvgzzmWdIMGxuy0ReNTxyApFgjhrbKn9XUDkZ/SSp/2Ucel3+fAb4VU
	vN4Ib89JKhqDvqpx3IbE21C2g2UkMxxDLjlyviApWGezPOm0eld77Cmu5ol9+lA9zCeRhjf3jxH
	RjiYtoed53Vn6u2fYvQ==
X-Google-Smtp-Source: AGHT+IFdkSkXuivdmkkLCkNDzHHH2j2oNa8Rw15o+okITyX+2rUE6eDXA/1am5MRLtz/aJ7axJnRAA==
X-Received: by 2002:a17:902:cf01:b0:24c:cb6b:105b with SMTP id d9443c01a7336-2516e4ae7e2mr117896905ad.25.1757357558378;
        Mon, 08 Sep 2025 11:52:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648c89bsm293986985ad.109.2025.09.08.11.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:38 -0700 (PDT)
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
Subject: [PATCH v2 14/16] fuse: use iomap for read_folio
Date: Mon,  8 Sep 2025 11:51:20 -0700
Message-ID: <20250908185122.3199171-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908185122.3199171-1-joannelkoong@gmail.com>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
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
 fs/fuse/file.c | 79 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4adcf09d4b01..5b75a461f8e1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -828,22 +828,69 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio,
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
+					     loff_t pos, size_t len)
+{
+	struct fuse_fill_read_data *data = ctx->private;
+	struct folio *folio = ctx->cur_folio;
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
+		.private = &data,
 
-	err = -EIO;
-	if (fuse_is_bad(inode))
-		goto out;
+	};
+	int err;
 
-	err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
-	if (!err)
-		folio_mark_uptodate(folio);
+	if (fuse_is_bad(inode)) {
+		folio_unlock(folio);
+		return -EIO;
+	}
 
+	err = iomap_read_folio(&fuse_iomap_ops, &ctx);
 	fuse_invalidate_atime(inode);
- out:
-	folio_unlock(folio);
 	return err;
 }
 
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


