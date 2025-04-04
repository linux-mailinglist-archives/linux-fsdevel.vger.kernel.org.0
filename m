Return-Path: <linux-fsdevel+bounces-45790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C71A7C327
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 20:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24081773D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9245321A436;
	Fri,  4 Apr 2025 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbnaX8+5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4C21C171
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790501; cv=none; b=VKbhZqdeNGx12Dy7zm6utGLVeaHfldBrOcTHeNvXiF6fs0Uh8+LttMwspFyfIqGvH9mlOJMlHAVnePrzboOr7ejoLbzsTNOJRFS4UujoqOax9wnVcG7XAz++EfdAyrWOxZVJjpz60PrGZOhIR6nf40j2uAddDus3lBGwzzmZLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790501; c=relaxed/simple;
	bh=PocwMwfthKm2K2U00xXQZcA/MzoSSBw7AFBkMCKsEP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTpWT7iSlqT9zO6kVsFDEXcZFEpHf9EGyJ82D4dVHC6FnA5oh5mYMI4w51W7yF445ftBPSQO0Jmc6RZ+IMJveQdw2Wh4M583pfrGMma8d5PZ6wnXz7zEmtpKAGO5cjaAN3EuEXFEGwds+US5W9R7yscXbrcCg3Ng+MufIMylKPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbnaX8+5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240b4de12bso32739835ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 11:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743790498; x=1744395298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro6dJ4GoZF5GCiGEcpg9UJuR608idQkDGAMhopK9Xk8=;
        b=VbnaX8+5yyr97T7nQwpwboLGAO+dcNwE+koy1LDTJDZmAkVDIFzDxkvy/wQa7eVLS9
         m0KQGbeAGmn2KoX01B/c62d42opCLd2cgtBjpnymoZKOLydBonZUzsYbfH79vDAaGY+c
         RBcGeSeg24Iv6r9ZDTY/SIuocBDgH1q/bZXFccIKLKa4wfVdKEORaRB4XKtfmGnynrVs
         vEpoP4X3D4R+vhfCtbAuN7IyXBiV9XbM8U5BywX47IFfbXKvTplo63pJanT7LWNFwtUY
         OD5PDsH3vwTtOrQr+oXTirksjB7TY/BhaiglrAz6b/px4l+JKrfG3+XKdVJFymYPlCpK
         +iSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743790498; x=1744395298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ro6dJ4GoZF5GCiGEcpg9UJuR608idQkDGAMhopK9Xk8=;
        b=FDmVkvcRIZlNCXDHtR56hRME0xvvcHmGSslFluL7mV0Qc4CKYa5KiSMzg/UxEDxMqo
         0MSfGqfb3bGo/8lgm9fe3UujKkS/HcVP2XCASLP0w3K5gUbZI1TAlfjid1letvQpRRzf
         isXYsyKnKQFCnFto+EnuB6mXSQY7VPdkCl/r8YOSoRl8JHKCxMwV5d/G1LGGwFkTNm4J
         20dM3xppW2qrfeoESGxgZfRdeIuVxfZwtLGgi9Chd+X8T6kop+XPbRsb0MitMDYeea6L
         czD8/V9q6VT/He3VsPMT6lToA8KcEO3maJcShJ8p0npCL6458bNC9zkqKneQMMRaU/Ul
         j/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYMkT5cYQJXCA5rlCYr8EynZcduGG4QkM2nuIQAjr3Hxyk6BYKyC68GRtKYuBqGDdliibHUzE7v4HFDSHA@vger.kernel.org
X-Gm-Message-State: AOJu0Yyri127PhReHqLiJMV11Fjz8vGRicVrMjAHkCyFi2JGQUyw6SYQ
	GkBDHYRD37tsLmNaZg1PESa+4IxDEYD/qIfT3TdsFozpeHFRErc3
