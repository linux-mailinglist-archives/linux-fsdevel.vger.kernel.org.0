Return-Path: <linux-fsdevel+bounces-54395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1D0AFF473
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2668B7AFCF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15E8246BB4;
	Wed,  9 Jul 2025 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBKs8ss5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AB24467F
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099062; cv=none; b=LyJT65WgnyIQtfbZc1BI4V8Kmzv2WdOVypvjzme62gZk4mUmXAUTgbDtey5/TDACjvBjz38JI+YfKV42aApGH8NHau2ZhBR1L8iUapRFXHQOYMMukowPG00NwxFYMq1xObIwixYQ62/DzTeJFZMvGq7Q4ho7jHcNwoVSk2zYZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099062; c=relaxed/simple;
	bh=sRn91AAed+ypF+phKI69WHs/KIFnTZhStbIIQYE8+eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=se87t9BMH95Obem+W6ICA21jprfYQoGK+v4j7U/Fl3j/s6R5v3HN+eGsgTJJcWWSTjBDji6bDgO1qMsq2sqqGSoZo8j6aCbML6XHGxo+u9Sm/cwYygmKeC6qIqEF2n+ZbHSQPQrMVDNN9Ly9uNSlPycH0NoDnobYDWvDqVjuMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBKs8ss5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so408172b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 15:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752099060; x=1752703860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLUMP1/fjMdbV5dV0l93nG5s5xzixBEQvAw/RgrASPY=;
        b=JBKs8ss5y3Vf5m3Z4kcSnF8jXjfFLq99tLIYFgEdYsUvKLtVPtJQd/WHHQllyYJEtj
         NDzj6kB/ORUaO+TqlRdkhmAF+OaQ6nVTZFtNVEGT/NKgJgqg5lmb7EzsllWBm0TT6rVd
         OoIyHyrpCV7KoTvrvfcwJi/I2nYt3RKuViqGefADjOexQGfXlX2e7oSXNhiFdLSsfgxI
         c1fLGf5CoH+BNWsXB4TzCMjcM4a3IYATSHDY/W6lv6dUU8WyNPypx4SUejVorBepbMmn
         j5Xh3nA2DmITqWUTxTkH3doSQclwHj1ituNHexKi0SradL2ZFSaU0ZD/15F1wFKKnDXV
         yjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099060; x=1752703860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLUMP1/fjMdbV5dV0l93nG5s5xzixBEQvAw/RgrASPY=;
        b=B+8CTbN7tWbnQ8FFp8RLLXct22cRRtUxbTaqptiS7V0sz8koyh5d/a2BvJHM/TUzye
         zvYP+DD3CzpX2mH7RpgFfk18Y9wMXuJp+Oy/Othm5Ax0lT00SX0hCpbOfuCabM9dDTEm
         INKwlhLlz+onfIUDK8iCOm5WM2Py7hFg/FoMWZeL07TFdpr/1ctZOdWVuUZNqeQgDw0w
         AaaoH8NPk+EPnaP0P/WqIabYcetrBImRddJDuuVpx5JZtK/pIkoOL2bhAqzl6HUzqIUZ
         6n6kpgcxBm6bPoZXWFbT1wHDTqBE9UbCEetLoBVuibU+p24nbHgFRD+RRFb7nKRt4SHz
         zJiQ==
X-Gm-Message-State: AOJu0Yw8vaslJNbNNewnYNIG94kyoWjplEmAlwM08L4K1A5krg2x6vjM
	C+Zr49y+j+53nddLSA+c8ZNdKXZcviLP7QrFB51hiS64zebgTmonJthCAYFqlQ==
X-Gm-Gg: ASbGncuK4B+zpT+gGJ49R8BlBpYHpH1uKZjbobXVWaLWYYI1VQeYdWIDdZRwSHCtMZA
	jTAIhn0FmZtUyzrLNL26Fyja9ekcCWyhySVe0HMGxagjiQknVfvNxFwOvyB/2dDYEAGkjuRUvG8
	qHNy4I8uLstSsTcMj9wrhefJndlhxAGWD8qVPxMtmnccF9iWYBymUWXapi1RyPxy+/7iRHT2kDD
	UR8jyGRrn1zn8HX3X9PHdqqwx28fCsePmGqvMbZ3SbDsxoZ/Lf32epOa6XqN6z2tdbHuKHfLU+J
	/kMq9XWXN+0zRqXUiSVdp2eyt4Xah0VUGmEMWzVuuaJZETKSrUWYIsHkMkRrkoxzLjDCWLk=
