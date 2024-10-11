Return-Path: <linux-fsdevel+bounces-31790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6AB99AEB9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 00:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CE81F235A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 22:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DE41D4336;
	Fri, 11 Oct 2024 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+LlW3O+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BDE1CEE86
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728686231; cv=none; b=ty2fU08LTgwday7++2NiHWSrWB//HgOedfWJKGaQdZqeLZ2EUrGnz4+LhnVC/ulyuo3BLklW2sKbLlzuRfK1HWUpdouPAruoLUx0Cpom9bDbze/nSaOvdXwKxIfQoA5UtVaxBpUrJe8jLtFMZIbNdKKYvrRSlgPjwSqBT2u/ytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728686231; c=relaxed/simple;
	bh=FfuLUBOz+0RL0qOwiDRmtA8YuTfbrLFrlwKqBkYNzIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=px1NlooQHNEDXfXD4CAh+OUwZAbfnMzXm7hcdICdtXMDBvv/ZfaWxDtEt3AaZC8dvKoK1a39hY4h5nqmpys82D9wRUQ5AUGtYDs5eiOrIkpqAkJqjhX1A12Y8TnGrFkU5r9OaEx/C9ZHi9mWh0q2FHK7C/84gIK/k6xsw4iiC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+LlW3O+; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6dbc9a60480so23531907b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 15:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728686229; x=1729291029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNXXnngpL6dWQKI7TQhjBR3pGHoC6owvQJqVkEmPhBw=;
        b=H+LlW3O+aUeO5l7dY4fuREzmSGhQXAicSnKvbckbj8TKyIz7RezeyQ6ikaXOpM7P8Q
         E8rYjj+leEvADYTKRguzi1pNIbmhz54Un/5NKYjWABpE41d6zy/7CcqEeyLb0q1sGGZp
         ahJSWkV79fpsyf0HaRt6hBm6Pjr15t8QNp2CxfoLFi46/wK7BN6b1tm0GQ4brsZ7L6AD
         LMwfGmxMUOuLgeBsAF83OVT2TyhkrEOEmhJYI2me9YGY4doSfr+/QYd2m1y/R9laJw6e
         vbfNoE+cPbsez5o+f5BDsnR7rV/r9AIIMChZ/WcbYvjanZoaZGYpbgskWlK5KSBqPSco
         x6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728686229; x=1729291029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNXXnngpL6dWQKI7TQhjBR3pGHoC6owvQJqVkEmPhBw=;
        b=jO2Mfu5usFrgeLCnYhZn2aei6KanKDAqMjOXNrWwsI6G6dMKLlrxpC3p6TeThPGg89
         ygoayG8iDyDzkqMReUj12AYXhWf3DgM/wko1d+xA5vt1OkHLoN2z94Mz8QOHWYHbERqW
         a6WR2bo7SxC9jQ52b0w70/4801ku561+eGV6AMzr1p9LqveMOlgiOl1oykh1pL8nzqBC
         gMOZHGjvZZEZvH+BRIGTJZ2w4CucEm2kP9v2AWdNr9BCzUs979MlPLf6f+O6uvyroIMn
         V3qyPKwCgScGNWl5DsWE3bhRLP+FYRLZSfSQnZ7hoqo/T07w6wWOF4xLH4aPvNcOUDR5
         FKBA==
X-Forwarded-Encrypted: i=1; AJvYcCUO9uFSNvTRzjJFYEnYG5tjBE0msb5WS8IG0rnz5RJtQlxVtM7QmsfdYrtw74mZUb2KW2yQvGlBaJLFY7Oz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxdhq1NXUI3MaG6MHXLfV6N3Nf3OyvAL/VSrl75ih+6GgSiokH
	fJv1QA0WYMpgBUxlh1eJcHYyCTexn+zI7JyEUby9N42+EZlnVnIz
X-Google-Smtp-Source: AGHT+IEnj7nBPlDzyyZGfdD80q/5tFw+JFCaHFIfzZtj34AKTK3OrLihzeKifEVAARcM2RvKzgA7wQ==
X-Received: by 2002:a05:690c:670e:b0:6d6:7c9a:bf58 with SMTP id 00721157ae682-6e347b36821mr41689407b3.28.1728686228561;
        Fri, 11 Oct 2024 15:37:08 -0700 (PDT)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332c27bcesm7715917b3.83.2024.10.11.15.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 15:37:08 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH 2/2] fuse: remove tmp folio for writebacks and internal rb tree
