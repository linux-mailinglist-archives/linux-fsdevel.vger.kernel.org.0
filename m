Return-Path: <linux-fsdevel+bounces-32810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863C69AEDD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3079B2787C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916B01FF7D7;
	Thu, 24 Oct 2024 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbkWVJXX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413041FF02F
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790501; cv=none; b=klcSEFfBZmWI/NdsH2R5pZdijHY3jD3GgaQ3bL95/NwtkSmqpL3N6S8ZZnR/jpxtZ4Rq0BI2HNJOvfzPAEEoXcKj7lL2t3NPvVwNYbuSfxovjReuXMTUJN7ubcMvsKyGQmO4xN5HTomnath06w+OeClFTSVfZKi4+E/uZ+kEZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790501; c=relaxed/simple;
	bh=BFp33PvH1AHByIGlb/u8bJiihLQLKq4b5Fj8IXPxvF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvGQIcPwbDFhiyK89HOJ0GqhKsm+qHoJo/zZXIaNUFDw72nhuAUcGDtq1msZK2yXpnaCOnf49v5gSgLiQFtTDzjD4IvrkaViLUGcZHufuFWbvTJLqUQQhWwX6uNzlB/Jvcno34O9UCyqs/7G0v/rkwG3kP6wvkuDT+sCl7x9eKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbkWVJXX; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e8063533b5so12615377b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790497; x=1730395297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYZwgSPRFPTiqo+NFL+9REXRMrpVMuOSZaJuhzSDcXs=;
        b=PbkWVJXX1VeF9NwVQskKplxtCoxoxfXYk3s2yBnO8BUs+6rYRagtyp7gf8ijBZfKBA
         w24cpABOaaAdIaIHCaIXZf/ZaMQzxqGy4N2yBXzQudILlwNIIm+UrzQ7gMnD56+Vj4WY
         jR1YG3KOgT8bvsU2jPwNmPxin/gstST9RwKB3rGXVbQ8PRUP8yX2ylourSdSwHuhW57W
         J63SHuUvO5GtIb2KOBWRw4P2EdCkDDjyIoYTHk9T5HndR8VRu1sAz6MaShHaLIdIneDY
         aU3Rv6ijRpqR6xPyQSlyrLPBnZ6UzpfTnaO0mg8OYpzRC2PqgmfsOUtsdu+/rJaEb37+
         2kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790497; x=1730395297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYZwgSPRFPTiqo+NFL+9REXRMrpVMuOSZaJuhzSDcXs=;
        b=M49CW4lus5fhL95VV42ti8j/sHADPwH6fjgMD8tZBqIYt19KgamaeMlwmmYqwCLr5g
         rSSa+bx2t7d2vVmtaMuyKlL5pz0ZAYlXA4nElFCQzXzn/5LM/Ay03C/t7P2vNsVB8cBx
         qyCFq/1+7G+RtmxCiA+VUYStzvNTyjplNDjTKdfYnkXSIXAzf4sFYus8a2l0iRD5Y1oZ
         AjhSs8MxFvQGfp9o69XOJH1BPWLFfW3/E4eX73iDRMWQ360MLyreX5POLtSz0qYufU13
         vDOeKRpX44kye+BMl4ITiEMLKq8TFXBT2H+ztDPmwwFfjevylZHnfbue5r18474xzflf
         vDig==
X-Forwarded-Encrypted: i=1; AJvYcCWq3oCjF8d4ib1KZZB5pa81s7LY0e4LEwSppgzdhnAiOGcqyMaa6UUyD1WPcIC+4bDwRnPlN84zRA7T/AUL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05ixCjODs3DANRn6KR+sSKl630lmbbLOpRDtqsxc/11lY0GEP
	JOWKAxJPZVkiX/AdfpuS8PnkXSv5z8JGZn06UUe/CXjmpV7++eXZ
X-Google-Smtp-Source: AGHT+IFIiRP5wFo1QLpmbIQ68brd9+ZRz8TqXEFgQT7DOpA1/wYbP3nLMFEcEL5oW4iXvo6YYmsmAg==
X-Received: by 2002:a05:690c:91:b0:6e3:1fbe:9aa8 with SMTP id 00721157ae682-6e7f0df060cmr72071647b3.15.1729790497112;
        Thu, 24 Oct 2024 10:21:37 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ad5addsm20805207b3.72.2024.10.24.10.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:21:36 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v3 13/13] fuse: remove pages for requests and exclusively use folios
