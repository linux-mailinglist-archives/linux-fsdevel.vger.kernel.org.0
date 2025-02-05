Return-Path: <linux-fsdevel+bounces-40862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31894A27FE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 01:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B083F16638B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E88460;
	Wed,  5 Feb 2025 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="ge/R1YuD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFDC163
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 00:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738713805; cv=none; b=suw1eZ7xtky1YlVWjJggkSw2oJfM5j/+U5FpFw2712JxP05EzsbI0Fkq5YzXafrDvzfFOsDyya8IYGzpqxbjI9XuHK+WAWiKAGDALNHvqsZnQmg1SHi7CK2BOdpiXl9lSEeyvxqnnxTxXIB7Z3gYERqUMaHg07lxxJRyEFjSR9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738713805; c=relaxed/simple;
	bh=WNowUPFZxMJDLV3UgrmUOzqGuc60hZ57l/dZ3jSuxgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg6SyFeoQ3a+k+I6IYN4iL6xhgNoLdj+/WuPzdnn1r5CeY/YxzWN28BbB+RGmXB0wfDm9HSzP8Ch6CQfyU3RQDGOEyg7Te5KXc4lr+NWXRPMljkmHXjj/7rSWHM7VuIv9G3twaqoQyAwLiW0NpY1Q5CVwcNsRUG/XxvvLmMLJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=ge/R1YuD; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-724a5d042c0so3262340a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 16:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1738713802; x=1739318602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKtkYSbHl0RGoHvl17gVW/od8FXDpWdybf/I63gwLS4=;
        b=ge/R1YuDlUFIzGl2jlRXgMSZHXjNFwMYpaTnVagIX2FjnqSnpuB2a8aSf6DYPD3Agl
         i+Sl1ZSJyYDS6jCEDA54d4jpCG23yTt+SGNLSnks6P05oOEa+P/87Xev8fnt4VP8GYwo
         60XVXVi1FNBLNwbOZVh61CIaUDAKT4yxsPmW021jd8u4CjC3mGDS1YmytN2M8WUvGqTY
         iz5E4S/XGnMzZklhI+YqWKrUSGHpdwZpsrtYZiMK19X6y5Db5l59eHiGzUhCBR4R8uFx
         YNAWWcwrcDf9N4lGO9eN150KkDam/rztCgrqX2y/p51tGINeTFpOBadYf2ALFHk7uW1O
         1cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738713802; x=1739318602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKtkYSbHl0RGoHvl17gVW/od8FXDpWdybf/I63gwLS4=;
        b=HE6WYsxGS+r+M2St8G084DXN0hKlmnmPc+NSLf1V4DM+2p+OfeW/74slaNc6Vce7Pz
         xdh5+raGxdlm9R4nqV5bfws6ZAtxixqeInCU4fV4kzoWg4mtG/vXnqD43Qx6Qh6YFO5N
         EdvOZq6Lgh0fI6HAst2lv+T2/fc26VTBd76AOnJU0OdEpCSKyZkxNEY6HiXfjLmWDTG8
         OGYenYCYmvcmVo4KM1oGsGNKU7ktDHgaN0CqUl9ODlNj81Sii7yiHBMmiBA2np1ko6u9
         fLmGekHhv/9ZsJ01LTWPEdnUWxEh3mb2bmuuvDgj6iSSSJCh0BC7BO51EUOHUTJRXvOw
         bT2A==
X-Forwarded-Encrypted: i=1; AJvYcCWTm4zXE3QxsYqBKqzwojmgPcKzY49E3irozRPf4lM0bQNwF5Ywbcb1gSep6nLwcUTfujQvupsVBYDf5lmr@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwXhEASafwqyXQirQ/+Vn+voCgn2amQn0Ngnr57D5Qw0+qkzq
	gXSc5Du64xO6n4ko9BJD6MLXwta8VJD3NJ97PCJh+/Mc9pgTYI1fPdJgZHDiRmI=
X-Gm-Gg: ASbGncttIAqe6/rVYLx6wiODp0184vGbFjSUEn3BIMHeVeBiZBBnrWRwjQuXQeGZvq8
	kpJk4WJZI8G79rdfmRo9xtt13XMCefn5WF3kdmRh+R4150Mm+FHegaYH6ZUsPpWgbYJ05A8oEWm
	wkyfqL2Se/iociKcWIieNYAhW7/jc2zyznBGGjsZ9UOwrNgqJi/cJmDR7nwhrFzzpdK3oZVax33
	CFpfV5052TUfqQBoqYZpNEc92NWEMpocRw9dVCQiFKFev9PEJOBJHYgfOy1op4RcUxR9ji4Mn/4
	qlZGw6B6RkaIFu7ElK9ZhSUCl24lusof
