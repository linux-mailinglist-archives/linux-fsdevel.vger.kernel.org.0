Return-Path: <linux-fsdevel+bounces-33955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C2B9C0EC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86825281E21
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765B17E782;
	Thu,  7 Nov 2024 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBo3GB6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054F195B1A
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007068; cv=none; b=rVfiGWl9jtPtfDXbTHWlAccCUpBrBQGgRCYRkeg2IBMe+zF1B8J/5gxGeEcZh9hZOEZ6F2t63R9xux9pSmDFup6+1/nunCvlZHX6RtpCDNPK5y2OfXw+tnSXsCa7vwO7MU9G8zSuvmNDjsj0xAvo2UMQsDDsFe/KZ/dL1xmj0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007068; c=relaxed/simple;
	bh=876u/r1RmBaMQribv4kOOKSU/WZ119YhdQv0UfQy+y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPGotEulvT7/HlKjF1YIszXSoPuECoXaDuH8FJU5/69U+qpatI8VnNmvVdfEUhGjGuIxIrkHd6EFjuAJcPfDXmWEaPjZMp2ENLCEh1JNwoY/FI/K6ajHJiAwW49+QZiXvB6YPKC+4vHcFjV+Por96v5IDa72tw5MfG+V23WStQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBo3GB6J; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e2918664a3fso1280444276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 11:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731007065; x=1731611865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd9fc4hPdhRnHAoBq+4wrx1ZclXDUb5MhN21NFaoAlY=;
        b=FBo3GB6JlS/dH0jfLM1aDCcVjWP48yckIQFxTbt4Ljn+e9puI8zK2/vzrEAcbfdu/I
         zqUTYBZF4vySX6SgVKe5aAxTcT+dpFgVkyja/ql7YokeoFmJlbncSNf1cUK0aHx6MAP3
         d9zwlK8KqqkOoX1uf3VrfxafKWXMQtqVzjfI/HRjByHGipwM0LXkb41Ao2mtnmZ4IcbS
         qKy3pZz1LTcbZRbedzhCyP8lPnKQS+RtvA0Xm1v4PDdgnS+dSCuHcrWLtHwFMSDuCw4W
         tQ5wG4fNV60VTAac/b9gupAkSWHYd3AehhKIBuXJg3niRueekC1DgTh86KlTCWEDQdD5
         2yEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007065; x=1731611865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd9fc4hPdhRnHAoBq+4wrx1ZclXDUb5MhN21NFaoAlY=;
        b=igbPm4G/+Pe/omeoxL9caCSQriRH3soqD3AIoHYufJPJVfCSwvQUqD9oQ9XzHPwlSe
         p2SD7lVTsQo7ZkaqqZczCbXAyDJoCw4TyGZEbAXrI6Vr64jVttG158ePxnq///SGjjiD
         kQlVomxq6OP4MNWPR4NMBraAIaSkm+o0P/VAQiyniKO+B7FvGMZt+mfy2TtMnZHiYGue
         iI0aAfTbKEA+kd6aF97t2l5zUq+W/AF2ZPtcn+jKAFoTP8E3mCVUXXiO/ndZbtoixXCP
         BwsSMcBWUOJzd8649Vv0MslbLH5q1DfmBqX7EqKcd1AOreXy+FdUcLPFZ48iaXZsJEh9
         YDBw==
X-Forwarded-Encrypted: i=1; AJvYcCUKKKSS0NmLqEm7tYpdGjbgQ9lfjileulDccOyKe9C63GRVK4GikVmCob7rsr0qLvsy70iaN9mEaFrrZF1m@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuf4NEj0bIRi+mHMjBeaxELKBa8ZZCDgxzjg3E3m7x+fd6y/rF
	xsllPPHWnmiLxroUG9H3CL7kNk1QPkIC+v4tx0GEAL00c3flBIm4
X-Google-Smtp-Source: AGHT+IHzjE4uzit81wgdKLtfKGm9hnxE8pRULcxB9Svk1Y0PsQoAtIjJZ+dkV7yShUmT0GvecKkkSw==
X-Received: by 2002:a05:6902:1081:b0:e2b:dc72:3bdf with SMTP id 3f1490d57ef6-e337e11f26emr729748276.10.1731007065407;
        Thu, 07 Nov 2024 11:17:45 -0800 (PST)
Received: from localhost (fwdproxy-nha-012.fbsv.net. [2a03:2880:25ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1baaefsm369181276.44.2024.11.07.11.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 11:17:45 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v3 6/6] fuse: remove tmp folio for writebacks and internal rb tree
Date: Thu,  7 Nov 2024 11:16:18 -0800
Message-ID: <20241107191618.2011146-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107191618.2011146-1-joannelkoong@gmail.com>
References: <20241107191618.2011146-1-joannelkoong@gmail.com>
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

A recent change prevents reclaim logic from waiting on writeback for
folios whose mappings have the AS_WRITEBACK_MAY_BLOCK flag set in it.
This commit sets AS_WRITEBACK_MAY_BLOCK on FUSE inode mappings (which
will prevent FUSE folios from running into the reclaim deadlock described
above) and removes the temporary folio + extra copying and the internal
rb tree.

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
 fs/fuse/file.c | 339 +++++--------------------------------------------
 1 file changed, 30 insertions(+), 309 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 88d0946b5bc9..a2e91fdd8521 100644
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
@@ -891,7 +813,7 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	 * have writeback that extends beyond the lifetime of the folio.  So
 	 * make sure we read a properly synced folio.
 	 */
-	fuse_wait_on_folio_writeback(inode, folio);
+	folio_wait_writeback(folio);
 
 	attr_ver = fuse_get_attr_version(fm->fc);
 
@@ -1006,13 +928,14 @@ static void fuse_readahead(struct readahead_control *rac)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	unsigned int max_pages, nr_pages;
-	pgoff_t first = readahead_index(rac);
-	pgoff_t last = first + readahead_count(rac) - 1;
+	loff_t first = readahead_pos(rac);
+	loff_t last = first + readahead_length(rac) - 1;
 
 	if (fuse_is_bad(inode))
 		return;
 
-	wait_event(fi->page_waitq, !fuse_range_is_writeback(inode, first, last));
+	wait_event(fi->page_waitq,
+		   !filemap_range_has_writeback(rac->mapping, first, last));
 
 	max_pages = min_t(unsigned int, fc->max_pages,
 			fc->max_read / PAGE_SIZE);
@@ -1172,7 +1095,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	int err;
 
 	for (i = 0; i < ap->num_folios; i++)
-		fuse_wait_on_folio_writeback(inode, ap->folios[i]);
+		folio_wait_writeback(ap->folios[i]);
 
 	fuse_write_args_fill(ia, ff, pos, count);
 	ia->write.in.flags = fuse_write_flags(iocb);
@@ -1622,7 +1545,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 			return res;
 		}
 	}