Date: Thu, 24 Oct 2024 10:18:09 -0700
Message-ID: <20241024171809.3142801-14-joannelkoong@gmail.com>
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

All fuse requests use folios instead of pages for transferring data.
Remove pages from the requests and exclusively use folios.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/cuse.c      |  1 -
 fs/fuse/dev.c       | 49 ++++++++---------------
 fs/fuse/dir.c       |  1 -
 fs/fuse/file.c      |  4 --
 fs/fuse/fuse_i.h    | 16 ++------
 fs/fuse/ioctl.c     |  1 -
 fs/fuse/readdir.c   |  1 -
 fs/fuse/virtio_fs.c | 95 +++++++++++++++++----------------------------
 8 files changed, 56 insertions(+), 112 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index eed78e303139..ef9fb30b9bdc 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -460,7 +460,6 @@ static int cuse_send_init(struct cuse_conn *cc)
 	ap->args.out_args[1].size = CUSE_INIT_INFO_MAX;
 	ap->args.out_argvar = true;
 	ap->args.out_pages = true;
-	ap->uses_folios = true;
 	ap->num_folios = 1;
 	ap->folios = &ia->folio;
 	ap->folio_descs = &ia->desc;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9467b05d3d4a..ee698e3ea32f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1028,41 +1028,27 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
 	struct fuse_req *req = cs->req;
 	struct fuse_args_pages *ap = container_of(req->args, typeof(*ap), args);
 
-	if (ap->uses_folios) {
-		for (i = 0; i < ap->num_folios && (nbytes || zeroing); i++) {
-			int err;
-			unsigned int offset = ap->folio_descs[i].offset;
-			unsigned int count = min(nbytes, ap->folio_descs[i].length);
-			struct page *orig, *pagep;
+	for (i = 0; i < ap->num_folios && (nbytes || zeroing); i++) {
+		int err;
+		unsigned int offset = ap->folio_descs[i].offset;
+		unsigned int count = min(nbytes, ap->folio_descs[i].length);
+		struct page *orig, *pagep;
 
-			orig = pagep = &ap->folios[i]->page;
+		orig = pagep = &ap->folios[i]->page;
 
-			err = fuse_copy_page(cs, &pagep, offset, count, zeroing);
-			if (err)
-				return err;
-
-			nbytes -= count;
-
-			/*
-			 *  fuse_copy_page may have moved a page from a pipe
-			 *  instead of copying into our given page, so update
-			 *  the folios if it was replaced.
-			 */
-			if (pagep != orig)
-				ap->folios[i] = page_folio(pagep);
-		}
-	} else {
-		for (i = 0; i < ap->num_pages && (nbytes || zeroing); i++) {
-			int err;
-			unsigned int offset = ap->descs[i].offset;
-			unsigned int count = min(nbytes, ap->descs[i].length);
+		err = fuse_copy_page(cs, &pagep, offset, count, zeroing);
+		if (err)
+			return err;
 
-			err = fuse_copy_page(cs, &ap->pages[i], offset, count, zeroing);
-			if (err)
-				return err;
+		nbytes -= count;
 
-			nbytes -= count;
-		}
+		/*
+		 *  fuse_copy_page may have moved a page from a pipe instead of
+		 *  copying into our given page, so update the folios if it was
+		 *  replaced.
+		 */
+		if (pagep != orig)
+			ap->folios[i] = page_folio(pagep);
 	}
 	return 0;
 }
@@ -1770,7 +1756,6 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	ap = &ra->ap;
 	ap->folios = (void *) (ra + 1);
 	ap->folio_descs = (void *) (ap->folios + num_pages);
