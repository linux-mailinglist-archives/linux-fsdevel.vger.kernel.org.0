Return-Path: <linux-fsdevel+bounces-32604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FCD9AB644
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5372D1C232DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3911CB321;
	Tue, 22 Oct 2024 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzpb6eGr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056A1CCB27
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623295; cv=none; b=myl4qmrQmhT+k+KJJW9MetzlGWCDzi0wm5SiEEj4EQuLP5KGyU7DQHPKBucE9qZn6oXIPUQQ6XnN+b+VA0AYTNd0CkwypKmjF/aMwxnqqQNcw5NuUnNX+GRjiH3vnW4TmCIydTURSnxAzUgdeYYEOvjPJZWjjQqYPhnfUSak2XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623295; c=relaxed/simple;
	bh=+GvzxVcw3NR96WLeKClotYmjGsPHcyFUD/PGVHN4+aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNMGXrNwefqOFMC375oFIPA0JMEPJHAXYQ3ET3wDiXrE0I/qvSwhFVpDsjVRC36LX89U6W2EvT+TiIQH71DPUVlZHtDXiCy7QPl0fUT/f9x0xO8NtmWQNJz4f++PNGvVu0jmJ1umZ2fJz5Nqgu4jST8/sr/4M1By3nOoFUHWgBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzpb6eGr; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e35fb3792eso59921687b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623293; x=1730228093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2okvCM9Mz7H/1j4q0oAIGkWxD4MzsN3YCiMJzP58qw=;
        b=Jzpb6eGrR8GARQjbqCe3OVm76+W5vRu7RlU13rSywRfZPK3JWHui+LN3P6QV9C+ERZ
         Eyc2NilERxD4EcM4QLLvMOY/A7gYRDzyPaxJ3v/JM7QwrCX4Wc8Ui9t+3o2vJ3JdBj2N
         l5uXdVYWB9KM9FZv4lLdcbakty3KXUyxAj/h4DuS7lsYeLZPQ3OTJU//d4+/Bzts5G33
         NmI/SjkEBpILi5TaD8Z2RSSQ6w8W9IPK6WFoussXIe05keZB7w9RXVq7NhFBfPQgg/lY
         NgxSoJLSPZmk4Djy8qNFUR/s8ps8Ti8Z9HSJpL2BOheZK/wU53Ad1Bnx1yY5lrKgQo7J
         7f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623293; x=1730228093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2okvCM9Mz7H/1j4q0oAIGkWxD4MzsN3YCiMJzP58qw=;
        b=C3j6zvsd1jqk38X7pZ/Zi58q9FHaZI7bK4w3ZOgIK9pVe6mRK5nNtJqPtZWuoHMxxi
         F2E4VnSF84CgWUToSl8ZH5YoIVBRDY/5vcSvqqDR7qZLzUwNmDFgPd+cSA3pmz5KrBFp
         DipnjGSLIx0E7jrfotL+iVz4pUdGNqMI6ooca5L8Udzss8R5B6IZqDCD4ZuqBvlNd4BN
         VKK2ujNa1tRLtwaR0HogdMJcBCgYecyjwQRfMQs8zRsMK8QLvGP1Q9fSIXkTWyXu4cqw
         6199U3pHECi4Ja2T5nXzpxeByyE8SAowM79XTEJ76aNjrDhrwDSOBsqe/whveytp+TyA
         /mng==
X-Forwarded-Encrypted: i=1; AJvYcCVXbnNRgya4zDh35II/ERcBYXyKf/KIpe0iEtyvbg02K0vlAX4aq8npKVY5DXhy6QNmSVrVJ2vpe8iHbMFu@vger.kernel.org
X-Gm-Message-State: AOJu0YzprmV1tqYEsE9NLklzrOSVXrHoJJMB9zvUgZqN0iiLNOsYrsqR
	At9ZBFCsqs8RkCktodqfaZGI3O1YJF3YsrXPvFQZ8WD55rCajm1n
X-Google-Smtp-Source: AGHT+IFXoj6baa3pwEncAmMRhxRhXyRQxc6cxP/4y2TRGRBge3Vn+a86u/KZ0URtSSDoDzpC4sKMUg==
X-Received: by 2002:a05:690c:39b:b0:6e2:83d:dfb4 with SMTP id 00721157ae682-6e7d3b845a8mr38595567b3.34.1729623293104;
        Tue, 22 Oct 2024 11:54:53 -0700 (PDT)
