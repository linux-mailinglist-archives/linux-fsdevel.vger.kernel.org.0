Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A71149D832
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 03:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiA0CrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 21:47:19 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55088 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiA0CrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:47:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CACD21923;
        Thu, 27 Jan 2022 02:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643251635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KkOF4oPkeZZZKayzg8ZVQCwB7v+mDSIDC7L5LPHRKXQ=;
        b=B0O+3jp4mxkh1XpwWM+FNy40XFfLzGb0Axq21Ieo05EzgRkUvnhGii2kHiGjgkRLqvdhtC
        2knTbGE65MpnfDYPlDD/ccAf6ArX+ks9W62f9mMUjn4Y9URMQFRbndQiWvherjRx1cbWEU
        ThaX50CNYQb06Pj1OE0TAC2fkpaINRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643251635;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KkOF4oPkeZZZKayzg8ZVQCwB7v+mDSIDC7L5LPHRKXQ=;
        b=akBmVAaqPSHWwfizVR5+UEN5LqmpYqCrwUXapYuPOGUA+SFdSPkHY8zNLaSjFpANMaqGvw
        pDptIRxgjShhOQDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F121013E46;
        Thu, 27 Jan 2022 02:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x7+BK6wH8mGsKwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Jan 2022 02:47:08 +0000
Subject: [PATCH 1/9] Remove inode_congested()
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Date:   Thu, 27 Jan 2022 13:46:29 +1100
Message-ID: <164325158954.29787.7856652136298668100.stgit@noble.brown>
In-Reply-To: <164325106958.29787.4865219843242892726.stgit@noble.brown>
References: <164325106958.29787.4865219843242892726.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

inode_congested() reports if the backing-device for the inode is
congested.  Few bdi report congestion any more, only ceph, fuse, and
nfs.  Having support just for those is unlikely to be useful.

The places which test inode_congested() or it variants like
inode_write_congested(), avoid initiating IO if congestion is present.
We now have to rely on other places in the stack to back off, or abort
requests - we already do for everything except these 3 filesystems.

So remove inode_congested() and related functions, and remove the call
sites, assuming that inode_congested() always returns 'false'.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/fs-writeback.c           |   37 -------------------------------------
 include/linux/backing-dev.h |   22 ----------------------
 mm/fadvise.c                |    5 ++---
 mm/readahead.c              |    6 ------
 mm/vmscan.c                 |   17 +----------------
 5 files changed, 3 insertions(+), 84 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f8d7fe6db989..42a3dfad40b8 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -893,43 +893,6 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 }
 EXPORT_SYMBOL_GPL(wbc_account_cgroup_owner);
 
