Return-Path: <linux-fsdevel+bounces-50884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3711AD0A68
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B266D1897BD9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8423F24167F;
	Fri,  6 Jun 2025 23:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1ywUGDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C023F40E;
	Fri,  6 Jun 2025 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253379; cv=none; b=fwTdZnTtakL3JZPf5VqkciKhMkhlz3WpA2/cXhPAf6vY6lhNM6XmGBFAGLii3nv9P92GFaZWeCOpzCSPTimGWHEU2l42ozbEK4FUhWoORoBIVnUoxh93tJHyS9Tbpa0MbkOwRzYm7PsIy8f4qNkGI6iP+p1WjaXcplSbXLl3VgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253379; c=relaxed/simple;
	bh=O1W0ulwM4LFY3XaJ4MM+D7afynstYG+yfDrDZYJ/8KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lzkr3WmuslEIBGSTrYI7RJn+eOtsLOodnXjC/pwkIMV+bBxB4YxA4Fcdb5mEqLVt7O3epnZeysEwrbYU64JfFbVKIs64sannsJoqi/yv5kwY4iFYBvHNf1EbaXoiRbmKRQu+xYnTtLqSF4CZ0u2Ig3MowcAClZf8ZgmdKmPILqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1ywUGDc; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b2c41acd479so1582709a12.2;
        Fri, 06 Jun 2025 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749253376; x=1749858176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qVy8htEdXKu34PnkgJIG77st3hVzlJLo74xh4inSgo=;
        b=k1ywUGDc/1J32nIk8pmChuZqxtjGVYsAsG4N0G9HJQ7amdkDzKWsyepxN1/stTqapF
         VP59iC3+nksPA5x29Wqjd8Z4ii7LKN9Ka3515litT20Lu6SvuQddcVM5ZOzjujeDN2J4
         mwPUDKx91KDxqxm+RdXQkIJkZrSC/uImRxKo/tXLyInoTq6k3iq/57P2k81jDARr0vd/
         AQ6BH2KNni7cUkiaqGU+FoPyuODFVVHELMp7ccT3QnQgHi2o/iORXCw+wJ85tKevqw+V
         zFtpVKbj7R5CxYtuK4QZrKd58th7x2OTAUytOeOxHT+h1U/MB01jey44VV1alfN32liR
         HfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749253376; x=1749858176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qVy8htEdXKu34PnkgJIG77st3hVzlJLo74xh4inSgo=;
        b=U08lzFmAWmO4aj5xhxibptVnKCLID7rYcub9/esZxj7FY3hXQxqJtw0NAVd4DqcEJl
         asdQqczR1o7txkg12SSb81gAIQNy7oMx40K7F8Vt2/S5rsj1ZVzfmbQakftPFNdOk8Eo
         szJzDU3/wpCeEO2WtnHEIYKoKjCDvTkWAQyPKnM8jHiyoIWjXdfZrpbl9TzHQGepfMX0
         2nnAJdh5KbYuVshYrtNQA6tIXkAKACgIVPhBSH0d5ikcO0BJTYd4qivrt120+GPWZ8AI
         izKP/wGESqbrCu1up3PyH0TOZyvfWkvZLftNfB/Y9aF8RoTHWmuCFsdpOHmLNeZs7bX/
         VwkA==
X-Forwarded-Encrypted: i=1; AJvYcCVNaP3ZzRlf3WE0p3HWtWB8WvaIK1w2rGi4wG+4CDV8DScwqNFqv2y6ZChjk7XNiFiSuZxGhShK77B1dmHG@vger.kernel.org, AJvYcCX61/7sNbctH4+OTXwKoXXHDhc4mErTBnQy/QPA55EzrPXDT6UCreD4gVcsecEhSQsDedoTjaZby2Kg@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCiIdABDAXMD5emR7kNNOLF2IO9OWu+4tOfL+uPE2XSPQTHbR
	/XNL9Hd0Q90D3fOUIgRH+YS9FSMs9zXfRmacSBlykoLhnNl+ejUC9Hs2
X-Gm-Gg: ASbGnctH++JJyCMgxj9FSw1DxazZxJWHsxJor0U2ABIILbvyM/8lroCfYShMzhkTU7i
	IP7ivZIwHv4Nb8LPjuAegB1DzKn3UlZUhNbaFAzgZNM8LPC4qnV8xiVRIwvsHtG+iTg5ikGrmsK
	Am/+sANmMR/IR2qx0i9f0I/CO3qjj0jYgh6SJ5CdsY1TFkgt+UxmB+FLJH3WArWlhluXCiNL131
	dyBU4y2EmWl0eW54URzeZE+xjdJcJuJTPARyasapT4IkAv5rBO/RDbM2/2l2rzn7oJEv8/88TSX
	VAwhLXx/7Q3kIihjSFttS/WV+fNagpLRLVxEURt4I0o5of3QI7O+RM7P
