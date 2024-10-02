Return-Path: <linux-fsdevel+bounces-30751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF3198E140
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EDB1C2362A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC51D150B;
	Wed,  2 Oct 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3fR2Mv+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF71D1730
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888134; cv=none; b=s9/KaFKXdCvWYQo4R+I5IwC6TOXWoBOhBYHMdJClhC9oJ4AFn9GmAotrJyE9eIv8UM/s77wR/rSYQht2F5rjVP46bsfGRMGujTkBN7E7u4XLpU5qk0g9NHf4XC1BW/n1nvLZ+tmw7ZUwCN/OB1R4CtkobjDVzzDv+BHMeiWuOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888134; c=relaxed/simple;
	bh=yR0hW+KLcHj9ItOah3WSaKvMNerGJnqsZiYR4YSNNsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbXtItagD0qKAW3xiP+eDUrMcrlicv+DxdEUO15OIoQ4i2DTeUSgzOOmlmn7Za8mfHieu1gQs1npEy7MnT/JWwZjSR9MB9eHZ/73AqbVYqXA6KHkMFowy6StqT6jRg9K+Kfd44s/pxVmdZzngigRg2gY60e9/Yj9LVXGCiDlCrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3fR2Mv+; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e026a2238d8so13671276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888129; x=1728492929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WThkpNSzkhzcwAbyMZ7NvGW3nEKriK7cOfyXAk/GufQ=;
        b=X3fR2Mv+C7MO5iT3++zXbEFHnjsmbC3mhsZqMmpMff8HbnNUKBAK2uVWhaEr1NnWAi
         FfIMKCNQa8dCEiJFe6l6yeJN6A6bvAokf7geccwohModZz5cPNV5aFPBtOKIxbAOgxMm
         jpd+EvMhU6kHaJmW4dLxuhgh95YewKDe2l0xcZkHWsPc7gOCm+Y0TbOgh6bDdbN6K+pL
         +Tx5tMKtT/PLJd/MPl8K8dIs4idgGPx9RqWs1d24sEbeCgCpJoG8qZmQsJ5AkpS9gM24
         VqHd6lS+6WQFZ32mlqAK/3hdjgNbt4eIQckoy/dJD7R+AuC08DsN+INREEEO19eTbjze
         Dh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888129; x=1728492929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WThkpNSzkhzcwAbyMZ7NvGW3nEKriK7cOfyXAk/GufQ=;
        b=O2NQ2Gn/K3aGTrV5bJfr232AqAM3xDg5PUeh8QBfSdumuNNP6LJtW9LGoGcUyoRYSy
         J+x+OnIP+FvsD0OrQ3NEiLRRhidDdAIGMvYMoXbAWC7qgkyDk5AmQyXdbd9m+RCPGL/3
         Khhs9zqSw1ZYGK4WtpOZBK4YRxsYdb0WiYa66tx0TUHjOfeVOBsE3tPyrD/Yb9ifhdoV
         7fQzwFo4ePNC3GfZwOqcj+t2CZasAc/hd49q/BXL7LcTRm+ozXNFCyx2a85dodXfMDsk
         PBgxex/nLheuJPJLp6XzJj65v38tf0sEZ/UDtNwHNJGBiJkKkQgczLN4Rk6WhRSmreCh
         FNkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE2Gv1wLh6DXgUsWD27HDGvQoE/qJXJMHeVZcLQuCLywbSJi6eJ6k4Hze10IRnwNwwQQbNU0cMmzPc3n8a@vger.kernel.org
X-Gm-Message-State: AOJu0YwGrPMW0JpwZZ04WRq0zalvVVXkL2Edfg6ceH9drIj7YtXSfWYI
	OHGr+lWKhD7Ay7ERIJKJ3T2er+tQmUVcWo9pudNgIwwHKnwCgy9P
X-Google-Smtp-Source: AGHT+IFWrIFV/zfiWpVVZxOJrTVYtO+U7NT7D1G5B5s06UfWh3ApVBUAgVb14gsPDHCS1qu6eeIkTw==
X-Received: by 2002:a05:6902:1546:b0:e20:2bd7:14f1 with SMTP id 3f1490d57ef6-e2638439fcamr2948938276.56.1727888129465;
        Wed, 02 Oct 2024 09:55:29 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e6c3067asm3864708276.53.2024.10.02.09.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:55:29 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH 13/13] fuse: remove pages for requests and exclusively use folios