X-Gm-Gg: ASbGncuKEndNmLkicKvwfIBiOdm9S2eEwbNIk0ruwKeA7WZz55OEi0Kj79qhUnJjkD6
	rk448iipaHthnRxNXyWk3C/SgPHEEe45Wh0NOEuIIUeD26PQ5CpoYmlENrtSYfAlZ+/grQ9GHxm
	lyWjysdv9+dZGuW9w7m40SHIttrLX4BsFX56+8TMEV0BZobq+K9pHxx7Gx9gScmGtqB5dIdzj9F
	JbHGNyG59RZ6nd4iYPcrklm1NEBJyV9QP79zJyzb68tQalH8c8xKi2W40jWigc6dHi8JURkoWEo
	yl7qLuOmlpFy0Lyh6M+5SnXY7gjJtdH5J3ZsJqw=
X-Google-Smtp-Source: AGHT+IGkN0PRjt/OSbDEHn8IomnvUJ855I+Gfmi28p8+UH+Wi59dJqBErOB3hRXspe1aOB+8PEZLGw==
X-Received: by 2002:a17:902:c94e:b0:224:5a8:ba29 with SMTP id d9443c01a7336-22a8a0b38bdmr46533995ad.43.1743790497957;
        Fri, 04 Apr 2025 11:14:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785bffedsm35700125ad.63.2025.04.04.11.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 11:14:57 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	david@redhat.com,
	bernd.schubert@fastmail.fm,
	ziy@nvidia.com,
	jlayton@kernel.org,
	kernel-team@meta.com,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH v7 3/3] fuse: remove tmp folio for writebacks and internal rb tree
Date: Fri,  4 Apr 2025 11:14:43 -0700
Message-ID: <20250404181443.1363005-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404181443.1363005-1-joannelkoong@gmail.com>
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current FUSE writeback design (see commit 3be5a52b30aa
("fuse: support writable mmap")), a temp page is allocated for every
dirty page to be written back, the contents of the dirty page are copied over
to the temp page, and the temp page gets handed to the server to write back.

This is done so that writeback may be immediately cleared on the dirty page,
and this in turn is done in order to mitigate the following deadlock scenario
that may arise if reclaim waits on writeback on the dirty page to complete:
* single-threaded FUSE server is in the middle of handling a request
  that needs a memory allocation
* memory allocation triggers direct reclaim
* direct reclaim waits on a folio under writeback
* the FUSE server can't write back the folio since it's stuck in
  direct reclaim

With a recent change that added AS_WRITEBACK_INDETERMINATE and mitigates
the situations described above, FUSE writeback does not need to use
temp pages if it sets AS_WRITEBACK_INDETERMINATE on its inode mappings.

This commit sets AS_WRITEBACK_INDETERMINATE on the inode mappings
and removes the temporary pages + extra copying and the internal rb
tree.

fio benchmarks --
(using averages observed from 10 runs, throwing away outliers)

Setup:
sudo mount -t tmpfs -o size=30G tmpfs ~/tmp_mount
 ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=4 -o source=~/tmp_mount ~/fuse_mount

fio --name=writeback --ioengine=sync --rw=write --bs={1k,4k,1M} --size=2G
--numjobs=2 --ramp_time=30 --group_reporting=1 --directory=/root/fuse_mount

        bs =  1k          4k            1M
Before  351 MiB/s     1818 MiB/s     1851 MiB/s
After   341 MiB/s     2246 MiB/s     2685 MiB/s
% diff        -3%          23%         45%

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c   | 360 ++++-------------------------------------------
 fs/fuse/fuse_i.h |   3 -
 2 files changed, 28 insertions(+), 335 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 754378dd9f71..91ada0208863 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -415,89 +415,11 @@ u64 fuse_lock_owner_id(struct fuse_conn *fc, fl_owner_t id)
 
 struct fuse_writepage_args {
 	struct fuse_io_args ia;
-	struct rb_node writepages_entry;
 	struct list_head queue_entry;
-	struct fuse_writepage_args *next;
 	struct inode *inode;
 	struct fuse_sync_bucket *bucket;
 };
 
