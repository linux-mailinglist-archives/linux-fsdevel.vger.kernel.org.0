Return-Path: <linux-fsdevel+bounces-32809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E445C9AEDD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EE2B278D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9074D1FF7AE;
	Thu, 24 Oct 2024 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkzywBSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927D1FEFC2
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790500; cv=none; b=odUN2WxSvn32Cf9+aj/AsMofw+3e6CMjCeIEVovTEbJhoT5DD9WbQ3g5aOYRZkj825OmzA68LV7Dg5sqG15/rE9VfFQdNsMEta6XuJTculg93OezJjYGnSD+RHqSEsJhMdpyZmiBOzV0Y9l9OsaIxuH6kQ1X2F3H4IqaQPZyXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790500; c=relaxed/simple;
	bh=1fx4xorTc0SaJnZqDSSJwFVUP5boIwS3BOMlFmZESII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJhHWcmlYgTeqiqlSv4e3WBWjdKH04qXlIELqxHTxqq1bOKYzjNde6IILc/lSGbt66F90yrnNwfT8tCMXZ64tGiF1g3bjJRfqjlvkqT8cBsQatLQJ7mrTtyCS9FmTCK71T1wgNLhQY/ceMglbVf4VQG1sgmho0Rk8lstLeu8C2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkzywBSY; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so1391426276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790496; x=1730395296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7DCoZ4SSyBWorpQRh2bKORgPIpYfwI01uLP4jAa5/k=;
        b=VkzywBSY1mcdOcocEmXvSXFOjgMtD9cLLrcHqko8S93hbcKQoKYcS1/rZm86uXxWcM
         n9b1hGAZ7w/XnOXQTxM0T7+FT3kmq0w5O6RYh0wyMXGuuSB97vIoyT4u/z+Tt3B8f2L8
         cd4tqC8geaU1C8fOB0iUlkPt6Q0W6CyZmpREYx8x5n8ZrF9wNjmCgR8EpHVzUpm47LrK
         2d6dV/xQLjUXgXcRTCRFZf6Fop3q4dVtOeBsq3GZ8y98ZkgUxBe+ZOQ4PEJDUdRu+OsV
         E69OoYMY/7nxL3iG6cy9iu4+dcNk2lH0kAERGlN29UMlwAktd3RhYymJERr/REycMx66
         rfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790496; x=1730395296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7DCoZ4SSyBWorpQRh2bKORgPIpYfwI01uLP4jAa5/k=;
        b=oaqwqoJb7YjbswjpR1OK+mJegt32EghuTMjktnD5qdNmahCPCV6q/2GpMNCcc8wj+h
         NC/Lbhtj3B47PUb0cSEJCpprMEUWcr+6nIFb/2biJi8TqplqrIozrYCdCVyiCKF2HxWL
         vK0H2p6OYx9Hr5iUXLoHNysw4G84C2n4fIwfGl1BGlsASJz+AEZWQM6e3xCK5CdolmBi
         A3LoAYZkOVUTTvq8JpU6GSztJue9ezZOsHEkU7zFMkNOBaidVBpOxL0Y4GYLHE4RotlW
         IAFRy3eHoE7gkjOmxs/++nqIcvQBIt54AEBqMxKkLXKcfHZPXALf5efZgABFVwSSWs4l
         h9Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWetPyQYl3uHXgnewxTfLsPe/VwsST1uSPyfFpjTC7dmrHtGWfbGAi88XxpwIFV2zRiQG0z1qMWDi24T2NB@vger.kernel.org
X-Gm-Message-State: AOJu0YxS6BNRHITbIOvUwGUX+bP1mv9VugyLyxgLF+fe/Us2mXduHiVE
	f287+/yW8iCn/7KMWI1tqpywxtE2o6dBPcNGs3uFlcRYNYDh6Mb8zgpnTw==
X-Google-Smtp-Source: AGHT+IHZRJDsTNpLMedO62EHqxIReoWTeb2Qqbk7nZ9GO4YFtKjl4gqofq7FFBtkZ8vsdu7eBG2/lQ==
X-Received: by 2002:a25:d650:0:b0:e2b:ade5:b925 with SMTP id 3f1490d57ef6-e2e3a6c65dbmr5653381276.43.1729790496315;
        Thu, 24 Oct 2024 10:21:36 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdcaebe52sm1933628276.41.2024.10.24.10.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:21:35 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v3 12/13] fuse: convert direct io to use folios
