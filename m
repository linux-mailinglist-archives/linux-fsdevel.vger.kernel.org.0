Return-Path: <linux-fsdevel+bounces-32602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B919AB640
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806F2B247A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED4A1CB312;
	Tue, 22 Oct 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAVRwRJT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584E1CB314
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623294; cv=none; b=gzIOiUCxhfGLANo0qQWXkt/T6NEAr8RHqoO+LMFoWAucXjVH1NqItBC5GWbixFYxl0ivzhBgsYWzvG59Bh8XOgXipd3obLKrhECbCa+jrw/Me/Zk/I9YXvbag3tm3UtaaH46lx2AZEeA4xVNrDvtBit7fbjuVvWVdI1ad8lK4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623294; c=relaxed/simple;
	bh=C+ZFmBhkWJBEUf+QVYPJlux2aWYUCRl3Cvoa6yedOko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i83BPxWuBDRz5JF+UI6Eq9yD0iwD6Qgq0HnSQVNBqqi5pctI5jUrz64S8EEzIZngpAh3ckA3jJ7XpuTXzi9Y4WUX9sEhhOkXiA8pAFz4R6tRKgghwq7amZnnXwoakueQfU5lzf+8TWevjGH1+sMZYSSUrgrIs5Lw+1p5Lp5/gUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAVRwRJT; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso5598178276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623292; x=1730228092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLh99GkXyq+kP9pQTLVSJdqNoY2DuPZPcJCXbuMVIms=;
        b=PAVRwRJTKA1wT2hXBbNDAsI6rkzLbAIY4zGRkzmD5ZyDqk7oIDE7cOhixZ7sDIpSDF
         Nkd0E1JGNlxgnieg2MQzeK3PQNheBGetSmpcvMVtcb/iSoNgA3HzJLmviN9B26CpvBM2
         EMEgQD1V2dabr+h8i0BHuo1UQtIYRtJiGnlu7ecuZsRKO4DZHy5cDePBWw2EEYYUeOpK
         llDIzlV37/qGAE5pWuAMutWomVoTWprxXrptqkNLGx3wMXqONiHl6/RTwilVMuL+6QDt
         qpVPt0KPkQnXZ9TOlbGGiFxFcCDLpGMjYxz6iizbv96uziITr16XoqfqQ99qd14/V1oU
         sCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623292; x=1730228092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLh99GkXyq+kP9pQTLVSJdqNoY2DuPZPcJCXbuMVIms=;
        b=kDfULeMeMP9HexMr/62TpC0Y+SKKai4DGlR6a4Epgzcxy7R4V90cr7cCDSPndSEZQh
         7FUSlc7e9kvimsrqVkOAgYncsgHpC3X0tKpKU8Ob/tzznJ8MM7+CccnUq6ZY1WP7nqK2
         kISDvXrl63Yl6eN1m9skp4X2ST4ZJg6MHmXmGrP4MrHVF0rPOnM9FjXQWqn/o1qHhrsV
         R4BLN45O28iz3zPGPCPou2aDD4fSTAPoHg9JP0L8EZStMrFC6CiexSLvObgKP38RaF4h
         2vEl1I8cF6NWNcPmqGoE9X3pzQvC8UB++8iRRZvldajZTtkBB84Tr35i2tPcI+Zs9cPS
         DGPA==
X-Forwarded-Encrypted: i=1; AJvYcCVlm4xlq8c7L6RMSwA0egYlqpRBxzEZnvjStTarH+DTjIu2Xtem7+nS02U3ZEmQUf86zJnfWXpJRqRo2/xn@vger.kernel.org
X-Gm-Message-State: AOJu0YwjpJqqXA66novF5585FMhMRYQ2TyTc5ZwBSVMfXLpkLu6zwAQk
	NR2po3F9ATY2Pbi7yECgktcG3wl07RxfCquv3RwrC4HubxmhU8wA
X-Google-Smtp-Source: AGHT+IG+7gSMFOK9CQ/jO3/Pibyz7Yob/FT/njYkIS/TedfRR9WjtlE7VkNGzyQkp3i7pHosha41gw==
X-Received: by 2002:a05:6902:154b:b0:e28:fc3f:b818 with SMTP id 3f1490d57ef6-e2bb12efd0amr14833443276.18.1729623291726;
        Tue, 22 Oct 2024 11:54:51 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc9b61b4sm1154345276.37.2024.10.22.11.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:54:51 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v2 04/13] fuse: convert readlink to use folios
Date: Tue, 22 Oct 2024 11:54:34 -0700
Message-ID: <20241022185443.1891563-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022185443.1891563-1-joannelkoong@gmail.com>
References: <20241022185443.1891563-1-joannelkoong@gmail.com>
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