X-Google-Smtp-Source: AGHT+IF9BCFd8Vuk5OoUZatTbIoQxqk7c+mThZbCTd2VRyqlDfu+KqYGmtOsOl2YC+wnZ5AaWfvdZw==
X-Received: by 2002:a05:6830:700b:b0:724:997f:3a4d with SMTP id 46e09a7af769-726a4290cc3mr714807a34.27.1738713801617;
        Tue, 04 Feb 2025 16:03:21 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:d53:ebfc:fe83:43f5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726617eb64csm3666413a34.37.2025.02.04.16.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:03:20 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [RFC PATCH 1/4] ceph: extend ceph_writeback_ctl for ceph_writepages_start() refactoring
Date: Tue,  4 Feb 2025 16:02:46 -0800
Message-ID: <20250205000249.123054-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205000249.123054-1-slava@dubeyko.com>
References: <20250205000249.123054-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The ceph_writepages_start() has unreasonably huge size and
complex logic that makes this method hard to understand.
Current state of the method's logic makes bug fix really
hard task. This patch extends the struct ceph_writeback_ctl
with the goal to make ceph_writepages_start() method
more compact and easy to understand by means of deep refactoring.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/addr.c | 487 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 302 insertions(+), 185 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f5224a566b69..d002ff62d867 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -568,7 +568,36 @@ struct ceph_writeback_ctl
 	u64 truncate_size;
 	u32 truncate_seq;
 	bool size_stable;
+
 	bool head_snapc;
+	struct ceph_snap_context *snapc;
+	struct ceph_snap_context *last_snapc;
+
+	bool done;
+	bool should_loop;
+	bool range_whole;
+	pgoff_t start_index;
+	pgoff_t index;
+	pgoff_t end;
+	xa_mark_t tag;
+
+	pgoff_t strip_unit_end;
+	unsigned int wsize;
+	unsigned int nr_folios;
+	unsigned int max_pages;
+	unsigned int locked_pages;
+
+	int op_idx;
+	int num_ops;
+	u64 offset;
+	u64 len;
+
+	struct folio_batch fbatch;
+	unsigned int processed_in_fbatch;
+
+	bool from_pool;
+	struct page **pages;
+	struct page **data_pages;
 };
 
 /*
@@ -949,6 +978,74 @@ static void writepages_finish(struct ceph_osd_request *req)
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
 }
 
+static inline
+unsigned int ceph_define_write_size(struct address_space *mapping)
+{
+	struct inode *inode = mapping->host;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	unsigned int wsize = i_blocksize(inode);
+
+	if (fsc->mount_options->wsize < wsize)
+		wsize = fsc->mount_options->wsize;
+
+	return wsize;
+}
+
+static inline
+void ceph_folio_batch_init(struct ceph_writeback_ctl *ceph_wbc)
+{
+	folio_batch_init(&ceph_wbc->fbatch);
+	ceph_wbc->processed_in_fbatch = 0;
+}
+
+static inline
+void ceph_folio_batch_reinit(struct ceph_writeback_ctl *ceph_wbc)
+{
+	folio_batch_release(&ceph_wbc->fbatch);
+	ceph_folio_batch_init(ceph_wbc);
+}
+
+static inline
+void ceph_init_writeback_ctl(struct address_space *mapping,
+			     struct writeback_control *wbc,
+			     struct ceph_writeback_ctl *ceph_wbc)
+{
+	ceph_wbc->snapc = NULL;
+	ceph_wbc->last_snapc = NULL;
+
+	ceph_wbc->strip_unit_end = 0;
+	ceph_wbc->wsize = ceph_define_write_size(mapping);
+
+	ceph_wbc->nr_folios = 0;
+	ceph_wbc->max_pages = 0;
+	ceph_wbc->locked_pages = 0;
+
+	ceph_wbc->done = false;
+	ceph_wbc->should_loop = false;
+	ceph_wbc->range_whole = false;
+
+	ceph_wbc->start_index = wbc->range_cyclic ? mapping->writeback_index : 0;
+	ceph_wbc->index = ceph_wbc->start_index;
+	ceph_wbc->end = -1;
+
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
+		ceph_wbc->tag = PAGECACHE_TAG_TOWRITE;
+	} else {
+		ceph_wbc->tag = PAGECACHE_TAG_DIRTY;
+	}
+
+	ceph_wbc->op_idx = -1;
+	ceph_wbc->num_ops = 0;
+	ceph_wbc->offset = 0;
+	ceph_wbc->len = 0;
+	ceph_wbc->from_pool = false;
+
+	ceph_folio_batch_init(ceph_wbc);
+
+	ceph_wbc->pages = NULL;
+	ceph_wbc->data_pages = NULL;
+}
+
 /*
  * initiate async writeback
  */
