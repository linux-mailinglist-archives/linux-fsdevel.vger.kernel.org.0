Return-Path: <linux-fsdevel+bounces-30371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A2C98A5BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C10A1F222C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A4190067;
	Mon, 30 Sep 2024 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="YEWFSlDs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA471E4A4
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703949; cv=none; b=rBpJvvVC8uychhIcFDUMXzleY00QYyuH4zMCC+8wwSlHLF3Wjid7RBn9jOZW6dEf+C48M/sAGCeAVd0htPdM7poeQLNPXH2x8PukZR4KurGMWVbhF7dUEOblsunSTzOP/dwAqMaskua8fJQ/zWkBAq2Y2VbSF9Z4gXJ6rSbQpiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703949; c=relaxed/simple;
	bh=Qrr6OJ249fqkmKs7a9LMg35Xw1pXf2Hk8Mfn4uz7irs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ett+RGIe6Y79QK2iMxzdwsAfYHq+P/lC3XXSltPQm4iot54TQfRw+zAzN1aU2Dw6+YnP82qaYkn2mohbnuYGr/VXvOBQWt3L4LHFxSSpnMF9EGIrEiXRd4ytiu4/39nxpnDsWfdKXHlqJ1VKmrxDHW83YvxPAUaaclRa6wnaaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=YEWFSlDs; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb2e136da3so29843226d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727703947; x=1728308747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEA31PVjDHej/o795UL7q1iQP5rvE5UvcpBV5xt9Whc=;
        b=YEWFSlDs7DEFQqVVYbxZGRr9zKGAZjJZBM8Pp68wcMkHSw7hVAVUm9sEBoGJt2NxR2
         8j7JyTUqazN9wSfeHuLZifcJ0JdJucrcZvoliO1Vc2MzGPm8YdZ7dssnMbc3Fje0xVMK
         Jr3m3P3m6b6J5KsL9vom1xePAMKVh5wmd6toUmI2JWxCyt1GWit22qEEHSGZ4XF1w0NG
         DS8ye0ghKtCRwyRR+2ETxpHGPslKdfbdTeUIPFmNM72XkVkgRMIzVgPQ2bq32S3n7HP1
         GbQjtgDOGEtftuFdXMlWZhEgR/XyvPFcXcUZOUXRv5svKASEmU81ywnOgKjgIUGFjlrR
         QsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703947; x=1728308747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEA31PVjDHej/o795UL7q1iQP5rvE5UvcpBV5xt9Whc=;
        b=nRJ9YmNsya7f4nPe4iKMZKFmHHqd3wP97w0Shn5xRmvnIGdKiar+qLxoDrouGECnUy
         FAVtVXdLcoDF6ZYFSnL//j8NTAt+n+CqkUqMsK3G53ugOwMjSuL8HqnCMe2lrOpaw8Jy
         ENwGCDqzdUgZ58lpKZxWoBTgg7UXi3qizdSPrzS5867PiUABvcTAv1/Yk15uydLszRop
         7mii52Druv5ApYW7Z0luFlmLvlSXaqzRbEPiS5Fn5mQwitaIyIo4KKcm20g+ridpRyGT
         D1FMW9V+V5fmi/IybQ6qsV2pTmm38SafK2Uk1/Zk1ffYBO0uLNU/TbR3qvqqEt6h/EV6
         HuSQ==
X-Gm-Message-State: AOJu0Yy7ZQ/4ROvfX0g6hfRjsSr+SgB5N88dDexXbgl8YLf8t0oMQwky
	vl88U/+qgdoBZ0KxR+uIdceEWRjBp2xdlQ4KbF5FGFPZYPTYsLFTfXl6lFUAUvYdYK76kBOHkoQ
	I
X-Google-Smtp-Source: AGHT+IEF/0YwcYQNLfPWvZqhNmRQXQ5JbBaN0rwp67tpGA/hJqJHkmvNa+VM9ZuV/6GZz6MTVMsBDw==
X-Received: by 2002:a05:6214:3d13:b0:6cb:69dc:9923 with SMTP id 6a1803df08f44-6cb69dc992dmr35526886d6.41.1727703946731;
        Mon, 30 Sep 2024 06:45:46 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b612ecfsm39987916d6.55.2024.09.30.06.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:45:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Subject: [PATCH v4 06/10] fuse: convert fuse_do_readpage to use folios
Date: Mon, 30 Sep 2024 09:45:14 -0400
Message-ID: <17ca5aafb5c9591d28553c8af42551c8bc23a9ef.1727703714.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727703714.git.josef@toxicpanda.com>
References: <cover.1727703714.git.josef@toxicpanda.com>
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
 fs/fuse/file.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2af9ec67a8e7..45667c40de7a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -858,12 +858,13 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
 	}
 }
 
-static int fuse_do_readpage(struct file *file, struct page *page)
+static int fuse_do_readfolio(struct file *file, struct folio *folio)
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
@@ -875,11 +876,11 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 	u64 attr_ver;
 
 	/*
-	 * Page writeback can extend beyond the lifetime of the
-	 * page-cache page, so make sure we read a properly synced
-	 * page.
+	 * With the temporary pages that are used to complete writeback, we can
+	 * have writeback that extends beyond the lifetime of the folio.  So
+	 * make sure we read a properly synced folio.
 	 */
-	fuse_wait_on_page_writeback(inode, page->index);
+	fuse_wait_on_folio_writeback(inode, folio);
 
 	attr_ver = fuse_get_attr_version(fm->fc);
 
@@ -897,25 +898,24 @@ static int fuse_do_readpage(struct file *file, struct page *page)
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
+	err = fuse_do_readfolio(file, folio);
 	fuse_invalidate_atime(inode);
  out:
-	unlock_page(page);
+	folio_unlock(folio);
 	return err;
 }
 
@@ -2444,7 +2444,7 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
 			folio_zero_segment(folio, 0, off);
 		goto success;
 	}
-	err = fuse_do_readpage(file, &folio->page);
+	err = fuse_do_readfolio(file, folio);
 	if (err)
 		goto cleanup;
 success:
-- 
2.43.0


