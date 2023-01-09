Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F7661E5C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 06:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbjAIFSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 00:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjAIFSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:18:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9929ED2DC;
        Sun,  8 Jan 2023 21:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YLUcsaMTdWzUTPeweatSYOos3qbQs6I0puU7586j9/8=; b=rAzQJTyZjPOc2dWheR771P9Y5N
        zEFvxTxSDP0E8IpVfF6xp0gNN58oO9Dpqu10uAK0toI8KWtTrYdFheabjxryK47Fc/6XtgZMl/qcK
        qFHVBKck4DfGAQMCUFkPHaYjIOxCKUezVTuKaQ5SABoD/vTuoEjpfNQOUqxuDHw5k8oDZq+xFcfSl
        XJl+2VeymGOsq6o/fwSbipUr+VEFYqSYdhM6Eg9Z/n+gV0uwM27qKhuw14Nd2fpbBlbZj6Z0Xvh9O
        JApINzQ7SNd06B2+cWVk5UY4YnSzbEpF03HpCfFRUUzauiuhQLMORV1XQIxAzasoT5c5qgxAGv65O
        TUrFVwvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEkYE-0020xQ-0e; Mon, 09 Jan 2023 05:18:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/11] mm: Remove AS_EIO and AS_ENOSPC
Date:   Mon,  9 Jan 2023 05:18:21 +0000
Message-Id: <20230109051823.480289-10-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230109051823.480289-1-willy@infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All users are now converted to use wb_err, so convert the
remaining comments, drop the unused filemap_check_errors()
and remove the compatibility code in mapping_set_error() and
file_check_and_advance_wb_err().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/extent_io.c    |  6 +++---
 fs/f2fs/data.c          |  2 +-
 include/linux/pagemap.h | 20 +++++---------------
 mm/filemap.c            | 21 ---------------------
 4 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9bd32daa9b9a..f1c3572b6a90 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2386,7 +2386,7 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
 	 * or the content of some node/leaf from a past generation that got
 	 * cowed or deleted and is no longer valid.
 	 *
-	 * Note: setting AS_EIO/AS_ENOSPC in the btree inode's i_mapping would
+	 * Note: setting wb_err in the btree inode's i_mapping would
 	 * not be enough - we need to distinguish between log tree extents vs
 	 * non-log tree extents, and the next filemap_fdatawait_range() call
 	 * will catch and clear such errors in the mapping - and that call might
@@ -2397,10 +2397,10 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
 	 * set (since it's a runtime flag, not persisted on disk).
 	 *
 	 * Using the flags below in the btree inode also makes us achieve the
-	 * goal of AS_EIO/AS_ENOSPC when writepages() returns success, started
+	 * goal of wb_err when writepages() returns success, started
 	 * writeback for all dirty pages and before filemap_fdatawait_range()
 	 * is called, the writeback for all dirty pages had already finished
-	 * with errors - because we were not using AS_EIO/AS_ENOSPC,
+	 * with errors - because we were not using wb_err,
 	 * filemap_fdatawait_range() would return success, as it could not know
 	 * that writeback errors happened (the pages were no longer tagged for
 	 * writeback).
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 97e816590cd9..566fe19ca57d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2913,7 +2913,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	redirty_page_for_writepage(wbc, page);
 	/*
 	 * pageout() in MM traslates EAGAIN, so calls handle_write_error()
-	 * -> mapping_set_error() -> set_bit(AS_EIO, ...).
+	 * -> mapping_set_error().
 	 * file_write_and_wait_range() will see EIO error, which is critical
 	 * to return value of fsync() followed by atomic_write failure to user.
 	 */
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 985fd47739f4..573b8cce3a85 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -51,7 +51,6 @@ int __filemap_fdatawrite_range(struct address_space *mapping,
 		loff_t start, loff_t end, int sync_mode);
 int filemap_fdatawrite_range(struct address_space *mapping,
 		loff_t start, loff_t end);
-int filemap_check_errors(struct address_space *mapping);
 void __filemap_set_wb_err(struct address_space *mapping, int err);
 int filemap_fdatawrite_wbc(struct address_space *mapping,
 			   struct writeback_control *wbc);
@@ -192,14 +191,11 @@ static inline bool mapping_shrinkable(struct address_space *mapping)
  * Bits in mapping->flags.
  */
 enum mapping_flags {
-	AS_EIO		= 0,	/* IO error on async write */
-	AS_ENOSPC	= 1,	/* ENOSPC on async write */
-	AS_MM_ALL_LOCKS	= 2,	/* under mm_take_all_locks() */
-	AS_UNEVICTABLE	= 3,	/* e.g., ramdisk, SHM_LOCK */
-	AS_EXITING	= 4, 	/* final truncate in progress */
-	/* writeback related tags are not used */
-	AS_NO_WRITEBACK_TAGS = 5,
-	AS_LARGE_FOLIO_SUPPORT = 6,
+	AS_MM_ALL_LOCKS	= 0,	/* under mm_take_all_locks() */
+	AS_UNEVICTABLE,		/* e.g., ramdisk, SHM_LOCK */
+	AS_EXITING, 		/* final truncate in progress */
+	AS_NO_WRITEBACK_TAGS,	/* writeback related tags are not used */
+	AS_LARGE_FOLIO_SUPPORT,
 };
 
 /**
@@ -227,12 +223,6 @@ static inline void mapping_set_error(struct address_space *mapping, int error)
 	/* Record it in superblock */
 	if (mapping->host)
 		errseq_set(&mapping->host->i_sb->s_wb_err, error);
-
-	/* Record it in flags for now, for legacy callers */
-	if (error == -ENOSPC)
-		set_bit(AS_ENOSPC, &mapping->flags);
-	else
-		set_bit(AS_EIO, &mapping->flags);
 }
 
 static inline void mapping_set_unevictable(struct address_space *mapping)
diff --git a/mm/filemap.c b/mm/filemap.c
index 887520db115a..7bf8442bcfaa 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -341,20 +341,6 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 		filemap_free_folio(mapping, fbatch->folios[i]);
 }
 
-int filemap_check_errors(struct address_space *mapping)
-{
-	int ret = 0;
-	/* Check for outstanding write errors */
-	if (test_bit(AS_ENOSPC, &mapping->flags) &&
-	    test_and_clear_bit(AS_ENOSPC, &mapping->flags))
-		ret = -ENOSPC;
-	if (test_bit(AS_EIO, &mapping->flags) &&
-	    test_and_clear_bit(AS_EIO, &mapping->flags))
-		ret = -EIO;
-	return ret;
-}
-EXPORT_SYMBOL(filemap_check_errors);
-
 /**
  * filemap_fdatawrite_wbc - start writeback on mapping dirty pages in range
  * @mapping:	address space structure to write
@@ -684,13 +670,6 @@ int file_check_and_advance_wb_err(struct file *file)
 		spin_unlock(&file->f_lock);
 	}
 
-	/*
-	 * We're mostly using this function as a drop in replacement for
-	 * filemap_check_errors. Clear AS_EIO/AS_ENOSPC to emulate the effect
-	 * that the legacy code would have had on these flags.
-	 */
-	clear_bit(AS_EIO, &mapping->flags);
-	clear_bit(AS_ENOSPC, &mapping->flags);
 	return err;
 }
 EXPORT_SYMBOL(file_check_and_advance_wb_err);
-- 
2.35.1