-/**
- * inode_congested - test whether an inode is congested
- * @inode: inode to test for congestion (may be NULL)
- * @cong_bits: mask of WB_[a]sync_congested bits to test
- *
- * Tests whether @inode is congested.  @cong_bits is the mask of congestion
- * bits to test and the return value is the mask of set bits.
- *
- * If cgroup writeback is enabled for @inode, the congestion state is
- * determined by whether the cgwb (cgroup bdi_writeback) for the blkcg
- * associated with @inode is congested; otherwise, the root wb's congestion
- * state is used.
- *
- * @inode is allowed to be NULL as this function is often called on
- * mapping->host which is NULL for the swapper space.
- */
-int inode_congested(struct inode *inode, int cong_bits)
-{
-	/*
-	 * Once set, ->i_wb never becomes NULL while the inode is alive.
-	 * Start transaction iff ->i_wb is visible.
-	 */
-	if (inode && inode_to_wb_is_valid(inode)) {
-		struct bdi_writeback *wb;
-		struct wb_lock_cookie lock_cookie = {};
-		bool congested;
-
-		wb = unlocked_inode_to_wb_begin(inode, &lock_cookie);
-		congested = wb_congested(wb, cong_bits);
-		unlocked_inode_to_wb_end(inode, &lock_cookie);
-		return congested;
-	}
-
-	return wb_congested(&inode_to_bdi(inode)->wb, cong_bits);
-}
-EXPORT_SYMBOL_GPL(inode_congested);
-
 /**
  * wb_split_bdi_pages - split nr_pages to write according to bandwidth
  * @wb: target bdi_writeback to split @nr_pages to
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 483979c1b9f4..860b675c2929 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -162,7 +162,6 @@ struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 				    gfp_t gfp);
 void wb_memcg_offline(struct mem_cgroup *memcg);
 void wb_blkcg_offline(struct blkcg *blkcg);
-int inode_congested(struct inode *inode, int cong_bits);
 
 /**
  * inode_cgwb_enabled - test whether cgroup writeback is enabled on an inode
@@ -390,29 +389,8 @@ static inline void wb_blkcg_offline(struct blkcg *blkcg)
 {
 }
 
-static inline int inode_congested(struct inode *inode, int cong_bits)
-{
-	return wb_congested(&inode_to_bdi(inode)->wb, cong_bits);
-}
-
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
-static inline int inode_read_congested(struct inode *inode)
-{
-	return inode_congested(inode, 1 << WB_sync_congested);
-}
-
-static inline int inode_write_congested(struct inode *inode)
-{
-	return inode_congested(inode, 1 << WB_async_congested);
-}
-
-static inline int inode_rw_congested(struct inode *inode)
-{
-	return inode_congested(inode, (1 << WB_sync_congested) |
-				      (1 << WB_async_congested));
-}
-
 static inline int bdi_congested(struct backing_dev_info *bdi, int cong_bits)
 {
 	return wb_congested(&bdi->wb, cong_bits);
diff --git a/mm/fadvise.c b/mm/fadvise.c
index d6baa4f451c5..338f16022012 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -109,9 +109,8 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 	case POSIX_FADV_NOREUSE:
 		break;
 	case POSIX_FADV_DONTNEED:
-		if (!inode_write_congested(mapping->host))
-			__filemap_fdatawrite_range(mapping, offset, endbyte,
-						   WB_SYNC_NONE);
+		__filemap_fdatawrite_range(mapping, offset, endbyte,
+					   WB_SYNC_NONE);
 
 		/*
 		 * First and last FULL page! Partial pages are deliberately
diff --git a/mm/readahead.c b/mm/readahead.c
index cf0dcf89eb69..feda2b1702f1 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -595,12 +595,6 @@ void page_cache_async_ra(struct readahead_control *ractl,
 
 	folio_clear_readahead(folio);
 
-	/*
-	 * Defer asynchronous read-ahead on IO congestion.
-	 */
-	if (inode_read_congested(ractl->mapping->host))
-		return;
-
 	if (blk_cgroup_congested())
 		return;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 090bfb605ecf..ce8492939bd3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -989,17 +989,6 @@ static inline int is_page_cache_freeable(struct page *page)
 	return page_count(page) - page_has_private(page) == 1 + page_cache_pins;
 }
 
-static int may_write_to_inode(struct inode *inode)
-{
-	if (current->flags & PF_SWAPWRITE)
-		return 1;
-	if (!inode_write_congested(inode))
-		return 1;
-	if (inode_to_bdi(inode) == current->backing_dev_info)
-		return 1;
-	return 0;
-}
-
 /*
  * We detected a synchronous write error writing a page out.  Probably
  * -ENOSPC.  We need to propagate that into the address_space for a subsequent
@@ -1199,8 +1188,6 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
 	}
 	if (mapping->a_ops->writepage == NULL)
 		return PAGE_ACTIVATE;
-	if (!may_write_to_inode(mapping->host))
-		return PAGE_KEEP;
 
 	if (clear_page_dirty_for_io(page)) {
 		int res;
@@ -1576,9 +1563,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		 * end of the LRU a second time.
 		 */
 		mapping = page_mapping(page);
-		if (((dirty || writeback) && mapping &&
-		     inode_write_congested(mapping->host)) ||
-		    (writeback && PageReclaim(page)))
+		if (writeback && PageReclaim(page))
 			stat->nr_congested++;
 
 		/*