Date: Fri, 11 Oct 2024 15:34:34 -0700
Message-ID: <20241011223434.1307300-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241011223434.1307300-1-joannelkoong@gmail.com>
References: <20241011223434.1307300-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we allocate and copy data to a temporary folio when
handling writeback in order to mitigate the following deadlock scenario
that may arise if reclaim waits on writeback to complete:
* single-threaded FUSE server is in the middle of handling a request
  that needs a memory allocation
* memory allocation triggers direct reclaim
* direct reclaim waits on a folio under writeback
* the FUSE server can't write back the folio since it's stuck in
  direct reclaim

To work around this, we allocate a temporary folio and copy over the
original folio to the temporary folio so that writeback can be
immediately cleared on the original folio. This additionally requires us
to maintain an internal rb tree to keep track of writeback state on the
temporary folios.

This change sets the address space operations flag
ASOP_NO_RECLAIM_IN_WRITEBACK so that FUSE folios are not reclaimed and
waited on while in writeback, and removes the temporary folio +
extra copying and the internal rb tree.

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
---
 fs/fuse/file.c | 321 +++++--------------------------------------------
 1 file changed, 27 insertions(+), 294 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4304e44f32e6..9fee9f3062db 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -415,74 +415,11 @@ u64 fuse_lock_owner_id(struct fuse_conn *fc, fl_owner_t id)
 
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
-		if (idx_from >= curr_index + wpa->ia.ap.num_pages)
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
 /*
  * Wait for all pending writepages on the inode to finish.
  *
@@ -876,7 +813,7 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 	 * page-cache page, so make sure we read a properly synced
 	 * page.
 	 */
-	fuse_wait_on_page_writeback(inode, page->index);
+	folio_wait_writeback(page_folio(page));
 
 	attr_ver = fuse_get_attr_version(fm->fc);
 
@@ -1024,8 +961,7 @@ static void fuse_readahead(struct readahead_control *rac)
 		ap = &ia->ap;
 		nr_pages = __readahead_batch(rac, ap->pages, nr_pages);
 		for (i = 0; i < nr_pages; i++) {
-			fuse_wait_on_page_writeback(inode,
-						    readahead_index(rac) + i);
+			folio_wait_writeback(page_folio(ap->pages[i]));
 			ap->descs[i].length = PAGE_SIZE;
 		}
 		ap->num_pages = nr_pages;
@@ -1147,7 +1083,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	int err;
 
 	for (i = 0; i < ap->num_pages; i++)
-		fuse_wait_on_page_writeback(inode, ap->pages[i]->index);
+		folio_wait_writeback(page_folio(ap->pages[i]));
 
 	fuse_write_args_fill(ia, ff, pos, count);
 	ia->write.in.flags = fuse_write_flags(iocb);
@@ -1583,7 +1519,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 			return res;
 		}
 	}
-	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
+	if (!cuse && filemap_range_has_writeback(mapping, pos, (pos + count - 1))) {
 		if (!write)
 			inode_lock(inode);
 		fuse_sync_writes(inode);
@@ -1780,13 +1716,17 @@ static ssize_t fuse_splice_write(struct pipe_inode_info *pipe, struct file *out,
 static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 {
 	struct fuse_args_pages *ap = &wpa->ia.ap;
+	struct folio *folio;
 	int i;
 
 	if (wpa->bucket)
 		fuse_sync_bucket_dec(wpa->bucket);
 
-	for (i = 0; i < ap->num_pages; i++)
-		__free_page(ap->pages[i]);
+	for (i = 0; i < ap->num_pages; i++) {
+		folio = page_folio(ap->pages[i]);
+		folio_end_writeback(folio);
+		folio_put(folio);
+	}
 
 	fuse_file_put(wpa->ia.ff, false);
 
@@ -1799,7 +1739,7 @@ static void fuse_writepage_finish_stat(struct inode *inode, struct page *page)
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 
 	dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-	dec_node_page_state(page, NR_WRITEBACK_TEMP);
+	dec_node_page_state(page, NR_WRITEBACK);
 	wb_writeout_inc(&bdi->wb);
 }
 
@@ -1822,7 +1762,6 @@ static void fuse_send_writepage(struct fuse_mount *fm,
 __releases(fi->lock)
 __acquires(fi->lock)
 {
-	struct fuse_writepage_args *aux, *next;
 	struct fuse_inode *fi = get_fuse_inode(wpa->inode);
 	struct fuse_write_in *inarg = &wpa->ia.write.in;
 	struct fuse_args *args = &wpa->ia.ap.args;
@@ -1858,18 +1797,8 @@ __acquires(fi->lock)
 
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
-		fuse_writepage_finish_stat(aux->inode, aux->ia.ap.pages[0]);
-		fuse_writepage_free(aux);
-	}
-
 	fuse_writepage_free(wpa);
 	spin_lock(&fi->lock);
 }
@@ -1897,43 +1826,6 @@ __acquires(fi->lock)
 	}
 }
 
