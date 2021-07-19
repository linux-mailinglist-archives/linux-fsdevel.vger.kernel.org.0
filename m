Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941E53CCC92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 05:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhGSDWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jul 2021 23:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhGSDWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jul 2021 23:22:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB57C061762
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jul 2021 20:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6d4XEx0lOJFBXcSIffgLzB4JhYEq4AbWIFdSuGAnnmk=; b=WhOIyvKV3jepRyndAa5QiUwGG3
        UeyMQSae9sTqj6ORgzlFDZeGdAMT2yRRmocyXU/IIRHEWhZvLU7ORJ3sqjh5Q7kop9thkYiFWVrIa
        9+cPK0Km97RsI3SZVkrf0kOtcmMXcUMo69AZq7k1UuA9ZZCigPnLAsjaLabNqZKJktADO/OOq8mFb
        BZzkB//6HehTv5ZCIK7SgXMSqKMvP+lL7nQNFor3XOk8MsB6QheoQ+29bKGi6gAegp0l6/o26vrQH
        59btXl8QjqQJmPlQXKhBx//HLPcqUUlqjsDn1c8azfuiz5u7ZdQS0U2SNBNkfHLBezRSDi6sCGMTN
        rPNFMV4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5JnP-006UQv-Ao; Mon, 19 Jul 2021 03:18:33 +0000
Date:   Mon, 19 Jul 2021 04:18:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Folio tree for next
Message-ID: <YPTu+xHa+0Qz0cOu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Stephen,

Please include a new tree in linux-next:

https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next
aka
git://git.infradead.org/users/willy/pagecache.git for-next

There are some minor conflicts with mmotm.  I resolved some of them by
pulling in three patches from mmotm and rebasing on top of them.
These conflicts (or near-misses) still remain, and I'm showing my
resolution:

+++ b/arch/arm/include/asm/cacheflush.h
@@@ -290,8 -290,8 +290,9 @@@ extern void flush_cache_page(struct vm_
   */
  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
  extern void flush_dcache_page(struct page *);
+ void flush_dcache_folio(struct folio *folio);

 +#define ARCH_IMPLEMENTS_FLUSH_KERNEL_VMAP_RANGE 1
  static inline void flush_kernel_vmap_range(void *addr, int size)
  {
        if ((cache_is_vivt() || cache_is_vipt_aliasing()))
+++ b/mm/filemap.c
@@@ -836,9 -833,9 +838,9 @@@ void replace_page_cache_page(struct pag
        new->mapping = mapping;
        new->index = offset;

-       mem_cgroup_migrate(old, new);
+       mem_cgroup_migrate(fold, fnew);

 -      xas_lock_irqsave(&xas, flags);
 +      xas_lock_irq(&xas);
        xas_store(&xas, new);

        old->mapping = NULL;
diff --cc mm/page-writeback.c
index 57b98ea365e2,c2987f05c944..96b69365de65
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@@ -2739,34 -2751,17 +2763,35 @@@ bool folio_clear_dirty_for_io(struct fo
                unlocked_inode_to_wb_end(inode, &cookie);
                return ret;
        }
-       return TestClearPageDirty(page);
+       return folio_test_clear_dirty(folio);
  }
- EXPORT_SYMBOL(clear_page_dirty_for_io);
+ EXPORT_SYMBOL(folio_clear_dirty_for_io);
  
 +static void wb_inode_writeback_start(struct bdi_writeback *wb)
 +{
 +      atomic_inc(&wb->writeback_inodes);
 +}
 +
 +static void wb_inode_writeback_end(struct bdi_writeback *wb)
 +{
 +      atomic_dec(&wb->writeback_inodes);
 +      /*
 +       * Make sure estimate of writeback throughput gets updated after
 +       * writeback completed. We delay the update by BANDWIDTH_INTERVAL
 +       * (which is the interval other bandwidth updates use for batching) so
 +       * that if multiple inodes end writeback at a similar time, they get
 +       * batched into one bandwidth update.
 +       */
 +      queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
 +}
 +
- int test_clear_page_writeback(struct page *page)
+ bool __folio_end_writeback(struct folio *folio)
  {
-       struct address_space *mapping = page_mapping(page);
-       int ret;
+       long nr = folio_nr_pages(folio);
+       struct address_space *mapping = folio_mapping(folio);
+       bool ret;
  
-       lock_page_memcg(page);
+       folio_memcg_lock(folio);
        if (mapping && mapping_use_writeback_tags(mapping)) {
                struct inode *inode = mapping->host;
                struct backing_dev_info *bdi = inode_to_bdi(inode);
@@@ -2780,11 -2775,8 +2805,11 @@@
                        if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
                                struct bdi_writeback *wb = inode_to_wb(inode);
  
-                               dec_wb_stat(wb, WB_WRITEBACK);
-                               __wb_writeout_inc(wb);
+                               wb_stat_mod(wb, WB_WRITEBACK, -nr);
+                               __wb_writeout_add(wb, nr);
 +                              if (!mapping_tagged(mapping,
 +                                                  PAGECACHE_TAG_WRITEBACK))
 +                                      wb_inode_writeback_end(wb);
                        }
                }
  
@@@ -2827,18 -2821,14 +2854,18 @@@ bool __folio_start_writeback(struct fol
                                                   PAGECACHE_TAG_WRITEBACK);
  
                        xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
 -                      if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT)
 -                              wb_stat_mod(inode_to_wb(inode), WB_WRITEBACK,
 -                                              nr);
 +                      if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
 +                              struct bdi_writeback *wb = inode_to_wb(inode);
 +
-                               inc_wb_stat(wb, WB_WRITEBACK);
++                              wb_stat_mod(wb, WB_WRITEBACK, nr);
 +                              if (!on_wblist)
 +                                      wb_inode_writeback_start(wb);
 +                      }
  
                        /*
-                        * We can come through here when swapping anonymous
-                        * pages, so we don't necessarily have an inode to track
-                        * for sync.
+                        * We can come through here when swapping
+                        * anonymous folios, so we don't necessarily
+                        * have an inode to track for sync.
                         */
                        if (mapping->host && !on_wblist)
                                sb_mark_inode_writeback(mapping->host);


