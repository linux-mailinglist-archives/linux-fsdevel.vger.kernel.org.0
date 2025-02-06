Return-Path: <linux-fsdevel+bounces-41032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E149A2A11B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D60B1888E93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41531224B1B;
	Thu,  6 Feb 2025 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ETLkkQkH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65C22489A;
	Thu,  6 Feb 2025 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824055; cv=none; b=nmcj1BDyuMt4FaSGCJyrQnEo3RvvpKC3vEmM1tY50f+ol0haUkq1NTex1PBjvTJZbkq/stWaudXPBJnxtjZSMd96mF+6lZiZ5WPpv9MLVlMEiYS20BnP+kBIHeZHzwiqzINH+9Oi+xXMKSdYW2i6Yz+PRiuo42J9NZD4xuVNjBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824055; c=relaxed/simple;
	bh=Xs7LzhP29xagLoOTFjy0J/eae4xwhRSO/+ZbNbfj1AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdt5IXl5Jj9ktOPjEAs/rminM4cl2cWYKvNtcaOZXfhRknKOaVWx3RSEe3uuq3OgeWkETatRjUuafKb1JrXxPKDLivGkNhLOeaPqcLNQZpNwFQExzx9hwVTznWe9Rjl4krWgjYTBT1giPrVX5i9iTN5OyzyxI/HHrFF9XwGOrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ETLkkQkH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=54P5sXtDl07w5LZhT9q0INZgUyx19HehDRfqriIhTOo=; b=ETLkkQkHpPRHa6jjd96n65LD3O
	qRCXkf2CsUItpBtDay/X/XBYRkOAfUHLhXwih6Cvx+aPNnrRkQa90FuwY7WF2eZIn854/dv817MQA
	U4n7cZgsqDylGpoEcVDNTKykBoLXQzd1mRJsWuqjgVlh8SXyxlUPFJuW6xPV/9OA0MZOuRkOnIjmh
	bPY5Gqzx6he2aPvMhcBcGxCHHiwE2J4Fb+EugB4malrjKF1sUuw84A9qnbuZCR90gcgXiSQEOvMKx
	drzY13d00fuBE85bSlF3rMoxjt4CkYMPmAxq6cIbwh6c4SbG8aQxNSsA1KtxMtjrM225ztdGK8EyP
	Cmr8NWhg==;
Received: from 2a02-8389-2341-5b80-9d5d-e9d2-4927-2bd6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9d5d:e9d2:4927:2bd6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfvZF-00000005PVi-1xMI;
	Thu, 06 Feb 2025 06:40:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/11] iomap: optionally use ioends for direct I/O
Date: Thu,  6 Feb 2025 07:40:05 +0100
Message-ID: <20250206064035.2323428-8-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206064035.2323428-1-hch@lst.de>
References: <20250206064035.2323428-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

struct iomap_ioend currently tracks outstanding buffered writes and has
some really nice code in core iomap and XFS to merge contiguous I/Os
an defer them to userspace for completion in a very efficient way.

For zoned writes we'll also need a per-bio user context completion to
record the written blocks, and the infrastructure for that would look
basically like the ioend handling for buffered I/O.

So instead of reinventing the wheel, reuse the existing infrastructure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/direct-io.c  | 48 +++++++++++++++++++++++++++++++++++++++++--
 fs/iomap/internal.h   |  1 +
 fs/iomap/ioend.c      |  2 ++
 include/linux/iomap.h | 10 +++++----
 4 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 277ece243770..138d246ec29d 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2010 Red Hat, Inc.
- * Copyright (c) 2016-2021 Christoph Hellwig.
+ * Copyright (c) 2016-2025 Christoph Hellwig.
  */
 #include <linux/module.h>
 #include <linux/compiler.h>
@@ -12,6 +12,7 @@
 #include <linux/backing-dev.h>
 #include <linux/uio.h>
 #include <linux/task_io_accounting_ops.h>
+#include "internal.h"
 #include "trace.h"
 
 #include "../internal.h"
@@ -20,6 +21,7 @@
  * Private flags for iomap_dio, must not overlap with the public ones in
  * iomap.h:
  */