-static struct fuse_writepage_args *fuse_find_writeback(struct fuse_inode *fi,
-					    pgoff_t idx_from, pgoff_t idx_to)
-{
-	struct rb_node *n;
-
-	n = fi->writepages.rb_node;
-
-	while (n) {
-		struct fuse_writepage_args *wpa;
-		pgoff_t curr_index;
-
-		wpa = rb_entry(n, struct fuse_writepage_args, writepages_entry);
-		WARN_ON(get_fuse_inode(wpa->inode) != fi);
-		curr_index = wpa->ia.write.in.offset >> PAGE_SHIFT;
-		if (idx_from >= curr_index + wpa->ia.ap.num_folios)
-			n = n->rb_right;
-		else if (idx_to < curr_index)
-			n = n->rb_left;
-		else
-			return wpa;
-	}
-	return NULL;
-}
-
-/*
- * Check if any page in a range is under writeback
- */
-static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_from,
-				   pgoff_t idx_to)
-{
-	struct fuse_inode *fi = get_fuse_inode(inode);
-	bool found;
-
-	if (RB_EMPTY_ROOT(&fi->writepages))
-		return false;
-
-	spin_lock(&fi->lock);
-	found = fuse_find_writeback(fi, idx_from, idx_to);
-	spin_unlock(&fi->lock);
-
-	return found;
-}
-
-static inline bool fuse_page_is_writeback(struct inode *inode, pgoff_t index)
-{
-	return fuse_range_is_writeback(inode, index, index);
-}
-
-/*
- * Wait for page writeback to be completed.
- *
- * Since fuse doesn't rely on the VM writeback tracking, this has to
- * use some other means.
- */
-static void fuse_wait_on_page_writeback(struct inode *inode, pgoff_t index)
-{
-	struct fuse_inode *fi = get_fuse_inode(inode);
-
-	wait_event(fi->page_waitq, !fuse_page_is_writeback(inode, index));
-}
-
-static inline bool fuse_folio_is_writeback(struct inode *inode,
-					   struct folio *folio)
-{
-	pgoff_t last = folio_next_index(folio) - 1;
-	return fuse_range_is_writeback(inode, folio_index(folio), last);
-}
-
-static void fuse_wait_on_folio_writeback(struct inode *inode,
-					 struct folio *folio)
-{
-	struct fuse_inode *fi = get_fuse_inode(inode);
-
-	wait_event(fi->page_waitq, !fuse_folio_is_writeback(inode, folio));
-}
-
 /*
  * Wait for all pending writepages on the inode to finish.
  *
@@ -886,13 +808,6 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	ssize_t res;
 	u64 attr_ver;
 
-	/*
-	 * With the temporary pages that are used to complete writeback, we can
-	 * have writeback that extends beyond the lifetime of the folio.  So
-	 * make sure we read a properly synced folio.
-	 */
-	fuse_wait_on_folio_writeback(inode, folio);
-
 	attr_ver = fuse_get_attr_version(fm->fc);
 
 	/* Don't overflow end offset */
@@ -1005,17 +920,12 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 static void fuse_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
-	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	unsigned int max_pages, nr_pages;
-	pgoff_t first = readahead_index(rac);
-	pgoff_t last = first + readahead_count(rac) - 1;
 
 	if (fuse_is_bad(inode))
 		return;
 
-	wait_event(fi->page_waitq, !fuse_range_is_writeback(inode, first, last));
-
 	max_pages = min_t(unsigned int, fc->max_pages,
 			fc->max_read / PAGE_SIZE);
 
@@ -1181,7 +1091,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	int err;
 
 	for (i = 0; i < ap->num_folios; i++)
-		fuse_wait_on_folio_writeback(inode, ap->folios[i]);
+		folio_wait_writeback(ap->folios[i]);
 
 	fuse_write_args_fill(ia, ff, pos, count);
 	ia->write.in.flags = fuse_write_flags(iocb);
@@ -1638,7 +1548,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 			return res;
 		}
 	}
