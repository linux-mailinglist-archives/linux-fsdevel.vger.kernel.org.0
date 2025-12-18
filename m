Return-Path: <linux-fsdevel+bounces-71593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C23CCA0B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 03:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FD01303CF59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 02:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92722773DE;
	Thu, 18 Dec 2025 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXT7W9E+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1571D5CD4;
	Thu, 18 Dec 2025 02:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766023408; cv=none; b=daHrpq4Ds9oRAA43FrWt666pJSDIz2rKynk5bn3xNgg8ls8Dm1u+IWtILeEemIIQ3IgiTusSZFkE3OktVsG7SnhDswI47Pf6BqNWs7gSaNmrwGDLOkdgdojjVBJtIk4Th+ql6nvEKk1l1L6VJZVpAOM1m7xjnYvugBtZDg+14jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766023408; c=relaxed/simple;
	bh=2XRlAB49UzqjcxkORAbh3UUECqetpaS5BuyfrKKs1gs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dANkNzY/fvCVRAIs0N1tsmAzyf4yuMPnd5bg6uKrZ5PsaPoVe4KqspVUexX/8A1P3qAjP3SPu6jrOcVIia+F8QOoLvisTLUdVJiDGshebp0BdOYbv7s0by8wjnn/xxTQOqCQzwoRFAwh8ozGcmUncFTYs/gIC2JMGbnx/zBC1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXT7W9E+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB0BC4CEF5;
	Thu, 18 Dec 2025 02:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766023407;
	bh=2XRlAB49UzqjcxkORAbh3UUECqetpaS5BuyfrKKs1gs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gXT7W9E+4/GyKacsIq2XtoVDYS7RwhRg8VhmwRIXs3R5yG97vlaph+8oQuYhVhLFb
	 Jlwdiuu9LCfFtG7Y+Bz10oyxCIAU3AEj7XYLmPVCp4TAU1m8/0idAOZ1PsAnEYmARo
	 2/oiaksQ/MI6YuVx76sj7LqyHTjlp07j78+KovI1esPPnT+yLkocC2Mq/jT1TF2Gnw
	 BWhXpyaxhmz3Zu+KnCiVAQt7evKPcdGBQSS+ReMeBulPUMsygIqEkaMkPuilFPJhCu
	 +WusczdQmulbnHme0GEctuw3AaSH30DYH+mowL568KHSuh6BNvDgoTZGIbmctim9ys
	 j01D9lJ9smW0A==
Date: Wed, 17 Dec 2025 18:03:27 -0800
Subject: [PATCH 3/6] iomap: report file I/O errors to the VFS
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-ext4@vger.kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gabriel@krisman.be, hch@lst.de,
 amir73il@gmail.com
Message-ID: <176602332192.686273.7145566076281990940.stgit@frogsfrogsfrogs>
In-Reply-To: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Wire up iomap so that it reports all file read and write errors to the
VFS (and hence fsnotify) via the new fserror mechanism.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c |   23 ++++++++++++++++++++++-
 fs/iomap/direct-io.c   |   12 ++++++++++++
 fs/iomap/ioend.c       |    6 ++++++
 3 files changed, 40 insertions(+), 1 deletion(-)


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e5c1ca440d93bd..b21e989b9fa5e6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -8,6 +8,7 @@
 #include <linux/writeback.h>
 #include <linux/swap.h>
 #include <linux/migrate.h>
+#include <linux/fserror.h>
 #include "internal.h"
 #include "trace.h"
 
@@ -371,8 +372,11 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (folio_test_uptodate(folio))
 		return 0;
 
-	if (WARN_ON_ONCE(size > iomap->length))
+	if (WARN_ON_ONCE(size > iomap->length)) {
+		fserror_report_io(iter->inode, FSERR_BUFFERED_READ,
+				  iomap->offset, size, -EIO, GFP_NOFS);
 		return -EIO;
+	}
 	if (offset > 0)
 		ifs_alloc(iter->inode, folio, iter->flags);
 
@@ -399,6 +403,11 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
+	if (error)
+		fserror_report_io(folio->mapping->host, FSERR_BUFFERED_READ,
+				  folio_pos(folio) + off, len, error,
+				  GFP_ATOMIC);
+
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
@@ -540,6 +549,10 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			if (!*bytes_submitted)
 				iomap_read_init(folio);
 			ret = ctx->ops->read_folio_range(iter, ctx, plen);
+			if (ret < 0)
+				fserror_report_io(iter->inode,
+						  FSERR_BUFFERED_READ, pos,
+						  plen, ret, GFP_NOFS);
 			if (ret)
 				return ret;
 			*bytes_submitted += plen;
@@ -815,6 +828,10 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 			else
 				status = iomap_bio_read_folio_range_sync(iter,
 						folio, block_start, plen);
+			if (status < 0)
+				fserror_report_io(iter->inode,
+						  FSERR_BUFFERED_READ, pos,
+						  len, status, GFP_NOFS);
 			if (status)
 				return status;
 		}
@@ -1805,6 +1822,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
+	loff_t orig_pos = pos;
 	size_t bytes_submitted = 0;
 	int error = 0;
 	u32 rlen;
@@ -1848,6 +1866,9 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 
 	if (bytes_submitted)
 		wpc->nr_folios++;
+	if (error && pos > orig_pos)
+		fserror_report_io(inode, FSERR_BUFFERED_WRITE, orig_pos, 0,
+				  error, GFP_NOFS);
 
 	/*
 	 * We can have dirty bits set past end of file in page_mkwrite path
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8e273408453a9c..a06c73eaa8901b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -7,6 +7,7 @@
 #include <linux/pagemap.h>
 #include <linux/iomap.h>
 #include <linux/task_io_accounting_ops.h>
+#include <linux/fserror.h>
 #include "internal.h"
 #include "trace.h"
 
@@ -78,6 +79,13 @@ static void iomap_dio_submit_bio(const struct iomap_iter *iter,
 	}
 }
 
+static inline enum fserror_type iomap_dio_err_type(const struct iomap_dio *dio)
+{
+	if (dio->flags & IOMAP_DIO_WRITE)
+		return FSERR_DIRECTIO_WRITE;
+	return FSERR_DIRECTIO_READ;
+}
+
 ssize_t iomap_dio_complete(struct iomap_dio *dio)
 {
 	const struct iomap_dio_ops *dops = dio->dops;
@@ -87,6 +95,10 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 
 	if (dops && dops->end_io)
 		ret = dops->end_io(iocb, dio->size, ret, dio->flags);
+	if (dio->error)
+		fserror_report_io(file_inode(iocb->ki_filp),
+				  iomap_dio_err_type(dio), offset, dio->size,
+				  dio->error, GFP_NOFS);
 
 	if (likely(!ret)) {
 		ret = dio->size;
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 86f44922ed3b6a..5b27ee98896707 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -6,6 +6,7 @@
 #include <linux/list_sort.h>
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
+#include <linux/fserror.h>
 #include "internal.h"
 #include "trace.h"
 
@@ -55,6 +56,11 @@ static u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
 
 	/* walk all folios in bio, ending page IO on them */
 	bio_for_each_folio_all(fi, bio) {
+		if (ioend->io_error)
+			fserror_report_io(inode, FSERR_BUFFERED_WRITE,
+					  folio_pos(fi.folio) + fi.offset,
+					  fi.length, ioend->io_error,
+					  GFP_ATOMIC);
 		iomap_finish_folio_write(inode, fi.folio, fi.length);
 		folio_count++;
 	}


