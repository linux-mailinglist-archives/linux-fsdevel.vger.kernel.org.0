Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D490942409C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 16:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbhJFPBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 11:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbhJFPBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:01:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EB0C061746
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Oct 2021 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hmxirDCVKdmy112BtA+cnDqJwLBS8QXg/tyzMLTtwkM=; b=konOVpAiwD3TNBBb3BoSzPKCb+
        tGKeovNCyE3V+mdh54Ae0NIeP3ew9dPQZWYpEcTIpbPqVOTP6TbPqtaGr021Nw1kb0pDqae/H4ClN
        B0wJ0nsQgbH80bNpYa8GYB2SPNfIl6G1nyTDW7xzgQZxvVDQPhhaJj7fahgm3EztVNdctJBgBeHjr
        lfM70qG++KLBQ6GZVN+sCqB5l3EEi2A7KJTI7xjOkomBJn8gP7jSDgZ5LBMIpHqFdVVeT7lXWHn6A
        S5OEXVYXVAEgXYsjFP4DHYc2ig17rD9xLbcU3mqU5lxCDmfhzBbGPtOzHsozX0ACAcD/n2GtF29ZB
        0e7lkFpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mY8N4-000ztf-CW; Wed, 06 Oct 2021 14:58:26 +0000
Date:   Wed, 6 Oct 2021 15:58:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC] pgflags_t
Message-ID: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David expressed some unease about the lack of typesafety in patches
1 & 2 of the page->slab conversion [1], and I'll admit to not being
particularly a fan of passing around an unsigned long.  That crystallised
in a discussion with Kent [2] about how to lock a page when you don't know
its type (solution: every memory descriptor type starts with a
pgflags_t)

So this patch is a step towards typesafety for pgflags_lock() by
changing the type of page->flags from a bare unsigned long to a
struct encapsulating an unsigned long.  A few users can already benefit
from passing around a pgflags_t, but most just append '.f' to get at
the unsigned long.  Also, most of them only do it for logging/tracing.

