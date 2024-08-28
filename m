Return-Path: <linux-fsdevel+bounces-27653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910EB9633AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA6A2846D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB4D1AD9C1;
	Wed, 28 Aug 2024 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JuxP9s1c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5E71AC89A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879692; cv=none; b=ozZVzcE77oZFjbUzNUvuUSr3l9wi4gm79k3hXQbxhq0oRTNeg8zdLVLL01ToMhqMD9sodDfqUvmtbmrQBN5wSwogg+3lfG1czSgO9gF/RjAojQOwJfWaHTbzjq3wDw+PgSscmChJ5IDqmlsyJ2P9BMQRrIUuNek69Lw/sMYxv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879692; c=relaxed/simple;
	bh=C7WbJ8HyRiKebH4aRJvaZ+gsrvSb+hM61v0w3L8+lg0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uk/4MX430TekndnSMvicWfKEl/ImoK0sR/FVFHmn6xP333gRNbWiRf3w6MIUiJEori6/IiFqzaSJosx0N4RJH0sirPNj1E7d4VFd4Sjt6OfBiaLrh+8128Wj7Zf+yQGKO+Lox0Oc5JcOsF9lkEHIvXHShEVpp+w2KxHERiwZV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JuxP9s1c; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf784346b9so34589966d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724879690; x=1725484490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xa2b/UuJ8mJ1f1NOXP+QXHNgtO+81ETtXdFQUbx9D58=;
        b=JuxP9s1c6RmGo2lO7B07PeOpyRZJqUaR2EmvFH4DFHhbHyfAI8JhN790ia7UzDtAyq
         Iswq8kVys+hi3WPh5GuqJbZqsweSOTN1xMLzQR/Mx7BhqO387JyP8m6JZtPHapQcQZvh
         CHg3V8jRdDm6rApmCLin9fjWSL7FMHR4oXXQhpqzfN68jl8V1znTdYApIIayyQeC3/Vg
         ySyGalwhbBNeqgsgNF7MvML0mHg4HGMDyPqjIJi251UG8CiJ+9BzlQxob48FyIOv+FQ7
         BhFaGy+huxnC0CpE0j2VTptsSoLxWcKlm/7LQZ/EHPiZmpg8VbvTzCcTcmQHnbibLRU0
         UweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879690; x=1725484490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xa2b/UuJ8mJ1f1NOXP+QXHNgtO+81ETtXdFQUbx9D58=;
        b=gaxhMKdDg903EHvD451wA63eaK59kDSU72F/WnsT/p4HPDQHcXniOtXiUPqyMFAY/K
         irDibdwv7WSiKMQDtOoTW4F0iRPDxgZsTRibNUWu0ud/xM1dqmdKRcFeXe+AyZ974Ew3
         aYGC6kqLKOPwrij3tsH8uhnBk697/omgKA9LJ2L2yUeyLicO0zzzpEcSlLwdhUq2EkR1
         rkYUg2KNIA6FZ6kQVOLzh4aDaMot9ZMFSNSbjsNgoCeAAkxLfZW9cTLOiavsEbkqt71y
         rcBdz+D0C3gs0AX2sAcIf+L7uba7wEupjYsb4n27wrnBFuPV049aeUdRpcO6T7BhkOIj
         lPZQ==
X-Gm-Message-State: AOJu0YxYCJ95zwJxUYdMZVGVT0ztMWXpe1WA47buoUriovxeghrLjMd7
	Fi8Mmu3lV3d9v4fhdZGSEUfIrOvPsVRRxVibHb5q4hjg1lKTME+NM9j5txYldrV5NGF9mtlOYkv
	8
X-Google-Smtp-Source: AGHT+IGxu1jsu2FHhRTp0an6lb2jB5Ew1C6CHguSTxNqwYmRCGFN8HY3LaOexLIrEwinvLEX7cQPlA==
X-Received: by 2002:a05:6214:2d46:b0:6c3:2fc5:7c4 with SMTP id 6a1803df08f44-6c33e6a184bmr11004126d6.48.1724879689910;
        Wed, 28 Aug 2024 14:14:49 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d20f64sm68141496d6.24.2024.08.28.14.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:14:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com,
	willy@infradead.org
Subject: [PATCH v2 07/11] fuse: convert fuse_do_readpage to use folios
Date: Wed, 28 Aug 2024 17:13:57 -0400
Message-ID: <c9f291bb96281f9329f1f703be295fffbfde1be5.1724879414.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724879414.git.josef@toxicpanda.com>
References: <cover.1724879414.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the buffered write path is using folios, convert
fuse_do_readpage() to take a folio instead of a page, update it to use
the appropriate folio helpers, and update the callers to pass in the
folio directly instead of a page.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index af91043b44d7..7b44efbe9653 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -859,12 +859,13 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
 	}
 }
 
-static int fuse_do_readpage(struct file *file, struct page *page)
+static int fuse_do_readpage(struct file *file, struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
-	loff_t pos = page_offset(page);
+	loff_t pos = folio_pos(folio);
 	struct fuse_page_desc desc = { .length = PAGE_SIZE };
+	struct page *page = &folio->page;
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
@@ -876,11 +877,10 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 	u64 attr_ver;
 
 	/*
-	 * Page writeback can extend beyond the lifetime of the
-	 * page-cache page, so make sure we read a properly synced
-	 * page.
+	 * Folio writeback can extend beyond the lifetime of the
+	 * folio, so make sure we read a properly synced folio.
 	 */
-	fuse_wait_on_page_writeback(inode, page->index);
+	fuse_wait_on_folio_writeback(inode, folio);
 
 	attr_ver = fuse_get_attr_version(fm->fc);
 
@@ -898,25 +898,24 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 	if (res < desc.length)
 		fuse_short_read(inode, attr_ver, res, &ia.ap);
 
-	SetPageUptodate(page);
+	folio_mark_uptodate(folio);
 
 	return 0;
 }
 
 static int fuse_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	int err;
 
 	err = -EIO;
 	if (fuse_is_bad(inode))
 		goto out;
 
-	err = fuse_do_readpage(file, page);
+	err = fuse_do_readpage(file, folio);
 	fuse_invalidate_atime(inode);
  out:
-	unlock_page(page);
+	folio_unlock(folio);
 	return err;
 }
 
@@ -1447,7 +1446,7 @@ static struct folio *fuse_iomap_get_folio(struct iomap_iter *iter,
 	if (fsize <= folio_pos(folio)) {
 		folio_zero_range(folio, 0, folio_size(folio));
 	} else {
-		int err = fuse_do_readpage(file, &folio->page);
+		int err = fuse_do_readpage(file, folio);
 		if (err) {
 			folio_unlock(folio);
 			folio_put(folio);
-- 
2.43.0


