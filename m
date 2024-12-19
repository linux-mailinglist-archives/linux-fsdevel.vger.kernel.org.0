Return-Path: <linux-fsdevel+bounces-37848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3CE9F8242
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12857165148
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56121BD03C;
	Thu, 19 Dec 2024 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wy6K32/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C66E1AA1D9;
	Thu, 19 Dec 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630021; cv=none; b=VDjOaj998snGBxYMv13lMXb8DUg0a1CK0DhH0iBRktpgJ1C+xyV66wVo8dsta4ACTRwy+eyav63qdLEUdA6ltCW6RrJn/UxuOowGLwNS/CpXLp35r180YuS+xHE1BfKM538BAyL6Uu4xiQk+CaN3RwxHiPrXLfC66Hye33hQ0sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630021; c=relaxed/simple;
	bh=bSxsjyWv5EBIspCbBOoKXPT4ILvJV/VtesVxnYyiztY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGOmeJiyF2PJDp8t3HAONZPEmoPGl6jI4JSKR8bbo4MYo9qEikwjDhVTsjJ1zbnTyWG7Ojel2MKN5KO90/ZDSW+U/rcwJxbYkciaeX4U7rXcXb7pWYThXKEnNYyW/tqVnnGP59arLkt394L5z4nlrsJvW1lhRqU6p4rkY8JgrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wy6K32/s; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=w2ruTtNSlWi9KccNpydesy0r5ikaJVjJu1jtpauYKzk=; b=Wy6K32/sxM4tEc1IOM3zTq5TAv
	TPnnpWjlwWxU2hjnHknP1rkGVKlnb2RHGQXoJtSvQUOz4khtvlbX2qpPf+LwuLvRUOwO0n4eVQll8
	Q086s4HiKefSpwQ5cj0PuPUhcAxQV2MHz7o2ghKH6cCnbTsav9jeMI5DnB0nsANoCz4+LBcTkGyNJ
	l2wJh7dM16c6V7cOhv7s+WzPTPI7G8n7t8irb8WT+lb95MICKsXnJ7kPr0WH09PW6R1PJtJecSkpW
	QvPuG/48qf+wP9zhR5eVB3JBAgwdMwuRKx9yBNN5csIW/scOkN4koHoc5y5xqHYbyZx/PoBScguaP
	XFlEmZAg==;
Received: from [2001:4bb8:2ae:97bf:7b0d:9cbd:e369:c821] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOKVW-00000002axp-2ss8;
	Thu, 19 Dec 2024 17:40:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/10] iomap: move common ioend code to ioend.c
Date: Thu, 19 Dec 2024 17:39:10 +0000
Message-ID: <20241219173954.22546-6-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241219173954.22546-1-hch@lst.de>
References: <20241219173954.22546-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This code will be reused for direct I/O soon, so split it out of
buffered-io.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 135 +----------------------------------------
 fs/iomap/internal.h    |   9 +++
 fs/iomap/ioend.c       | 127 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 133 deletions(-)
 create mode 100644 fs/iomap/internal.h

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0b68c9584a7f..06b90d859d74 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -12,17 +12,15 @@
 #include <linux/buffer_head.h>
 #include <linux/dax.h>
 #include <linux/writeback.h>
-#include <linux/list_sort.h>
 #include <linux/swap.h>
 #include <linux/bio.h>
 #include <linux/sched/signal.h>
 #include <linux/migrate.h>
+#include "internal.h"
 #include "trace.h"
 
 #include "../internal.h"
 
-#define IOEND_BATCH_SIZE	4096
-
 /*
  * Structure allocated for each folio to track per-block uptodate, dirty state
  * and I/O completions.
@@ -40,9 +38,6 @@ struct iomap_folio_state {
 	unsigned long		state[];
 };
 
-struct bio_set iomap_ioend_bioset;
-EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
-
 static inline bool ifs_is_fully_uptodate(struct folio *folio,
 		struct iomap_folio_state *ifs)
 {
@@ -1539,8 +1534,7 @@ static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
  * state, release holds on bios, and finally free up memory.  Do not use the
  * ioend after this.
  */
-static u32
-iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
+u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
 {
 	struct inode *inode = ioend->io_inode;
 	struct bio *bio = &ioend->io_bio;
@@ -1567,123 +1561,6 @@ iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
 	return folio_count;
 }
 
