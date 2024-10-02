Return-Path: <linux-fsdevel+bounces-30750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5FB98E13F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AB51C235A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0101D1731;
	Wed,  2 Oct 2024 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgY3wIPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70C1D150B
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888130; cv=none; b=c6xhAQYrM/+OiiRSVOJvzaqGJtp3EtJSOK5RH54Xqfc7KvCL0+IP3ngjnaIebicuLw0TRD4URQlGd8pC+mf12Dq5eufeos++Wgg2B8s4Zr9vSq8Jq83UxhoguEZrLoc133MIK2cEXBl7Kyl9RPYPTA8NiTwY7TlVRWLX0c0hXsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888130; c=relaxed/simple;
	bh=xR4UM9oCmE02frXQu0xHjIGkQQxVZBd1GpKxHYD05O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nf90KUkVjIm4QctpCXPNxGNg43Y3DWigk0oUgOG8n6a3fOHyJRgSAGxtPA3Nw+yWe25ap4XMLxGnUhJEwIml96I8TYf0ax6WjemW2FBq/1MWqyZ+p/1iFbJJOxVqR7MTasXhhC2kTz2bm64kq0zaE29zSn7FjSVTtJARKdcQPdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgY3wIPk; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e214c3d045so179217b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888128; x=1728492928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8DsfLSr/NMs5kxUIKVam3/UNO7YeIGWQF4+6qkmNtU=;
        b=mgY3wIPkAqAyYMx4SQk2hiL7PZO9SqGzJlbZIt+Nm9o6vXKDWaxhSdME6G6xkh8aoU
         5ZuDVTjqvxuz21cuPCUNI8jbrXQn99AGD4xrvwh51BOMB6IpFx7whLB2MibNj/HCwP49
         9Jl2z3+3iKw/GCs9M+VgM/uY+mFPCeckUZOwUV0xG49gBjkqEf//zE0X5lBdXuJHzb8c
         mieKe/6f+SitWcCWjBcBxRnJ/TdaAxoj1oATaMlmW1xUpK43ixHG40Jr8kfhvWEas4VL
         GQSVsxDJos5B8LX6aFep2cP2i5QDJFuCFcC1yZjaryw0aY3A7x6GaTALdwJsJiEcxabH
         uoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888128; x=1728492928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8DsfLSr/NMs5kxUIKVam3/UNO7YeIGWQF4+6qkmNtU=;
        b=BfHsHPfHcGTauEsRsfuzqNIUb4XX3KhoB3+vhZE837KCOA+ZNi4LsLgFpoDQ7MBwFV
         AJsUBKCBGSGdxI7MyqbNtgImKt+qCpgJvd2N9TRcYeWX20dI3KN9Rynh6rlG+5Djz7Ug
         YViuHJFTe27D8nnxKvERuA87/A2ic9rAlRQERjThFlIPRtHIjSQI68dP0xyv/fEhiB+n
         HCs7jAvtQtYYCI4AfxWh46KfrNoPk7swosyzMOoW4Laue9Ro/voHxPe3Zzv4LhfVFDZa
         paeqeLrRakZDOD/iUQyKvFe/GiynOFoaeoA9JcdXEzXRCnpMFYFIrJpKHT4Tqd/aOFRE
         nDBA==
X-Forwarded-Encrypted: i=1; AJvYcCUqVAraE81ZbAycvFst4ageiTYCUNRc8pKCLSkJToSbbEEspGYOGwOnwb8zmbnVE6nZu/uJieRhepqIKkRe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7SCFxmGNZ03hzZdC32P/vzBvbnoKh2wbtHig0Xd41g/OzK8Az
	JM2D2Kozhlt1+MfP+j/UURRnOETlmkdhPVTdPfm9lDdoOAl429FXnOg4PA==
X-Google-Smtp-Source: AGHT+IHSZ2ZX7syUPfv+xRNyUZzatNDwceTVTq7Kbauf5XE4hVvvY/IjdwoserXCMFgaWVfjzKLTiA==
X-Received: by 2002:a05:690c:508a:b0:6af:8662:ff37 with SMTP id 00721157ae682-6e2a2b112d6mr26779037b3.21.1727888128245;
        Wed, 02 Oct 2024 09:55:28 -0700 (PDT)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2452f9ed3sm25329017b3.12.2024.10.02.09.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:55:28 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH 12/13] fuse: convert direct io to use folios
Date: Wed,  2 Oct 2024 09:52:52 -0700
Message-ID: <20241002165253.3872513-13-joannelkoong@gmail.com>
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

