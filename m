Return-Path: <linux-fsdevel+bounces-27446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8F59618B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181DA284174
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3211D1D365B;
	Tue, 27 Aug 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="huuIK7he"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3511D1F60
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791589; cv=none; b=IkQhkX0GfnnBmnLAxhgq4JLIH4eJHAaHmXLODU0PzjSXAprRaHDLOW6BkrukTiddsEoq32nQn+X6P8w4Qvm0g0kA0QyXCpd273vu1vyXuiS5a5exwRXK5UUdIGhN+9b4eV0mhU23K894PCdjzWhr/edoHSpgpgiLiJZS+TW4lhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791589; c=relaxed/simple;
	bh=XV6kS0+Pfazf+gnw8rE0kSJpovr6OxjLV8yVC6OgrOg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlKIvwF/0SM0lRyumexn9FtgOdXiEDku7qZKSVRnEfgXx+inq26oXUPOJ3jQ0y1Ic7FCU1QjkWKAZuEOvGcQOa1jIKyrunsN5/bLqxjrJuMP7xo/IwiiEKYDBXWit45aryKiI+fGvj+aJecIfNeJh6/3FY6P5ibXJ+0mlKZgUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=huuIK7he; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70942ebcc29so5334762a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724791587; x=1725396387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GaOAS1OWATnJoGW/KHZeFcx5X9aHGtIlOnElvn46UQ=;
        b=huuIK7heguw5e3+xlq+9zJkztSj3BF9S4EDpe2k73WpIdEeQMiE1bXsKOAf9VC/qck
         OOxrs0hiezW7XfSWxPGLCn8RY3niA7pCWSjmmkWE6477hGRmXj4LcDIfXmaZ1EJgsLpc
         ABq1OJMAofijIvdapMIbvbLm9lJiUCOYHMHWYWFYDrNxuTVtuX6iZzJ/GsDqDh7wN8Nd
         AwdyFpXSNULI01UyB/GJI9+HzXGB17/TT0ISqzsFeA7xp6gqeh+yJbBlGc99bj6Ux8mx
         CKL4VBAuKWedzIVr5LUxyaE8Zlt2T0NlOGmnwPrH3lzbH8x5uhfVzXdE3tsPzXOAem2J
         5UUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791587; x=1725396387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GaOAS1OWATnJoGW/KHZeFcx5X9aHGtIlOnElvn46UQ=;
        b=QufBsUH+GBSTBDQWLFygxGwYVKIyuV1cSUbHGT8da0QvzuF1rQe0tyy3UTijyfooj9
         VToq7lKshFv7SE2jwysSiX6t30kffEjmzPSY0Hj70D3ObEdZlVwC4Yp9ewoL1snVYbsj
         ZX8/UwE0+4UWUBFEotVqf9vlCkeHzSePKonotUGnD3yBouW7oBvyeRPm5QLM38Gvnz9X
         JzBOVY2a+JQoG/SDAmZJwVK+UxhNKZaxfZgU3UdTZbVROayKvzSa2CWvUSQF6FMRTfKr
         c5kewslgXB5skBCJjVEoiQ3LWywoxGXeqxVLxWDYGIsUr5Eli4saQU0PPZgfrsdorOK+
         05+w==
X-Gm-Message-State: AOJu0Yy2CZQqRlC/3m49YL3iDCF9DqeWAClsRK/n/03ocFzbTtPgwiDH
	dcXZh4MRm6d/naDnGQJ3nBu/Fzw2RRwX/wTuIEDabOzwaOVb8V3hSSxEeC1ay58wfAgk2RSbQpm
	n
X-Google-Smtp-Source: AGHT+IEzNUy1jpkwy4hqRHI12bVshwCDpUJZJAVOahAgsgbyy5VU+ITDEs6GAQH/S2ttnTd6CEK5+Q==
X-Received: by 2002:a05:6830:2d8a:b0:709:4757:973 with SMTP id 46e09a7af769-70e0ebd0cd0mr16059363a34.23.1724791586939;
        Tue, 27 Aug 2024 13:46:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4564cdb1296sm27918841cf.65.2024.08.27.13.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:46:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com
Subject: [PATCH 07/11] fuse: convert fuse_do_readpage to use folios
Date: Tue, 27 Aug 2024 16:45:20 -0400
Message-ID: <07b50db20f6a86179a05b1f4f23eb10aefcbaeec.1724791233.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724791233.git.josef@toxicpanda.com>
References: <cover.1724791233.git.josef@toxicpanda.com>
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
index c61bc4396649..f06f0239427b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -861,12 +861,13 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
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
@@ -878,11 +879,10 @@ static int fuse_do_readpage(struct file *file, struct page *page)
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
 
@@ -900,25 +900,24 @@ static int fuse_do_readpage(struct file *file, struct page *page)
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
 
@@ -1446,7 +1445,7 @@ static struct folio *fuse_iomap_get_folio(struct iomap_iter *iter,
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