-	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
+	if (!cuse && filemap_range_has_writeback(mapping, pos, (pos + count - 1))) {
 		if (!write)
 			inode_lock(inode);
 		fuse_sync_writes(inode);
@@ -1835,38 +1745,34 @@ static ssize_t fuse_splice_write(struct pipe_inode_info *pipe, struct file *out,
 static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 {
 	struct fuse_args_pages *ap = &wpa->ia.ap;
-	int i;
 
 	if (wpa->bucket)
 		fuse_sync_bucket_dec(wpa->bucket);
 
-	for (i = 0; i < ap->num_folios; i++)
-		folio_put(ap->folios[i]);
-
 	fuse_file_put(wpa->ia.ff, false);
 
 	kfree(ap->folios);
 	kfree(wpa);
 }
 
-static void fuse_writepage_finish_stat(struct inode *inode, struct folio *folio)
-{
-	struct backing_dev_info *bdi = inode_to_bdi(inode);
-
-	dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-	node_stat_sub_folio(folio, NR_WRITEBACK_TEMP);
-	wb_writeout_inc(&bdi->wb);
-}
-
 static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 {
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = wpa->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	int i;
 
-	for (i = 0; i < ap->num_folios; i++)
-		fuse_writepage_finish_stat(inode, ap->folios[i]);
+	for (i = 0; i < ap->num_folios; i++) {
+		/*
+		 * Benchmarks showed that ending writeback within the
+		 * scope of the fi->lock alleviates xarray lock
+		 * contention and noticeably improves performance.
+		 */
+		folio_end_writeback(ap->folios[i]);
+		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
+		wb_writeout_inc(&bdi->wb);
+	}
 
 	wake_up(&fi->page_waitq);
 }
@@ -1877,7 +1783,6 @@ static void fuse_send_writepage(struct fuse_mount *fm,
 __releases(fi->lock)
 __acquires(fi->lock)
 {
-	struct fuse_writepage_args *aux, *next;
 	struct fuse_inode *fi = get_fuse_inode(wpa->inode);
 	struct fuse_write_in *inarg = &wpa->ia.write.in;
 	struct fuse_args *args = &wpa->ia.ap.args;
@@ -1914,19 +1819,8 @@ __acquires(fi->lock)
 
  out_free:
 	fi->writectr--;
-	rb_erase(&wpa->writepages_entry, &fi->writepages);
 	fuse_writepage_finish(wpa);
 	spin_unlock(&fi->lock);
-
-	/* After rb_erase() aux request list is private */
-	for (aux = wpa->next; aux; aux = next) {
-		next = aux->next;
-		aux->next = NULL;
-		fuse_writepage_finish_stat(aux->inode,
-					   aux->ia.ap.folios[0]);
-		fuse_writepage_free(aux);
-	}
-
 	fuse_writepage_free(wpa);
 	spin_lock(&fi->lock);
 }
@@ -1954,43 +1848,6 @@ __acquires(fi->lock)
 	}
 }
 
-static struct fuse_writepage_args *fuse_insert_writeback(struct rb_root *root,
-						struct fuse_writepage_args *wpa)
-{
-	pgoff_t idx_from = wpa->ia.write.in.offset >> PAGE_SHIFT;
-	pgoff_t idx_to = idx_from + wpa->ia.ap.num_folios - 1;
-	struct rb_node **p = &root->rb_node;
-	struct rb_node  *parent = NULL;
-
-	WARN_ON(!wpa->ia.ap.num_folios);
-	while (*p) {
-		struct fuse_writepage_args *curr;
-		pgoff_t curr_index;
-
-		parent = *p;
-		curr = rb_entry(parent, struct fuse_writepage_args,
-				writepages_entry);
-		WARN_ON(curr->inode != wpa->inode);
-		curr_index = curr->ia.write.in.offset >> PAGE_SHIFT;
-
-		if (idx_from >= curr_index + curr->ia.ap.num_folios)
-			p = &(*p)->rb_right;
-		else if (idx_to < curr_index)
-			p = &(*p)->rb_left;
-		else
-			return curr;
-	}
-
-	rb_link_node(&wpa->writepages_entry, parent, p);
-	rb_insert_color(&wpa->writepages_entry, root);
-	return NULL;
-}
-
-static void tree_insert(struct rb_root *root, struct fuse_writepage_args *wpa)
-{
-	WARN_ON(fuse_insert_writeback(root, wpa));
-}
-
 static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 			       int error)
 {
@@ -2010,41 +1867,6 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 	if (!fc->writeback_cache)
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);
 	spin_lock(&fi->lock);