Received: from localhost (fwdproxy-nha-001.fbsv.net. [2a03:2880:25ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb641sm11920837b3.83.2024.10.22.11.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:54:52 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v2 06/13] fuse: convert reads to use folios
Date: Tue, 22 Oct 2024 11:54:36 -0700
Message-ID: <20241022185443.1891563-7-joannelkoong@gmail.com>
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

Convert read requests to use folios instead of pages.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c   | 67 ++++++++++++++++++++++++++++++++----------------
 fs/fuse/fuse_i.h | 12 +++++++++
 2 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ce67af163c9a..ece1c0319e35 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -760,12 +760,37 @@ static struct fuse_io_args *fuse_io_alloc(struct fuse_io_priv *io,
 	return ia;
 }
 
+static struct fuse_io_args *fuse_io_folios_alloc(struct fuse_io_priv *io,
+						 unsigned int nfolios)
+{
+	struct fuse_io_args *ia;
+
+	ia = kzalloc(sizeof(*ia), GFP_KERNEL);
+	if (ia) {
+		ia->io = io;
+		ia->ap.uses_folios = true;
+		ia->ap.folios = fuse_folios_alloc(nfolios, GFP_KERNEL,
+						  &ia->ap.folio_descs);
+		if (!ia->ap.folios) {
+			kfree(ia);
+			ia = NULL;
+		}
+	}
+	return ia;
+}
+
 static void fuse_io_free(struct fuse_io_args *ia)
 {
 	kfree(ia->ap.pages);
 	kfree(ia);
 }
 
+static void fuse_io_folios_free(struct fuse_io_args *ia)
+{
+	kfree(ia->ap.folios);
+	kfree(ia);
+}
+
 static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
 				  int err)
 {
@@ -865,7 +890,7 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
 	 * reached the client fs yet.  So the hole is not present there.
 	 */
 	if (!fc->writeback_cache) {
-		loff_t pos = page_offset(ap->pages[0]) + num_read;
+		loff_t pos = folio_pos(ap->folios[0]) + num_read;
 		fuse_read_update_size(inode, pos, attr_ver);
 	}
 }
@@ -875,14 +900,14 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	struct inode *inode = folio->mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	loff_t pos = folio_pos(folio);
-	struct fuse_page_desc desc = { .length = PAGE_SIZE };
-	struct page *page = &folio->page;
+	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
-		.ap.num_pages = 1,
-		.ap.pages = &page,
-		.ap.descs = &desc,
+		.ap.uses_folios = true,
+		.ap.num_folios = 1,
+		.ap.folios = &folio,
+		.ap.folio_descs = &desc,
 	};
 	ssize_t res;
 	u64 attr_ver;
@@ -941,8 +966,8 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	size_t num_read = args->out_args[0].size;
 	struct address_space *mapping = NULL;
 
-	for (i = 0; mapping == NULL && i < ap->num_pages; i++)
-		mapping = ap->pages[i]->mapping;
+	for (i = 0; mapping == NULL && i < ap->num_folios; i++)
+		mapping = ap->folios[i]->mapping;
 
 	if (mapping) {
 		struct inode *inode = mapping->host;
@@ -956,15 +981,12 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		fuse_invalidate_atime(inode);
 	}
 
-	for (i = 0; i < ap->num_pages; i++) {
-		struct folio *folio = page_folio(ap->pages[i]);
-
-		folio_end_read(folio, !err);
-	}
+	for (i = 0; i < ap->num_folios; i++)
+		folio_end_read(ap->folios[i], !err);
 	if (ia->ff)
 		fuse_file_put(ia->ff, false);
 
-	fuse_io_free(ia);
+	fuse_io_folios_free(ia);
 }
 
 static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
@@ -972,8 +994,9 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
 	struct fuse_args_pages *ap = &ia->ap;
-	loff_t pos = page_offset(ap->pages[0]);
-	size_t count = ap->num_pages << PAGE_SHIFT;
+	loff_t pos = folio_pos(ap->folios[0]);
+	/* Currently, all folios in FUSE are one page */
+	size_t count = ap->num_folios << PAGE_SHIFT;
 	ssize_t res;
 	int err;
 
@@ -984,7 +1007,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 	/* Don't overflow end offset */
 	if (pos + (count - 1) == LLONG_MAX) {
 		count--;
-		ap->descs[ap->num_pages - 1].length--;
+		ap->folio_descs[ap->num_folios - 1].length--;
 	}
 	WARN_ON((loff_t) (pos + count) < 0);
 
@@ -1045,16 +1068,16 @@ static void fuse_readahead(struct readahead_control *rac)
 			 */
 			break;
 
-		ia = fuse_io_alloc(NULL, cur_pages);
+		ia = fuse_io_folios_alloc(NULL, cur_pages);
 		if (!ia)
 			return;
 		ap = &ia->ap;
 
-		while (ap->num_pages < cur_pages) {
+		while (ap->num_folios < cur_pages) {
 			folio = readahead_folio(rac);
-			ap->pages[ap->num_pages] = &folio->page;
-			ap->descs[ap->num_pages].length = folio_size(folio);
-			ap->num_pages++;
+			ap->folios[ap->num_folios] = folio;
+			ap->folio_descs[ap->num_folios].length = folio_size(folio);
+			ap->num_folios++;
 		}
 		fuse_send_readpages(ia, rac->file);
 		nr_pages -= cur_pages;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 24a3da8400d1..b6877064c071 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1029,6 +1029,18 @@ static inline struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
 	return pages;
 }
 
+static inline struct folio **fuse_folios_alloc(unsigned int nfolios, gfp_t flags,
+					       struct fuse_folio_desc **desc)
+{
+	struct folio **folios;
+
+	folios = kzalloc(nfolios * (sizeof(struct folio *) +
+				    sizeof(struct fuse_folio_desc)), flags);
+	*desc = (void *) (folios + nfolios);
+
+	return folios;
+}
+
 static inline void fuse_page_descs_length_init(struct fuse_page_desc *descs,
 					       unsigned int index,
 					       unsigned int nr_pages)
-- 
2.43.5


