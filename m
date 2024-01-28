Return-Path: <linux-fsdevel+bounces-9243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9774283F5DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 15:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58001C225C1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC03A28DD2;
	Sun, 28 Jan 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abnp7UAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB424B41
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706452000; cv=none; b=h2yPnRMI3EoMvnSFryf3GfUQ25raqkfw4ouTahvKtuI3OQBzk1TKuBTwbMTz1NNwUe/mt3z8kG4Wx7+81djKTUz7RUN+DWQYevptYn9sw9g5oML/v8mfI8j4W/WFZLC9gwlVD6SpjaJhU4DErwENNQpRSB0fIwk41o6CrwQ9IM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706452000; c=relaxed/simple;
	bh=ap3jE6eJ5LumWLiuT4HUPdO0BOsdnouZYWjxGdamNxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3+LW17sAc/koR4RsaJEu+JiYp9WZCjVv6ACdmV0+xVFBtSLz3r6KfDg6nh/BT4Yhzmp1OybXHZ4NolN9P0rAbwp8AfQJXakJnmvTwquJX+5w6ZflZTK3G3pldsWB/Z3AzIhjxueYonjKspVTn2e82Pg93i6CsdaZueDMmZfPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=abnp7UAm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706451997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+CMzCSV2vzJC7cGxMUfn3KLiYWQWO3h35bY6GJWrDzU=;
	b=abnp7UAmSqfT3FWQqcwPFDQyPllBjZHehcTPQqGox4kwGRqWWvmGarHUr22zVXODluKeSB
	2ZBh0d2cHgyjQM7fCTsV2OpOZkYXfMN/vwFPR+fvdtpSRkBDeV7KSB0WJe8edRnh5QlTYr
	SIPJozI7F+A9tKeaDD8fpCfndlzrUek=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-cTWLHBBcPtCk_Sstyzs8Mg-1; Sun,
 28 Jan 2024 09:26:32 -0500
X-MC-Unique: cTWLHBBcPtCk_Sstyzs8Mg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5176229AB411;
	Sun, 28 Jan 2024 14:26:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7FBCB1C060AF;
	Sun, 28 Jan 2024 14:26:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [RFC PATCH] mm/readahead: readahead aggressively if read drops in willneed range
Date: Sun, 28 Jan 2024 22:25:22 +0800
Message-ID: <20240128142522.1524741-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Since commit 6d2be915e589 ("mm/readahead.c: fix readahead failure for
memoryless NUMA nodes and limit readahead max_pages"), ADV_WILLNEED
only tries to readahead 512 pages, and the remained part in the advised
range fallback on normal readahead.

If bdi->ra_pages is set as small, readahead will perform not efficient
enough. Increasing read ahead may not be an option since workload may
have mixed random and sequential I/O.

Improve this situation by maintaining one willneed range maple tree, if
read drops in any willneed range, readahead aggressively just like
what we did before commit 6d2be915e589.

Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Don Dutile <ddutile@redhat.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/file_table.c    | 10 ++++++++++
 include/linux/fs.h | 15 +++++++++++++++
 mm/filemap.c       |  5 ++++-
 mm/internal.h      |  7 ++++++-
 mm/readahead.c     | 32 +++++++++++++++++++++++++++++++-
 5 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index b991f90571b4..bb0303683305 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -61,8 +61,18 @@ struct path *backing_file_user_path(struct file *f)
 }
 EXPORT_SYMBOL_GPL(backing_file_user_path);
 