-static struct fuse_writepage_args *fuse_insert_writeback(struct rb_root *root,
-						struct fuse_writepage_args *wpa)
-{
-	pgoff_t idx_from = wpa->ia.write.in.offset >> PAGE_SHIFT;
-	pgoff_t idx_to = idx_from + wpa->ia.ap.num_pages - 1;
-	struct rb_node **p = &root->rb_node;
-	struct rb_node  *parent = NULL;
-
-	WARN_ON(!wpa->ia.ap.num_pages);
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
-		if (idx_from >= curr_index + curr->ia.ap.num_pages)
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
@@ -1953,41 +1845,6 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
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
@@ -2074,19 +1931,18 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
 }
 
 static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
-					  struct folio *tmp_folio, uint32_t page_index)
+					  uint32_t page_index)
 {
 	struct inode *inode = folio->mapping->host;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 
-	folio_copy(tmp_folio, folio);
-
-	ap->pages[page_index] = &tmp_folio->page;
+	folio_get(folio);
+	ap->pages[page_index] = &folio->page;
 	ap->descs[page_index].offset = 0;
 	ap->descs[page_index].length = PAGE_SIZE;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
+	inc_node_page_state(&folio->page, NR_WRITEBACK);
 }
 
 static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
@@ -2121,18 +1977,12 @@ static int fuse_writepage_locked(struct folio *folio)
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
@@ -2143,22 +1993,17 @@ static int fuse_writepage_locked(struct folio *folio)
 	ap->num_pages = 1;
 
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
@@ -2168,7 +2013,6 @@ struct fuse_fill_wb_data {
 	struct fuse_writepage_args *wpa;
 	struct fuse_file *ff;
 	struct inode *inode;
-	struct page **orig_pages;
 	unsigned int max_pages;
 };
 
@@ -2203,68 +2047,11 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 	struct fuse_writepage_args *wpa = data->wpa;
 	struct inode *inode = data->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	int num_pages = wpa->ia.ap.num_pages;
-	int i;
 
 	spin_lock(&fi->lock);
 	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
 	fuse_flush_writepages(inode);
 	spin_unlock(&fi->lock);
-
-	for (i = 0; i < num_pages; i++)
-		end_page_writeback(data->orig_pages[i]);
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
-			       struct page *page)
-{
-	struct fuse_inode *fi = get_fuse_inode(new_wpa->inode);
-	struct fuse_writepage_args *tmp;
-	struct fuse_writepage_args *old_wpa;
-	struct fuse_args_pages *new_ap = &new_wpa->ia.ap;
-
-	WARN_ON(new_ap->num_pages != 0);
-	new_ap->num_pages = 1;
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
-		if (curr_index == page->index) {
-			WARN_ON(tmp->ia.ap.num_pages != 1);
-			swap(tmp->ia.ap.pages[0], new_ap->pages[0]);
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
-		fuse_writepage_finish_stat(new_wpa->inode, new_ap->pages[0]);
-		fuse_writepage_free(new_wpa);
-	}
-
-	return false;
 }
 
 static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
