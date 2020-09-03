Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9490A25C3C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgICO5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgICOJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:09:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADCFC0611E9
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2cBKtztXbapuaDPjC85hkD+JbRvyUkQLpluPy1fPuaE=; b=ioXVhWw7Lh/7jBgBK8c4XzfU4h
        N4msuXj3b9ryTcdexBSV4qFmNkEhq+SkR4XAv3JPJRh4MarNV0X6hXjB1k1alncu3V2CzAvbe7rAD
        jdGHEQz4iNhZTnpN3DmI5BHQb0pNk+LjHZsN23EbyN13sTlUuhz0pcn4S1Hbhp2IcGzQcV6HGlJRB
        XfXzRabXH3WYjWKE2xb4NoGIOgK4CvzU/PVIrla7kquX0WFCrxW7Yxvvi4Vr7InQiwg8dlwNzMOkY
        Len2NIvWhyj1+Jm8X6TgcncIJc4/PVKB9/nXuODEiPFGlZ+F1S4QY7L2dm4q2m7edl78KSKAA3Rq3
        mG+0eBig==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDpv3-0003ik-7B; Thu, 03 Sep 2020 14:08:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 8/9] mm/filemap: Fold ra_submit into do_sync_mmap_readahead
Date:   Thu,  3 Sep 2020 15:08:43 +0100
Message-Id: <20200903140844.14194-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903140844.14194-1-willy@infradead.org>
References: <20200903140844.14194-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Fold ra_submit() into its last remaining user and pass the
readahead_control struct to both do_page_cache_ra() and
page_cache_sync_ra().

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c  | 10 +++++-----
 mm/internal.h | 10 ----------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1aaea26556cc..1ad49c33439a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2466,8 +2466,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
+	DEFINE_READAHEAD(ractl, file, mapping, vmf->pgoff);
 	struct file *fpin = NULL;
-	pgoff_t offset = vmf->pgoff;
 	unsigned int mmap_miss;
 
 	/* If we don't want any read-ahead, don't bother */
@@ -2478,8 +2478,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 
 	if (vmf->vma->vm_flags & VM_SEQ_READ) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-		page_cache_sync_readahead(mapping, ra, file, offset,
-					  ra->ra_pages);
+		page_cache_sync_ra(&ractl, ra, ra->ra_pages);
 		return fpin;
 	}
 
@@ -2499,10 +2498,11 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	 * mmap read-around
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	ra->start = max_t(long, 0, offset - ra->ra_pages / 2);
+	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
 	ra->size = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
-	ra_submit(ra, mapping, file);
+	ractl._index = ra->start;
+	do_page_cache_ra(&ractl, ra->size, ra->async_size);
 	return fpin;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 5533e85bd123..0a2e5caea2aa 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -59,16 +59,6 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 	force_page_cache_ra(&ractl, nr_to_read);
 }
 
-/*
- * Submit IO for the read-ahead request in file_ra_state.
- */
-static inline void ra_submit(struct file_ra_state *ra,
-		struct address_space *mapping, struct file *file)
-{
-	DEFINE_READAHEAD(ractl, file, mapping, ra->start);
-	do_page_cache_ra(&ractl, ra->size, ra->async_size);
-}
-
 /**
  * page_evictable - test whether a page is evictable
  * @page: the page to test
-- 
2.28.0

