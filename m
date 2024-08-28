Return-Path: <linux-fsdevel+bounces-27652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F269633AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E192DB21390
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7BB1AD417;
	Wed, 28 Aug 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="asgT9x+l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0D1AC8A9
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879691; cv=none; b=XM3Uah8YaG7S7bjWm4Iu10B8WFdgXOQOoC2FhgbnNt0woGO9acYnZrGfdpt0UjaAXEigseoJAZPAAi4faDHdgHLR8EdJ3nVS9sAId5sJA4+0NQ3vTi6eQT1372SkkSvbFynsO5Fm/WLmFcFz8VSqT81M+sVXPZFK9irTqAbl2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879691; c=relaxed/simple;
	bh=EPTtiftFSfELZLbjnZAHuoODiXnvFK83m3r4JOpyy+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FY+KLYuwLHrjPKHndBkH+Q/oYTvnGvNncXohOsa65PY+ONXfrlPeVldqrlADdtfTUX+gF7picy2C3ZUpDuYi76E7Mb3mhbUFmtu6CdKtQCRRRVi4c+7fYj702gtzrgSIEAvVEetUaMYrvYMT3ASWVfZpwEwKxSWVnAlRPXFxkCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=asgT9x+l; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4503ccbc218so9590461cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724879688; x=1725484488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaTpBNDg2GfeKIc65MjT51a5XarKI2599rDM016xIxM=;
        b=asgT9x+lNYqRjpMCrsH8CbrY6qhvgp2TaVzdrN5cJjavlhkWGmV695bQUwuYLR07GE
         RRCcol+1H4nah25O4rFdg5bkPcQe32AXC45DpHzDxWFIK0qhsmMqH6jmF4U+kSURlsa7
         hqBnVaed7cgPhKemth7+x3vnsyUpHf7kUqMhbrSeT419rtsJjnQ+Cnyk0GTXRCzjIgp2
         /94uUYXCb/Rfqt10/BKZklMmyWJ8XytUj43QOb1xBpkf6lGA+UzINMkrr0D03pSDQ1E0
         837+mrqg0dVvLO/Qh8CmfIfZywmFy4HjzNl3lK9RqbjUrHGAbhSaz17viIQn1Oo71kmh
         LRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879688; x=1725484488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaTpBNDg2GfeKIc65MjT51a5XarKI2599rDM016xIxM=;
        b=u6siWPLAd4OB6grDwLK1ZlmWZImNoVcHtQ07WQ8vXkGaZtCsuhE7xCtnc9YgDnm95g
         b2NMMXh2ITZFQl0t4aNUH7dZN2cEAYFQi8UwPkXMNoYzRsAKCa+M1aEkJ8uNSiLprvfP
         bDbeJIbbLfsL97cZ9i/E9KT5ZAsadWbSa6AhxWn6SPmBNxulmJTq0sQlhbBw67k5r0YW
         K34kBFx4Eckd1kkjqXrI3A/jQoOHMnPVziwLbywjgiPtPAq/pWEvAwdU9oWelyh3vYRu
         +k2GfuQQR3w9ehqusL5mgOeUT6fiTRx7v6WhM6tyFegqNyseVDEZjz8qEKuxWmYWEN79
         R/tw==
X-Gm-Message-State: AOJu0YxpAOtlTy+b97XOK00UHCyYS2DIhT1h+MhhoiNRt0SHWkkXVMeF
	HvZgnRUA6Wa+CFJ1AMbHI0Hybb6MZbMJvc8AOfY39n4S+9MVYrdfqK67XEwYhoA31MSnMZdPYNt
	G
X-Google-Smtp-Source: AGHT+IHL2HaE6jZLI+vVZb3ZtFFB+qrpiRCgpBEC0p5ZBt5xgmMoGZp6ZkS48f7PIg1jw7fsRcRhWw==
X-Received: by 2002:a05:6214:412:b0:6bd:738c:842e with SMTP id 6a1803df08f44-6c33f33ba2dmr9729236d6.7.1724879688508;
        Wed, 28 Aug 2024 14:14:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d1c856sm68693286d6.14.2024.08.28.14.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:14:48 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com,
	willy@infradead.org