@@ -2273,15 +2060,6 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
 {
 	WARN_ON(!ap->num_pages);
 
-	/*
-	 * Being under writeback is unlikely but possible.  For example direct
-	 * read to an mmaped fuse file will set the page dirty twice; once when
-	 * the pages are faulted with get_user_pages(), and then after the read
-	 * completed.
-	 */
-	if (fuse_page_is_writeback(data->inode, page->index))
-		return true;
-
 	/* Reached max pages */
 	if (ap->num_pages == fc->max_pages)
 		return true;
@@ -2291,7 +2069,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
 		return true;
 
 	/* Discontinuity */
-	if (data->orig_pages[ap->num_pages - 1]->index + 1 != page->index)
+	if (ap->pages[ap->num_pages - 1]->index + 1 != page->index)
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2308,9 +2086,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct fuse_writepage_args *wpa = data->wpa;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = data->inode;
-	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct folio *tmp_folio;
 	int err;
 
 	if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) {
@@ -2318,54 +2094,23 @@ static int fuse_writepages_fill(struct folio *folio,
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
-	 * request to the fi->writepages list and increment ap->num_pages.
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
 		data->max_pages = 1;
 		ap = &wpa->ia.ap;
 	}
 	folio_start_writeback(folio);
 
-	fuse_writepage_args_page_fill(wpa, folio, tmp_folio, ap->num_pages);
-	data->orig_pages[ap->num_pages] = &folio->page;
+	fuse_writepage_args_page_fill(wpa, folio, ap->num_pages);
 
 	err = 0;
-	if (data->wpa) {
-		/*
-		 * Protected by fi->lock against concurrent access by
-		 * fuse_page_is_writeback().
-		 */
-		spin_lock(&fi->lock);
-		ap->num_pages++;
-		spin_unlock(&fi->lock);
-	} else if (fuse_writepage_add(wpa, &folio->page)) {
+	ap->num_pages++;
+	if (!data->wpa)
 		data->wpa = wpa;
-	} else {
-		folio_end_writeback(folio);
-	}
 out_unlock:
 	folio_unlock(folio);
 
@@ -2394,21 +2139,12 @@ static int fuse_writepages(struct address_space *mapping,
 	if (!data.ff)
 		return -EIO;
 
-	err = -ENOMEM;
-	data.orig_pages = kcalloc(fc->max_pages,
-				  sizeof(struct page *),
-				  GFP_NOFS);
-	if (!data.orig_pages)
-		goto out;
-
 	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
 	if (data.wpa) {
 		WARN_ON(!data.wpa->ia.ap.num_pages);
 		fuse_writepages_send(&data);
 	}
 
-	kfree(data.orig_pages);
-out:
 	fuse_file_put(data.ff, false);
 	return err;
 }
@@ -2433,7 +2169,7 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
 	if (IS_ERR(folio))
 		goto error;
 
-	fuse_wait_on_page_writeback(mapping->host, folio->index);
+	folio_wait_writeback(folio);
 
 	if (folio_test_uptodate(folio) || len >= folio_size(folio))
 		goto success;
@@ -2497,13 +2233,11 @@ static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
 	if (folio_clear_dirty_for_io(folio)) {
-		struct inode *inode = folio->mapping->host;
-
 		/* Serialize with pending writeback for the same page */
-		fuse_wait_on_page_writeback(inode, folio->index);
+		folio_wait_writeback(folio);
 		err = fuse_writepage_locked(folio);
 		if (!err)
-			fuse_wait_on_page_writeback(inode, folio->index);
+			folio_wait_writeback(folio);
 	}
 	return err;
 }
@@ -2547,7 +2281,7 @@ static vm_fault_t fuse_page_mkwrite(struct vm_fault *vmf)
 		return VM_FAULT_NOPAGE;
 	}
 
-	fuse_wait_on_page_writeback(inode, page->index);
+	folio_wait_writeback(page_folio(page));
 	return VM_FAULT_LOCKED;
 }
 
@@ -3375,7 +3109,6 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	fi->iocachectr = 0;
 	init_waitqueue_head(&fi->page_waitq);
 	init_waitqueue_head(&fi->direct_io_waitq);
-	fi->writepages = RB_ROOT;
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_inode_init(inode, flags);
-- 
2.43.5


