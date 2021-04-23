Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B436931E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbhDWN3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59106 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242768AbhDWN3P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619184518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Fthp8friIau9LQqnjujGfu31W6GtpUqQ0HW4o6b0bA=;
        b=AmKdn879MpNFHgbjVce5eO8WZHOvUNEuHZDjSDWWYaV2dCYt1QKEk49ivASg7a+iIGGORT
        pkkFskCgfYyHqW8F3HEJZwxDxFXCuSqmBFg2wnOsvLmfBr+9ZAet1fkKqIGiP0iVMb7IF5
        /90VQPXfRVAv6emgaYRJuBzy6toV+PQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-_kPe6VtcOuqP3GgS4gz4eg-1; Fri, 23 Apr 2021 09:28:36 -0400
X-MC-Unique: _kPe6VtcOuqP3GgS4gz4eg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFDED80D6A8;
        Fri, 23 Apr 2021 13:28:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A95D19C71;
        Fri, 23 Apr 2021 13:28:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v7 03/31] mm/filemap: Pass the file_ra_state in the ractl
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 23 Apr 2021 14:28:29 +0100
Message-ID: <161918450961.3145707.1322623921347765852.stgit@warthog.procyon.org.uk>
In-Reply-To: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
References: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox (Oracle) <willy@infradead.org>

For readahead_expand(), we need to modify the file ra_state, so pass it
down by adding it to the ractl.  We have to do this because it's not always
the same as f_ra in the struct file that is already being passed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Dave Wysochanski <dwysocha@redhat.com>
Tested-By: Marc Dionne <marc.dionne@auristor.com>
Link: https://lore.kernel.org/r/20210407201857.3582797-2-willy@infradead.org/
Link: https://lore.kernel.org/r/161789067431.6155.8063840447229665720.stgit@warthog.procyon.org.uk/ # v6
---

 fs/ext4/verity.c        |    2 +-
 fs/f2fs/file.c          |    2 +-
 fs/f2fs/verity.c        |    2 +-
 include/linux/pagemap.h |   20 +++++++++++---------
 mm/filemap.c            |    4 ++--
 mm/internal.h           |    7 +++----
 mm/readahead.c          |   22 +++++++++++-----------
 7 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 00e3cbde472e..07438f46b558 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -370,7 +370,7 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
-	DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, index);
+	DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 	struct page *page;
 
 	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d26ff2ae3f5e..c1e6f669a0c4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4051,7 +4051,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 
 static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 {
-	DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, page_idx);
+	DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, page_idx);
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
 	pgoff_t redirty_idx = page_idx;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 054ec852b5ea..a7beff28a3c5 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -228,7 +228,7 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
