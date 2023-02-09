Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821746908E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 13:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBIMc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 07:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjBIMcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:32:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647022B629;
        Thu,  9 Feb 2023 04:32:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BCCD05CD3E;
        Thu,  9 Feb 2023 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675945928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIVy/KuL6g/vo7B3GdY0//P3KeKhKB5lViH2xRs5ty0=;
        b=Zre6VeWjTeCtrShgQfH89eJL16vS9CIvftlVUvUAjAZqfL4aDQGRrK6dmB+30g4nLDVK/3
        C0GOxQH9LgMrCfFFeskXvqu8HXY95n7x5CQj8fgHHSmP7VriwQg9Jgsuzj7H5OMtAAnpMx
        BeYBDffiGmkvPxM4Y1+UHguzzkBYUpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675945928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIVy/KuL6g/vo7B3GdY0//P3KeKhKB5lViH2xRs5ty0=;
        b=ZzoAo7prSZG2dRsrtPw+9bdfqAsg69nQSC8iYB+KcdJnOrLydw+lNDs1eR5l++/0Lx+6pg
        rjciXxcLp+SYG/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A64CE13915;
        Thu,  9 Feb 2023 12:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XJqTKMjn5GO1WQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Feb 2023 12:32:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8D02DA06E3; Thu,  9 Feb 2023 13:32:06 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/5] mm: Do not try to write pinned folio during memory cleaning writeback