@@ -960,17 +1057,11 @@ static int ceph_writepages_start(struct address_space *mapping,
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = fsc->client;
 	struct ceph_vino vino = ceph_vino(inode);
-	pgoff_t index, start_index, end = -1;
-	struct ceph_snap_context *snapc = NULL, *last_snapc = NULL, *pgsnapc;
-	struct folio_batch fbatch;
-	int rc = 0;
-	unsigned int wsize = i_blocksize(inode);
-	struct ceph_osd_request *req = NULL;
+	struct ceph_snap_context *pgsnapc;
 	struct ceph_writeback_ctl ceph_wbc;
-	bool should_loop, range_whole = false;
-	bool done = false;
+	struct ceph_osd_request *req = NULL;
+	int rc = 0;
 	bool caching = ceph_is_cache_enabled(inode);
-	xa_mark_t tag;
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
 	    fsc->write_congested)
@@ -989,86 +1080,78 @@ static int ceph_writepages_start(struct address_space *mapping,
 		mapping_set_error(mapping, -EIO);
 		return -EIO; /* we're in a forced umount, don't write! */
 	}
-	if (fsc->mount_options->wsize < wsize)
-		wsize = fsc->mount_options->wsize;
 
-	folio_batch_init(&fbatch);
+	ceph_init_writeback_ctl(mapping, wbc, &ceph_wbc);
 
-	start_index = wbc->range_cyclic ? mapping->writeback_index : 0;
-	index = start_index;
-
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
-		tag = PAGECACHE_TAG_TOWRITE;
-	} else {
-		tag = PAGECACHE_TAG_DIRTY;
-	}
 retry:
 	/* find oldest snap context with dirty data */
