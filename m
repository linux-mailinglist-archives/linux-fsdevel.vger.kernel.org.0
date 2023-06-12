Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8659672D16B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbjFLVFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbjFLVEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:04:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B02E2959
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=I07LqDro4fa5l6e/F6p2fyQSef3eBPSmHHHBiFnjelc=; b=bPGjuQwXCCyvsRA/mQdrkkWQey
        Tlqe5Ew9ZOK5/BFgB5dEJVayh21G4YQIbmED1RP4i6tGr1xk+HkqpmRSWRjEpPWskC46eYhI6tno5
        LA/5suxoCbKsq4IH+HEqqePInPtQWX7/cZa+kKXb5Kr/f+wfiJcjs2wUvp/gWj8wLXr58Zm9v5vXX
        VNk2v8y1VFi7SA9D1oPJOPOgPcTevlZUsN/D260TrTR0+fV8B/kKSwO3hfg/rHWmiYEPbSbfmlsE0
        7q5uBhF9KV9T/xT7Oy9hdxNH7OVrML2+dVwuMlG3L9gS+uI2vu9ELq3G++fNBaF0LIb52ptf3nADY
        aoC4pkDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8ofX-0033wq-Gc; Mon, 12 Jun 2023 21:01:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 07/14] buffer: Convert block_page_mkwrite() to use a folio
Date:   Mon, 12 Jun 2023 22:01:34 +0100
Message-Id: <20230612210141.730128-8-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230612210141.730128-1-willy@infradead.org>
References: <20230612210141.730128-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If any page in a folio is dirtied, dirty the entire folio.  Removes a
number of hidden calls to compound_head() and references to page->mapping
and page->index.  Fixes a pre-existing bug where we could mark a folio
as dirty if the file is truncated to a multiple of the page size just
as we take the page fault.  I don't believe this bug has any bad effect,
it's just inefficient.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 34ecf55d2f12..0af167e8a9c6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2564,38 +2564,37 @@ EXPORT_SYMBOL(block_commit_write);
 int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 			 get_block_t get_block)
 {
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vma->vm_file);
 	unsigned long end;
 	loff_t size;
 	int ret;
 
-	lock_page(page);
+	folio_lock(folio);
 	size = i_size_read(inode);
-	if ((page->mapping != inode->i_mapping) ||
-	    (page_offset(page) > size)) {
+	if ((folio->mapping != inode->i_mapping) ||
+	    (folio_pos(folio) >= size)) {
 		/* We overload EFAULT to mean page got truncated */
 		ret = -EFAULT;
 		goto out_unlock;
 	}
 
-	/* page is wholly or partially inside EOF */
-	if (((page->index + 1) << PAGE_SHIFT) > size)
-		end = size & ~PAGE_MASK;
-	else
-		end = PAGE_SIZE;
+	end = folio_size(folio);
+	/* folio is wholly or partially inside EOF */
+	if (folio_pos(folio) + end > size)
+		end = size - folio_pos(folio);
 
-	ret = __block_write_begin(page, 0, end, get_block);
+	ret = __block_write_begin_int(folio, 0, end, get_block, NULL);
 	if (!ret)
-		ret = block_commit_write(page, 0, end);
+		ret = block_commit_write(&folio->page, 0, end);
 
 	if (unlikely(ret < 0))
 		goto out_unlock;
-	set_page_dirty(page);
-	wait_for_stable_page(page);
+	folio_mark_dirty(folio);
+	folio_wait_stable(folio);
 	return 0;
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	return ret;
 }
 EXPORT_SYMBOL(block_page_mkwrite);
-- 
2.39.2

