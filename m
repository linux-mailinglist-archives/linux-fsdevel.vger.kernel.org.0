Return-Path: <linux-fsdevel+bounces-27445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E629618B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB5CB232A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125001D3631;
	Tue, 27 Aug 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VKFrLXuW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A441D31A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791588; cv=none; b=AWSLhJmb0gnfYrXpxbc8PgBrXEpZOEemUmZUMCaIc7rKfoo1ksayIcuNFCq/cNfGVe9aAwBdgu/C4M/kDAEny+hKbTR0pmAhm07/tneBsbwZqf+r2BcwQnCzPYi82fpBZjALKaAnpfcmKhmAnnIWfGeAYlt5T+H/rLUzS84nIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791588; c=relaxed/simple;
	bh=zFlBcsUiZJn9q1vlsEwyspUOjL14G5c8Lhb4SBpF8U8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXZSZ88vvxsZXJwCnDiuTXlp+qH//IUlZ6tX1qjiutiindqnixC7CN/43TJi2ipI0TsaBJQz72oRurxeOS+TLehzluqmxh1dHdYOy6x930q7gWD/jOxI/+HC+x83CZHmM/t8Z3SDXmDgzVKysxxZgt4y51gSHyztpgCOmndxFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VKFrLXuW; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-68518bc1407so65645287b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724791585; x=1725396385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWNvVlUDhv+Rc4ICGZzwkrwvqmFhZSdHtfp+0p4lK7k=;
        b=VKFrLXuWgbDx+Hd81Auc2COKzDXZahV9AfvgEHJwq1alO4wZ+PM87ph2rUyHRBjQm8
         hIdZMiTVzdbFrMnI6rEP9UiKfmHax04fEve4WJ+EEWYkLEsm/BKDAw13inLFBXRtVUHF
         OwPSAYKdcd5bARKA7L+d1HUrOtcCuPWGb6ObW1Vzw+iMpWp4xRbxChE7w3Q9wKaO1CwQ
         sS8QGhGKbCeu+RbzpqqBjBjbElFaaVk8W6aIR4waCQGPdKoK0bmNNN6dO1O+/PytVPOx
         Cuv7sSdOLvlulqkzcSIGOyq4TuXbCpmRoM5k1METDUShvHG407CrdOaFU/GvYGdInXxs
         7afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791585; x=1725396385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWNvVlUDhv+Rc4ICGZzwkrwvqmFhZSdHtfp+0p4lK7k=;
        b=RX8vsHVI7kqQkbiAIl09aWlPalg8bQhZljFAZB3Np6V+jkp2FvWodhtC86/qAZ11Vl
         4Zhj0IO5q7sOw2Jt/r5U2mahDNc8O77Yo8LuCoVIispNJ/mx2OVHuf99gBXMc/zU2ESc
         Huof+Q4IMdzxDzYiUS4SAL81DaN2p0ZXEXuINqyWErwmNOXUj+6NuIvea86KOSE7IC+Y
         R404vGcZQbKTtX8lnDSSQSPZnA3KCj56f8KDmD06v4IVmq9VAEpb3/8HcUdxGIRzPvIT
         y78j8OCxBI8EEKJKLE7ej8x5GwBIzKglKggIC9jwVLmj+8TeJx889fGk/xosQjdcXMfh
         NAoA==
X-Gm-Message-State: AOJu0Yz+YlMiVIdg3fqD7QvH/tP48mjjuT4ZrAQCb5jQL5DlLwUatBN6
	rtgofuZTIOhHhxrLGCCI6G2iO3NkFtEXt/Ft4VtivrqYSEfxnrjULSo+EiZg6Srely2xnbrpTAa
	Q
X-Google-Smtp-Source: AGHT+IGOYaZXg20LgJ138MCELRlyaRvtlVgk5tBYeqP6oZ4GE3YeM+8AB5nJhvdP72uFRah/XyscmA==
X-Received: by 2002:a05:690c:3248:b0:683:37a8:cd77 with SMTP id 00721157ae682-6c629250047mr126522867b3.29.1724791585357;
        Tue, 27 Aug 2024 13:46:25 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4bb7fsm59865156d6.41.2024.08.27.13.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:46:24 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com
Subject: [PATCH 06/11] fuse: use iomap for writeback cache buffered writes
Date: Tue, 27 Aug 2024 16:45:19 -0400
Message-ID: <11b0ac855816688f6ae9a6653ddb0b814a62c3bc.1724791233.git.josef@toxicpanda.com>
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

We're currently using the old ->write_begin()/->write_end() method of
doing buffered writes.  This isn't a huge deal for fuse since we
basically just want to copy the pages and move on, but the iomap
infrastructure gives us access to having huge folios.  Rework the
buffered write path when we have writeback cache to use the iomap
buffered write code, the ->get_folio() callback now handles the work
that we did in ->write_begin(), the rest of the work is handled inside
of iomap so we don't need a replacement for ->write_end.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 154 +++++++++++++++++++++----------------------------
 1 file changed, 66 insertions(+), 88 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b259d4db0ff1..c61bc4396649 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -21,6 +21,7 @@
 #include <linux/filelock.h>
 #include <linux/splice.h>
 #include <linux/task_io_accounting_ops.h>
+#include <linux/iomap.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
@@ -1419,6 +1420,63 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
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
@@ -1427,6 +1485,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = mapping->host;
 	ssize_t err, count;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	bool writethrough = (fc->writeback_cache == 0);
 
 	if (fc->writeback_cache) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
@@ -1437,14 +1496,10 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
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
@@ -1463,8 +1518,12 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
@@ -2407,85 +2466,6 @@ static int fuse_writepages(struct address_space *mapping,
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
@@ -3351,8 +3331,6 @@ static const struct address_space_operations fuse_file_aops  = {
 	.migrate_folio	= filemap_migrate_folio,
 	.bmap		= fuse_bmap,
 	.direct_IO	= fuse_direct_IO,
-	.write_begin	= fuse_write_begin,
-	.write_end	= fuse_write_end,
 };
 
 void fuse_init_file_inode(struct inode *inode, unsigned int flags)
-- 
2.43.0