-	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
+	if (!cuse && filemap_range_has_writeback(mapping, pos, (pos + count - 1))) {
 		if (!write)
 			inode_lock(inode);
 		fuse_sync_writes(inode);
@@ -1824,8 +1747,10 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	if (wpa->bucket)
 		fuse_sync_bucket_dec(wpa->bucket);
 
-	for (i = 0; i < ap->num_folios; i++)
+	for (i = 0; i < ap->num_folios; i++) {
+		folio_end_writeback(ap->folios[i]);
 		folio_put(ap->folios[i]);
+	}
 
 	fuse_file_put(wpa->ia.ff, false);
 
@@ -1838,7 +1763,7 @@ static void fuse_writepage_finish_stat(struct inode *inode, struct folio *folio)
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 
 	dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-	node_stat_sub_folio(folio, NR_WRITEBACK_TEMP);
+	node_stat_sub_folio(folio, NR_WRITEBACK);
 	wb_writeout_inc(&bdi->wb);
 }
 
@@ -1861,7 +1786,6 @@ static void fuse_send_writepage(struct fuse_mount *fm,
 __releases(fi->lock)
 __acquires(fi->lock)
 {
-	struct fuse_writepage_args *aux, *next;
 	struct fuse_inode *fi = get_fuse_inode(wpa->inode);
 	struct fuse_write_in *inarg = &wpa->ia.write.in;
 	struct fuse_args *args = &wpa->ia.ap.args;
@@ -1898,19 +1822,8 @@ __acquires(fi->lock)
 
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
@@ -1938,43 +1851,6 @@ __acquires(fi->lock)
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
@@ -1994,41 +1870,6 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
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
@@ -2115,19 +1956,18 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
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
+	folio_get(folio);
+	ap->folios[folio_index] = folio;
 	ap->descs[folio_index].offset = 0;
 	ap->descs[folio_index].length = PAGE_SIZE;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
+	node_stat_add_folio(folio, NR_WRITEBACK);
 }
 
 static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
@@ -2162,18 +2002,12 @@ static int fuse_writepage_locked(struct folio *folio)
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
@@ -2184,22 +2018,17 @@ static int fuse_writepage_locked(struct folio *folio)
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
@@ -2209,7 +2038,6 @@ struct fuse_fill_wb_data {
 	struct fuse_writepage_args *wpa;
 	struct fuse_file *ff;
 	struct inode *inode;
-	struct folio **orig_folios;
 	unsigned int max_folios;
 };
 
@@ -2244,69 +2072,11 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
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
@@ -2315,15 +2085,6 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
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
@@ -2333,7 +2094,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 		return true;
 
 	/* Discontinuity */
-	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
+	if (ap->folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2352,7 +2113,6 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct inode *inode = data->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct folio *tmp_folio;
 	int err;
 
 	if (!data->ff) {
@@ -2367,54 +2127,23 @@ static int fuse_writepages_fill(struct folio *folio,
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
 
@@ -2441,13 +2170,6 @@ static int fuse_writepages(struct address_space *mapping,
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
@@ -2456,7 +2178,6 @@ static int fuse_writepages(struct address_space *mapping,
 	if (data.ff)
 		fuse_file_put(data.ff, false);
 
-	kfree(data.orig_folios);
 out:
 	return err;
 }
@@ -2481,7 +2202,7 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
 	if (IS_ERR(folio))
 		goto error;
 
-	fuse_wait_on_page_writeback(mapping->host, folio->index);
+	folio_wait_writeback(folio);
 
 	if (folio_test_uptodate(folio) || len >= folio_size(folio))
 		goto success;
@@ -2545,13 +2266,11 @@ static int fuse_launder_folio(struct folio *folio)
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
@@ -2595,7 +2314,7 @@ static vm_fault_t fuse_page_mkwrite(struct vm_fault *vmf)
 		return VM_FAULT_NOPAGE;
 	}
 
-	fuse_wait_on_folio_writeback(inode, folio);
+	folio_wait_writeback(folio);
 	return VM_FAULT_LOCKED;
 }
 
@@ -3413,9 +3132,12 @@ static const struct address_space_operations fuse_file_aops  = {
 void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
+	if (fc->writeback_cache)
+		mapping_set_writeback_may_block(&inode->i_data);
 
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
@@ -3423,7 +3145,6 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	fi->iocachectr = 0;
 	init_waitqueue_head(&fi->page_waitq);
 	init_waitqueue_head(&fi->direct_io_waitq);
-	fi->writepages = RB_ROOT;
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_inode_init(inode, flags);
-- 
2.43.5