Date: Wed,  2 Oct 2024 09:52:53 -0700
Message-ID: <20241002165253.3872513-14-joannelkoong@gmail.com>
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

All fuse requests use folios instead of pages for transferring data.
Remove pages from the requests and exclusively use folios.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/cuse.c      |  1 -
 fs/fuse/dev.c       | 41 +++++++-------------
 fs/fuse/dir.c       |  1 -
 fs/fuse/file.c      |  4 --
 fs/fuse/fuse_i.h    | 16 ++------
 fs/fuse/ioctl.c     |  1 -
 fs/fuse/readdir.c   |  1 -
 fs/fuse/virtio_fs.c | 94 +++++++++++++++++----------------------------
 8 files changed, 52 insertions(+), 107 deletions(-)

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
index 2f59af6a8c22..00390a0cd010 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1028,37 +1028,23 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
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
-			/* Check if the folio was replaced in the page cache */
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
+		/* Check if the folio was replaced in the page cache */
+		if (pagep != orig)
+			ap->folios[i] = page_folio(pagep);
 	}
 	return 0;
 }
@@ -1769,7 +1755,6 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	ap = &ra->ap;
 	ap->folios = (void *) (ra + 1);
 	ap->folio_descs = (void *) (ap->folios + num_folios);
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
index 38ed9026f286..2bc860bd3ca3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -747,7 +747,6 @@ static struct fuse_io_args *fuse_io_folios_alloc(struct fuse_io_priv *io,
 	ia = kzalloc(sizeof(*ia), GFP_KERNEL);
 	if (ia) {
 		ia->io = io;
-		ia->ap.uses_folios = true;
 		ia->ap.folios = fuse_folios_alloc(nfolios, GFP_KERNEL,
 						  &ia->ap.folio_descs);
 		if (!ia->ap.folios) {
@@ -873,7 +872,6 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
-		.ap.uses_folios = true,
 		.ap.num_folios = 1,
 		.ap.folios = &folio,
 		.ap.folio_descs = &desc,
@@ -1309,7 +1307,6 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 		unsigned int nr_folios = fuse_wr_folios(pos, iov_iter_count(ii),
 							fc->max_pages);
 
-		ap->uses_folios = true;
 		ap->folios = fuse_folios_alloc(nr_folios, GFP_KERNEL, &ap->folio_descs);
 		if (!ap->folios) {
 			err = -ENOMEM;
@@ -2063,7 +2060,6 @@ static struct fuse_writepage_args *fuse_writepage_args_alloc(void)
 	if (wpa) {
 		ap = &wpa->ia.ap;
 		ap->num_folios = 0;
-		ap->uses_folios = true;
 		ap->folios = fuse_folios_alloc(1, GFP_NOFS, &ap->folio_descs);
 		if (!ap->folios) {
 			kfree(wpa);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d9fa12aee07d..60c76f8afb9e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -322,19 +322,9 @@ struct fuse_args {
 
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
index 5e7262c93590..9c09ee22caaa 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -773,29 +773,15 @@ static void virtio_fs_request_complete(struct fuse_req *req,
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
@@ -1282,22 +1268,16 @@ static void virtio_fs_send_interrupt(struct fuse_iqueue *fiq, struct fuse_req *r
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
@@ -1315,7 +1295,8 @@ static unsigned int sg_count_fuse_req(struct fuse_req *req)
 
 	if (args->in_pages) {
 		size = args->in_args[args->in_numargs - 1].size;
-		total_sgs += sg_count_fuse_pages(ap, size);
+		total_sgs += sg_count_fuse_folios(ap->folio_descs, ap->num_folios,
+						  size);
 	}
 
 	if (!test_bit(FR_ISREPLY, &req->flags))
@@ -1328,35 +1309,29 @@ static unsigned int sg_count_fuse_req(struct fuse_req *req)
 
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
@@ -1380,8 +1355,11 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
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


