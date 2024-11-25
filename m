Return-Path: <linux-fsdevel+bounces-35854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C950C9D8E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D41B2310E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F01CDA15;
	Mon, 25 Nov 2024 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJbFQXzj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614CD18F2D8
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572366; cv=none; b=KNrVgt7bZmlYRw4GeDY8Zz2s1f+E8f8O4jEAs+WclJpTFnx0fEdHKZUs5cHqLhDUN72Qyhz4I4V3JIkIbMb1rH6TP4l9wMK/VLNYRmAqzwKz5M4Y4ACO4AbXQJpwN9deNy+gzdUdqrfq6195Ywni6FEPzQy9ClQEKeEzLKG1xPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572366; c=relaxed/simple;
	bh=bhqSvXPWxQPhzTCIRae/TCxlpI+rBab8NmnwLR6q1AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8z+Cxcp2q8DJo+PMQzVCNpN/aNkbG1DwaXmOjrD++6j1VeC1HvMiP5eYXzM7tL5/fDluae8t0IPIC/K8WIbJ2ZF5G0YqV3GXKLrWaF2sv4TKlC+2OIBhCNcxCnpYxEikz6v3t+Dd6+XWgS4zkwqWNbw3/5hFZGh6Io2qYsYxpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJbFQXzj; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so4661089276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572364; x=1733177164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwMzRvhCZM3dkWOAz2qoJr7DwJWBiqujZyVJZp2UJm8=;
        b=TJbFQXzjKLR+4f2j3XoOHtN8ETPtKvrV588srYJYg0mMnQrvo2q8hInFIJsK2Ve7VJ
         2+ZYn+ddsIERcYuLEneyxuUuMctcV2V3ODFlwt5LpYquf21ngBNtPcDqa8GEJ9Bt+IYA
         WKQVjXBgw3EUwSBKH41y7FjvUm6hq8HkitjHSJ6PSYvS0Rpjtt4xS02O6Cmech2Wc1nc
         TX0VUKSNOP9QzxJFXQn7+fz1bhB9oBxfu9RtbY15Eeem+jaiN9/njzbhXG34Rpt0WdDT
         yeVBx4HK6WTKFYBDyzkopLg6hrkpBpmQOCXG7v4I313wT4IlxYSKS03mE9nyUsAugvv+
         TZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572364; x=1733177164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwMzRvhCZM3dkWOAz2qoJr7DwJWBiqujZyVJZp2UJm8=;
        b=HkxF4vTqG8xJGUXBGh7mC6M49FzGv3v+4hWFwMI24KPp0vXKDF8a7kZXHmdziGghjn
         YcB6RUyRWOsFkzKqXYHO66K1mzihZgZhaDOxMsMjtpnpJwLN7J3RnFuiPO26C2TR9ngn
         SCzAsT7LOoDylAs4HzN9d+J16ynyn/iIQV4MdvjziOJWzfxcavaA5nzeWWW99na+Ua8b
         plblwfYYNr77UgMAY1MsDG2USoxJy+m628e47mkbZl9kdD+uxhWZG6j+tfk1LcdBo1AP
         U1wUf3I42p3Inc7hgQ8q0bB0Foj/KhptPVs90yUG4uf3v++bSmgXnz2IFoZkIwe5wmIF
         2KBg==
X-Forwarded-Encrypted: i=1; AJvYcCU1DuV00g7Zk1ylesgOTeJzJIZzGQ3EkQoASy9oYcI7YYMU+D6d79CNnhCoF61TWG58V14H35f1qKY/7ztf@vger.kernel.org
X-Gm-Message-State: AOJu0YyGt2EF2O24sdrpFBZbF2smmzf/93dTKP23a6j2YC7mprPrr42F
	aBCER97aX3v+JFHbFORbLe+eb7S9KsO+UIZdQEIaqJwzqTywgDcK
X-Gm-Gg: ASbGncs05Q207AhjS9u9Lw+VqqnhTWUpnux8csQtPWL5+Jz151OBHevFOSMBMhR6TwW
	fFchD366aVduCjAU9uWiFkcJvGNIzymCh1CTLpe3TmzVTRm5Kx7PBjQlps1y0UKSj0EyUnhpZMm
	SRGUIFZjhyWD6Xltdz1fUryIzN4266NkxFjSL4YB7yAS1PXCMX+1KHZNNHGjrxQURZ10v6Q41FG
	HqO9ekwjQEuiJhIV+3dwY/3qQvlYH+saKSUvm7sMuJC3r68B+aMT52bLcLw3otGP3Zz2LMRG69q
	vXRn9ZNb
X-Google-Smtp-Source: AGHT+IH08CtbO+qNwNsJy8cpzah8zzDgaS2tS234vz+MeXeHq0A5xz/UGN0OdArgfdZmJ+mQEX6WQA==
X-Received: by 2002:a05:6902:2c08:b0:e33:2e:eac1 with SMTP id 3f1490d57ef6-e38f8b5a38fmr8261255276.30.1732572364323;
        Mon, 25 Nov 2024 14:06:04 -0800 (PST)
Received: from localhost (fwdproxy-nha-012.fbsv.net. [2a03:2880:25ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f604b594sm2743666276.18.2024.11.25.14.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:06:04 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH v2 06/12] fuse: support large folios for symlinks
Date: Mon, 25 Nov 2024 14:05:31 -0800
Message-ID: <20241125220537.3663725-7-joannelkoong@gmail.com>
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

Support large folios for symlinks and change the name from
fuse_getlink_page() to fuse_getlink_folio().

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b8a4608e31af..37c1e194909b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1585,10 +1585,10 @@ static int fuse_permission(struct mnt_idmap *idmap,
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
@@ -1643,7 +1643,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 	if (!folio)
 		goto out_err;
 
-	err = fuse_readlink_page(inode, folio);
+	err = fuse_readlink_folio(inode, folio);
 	if (err) {
 		folio_put(folio);
 		goto out_err;
@@ -2231,7 +2231,7 @@ void fuse_init_dir(struct inode *inode)
 
 static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
 {
-	int err = fuse_readlink_page(folio->mapping->host, folio);
+	int err = fuse_readlink_folio(folio->mapping->host, folio);
 
 	if (!err)
 		folio_mark_uptodate(folio);
-- 
2.43.5