-	DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, index);
+	DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 	struct page *page;
 
 	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bb4433c98d02..4220ded38f4b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -812,20 +812,23 @@ static inline int add_to_page_cache(struct page *page,
  * @file: The file, used primarily by network filesystems for authentication.
  *	  May be NULL if invoked internally by the filesystem.
  * @mapping: Readahead this filesystem object.
+ * @ra: File readahead state.  May be NULL.
  */
 struct readahead_control {
 	struct file *file;
 	struct address_space *mapping;
+	struct file_ra_state *ra;
 /* private: use the readahead_* accessors instead */
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
 };
 
-#define DEFINE_READAHEAD(rac, f, m, i)					\
-	struct readahead_control rac = {				\
+#define DEFINE_READAHEAD(ractl, f, r, m, i)				\
+	struct readahead_control ractl = {				\
 		.file = f,						\
 		.mapping = m,						\
+		.ra = r,						\
 		._index = i,						\
 	}
 
@@ -833,10 +836,9 @@ struct readahead_control {
 
 void page_cache_ra_unbounded(struct readahead_control *,
 		unsigned long nr_to_read, unsigned long lookahead_count);
-void page_cache_sync_ra(struct readahead_control *, struct file_ra_state *,
+void page_cache_sync_ra(struct readahead_control *, unsigned long req_count);
+void page_cache_async_ra(struct readahead_control *, struct page *,
 		unsigned long req_count);
-void page_cache_async_ra(struct readahead_control *, struct file_ra_state *,
-		struct page *, unsigned long req_count);
 
 /**
  * page_cache_sync_readahead - generic file readahead
@@ -856,8 +858,8 @@ void page_cache_sync_readahead(struct address_space *mapping,
 		struct file_ra_state *ra, struct file *file, pgoff_t index,
 		unsigned long req_count)
 {
-	DEFINE_READAHEAD(ractl, file, mapping, index);
-	page_cache_sync_ra(&ractl, ra, req_count);
+	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
+	page_cache_sync_ra(&ractl, req_count);
 }
 
 /**
@@ -879,8 +881,8 @@ void page_cache_async_readahead(struct address_space *mapping,
 		struct file_ra_state *ra, struct file *file,
 		struct page *page, pgoff_t index, unsigned long req_count)
 {
-	DEFINE_READAHEAD(ractl, file, mapping, index);
-	page_cache_async_ra(&ractl, ra, page, req_count);
+	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
+	page_cache_async_ra(&ractl, page, req_count);
 }
 
 /**
diff --git a/mm/filemap.c b/mm/filemap.c
index afe22f09960e..46e0321ba87a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2832,7 +2832,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
-	DEFINE_READAHEAD(ractl, file, mapping, vmf->pgoff);
+	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
@@ -2844,7 +2844,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 
 	if (vmf->vma->vm_flags & VM_SEQ_READ) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-		page_cache_sync_ra(&ractl, ra, ra->ra_pages);
+		page_cache_sync_ra(&ractl, ra->ra_pages);
 		return fpin;
 	}
 
diff --git a/mm/internal.h b/mm/internal.h
index 1432feec62df..83a07b2a7b1f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -51,13 +51,12 @@ void unmap_page_range(struct mmu_gather *tlb,
 
 void do_page_cache_ra(struct readahead_control *, unsigned long nr_to_read,
 		unsigned long lookahead_size);
-void force_page_cache_ra(struct readahead_control *, struct file_ra_state *,
-		unsigned long nr);
+void force_page_cache_ra(struct readahead_control *, unsigned long nr);
 static inline void force_page_cache_readahead(struct address_space *mapping,
 		struct file *file, pgoff_t index, unsigned long nr_to_read)
 {
-	DEFINE_READAHEAD(ractl, file, mapping, index);
-	force_page_cache_ra(&ractl, &file->f_ra, nr_to_read);
+	DEFINE_READAHEAD(ractl, file, &file->f_ra, mapping, index);
+	force_page_cache_ra(&ractl, nr_to_read);
 }
 
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
diff --git a/mm/readahead.c b/mm/readahead.c
index c5b0457415be..2088569a947e 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -272,9 +272,10 @@ void do_page_cache_ra(struct readahead_control *ractl,
  * memory at once.
  */
 void force_page_cache_ra(struct readahead_control *ractl,
-		struct file_ra_state *ra, unsigned long nr_to_read)
+		unsigned long nr_to_read)
 {
 	struct address_space *mapping = ractl->mapping;
+	struct file_ra_state *ra = ractl->ra;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages, index;
 
@@ -433,10 +434,10 @@ static int try_context_readahead(struct address_space *mapping,
  * A minimal readahead algorithm for trivial sequential/random reads.
  */
 static void ondemand_readahead(struct readahead_control *ractl,
-		struct file_ra_state *ra, bool hit_readahead_marker,
-		unsigned long req_size)
+		bool hit_readahead_marker, unsigned long req_size)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(ractl->mapping->host);
+	struct file_ra_state *ra = ractl->ra;
 	unsigned long max_pages = ra->ra_pages;
 	unsigned long add_pages;
 	unsigned long index = readahead_index(ractl);
@@ -550,7 +551,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 }
 
 void page_cache_sync_ra(struct readahead_control *ractl,
-		struct file_ra_state *ra, unsigned long req_count)
+		unsigned long req_count)
 {
 	bool do_forced_ra = ractl->file && (ractl->file->f_mode & FMODE_RANDOM);
 
@@ -560,7 +561,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	 * read-ahead will do the right thing and limit the read to just the
 	 * requested range, which we'll set to 1 page for this case.
 	 */
-	if (!ra->ra_pages || blk_cgroup_congested()) {
+	if (!ractl->ra->ra_pages || blk_cgroup_congested()) {
 		if (!ractl->file)
 			return;
 		req_count = 1;
@@ -569,21 +570,20 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 
 	/* be dumb */
 	if (do_forced_ra) {
-		force_page_cache_ra(ractl, ra, req_count);
+		force_page_cache_ra(ractl, req_count);
 		return;
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(ractl, ra, false, req_count);
+	ondemand_readahead(ractl, false, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_ra);
 
 void page_cache_async_ra(struct readahead_control *ractl,
-		struct file_ra_state *ra, struct page *page,
-		unsigned long req_count)
+		struct page *page, unsigned long req_count)
 {
 	/* no read-ahead */
-	if (!ra->ra_pages)
+	if (!ractl->ra->ra_pages)
 		return;
 
 	/*
@@ -604,7 +604,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(ractl, ra, true, req_count);
+	ondemand_readahead(ractl, true, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_ra);
 