-	snapc = get_oldest_context(inode, &ceph_wbc, NULL);
-	if (!snapc) {
+	ceph_wbc.snapc = get_oldest_context(inode, &ceph_wbc, NULL);
+	if (!ceph_wbc.snapc) {
 		/* hmm, why does writepages get called when there
 		   is no dirty data? */
 		doutc(cl, " no snap context with dirty data?\n");
 		goto out;
 	}
-	doutc(cl, " oldest snapc is %p seq %lld (%d snaps)\n", snapc,
-	      snapc->seq, snapc->num_snaps);
+	doutc(cl, " oldest snapc is %p seq %lld (%d snaps)\n",
+	      ceph_wbc.snapc, ceph_wbc.snapc->seq,
+	      ceph_wbc.snapc->num_snaps);
 
-	should_loop = false;
-	if (ceph_wbc.head_snapc && snapc != last_snapc) {
+	ceph_wbc.should_loop = false;
+	if (ceph_wbc.head_snapc && ceph_wbc.snapc != ceph_wbc.last_snapc) {
 		/* where to start/end? */
 		if (wbc->range_cyclic) {
-			index = start_index;
-			end = -1;
-			if (index > 0)
-				should_loop = true;
-			doutc(cl, " cyclic, start at %lu\n", index);
+			ceph_wbc.index = ceph_wbc.start_index;
+			ceph_wbc.end = -1;
+			if (ceph_wbc.index > 0)
+				ceph_wbc.should_loop = true;
+			doutc(cl, " cyclic, start at %lu\n", ceph_wbc.index);
 		} else {
-			index = wbc->range_start >> PAGE_SHIFT;
-			end = wbc->range_end >> PAGE_SHIFT;
+			ceph_wbc.index = wbc->range_start >> PAGE_SHIFT;
+			ceph_wbc.end = wbc->range_end >> PAGE_SHIFT;
 			if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-				range_whole = true;
-			doutc(cl, " not cyclic, %lu to %lu\n", index, end);
+				ceph_wbc.range_whole = true;
+			doutc(cl, " not cyclic, %lu to %lu\n",
+			      ceph_wbc.index, ceph_wbc.end);
 		}
 	} else if (!ceph_wbc.head_snapc) {
 		/* Do not respect wbc->range_{start,end}. Dirty pages
 		 * in that range can be associated with newer snapc.
 		 * They are not writeable until we write all dirty pages
 		 * associated with 'snapc' get written */
-		if (index > 0)
-			should_loop = true;
+		if (ceph_wbc.index > 0)
+			ceph_wbc.should_loop = true;
 		doutc(cl, " non-head snapc, range whole\n");
 	}
 
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag_pages_for_writeback(mapping, index, end);
+		tag_pages_for_writeback(mapping, ceph_wbc.index, ceph_wbc.end);
 
-	ceph_put_snap_context(last_snapc);
-	last_snapc = snapc;
+	ceph_put_snap_context(ceph_wbc.last_snapc);
+	ceph_wbc.last_snapc = ceph_wbc.snapc;
 
-	while (!done && index <= end) {
-		int num_ops = 0, op_idx;
-		unsigned i, nr_folios, max_pages, locked_pages = 0;
-		struct page **pages = NULL, **data_pages;
+	while (!ceph_wbc.done && ceph_wbc.index <= ceph_wbc.end) {
+		unsigned i;
 		struct page *page;
-		pgoff_t strip_unit_end = 0;
-		u64 offset = 0, len = 0;
-		bool from_pool = false;
 
-		max_pages = wsize >> PAGE_SHIFT;
+		ceph_wbc.max_pages = ceph_wbc.wsize >> PAGE_SHIFT;
 
 get_more_pages:
-		nr_folios = filemap_get_folios_tag(mapping, &index,
-						   end, tag, &fbatch);
-		doutc(cl, "pagevec_lookup_range_tag got %d\n", nr_folios);
-		if (!nr_folios && !locked_pages)
+		ceph_wbc.nr_folios = filemap_get_folios_tag(mapping,
+							    &ceph_wbc.index,
+							    ceph_wbc.end,
+							    ceph_wbc.tag,
+							    &ceph_wbc.fbatch);
+		doutc(cl, "pagevec_lookup_range_tag got %d\n",
+			ceph_wbc.nr_folios);
+		if (!ceph_wbc.nr_folios && !ceph_wbc.locked_pages)
 			break;
-		for (i = 0; i < nr_folios && locked_pages < max_pages; i++) {
-			struct folio *folio = fbatch.folios[i];
+		for (i = 0; i < ceph_wbc.nr_folios &&
+			    ceph_wbc.locked_pages < ceph_wbc.max_pages; i++) {
+			struct folio *folio = ceph_wbc.fbatch.folios[i];
 
 			page = &folio->page;
 			doutc(cl, "? %p idx %lu\n", page, page->index);
-			if (locked_pages == 0)
+			if (ceph_wbc.locked_pages == 0)
 				lock_page(page);  /* first page */
 			else if (!trylock_page(page))
 				break;
@@ -1082,13 +1165,14 @@ static int ceph_writepages_start(struct address_space *mapping,
 			}
 			/* only if matching snap context */
 			pgsnapc = page_snap_context(page);
-			if (pgsnapc != snapc) {
+			if (pgsnapc != ceph_wbc.snapc) {
 				doutc(cl, "page snapc %p %lld != oldest %p %lld\n",
-				      pgsnapc, pgsnapc->seq, snapc, snapc->seq);
-				if (!should_loop &&
+				      pgsnapc, pgsnapc->seq,
+				      ceph_wbc.snapc, ceph_wbc.snapc->seq);
+				if (!ceph_wbc.should_loop &&
 				    !ceph_wbc.head_snapc &&
 				    wbc->sync_mode != WB_SYNC_NONE)
-					should_loop = true;
+					ceph_wbc.should_loop = true;
 				unlock_page(page);
 				continue;
 			}
@@ -1103,7 +1187,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 				folio_unlock(folio);
 				continue;
 			}
-			if (strip_unit_end && (page->index > strip_unit_end)) {
+			if (ceph_wbc.strip_unit_end &&
+			    (page->index > ceph_wbc.strip_unit_end)) {
 				doutc(cl, "end of strip unit %p\n", page);
 				unlock_page(page);
 				break;
@@ -1132,47 +1217,52 @@ static int ceph_writepages_start(struct address_space *mapping,
 			 * calculate max possinle write size and
 			 * allocate a page array
 			 */
-			if (locked_pages == 0) {
+			if (ceph_wbc.locked_pages == 0) {
 				u64 objnum;
 				u64 objoff;
 				u32 xlen;
 
 				/* prepare async write request */
-				offset = (u64)page_offset(page);
+				ceph_wbc.offset = (u64)page_offset(page);
 				ceph_calc_file_object_mapping(&ci->i_layout,
-							      offset, wsize,
+							      ceph_wbc.offset,
+							      ceph_wbc.wsize,
 							      &objnum, &objoff,
 							      &xlen);
-				len = xlen;
+				ceph_wbc.len = xlen;
 
-				num_ops = 1;
-				strip_unit_end = page->index +
-					((len - 1) >> PAGE_SHIFT);
+				ceph_wbc.num_ops = 1;
+				ceph_wbc.strip_unit_end = page->index +
+					((ceph_wbc.len - 1) >> PAGE_SHIFT);
 
-				BUG_ON(pages);
-				max_pages = calc_pages_for(0, (u64)len);
-				pages = kmalloc_array(max_pages,
-						      sizeof(*pages),
+				BUG_ON(ceph_wbc.pages);
+				ceph_wbc.max_pages =
+					calc_pages_for(0, (u64)ceph_wbc.len);
+				ceph_wbc.pages = kmalloc_array(ceph_wbc.max_pages,
+						      sizeof(*ceph_wbc.pages),
 						      GFP_NOFS);
-				if (!pages) {
-					from_pool = true;
-					pages = mempool_alloc(ceph_wb_pagevec_pool, GFP_NOFS);
-					BUG_ON(!pages);
+				if (!ceph_wbc.pages) {
+					ceph_wbc.from_pool = true;
+					ceph_wbc.pages =
+						mempool_alloc(ceph_wb_pagevec_pool,
+								GFP_NOFS);
+					BUG_ON(!ceph_wbc.pages);
 				}
 
-				len = 0;
+				ceph_wbc.len = 0;
 			} else if (page->index !=
-				   (offset + len) >> PAGE_SHIFT) {
-				if (num_ops >= (from_pool ?  CEPH_OSD_SLAB_OPS :
+				   (ceph_wbc.offset + ceph_wbc.len) >> PAGE_SHIFT) {
+				if (ceph_wbc.num_ops >=
+				    (ceph_wbc.from_pool ?  CEPH_OSD_SLAB_OPS :
 							     CEPH_OSD_MAX_OPS)) {
 					redirty_page_for_writepage(wbc, page);
 					unlock_page(page);
 					break;
 				}
 
-				num_ops++;
-				offset = (u64)page_offset(page);
-				len = 0;
+				ceph_wbc.num_ops++;
+				ceph_wbc.offset = (u64)page_offset(page);
+				ceph_wbc.len = 0;
 			}
 
 			/* note position of first page in fbatch */
@@ -1185,78 +1275,85 @@ static int ceph_writepages_start(struct address_space *mapping,
 				fsc->write_congested = true;
 
 			if (IS_ENCRYPTED(inode)) {
-				pages[locked_pages] =
+				ceph_wbc.pages[ceph_wbc.locked_pages] =
 					fscrypt_encrypt_pagecache_blocks(page,
 						PAGE_SIZE, 0,
-						locked_pages ? GFP_NOWAIT : GFP_NOFS);
-				if (IS_ERR(pages[locked_pages])) {
-					if (PTR_ERR(pages[locked_pages]) == -EINVAL)
+						ceph_wbc.locked_pages ?
+							GFP_NOWAIT : GFP_NOFS);
+				if (IS_ERR(ceph_wbc.pages[ceph_wbc.locked_pages])) {
+					if (PTR_ERR(ceph_wbc.pages[ceph_wbc.locked_pages]) == -EINVAL)
 						pr_err_client(cl,
 							"inode->i_blkbits=%hhu\n",
 							inode->i_blkbits);
 					/* better not fail on first page! */
-					BUG_ON(locked_pages == 0);
-					pages[locked_pages] = NULL;
+					BUG_ON(ceph_wbc.locked_pages == 0);
+					ceph_wbc.pages[ceph_wbc.locked_pages] = NULL;
 					redirty_page_for_writepage(wbc, page);
 					unlock_page(page);
 					break;
 				}
-				++locked_pages;
+				++ceph_wbc.locked_pages;
 			} else {
-				pages[locked_pages++] = page;
+				ceph_wbc.pages[ceph_wbc.locked_pages++] = page;
 			}
 
-			fbatch.folios[i] = NULL;
-			len += thp_size(page);
+			ceph_wbc.fbatch.folios[i] = NULL;
+			ceph_wbc.len += thp_size(page);
 		}
 
 		/* did we get anything? */
-		if (!locked_pages)
+		if (!ceph_wbc.locked_pages)
 			goto release_folios;
 		if (i) {
 			unsigned j, n = 0;
 			/* shift unused page to beginning of fbatch */
-			for (j = 0; j < nr_folios; j++) {
-				if (!fbatch.folios[j])
+			for (j = 0; j < ceph_wbc.nr_folios; j++) {
+				if (!ceph_wbc.fbatch.folios[j])
 					continue;
-				if (n < j)
-					fbatch.folios[n] = fbatch.folios[j];
+				if (n < j) {
+					ceph_wbc.fbatch.folios[n] =
+						ceph_wbc.fbatch.folios[j];
+				}
 				n++;
 			}
-			fbatch.nr = n;
+			ceph_wbc.fbatch.nr = n;
 
-			if (nr_folios && i == nr_folios &&
-			    locked_pages < max_pages) {
+			if (ceph_wbc.nr_folios && i == ceph_wbc.nr_folios &&
+			    ceph_wbc.locked_pages < ceph_wbc.max_pages) {
 				doutc(cl, "reached end fbatch, trying for more\n");
-				folio_batch_release(&fbatch);
+				folio_batch_release(&ceph_wbc.fbatch);
 				goto get_more_pages;
 			}
 		}
 
 new_request:
-		offset = ceph_fscrypt_page_offset(pages[0]);
-		len = wsize;
+		ceph_wbc.offset = ceph_fscrypt_page_offset(ceph_wbc.pages[0]);
+		ceph_wbc.len = ceph_wbc.wsize;
 
 		req = ceph_osdc_new_request(&fsc->client->osdc,
 					&ci->i_layout, vino,
-					offset, &len, 0, num_ops,
+					ceph_wbc.offset, &ceph_wbc.len,
+					0, ceph_wbc.num_ops,
 					CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE,
-					snapc, ceph_wbc.truncate_seq,
+					ceph_wbc.snapc, ceph_wbc.truncate_seq,
 					ceph_wbc.truncate_size, false);
 		if (IS_ERR(req)) {
 			req = ceph_osdc_new_request(&fsc->client->osdc,
 						&ci->i_layout, vino,
-						offset, &len, 0,
-						min(num_ops,
+						ceph_wbc.offset, &ceph_wbc.len,
+						0, min(ceph_wbc.num_ops,
 						    CEPH_OSD_SLAB_OPS),
 						CEPH_OSD_OP_WRITE,
 						CEPH_OSD_FLAG_WRITE,
-						snapc, ceph_wbc.truncate_seq,
+						ceph_wbc.snapc,
+						ceph_wbc.truncate_seq,
 						ceph_wbc.truncate_size, true);
 			BUG_ON(IS_ERR(req));
 		}
-		BUG_ON(len < ceph_fscrypt_page_offset(pages[locked_pages - 1]) +
-			     thp_size(pages[locked_pages - 1]) - offset);
+		BUG_ON(ceph_wbc.len <
+			ceph_fscrypt_page_offset(ceph_wbc.pages[ceph_wbc.locked_pages - 1]) +
+				thp_size(ceph_wbc.pages[ceph_wbc.locked_pages - 1]) -
+					ceph_wbc.offset);
 
 		if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
 			rc = -EIO;
@@ -1266,100 +1363,118 @@ static int ceph_writepages_start(struct address_space *mapping,
 		req->r_inode = inode;
 
 		/* Format the osd request message and submit the write */
-		len = 0;
-		data_pages = pages;
-		op_idx = 0;
-		for (i = 0; i < locked_pages; i++) {
-			struct page *page = ceph_fscrypt_pagecache_page(pages[i]);
+		ceph_wbc.len = 0;
+		ceph_wbc.data_pages = ceph_wbc.pages;
+		ceph_wbc.op_idx = 0;
+		for (i = 0; i < ceph_wbc.locked_pages; i++) {
+			struct page *page =
+				ceph_fscrypt_pagecache_page(ceph_wbc.pages[i]);
 
 			u64 cur_offset = page_offset(page);
 			/*
 			 * Discontinuity in page range? Ceph can handle that by just passing
 			 * multiple extents in the write op.
 			 */
-			if (offset + len != cur_offset) {
+			if (ceph_wbc.offset + ceph_wbc.len != cur_offset) {
 				/* If it's full, stop here */
-				if (op_idx + 1 == req->r_num_ops)
+				if (ceph_wbc.op_idx + 1 == req->r_num_ops)
 					break;
 
 				/* Kick off an fscache write with what we have so far. */
-				ceph_fscache_write_to_cache(inode, offset, len, caching);
+				ceph_fscache_write_to_cache(inode, ceph_wbc.offset,
+							    ceph_wbc.len, caching);
 
 				/* Start a new extent */
-				osd_req_op_extent_dup_last(req, op_idx,
-							   cur_offset - offset);
-				doutc(cl, "got pages at %llu~%llu\n", offset,
-				      len);
-				osd_req_op_extent_osd_data_pages(req, op_idx,
-							data_pages, len, 0,
-							from_pool, false);
-				osd_req_op_extent_update(req, op_idx, len);
-
-				len = 0;
-				offset = cur_offset;
-				data_pages = pages + i;
-				op_idx++;
+				osd_req_op_extent_dup_last(req, ceph_wbc.op_idx,
+							   cur_offset -
+								ceph_wbc.offset);
+				doutc(cl, "got pages at %llu~%llu\n",
+					ceph_wbc.offset,
+					ceph_wbc.len);
+				osd_req_op_extent_osd_data_pages(req,
+							ceph_wbc.op_idx,
+							ceph_wbc.data_pages,
+							ceph_wbc.len, 0,
+							ceph_wbc.from_pool, false);
+				osd_req_op_extent_update(req, ceph_wbc.op_idx,
+							 ceph_wbc.len);
+
+				ceph_wbc.len = 0;
+				ceph_wbc.offset = cur_offset;
+				ceph_wbc.data_pages = ceph_wbc.pages + i;
+				ceph_wbc.op_idx++;
 			}
 
 			set_page_writeback(page);
 			if (caching)
 				ceph_set_page_fscache(page);
-			len += thp_size(page);
+			ceph_wbc.len += thp_size(page);
 		}
-		ceph_fscache_write_to_cache(inode, offset, len, caching);
+		ceph_fscache_write_to_cache(inode, ceph_wbc.offset,
+					    ceph_wbc.len, caching);
 
 		if (ceph_wbc.size_stable) {
-			len = min(len, ceph_wbc.i_size - offset);
-		} else if (i == locked_pages) {
+			ceph_wbc.len = min(ceph_wbc.len,
+					    ceph_wbc.i_size - ceph_wbc.offset);
+		} else if (i == ceph_wbc.locked_pages) {
 			/* writepages_finish() clears writeback pages
 			 * according to the data length, so make sure
 			 * data length covers all locked pages */
-			u64 min_len = len + 1 - thp_size(page);
-			len = get_writepages_data_length(inode, pages[i - 1],
-							 offset);
-			len = max(len, min_len);
+			u64 min_len = ceph_wbc.len + 1 - thp_size(page);
+			ceph_wbc.len =
+				get_writepages_data_length(inode,
+							ceph_wbc.pages[i - 1],
+							ceph_wbc.offset);
+			ceph_wbc.len = max(ceph_wbc.len, min_len);
+		}
+		if (IS_ENCRYPTED(inode)) {
+			ceph_wbc.len = round_up(ceph_wbc.len,
+						CEPH_FSCRYPT_BLOCK_SIZE);
 		}
-		if (IS_ENCRYPTED(inode))
-			len = round_up(len, CEPH_FSCRYPT_BLOCK_SIZE);
 
-		doutc(cl, "got pages at %llu~%llu\n", offset, len);
+		doutc(cl, "got pages at %llu~%llu\n",
+			ceph_wbc.offset, ceph_wbc.len);
 
 		if (IS_ENCRYPTED(inode) &&
-		    ((offset | len) & ~CEPH_FSCRYPT_BLOCK_MASK))
+		    ((ceph_wbc.offset | ceph_wbc.len) & ~CEPH_FSCRYPT_BLOCK_MASK))
 			pr_warn_client(cl,
 				"bad encrypted write offset=%lld len=%llu\n",
-				offset, len);
+				ceph_wbc.offset, ceph_wbc.len);
 
-		osd_req_op_extent_osd_data_pages(req, op_idx, data_pages, len,
-						 0, from_pool, false);
-		osd_req_op_extent_update(req, op_idx, len);
+		osd_req_op_extent_osd_data_pages(req, ceph_wbc.op_idx,
+						 ceph_wbc.data_pages,
+						 ceph_wbc.len,
+						 0, ceph_wbc.from_pool, false);
+		osd_req_op_extent_update(req, ceph_wbc.op_idx, ceph_wbc.len);
 
-		BUG_ON(op_idx + 1 != req->r_num_ops);
+		BUG_ON(ceph_wbc.op_idx + 1 != req->r_num_ops);
 
-		from_pool = false;
-		if (i < locked_pages) {
-			BUG_ON(num_ops <= req->r_num_ops);
-			num_ops -= req->r_num_ops;
-			locked_pages -= i;
+		ceph_wbc.from_pool = false;
+		if (i < ceph_wbc.locked_pages) {
+			BUG_ON(ceph_wbc.num_ops <= req->r_num_ops);
+			ceph_wbc.num_ops -= req->r_num_ops;
+			ceph_wbc.locked_pages -= i;
 
 			/* allocate new pages array for next request */
-			data_pages = pages;
-			pages = kmalloc_array(locked_pages, sizeof(*pages),
-					      GFP_NOFS);
-			if (!pages) {
-				from_pool = true;
-				pages = mempool_alloc(ceph_wb_pagevec_pool, GFP_NOFS);
-				BUG_ON(!pages);
+			ceph_wbc.data_pages = ceph_wbc.pages;
+			ceph_wbc.pages = kmalloc_array(ceph_wbc.locked_pages,
+							sizeof(*ceph_wbc.pages),
+							GFP_NOFS);
+			if (!ceph_wbc.pages) {
+				ceph_wbc.from_pool = true;
+				ceph_wbc.pages =
+					mempool_alloc(ceph_wb_pagevec_pool, GFP_NOFS);
+				BUG_ON(!ceph_wbc.pages);
 			}
-			memcpy(pages, data_pages + i,
-			       locked_pages * sizeof(*pages));
-			memset(data_pages + i, 0,
-			       locked_pages * sizeof(*pages));
+			memcpy(ceph_wbc.pages, ceph_wbc.data_pages + i,
+			       ceph_wbc.locked_pages * sizeof(*ceph_wbc.pages));
+			memset(ceph_wbc.data_pages + i, 0,
+			       ceph_wbc.locked_pages * sizeof(*ceph_wbc.pages));
 		} else {
-			BUG_ON(num_ops != req->r_num_ops);
-			index = pages[i - 1]->index + 1;
+			BUG_ON(ceph_wbc.num_ops != req->r_num_ops);
+			ceph_wbc.index = ceph_wbc.pages[i - 1]->index + 1;
 			/* request message now owns the pages array */
-			pages = NULL;
+			ceph_wbc.pages = NULL;
 		}
 
 		req->r_mtime = inode_get_mtime(inode);
@@ -1367,7 +1482,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 		req = NULL;
 
 		wbc->nr_to_write -= i;
-		if (pages)
+		if (ceph_wbc.pages)
 			goto new_request;
 
 		/*
@@ -1377,54 +1492,56 @@ static int ceph_writepages_start(struct address_space *mapping,
 		 * we tagged for writeback prior to entering this loop.
 		 */
 		if (wbc->nr_to_write <= 0 && wbc->sync_mode == WB_SYNC_NONE)
-			done = true;
+			ceph_wbc.done = true;
 
 release_folios:
 		doutc(cl, "folio_batch release on %d folios (%p)\n",
-		      (int)fbatch.nr, fbatch.nr ? fbatch.folios[0] : NULL);
-		folio_batch_release(&fbatch);
+		      (int)ceph_wbc.fbatch.nr,
+		      ceph_wbc.fbatch.nr ? ceph_wbc.fbatch.folios[0] : NULL);
+		folio_batch_release(&ceph_wbc.fbatch);
 	}
 
-	if (should_loop && !done) {
+	if (ceph_wbc.should_loop && !ceph_wbc.done) {
 		/* more to do; loop back to beginning of file */
 		doutc(cl, "looping back to beginning of file\n");
-		end = start_index - 1; /* OK even when start_index == 0 */
+		ceph_wbc.end = ceph_wbc.start_index - 1; /* OK even when start_index == 0 */
 
 		/* to write dirty pages associated with next snapc,
 		 * we need to wait until current writes complete */
 		if (wbc->sync_mode != WB_SYNC_NONE &&
-		    start_index == 0 && /* all dirty pages were checked */
+		    ceph_wbc.start_index == 0 && /* all dirty pages were checked */
 		    !ceph_wbc.head_snapc) {
 			struct page *page;
 			unsigned i, nr;
-			index = 0;
-			while ((index <= end) &&
-			       (nr = filemap_get_folios_tag(mapping, &index,
+			ceph_wbc.index = 0;
+			while ((ceph_wbc.index <= ceph_wbc.end) &&
+			       (nr = filemap_get_folios_tag(mapping,
+						&ceph_wbc.index,
 						(pgoff_t)-1,
 						PAGECACHE_TAG_WRITEBACK,
-						&fbatch))) {
+						&ceph_wbc.fbatch))) {
 				for (i = 0; i < nr; i++) {
-					page = &fbatch.folios[i]->page;
-					if (page_snap_context(page) != snapc)
+					page = &ceph_wbc.fbatch.folios[i]->page;
+					if (page_snap_context(page) != ceph_wbc.snapc)
 						continue;
 					wait_on_page_writeback(page);
 				}
-				folio_batch_release(&fbatch);
+				folio_batch_release(&ceph_wbc.fbatch);
 				cond_resched();
 			}
 		}
 
-		start_index = 0;
-		index = 0;
+		ceph_wbc.start_index = 0;
+		ceph_wbc.index = 0;
 		goto retry;
 	}
 
-	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
-		mapping->writeback_index = index;
+	if (wbc->range_cyclic || (ceph_wbc.range_whole && wbc->nr_to_write > 0))
+		mapping->writeback_index = ceph_wbc.index;
 
 out:
 	ceph_osdc_put_request(req);
-	ceph_put_snap_context(last_snapc);
+	ceph_put_snap_context(ceph_wbc.last_snapc);
 	doutc(cl, "%llx.%llx dend - startone, rc = %d\n", ceph_vinop(inode),
 	      rc);
 	return rc;
-- 
2.48.0