[1] https://lore.kernel.org/linux-mm/02a055cd-19d6-6e1d-59bb-e9e5f9f1da5b@redhat.com/
[2] https://lore.kernel.org/linux-mm/YVyQpPuwIGFSSEQ8@casper.infradead.org/

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 4ba2a3ee4bce..666ecb07c15b 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -128,7 +128,7 @@ __setup("debugpat", pat_debug_setup);
 
 static inline enum page_cache_mode get_page_memtype(struct page *pg)
 {
-	unsigned long pg_flags = pg->flags & _PGMT_MASK;
+	unsigned long pg_flags = pg->flags.f & _PGMT_MASK;
 
 	if (pg_flags == _PGMT_WB)
 		return _PAGE_CACHE_MODE_WB;
@@ -144,8 +144,8 @@ static inline void set_page_memtype(struct page *pg,
 				    enum page_cache_mode memtype)
 {
 	unsigned long memtype_flags;
-	unsigned long old_flags;
-	unsigned long new_flags;
+	pgflags_t old_flags;
+	pgflags_t new_flags;
 
 	switch (memtype) {
 	case _PAGE_CACHE_MODE_WC:
@@ -165,8 +165,8 @@ static inline void set_page_memtype(struct page *pg,
 
 	do {
 		old_flags = pg->flags;
-		new_flags = (old_flags & _PGMT_CLEAR_MASK) | memtype_flags;
-	} while (cmpxchg(&pg->flags, old_flags, new_flags) != old_flags);
+		new_flags.f = (old_flags.f & _PGMT_CLEAR_MASK) | memtype_flags;
+	} while (cmpxchg(&pg->flags, old_flags, new_flags).f != old_flags.f);
 }
 #else
 static inline enum page_cache_mode get_page_memtype(struct page *pg)
diff --git a/fs/afs/file.c b/fs/afs/file.c
index e6c447ae91f3..540498eb7418 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -474,7 +474,7 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
 
 	_enter("{{%llx:%llu}[%lu],%lx},%x",
-	       vnode->fid.vid, vnode->fid.vnode, page->index, page->flags,
+	       vnode->fid.vid, vnode->fid.vnode, page->index, page->flags.f,
 	       gfp_flags);
 
 	/* deny if page is being written to the cache and the caller hasn't
diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 8ffc40e84a59..200eb0a82684 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -36,7 +36,7 @@ static int cachefiles_read_waiter(wait_queue_entry_t *wait, unsigned mode,
 	if (key->page != page || key->bit_nr != PG_locked)
 		return 0;
 
-	_debug("--- monitor %p %lx ---", page, page->flags);
+	_debug("--- monitor %p %lx ---", page, page->flags.f);
 
 	if (!PageUptodate(page) && !PageError(page)) {
 		/* unlocked, not uptodate and not erronous? */
@@ -82,7 +82,7 @@ static int cachefiles_read_reissue(struct cachefiles_object *object,
 
 	_enter("{ino=%lx},{%lx,%lx}",
 	       d_backing_inode(object->backer)->i_ino,
-	       backpage->index, backpage->flags);
+	       backpage->index, backpage->flags.f);
 
 	/* skip if the page was truncated away completely */
 	if (backpage->mapping != bmapping) {
@@ -127,7 +127,7 @@ static int cachefiles_read_reissue(struct cachefiles_object *object,
 	 * the monitor may miss the event - so we have to ensure that we do get
 	 * one in such a case */
 	if (trylock_page(backpage)) {
-		_debug("jumpstart %p {%lx}", backpage, backpage->flags);
+		_debug("jumpstart %p {%lx}", backpage, backpage->flags.f);
 		unlock_page(backpage);
 	}
 
@@ -193,7 +193,7 @@ static void cachefiles_read_copier(struct fscache_operation *_op)
 			cachefiles_io_error_obj(
 				object,
 				"Readpage failed on backing file %lx",
-				(unsigned long) monitor->back_page->flags);
+				(unsigned long) monitor->back_page->flags.f);
 			error = -EIO;
 		}
 
@@ -301,7 +301,7 @@ static int cachefiles_read_backing_file_one(struct cachefiles_object *object,
 	 * the monitor may miss the event - so we have to ensure that we do get
 	 * one in such a case */
 	if (trylock_page(backpage)) {
-		_debug("jumpstart %p {%lx}", backpage, backpage->flags);
+		_debug("jumpstart %p {%lx}", backpage, backpage->flags.f);
 		unlock_page(backpage);
 	}
 	goto success;
@@ -324,7 +324,7 @@ static int cachefiles_read_backing_file_one(struct cachefiles_object *object,
 
 	if (!trylock_page(backpage))
 		goto monitor_backing_page;
-	_debug("read %p {%lx}", backpage, backpage->flags);
+	_debug("read %p {%lx}", backpage, backpage->flags.f);
 	goto read_backing_page;
 
 	/* the backing page is already up to date, attach the netfs
@@ -555,7 +555,7 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
 		 * installed, so the monitor may miss the event - so we have to
 		 * ensure that we do get one in such a case */
 		if (trylock_page(backpage)) {
-			_debug("2unlock %p {%lx}", backpage, backpage->flags);
+			_debug("2unlock %p {%lx}", backpage, backpage->flags.f);
 			unlock_page(backpage);
 		}
 
@@ -577,13 +577,13 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
 		if (PageUptodate(backpage))
 			goto backing_page_already_uptodate;
 
-		_debug("- not ready %p{%lx}", backpage, backpage->flags);
+		_debug("- not ready %p{%lx}", backpage, backpage->flags.f);
 
 		if (!trylock_page(backpage))
 			goto monitor_backing_page;
 
 		if (PageError(backpage)) {
-			_debug("error %lx", backpage->flags);
+			_debug("error %lx", backpage->flags.f);
 			unlock_page(backpage);
 			goto io_error;
 		}
@@ -598,7 +598,7 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
 		/* the backing page is already up to date, attach the netfs
 		 * page to the pagecache and LRU and copy the data across */
 	backing_page_already_uptodate_unlock:
-		_debug("uptodate %lx", backpage->flags);
+		_debug("uptodate %lx", backpage->flags.f);
 		unlock_page(backpage);
 	backing_page_already_uptodate:
 		_debug("- uptodate");
diff --git a/fs/fscache/page.c b/fs/fscache/page.c
index 27df94ef0e0b..8edc0c830ca2 100644
--- a/fs/fscache/page.c
+++ b/fs/fscache/page.c
@@ -961,7 +961,7 @@ int __fscache_write_page(struct fscache_cookie *cookie,
 	bool wake_cookie = false;
 	int ret;
 
-	_enter("%p,%x,", cookie, (u32) page->flags);
+	_enter("%p,%lx,", cookie, page->flags.f);
 
 	ASSERTCMP(cookie->def->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
 	ASSERT(PageFsCache(page));
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index dde341a6388a..d788869ca176 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -777,7 +777,7 @@ static int fuse_check_page(struct page *page)
 {
 	if (page_mapcount(page) ||
 	    page->mapping != NULL ||
-	    (page->flags & PAGE_FLAGS_CHECK_AT_PREP &
+	    (page->flags.f & PAGE_FLAGS_CHECK_AT_PREP &
 	     ~(1 << PG_locked |
 	       1 << PG_referenced |
 	       1 << PG_uptodate |
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 79c621c7863d..5d4fda48b69b 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -39,7 +39,7 @@ static void gfs2_ail_error(struct gfs2_glock *gl, const struct buffer_head *bh)
 	       "AIL buffer %p: blocknr %llu state 0x%08lx mapping %p page "
 	       "state 0x%lx\n",
 	       bh, (unsigned long long)bh->b_blocknr, bh->b_state,
-	       bh->b_page->mapping, bh->b_page->flags);
+	       bh->b_page->mapping, bh->b_page->flags.f);
 	fs_err(sdp, "AIL glock %u:%llu mapping %p\n",
 	       gl->gl_name.ln_type, gl->gl_name.ln_number,
 	       gfs2_glock2aspace(gl));
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 4fc8cd698d1a..f294f8235887 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -224,7 +224,7 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 		if (ret)
 			goto out_page;
 	}
-	jffs2_dbg(1, "end write_begin(). pg->flags %lx\n", pg->flags);
+	jffs2_dbg(1, "end write_begin(). pg->flags %lx\n", pg->flags.f);
 	return ret;
 
 out_page:
@@ -252,7 +252,7 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 
 	jffs2_dbg(1, "%s(): ino #%lu, page at 0x%lx, range %d-%d, flags %lx\n",
 		  __func__, inode->i_ino, pg->index << PAGE_SHIFT,
-		  start, end, pg->flags);
+		  start, end, pg->flags.f);
 
 	/* We need to avoid deadlock with page_cache_read() in
 	   jffs2_garbage_collect_pass(). So the page must be
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index d743629e05e1..648ceb95ea68 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -406,7 +406,7 @@ int __nfs_readpage_from_fscache(struct nfs_open_context *ctx,
 
 	dfprintk(FSCACHE,
 		 "NFS: readpage_from_fscache(fsc:%p/p:%p(i:%lx f:%lx)/0x%p)\n",
-		 nfs_i_fscache(inode), page, page->index, page->flags, inode);
+		 nfs_i_fscache(inode), page, page->index, page->flags.f, inode);
 
 	if (PageChecked(page)) {
 		ClearPageChecked(page);
@@ -500,13 +500,13 @@ void __nfs_readpage_to_fscache(struct inode *inode, struct page *page, int sync)
 
 	dfprintk(FSCACHE,
 		 "NFS: readpage_to_fscache(fsc:%p/p:%p(i:%lx f:%lx)/%d)\n",
-		 nfs_i_fscache(inode), page, page->index, page->flags, sync);
+		 nfs_i_fscache(inode), page, page->index, page->flags.f, sync);
 
 	ret = fscache_write_page(nfs_i_fscache(inode), page,
 				 inode->i_size, GFP_KERNEL);
 	dfprintk(FSCACHE,
 		 "NFS:     readpage_to_fscache: p:%p(i:%lu f:%lx) ret %d\n",
-		 page, page->index, page->flags, ret);
+		 page, page->index, page->flags.f, ret);
 
 	if (ret != 0) {
 		fscache_uncache_page(nfs_i_fscache(inode), page);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 171fb5cd427f..9aa99971dbbe 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -166,7 +166,7 @@ void nilfs_page_bug(struct page *page)
 	printk(KERN_CRIT "NILFS_PAGE_BUG(%p): cnt=%d index#=%llu flags=0x%lx "
 	       "mapping=%p ino=%lu\n",
 	       page, page_ref_count(page),
-	       (unsigned long long)page->index, page->flags, m, ino);
+	       (unsigned long long)page->index, page->flags.f, m, ino);
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *bh, *head;
@@ -462,7 +462,7 @@ int __nilfs_clear_page_dirty(struct page *page)
 
 	if (mapping) {
 		xa_lock_irq(&mapping->i_pages);
-		if (test_bit(PG_dirty, &page->flags)) {
+		if (PageDirty(page)) {
 			__xa_clear_mark(&mapping->i_pages, page_index(page),
 					     PAGECACHE_TAG_DIRTY);
 			xa_unlock_irq(&mapping->i_pages);
diff --git a/fs/proc/page.c b/fs/proc/page.c
index 9f1077d94cde..25b2edbb287c 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -100,14 +100,14 @@ static const struct proc_ops kpagecount_proc_ops = {
  * physical page flags.
  */
 
-static inline u64 kpf_copy_bit(u64 kflags, int ubit, int kbit)
+static inline u64 kpf_copy_bit(pgflags_t kflags, int ubit, int kbit)
 {
-	return ((kflags >> kbit) & 1) << ubit;
+	return ((kflags.f >> kbit) & 1ULL) << ubit;
 }
 
 u64 stable_page_flags(struct page *page)
 {
-	u64 k;
+	pgflags_t k;
 	u64 u;
 
 	/*
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 5cfa28cd00cd..c7d87ef84c25 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -107,7 +107,7 @@ static int do_readpage(struct page *page)
 	loff_t i_size = i_size_read(inode);
 
 	dbg_gen("ino %lu, pg %lu, i_size %lld, flags %#lx",
-		inode->i_ino, page->index, i_size, page->flags);
+		inode->i_ino, page->index, i_size, page->flags.f);
 	ubifs_assert(c, !PageChecked(page));
 	ubifs_assert(c, !PagePrivate(page));
 
@@ -614,7 +614,7 @@ static int populate_page(struct ubifs_info *c, struct page *page,
 	pgoff_t end_index;
 
 	dbg_gen("ino %lu, pg %lu, i_size %lld, flags %#lx",
-		inode->i_ino, page->index, i_size, page->flags);
+		inode->i_ino, page->index, i_size, page->flags.f);
 
 	addr = zaddr = kmap(page);
 
@@ -1013,7 +1013,7 @@ static int ubifs_writepage(struct page *page, struct writeback_control *wbc)
 	void *kaddr;
 
 	dbg_gen("ino %lu, pg %lu, pg flags %#lx",
-		inode->i_ino, page->index, page->flags);
+		inode->i_ino, page->index, page->flags.f);
 	ubifs_assert(c, PagePrivate(page));
 
 	/* Is the page fully outside @i_size? (truncate in progress) */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 73a52aba448f..39549f00abf6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1127,8 +1127,8 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
 
 static inline enum zone_type page_zonenum(const struct page *page)
 {
-	ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
-	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
+	ASSERT_EXCLUSIVE_BITS(page->flags.f, ZONES_MASK << ZONES_PGSHIFT);
+	return (page->flags.f >> ZONES_PGSHIFT) & ZONES_MASK;
 }
 
 #ifdef CONFIG_ZONE_DEVICE
@@ -1365,7 +1365,7 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
  */
 static inline int page_zone_id(struct page *page)
 {
-	return (page->flags >> ZONEID_PGSHIFT) & ZONEID_MASK;
+	return (page->flags.f >> ZONEID_PGSHIFT) & ZONEID_MASK;
 }
 
 #ifdef NODE_NOT_IN_PAGE_FLAGS
@@ -1375,7 +1375,7 @@ static inline int page_to_nid(const struct page *page)
 {
 	struct page *p = (struct page *)page;
 
-	return (PF_POISONED_CHECK(p)->flags >> NODES_PGSHIFT) & NODES_MASK;
+	return (PF_POISONED_CHECK(p)->flags.f >> NODES_PGSHIFT) & NODES_MASK;
 }
 #endif
 
@@ -1433,14 +1433,14 @@ static inline void page_cpupid_reset_last(struct page *page)
 #else
 static inline int page_cpupid_last(struct page *page)
 {
-	return (page->flags >> LAST_CPUPID_PGSHIFT) & LAST_CPUPID_MASK;
+	return (page->flags.f >> LAST_CPUPID_PGSHIFT) & LAST_CPUPID_MASK;
 }
 
 extern int page_cpupid_xchg_last(struct page *page, int cpupid);
 
 static inline void page_cpupid_reset_last(struct page *page)
 {
-	page->flags |= LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT;
+	page->flags.f |= LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT;
 }
 #endif /* LAST_CPUPID_NOT_IN_PAGE_FLAGS */
 #else /* !CONFIG_NUMA_BALANCING */
@@ -1502,7 +1502,7 @@ static inline u8 page_kasan_tag(const struct page *page)
 	u8 tag = 0xff;
 
 	if (kasan_enabled()) {
-		tag = (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
+		tag = (page->flags.f >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
 		tag ^= 0xff;
 	}
 
@@ -1513,8 +1513,8 @@ static inline void page_kasan_tag_set(struct page *page, u8 tag)
 {
 	if (kasan_enabled()) {
 		tag ^= 0xff;
-		page->flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
-		page->flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
+		page->flags.f &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
+		page->flags.f |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
 	}
 }
 
@@ -1549,13 +1549,13 @@ static inline pg_data_t *page_pgdat(const struct page *page)
 #ifdef SECTION_IN_PAGE_FLAGS
 static inline void set_page_section(struct page *page, unsigned long section)
 {
-	page->flags &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
-	page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
+	page->flags.f &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
+	page->flags.f |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
 }
 
 static inline unsigned long page_to_section(const struct page *page)
 {
-	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
+	return (page->flags.f >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
 }
 #endif
 
@@ -1575,14 +1575,14 @@ static inline bool is_pinnable_page(struct page *page)
 
 static inline void set_page_zone(struct page *page, enum zone_type zone)
 {
-	page->flags &= ~(ZONES_MASK << ZONES_PGSHIFT);
-	page->flags |= (zone & ZONES_MASK) << ZONES_PGSHIFT;
+	page->flags.f &= ~(ZONES_MASK << ZONES_PGSHIFT);
+	page->flags.f |= (zone & ZONES_MASK) << ZONES_PGSHIFT;
 }
 
 static inline void set_page_node(struct page *page, unsigned long node)
 {
-	page->flags &= ~(NODES_MASK << NODES_PGSHIFT);
-	page->flags |= (node & NODES_MASK) << NODES_PGSHIFT;
+	page->flags.f &= ~(NODES_MASK << NODES_PGSHIFT);
+	page->flags.f |= (node & NODES_MASK) << NODES_PGSHIFT;
 }
 
 static inline void set_page_links(struct page *page, enum zone_type zone,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7f8ee09c711f..e90b52938d6f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -67,8 +67,10 @@ struct mem_cgroup;
 #define _struct_page_alignment
 #endif
 
+typedef struct { unsigned long f; } pgflags_t;
+
 struct page {
-	unsigned long flags;		/* Atomic flags, some possibly
+	pgflags_t flags;		/* Atomic flags, some possibly
 					 * updated asynchronously */
 	/*
 	 * Five words (20/40 bytes) are available in this union.
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a558d67ee86f..96bb3b9cd9ed 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -200,13 +200,13 @@ static __always_inline int PageTail(struct page *page)
 
 static __always_inline int PageCompound(struct page *page)
 {
-	return test_bit(PG_head, &page->flags) || PageTail(page);
+	return test_bit(PG_head, &page->flags.f) || PageTail(page);
 }
 
 #define	PAGE_POISON_PATTERN	-1l
 static inline int PagePoisoned(const struct page *page)
 {
-	return page->flags == PAGE_POISON_PATTERN;
+	return page->flags.f == PAGE_POISON_PATTERN;
 }
 
 #ifdef CONFIG_DEBUG_VM
@@ -266,31 +266,31 @@ static inline void page_init_poison(struct page *page, size_t size)
  */
 #define TESTPAGEFLAG(uname, lname, policy)				\
 static __always_inline int Page##uname(struct page *page)		\
-	{ return test_bit(PG_##lname, &policy(page, 0)->flags); }
+	{ return test_bit(PG_##lname, &policy(page, 0)->flags.f); }
 
 #define SETPAGEFLAG(uname, lname, policy)				\
 static __always_inline void SetPage##uname(struct page *page)		\
-	{ set_bit(PG_##lname, &policy(page, 1)->flags); }
+	{ set_bit(PG_##lname, &policy(page, 1)->flags.f); }
 
 #define CLEARPAGEFLAG(uname, lname, policy)				\
 static __always_inline void ClearPage##uname(struct page *page)		\
-	{ clear_bit(PG_##lname, &policy(page, 1)->flags); }
+	{ clear_bit(PG_##lname, &policy(page, 1)->flags.f); }
 
 #define __SETPAGEFLAG(uname, lname, policy)				\
 static __always_inline void __SetPage##uname(struct page *page)		\
-	{ __set_bit(PG_##lname, &policy(page, 1)->flags); }
+	{ __set_bit(PG_##lname, &policy(page, 1)->flags.f); }
 
 #define __CLEARPAGEFLAG(uname, lname, policy)				\
 static __always_inline void __ClearPage##uname(struct page *page)	\
-	{ __clear_bit(PG_##lname, &policy(page, 1)->flags); }
+	{ __clear_bit(PG_##lname, &policy(page, 1)->flags.f); }
 
 #define TESTSETFLAG(uname, lname, policy)				\
 static __always_inline int TestSetPage##uname(struct page *page)	\
-	{ return test_and_set_bit(PG_##lname, &policy(page, 1)->flags); }
+	{ return test_and_set_bit(PG_##lname, &policy(page, 1)->flags.f); }
 
 #define TESTCLEARFLAG(uname, lname, policy)				\
 static __always_inline int TestClearPage##uname(struct page *page)	\
-	{ return test_and_clear_bit(PG_##lname, &policy(page, 1)->flags); }
+	{ return test_and_clear_bit(PG_##lname, &policy(page, 1)->flags.f); }
 
 #define PAGEFLAG(uname, lname, policy)					\
 	TESTPAGEFLAG(uname, lname, policy)				\
@@ -403,7 +403,7 @@ static __always_inline int PageSwapCache(struct page *page)
 #ifdef CONFIG_THP_SWAP
 	page = compound_head(page);
 #endif
-	return PageSwapBacked(page) && test_bit(PG_swapcache, &page->flags);
+	return PageSwapBacked(page) && test_bit(PG_swapcache, &page->flags.f);
 
 }
 SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
@@ -524,7 +524,7 @@ static inline int PageUptodate(struct page *page)
 {
 	int ret;
 	page = compound_head(page);
-	ret = test_bit(PG_uptodate, &(page)->flags);
+	ret = test_bit(PG_uptodate, &(page)->flags.f);
 	/*
 	 * Must ensure that the data we read out of the page is loaded
 	 * _after_ we've loaded page->flags to check for PageUptodate.
@@ -543,7 +543,7 @@ static __always_inline void __SetPageUptodate(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	smp_wmb();
-	__set_bit(PG_uptodate, &page->flags);
+	__set_bit(PG_uptodate, &page->flags.f);
 }
 
 static __always_inline void SetPageUptodate(struct page *page)
@@ -555,7 +555,7 @@ static __always_inline void SetPageUptodate(struct page *page)
 	 * uptodate are actually visible before PageUptodate becomes true.
 	 */
 	smp_wmb();
-	set_bit(PG_uptodate, &page->flags);
+	set_bit(PG_uptodate, &page->flags.f);
 }
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
@@ -846,7 +846,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
  */
 static inline int page_has_private(struct page *page)
 {
-	return !!(page->flags & PAGE_FLAGS_PRIVATE);
+	return !!(page->flags.f & PAGE_FLAGS_PRIVATE);
 }
 
 #undef PF_ANY
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 62db6b0176b9..c34f2b9d2bda 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -612,7 +612,7 @@ extern void unlock_page(struct page *page);
 static inline int trylock_page(struct page *page)
 {
 	page = compound_head(page);
-	return (likely(!test_and_set_bit_lock(PG_locked, &page->flags)));
+	return (likely(!test_and_set_bit_lock(PG_locked, &page->flags.f)));
 }
 
 /*
diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index 8a99c1cd417b..ae1e991f3b76 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -28,7 +28,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 
 	TP_fast_assign(
 		__entry->pfn = page_to_pfn(page);
-		__entry->flags = page->flags;
+		__entry->flags = page->flags.f;
 		__entry->count = page_ref_count(page);
 		__entry->mapcount = page_mapcount(page);
 		__entry->mapping = page->mapping;
@@ -77,7 +77,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 
 	TP_fast_assign(
 		__entry->pfn = page_to_pfn(page);
-		__entry->flags = page->flags;
+		__entry->flags = page->flags.f;
 		__entry->count = page_ref_count(page);
 		__entry->mapcount = page_mapcount(page);
 		__entry->mapping = page->mapping;
diff --git a/mm/debug.c b/mm/debug.c
index fae0f81ad831..48af9829aee9 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -162,7 +162,7 @@ static void __dump_page(struct page *page)
 out_mapping:
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 
-	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
+	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags.f, &head->flags.f,
 		page_cma ? " CMA" : "");
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
diff --git a/mm/filemap.c b/mm/filemap.c
index 82a17c35eb96..cf02f6b49665 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1141,10 +1141,10 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	 */
 	flags = wait->flags;
 	if (flags & WQ_FLAG_EXCLUSIVE) {
-		if (test_bit(key->bit_nr, &key->page->flags))
+		if (test_bit(key->bit_nr, &key->page->flags.f))
 			return -1;
 		if (flags & WQ_FLAG_CUSTOM) {
-			if (test_and_set_bit(key->bit_nr, &key->page->flags))
+			if (test_and_set_bit(key->bit_nr, &key->page->flags.f))
 				return -1;
 			flags |= WQ_FLAG_DONE;
 		}
@@ -1260,9 +1260,9 @@ static inline bool trylock_page_bit_common(struct page *page, int bit_nr,
 					struct wait_queue_entry *wait)
 {
 	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
-		if (test_and_set_bit(bit_nr, &page->flags))
+		if (test_and_set_bit(bit_nr, &page->flags.f))
 			return false;
-	} else if (test_bit(bit_nr, &page->flags))
+	} else if (test_bit(bit_nr, &page->flags.f))
 		return false;
 
 	wait->flags |= WQ_FLAG_WOKEN | WQ_FLAG_DONE;
@@ -1371,7 +1371,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 		 *
 		 * And if that fails, we'll have to retry this all.
 		 */
-		if (unlikely(test_and_set_bit(bit_nr, &page->flags)))
+		if (unlikely(test_and_set_bit(bit_nr, &page->flags.f)))
 			goto repeat;
 
 		wait->flags |= WQ_FLAG_DONE;
@@ -1509,7 +1509,7 @@ void unlock_page(struct page *page)
 	BUILD_BUG_ON(PG_waiters != 7);
 	page = compound_head(page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
+	if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags.f))
 		wake_up_page_bit(page, PG_locked);
 }
 EXPORT_SYMBOL(unlock_page);
@@ -1529,7 +1529,7 @@ void end_page_private_2(struct page *page)
 {
 	page = compound_head(page);
 	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
-	clear_bit_unlock(PG_private_2, &page->flags);
+	clear_bit_unlock(PG_private_2, &page->flags.f);
 	wake_up_page_bit(page, PG_private_2);
 	put_page(page);
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5e9ef0fc261e..abf471c39abd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2350,8 +2350,8 @@ static void __split_huge_page_tail(struct page *head, int tail,
 	 * After successful get_page_unless_zero() might follow flags change,
 	 * for example lock_page() which set PG_waiters.
 	 */
-	page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
-	page_tail->flags |= (head->flags &
+	page_tail->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	page_tail->flags.f |= (head->flags.f &
 			((1L << PG_referenced) |
 			 (1L << PG_swapbacked) |
 			 (1L << PG_swapcache) |
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 95dc7b83381f..39d34a277d7e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1471,7 +1471,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
-		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
+		subpage->flags.f &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
 				1 << PG_active | 1 << PG_private |
 				1 << PG_writeback);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3e6449f2102a..043f98e46df4 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1389,7 +1389,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 }
 
 static int identify_page_state(unsigned long pfn, struct page *p,
-				unsigned long page_flags)
+				pgflags_t page_flags)
 {
 	struct page_state *ps;
 
@@ -1399,14 +1399,14 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 	 * carried out only if the first check can't determine the page status.
 	 */
 	for (ps = error_states;; ps++)
-		if ((p->flags & ps->mask) == ps->res)
+		if ((p->flags.f & ps->mask) == ps->res)
 			break;
 
-	page_flags |= (p->flags & (1UL << PG_dirty));
+	page_flags.f |= (p->flags.f & (1UL << PG_dirty));
 
 	if (!ps->mask)
 		for (ps = error_states;; ps++)
-			if ((page_flags & ps->mask) == ps->res)
+			if ((page_flags.f & ps->mask) == ps->res)
 				break;
 	return page_action(ps, p, pfn);
 }
@@ -1435,7 +1435,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	struct page *p = pfn_to_page(pfn);
 	struct page *head = compound_head(p);
 	int res;
-	unsigned long page_flags;
+	pgflags_t page_flags;
 
 	if (TestSetPageHWPoison(head)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
@@ -1625,7 +1625,7 @@ int memory_failure(unsigned long pfn, int flags)
 	struct page *orig_head;
 	struct dev_pagemap *pgmap;
 	int res = 0;
-	unsigned long page_flags;
+	pgflags_t page_flags;
 	bool retry = true;
 	static DEFINE_MUTEX(mf_mutex);
 
@@ -2110,13 +2110,13 @@ static int __soft_offline_page(struct page *page)
 				putback_movable_pages(&pagelist);
 
 			pr_info("soft offline: %#lx: %s migration failed %d, type %lx (%pGp)\n",
-				pfn, msg_page[huge], ret, page->flags, &page->flags);
+				pfn, msg_page[huge], ret, page->flags.f, &page->flags.f);
 			if (ret > 0)
 				ret = -EBUSY;
 		}
 	} else {
 		pr_info("soft offline: %#lx: %s isolation failed, page count %d, type %lx (%pGp)\n",
-			pfn, msg_page[huge], page_count(page), page->flags, &page->flags);
+			pfn, msg_page[huge], page_count(page), page->flags.f, &page->flags.f);
 		ret = -EBUSY;
 	}
 	return ret;
diff --git a/mm/mmzone.c b/mm/mmzone.c
index eb89d6e018e2..1bd2f25988f0 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -90,12 +90,12 @@ int page_cpupid_xchg_last(struct page *page, int cpupid)
 	int last_cpupid;
 
 	do {
-		old_flags = flags = page->flags;
+		old_flags = flags = page->flags.f;
 		last_cpupid = page_cpupid_last(page);
 
 		flags &= ~(LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT);
 		flags |= (cpupid & LAST_CPUPID_MASK) << LAST_CPUPID_PGSHIFT;
-	} while (unlikely(cmpxchg(&page->flags, old_flags, flags) != old_flags));
+	} while (unlikely(cmpxchg(&page->flags.f, old_flags, flags) != old_flags));
 
 	return last_cpupid;
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..f6f12d3e74b2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1070,7 +1070,7 @@ static inline void __free_one_page(struct page *page,
 	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
 
 	VM_BUG_ON(!zone_is_initialized(zone));
-	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
+	VM_BUG_ON_PAGE(page->flags.f & PAGE_FLAGS_CHECK_AT_PREP, page);
 
 	VM_BUG_ON(migratetype == -1);
 	if (likely(!is_migrate_isolate(migratetype)))
@@ -1165,7 +1165,7 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-			(page->flags & check_flags)))
+			(page->flags.f & check_flags)))
 		return false;
 
 	return true;
@@ -1181,7 +1181,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 		bad_reason = "non-NULL mapping";
 	if (unlikely(page_ref_count(page) != 0))
 		bad_reason = "nonzero _refcount";
-	if (unlikely(page->flags & flags)) {
+	if (unlikely(page->flags.f & flags)) {
 		if (flags == PAGE_FLAGS_CHECK_AT_PREP)
 			bad_reason = "PAGE_FLAGS_CHECK_AT_PREP flag(s) set";
 		else
@@ -1321,7 +1321,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 				bad++;
 				continue;
 			}
-			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+			(page + i)->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
 		}
 	}
 	if (PageMappingFlags(page))
@@ -1334,7 +1334,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		return false;
 
 	page_cpupid_reset_last(page);
-	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
 	reset_page_owner(page, order);
 
 	if (!PageHighMem(page)) {
@@ -2310,7 +2310,7 @@ static inline void expand(struct zone *zone, struct page *page,
 
 static void check_new_page_bad(struct page *page)
 {
-	if (unlikely(page->flags & __PG_HWPOISON)) {
+	if (unlikely(page->flags.f & __PG_HWPOISON)) {
 		/* Don't complain about hwpoisoned pages */
 		page_mapcount_reset(page); /* remove PageBuddy */
 		return;
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 62402d22539b..878d79fb10ac 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -356,7 +356,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 			migratetype_names[page_mt],
 			pfn >> pageblock_order,
 			migratetype_names[pageblock_mt],
-			page->flags, &page->flags);
+			page->flags.f, &page->flags.f);
 
 	if (ret >= count)
 		goto err;
diff --git a/mm/slub.c b/mm/slub.c
index 3d2025f7163b..f07cfa112b01 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -420,13 +420,13 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
 static __always_inline void __slab_lock(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	bit_spin_lock(PG_locked, &page->flags);
+	bit_spin_lock(PG_locked, &page->flags.f);
 }
 
 static __always_inline void __slab_unlock(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	__bit_spin_unlock(PG_locked, &page->flags);
+	__bit_spin_unlock(PG_locked, &page->flags.f);
 }
 
 static __always_inline void slab_lock(struct page *page, unsigned long *flags)
@@ -765,7 +765,7 @@ static void print_page_info(struct page *page)
 {
 	pr_err("Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
 	       page, page->objects, page->inuse, page->freelist,
-	       page->flags, &page->flags);
+	       page->flags.f, &page->flags.f);
 
 }
 

