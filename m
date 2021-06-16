Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B843AA063
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 17:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhFPPwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 11:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbhFPPwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:52:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3EBC061574;
        Wed, 16 Jun 2021 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=E5vX2MLfmqTWkpek062RxTj+YrNTuLmQP4A+jQIoiJ4=; b=dIAWMqFaji5kUvQpp46QKUy+Fh
        CI4H3SUGQXMsU3C1s3aXacUCPKT9OZeZSNlVyBCfWWzQ6HyJbXbe/P+d6LD5+1Q/m3RWX5zf9tjJo
        3fqeoVmCohgUa/G1D4G17YK0F+csk105KUK/6RCyBvwWzB7TGQ6q3O8cO0x3h2G+bZpABCAlRL2xv
        d/u4UMaEMGOMeRdUDHBjV/ZSgn9CazHVFG1o7VxqynEqaiVlfaNW3UqfvWj4NYL1maffO2NnuGDAM
        jQbxFtRohDPYjrmlVJtnpIaXm/vUUausGSCbPoPi08mZApH3g2EzkV23SAFfWTZLAULsQgvT6um7a
        5UEuEdtw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltXmp-008DWU-7P; Wed, 16 Jun 2021 15:49:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] afs: Re-enable freezing once a page fault is interrupted
Date:   Wed, 16 Jun 2021 16:49:00 +0100
Message-Id: <20210616154900.1958373-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a task is killed during a page fault, it does not currently call
sb_end_pagefault(), which means that the filesystem cannot be frozen
at any time thereafter.  This may be reported by lockdep like this:

====================================
WARNING: fsstress/10757 still has locks held!
5.13.0-rc4-build4+ #91 Not tainted
------------------------------------
1 lock held by fsstress/10757:
 #0: ffff888104eac530
 (
sb_pagefaults

as filesystem freezing is modelled as a lock.

Fix this by removing all the direct returns from within the function,
and using 'ret' to indicate whether we were interrupted or successful.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/write.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index a523bb86915d..62dd906f9b72 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -832,6 +832,7 @@ int afs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  */
 vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 {
+	vm_fault_t ret = VM_FAULT_RETRY;
 	struct page *page = thp_head(vmf->page);
 	struct file *file = vmf->vma->vm_file;
 	struct inode *inode = file_inode(file);
@@ -848,14 +849,14 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 #ifdef CONFIG_AFS_FSCACHE
 	if (PageFsCache(page) &&
 	    wait_on_page_fscache_killable(page) < 0)
-		return VM_FAULT_RETRY;
+		goto out;
 #endif
 
 	if (wait_on_page_writeback_killable(page))
-		return VM_FAULT_RETRY;
+		goto out;
 
 	if (lock_page_killable(page) < 0)
-		return VM_FAULT_RETRY;
+		goto out;
 
 	/* We mustn't change page->private until writeback is complete as that
 	 * details the portion of the page we need to write back and we might
@@ -863,7 +864,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 */
 	if (wait_on_page_writeback_killable(page) < 0) {
 		unlock_page(page);
-		return VM_FAULT_RETRY;
+		goto out;
 	}
 
 	priv = afs_page_dirty(page, 0, thp_size(page));
@@ -877,8 +878,10 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	}
 	file_update_time(file);
 
+	ret = VM_FAULT_LOCKED;
+out:
 	sb_end_pagefault(inode->i_sb);
-	return VM_FAULT_LOCKED;
+	return ret;
 }
 
 /*
-- 
2.30.2

