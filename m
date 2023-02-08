Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE4068F149
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 15:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjBHOxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 09:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjBHOxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:53:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A0872BD;
        Wed,  8 Feb 2023 06:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HdngZPvdXKZlg8aWQlwaqgB89GRwI5fL2TphFM1bPZg=; b=mIOoo7xcGsiBchVCgVhbLA4GaO
        maepzfffPhFBJh1ZKAHeGTvMELGTvkEl1c5Pd5Ozj2+WhTRZx5zJhWSjhMJuicBsK3oVsqPUYMhir
        uhf0TZjF4cHNOgF+dXtJ10FaVGNsWhu0m47+EYSn3La4I863Krw849ee81FyoWUx3PJAUiIHGTEx4
        t3Jhl1tgNZhpQvFDRvqar4cn/H8ZeaFrvvVzrNlGj97rXB3vggM1iZ+jaPHHIv5QuHYkSemgA2mQN
        SGpnygNsMm2kdC4RlP/rI5FyFdlvpYKAB2nQNKgD9zG2/T9PP+JHqyc7/ih3F9IQX2KMX6ueG+rhe
        QO25gZLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPlpL-001HwV-1L; Wed, 08 Feb 2023 14:53:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 3/3] mm: Hold the RCU read lock over calls to ->map_pages
Date:   Wed,  8 Feb 2023 14:53:35 +0000
Message-Id: <20230208145335.307287-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230208145335.307287-1-willy@infradead.org>
References: <20230208145335.307287-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/filesystems/locking.rst | 4 ++--
 mm/memory.c                           | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

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
index f1cf47b7e3bb..77577a1d09ac 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4442,6 +4442,7 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	unsigned long address = vmf->address, nr_pages, mask;
 	pgoff_t start_pgoff = vmf->pgoff;
 	pgoff_t end_pgoff;
+	vm_fault_t ret;
 	int off;
 
 	nr_pages = READ_ONCE(fault_around_bytes) >> PAGE_SHIFT;
@@ -4467,7 +4468,11 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 			return VM_FAULT_OOM;
 	}
 
-	return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
+	rcu_read_lock();
+	ret = vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
+	rcu_read_unlock();
+
+	return ret;
 }
 
 /* Return true if we should do read fault-around, false otherwise */
-- 
2.35.1

