Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C5B6CAC17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 19:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjC0Rph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 13:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjC0Rpc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:45:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49280199E;
        Mon, 27 Mar 2023 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sN2jldM9CY7aIkWwKeR1CK1+RammERB2ANKihvDELc4=; b=qZecYoGcykBbwmr7BQ73lsvQRL
        7gZkBAEKJXtSnbFL1+kjXtQ9/BHx6ug9L2v458DCOq4fkXkxqUuFJ4CZ5M7L/GVgnHcLBQYhRBFC6
        QWrfg+YCRq5wnEsDCbLZUN4kZSYirKyVwj0+KdtHTIXuD0om2HYLsfQhgcHrgVOgs5juAvishtQp0
        VhctSXw8l3NyR8zrorbrBrgVMmqTFpSm2Bpvfy4H2Z4hLc7Jx5L4AmO8o6wcHhHgc8w7HvEUhJ24D
        3Z9ZT4zFFIjhtTwiayCAFm1+6tWK5MycDRBzmsaxNAciKbdsiMxohtdQWGGc15DRYTUAP47SaXfGj
        Dspc/OhA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pgquI-007bGY-FT; Mon, 27 Mar 2023 17:45:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 3/3] mm: Hold the RCU read lock over calls to ->map_pages
Date:   Mon, 27 Mar 2023 18:45:15 +0100
Message-Id: <20230327174515.1811532-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230327174515.1811532-1-willy@infradead.org>
References: <20230327174515.1811532-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prevent filesystems from doing things which sleep in their map_pages
method.  This is in preparation for a pagefault path protected only
by RCU.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst |  4 ++--
 mm/memory.c                           | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 922886fefb7f..8a80390446ba 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -645,7 +645,7 @@ ops		mmap_lock	PageLocked(page)
 open:		yes
 close:		yes
 fault:		yes		can return with page locked
-map_pages:	yes
+map_pages:	read
 page_mkwrite:	yes		can return with page locked
 pfn_mkwrite:	yes
 access:		yes
@@ -661,7 +661,7 @@ locked. The VM will unlock the page.
 
 ->map_pages() is called when VM asks to map easy accessible pages.
 Filesystem should find and map pages associated with offsets from "start_pgoff"
-till "end_pgoff". ->map_pages() is called with page table locked and must
+till "end_pgoff". ->map_pages() is called with the RCU lock held and must
 not block.  If it's not possible to reach a page without blocking,
 filesystem should skip it. Filesystem should use set_pte_range() to setup
 page table entry. Pointer to entry associated with the page is passed in
diff --git a/mm/memory.c b/mm/memory.c
index 8071bb17abf2..a7edf6d714db 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4461,6 +4461,7 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	/* The page offset of vmf->address within the VMA. */
 	pgoff_t vma_off = vmf->pgoff - vmf->vma->vm_pgoff;
 	pgoff_t from_pte, to_pte;
+	vm_fault_t ret;
 
 	/* The PTE offset of the start address, clamped to the VMA. */
 	from_pte = max(ALIGN_DOWN(pte_off, nr_pages),
@@ -4476,9 +4477,13 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 			return VM_FAULT_OOM;
 	}
 
-	return vmf->vma->vm_ops->map_pages(vmf,
-		vmf->pgoff + from_pte - pte_off,
-		vmf->pgoff + to_pte - pte_off);
+	rcu_read_lock();
+	ret = vmf->vma->vm_ops->map_pages(vmf,
+			vmf->pgoff + from_pte - pte_off,
+			vmf->pgoff + to_pte - pte_off);
+	rcu_read_unlock();
+
+	return ret;
 }
 
 /* Return true if we should do read fault-around, false otherwise */
-- 
2.39.2

