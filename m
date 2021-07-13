Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009753C6A6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 08:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhGMG2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 02:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhGMG2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 02:28:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFFEC0613DD;
        Mon, 12 Jul 2021 23:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5NJ/GobYssN7on3zOlsbOWTmiBv2EzLNZy86W7YdGXg=; b=fbsmLbOQszWOm3dv8Pr5kj2E7C
        2oH8QijCtEXZ3EozE81NW39ttgW8OJljVf+LGGn1grSH4J/TUVDG0j2e/NTp+MRk4wJ9nnd3+guTz
        +uiAyPZWdlJAz/ObZcfnq4duRgc9SCYl6elA/kg4FjqqjxRWiSyctVBKCNGsl9KYTYO892oJYWZI5
        TrvEbdC7HmPZPoevV1PUKcLJ6czjAami4Jbi7sr+F0PnKOI41Qf+ldIkfRpOlaioGlDjqxR3FtMJ3
        yq3YPlebvzDtb55VjfVt14OhvN5M9EDIMhIcPqpI3SwMoNGZzFinwEFn0SbUkZR/uo311WDKHFLwQ
        3JuzSKBg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3Bqr-000oBA-3D; Tue, 13 Jul 2021 06:25:10 +0000
Date:   Tue, 13 Jul 2021 07:25:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/14] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <YO0xwY+q7d8rQE3f@infradead.org>
References: <20210712163901.29514-1-jack@suse.cz>
 <20210712165609.13215-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712165609.13215-3-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Still looks good.  That being said the additional conditional locking in
filemap_fault makes it fall over the readbility cliff for me.  Something
like this on top of your series would help:

diff --git a/mm/filemap.c b/mm/filemap.c
index fd3f94d36c49..0fad08331cf4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3040,21 +3040,23 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * Do we have something in the page cache already?
 	 */
 	page = find_get_page(mapping, offset);
-	if (likely(page) && !(vmf->flags & FAULT_FLAG_TRIED)) {
+	if (likely(page)) {
 		/*
-		 * We found the page, so try async readahead before
-		 * waiting for the lock.
+		 * We found the page, so try async readahead before waiting for
+		 * the lock.
 		 */
-		fpin = do_async_mmap_readahead(vmf, page);
-	} else if (!page) {
+		if (!(vmf->flags & FAULT_FLAG_TRIED))
+			fpin = do_async_mmap_readahead(vmf, page);
+		if (unlikely(!PageUptodate(page))) {
+			filemap_invalidate_lock_shared(mapping);
+			mapping_locked = true;
+		}
+	} else {
 		/* No page in the page cache at all */
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
 		fpin = do_sync_mmap_readahead(vmf);
-	}
-
-	if (!page) {
 retry_find:
 		/*
 		 * See comment in filemap_create_page() why we need
@@ -3073,9 +3075,6 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 			filemap_invalidate_unlock_shared(mapping);
 			return VM_FAULT_OOM;
 		}
-	} else if (unlikely(!PageUptodate(page))) {
-		filemap_invalidate_lock_shared(mapping);
-		mapping_locked = true;
 	}
 
 	if (!lock_page_maybe_drop_mmap(vmf, page, &fpin))