+#define IOMAP_DIO_NO_INVALIDATE	(1U << 25)
 #define IOMAP_DIO_CALLER_COMP	(1U << 26)
 #define IOMAP_DIO_INLINE_COMP	(1U << 27)
 #define IOMAP_DIO_WRITE_THROUGH	(1U << 28)
@@ -119,7 +121,8 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	 * ->end_io() when necessary, otherwise a racing buffer read would cache
 	 * zeros from unwritten extents.
 	 */
-	if (!dio->error && dio->size && (dio->flags & IOMAP_DIO_WRITE))
+	if (!dio->error && dio->size && (dio->flags & IOMAP_DIO_WRITE) &&
+	    !(dio->flags & IOMAP_DIO_NO_INVALIDATE))
 		kiocb_invalidate_post_direct_write(iocb, dio->size);
 
 	inode_dio_end(file_inode(iocb->ki_filp));
@@ -241,6 +244,47 @@ void iomap_dio_bio_end_io(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
 
+u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
+{
+	struct iomap_dio *dio = ioend->io_bio.bi_private;
+	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
+	u32 vec_count = ioend->io_bio.bi_vcnt;
+
+	if (ioend->io_error)
+		iomap_dio_set_error(dio, ioend->io_error);
+
+	if (atomic_dec_and_test(&dio->ref)) {
+		/*
+		 * Try to avoid another context switch for the completion given
+		 * that we are already called from the ioend completion
+		 * workqueue, but never invalidate pages from this thread to
+		 * avoid deadlocks with buffered I/O completions.  Tough luck if
+		 * you hit the tiny race with someone dirtying the range now
+		 * between this check and the actual completion.
+		 */
+		if (!dio->iocb->ki_filp->f_mapping->nrpages) {
+			dio->flags |= IOMAP_DIO_INLINE_COMP;
+			dio->flags |= IOMAP_DIO_NO_INVALIDATE;
+		}
+		dio->flags &= ~IOMAP_DIO_CALLER_COMP;
+		iomap_dio_done(dio);
+	}
+
+	if (should_dirty) {
+		bio_check_pages_dirty(&ioend->io_bio);
+	} else {
+		bio_release_pages(&ioend->io_bio, false);
+		bio_put(&ioend->io_bio);
+	}
+
+	/*
+	 * Return the number of bvecs completed as even direct I/O completions
+	 * do significant per-folio work and we'll still want to give up the
+	 * CPU after a lot of completions.
+	 */
+	return vec_count;
+}
+
 static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		loff_t pos, unsigned len)
 {
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index 36d5c56e073e..f6992a3bf66a 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -5,5 +5,6 @@
 #define IOEND_BATCH_SIZE	4096
 
 u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
+u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
 
 #endif /* _IOMAP_INTERNAL_H */
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 97d43c50cdf7..44f254ecab55 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -41,6 +41,8 @@ static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 
 	if (!atomic_dec_and_test(&ioend->io_remaining))
 		return 0;
+	if (ioend->io_flags & IOMAP_IOEND_DIRECT)
+		return iomap_finish_ioend_direct(ioend);
 	return iomap_finish_ioend_buffered(ioend);
 }
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 90c27875e39d..5768b9f2a1cc 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -343,20 +343,22 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 #define IOMAP_IOEND_UNWRITTEN		(1U << 1)
 /* don't merge into previous ioend */
 #define IOMAP_IOEND_BOUNDARY		(1U << 2)
+/* is direct I/O */
+#define IOMAP_IOEND_DIRECT		(1U << 3)
 
 /*
  * Flags that if set on either ioend prevent the merge of two ioends.
  * (IOMAP_IOEND_BOUNDARY also prevents merges, but only one-way)
  */
 #define IOMAP_IOEND_NOMERGE_FLAGS \
-	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN)
+	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT)
 
 /*
  * Structure for writeback I/O completions.
  *
- * File systems implementing ->submit_ioend can split a bio generated
- * by iomap.  In that case the parent ioend it was split from is recorded
- * in ioend->io_parent.
+ * File systems implementing ->submit_ioend (for buffered I/O) or ->submit_io
+ * for direct I/O) can split a bio generated by iomap.  In that case the parent
+ * ioend it was split from is recorded in ioend->io_parent.
  */
 struct iomap_ioend {
 	struct list_head	io_list;	/* next ioend in chain */
-- 
2.45.2