Convert direct io requests to use folios instead of pages.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 88 ++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 50 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1fa870fb3cc4..38ed9026f286 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -665,11 +665,11 @@ static void fuse_release_user_pages(struct fuse_args_pages *ap,
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
 }
 
@@ -739,24 +739,6 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
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
@@ -776,12 +758,6 @@ static struct fuse_io_args *fuse_io_folios_alloc(struct fuse_io_priv *io,
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
@@ -814,7 +790,7 @@ static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
 	}
 
 	fuse_aio_complete(io, err, pos);
-	fuse_io_free(ia);
+	fuse_io_folios_free(ia);
 }
 
 static ssize_t fuse_async_req_send(struct fuse_mount *fm,
@@ -1518,10 +1494,11 @@ static inline size_t fuse_get_frag_size(const struct iov_iter *ii,
 
 static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 			       size_t *nbytesp, int write,
-			       unsigned int max_pages)
+			       unsigned int max_folios)
 {
 	size_t nbytes = 0;  /* # bytes already packed in req */
 	ssize_t ret = 0;
+	ssize_t i = 0;
 
 	/* Special case for kernel I/O: can copy directly into the buffer */
 	if (iov_iter_is_kvec(ii)) {
@@ -1538,15 +1515,23 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 		return 0;
 	}
 
-	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
-		unsigned npages;
+	/*
+	 * Until there is support for iov_iter_extract_folios(), we have to
+	 * manually extract pages using iov_iter_extract_pages() and then
+	 * copy that to a folios array.
+	 */
+	struct page **pages = kzalloc((max_folios - ap->num_folios) * sizeof(struct page *),
+				      GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	while (nbytes < *nbytesp && ap->num_folios < max_folios) {
+		unsigned nfolios;
 		size_t start;
-		struct page **pt_pages;
 
-		pt_pages = &ap->pages[ap->num_pages];
-		ret = iov_iter_extract_pages(ii, &pt_pages,
+		ret = iov_iter_extract_pages(ii, &pages,
 					     *nbytesp - nbytes,
-					     max_pages - ap->num_pages,
+					     max_folios - ap->num_folios,
 					     0, &start);
 		if (ret < 0)
 			break;
@@ -1554,15 +1539,18 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 		nbytes += ret;
 
 		ret += start;
-		npages = DIV_ROUND_UP(ret, PAGE_SIZE);
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
 	}
+	kfree(pages);
 
 	ap->args.is_pinned = iov_iter_extract_will_pin(ii);
 	ap->args.user_pages = true;
@@ -1594,18 +1582,18 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	ssize_t res = 0;
 	int err = 0;
 	struct fuse_io_args *ia;
-	unsigned int max_pages;
+	unsigned int max_folios;
 	bool fopen_direct_io = ff->open_flags & FOPEN_DIRECT_IO;
 
-	max_pages = iov_iter_npages(iter, fc->max_pages);
-	ia = fuse_io_alloc(io, max_pages);
+	max_folios = iov_iter_npages(iter, fc->max_pages);
+	ia = fuse_io_folios_alloc(io, max_folios);
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
@@ -1620,7 +1608,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	if (fopen_direct_io && write) {
 		res = invalidate_inode_pages2_range(mapping, idx_from, idx_to);
 		if (res) {
-			fuse_io_free(ia);
+			fuse_io_folios_free(ia);
 			return res;
 		}
 	}
@@ -1632,7 +1620,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		size_t nbytes = min(count, nmax);
 
 		err = fuse_get_user_pages(&ia->ap, iter, &nbytes, write,
-					  max_pages);
+					  max_folios);
 		if (err && !nbytes)
 			break;
 
@@ -1647,7 +1635,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 
 		if (!io->async || nres < 0) {
 			fuse_release_user_pages(&ia->ap, io->should_dirty);
-			fuse_io_free(ia);
+			fuse_io_folios_free(ia);
 		}
 		ia = NULL;
 		if (nres < 0) {
@@ -1665,14 +1653,14 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 			break;
 		}
 		if (count) {
-			max_pages = iov_iter_npages(iter, fc->max_pages);
-			ia = fuse_io_alloc(io, max_pages);
+			max_folios = iov_iter_npages(iter, fc->max_pages);
+			ia = fuse_io_folios_alloc(io, max_folios);
 			if (!ia)
 				break;
 		}
 	}
 	if (ia)
-		fuse_io_free(ia);
+		fuse_io_folios_free(ia);
 	if (res > 0)
 		*ppos = pos;
 
-- 
2.43.5