-	ap->uses_folios = true;
 
 	args = &ap->args;
 	args->nodeid = outarg->nodeid;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a08c532068d0..2661f0cab349 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1590,7 +1590,6 @@ static int fuse_readlink_page(struct inode *inode, struct folio *folio)
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_folio_desc desc = { .length = PAGE_SIZE - 1 };
 	struct fuse_args_pages ap = {
-		.uses_folios = true,
 		.num_folios = 1,
 		.folios = &folio,
 		.folio_descs = &desc,
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 14af8c41fc83..070db159ba7b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -750,7 +750,6 @@ static struct fuse_io_args *fuse_io_folios_alloc(struct fuse_io_priv *io,
 	ia = kzalloc(sizeof(*ia), GFP_KERNEL);
 	if (ia) {
 		ia->io = io;
-		ia->ap.uses_folios = true;
 		ia->ap.folios = fuse_folios_alloc(nfolios, GFP_KERNEL,
 						  &ia->ap.folio_descs);
 		if (!ia->ap.folios) {
@@ -880,7 +879,6 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
-		.ap.uses_folios = true,
 		.ap.num_folios = 1,
 		.ap.folios = &folio,
 		.ap.folio_descs = &desc,
@@ -1318,7 +1316,6 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 		unsigned int nr_pages = fuse_wr_pages(pos, iov_iter_count(ii),
 						      fc->max_pages);
 
-		ap->uses_folios = true;
 		ap->folios = fuse_folios_alloc(nr_pages, GFP_KERNEL, &ap->folio_descs);
 		if (!ap->folios) {
 			err = -ENOMEM;
@@ -2093,7 +2090,6 @@ static struct fuse_writepage_args *fuse_writepage_args_alloc(void)
 	if (wpa) {
 		ap = &wpa->ia.ap;
 		ap->num_folios = 0;
-		ap->uses_folios = true;
 		ap->folios = fuse_folios_alloc(1, GFP_NOFS, &ap->folio_descs);
 		if (!ap->folios) {
 			kfree(wpa);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d26d278da886..55d371016c97 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -325,19 +325,9 @@ struct fuse_args {
 
 struct fuse_args_pages {
 	struct fuse_args args;
-	union {
-		struct {
-			struct page **pages;
-			struct fuse_page_desc *descs;
-			unsigned int num_pages;
-		};
-		struct {
-			struct folio **folios;
-			struct fuse_folio_desc *folio_descs;
-			unsigned int num_folios;
-		};
-	};
-	bool uses_folios;
+	struct folio **folios;
+	unsigned int num_folios;
+	struct fuse_folio_desc *folio_descs;
 };
 
 struct fuse_release_args {
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 1c77d8a27950..28138c838d49 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -306,7 +306,6 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 	err = -ENOMEM;
 	if (max_pages > fm->fc->max_pages)
 		goto out;
-	ap.uses_folios = true;
 	while (ap.num_folios < max_pages) {
 		ap.folios[ap.num_folios] = folio_alloc(GFP_KERNEL | __GFP_HIGHMEM, 0);
 		if (!ap.folios[ap.num_folios])
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index fd0eff1b9f2d..aeb5ea534c96 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -346,7 +346,6 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 
 	plus = fuse_use_readdirplus(inode, ctx);
 	ap->args.out_pages = true;
-	ap->uses_folios = true;
 	ap->num_folios = 1;
 	ap->folios = &folio;
 	ap->folio_descs = &desc;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 9f0d98cc20d3..b8d31a93f2d6 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -765,7 +765,6 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	struct fuse_args *args;
 	struct fuse_args_pages *ap;
 	unsigned int len, i, thislen;
-	struct page *page;
 	struct folio *folio;
 
 	/*
@@ -778,29 +777,15 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	if (args->out_pages && args->page_zeroing) {
 		len = args->out_args[args->out_numargs - 1].size;
 		ap = container_of(args, typeof(*ap), args);
-		if (ap->uses_folios) {
-			for (i = 0; i < ap->num_folios; i++) {
-				thislen = ap->folio_descs[i].length;
-				if (len < thislen) {
-					WARN_ON(ap->folio_descs[i].offset);
-					folio = ap->folios[i];
-					folio_zero_segment(folio, len, thislen);
-					len = 0;
-				} else {
-					len -= thislen;
-				}
-			}
-		} else {
-			for (i = 0; i < ap->num_pages; i++) {
-				thislen = ap->descs[i].length;
-				if (len < thislen) {
-					WARN_ON(ap->descs[i].offset);
-					page = ap->pages[i];
-					zero_user_segment(page, len, thislen);
-					len = 0;
-				} else {
-					len -= thislen;
-				}
+		for (i = 0; i < ap->num_folios; i++) {
+			thislen = ap->folio_descs[i].length;
+			if (len < thislen) {
+				WARN_ON(ap->folio_descs[i].offset);
+				folio = ap->folios[i];
+				folio_zero_segment(folio, len, thislen);
+				len = 0;
+			} else {
+				len -= thislen;
 			}
 		}
 	}
@@ -1287,22 +1272,16 @@ static void virtio_fs_send_interrupt(struct fuse_iqueue *fiq, struct fuse_req *r
 }
 
 /* Count number of scatter-gather elements required */
-static unsigned int sg_count_fuse_pages(struct fuse_args_pages *ap,
-					unsigned int total_len)
+static unsigned int sg_count_fuse_folios(struct fuse_folio_desc *folio_descs,
+					 unsigned int num_folios,
+					 unsigned int total_len)
 {
 	unsigned int i;
 	unsigned int this_len;
 
-	if (ap->uses_folios) {
-		for (i = 0; i < ap->num_folios && total_len; i++) {
-			this_len =  min(ap->folio_descs[i].length, total_len);
-			total_len -= this_len;
-		}
-	} else {
-		for (i = 0; i < ap->num_pages && total_len; i++) {
-			this_len =  min(ap->descs[i].length, total_len);
-			total_len -= this_len;
-		}
+	for (i = 0; i < num_folios && total_len; i++) {
+		this_len =  min(folio_descs[i].length, total_len);
+		total_len -= this_len;
 	}
 
 	return i;
@@ -1320,7 +1299,8 @@ static unsigned int sg_count_fuse_req(struct fuse_req *req)
 
 	if (args->in_pages) {
 		size = args->in_args[args->in_numargs - 1].size;
-		total_sgs += sg_count_fuse_pages(ap, size);
+		total_sgs += sg_count_fuse_folios(ap->folio_descs, ap->num_folios,
+						  size);
 	}
 
 	if (!test_bit(FR_ISREPLY, &req->flags))
@@ -1333,35 +1313,29 @@ static unsigned int sg_count_fuse_req(struct fuse_req *req)
 
 	if (args->out_pages) {
 		size = args->out_args[args->out_numargs - 1].size;
-		total_sgs += sg_count_fuse_pages(ap, size);
+		total_sgs += sg_count_fuse_folios(ap->folio_descs, ap->num_folios,
+						  size);
 	}
 
 	return total_sgs;
 }
 
-/* Add pages/folios to scatter-gather list and return number of elements used */
-static unsigned int sg_init_fuse_pages(struct scatterlist *sg,
-				       struct fuse_args_pages *ap,
-				       unsigned int total_len)
+/* Add folios to scatter-gather list and return number of elements used */
+static unsigned int sg_init_fuse_folios(struct scatterlist *sg,
+					struct folio **folios,
+					struct fuse_folio_desc *folio_descs,
+					unsigned int num_folios,
+				        unsigned int total_len)
 {
 	unsigned int i;
 	unsigned int this_len;
 
-	if (ap->uses_folios) {
-		for (i = 0; i < ap->num_folios && total_len; i++) {
-			sg_init_table(&sg[i], 1);
-			this_len =  min(ap->folio_descs[i].length, total_len);
-			sg_set_folio(&sg[i], ap->folios[i], this_len,
-				     ap->folio_descs[i].offset);
-			total_len -= this_len;
-		}
-	} else {
-		for (i = 0; i < ap->num_pages && total_len; i++) {
-			sg_init_table(&sg[i], 1);
-			this_len =  min(ap->descs[i].length, total_len);
-			sg_set_page(&sg[i], ap->pages[i], this_len, ap->descs[i].offset);
-			total_len -= this_len;
-		}
+	for (i = 0; i < num_folios && total_len; i++) {
+		sg_init_table(&sg[i], 1);
+		this_len =  min(folio_descs[i].length, total_len);
+		sg_set_folio(&sg[i], folios[i], this_len,
+			     folio_descs[i].offset);
+		total_len -= this_len;
 	}
 
 	return i;
@@ -1385,8 +1359,11 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 		sg_init_one(&sg[total_sgs++], argbuf, len);
 
 	if (argpages)
-		total_sgs += sg_init_fuse_pages(&sg[total_sgs], ap,
-						args[numargs - 1].size);
+		total_sgs += sg_init_fuse_folios(&sg[total_sgs],
+						 ap->folios,
+						 ap->folio_descs,
+						 ap->num_folios,
+						 args[numargs - 1].size);
 
 	if (len_used)
 		*len_used = len;
-- 
2.43.5