+static inline void file_ra_free(struct file_ra_state *ra)
+{
+	if (ra->need_mt) {
+		mtree_destroy(ra->need_mt);
+		kfree(ra->need_mt);
+		ra->need_mt = NULL;
+	}
+}
+
 static inline void file_free(struct file *f)
 {
+	file_ra_free(&f->f_ra);
 	security_file_free(f);
 	if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
 		percpu_counter_dec(&nr_files);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..bdbd16990072 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -43,6 +43,7 @@
 #include <linux/cred.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
+#include <linux/maple_tree.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -961,6 +962,7 @@ struct fown_struct {
  * @ra_pages: Maximum size of a readahead request, copied from the bdi.
  * @mmap_miss: How many mmap accesses missed in the page cache.
  * @prev_pos: The last byte in the most recent read request.
+ * @need_mt: maple tree for tracking WILL_NEED ranges
  *
  * When this structure is passed to ->readahead(), the "most recent"
  * readahead means the current readahead.
@@ -972,6 +974,7 @@ struct file_ra_state {
 	unsigned int ra_pages;
 	unsigned int mmap_miss;
 	loff_t prev_pos;
+	struct maple_tree *need_mt;
 };
 
 /*
@@ -983,6 +986,18 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
 		index <  ra->start + ra->size);
 }
 
+/*
+ * Check if @index falls in the madvise/fadvise WILLNEED window.
+ */
+static inline bool ra_index_in_need_range(struct file_ra_state *ra,
+		pgoff_t index)
+{
+	if (ra->need_mt)
+		return mtree_load(ra->need_mt, index) != NULL;
+
+	return false;
+}
+
 /*
  * f_{lock,count,pos_lock} members can be highly contended and share
  * the same cacheline. f_{lock,mode} are very frequently used together
diff --git a/mm/filemap.c b/mm/filemap.c
index 750e779c23db..0ffe63d58421 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3147,7 +3147,10 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
-	ra->size = ra->ra_pages;
+	if (ra_index_in_need_range(ra, vmf->pgoff))
+		ra->size = inode_to_bdi(mapping->host)->io_pages;
+	else
+		ra->size = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
 	ractl._index = ra->start;
 	page_cache_ra_order(&ractl, ra, 0);
diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..17bd970ff23c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -120,13 +120,18 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
+void file_ra_add_need_range(struct file_ra_state *ra, pgoff_t start,
+		pgoff_t end);
 void page_cache_ra_order(struct readahead_control *, struct file_ra_state *,
 		unsigned int order);
 void force_page_cache_ra(struct readahead_control *, unsigned long nr);
 static inline void force_page_cache_readahead(struct address_space *mapping,
 		struct file *file, pgoff_t index, unsigned long nr_to_read)
 {
-	DEFINE_READAHEAD(ractl, file, &file->f_ra, mapping, index);
+	struct file_ra_state *ra = &file->f_ra;
+	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
+
+	file_ra_add_need_range(ra, index, index + nr_to_read);
 	force_page_cache_ra(&ractl, nr_to_read);
 }
 
diff --git a/mm/readahead.c b/mm/readahead.c
index 23620c57c122..0882ceecf9ff 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -140,9 +140,38 @@ file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 {
 	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
 	ra->prev_pos = -1;
+	ra->need_mt = NULL;
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
 
+static void file_ra_setup_need_mt(struct file_ra_state *ra)
+{
+	struct maple_tree *mt = kzalloc(sizeof(*mt), GFP_KERNEL);
+
+	if (!mt)
+		return;
+
+	mt_init(mt);
+	if (cmpxchg(&ra->need_mt, NULL, mt) != NULL)
+		kfree(mt);
+}
+
+/* Maintain one willneed range hint for speedup readahead */
+void file_ra_add_need_range(struct file_ra_state *ra, pgoff_t start,
+		pgoff_t end)
+{
+	/* ignore small willneed range */
+	if (end - start < 4 * ra->ra_pages)
+		return;
+
+	if (!ra->need_mt)
+		file_ra_setup_need_mt(ra);
+
+	if (ra->need_mt)
+		mtree_insert_range(ra->need_mt, start, end, (void *)1,
+				GFP_KERNEL);
+}
+
 static void read_pages(struct readahead_control *rac)
 {
 	const struct address_space_operations *aops = rac->mapping->a_ops;
@@ -552,9 +581,10 @@ static void ondemand_readahead(struct readahead_control *ractl,
 {
 	struct backing_dev_info *bdi = inode_to_bdi(ractl->mapping->host);
 	struct file_ra_state *ra = ractl->ra;
-	unsigned long max_pages = ra->ra_pages;
 	unsigned long add_pages;
 	pgoff_t index = readahead_index(ractl);
+	unsigned long max_pages = ra_index_in_need_range(ra, index) ?
+		bdi->io_pages : ra->ra_pages;
 	pgoff_t expected, prev_index;
 	unsigned int order = folio ? folio_order(folio) : 0;
 
-- 
2.41.0