X-Google-Smtp-Source: AGHT+IFX+pYhSmvKksmVXlIFcm6m1xk46ye/Q5tD9TAm2DlnE85Z8TCeyzPsdpDoUJ3S7IZ3oHV44g==
X-Received: by 2002:a17:90b:2d8e:b0:311:e305:4e97 with SMTP id 98e67ed59e1d1-31347309819mr7261782a91.19.1749253376453;
        Fri, 06 Jun 2025 16:42:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fc6f8sm17666215ad.136.2025.06.06.16.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:42:56 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: djwong@kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v1 6/8] fuse: use iomap for buffered writes
Date: Fri,  6 Jun 2025 16:38:01 -0700
Message-ID: <20250606233803.1421259-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606233803.1421259-1-joannelkoong@gmail.com>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have buffered writes go through iomap so that large folios in fuse can
have granular large folio dirty tracking. This has no effect on
functionality until fuse's writepages callback also calls into iomap.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/Kconfig |   1 +
 fs/fuse/file.c  | 141 ++++++++++++++++++------------------------------
 2 files changed, 53 insertions(+), 89 deletions(-)

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
index 3d0b33be3824..a0118b501880 100644
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
 
@@ -834,13 +837,25 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
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
 
+static int fuse_iomap_read_folio_sync(loff_t block_start, struct folio *folio,
+				       size_t off, size_t len, const struct iomap *iomap,
+				       void *private)
+{
+	struct file *file = private;
+
+	return fuse_do_readfolio(file, folio, off, len);
+}
+
 static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 			       int err)
 {
@@ -1375,6 +1390,25 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
 	}
 }
 
+static const struct iomap_folio_ops fuse_iomap_folio_ops = {
+	.read_folio_sync = fuse_iomap_read_folio_sync,
+};
+
+static int fuse_write_iomap_begin(struct inode *inode, loff_t offset,
+				  loff_t length, unsigned int flags,
+				  struct iomap *iomap, struct iomap *srcmap)
+{
+	iomap->type = IOMAP_IN_MEM;
+	iomap->folio_ops = &fuse_iomap_folio_ops;
+	iomap->length = length;
+	iomap->offset = offset;
+	return 0;
+}
+
+static const struct iomap_ops fuse_write_iomap_ops = {
+	.iomap_begin	= fuse_write_iomap_begin,
+};
+
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -1384,6 +1418,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = mapping->host;
 	ssize_t err, count;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	bool writeback = false;
 
 	if (fc->writeback_cache) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
@@ -1397,8 +1432,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 						file_inode(file))) {
 			goto writethrough;
 		}
-
-		return generic_file_write_iter(iocb, from);
+		writeback = true;
 	}
 
 writethrough:
@@ -1420,6 +1454,13 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 		written = direct_write_fallback(iocb, from, written,
 				fuse_perform_write(iocb, from));
+	} else if (writeback) {
+		/*
+		 * Use iomap so that we get granular dirty tracking for
+		 * writing back large folios.
+		 */
+		written = iomap_file_buffered_write(iocb, from,
+						    &fuse_write_iomap_ops, file);
 	} else {
 		written = fuse_perform_write(iocb, from);
 	}
@@ -2209,84 +2250,6 @@ static int fuse_writepages(struct address_space *mapping,
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
@@ -3144,12 +3107,12 @@ static const struct address_space_operations fuse_file_aops  = {
 	.readahead	= fuse_readahead,
 	.writepages	= fuse_writepages,
 	.launder_folio	= fuse_launder_folio,
-	.dirty_folio	= filemap_dirty_folio,
+	.dirty_folio	= iomap_dirty_folio,
+	.release_folio	= iomap_release_folio,
+	.invalidate_folio = iomap_invalidate_folio,
 	.migrate_folio	= filemap_migrate_folio,
 	.bmap		= fuse_bmap,
 	.direct_IO	= fuse_direct_IO,
-	.write_begin	= fuse_write_begin,
-	.write_end	= fuse_write_end,
 };
 
 void fuse_init_file_inode(struct inode *inode, unsigned int flags)
-- 
2.47.1