Date: Thu, 24 Oct 2024 10:18:08 -0700
Message-ID: <20241024171809.3142801-13-joannelkoong@gmail.com>
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

Convert direct io requests to use folios instead of pages.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c   | 80 +++++++++++++++++++++---------------------------
 fs/fuse/fuse_i.h | 22 -------------
 2 files changed, 35 insertions(+), 67 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 99af3c39e529..14af8c41fc83 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -665,11 +665,11 @@ static void fuse_release_user_pages(struct fuse_args_pages *ap, ssize_t nres,
 {
 	unsigned int i;
 
-	for (i = 0; i < ap->num_pages; i++) {
+	for (i = 0; i < ap->num_folios; i++) {
 		if (should_dirty)
-			set_page_dirty_lock(ap->pages[i]);
+			folio_mark_dirty_lock(ap->folios[i]);
 		if (ap->args.is_pinned)
-			unpin_user_page(ap->pages[i]);
+			unpin_folio(ap->folios[i]);
 	}
 
 	if (nres > 0 && ap->args.invalidate_vmap)
@@ -742,24 +742,6 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 	kref_put(&io->refcnt, fuse_io_release);
 }
 
-static struct fuse_io_args *fuse_io_alloc(struct fuse_io_priv *io,
-					  unsigned int npages)
-{
-	struct fuse_io_args *ia;
-
-	ia = kzalloc(sizeof(*ia), GFP_KERNEL);
-	if (ia) {
-		ia->io = io;
-		ia->ap.pages = fuse_pages_alloc(npages, GFP_KERNEL,
-						&ia->ap.descs);
-		if (!ia->ap.pages) {
-			kfree(ia);
-			ia = NULL;
-		}
-	}
-	return ia;
-}
-
 static struct fuse_io_args *fuse_io_folios_alloc(struct fuse_io_priv *io,
 						 unsigned int nfolios)
 {
@@ -779,12 +761,6 @@ static struct fuse_io_args *fuse_io_folios_alloc(struct fuse_io_priv *io,
 	return ia;
 }
 
-static void fuse_io_free(struct fuse_io_args *ia)
-{
-	kfree(ia->ap.pages);
-	kfree(ia);
-}
-
 static void fuse_io_folios_free(struct fuse_io_args *ia)
 {
 	kfree(ia->ap.folios);
@@ -821,7 +797,7 @@ static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
 	fuse_release_user_pages(&ia->ap, err ?: nres, io->should_dirty);
 
 	fuse_aio_complete(io, err, pos);
-	fuse_io_free(ia);
+	fuse_io_folios_free(ia);
 }
 
 static ssize_t fuse_async_req_send(struct fuse_mount *fm,
@@ -1531,6 +1507,7 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 			       bool use_pages_for_kvec_io)
 {
 	bool flush_or_invalidate = false;
+	unsigned int nr_pages = 0;
 	size_t nbytes = 0;  /* # bytes already packed in req */
 	ssize_t ret = 0;
 
@@ -1560,15 +1537,23 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 		}
 	}
 
-	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
-		unsigned npages;
+	/*
+	 * Until there is support for iov_iter_extract_folios(), we have to
+	 * manually extract pages using iov_iter_extract_pages() and then
+	 * copy that to a folios array.
+	 */
+	struct page **pages = kzalloc(max_pages * sizeof(struct page *),
+				      GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	while (nbytes < *nbytesp && nr_pages < max_pages) {
+		unsigned nfolios, i;
 		size_t start;
-		struct page **pt_pages;
 
-		pt_pages = &ap->pages[ap->num_pages];
-		ret = iov_iter_extract_pages(ii, &pt_pages,
+		ret = iov_iter_extract_pages(ii, &pages,
 					     *nbytesp - nbytes,
-					     max_pages - ap->num_pages,
+					     max_pages - nr_pages,
 					     0, &start);
 		if (ret < 0)
 			break;
@@ -1576,15 +1561,20 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 		nbytes += ret;
 
 		ret += start;
-		npages = DIV_ROUND_UP(ret, PAGE_SIZE);
+		/* Currently, all folios in FUSE are one page */
+		nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
 
-		ap->descs[ap->num_pages].offset = start;
-		fuse_page_descs_length_init(ap->descs, ap->num_pages, npages);
+		ap->folio_descs[ap->num_folios].offset = start;
+		fuse_folio_descs_length_init(ap->folio_descs, ap->num_folios, nfolios);
+		for (i = 0; i < nfolios; i++)
+			ap->folios[i + ap->num_folios] = page_folio(pages[i]);
 
-		ap->num_pages += npages;
-		ap->descs[ap->num_pages - 1].length -=
+		ap->num_folios += nfolios;
+		ap->folio_descs[ap->num_folios - 1].length -=
 			(PAGE_SIZE - ret) & (PAGE_SIZE - 1);
+		nr_pages += nfolios;
 	}
+	kfree(pages);
 
 	if (write && flush_or_invalidate)
 		flush_kernel_vmap_range(ap->args.vmap_base, nbytes);
@@ -1624,14 +1614,14 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	bool fopen_direct_io = ff->open_flags & FOPEN_DIRECT_IO;
 
 	max_pages = iov_iter_npages(iter, fc->max_pages);
-	ia = fuse_io_alloc(io, max_pages);
+	ia = fuse_io_folios_alloc(io, max_pages);
 	if (!ia)
 		return -ENOMEM;
 
 	if (fopen_direct_io && fc->direct_io_allow_mmap) {
 		res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
 		if (res) {
-			fuse_io_free(ia);
+			fuse_io_folios_free(ia);
 			return res;
 		}
 	}
@@ -1646,7 +1636,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	if (fopen_direct_io && write) {
 		res = invalidate_inode_pages2_range(mapping, idx_from, idx_to);
 		if (res) {
-			fuse_io_free(ia);
+			fuse_io_folios_free(ia);
 			return res;
 		}
 	}
@@ -1673,7 +1663,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 
 		if (!io->async || nres < 0) {
 			fuse_release_user_pages(&ia->ap, nres, io->should_dirty);
-			fuse_io_free(ia);
+			fuse_io_folios_free(ia);
 		}
 		ia = NULL;
 		if (nres < 0) {
@@ -1692,13 +1682,13 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		}
 		if (count) {
 			max_pages = iov_iter_npages(iter, fc->max_pages);
-			ia = fuse_io_alloc(io, max_pages);
+			ia = fuse_io_folios_alloc(io, max_pages);
 			if (!ia)
 				break;
 		}
 	}
 	if (ia)
-		fuse_io_free(ia);
+		fuse_io_folios_free(ia);
 	if (res > 0)
 		*ppos = pos;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c1c7def8ee4b..d26d278da886 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1017,18 +1017,6 @@ static inline bool fuse_is_bad(struct inode *inode)
 	return unlikely(test_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state));
 }
 
-static inline struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
-					     struct fuse_page_desc **desc)
-{
-	struct page **pages;
-
-	pages = kzalloc(npages * (sizeof(struct page *) +
-				  sizeof(struct fuse_page_desc)), flags);
-	*desc = (void *) (pages + npages);
-
-	return pages;
-}
-
 static inline struct folio **fuse_folios_alloc(unsigned int nfolios, gfp_t flags,
 					       struct fuse_folio_desc **desc)
 {
@@ -1041,16 +1029,6 @@ static inline struct folio **fuse_folios_alloc(unsigned int nfolios, gfp_t flags
 	return folios;
 }
 
-static inline void fuse_page_descs_length_init(struct fuse_page_desc *descs,
-					       unsigned int index,
-					       unsigned int nr_pages)
-{
-	int i;
-
-	for (i = index; i < index + nr_pages; i++)
-		descs[i].length = PAGE_SIZE - descs[i].offset;
-}
-
 static inline void fuse_folio_descs_length_init(struct fuse_folio_desc *descs,
 						unsigned int index,
 						unsigned int nr_folios)
-- 
2.43.5


