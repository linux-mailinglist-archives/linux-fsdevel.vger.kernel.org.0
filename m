Return-Path: <linux-fsdevel+bounces-32801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876929AEDC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11A01C23C20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903CC1FC7ED;
	Thu, 24 Oct 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5goB1oT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C831FBF7A
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790493; cv=none; b=E86jEbzMA3GxD9KiWOgVDARkvpPl/qcKUgeMbr6gweX6pEWHx4Q2GSReNapDwG3jRRoyiWpkdypgbb/sRG07yixCilfve72VTfCraZglQLJsvFRFN7hR5qltl1D0EK2u9VEHPc0Kk7lW3WUvj7lLiHmZm4WgEOoXZMHpxUL6txg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790493; c=relaxed/simple;
	bh=C+ZFmBhkWJBEUf+QVYPJlux2aWYUCRl3Cvoa6yedOko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tF40f1GSjMJFK4aJY4jMuZlD0e3ZPps7Lll/fUnZfV7xXUHufbLQJPbN69q6w10VuanTJSrWaOh8yOKiuzmRI98O5LodI08knqnrRHCeDtfyDYaO3YRCYDbTQ47f0Ql/YlegUbd3+/2f0M/6hyaeu6YulfIG3LogcG9fagOMUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5goB1oT; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e290d48d3f7so1281976276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790490; x=1730395290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLh99GkXyq+kP9pQTLVSJdqNoY2DuPZPcJCXbuMVIms=;
        b=F5goB1oTrPwkBOWWdjP1eU0xadWfHS3Y3O/OtDwFZm5JRzAhv1FtRs4X3Ba3vbvyDi
         SAbz0k5ssI73FGZ/OUmOsIlTKAL6DcPHLWZw4tqNS7AZdxIDyndB7Sevkqs5+vG3KW6N
         nBWpNUA92BI0cwFAJiz9Nt14d1AeHKSRfRWKpanS//83MTKIKA2FiuZp1VgqX+gEOIGI
         K+EXrLiJ7yfogS02CZGRdWBv9d/bw/BCkceV0NGF32k0vsnKFN2ZH3Fd/Y6QQpzpFQ+i
         WoGt0KUcXGMizars2GHgar03BuWHR43k8pglEsnV8H6QBkBV7+8wkhzlApwfGU88IEfe
         RF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790490; x=1730395290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLh99GkXyq+kP9pQTLVSJdqNoY2DuPZPcJCXbuMVIms=;
        b=kDU3ad7cZtriItXstK6kj68ZuVg62MccBTjqSeqBeLh4k93jYNWdbQLMVCwXrT+XIH
         T99MI8rnfmOAQXE60AFYlyllE5TnMSJt2JlVP77n2G+YeYdlxgXD/WEMlez9o0ijboSx
         y16lanmUjbEXe5NOSsorU/RhceLgxwUB2abbrIdyox0uqMOS4ixRfM1SolLyCnSLbHek
         N6E7wBb7SA7LQlCsYnFa+wa0+yy8DG+cemP+FdvL+pF7MZupRGKe+CowqL0ZxOpHPAC2
         uODRg5BLvZpiFifXEsU/mLj6vQ8OnauhPlehuNeQJiao41wV5qlbJ7JxLglxq7I9JIti
         kpcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2IsMEyWdO+l+PWmvtI/iWgGjl9rJMJYMKM8nsD2ARJARZEK9fG8p2A8ppIAi+pbGgERlfL+Blc//mizy7@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSlConI6B/ULI3H+XFFgC4NA0P/J16+OXlGFwBaL0sIgmsyQp
	PmWEJXfs2MPbZ7oBTmI5aGwlpN00+UGeebpCLWQa9eOGwwFT4/ca
X-Google-Smtp-Source: AGHT+IG97x0F4qsnZh34R0UhnmjM6sQQRZfbfidA46jeZ0OezPZWwmdfpdj8wWkwxzP7bO/VjZn82g==
X-Received: by 2002:a05:6902:2088:b0:e29:29b0:2b2a with SMTP id 3f1490d57ef6-e2e3a6e4ed4mr7767533276.51.1729790489794;
        Thu, 24 Oct 2024 10:21:29 -0700 (PDT)
Received: from localhost (fwdproxy-nha-014.fbsv.net. [2a03:2880:25ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc9926c0sm2047881276.17.2024.10.24.10.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:21:29 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v3 04/13] fuse: convert readlink to use folios
Date: Thu, 24 Oct 2024 10:18:00 -0700
Message-ID: <20241024171809.3142801-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241024171809.3142801-1-joannelkoong@gmail.com>
References: <20241024171809.3142801-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert readlink requests to use a folio instead of a page.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dir.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 54104dd48af7..a08c532068d0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1585,14 +1585,15 @@ static int fuse_permission(struct mnt_idmap *idmap,
 	return err;
 }
 
-static int fuse_readlink_page(struct inode *inode, struct page *page)
+static int fuse_readlink_page(struct inode *inode, struct folio *folio)
 {
 	struct fuse_mount *fm = get_fuse_mount(inode);
-	struct fuse_page_desc desc = { .length = PAGE_SIZE - 1 };
+	struct fuse_folio_desc desc = { .length = PAGE_SIZE - 1 };
 	struct fuse_args_pages ap = {
-		.num_pages = 1,
-		.pages = &page,
-		.descs = &desc,
+		.uses_folios = true,
+		.num_folios = 1,
+		.folios = &folio,
+		.folio_descs = &desc,
 	};
 	char *link;
 	ssize_t res;
@@ -1614,7 +1615,7 @@ static int fuse_readlink_page(struct inode *inode, struct page *page)
 	if (WARN_ON(res >= PAGE_SIZE))
 		return -EIO;
 
-	link = page_address(page);
+	link = folio_address(folio);
 	link[res] = '\0';
 
 	return 0;
@@ -1624,7 +1625,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 				 struct delayed_call *callback)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct page *page;
+	struct folio *folio;
 	int err;
 
 	err = -EIO;
@@ -1638,20 +1639,20 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 	if (!dentry)
 		goto out_err;
 
-	page = alloc_page(GFP_KERNEL);
+	folio = folio_alloc(GFP_KERNEL, 0);
 	err = -ENOMEM;
-	if (!page)
+	if (!folio)
 		goto out_err;
 
-	err = fuse_readlink_page(inode, page);
+	err = fuse_readlink_page(inode, folio);
 	if (err) {
-		__free_page(page);
+		folio_put(folio);
 		goto out_err;
 	}
 
-	set_delayed_call(callback, page_put_link, page);
+	set_delayed_call(callback, page_put_link, &folio->page);
 
-	return page_address(page);
+	return folio_address(folio);
 
 out_err:
 	return ERR_PTR(err);
@@ -2231,7 +2232,7 @@ void fuse_init_dir(struct inode *inode)
 
 static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
 {
-	int err = fuse_readlink_page(folio->mapping->host, &folio->page);
+	int err = fuse_readlink_page(folio->mapping->host, folio);
 
 	if (!err)
 		folio_mark_uptodate(folio);
-- 
2.43.5