-static u32
-iomap_finish_ioend(struct iomap_ioend *ioend, int error)
-{
-	if (ioend->io_parent) {
-		struct bio *bio = &ioend->io_bio;
-
-		ioend = ioend->io_parent;
-		bio_put(bio);
-	}
-
-	if (error)
-		cmpxchg(&ioend->io_error, 0, error);
-
-	if (!atomic_dec_and_test(&ioend->io_remaining))
-		return 0;
-	return iomap_finish_ioend_buffered(ioend);
-}
-
-/*
- * Ioend completion routine for merged bios. This can only be called from task
- * contexts as merged ioends can be of unbound length. Hence we have to break up
- * the writeback completions into manageable chunks to avoid long scheduler
- * holdoffs. We aim to keep scheduler holdoffs down below 10ms so that we get
- * good batch processing throughput without creating adverse scheduler latency
- * conditions.
- */
-void
-iomap_finish_ioends(struct iomap_ioend *ioend, int error)
-{
-	struct list_head tmp;
-	u32 completions;
-
-	might_sleep();
-
-	list_replace_init(&ioend->io_list, &tmp);
-	completions = iomap_finish_ioend(ioend, error);
-
-	while (!list_empty(&tmp)) {
-		if (completions > IOEND_BATCH_SIZE * 8) {
-			cond_resched();
-			completions = 0;
-		}
-		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
-		list_del_init(&ioend->io_list);
-		completions += iomap_finish_ioend(ioend, error);
-	}
-}
-EXPORT_SYMBOL_GPL(iomap_finish_ioends);
-
-/*
- * We can merge two adjacent ioends if they have the same set of work to do.
- */
-static bool
-iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
-{
-	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
-		return false;
-	if (next->io_flags & IOMAP_IOEND_BOUNDARY)
-		return false;
-	if ((ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
-	    (next->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
-		return false;
-	if (ioend->io_offset + ioend->io_size != next->io_offset)
-		return false;
-	/*
-	 * Do not merge physically discontiguous ioends. The filesystem
-	 * completion functions will have to iterate the physical
-	 * discontiguities even if we merge the ioends at a logical level, so
-	 * we don't gain anything by merging physical discontiguities here.
-	 *
-	 * We cannot use bio->bi_iter.bi_sector here as it is modified during
-	 * submission so does not point to the start sector of the bio at
-	 * completion.
-	 */
-	if (ioend->io_sector + (ioend->io_size >> 9) != next->io_sector)
-		return false;
-	return true;
-}
-
-void
-iomap_ioend_try_merge(struct iomap_ioend *ioend, struct list_head *more_ioends)
-{
-	struct iomap_ioend *next;
-
-	INIT_LIST_HEAD(&ioend->io_list);
-
-	while ((next = list_first_entry_or_null(more_ioends, struct iomap_ioend,
-			io_list))) {
-		if (!iomap_ioend_can_merge(ioend, next))
-			break;
-		list_move_tail(&next->io_list, &ioend->io_list);
-		ioend->io_size += next->io_size;
-	}
-}
-EXPORT_SYMBOL_GPL(iomap_ioend_try_merge);
-
-static int
-iomap_ioend_compare(void *priv, const struct list_head *a,
-		const struct list_head *b)
-{
-	struct iomap_ioend *ia = container_of(a, struct iomap_ioend, io_list);
-	struct iomap_ioend *ib = container_of(b, struct iomap_ioend, io_list);
-
-	if (ia->io_offset < ib->io_offset)
-		return -1;
-	if (ia->io_offset > ib->io_offset)
-		return 1;
-	return 0;
-}
-
-void
-iomap_sort_ioends(struct list_head *ioend_list)
-{
-	list_sort(NULL, ioend_list, iomap_ioend_compare);
-}
-EXPORT_SYMBOL_GPL(iomap_sort_ioends);
-
 static void iomap_writepage_end_bio(struct bio *bio)
 {
 	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
@@ -2033,11 +1910,3 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 	return iomap_submit_ioend(wpc, error);
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
-
-static int __init iomap_buffered_init(void)
-{
-	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
-			   offsetof(struct iomap_ioend, io_bio),
-			   BIOSET_NEED_BVECS);
-}
-fs_initcall(iomap_buffered_init);
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
new file mode 100644
index 000000000000..36d5c56e073e
--- /dev/null
+++ b/fs/iomap/internal.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _IOMAP_INTERNAL_H
+#define _IOMAP_INTERNAL_H 1
+
+#define IOEND_BATCH_SIZE	4096
+
+u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
+
+#endif /* _IOMAP_INTERNAL_H */
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 1b032323ee4e..b4f6dd9e319a 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -3,6 +3,11 @@
  * Copyright (c) 2024 Christoph Hellwig.
  */
 #include <linux/iomap.h>
+#include <linux/list_sort.h>
+#include "internal.h"
+
+struct bio_set iomap_ioend_bioset;
+EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
 
 struct iomap_ioend *iomap_init_ioend(struct inode *inode,
 		struct bio *bio, loff_t file_offset, u16 ioend_flags)
@@ -22,6 +27,120 @@ struct iomap_ioend *iomap_init_ioend(struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(iomap_init_ioend);
 
+static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
+{
+	if (ioend->io_parent) {
+		struct bio *bio = &ioend->io_bio;
+
+		ioend = ioend->io_parent;
+		bio_put(bio);
+	}
+
+	if (error)
+		cmpxchg(&ioend->io_error, 0, error);
+
+	if (!atomic_dec_and_test(&ioend->io_remaining))
+		return 0;
+	return iomap_finish_ioend_buffered(ioend);
+}
+
+/*
+ * Ioend completion routine for merged bios. This can only be called from task
+ * contexts as merged ioends can be of unbound length. Hence we have to break up
+ * the writeback completions into manageable chunks to avoid long scheduler
+ * holdoffs. We aim to keep scheduler holdoffs down below 10ms so that we get
+ * good batch processing throughput without creating adverse scheduler latency
+ * conditions.
+ */
+void iomap_finish_ioends(struct iomap_ioend *ioend, int error)
+{
+	struct list_head tmp;
+	u32 completions;
+
+	might_sleep();
+
+	list_replace_init(&ioend->io_list, &tmp);
+	completions = iomap_finish_ioend(ioend, error);
+
+	while (!list_empty(&tmp)) {
+		if (completions > IOEND_BATCH_SIZE * 8) {
+			cond_resched();
+			completions = 0;
+		}
+		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
+		list_del_init(&ioend->io_list);
+		completions += iomap_finish_ioend(ioend, error);
+	}
+}
+EXPORT_SYMBOL_GPL(iomap_finish_ioends);
+
+/*
+ * We can merge two adjacent ioends if they have the same set of work to do.
+ */
+static bool iomap_ioend_can_merge(struct iomap_ioend *ioend,
+		struct iomap_ioend *next)
+{
+	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
+		return false;
+	if (next->io_flags & IOMAP_IOEND_BOUNDARY)
+		return false;
+	if ((ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
+	    (next->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
+		return false;
+	if (ioend->io_offset + ioend->io_size != next->io_offset)
+		return false;
+	/*
+	 * Do not merge physically discontiguous ioends. The filesystem
+	 * completion functions will have to iterate the physical
+	 * discontiguities even if we merge the ioends at a logical level, so
+	 * we don't gain anything by merging physical discontiguities here.
+	 *
+	 * We cannot use bio->bi_iter.bi_sector here as it is modified during
+	 * submission so does not point to the start sector of the bio at
+	 * completion.
+	 */
+	if (ioend->io_sector + (ioend->io_size >> SECTOR_SHIFT) !=
+	    next->io_sector)
+		return false;
+	return true;
+}
+
+void iomap_ioend_try_merge(struct iomap_ioend *ioend,
+		struct list_head *more_ioends)
+{
+	struct iomap_ioend *next;
+
+	INIT_LIST_HEAD(&ioend->io_list);
+
+	while ((next = list_first_entry_or_null(more_ioends, struct iomap_ioend,
+			io_list))) {
+		if (!iomap_ioend_can_merge(ioend, next))
+			break;
+		list_move_tail(&next->io_list, &ioend->io_list);
+		ioend->io_size += next->io_size;
+	}
+}
+EXPORT_SYMBOL_GPL(iomap_ioend_try_merge);
+
+static int iomap_ioend_compare(void *priv, const struct list_head *a,
+		const struct list_head *b)
+{
+	struct iomap_ioend *ia = container_of(a, struct iomap_ioend, io_list);
+	struct iomap_ioend *ib = container_of(b, struct iomap_ioend, io_list);
+
+	if (ia->io_offset < ib->io_offset)
+		return -1;
+	if (ia->io_offset > ib->io_offset)
+		return 1;
+	return 0;
+}
+
+void iomap_sort_ioends(struct list_head *ioend_list)
+{
+	list_sort(NULL, ioend_list, iomap_ioend_compare);
+}
+EXPORT_SYMBOL_GPL(iomap_sort_ioends);
+
 /*
  * Split up to the first @max_len bytes from @ioend if the ioend covers more
  * than @max_len bytes.
@@ -84,3 +203,11 @@ struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend,
 	return split_ioend;
 }
 EXPORT_SYMBOL_GPL(iomap_split_ioend);
+
+static int __init iomap_ioend_init(void)
+{
+	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
+			   offsetof(struct iomap_ioend, io_bio),
+			   BIOSET_NEED_BVECS);
+}
+fs_initcall(iomap_ioend_init);
-- 
2.45.2


