Return-Path: <linux-fsdevel+bounces-30742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80698E13A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E1AB2252F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB2D1D14F4;
	Wed,  2 Oct 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/80MXj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB51D131E
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888121; cv=none; b=DyHpyO8cw8mIXYuU2gYdNsDPfzCjrNs93/UNo965F05m7bRDqRIyL4nzpKXq6i/je4Rk868+5E7DlsRtVk9vD4PMbOHyoGEZM5xzfr/W80MGpvj10pLQy2kUGvygncK9s4fMHjYs6f/lFh1cIvXQYorGIhFitmkJg0UTrDBLpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888121; c=relaxed/simple;
	bh=0trQRNfSkzGb0zygXt4NuVBZf90HVgPVS7hOaof4cwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbYwaJE+eRMI/u0YInbTETSVe023V5fDdpOayDoVzxZdAhxnliLDBgLN1fS8T1LSgNXufEQUPdaicBx0pGQZUQXOPEWmj+AjWhBHPnXNIWrhERKwOHbklmlCq88h9FPsUBy4LauaiqY4kGDK3Y5Y7Qs212drIAATBczGANskRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/80MXj4; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e23aa29408so10618917b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888119; x=1728492919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94DvA0n4goqk55piTLGckL+WHzzHeBS31St4r7i/fts=;
        b=h/80MXj4ItSPH0gXq1AQ4fFt8YECBLhYezdwDEE/X/pJIfRpTw5fNo3shhPpDAGY1d
         NLdStg3yOo/54KVcjMCxuGlXmJQOB5ZY6cmESt2S8uppmMv8MEJ1XjfIke6nPRPMsWVU
         PvJ4zY+t7QYBfLIKWZeNJUzv1U/pBamV3ZocCHzv1Ck1y7HZ7j5xrHt5+sFzNDPJJWyW
         JLNO3x0imFw/8umY5/QHlU6aRk3blSnTbJcYVfZrpktqOiWxGK+03OslxV1qITrNaTpv
         mIk/GUi4bMFBb6GdGCVlK1G4Brg4O+hoKiUO+v7zmHPNJeNwt170DNbmX6wSXUKcUf6z
         yM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888119; x=1728492919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94DvA0n4goqk55piTLGckL+WHzzHeBS31St4r7i/fts=;
        b=NbDKN9AuBvL9ZmXa7Cl4mqrNTcHJ/qO1+eqDg4J1rsckwki1VsBQTrFq26NMTPUZ4y
         q4Rfv7dZu4u5yQpvkgydyvBZI95Wns+CC1VgocB7C73s7Wak50YK0pAOPQCTIBwGPU4z
         jAoknXaqCkAqHsjQBR1uC4h+2AtH6u9J3a0qRku9w7MFjDFmIQ1r5Cr1b1AcdfyM0gxZ
         rWAwKvZAc5ThqAzpKpmsJSOduTHmubVAntmIHz1tAeBSM1aUIGRBX+nxx0nuxXhxOgJv
         BJNTX4jxu19kfabNVzZdI1jspBTKLsUdBNBgEMSg1/jwTHz9glp8mPDZY8BiNeIP16fA
         tJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw5hfdpaNl3pk8CMYIvL6v3TqKmQT0zyqramPeOwaSaa5rj9C6ELG2OkY29BFExO/pquWA3bY2nFZLA55B@vger.kernel.org
X-Gm-Message-State: AOJu0Yz290q+WjA923AFyKoGowMCGMlGLJtaaFsbsLIa7aVrSnINnbbB
	X4wlPctynrASS49Hji9XwxiRVMD92QGCifM5Z0A5/V6BWWwk/wQn
X-Google-Smtp-Source: AGHT+IEPgFJq7maG+YYcBxjWOhkkD+GTsDzUEGy9j/dvjHAtDZb49Jbghy+TzJloGtU7P0/r7Jcr5Q==
X-Received: by 2002:a05:690c:63c2:b0:6db:d02f:b2c4 with SMTP id 00721157ae682-6e2b534c570mr3027307b3.7.1727888118670;
        Wed, 02 Oct 2024 09:55:18 -0700 (PDT)
Received: from localhost (fwdproxy-nha-002.fbsv.net. [2a03:2880:25ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24538880esm25636717b3.119.2024.10.02.09.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:55:18 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH 04/13] fuse: convert readlink to use folios
Date: Wed,  2 Oct 2024 09:52:44 -0700
Message-ID: <20241002165253.3872513-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002165253.3872513-1-joannelkoong@gmail.com>
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
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