Date:   Thu,  9 Feb 2023 13:31:55 +0100
Message-Id: <20230209123206.3548-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230209121046.25360-1-jack@suse.cz>
References: <20230209121046.25360-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24971; i=jack@suse.cz; h=from:subject; bh=y3H+GOLrDAW9dB63NteYUrKsdQl7J0M3vk0dPgRD2J8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj5Oe7dgtajS4zcK79M4BganpIO0XHXhJ6UNa4sASP AZ6OJzyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY+TnuwAKCRCcnaoHP2RA2bRCB/ 9MhOC8vb6EWPDXLTxP9SL2ydUEn59OqnwQq8j7AG/ym+6PVh6ge5JNQRK9TOTOiGVUv+SHRpbDuT1U KPSE0htkywEtJVEn7DKtJZW9o1y5xMVg+pgueeojm6FwYPpUToFnY1TFakfV9+CIH9IhHXSBJ5uNAb XknK6SY86Mw7ZXjs0OHANicmrpV/8xXW1NHKUtZ79oArnsFyStfoVxDfKoRDwDt6ptZ7NtRQyGMa/l /pt+FMu/zJUK1GTdoMVE6K/BAWzLEzrQq9BDc4AbF0qc0VjDkBI87jbBkfGgHEPSgvB/YxGNGXEjO/ z1xAzQQ7V1ZUMz89fErbebo8akTjlz
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a folio is pinned, there is no point in trying to write it during
memory cleaning writeback. We cannot reclaim the folio until it is
unpinned anyway and we cannot even be sure the folio is really clean.
On top of that writeback of such folio may be problematic as the data
can change while the writeback is running thus causing checksum or
DIF/DIX failures. So just don't bother doing memory cleaning writeback
for pinned folios.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/9p/vfs_addr.c            |  2 +-
 fs/afs/file.c               |  2 +-
 fs/afs/write.c              |  6 +++---
 fs/btrfs/extent_io.c        | 14 +++++++-------
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            |  2 +-
 fs/btrfs/subpage.c          |  2 +-
 fs/ceph/addr.c              |  6 +++---
 fs/cifs/file.c              |  6 +++---
 fs/ext4/inode.c             |  4 ++--
 fs/f2fs/checkpoint.c        |  4 ++--
 fs/f2fs/compress.c          |  2 +-
 fs/f2fs/data.c              |  2 +-
 fs/f2fs/dir.c               |  2 +-
 fs/f2fs/gc.c                |  4 ++--
 fs/f2fs/inline.c            |  2 +-
 fs/f2fs/node.c              | 10 +++++-----
 fs/fuse/file.c              |  2 +-
 fs/gfs2/aops.c              |  2 +-
 fs/nfs/write.c              |  2 +-
 fs/nilfs2/page.c            |  2 +-
 fs/nilfs2/segment.c         |  8 ++++----
 fs/orangefs/inode.c         |  2 +-
 fs/ubifs/file.c             |  2 +-
 include/linux/pagemap.h     |  5 +++--
 mm/folio-compat.c           |  4 ++--
 mm/migrate.c                |  2 +-
 mm/page-writeback.c         | 24 ++++++++++++++++++++----
 mm/vmscan.c                 |  2 +-
 29 files changed, 73 insertions(+), 56 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 97599edbc300..a14ff3c02eb1 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -221,7 +221,7 @@ static int v9fs_launder_folio(struct folio *folio)
 {
 	int retval;
 
-	if (folio_clear_dirty_for_io(folio)) {
+	if (folio_clear_dirty_for_io(NULL, folio)) {
 		retval = v9fs_vfs_write_folio_locked(folio);
 		if (retval)
 			return retval;
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 68d6d5dc608d..8a81ac9c12fa 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -453,7 +453,7 @@ static void afs_invalidate_dirty(struct folio *folio, size_t offset,
 
 undirty:
 	trace_afs_folio_dirty(vnode, tracepoint_string("undirty"), folio);
-	folio_clear_dirty_for_io(folio);
+	folio_clear_dirty_for_io(NULL, folio);
 full_invalidate:
 	trace_afs_folio_dirty(vnode, tracepoint_string("inval"), folio);
 	folio_detach_private(folio);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 19df10d63323..9a5e6d59040c 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -555,7 +555,7 @@ static void afs_extend_writeback(struct address_space *mapping,
 			folio = page_folio(pvec.pages[i]);
 			trace_afs_folio_dirty(vnode, tracepoint_string("store+"), folio);
 
-			if (!folio_clear_dirty_for_io(folio))
+			if (!folio_clear_dirty_for_io(NULL, folio))
 				BUG();
 			if (folio_start_writeback(folio))
 				BUG();
@@ -769,7 +769,7 @@ static int afs_writepages_region(struct address_space *mapping,
 			continue;
 		}
 
-		if (!folio_clear_dirty_for_io(folio))
+		if (!folio_clear_dirty_for_io(NULL, folio))
 			BUG();
 		ret = afs_write_back_from_locked_folio(mapping, wbc, folio, start, end);
 		folio_put(folio);
@@ -1000,7 +1000,7 @@ int afs_launder_folio(struct folio *folio)
 	_enter("{%lx}", folio->index);
 
 	priv = (unsigned long)folio_get_private(folio);
-	if (folio_clear_dirty_for_io(folio)) {
+	if (folio_clear_dirty_for_io(NULL, folio)) {
 		f = 0;
 		t = folio_size(folio);
 		if (folio_test_private(folio)) {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9bd32daa9b9a..2026f567cbdd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -215,7 +215,7 @@ void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
 	while (index <= end_index) {
 		page = find_get_page(inode->i_mapping, index);
 		BUG_ON(!page); /* Pages should be in the extent_io_tree */
-		clear_page_dirty_for_io(page);
+		clear_page_dirty_for_io(NULL, page);
 		put_page(page);
 		index++;
 	}
@@ -2590,7 +2590,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 	no_dirty_ebs = btrfs_subpage_clear_and_test_dirty(fs_info, page,
 							  eb->start, eb->len);
 	if (no_dirty_ebs)
-		clear_page_dirty_for_io(page);
+		clear_page_dirty_for_io(NULL, page);
 
 	bio_ctrl->end_io_func = end_bio_subpage_eb_writepage;
 
@@ -2633,7 +2633,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
-		clear_page_dirty_for_io(p);
+		clear_page_dirty_for_io(NULL, p);
 		set_page_writeback(p);
 		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
 					 bio_ctrl, disk_bytenr, p,
@@ -2655,7 +2655,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 	if (unlikely(ret)) {
 		for (; i < num_pages; i++) {
 			struct page *p = eb->pages[i];
-			clear_page_dirty_for_io(p);
+			clear_page_dirty_for_io(NULL, p);
 			unlock_page(p);
 		}
 	}
@@ -3083,7 +3083,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			}
 
 			if (PageWriteback(page) ||
-			    !clear_page_dirty_for_io(page)) {
+			    !clear_page_dirty_for_io(wbc, page)) {
 				unlock_page(page);
 				continue;
 			}
@@ -3174,7 +3174,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 		 */
 		ASSERT(PageLocked(page));
 		ASSERT(PageDirty(page));
-		clear_page_dirty_for_io(page);
+		clear_page_dirty_for_io(NULL, page);
 		ret = __extent_writepage(page, &wbc_writepages, &bio_ctrl);
 		ASSERT(ret <= 0);
 		if (ret < 0) {
@@ -4698,7 +4698,7 @@ static void btree_clear_page_dirty(struct page *page)
 {
 	ASSERT(PageDirty(page));
 	ASSERT(PageLocked(page));
-	clear_page_dirty_for_io(page);
+	clear_page_dirty_for_io(NULL, page);
 	xa_lock_irq(&page->mapping->i_pages);
 	if (!PageDirty(page))
 		__xa_clear_mark(&page->mapping->i_pages,
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0d250d052487..02ec9987fc17 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -507,7 +507,7 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 	}
 
 	for (i = 0; i < io_ctl->num_pages; i++)
-		clear_page_dirty_for_io(io_ctl->pages[i]);
+		clear_page_dirty_for_io(NULL, io_ctl->pages[i]);
 
 	return 0;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 98a800b8bd43..26820c697c5b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3002,7 +3002,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		 */
 		mapping_set_error(page->mapping, ret);
 		end_extent_writepage(page, ret, page_start, page_end);
-		clear_page_dirty_for_io(page);
+		clear_page_dirty_for_io(NULL, page);
 		SetPageError(page);
 	}
 	btrfs_page_clear_checked(inode->root->fs_info, page, page_start, PAGE_SIZE);
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index dd46b978ac2c..f85b5a2ccdab 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -515,7 +515,7 @@ void btrfs_subpage_clear_dirty(const struct btrfs_fs_info *fs_info,
 
 	last = btrfs_subpage_clear_and_test_dirty(fs_info, page, start, len);
 	if (last)
-		clear_page_dirty_for_io(page);
+		clear_page_dirty_for_io(NULL, page);
 }
 
 void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index cac4083e387a..ff940c9cd1cf 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -926,7 +926,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				     folio->index, ceph_wbc.i_size);
 				if ((ceph_wbc.size_stable ||
 				    folio_pos(folio) >= i_size_read(inode)) &&
-				    folio_clear_dirty_for_io(folio))
+				    folio_clear_dirty_for_io(wbc, folio))
 					folio_invalidate(folio, 0,
 							folio_size(folio));
 				folio_unlock(folio);
@@ -948,7 +948,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				wait_on_page_fscache(page);
 			}
 
-			if (!clear_page_dirty_for_io(page)) {
+			if (!clear_page_dirty_for_io(wbc, page)) {
 				dout("%p !clear_page_dirty_for_io\n", page);
 				unlock_page(page);
 				continue;
@@ -1282,7 +1282,7 @@ ceph_find_incompatible(struct page *page)
 
 		/* yay, writeable, do it now (without dropping page lock) */
 		dout(" page %p snapc %p not current, but oldest\n", page, snapc);
-		if (clear_page_dirty_for_io(page)) {
+		if (clear_page_dirty_for_io(NULL, page)) {
 			int r = writepage_nounlock(page, NULL);
 			if (r < 0)
 				return ERR_PTR(r);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 22dfc1f8b4f1..93e36829896e 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2342,7 +2342,7 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
 		for (j = 0; j < nr_pages; j++) {
 			wdata2->pages[j] = wdata->pages[i + j];
 			lock_page(wdata2->pages[j]);
-			clear_page_dirty_for_io(wdata2->pages[j]);
+			clear_page_dirty_for_io(NULL, wdata2->pages[j]);
 		}
 
 		wdata2->sync_mode = wdata->sync_mode;
@@ -2582,7 +2582,7 @@ wdata_prepare_pages(struct cifs_writedata *wdata, unsigned int found_pages,
 			wait_on_page_writeback(page);
 
 		if (PageWriteback(page) ||
-				!clear_page_dirty_for_io(page)) {
+				!clear_page_dirty_for_io(wbc, page)) {
 			unlock_page(page);
 			break;
 		}
@@ -5076,7 +5076,7 @@ static int cifs_launder_folio(struct folio *folio)
 
 	cifs_dbg(FYI, "Launder page: %lu\n", folio->index);
 
-	if (folio_clear_dirty_for_io(folio))
+	if (folio_clear_dirty_for_io(&wbc, folio))
 		rc = cifs_writepage_locked(&folio->page, &wbc);
 
 	folio_wait_fscache(folio);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 46078651ce32..7082b6ba8e12 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1616,7 +1616,7 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 			BUG_ON(folio_test_writeback(folio));
 			if (invalidate) {
 				if (folio_mapped(folio))
-					folio_clear_dirty_for_io(folio);
+					folio_clear_dirty_for_io(NULL, folio);
 				block_invalidate_folio(folio, 0,
 						folio_size(folio));
 				folio_clear_uptodate(folio);
@@ -2106,7 +2106,7 @@ static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
 	int err;
 
 	BUG_ON(page->index != mpd->first_page);
-	clear_page_dirty_for_io(page);
+	clear_page_dirty_for_io(NULL, page);
 	/*
 	 * We have to be very careful here!  Nothing protects writeback path
 	 * against i_size changes and the page can be writeably mapped into
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 56f7d0d6a8b2..37f951b11153 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -435,7 +435,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 
 			f2fs_wait_on_page_writeback(page, META, true, true);
 
-			if (!clear_page_dirty_for_io(page))
+			if (!clear_page_dirty_for_io(NULL, page))
 				goto continue_unlock;
 
 			if (__f2fs_write_meta_page(page, &wbc, io_type)) {
@@ -1415,7 +1415,7 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
 	memcpy(page_address(page), src, PAGE_SIZE);
 
 	set_page_dirty(page);
-	if (unlikely(!clear_page_dirty_for_io(page)))
+	if (unlikely(!clear_page_dirty_for_io(NULL, page)))
 		f2fs_bug_on(sbi, 1);
 
 	/* writeout cp pack 2 page */
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 2532f369cb10..efd09e280b2c 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1459,7 +1459,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!PageDirty(cc->rpages[i]))
 			goto continue_unlock;
 
-		if (!clear_page_dirty_for_io(cc->rpages[i]))
+		if (!clear_page_dirty_for_io(NULL, cc->rpages[i]))
 			goto continue_unlock;
 
 		ret = f2fs_write_single_data_page(cc->rpages[i], &_submitted,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 97e816590cd9..f1d622b64690 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3102,7 +3102,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 					goto continue_unlock;
 			}
 
-			if (!clear_page_dirty_for_io(page))
+			if (!clear_page_dirty_for_io(NULL, page))
 				goto continue_unlock;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8e025157f35c..73005e711b83 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -938,7 +938,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	if (bit_pos == NR_DENTRY_IN_BLOCK &&
 		!f2fs_truncate_hole(dir, page->index, page->index + 1)) {
 		f2fs_clear_page_cache_dirty_tag(page);
-		clear_page_dirty_for_io(page);
+		clear_page_dirty_for_io(NULL, page);
 		ClearPageUptodate(page);
 
 		clear_page_private_gcing(page);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6e2cae3d2e71..1f647287e3eb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1361,7 +1361,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	f2fs_invalidate_compress_page(fio.sbi, fio.old_blkaddr);
 
 	set_page_dirty(fio.encrypted_page);
-	if (clear_page_dirty_for_io(fio.encrypted_page))
+	if (clear_page_dirty_for_io(NULL, fio.encrypted_page))
 		dec_page_count(fio.sbi, F2FS_DIRTY_META);
 
 	set_page_writeback(fio.encrypted_page);
@@ -1446,7 +1446,7 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		f2fs_wait_on_page_writeback(page, DATA, true, true);
 
 		set_page_dirty(page);
-		if (clear_page_dirty_for_io(page)) {
+		if (clear_page_dirty_for_io(NULL, page)) {
 			inode_dec_dirty_pages(inode);
 			f2fs_remove_dirty_inode(inode);
 		}
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 21a495234ffd..2bfade0ead67 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -170,7 +170,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 	set_page_dirty(page);
 
 	/* clear dirty state */
-	dirty = clear_page_dirty_for_io(page);
+	dirty = clear_page_dirty_for_io(NULL, page);
 
 	/* write data page to try to make data consistent */
 	set_page_writeback(page);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index dde4c0458704..6f5571cac2b3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -124,7 +124,7 @@ static void clear_node_page_dirty(struct page *page)
 {
 	if (PageDirty(page)) {
 		f2fs_clear_page_cache_dirty_tag(page);
-		clear_page_dirty_for_io(page);
+		clear_page_dirty_for_io(NULL, page);
 		dec_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
 	}
 	ClearPageUptodate(page);
@@ -1501,7 +1501,7 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 	if (!PageDirty(page))
 		goto page_out;
 
-	if (!clear_page_dirty_for_io(page))
+	if (!clear_page_dirty_for_io(NULL, page))
 		goto page_out;
 
 	ret = f2fs_write_inline_data(inode, page);
@@ -1696,7 +1696,7 @@ int f2fs_move_node_page(struct page *node_page, int gc_type)
 
 		set_page_dirty(node_page);
 
-		if (!clear_page_dirty_for_io(node_page)) {
+		if (!clear_page_dirty_for_io(NULL, node_page)) {
 			err = -EAGAIN;
 			goto out_page;
 		}
@@ -1803,7 +1803,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 					set_page_dirty(page);
 			}
 
-			if (!clear_page_dirty_for_io(page))
+			if (!clear_page_dirty_for_io(NULL, page))
 				goto continue_unlock;
 
 			ret = __write_node_page(page, atomic &&
@@ -2011,7 +2011,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 write_node:
 			f2fs_wait_on_page_writeback(page, NODE, true, true);
 
-			if (!clear_page_dirty_for_io(page))
+			if (!clear_page_dirty_for_io(NULL, page))
 				goto continue_unlock;
 
 			set_fsync_mark(page, 0);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 875314ee6f59..cb9561128b4b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2399,7 +2399,7 @@ static int fuse_write_end(struct file *file, struct address_space *mapping,
 static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
-	if (folio_clear_dirty_for_io(folio)) {
+	if (folio_clear_dirty_for_io(NULL, folio)) {
 		struct inode *inode = folio->mapping->host;
 
 		/* Serialize with pending writeback for the same page */
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index e782b4f1d104..cf784dd5fd3b 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -247,7 +247,7 @@ static int gfs2_write_jdata_pagevec(struct address_space *mapping,
 		}
 
 		BUG_ON(PageWriteback(page));
-		if (!clear_page_dirty_for_io(page))
+		if (!clear_page_dirty_for_io(wbc, page))
 			goto continue_unlock;
 
 		trace_wbc_writepage(wbc, inode_to_bdi(inode));
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 80c240e50952..c07b686c84ce 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2089,7 +2089,7 @@ int nfs_wb_page(struct inode *inode, struct page *page)
 
 	for (;;) {
 		wait_on_page_writeback(page);
-		if (clear_page_dirty_for_io(page)) {
+		if (clear_page_dirty_for_io(&wbc, page)) {
 			ret = nfs_writepage_locked(page, &wbc);
 			if (ret < 0)
 				goto out_error;
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 39b7eea2642a..9c3cc20b446e 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -456,7 +456,7 @@ int __nilfs_clear_page_dirty(struct page *page)
 			__xa_clear_mark(&mapping->i_pages, page_index(page),
 					     PAGECACHE_TAG_DIRTY);
 			xa_unlock_irq(&mapping->i_pages);
-			return clear_page_dirty_for_io(page);
+			return clear_page_dirty_for_io(NULL, page);
 		}
 		xa_unlock_irq(&mapping->i_pages);
 		return 0;
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 76c3bd88b858..123494739030 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1644,7 +1644,7 @@ static void nilfs_begin_page_io(struct page *page)
 		return;
 
 	lock_page(page);
-	clear_page_dirty_for_io(page);
+	clear_page_dirty_for_io(NULL, page);
 	set_page_writeback(page);
 	unlock_page(page);
 }
@@ -1662,7 +1662,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 			if (bh->b_page != bd_page) {
 				if (bd_page) {
 					lock_page(bd_page);
-					clear_page_dirty_for_io(bd_page);
+					clear_page_dirty_for_io(NULL, bd_page);
 					set_page_writeback(bd_page);
 					unlock_page(bd_page);
 				}
@@ -1676,7 +1676,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 			if (bh == segbuf->sb_super_root) {
 				if (bh->b_page != bd_page) {
 					lock_page(bd_page);
-					clear_page_dirty_for_io(bd_page);
+					clear_page_dirty_for_io(NULL, bd_page);
 					set_page_writeback(bd_page);
 					unlock_page(bd_page);
 					bd_page = bh->b_page;
@@ -1691,7 +1691,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 	}
 	if (bd_page) {
 		lock_page(bd_page);
-		clear_page_dirty_for_io(bd_page);
+		clear_page_dirty_for_io(NULL, bd_page);
 		set_page_writeback(bd_page);
 		unlock_page(bd_page);
 	}
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 4df560894386..829de5553a77 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -501,7 +501,7 @@ static int orangefs_launder_folio(struct folio *folio)
 		.nr_to_write = 0,
 	};
 	folio_wait_writeback(folio);
-	if (folio_clear_dirty_for_io(folio)) {
+	if (folio_clear_dirty_for_io(&wbc, folio)) {
 		r = orangefs_writepage_locked(&folio->page, &wbc);
 		folio_end_writeback(folio);
 	}
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index f2353dd676ef..41d764fd5511 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1159,7 +1159,7 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
 				 */
 				ubifs_assert(c, PagePrivate(page));
 
-				clear_page_dirty_for_io(page);
+				clear_page_dirty_for_io(NULL, page);
 				if (UBIFS_BLOCKS_PER_PAGE_SHIFT)
 					offset = new_size &
 						 (PAGE_SIZE - 1);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 29e1f9e76eb6..81c42a95cf8d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1059,8 +1059,9 @@ static inline void folio_cancel_dirty(struct folio *folio)
 	if (folio_test_dirty(folio))
 		__folio_cancel_dirty(folio);
 }
-bool folio_clear_dirty_for_io(struct folio *folio);
-bool clear_page_dirty_for_io(struct page *page);
+bool folio_clear_dirty_for_io(struct writeback_control *wbc,
+			      struct folio *folio);
+bool clear_page_dirty_for_io(struct writeback_control *wbc, struct page *page);
 void folio_invalidate(struct folio *folio, size_t offset, size_t length);
 int __must_check folio_write_one(struct folio *folio);
 static inline int __must_check write_one_page(struct page *page)
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 69ed25790c68..748f82def674 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -63,9 +63,9 @@ int __set_page_dirty_nobuffers(struct page *page)
 }
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
 
-bool clear_page_dirty_for_io(struct page *page)
+bool clear_page_dirty_for_io(struct writeback_control *wbc, struct page *page)
 {
-	return folio_clear_dirty_for_io(page_folio(page));
+	return folio_clear_dirty_for_io(wbc, page_folio(page));
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index a4d3fc65085f..0bda652153b9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -870,7 +870,7 @@ static int writeout(struct address_space *mapping, struct folio *folio)
 		/* No write method for the address space */
 		return -EINVAL;
 
-	if (!folio_clear_dirty_for_io(folio))
+	if (!folio_clear_dirty_for_io(&wbc, folio))
 		/* Someone else already triggered a write */
 		return -EAGAIN;
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ad608ef2a243..2d70070e533c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2465,7 +2465,7 @@ int write_cache_pages(struct address_space *mapping,
 			}
 
 			BUG_ON(PageWriteback(page));
-			if (!clear_page_dirty_for_io(page))
+			if (!clear_page_dirty_for_io(wbc, page))
 				goto continue_unlock;
 
 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
@@ -2628,7 +2628,7 @@ int folio_write_one(struct folio *folio)
 
 	folio_wait_writeback(folio);
 
-	if (folio_clear_dirty_for_io(folio)) {
+	if (folio_clear_dirty_for_io(&wbc, folio)) {
 		folio_get(folio);
 		ret = mapping->a_ops->writepage(&folio->page, &wbc);
 		if (ret == 0)
@@ -2924,7 +2924,7 @@ EXPORT_SYMBOL(__folio_cancel_dirty);
 
 /*
  * Clear a folio's dirty flag, while caring for dirty memory accounting.
- * Returns true if the folio was previously dirty.
+ * Returns true if the folio was previously dirty and should be written back.
  *
  * This is for preparing to put the folio under writeout.  We leave
  * the folio tagged as dirty in the xarray so that a concurrent
@@ -2935,8 +2935,14 @@ EXPORT_SYMBOL(__folio_cancel_dirty);
  *
  * This incoherency between the folio's dirty flag and xarray tag is
  * unfortunate, but it only exists while the folio is locked.
+ *
+ * If the folio is pinned, its writeback is problematic so we just don't bother
+ * for memory cleaning writeback - this is why writeback control is passed in.
+ * If it is NULL, we assume pinned pages are not expected (e.g. this can be
+ * a metadata page) and warn if the page is actually pinned.
  */
-bool folio_clear_dirty_for_io(struct folio *folio)
+bool folio_clear_dirty_for_io(struct writeback_control *wbc,
+			      struct folio *folio)
 {
 	struct address_space *mapping = folio_mapping(folio);
 	bool ret = false;
@@ -2975,6 +2981,16 @@ bool folio_clear_dirty_for_io(struct folio *folio)
 		 */
 		if (folio_mkclean(folio))
 			folio_mark_dirty(folio);
+		/*
+		 * For pinned folios we have no chance to reclaim them anyway
+		 * and we cannot be sure folio is ever clean. So memory
+		 * cleaning writeback is pointless. Just skip it.
+		 */
+		if (wbc && wbc->sync_mode == WB_SYNC_NONE &&
+		    folio_maybe_dma_pinned(folio))
+			return false;
+		/* Catch callers not expecting pinned pages */
+		WARN_ON_ONCE(!wbc && folio_maybe_dma_pinned(folio));
 		/*
 		 * We carefully synchronise fault handlers against
 		 * installing a dirty pte and marking the folio dirty
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ab3911a8b116..71a226b47ac6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1283,7 +1283,7 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 	if (mapping->a_ops->writepage == NULL)
 		return PAGE_ACTIVATE;
 
-	if (folio_clear_dirty_for_io(folio)) {
+	if (folio_clear_dirty_for_io(NULL, folio)) {
 		int res;
 		struct writeback_control wbc = {
 			.sync_mode = WB_SYNC_NONE,
-- 
2.35.3