-	rb_erase(&wpa->writepages_entry, &fi->writepages);
-	while (wpa->next) {
-		struct fuse_mount *fm = get_fuse_mount(inode);
-		struct fuse_write_in *inarg = &wpa->ia.write.in;
-		struct fuse_writepage_args *next = wpa->next;
-
-		wpa->next = next->next;
-		next->next = NULL;
-		tree_insert(&fi->writepages, next);
-
-		/*
-		 * Skip fuse_flush_writepages() to make it easy to crop requests
-		 * based on primary request size.
-		 *
-		 * 1st case (trivial): there are no concurrent activities using
-		 * fuse_set/release_nowrite.  Then we're on safe side because
-		 * fuse_flush_writepages() would call fuse_send_writepage()
-		 * anyway.
-		 *
-		 * 2nd case: someone called fuse_set_nowrite and it is waiting
-		 * now for completion of all in-flight requests.  This happens
-		 * rarely and no more than once per page, so this should be
-		 * okay.
-		 *
-		 * 3rd case: someone (e.g. fuse_do_setattr()) is in the middle
-		 * of fuse_set_nowrite..fuse_release_nowrite section.  The fact
-		 * that fuse_set_nowrite returned implies that all in-flight
-		 * requests were completed along with all of their secondary
-		 * requests.  Further primary requests are blocked by negative
-		 * writectr.  Hence there cannot be any in-flight requests and
-		 * no invocations of fuse_writepage_end() while we're in
-		 * fuse_set_nowrite..fuse_release_nowrite section.
-		 */
-		fuse_send_writepage(fm, next, inarg->offset + inarg->size);
-	}
 	fi->writectr--;
 	fuse_writepage_finish(wpa);
 	spin_unlock(&fi->lock);
@@ -2131,19 +1953,16 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
 }
 
 static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
-					  struct folio *tmp_folio, uint32_t folio_index)
+					  uint32_t folio_index)
 {
 	struct inode *inode = folio->mapping->host;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 
-	folio_copy(tmp_folio, folio);
-
-	ap->folios[folio_index] = tmp_folio;
+	ap->folios[folio_index] = folio;
 	ap->descs[folio_index].offset = 0;
 	ap->descs[folio_index].length = PAGE_SIZE;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
 }
 
 static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
@@ -2178,18 +1997,12 @@ static int fuse_writepage_locked(struct folio *folio)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_writepage_args *wpa;
 	struct fuse_args_pages *ap;
-	struct folio *tmp_folio;
 	struct fuse_file *ff;
-	int error = -ENOMEM;
-
-	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
-	if (!tmp_folio)
-		goto err;
+	int error = -EIO;
 
-	error = -EIO;
 	ff = fuse_write_file_get(fi);
 	if (!ff)
-		goto err_nofile;
+		goto err;
 
 	wpa = fuse_writepage_args_setup(folio, ff);
 	error = -ENOMEM;
@@ -2200,22 +2013,17 @@ static int fuse_writepage_locked(struct folio *folio)
 	ap->num_folios = 1;
 
 	folio_start_writeback(folio);
-	fuse_writepage_args_page_fill(wpa, folio, tmp_folio, 0);
+	fuse_writepage_args_page_fill(wpa, folio, 0);
 
 	spin_lock(&fi->lock);
-	tree_insert(&fi->writepages, wpa);
 	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
 	fuse_flush_writepages(inode);
 	spin_unlock(&fi->lock);
 
-	folio_end_writeback(folio);
-
 	return 0;
 
 err_writepage_args:
 	fuse_file_put(ff, false);
-err_nofile:
-	folio_put(tmp_folio);
 err:
 	mapping_set_error(folio->mapping, error);
 	return error;
@@ -2225,7 +2033,6 @@ struct fuse_fill_wb_data {
 	struct fuse_writepage_args *wpa;
 	struct fuse_file *ff;
 	struct inode *inode;
-	struct folio **orig_folios;
 	unsigned int max_folios;
 };
 
