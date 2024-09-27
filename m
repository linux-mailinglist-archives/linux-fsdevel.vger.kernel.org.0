Return-Path: <linux-fsdevel+bounces-30279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856F3988B71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490822858D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C951C2DBB;
	Fri, 27 Sep 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WtuH29gO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE941C32EF
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469953; cv=none; b=JlZnu5qCsEZdID809oNlkMqjt13lwSGDXa2AMRUD07inQ2oi8ildcjAD2h/GZ0EY4AQAWSoJPORgjjla7dh912P2ybodA7M4Zsxmxt3lx4j8PTgL+W9/u6Ls+ao03Jf20sFNan7o+uYjpOLD7wWqXp8mBw8aUoupog9xzqb4llU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469953; c=relaxed/simple;
	bh=nwz6XfK+mPOFSG4FqpqRIcV+tg1cB8FrENRyhWMZIWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8Tv77LLflKrE+ZKo3vWQK1cwWOeOcFjnO6zwuZA+0tDHqXSCuDzJsSx8J7N4kNcu6Kres3iH7FqY9hMRDfSMfLzKUWhDhKuXYzunQUiRt+DOM+8uUuyExEsLmm3AWod7SmxAqlis2WPuipkZbWZg+XLw7vflzy/zTH5PqXngaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=WtuH29gO; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ddd138e0d0so24503427b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 13:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727469950; x=1728074750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Qzd63vJ+fCRdeBjKv8oXl3xCmoMjOM5uJKlOm7yyIs=;
        b=WtuH29gOVOEeXEXnwqALVNFwq5KycNhrLkVBkIRN/6yPvDNBtzGA0TOhFPf9vcQ6mZ
         PVi8xshik0iSZzs6PXgq7kEJ235TbNs5x1dKCrZdWmB2C22njGOAcoD4G7gYAa62i/eB
         Yq3kYudjDAMCJoiefzHMne8m8ZgzXmiTJONNQrtzTZ2VausDLbHQggvCZB6U8FxB9XOO
         rt4KiPsNtn5UqBESMF6yHScv32IwgwdwFQzZaPip2BIkyZfoL13x52JIii+ZVYuIM/qs
         cutMJqmA0+zzYU3lt8XWtNExCg5B7cu/Yzomq9V+XQFc/Z28pgVFY7+hVqIrtSimz52h
         ES2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469950; x=1728074750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Qzd63vJ+fCRdeBjKv8oXl3xCmoMjOM5uJKlOm7yyIs=;
        b=QKuWaa6KESaH0GyGp5AvDKlctZH4t4egSky7hPTupNVCT8ODyQHbwb1hpJxXgoD78s
         hiZR48sB8DX1IZ/ex0B/y7Vdnxj9ZkF6cEOzkPlLsU2wrm81UXqqFKMwi75M2fIp9av0
         RNwdER8MAk/dgMv44vbrxaRluZG3F5OnF8j3doZRC96JRiHvyMbSmLR2LLzuptkMOn1N
         BAl6Qy9mfC3Qyjzifq5a/5VSeqv+OrbjFBY2xBg98y4GvZ9uW9B2Vf2+9jGBK7aFN1e9
         7eRMI+Cx2nPIfz70h4q5X75XgC4SC3Vei312RuGqkjyTdzJ/nngn49R2wo6DHA0nVM92
         mvpw==
X-Gm-Message-State: AOJu0Ywj+R+EjuIyfxXYX2z3ROgfWVAnUbIGX+OlsVkuWYuwHijbRag2
	WjU9zWOhxgJ8Vu5HoWe80wYA77YW/EpxFycJcWyKTdwC0/09RyMWz1lqJiVe/Xf2jtVoHh5MKpa
	c
X-Google-Smtp-Source: AGHT+IGmtc9RkJ2MlpjG4zA1NfNlD8pUkXzcrbNP0egnTmlCAIwjUDxXHXHuVzXTPr27+ggCcA4DHg==
X-Received: by 2002:a05:690c:89:b0:6db:d5dd:af76 with SMTP id 00721157ae682-6e2475e841bmr47109347b3.32.1727469950334;
        Fri, 27 Sep 2024 13:45:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2453698fcsm4252377b3.77.2024.09.27.13.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:45:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Subject: [PATCH v3 06/10] fuse: convert fuse_do_readpage to use folios
Date: Fri, 27 Sep 2024 16:44:57 -0400
Message-ID: <0fe4cfc0e7d290e539abc215501ebebf658fd2b2.1727469663.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727469663.git.josef@toxicpanda.com>
References: <cover.1727469663.git.josef@toxicpanda.com>
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
index 2af9ec67a8e7..8a4621939d3b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -858,12 +858,13 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
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
@@ -875,11 +876,10 @@ static int fuse_do_readpage(struct file *file, struct page *page)
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
 
@@ -897,25 +897,24 @@ static int fuse_do_readpage(struct file *file, struct page *page)
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
 
@@ -2444,7 +2443,7 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
 			folio_zero_segment(folio, 0, off);
 		goto success;
 	}
-	err = fuse_do_readpage(file, &folio->page);
+	err = fuse_do_readpage(file, folio);
 	if (err)
 		goto cleanup;
 success:
-- 
2.43.0


