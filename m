Return-Path: <linux-fsdevel+bounces-37032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE589EC7D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 09:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAE8287B6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04DC1EC4DC;
	Wed, 11 Dec 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NLuCmfgT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518C1EC4C9;
	Wed, 11 Dec 2024 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907280; cv=none; b=qO55R2TyRUSzuWE2eKYqkk5ua1DjXafxO6atbJV9IP24uQ38GVzjlZ0py3H6vZ2mEcHC7URl7RzVbxqCR7E82yyWQvWWvGp2D2ixGAcGaYIj7RoYa3ygla+u30aYC1lTpkhB6Ev8xdj7dtc6dZdd4CnecnvkkwDN/IYiPT6TFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907280; c=relaxed/simple;
	bh=vatJ0uv/6b69REbCyF8I/dMRd8pe8Ka9EgXNo8rePB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NL0JogaaHMZWkXgPtz8qZ0FJsduOuMh+cn49Kw+TSVejzVU6myaxybCcJ8DK0+F0rPMFlbo2bb4pNiZkdgzAmcGjfoPLhE5xU1PS1WctbOfeMfHzGyh6UQmK/OAhzkcatmWBRCfExj54nC4TGKuKP/rayJYvLvxLOGmYx+XB5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NLuCmfgT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DMEc82QdH/cjdaQ5H5FzEDQHRIgmSKGOptpYBAnEp4U=; b=NLuCmfgTN8SCM/w7OOARlWdsZu
	uuqJ0wnztnyrFdiog2LLkbY1uU60M53f/YyjnZ4hPBalGUrUiMaHSmTJZxyOfqpk+9AwPM8/s5pyF
	2GEibOEMRsmJ/HKrrx2xwld9de/luNkJND8TLeVCj3mXedtouW7j/f8js4amgSdRfl0LnUnpemw8h
	lOzRJA8mTQguwY+TFnQd59F/m2J1M6CiXaV9lF/UtON6rfpyxPhY93X+tJDnsgy10COM0cVbD+3w5
	5wa3Ae2ogS3MYUtndxmntFtVqOjgPL0wqFjaUUVz8ncFsIbG7C96a2ru1mpE8tvMDlEkiX10CWnhn
	eQOT/4dw==;
Received: from [2001:4bb8:2ae:8817:935:3eb8:759c:c417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLIUP-0000000EIOu-3dda;
	Wed, 11 Dec 2024 08:54:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/8] iomap: optionally use ioends for direct I/O
Date: Wed, 11 Dec 2024 09:53:45 +0100
Message-ID: <20241211085420.1380396-6-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211085420.1380396-1-hch@lst.de>
References: <20241211085420.1380396-1-hch@lst.de>
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
---
 fs/iomap/buffered-io.c |  3 +++
 fs/iomap/direct-io.c   | 50 +++++++++++++++++++++++++++++++++++++++++-
 fs/iomap/internal.h    |  7 ++++++
 include/linux/iomap.h  |  4 +++-
 4 files changed, 62 insertions(+), 2 deletions(-)
 create mode 100644 fs/iomap/internal.h

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8125f758a99d..ceca9473a09c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -17,6 +17,7 @@
 #include <linux/bio.h>
 #include <linux/sched/signal.h>
 #include <linux/migrate.h>
+#include "internal.h"
 #include "trace.h"
 
 #include "../internal.h"
@@ -1582,6 +1583,8 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 
 	if (!atomic_dec_and_test(&ioend->io_remaining))
 		return 0;
+	if (ioend->io_flags & IOMAP_IOEND_DIRECT)
+		return iomap_finish_ioend_direct(ioend);
 	return iomap_finish_ioend_buffered(ioend);
 }
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b521eb15759e..b5466361cafe 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
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
@@ -117,7 +119,8 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	 * ->end_io() when necessary, otherwise a racing buffer read would cache
 	 * zeros from unwritten extents.
 	 */
-	if (!dio->error && dio->size && (dio->flags & IOMAP_DIO_WRITE))
+	if (!dio->error && dio->size && (dio->flags & IOMAP_DIO_WRITE) &&
+	    !(dio->flags & IOMAP_DIO_NO_INVALIDATE))
 		kiocb_invalidate_post_direct_write(iocb, dio->size);
 
 	inode_dio_end(file_inode(iocb->ki_filp));
@@ -163,6 +166,51 @@ static inline void iomap_dio_set_error(struct iomap_dio *dio, int ret)
 	cmpxchg(&dio->error, 0, ret);
 }
 
+u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
+{
+	struct iomap_dio *dio = ioend->io_bio.bi_private;
+	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
+	struct kiocb *iocb = dio->iocb;
+	u32 vec_count = ioend->io_bio.bi_vcnt;
+
+	if (ioend->io_error)
+		iomap_dio_set_error(dio, ioend->io_error);
+
+	if (atomic_dec_and_test(&dio->ref)) {
+		struct inode *inode = file_inode(iocb->ki_filp);
+
+		if (dio->wait_for_completion) {
+			struct task_struct *waiter = dio->submit.waiter;
+
+			WRITE_ONCE(dio->submit.waiter, NULL);
+			blk_wake_io_task(waiter);
+		} else if (!inode->i_mapping->nrpages) {
+			WRITE_ONCE(iocb->private, NULL);
+
+			/*
+			 * We must never invalidate pages from this thread to
+			 * avoid deadlocks with buffered I/O completions.
+			 * Tough luck if you hit the tiny race with someone
+			 * dirtying the range now.
+			 */
+			dio->flags |= IOMAP_DIO_NO_INVALIDATE;
+			iomap_dio_complete_work(&dio->aio.work);
+		} else {
+			INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
+			queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
+		}
+	}
+
+	if (should_dirty) {
+		bio_check_pages_dirty(&ioend->io_bio);
+	} else {
+		bio_release_pages(&ioend->io_bio, false);
+		bio_put(&ioend->io_bio);
+	}
+
+	return vec_count;
+}
+
 void iomap_dio_bio_end_io(struct bio *bio)
 {
 	struct iomap_dio *dio = bio->bi_private;
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
new file mode 100644
index 000000000000..20cccfc3bb13
--- /dev/null
+++ b/fs/iomap/internal.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _IOMAP_INTERNAL_H
+#define _IOMAP_INTERNAL_H 1
+
+u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
+
+#endif /* _IOMAP_INTERNAL_H */
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index eaa8cb9083eb..f6943c80e5fd 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -343,9 +343,11 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 #define IOMAP_IOEND_UNWRITTEN		(1U << 1)
 /* don't merge into previous ioend */
 #define IOMAP_IOEND_BOUNDARY		(1U << 2)
+/* is direct I/O */
+#define IOMAP_IOEND_DIRECT		(1U << 3)
 
 #define IOMAP_IOEND_NOMERGE_FLAGS \
-	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN)
+	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT)
 
 /*
  * Structure for writeback I/O completions.
-- 
2.45.2


