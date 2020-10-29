Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F3A29F55D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgJ2TeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgJ2TeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0FEC0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=l3Uro+7ac/lRqi712xHiq8ZfTNOWcphqVa06+YHLQMc=; b=jc65qq8SyRwDz41gI2oZLmMKJt
        qT2hX/tLg5oVN3xhHJy3IKoyss20k4x97u4URjS2IlDEb/+2tCDm7E68Wzw6JLcIoswEapJ3N9MFE
        5/OYTq60uCAa+pYXJnu27Nj8ChZsaPE8tJVqQdKLE4+/E1sq8/dAQ4mndKyDWZbO7udZNuQYWB2/T
        e7zSMCLUcigQnfzkz7vyBGPXr7M+wDML0fvMhnOy6aAkODphaO9kkYYFMlrDrtidZoqq+nMvPkQMm
        2mRbDZbqniBoAm/e6v3c/ttgXz8fuLf+0iXx1ODRwW6m2Bxmb0AzzRP8JrUQiCjmffgh0a724BCbq
        VyUeD3Mg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDga-0007d1-9I; Thu, 29 Oct 2020 19:34:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 18/19] mm/filemap: Support VM_HUGEPAGE for file mappings
Date:   Thu, 29 Oct 2020 19:34:04 +0000
Message-Id: <20201029193405.29125-19-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the VM_HUGEPAGE flag is set, attempt to allocate PMD-sized THPs
during readahead, even if we have no history of readahead being
successful.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index ee4a4990bad3..79a2ac001948 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2801,6 +2801,20 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	/* Use the readahead code for THP, even if readahead is disabled */
+	if (vmf->vma->vm_flags & VM_HUGEPAGE) {
+		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
+		ra->size = HPAGE_PMD_NR;
+		if (vmf->vma->vm_flags & VM_RAND_READ)
+			ra->size *= 2;
+		ra->async_size = HPAGE_PMD_NR;
+		page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
+		return fpin;
+	}
+#endif
+
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
 		return fpin;
-- 
2.28.0

