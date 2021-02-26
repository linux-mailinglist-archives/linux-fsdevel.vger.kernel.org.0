Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A450332639E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 15:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhBZOBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 09:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZOBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:01:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED67C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Feb 2021 06:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mEMVgXDc2/lvAr/oSwoM2Grls7q5GWAhife7U4SoQCs=; b=wFihlEPtOvO4y5n1FoFi518OpR
        kH+nmDloDHB7bz2+rEFYGRKemxQgetpC4moY3yM7ZGNjxUMpJYstADZpE4fOWQmUINRxrNk58+Fe3
        Fo1YDs9T7FMZBAXCioGOC/WY1EDc6IA910BJkkbWKy3uj2Xt3cNlSj2oyaJKyIqzkPi4hcHU0F3tM
        aOLu1uOSjqAsbXs9144pbyN7n5wPXG/l3etE3N/PZiHeUW+4vFHzkRn5g9u13d+YU5WUKHQZTTORd
        XjBrG1WJR0NuwZMfuwMhEFSLd6e4Js6v8PlX+4pAE4FXaR5CdopODwM6ldwe7aQ7FN2Pk+ZwLGJLH
        fWnKCkIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFdfM-00C6F4-AD; Fri, 26 Feb 2021 14:00:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] mm/filemap: Use filemap_read_page in filemap_fault
Date:   Fri, 26 Feb 2021 14:00:11 +0000
Message-Id: <20210226140011.2883498-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After splitting generic_file_buffered_read() into smaller parts, it
turns out we can reuse one of the parts in filemap_fault().  This fixes
an oversight -- waiting for the I/O to complete is now interruptible
by a fatal signal.  And it saves us a few bytes of text in an unlikely
path.

$ ./scripts/bloat-o-meter before.o after.o
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-207 (-207)
Function                                     old     new   delta
filemap_fault                               2187    1980    -207
Total: Before=37491, After=37284, chg -0.55%

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 46a8b9e82434..f7ab86d13692 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2748,7 +2748,6 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	struct file *file = vmf->vma->vm_file;
 	struct file *fpin = NULL;
 	struct address_space *mapping = file->f_mapping;
-	struct file_ra_state *ra = &file->f_ra;
 	struct inode *inode = mapping->host;
 	pgoff_t offset = vmf->pgoff;
 	pgoff_t max_off;
@@ -2835,14 +2834,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * because there really aren't any performance issues here
 	 * and we need to check for errors.
 	 */
-	ClearPageError(page);
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	error = mapping->a_ops->readpage(file, page);
-	if (!error) {
-		wait_on_page_locked(page);
-		if (!PageUptodate(page))
-			error = -EIO;
-	}
+	error = filemap_read_page(file, mapping, page);
 	if (fpin)
 		goto out_retry;
 	put_page(page);
@@ -2850,7 +2843,6 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (!error || error == AOP_TRUNCATED_PAGE)
 		goto retry_find;
 
-	shrink_readahead_size_eio(ra);
 	return VM_FAULT_SIGBUS;
 
 out_retry:
-- 
2.30.0

