Return-Path: <linux-fsdevel+bounces-51634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C8FAD97C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5511BC2DF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D154A28F50F;
	Fri, 13 Jun 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn92n6RD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0628ECE1;
	Fri, 13 Jun 2025 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851472; cv=none; b=azkkccZkLIAEe15buwvc0hVL7DTaLrt3gPbvB30kXGnln+Hjdjjieg+Gm+SrsNwvampx2iVj0jaHqncDpjx7KvucXqZ8BBUeA7CM1IGnUyNXTZOef2ViPMpg8i68JdmCBDW1pTXU1HPQ4QEv4HPDKrDME9yKOpRuTcQJHFXcR0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851472; c=relaxed/simple;
	bh=Wvs4WAz1GF+GhZ7426kI7MnISpGi6ZN9GS1cOEVDlIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUmY4chDVh+/0EQAIIe0kt8QtxEDWge9YQr+/DECsaPJYhRPFl9mI7tpLX3c+b2NgoRvybSuyXaHwx+h9tU+j4w0gBpDFWLJTLO7T/jXOIVZjfKqWM47LDQ/ZaM/oNBVsJoPuOUPsPq162UbQc1Yat5azBwACEXo77nVc31dnK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn92n6RD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3122a63201bso2589100a91.0;
        Fri, 13 Jun 2025 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851470; x=1750456270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIbeQ5LGN1UTmJQfZoPTutbV9YgqXgSIh1ljO8EelyY=;
        b=dn92n6RDG9+VJbhmfzEoeELbGqh9i3PsLJJFOIiRJ+s3ran/HZm/C9J+Zyi29K9YBn
         iKrmzX5s45aQUduGxjf7/ZnnFUnS/jCN3ZckzvbpmcA4dC3MT4Ynfrz/J3J/D2wZNf5r
         e9uDxypZMSg8SnjzSlhVSRBW7mRaNbs+zueLzxfUyoaXeoreadLWBr6wY68W8TYTjuR1
         c9q3iZ4hLQQF9ekv6htVFfrnXBSA6RgQUFgmZdeoghRFbqo09ardbshephQALHWQYaJZ
         PG4ZcfGTDdFzPxxYel4PEWuC14x1FOwU6gFg0vNBPV2LWQnWZKYtUrMR6bafZiOwn6GI
         K5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851470; x=1750456270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIbeQ5LGN1UTmJQfZoPTutbV9YgqXgSIh1ljO8EelyY=;
        b=oa5KQM9yjmP1ENsI3vD9gw94RJ0dRQZDV7e9/yvOUNPSxiBZ292koZM2Ol2IAg5RZQ
         FzGdw4ILvlYxJzMEFv4nYaQ0LoCpN/FLlxifiGSuATVEr52yUSacV9xqm0qTD2KYa1N1
         5vSYay1fhcZucHvYcxVeZfLDPfbg6yryYIKSKIJEMHEkeGyO77dFAOWFGKDyhhwyY1RH
         Og8I+xt7WH2gMm/9quQ4khdBG6ApcIIoNNrL516m8grAuz/hfzZhB92p/kUQ6XGATeGS
         Q3n6a3JNDP7/APM8Wrcv+pgIBx4FtI+4PyDSJBbbCVsmucG2gyAqrWpGAYuEACqkMihJ
         i7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGZBRFKfssBueJ6y94bt70heC/rwXa/AR1fid4jZLzhMxI7Wp+Aph7++/svjX+g4JC71/GL6+R6w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGATb/A5KHxQt0JkWSBAQJqNMXfaIEqEJGMoZlqdG+C5pXUrQx
	AIrdiShOGfmAGnv7hmeEzy7H7+Vc2SLpwuvzX/45RIraSl9G0C7DKRk8HdMf8Q==
X-Gm-Gg: ASbGnctLPA0OHBgp5rx5nFZ18p1NeH+smweVj+o1pwMQEhbbkz3nDDbsr9G4N2BcWwa
	/A1JbRO/a0yjoODmY6nhQsOvBLgDro9/9IRFeHf+6gKkRDSXAkBuwNVY1qvA9x6/wxIvEvYlPbL
	zFQS2sAYpudhltSOjYoVEC3m5fTOANfu9xKbfwuUFGhtcMFz/N8a7EczC5td5PM0nsdQX0jSqvd
	IGKLtBGKHyjVoIz+6DLxKqpfJ6f4DhcaAqz9RM35iwFKhsSvB4caR7jP3JhQ+sZvOwrzNU3LzqK
	Aglkl6FNxWncwDRWEWOU6dFQjZJXWMLtNNuBX3ck6HsOuN9WEk2Li9KldA==
X-Google-Smtp-Source: AGHT+IHLSzldLzOnKhxJVbr9XpU2aarowxp9khju3MZ/vMUM4BlSOP/R7tSkrImQvUd2iK4rv2YMlw==
X-Received: by 2002:a17:90b:540c:b0:311:e8cc:4255 with SMTP id 98e67ed59e1d1-313f1dcee61mr1393822a91.31.1749851469652;
        Fri, 13 Jun 2025 14:51:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b49a8asm3910702a91.32.2025.06.13.14.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:51:09 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 14/16] fuse: use iomap for buffered writes
Date: Fri, 13 Jun 2025 14:46:39 -0700
Message-ID: <20250613214642.2903225-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
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
folio a write is issued at pos 1 to 4097, only the first two pages are
read in and the ones after that are skipped).

iomap also has granular dirty tracking. This is useful in that when it
comes to writeback time, only the dirty portions of the large folio will
be written instead of having to write out the entire folio. For example
if there is a 1 MB large folio and only 2 bytes in it are dirty, only
the page for those  dirty bytes will be written out. Please note that
granular writeback is only done once fuse also uses iomap in writeback
(separate commit).

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
index f102afc03359..59ff1dfd755b 100644
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
+	iomap->type = IOMAP_MAPPED;
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
+		 * Use iomap so that we can do granular uptodate reads
+		 * and granular dirty tracking for large folios.
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