@@ -2260,69 +2067,11 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 	struct fuse_writepage_args *wpa = data->wpa;
 	struct inode *inode = data->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	int num_folios = wpa->ia.ap.num_folios;
-	int i;
 
 	spin_lock(&fi->lock);
 	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
 	fuse_flush_writepages(inode);
 	spin_unlock(&fi->lock);
-
-	for (i = 0; i < num_folios; i++)
-		folio_end_writeback(data->orig_folios[i]);
-}
-
-/*
- * Check under fi->lock if the page is under writeback, and insert it onto the
- * rb_tree if not. Otherwise iterate auxiliary write requests, to see if there's
- * one already added for a page at this offset.  If there's none, then insert
- * this new request onto the auxiliary list, otherwise reuse the existing one by
- * swapping the new temp page with the old one.
- */
-static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
-			       struct folio *folio)
-{
-	struct fuse_inode *fi = get_fuse_inode(new_wpa->inode);
-	struct fuse_writepage_args *tmp;
-	struct fuse_writepage_args *old_wpa;
-	struct fuse_args_pages *new_ap = &new_wpa->ia.ap;
-
-	WARN_ON(new_ap->num_folios != 0);
-	new_ap->num_folios = 1;
-
-	spin_lock(&fi->lock);
-	old_wpa = fuse_insert_writeback(&fi->writepages, new_wpa);
-	if (!old_wpa) {
-		spin_unlock(&fi->lock);
-		return true;
-	}
-
-	for (tmp = old_wpa->next; tmp; tmp = tmp->next) {
-		pgoff_t curr_index;
-
-		WARN_ON(tmp->inode != new_wpa->inode);
-		curr_index = tmp->ia.write.in.offset >> PAGE_SHIFT;
-		if (curr_index == folio->index) {
-			WARN_ON(tmp->ia.ap.num_folios != 1);
-			swap(tmp->ia.ap.folios[0], new_ap->folios[0]);
-			break;
-		}
-	}
-
-	if (!tmp) {
-		new_wpa->next = old_wpa->next;
-		old_wpa->next = new_wpa;
-	}
-
-	spin_unlock(&fi->lock);
-
-	if (tmp) {
-		fuse_writepage_finish_stat(new_wpa->inode,
-					   folio);
-		fuse_writepage_free(new_wpa);
-	}
-
-	return false;
 }
 
 static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