Subject: [PATCH v2 06/11] fuse: use iomap for writeback cache buffered writes
Date: Wed, 28 Aug 2024 17:13:56 -0400
Message-ID: <dc1e8cd7300e1b76ae2fe77755acaf216571153b.1724879414.git.josef@toxicpanda.com>
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

We're currently using the old ->write_begin()/->write_end() method of
doing buffered writes.  This isn't a huge deal for fuse since we
basically just want to copy the pages and move on, but the iomap
infrastructure gives us access to having huge folios.  Rework the
buffered write path when we have writeback cache to use the iomap
buffered write code, the ->get_folio() callback now handles the work
that we did in ->write_begin(), the rest of the work is handled inside
of iomap so we don't need a replacement for ->write_end.

This does bring BLOCK as a dependency, as the buffered write part of
iomap requires CONFIG_BLOCK.  This could be shed if we reworked the file
write iter portion of the buffered write path was separated out to not
need BLOCK.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/Kconfig |   2 +
 fs/fuse/file.c  | 154 +++++++++++++++++++++---------------------------
 2 files changed, 68 insertions(+), 88 deletions(-)

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 8674dbfbe59d..8a799324d7bd 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config FUSE_FS
 	tristate "FUSE (Filesystem in Userspace) support"
+	depends on BLOCK
 	select FS_POSIX_ACL
+	select FS_IOMAP
 	help
 	  With FUSE it is possible to implement a fully functional filesystem
 	  in a userspace program.
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ab531a4694b3..af91043b44d7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -21,6 +21,7 @@
 #include <linux/filelock.h>
 #include <linux/splice.h>
 #include <linux/task_io_accounting_ops.h>
+#include <linux/iomap.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
@@ -1420,6 +1421,63 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
 	}
 }
 
+static struct folio *fuse_iomap_get_folio(struct iomap_iter *iter,
+					  loff_t pos, unsigned len)
+{
+	struct file *file = (struct file *)iter->private;
+	struct inode *inode = iter->inode;
+	struct folio *folio;
+	loff_t fsize;
+
+	folio = iomap_get_folio(iter, pos, len);
+	if (IS_ERR(folio))
+		return folio;
+
+	fuse_wait_on_folio_writeback(inode, folio);
+
+	if (folio_test_uptodate(folio))
+		return folio;
+
+	/*
+	 * If we're going to write past EOF then avoid the read, but zero the
+	 * whole thing and mark it uptodate so that if we get a short write we
+	 * don't try to re-read this page, we just carry on.
+	 */
+	fsize = i_size_read(inode);
+	if (fsize <= folio_pos(folio)) {
+		folio_zero_range(folio, 0, folio_size(folio));
+	} else {
+		int err = fuse_do_readpage(file, &folio->page);
+		if (err) {
+			folio_unlock(folio);
+			folio_put(folio);
+			return ERR_PTR(err);
+		}
+	}
+
+	return folio;
+}
+
+static const struct iomap_folio_ops fuse_iomap_folio_ops = {
+	.get_folio = fuse_iomap_get_folio,
+};
+
+static int fuse_iomap_begin_write(struct inode *inode, loff_t pos, loff_t length,
+				  unsigned flags, struct iomap *iomap,
+				  struct iomap *srcmap)
+{
+	iomap->type = IOMAP_DELALLOC;
+	iomap->addr = IOMAP_NULL_ADDR;
+	iomap->offset = pos;
+	iomap->length = length;
+	iomap->folio_ops = &fuse_iomap_folio_ops;
+	return 0;
+}
+
+static const struct iomap_ops fuse_iomap_write_ops = {
+	.iomap_begin = fuse_iomap_begin_write,
+};
+
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -1428,6 +1486,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = mapping->host;
 	ssize_t err, count;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	bool writethrough = (fc->writeback_cache == 0);
 
 	if (fc->writeback_cache) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
