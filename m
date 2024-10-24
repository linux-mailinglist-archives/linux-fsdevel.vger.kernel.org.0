Return-Path: <linux-fsdevel+bounces-32803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 194EB9AEDC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 028E1B273F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F901FAF05;
	Thu, 24 Oct 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Def8GqJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859171FC7D6
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790494; cv=none; b=FeEG08NMoc998JwflKeS4xfTJoU/+SPiyHzkBcpfC1jW4uONC2O/mcYTce4lwifWoy4hiqqBAb/YuNLykJFHq0rkaNaicITXKsd9jbODTQc6kP4YWb95iW8A5/ojG6KVHLdwXsZ0Oezh8DneJIYrnHVS7Z5lrRVcYlWeSaQHNrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790494; c=relaxed/simple;
	bh=+GvzxVcw3NR96WLeKClotYmjGsPHcyFUD/PGVHN4+aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aji8D1YKWjX1paq8CM6IYobhghFKQ2r/GlSQIyaNp5pYKSC+k9RjqlT8HUxjqsbgbV7E8wMtb94PaDbPIQGrtY7dtNDm1+MPV/ntWHPq9O6PGtKlpXHiT/0LqgrQDmWrF0RLJPaOaS27Q0ssjmfTDCUf7UVKfKwCa8GTUzatOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Def8GqJ2; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e2bdbdee559so1340393276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790491; x=1730395291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2okvCM9Mz7H/1j4q0oAIGkWxD4MzsN3YCiMJzP58qw=;
        b=Def8GqJ2w5LH8MTB4hwC9O6sEll9fKN4H5oWVMVeyiC7XH3MIEFVJ40BFsp0w2gRUU
         kuquXrXup5D8au+naGJgjN65GE6ryhBJsaMMS1f54Pjoysxm+K33JIknBLKQozjossU7
         We22kfh6IryQpXJcZrjhjz4aiTSXh7UKOfJgG8ezHFiQvp98hOAhKHFy9YkJ6HwagkqU
         L0QLWUkr328W3c+j+QcR+ncIWXSZiwcpf7EU0AT1zkoOIewnX2yRy6KeAma08tYfpU3g
         tX44UY0Ufu6zB2IDTVOG9hh5buXTQmPzlJS4UefInUhRHVSB74TybEUqZImtv87DcuoL
         rcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790491; x=1730395291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2okvCM9Mz7H/1j4q0oAIGkWxD4MzsN3YCiMJzP58qw=;
        b=iFfevT+3juflO291VbRoa8P/NovCde+Hb1vWWzkh69R43ovbsL4omxKvoXHIbf6JXt
         Vt3h9uvIfjwUsJ3Hf7b2pCoG2H7XrcZ33Bf18iaVYcytLYXZMzOAzXUzVMLwTHPe44Nm
         KtbJmufOP8OgPAPYKmIP8euSMwPFzwy6B+A6ma4qfmuV0NqEB8NmVz0v86dkrPK6IPIq
         oq6kzuJw9BemvpM4v/kVzX2FJ6coLI8gepEtYI3C45i8v+vFg7NBAk+EiLNYFfEC6DLO
         +bOvt6dMIVB66Fg0WdxacWRUEkP1UXH32SWJNY9jDyUU2LUNhzMhoGLCedaq7Wxrn2NV
         RojA==
X-Forwarded-Encrypted: i=1; AJvYcCVHnyqmKDNlhi7C3Eunl6TV8mP0DX+b/McE9wGI9b34uzQcVRnD52QqMVR1JiwT67dSY0899xfTLx2kBY40@vger.kernel.org
X-Gm-Message-State: AOJu0YxgspTt6iwt9zJUQlxxNDuU8FhzKqYWxuZp+ugxWX85X+EdY2QZ
	uJiq+GyHWzCWLTfb4e8HmdlarMRCfEN9K+iyGfUqdxcAm5wQVPMy
X-Google-Smtp-Source: AGHT+IEVau3YClcmLxtR+9Up4nGFKYOoIn5mLYZgzfM4Dvp/TXbf4QxD3hlcf+8l5Z2JFU8dc0DpCA==
X-Received: by 2002:a05:6902:a83:b0:e29:27c4:3c6b with SMTP id 3f1490d57ef6-e2e3a66599fmr6768078276.30.1729790491321;
        Thu, 24 Oct 2024 10:21:31 -0700 (PDT)
Received: from localhost (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc96ab29sm1952582276.10.2024.10.24.10.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:21:30 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v3 06/13] fuse: convert reads to use folios
Date: Thu, 24 Oct 2024 10:18:02 -0700
Message-ID: <20241024171809.3142801-7-joannelkoong@gmail.com>
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