X-Google-Smtp-Source: AGHT+IF9Hgpef/+kp1FklLHOrXYoviooqZS74FxNsQyqZLdEMUIopHLanZbHVyY1mWRgWF+Z6Ix7MA==
X-Received: by 2002:a05:6a00:809:b0:73e:2dc5:a93c with SMTP id d2e1a72fcca58-74ea6640dc1mr5401228b3a.11.1752099059660;
        Wed, 09 Jul 2025 15:10:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06432sm24779b3a.42.2025.07.09.15.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:10:59 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	kernel-team@meta.com
Subject: [PATCH v4 1/5] fuse: use iomap for buffered writes
Date: Wed,  9 Jul 2025 15:10:19 -0700
Message-ID: <20250709221023.2252033-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250709221023.2252033-1-joannelkoong@gmail.com>
References: <20250709221023.2252033-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have buffered writes go through iomap. This has two advantages:
* granular large folio synchronous reads
* granular large folio dirty tracking

If for example there is a 1 MB large folio and a write issued at pos 1
to pos 1 MB - 2, only the head and tail pages will need to be read in
and marked uptodate instead of the entire folio needing to be read in.
Non-relevant trailing pages are also skipped (eg if for a 1 MB large
folio a write is issued at pos 1 to 4099, only the first two pages are
read in and the ones after that are skipped).

iomap also has granular dirty tracking. This is useful in that when it
comes to writeback time, only the dirty portions of the large folio will
be written instead of having to write out the entire folio. For example
if there is a 1 MB large folio and only 2 bytes in it are dirty, only
the page for those dirty bytes get written out. Please note that
granular writeback is only done once fuse also uses iomap in writeback
(separate commit).

.release_folio needs to be set to iomap_release_folio so that any
allocated iomap ifs structs get freed.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/Kconfig |   1 +
 fs/fuse/file.c  | 148 ++++++++++++++++++------------------------------
 2 files changed, 55 insertions(+), 94 deletions(-)

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index ca215a3cba3e..a774166264de 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -2,6 +2,7 @@
 config FUSE_FS
 	tristate "FUSE (Filesystem in Userspace) support"
 	select FS_POSIX_ACL
+	select FS_IOMAP
 	help
 	  With FUSE it is possible to implement a fully functional filesystem
 	  in a userspace program.
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 47006d0753f1..cadad61ef7df 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -21,6 +21,7 @@
 #include <linux/filelock.h>
 #include <linux/splice.h>
 #include <linux/task_io_accounting_ops.h>
+#include <linux/iomap.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
@@ -788,12 +789,16 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
 	}
 }
 
-static int fuse_do_readfolio(struct file *file, struct folio *folio)
+static int fuse_do_readfolio(struct file *file, struct folio *folio,
+			     size_t off, size_t len)
 {
 	struct inode *inode = folio->mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
-	loff_t pos = folio_pos(folio);
-	struct fuse_folio_desc desc = { .length = folio_size(folio) };
+	loff_t pos = folio_pos(folio) + off;
+	struct fuse_folio_desc desc = {
+		.offset = off,
+		.length = len,
+	};
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
@@ -820,8 +825,6 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	if (res < desc.length)
 		fuse_short_read(inode, attr_ver, res, &ia.ap);
 
-	folio_mark_uptodate(folio);
-
 	return 0;
 }
 
@@ -834,13 +837,26 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
 	if (fuse_is_bad(inode))
 		goto out;
 
-	err = fuse_do_readfolio(file, folio);
+	err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
+	if (!err)
+		folio_mark_uptodate(folio);
+
 	fuse_invalidate_atime(inode);
  out:
 	folio_unlock(folio);
 	return err;
 }
 
+static int fuse_iomap_read_folio_range(const struct iomap_iter *iter,
+				       struct folio *folio, loff_t pos,
+				       size_t len)
+{
+	struct file *file = iter->private;
+	size_t off = offset_in_folio(folio, pos);
+
+	return fuse_do_readfolio(file, folio, off, len);
+}
+
 static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 			       int err)
 {
@@ -1374,6 +1390,24 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
 	}
 }
 
