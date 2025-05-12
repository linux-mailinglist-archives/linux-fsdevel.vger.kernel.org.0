Return-Path: <linux-fsdevel+bounces-48781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E49AB47BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 00:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466EC19E1373
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 23:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA8F29A9EA;
	Mon, 12 May 2025 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EriAnt6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39D229A9DD
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 22:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090778; cv=none; b=JT4M2A8V6JnEicLQEg0d62PN9hZ4QuQp83NL9h9ShVipRwCl0QF1sYTQ2419iaz1P8f+vx55fwMCWevMKgBgytKz5jUw35nWCkyIkCoCu8QqmIb70/g5vekT7OZ7Yz9nqQpgZcXzmJdTemupyRSCEOEffGkQFyJoUT5MmTJOyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090778; c=relaxed/simple;
	bh=Ge5EoEsLfxGUHkQyc32praaw5Jp4NWr6HJKAUQsaj44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ae4sSRb4y9zUBHYCuSq3GfFXy4wTL/ISKyO8zN2d5AIcNFIVaXyqbrGDBSutW1UOVJKezLaWZLLdaMIWM2Tg0xzCDQkWWBGIssezQw+Qe1M83L5tNa5DX840MAzX9jgoNQALltB+Hfd1X9oxTtSLyjrPPok8UZR5hAO45y/nnyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EriAnt6p; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73c17c770a7so6011023b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747090776; x=1747695576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQ+iZ0KFCP0gZz2f3dLowBb445hvVnr0DYEIuH+Sp3g=;
        b=EriAnt6psaJ/nbyDPKa9li11n4M1NNtwaynAyBa/B/hlwafc7ru+Kt5f7+1l3o+5Rv
         NxhWLQFKZmrCeVYyh+Fg7JY0q21d3f5ur1fanoR8051slA2rezgCKG8xl/qPsydAhdz3
         0S0MeIr/M/CwG6b4fwel1ieRt6NotupCT8eXcR4v4OQwwqYoeocQNKrxkDnwswDrULlo
         i5+o3stIs3GEAYt3frlpQ2oXqMzWNCcAH8VX4S8EEgG8dQCrzLyR5r3xl5Mg876lcGNq
         MtIH3YHBwr2RREgSyS+102MnNtL+8BbYBz+/Bs3rPohFCmz6caHDxonYKy4seb83zUTi
         tWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747090776; x=1747695576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQ+iZ0KFCP0gZz2f3dLowBb445hvVnr0DYEIuH+Sp3g=;
        b=Sj1UovjYbR9cLFqG6+zSlX8sKupRtxCAL8c0A+Rec6lg08KKVV/A75rjx3cuiisKKM
         ycLjB9fPBk93nD1Dyu1qaC4k05+1Ol3E92G6RF7HtNd9v3Y7jDJVZfJLf8/T2kY5PbOA
         zRq0wKSmQiWlxVZ2jqmeDCx12ec5wP4F80XRejUfo37CwpXh79LAFXXoDkW4Kb4AKDwV
         Wlw1588XpCtj6lA1bDhvtmlMW4Zn9ZIv0su+SF7zOyOuHDtp7YxotJ3EpoqxXMFlLaVt
         eF9wAaYXLQit+++qqbg8ikFucaS8sAxDKw3jUkpubAsiZJiNWoShNcdMdM0GokQylA6J
         NnlQ==
X-Gm-Message-State: AOJu0Yw43NsUckfY5oRDTaPNmk6BEomos+4os9qV8N8ZKPwezd4+VIMq
	wknwZbP3vPqvf8p30fubDyOkb9s2u5o0b1Ca/LH04TOa6ew4ExcL
X-Gm-Gg: ASbGnctkntVqS2HIUzbWKJ3W0hBtzLiVk1bti+yCQ87Aw6ZpM/iU4pVtOHM5IOk+YkO
	pxXI+mFG4YMHivkQng8cJn/ZrETKZoxlTJoqavLuhT307zOd6MQOmdzC+8tFFavxLKv1Haf6Owm
	+7xiHhNpXYa6ntTfh1c5SIov9+A46ZbWKTQlxmnSnmmCrKIan8r1UIO2D8u6qLNyCEm72kEGjoC
	+To/JBR+Nn9FvSSQqZAdKMw/diN1r5sGjm/ttgQa1PXeUcj52PNT6dSClySEviLTvE9FmeVGW3K
	T5z5PCTjdtkYPFjjmMCizhUoyAoPb2558FaegNXMbW0Z+9Mp+w9wujAI
X-Google-Smtp-Source: AGHT+IE0jNqzLfcSh4i3hpHWLLlyHAHrSkN4a3XNNk33cZBJGqR3eKm1ktfUtkrbk3f8g95C2Ojjeg==
X-Received: by 2002:a05:6a00:400a:b0:736:5e6f:295b with SMTP id d2e1a72fcca58-7423be77924mr18190359b3a.12.1747090776130;
        Mon, 12 May 2025 15:59:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237736e0csm6904080b3a.66.2025.05.12.15.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 15:59:35 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	willy@infradead.org,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v6 06/11] fuse: support large folios for symlinks
Date: Mon, 12 May 2025 15:58:35 -0700
Message-ID: <20250512225840.826249-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512225840.826249-1-joannelkoong@gmail.com>
References: <20250512225840.826249-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support large folios for symlinks and change the name from
fuse_getlink_page() to fuse_getlink_folio().

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1fb0b15a6088..3003119559e8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1629,10 +1629,10 @@ static int fuse_permission(struct mnt_idmap *idmap,
 	return err;
 }
 
-static int fuse_readlink_page(struct inode *inode, struct folio *folio)
+static int fuse_readlink_folio(struct inode *inode, struct folio *folio)
 {
 	struct fuse_mount *fm = get_fuse_mount(inode);
-	struct fuse_folio_desc desc = { .length = PAGE_SIZE - 1 };
+	struct fuse_folio_desc desc = { .length = folio_size(folio) - 1 };
 	struct fuse_args_pages ap = {
 		.num_folios = 1,
 		.folios = &folio,
@@ -1687,7 +1687,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 	if (!folio)
 		goto out_err;
 
-	err = fuse_readlink_page(inode, folio);
+	err = fuse_readlink_folio(inode, folio);
 	if (err) {
 		folio_put(folio);
 		goto out_err;
@@ -2277,7 +2277,7 @@ void fuse_init_dir(struct inode *inode)
 
 static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
 {
-	int err = fuse_readlink_page(folio->mapping->host, folio);
+	int err = fuse_readlink_folio(folio->mapping->host, folio);
 
 	if (!err)
 		folio_mark_uptodate(folio);
-- 
2.47.1