@@ -1438,14 +1497,10 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 		if (fc->handle_killpriv_v2 &&
 		    setattr_should_drop_suidgid(&nop_mnt_idmap,
-						file_inode(file))) {
-			goto writethrough;
-		}
-
-		return generic_file_write_iter(iocb, from);
+						file_inode(file)))
+			writethrough = true;
 	}
 
-writethrough:
 	inode_lock(inode);
 
 	err = count = generic_write_checks(iocb, from);
@@ -1464,8 +1519,12 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 		written = direct_write_fallback(iocb, from, written,
 				fuse_perform_write(iocb, from));
-	} else {
+	} else if (writethrough) {
 		written = fuse_perform_write(iocb, from);
+	} else {
+		written = iomap_file_buffered_write(iocb, from,
+						    &fuse_iomap_write_ops,
+						    file);
 	}
 out:
 	inode_unlock(inode);
@@ -2408,85 +2467,6 @@ static int fuse_writepages(struct address_space *mapping,
 	return err;
 }
 
-/*
- * It's worthy to make sure that space is reserved on disk for the write,
- * but how to implement it without killing performance need more thinking.
- */
-static int fuse_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
-{
-	pgoff_t index = pos >> PAGE_SHIFT;
-	struct fuse_conn *fc = get_fuse_conn(file_inode(file));
-	struct page *page;
-	loff_t fsize;
-	int err = -ENOMEM;
-
-	WARN_ON(!fc->writeback_cache);
-
-	page = grab_cache_page_write_begin(mapping, index);
-	if (!page)
-		goto error;
-
-	fuse_wait_on_page_writeback(mapping->host, page->index);
-
-	if (PageUptodate(page) || len == PAGE_SIZE)
-		goto success;
-	/*
-	 * Check if the start this page comes after the end of file, in which
-	 * case the readpage can be optimized away.
-	 */
-	fsize = i_size_read(mapping->host);
-	if (fsize <= (pos & PAGE_MASK)) {
-		size_t off = pos & ~PAGE_MASK;
-		if (off)
-			zero_user_segment(page, 0, off);
-		goto success;
-	}
-	err = fuse_do_readpage(file, page);
-	if (err)
-		goto cleanup;
-success:
-	*pagep = page;
-	return 0;
-
-cleanup:
-	unlock_page(page);
-	put_page(page);
-error:
-	return err;
-}
-
-static int fuse_write_end(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, unsigned copied,
-		struct page *page, void *fsdata)
-{
-	struct inode *inode = page->mapping->host;
-
-	/* Haven't copied anything?  Skip zeroing, size extending, dirtying. */
-	if (!copied)
-		goto unlock;
-
-	pos += copied;
-	if (!PageUptodate(page)) {
-		/* Zero any unwritten bytes at the end of the page */
-		size_t endoff = pos & ~PAGE_MASK;
-		if (endoff)
-			zero_user_segment(page, endoff, PAGE_SIZE);
-		SetPageUptodate(page);
-	}
-
-	if (pos > inode->i_size)
-		i_size_write(inode, pos);
-
-	set_page_dirty(page);
-
-unlock:
-	unlock_page(page);
-	put_page(page);
-
-	return copied;
-}
-
 static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
@@ -3352,8 +3332,6 @@ static const struct address_space_operations fuse_file_aops  = {
 	.migrate_folio	= filemap_migrate_folio,
 	.bmap		= fuse_bmap,
 	.direct_IO	= fuse_direct_IO,
-	.write_begin	= fuse_write_begin,
-	.write_end	= fuse_write_end,
 };
 
 void fuse_init_file_inode(struct inode *inode, unsigned int flags)
-- 
2.43.0