@@ -2331,15 +2080,6 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 {
 	WARN_ON(!ap->num_folios);
 
-	/*
-	 * Being under writeback is unlikely but possible.  For example direct
-	 * read to an mmaped fuse file will set the page dirty twice; once when
-	 * the pages are faulted with get_user_pages(), and then after the read
-	 * completed.
-	 */
-	if (fuse_folio_is_writeback(data->inode, folio))
-		return true;
-
 	/* Reached max pages */
 	if (ap->num_folios == fc->max_pages)
 		return true;
@@ -2349,7 +2089,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 		return true;
 
 	/* Discontinuity */
-	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
+	if (ap->folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2368,7 +2108,6 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct inode *inode = data->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct folio *tmp_folio;
 	int err;
 
 	if (!data->ff) {
@@ -2383,54 +2122,23 @@ static int fuse_writepages_fill(struct folio *folio,
 		data->wpa = NULL;
 	}
 
-	err = -ENOMEM;
-	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
-	if (!tmp_folio)
-		goto out_unlock;
-
-	/*
-	 * The page must not be redirtied until the writeout is completed
-	 * (i.e. userspace has sent a reply to the write request).  Otherwise
-	 * there could be more than one temporary page instance for each real
-	 * page.
-	 *
-	 * This is ensured by holding the page lock in page_mkwrite() while
-	 * checking fuse_page_is_writeback().  We already hold the page lock
-	 * since clear_page_dirty_for_io() and keep it held until we add the
-	 * request to the fi->writepages list and increment ap->num_folios.
-	 * After this fuse_page_is_writeback() will indicate that the page is
-	 * under writeback, so we can release the page lock.
-	 */
 	if (data->wpa == NULL) {
 		err = -ENOMEM;
 		wpa = fuse_writepage_args_setup(folio, data->ff);
-		if (!wpa) {
-			folio_put(tmp_folio);
+		if (!wpa)
 			goto out_unlock;
-		}
 		fuse_file_get(wpa->ia.ff);
 		data->max_folios = 1;
 		ap = &wpa->ia.ap;
 	}
 	folio_start_writeback(folio);
 
-	fuse_writepage_args_page_fill(wpa, folio, tmp_folio, ap->num_folios);
-	data->orig_folios[ap->num_folios] = folio;
+	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios);
 
 	err = 0;
-	if (data->wpa) {
-		/*
-		 * Protected by fi->lock against concurrent access by
-		 * fuse_page_is_writeback().
-		 */
-		spin_lock(&fi->lock);
-		ap->num_folios++;
-		spin_unlock(&fi->lock);
-	} else if (fuse_writepage_add(wpa, folio)) {
+	ap->num_folios++;
+	if (!data->wpa)
 		data->wpa = wpa;
-	} else {
-		folio_end_writeback(folio);
-	}
 out_unlock:
 	folio_unlock(folio);
 
@@ -2457,13 +2165,6 @@ static int fuse_writepages(struct address_space *mapping,
 	data.wpa = NULL;
 	data.ff = NULL;
 
-	err = -ENOMEM;
-	data.orig_folios = kcalloc(fc->max_pages,
-				   sizeof(struct folio *),
-				   GFP_NOFS);
-	if (!data.orig_folios)
-		goto out;
-
 	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
 	if (data.wpa) {
 		WARN_ON(!data.wpa->ia.ap.num_folios);
@@ -2472,7 +2173,6 @@ static int fuse_writepages(struct address_space *mapping,
 	if (data.ff)
 		fuse_file_put(data.ff, false);
 
-	kfree(data.orig_folios);
 out:
 	return err;
 }
@@ -2497,8 +2197,6 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
 	if (IS_ERR(folio))
 		goto error;
 
-	fuse_wait_on_page_writeback(mapping->host, folio->index);
-
 	if (folio_test_uptodate(folio) || len >= folio_size(folio))
 		goto success;
 	/*
@@ -2561,13 +2259,9 @@ static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
 	if (folio_clear_dirty_for_io(folio)) {
-		struct inode *inode = folio->mapping->host;
-
-		/* Serialize with pending writeback for the same page */
-		fuse_wait_on_page_writeback(inode, folio->index);
 		err = fuse_writepage_locked(folio);
 		if (!err)
-			fuse_wait_on_page_writeback(inode, folio->index);
+			folio_wait_writeback(folio);
 	}
 	return err;
 }
@@ -2611,7 +2305,7 @@ static vm_fault_t fuse_page_mkwrite(struct vm_fault *vmf)
 		return VM_FAULT_NOPAGE;
 	}
 
-	fuse_wait_on_folio_writeback(inode, folio);
+	folio_wait_writeback(folio);
 	return VM_FAULT_LOCKED;
 }
 
@@ -3429,9 +3123,12 @@ static const struct address_space_operations fuse_file_aops  = {
 void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
+	if (fc->writeback_cache)
+		mapping_set_writeback_indeterminate(&inode->i_data);
 
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
@@ -3439,7 +3136,6 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	fi->iocachectr = 0;
 	init_waitqueue_head(&fi->page_waitq);
 	init_waitqueue_head(&fi->direct_io_waitq);
-	fi->writepages = RB_ROOT;
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_inode_init(inode, flags);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fee96fe7887b..28a101a5c558 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -141,9 +141,6 @@ struct fuse_inode {
 
 			/* waitq for direct-io completion */
 			wait_queue_head_t direct_io_waitq;
-
-			/* List of writepage requestst (pending or sent) */
-			struct rb_root writepages;
 		};
 
 		/* readdir cache (directory only) */
-- 
2.47.1