+static const struct iomap_write_ops fuse_iomap_write_ops = {
+	.read_folio_range = fuse_iomap_read_folio_range,
+};
+
+static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+			    unsigned int flags, struct iomap *iomap,
+			    struct iomap *srcmap)
+{
+	iomap->type = IOMAP_MAPPED;
+	iomap->length = length;
+	iomap->offset = offset;
+	return 0;
+}
+
+static const struct iomap_ops fuse_iomap_ops = {
+	.iomap_begin	= fuse_iomap_begin,
+};
+
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -1383,6 +1417,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = mapping->host;
 	ssize_t err, count;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	bool writeback = false;
 
 	if (fc->writeback_cache) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
@@ -1391,16 +1426,11 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (err)
 			return err;
 
-		if (fc->handle_killpriv_v2 &&
-		    setattr_should_drop_suidgid(idmap,
-						file_inode(file))) {
-			goto writethrough;
-		}
-
-		return generic_file_write_iter(iocb, from);
+		if (!fc->handle_killpriv_v2 ||
+		    !setattr_should_drop_suidgid(idmap, file_inode(file)))
+			writeback = true;
 	}
 
-writethrough:
 	inode_lock(inode);
 
 	err = count = generic_write_checks(iocb, from);
@@ -1419,6 +1449,15 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 		written = direct_write_fallback(iocb, from, written,
 				fuse_perform_write(iocb, from));
+	} else if (writeback) {
+		/*
+		 * Use iomap so that we can do granular uptodate reads
+		 * and granular dirty tracking for large folios.
+		 */
+		written = iomap_file_buffered_write(iocb, from,
+						    &fuse_iomap_ops,
+						    &fuse_iomap_write_ops,
+						    file);
 	} else {
 		written = fuse_perform_write(iocb, from);
 	}
@@ -2208,84 +2247,6 @@ static int fuse_writepages(struct address_space *mapping,
 	return err;
 }
 
-/*
- * It's worthy to make sure that space is reserved on disk for the write,
- * but how to implement it without killing performance need more thinking.
- */
-static int fuse_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, struct folio **foliop, void **fsdata)
-{
-	pgoff_t index = pos >> PAGE_SHIFT;
-	struct fuse_conn *fc = get_fuse_conn(file_inode(file));
-	struct folio *folio;
-	loff_t fsize;
-	int err = -ENOMEM;
-
-	WARN_ON(!fc->writeback_cache);
-
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
-			mapping_gfp_mask(mapping));
-	if (IS_ERR(folio))
-		goto error;
-
-	if (folio_test_uptodate(folio) || len >= folio_size(folio))
-		goto success;
-	/*
-	 * Check if the start of this folio comes after the end of file,
-	 * in which case the readpage can be optimized away.
-	 */
-	fsize = i_size_read(mapping->host);
-	if (fsize <= folio_pos(folio)) {
-		size_t off = offset_in_folio(folio, pos);
-		if (off)
-			folio_zero_segment(folio, 0, off);
-		goto success;
-	}
-	err = fuse_do_readfolio(file, folio);
-	if (err)
-		goto cleanup;
-success:
-	*foliop = folio;
-	return 0;
-
-cleanup:
-	folio_unlock(folio);
-	folio_put(folio);
-error:
-	return err;
-}
-
-static int fuse_write_end(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, unsigned copied,
-		struct folio *folio, void *fsdata)
-{
-	struct inode *inode = folio->mapping->host;
-
-	/* Haven't copied anything?  Skip zeroing, size extending, dirtying. */
-	if (!copied)
-		goto unlock;
-
-	pos += copied;
-	if (!folio_test_uptodate(folio)) {
-		/* Zero any unwritten bytes at the end of the page */
-		size_t endoff = pos & ~PAGE_MASK;
-		if (endoff)
-			folio_zero_segment(folio, endoff, PAGE_SIZE);
-		folio_mark_uptodate(folio);
-	}
-
-	if (pos > inode->i_size)
-		i_size_write(inode, pos);
-
-	folio_mark_dirty(folio);
-
-unlock:
-	folio_unlock(folio);
-	folio_put(folio);
-
-	return copied;
-}
-
 static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
@@ -3144,11 +3105,10 @@ static const struct address_space_operations fuse_file_aops  = {
 	.writepages	= fuse_writepages,
 	.launder_folio	= fuse_launder_folio,
 	.dirty_folio	= filemap_dirty_folio,
+	.release_folio	= iomap_release_folio,
 	.migrate_folio	= filemap_migrate_folio,
 	.bmap		= fuse_bmap,
 	.direct_IO	= fuse_direct_IO,
-	.write_begin	= fuse_write_begin,
-	.write_end	= fuse_write_end,
 };
 
 void fuse_init_file_inode(struct inode *inode, unsigned int flags)
-- 
2.47.1


