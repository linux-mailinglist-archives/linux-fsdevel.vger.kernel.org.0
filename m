Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F37B6F5B72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 17:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjECPpd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 11:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjECPpc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 11:45:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F1C619B
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MiREGWuSJ6yPcrwP2TkqyYmrxbKxebACKopRegSgDDM=; b=QIpReoppX+7W8gWJ/2Llctb718
        XjUxDThfsAVCAunJ73cqtLMIdZz7LIiChj5D9X8DhMP0CR18lwTuRbiVxZXiRYh17IH9maOjW5lPG
        zalNpzdHvQTvSIWqpUjLHanS67wovYkpwP01O+CYTBQg/LgzfvWYckSF4XwYDg/YGmdCBSZwbQiVV
        uQOv1HQoB5ocKSs5IYolYxSRQilShDaHIlsfH4bb045o5eV8dlpyi9ygw2Tvf9U7yZ0cV9qd7jd4q
        6S/0lygIOECqsK7e9PWYlTwhyo+1a+4FL3wXPi8pqRudMOvhwtOz7B3kuE2ROiYj+m+zhLSp9I+SI
        vip/gyRw==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puEfY-0050jA-0S;
        Wed, 03 May 2023 15:45:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     akpm@linux-foundation.org
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com
Subject: [PATCH 1/2] filemap: fix the conditional folio_put in filemap_fault
Date:   Wed,  3 May 2023 17:45:25 +0200
Message-Id: <20230503154526.1223095-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

folio can't be NULL here now that __filemap_get_folio returns an
ERR_PTR.  Remove the conditional folio_put after the out_retry
label and add a new label for the cases where we have a valid folio.

Fixes: 66dabbb65d67 ("mm: return an ERR_PTR from __filemap_get_folio")
Reported-by: syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a34abfe8c65430..ae597f63a9bc54 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3298,7 +3298,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	}
 
 	if (!lock_folio_maybe_drop_mmap(vmf, folio, &fpin))
-		goto out_retry;
+		goto out_retry_put_folio;
 
 	/* Did it get truncated? */
 	if (unlikely(folio->mapping != mapping)) {
@@ -3334,7 +3334,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 */
 	if (fpin) {
 		folio_unlock(folio);
-		goto out_retry;
+		goto out_retry_put_folio;
 	}
 	if (mapping_locked)
 		filemap_invalidate_unlock_shared(mapping);
@@ -3363,7 +3363,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
 	if (fpin)
-		goto out_retry;
+		goto out_retry_put_folio;
 	folio_put(folio);
 
 	if (!error || error == AOP_TRUNCATED_PAGE)
@@ -3372,14 +3372,14 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 
 	return VM_FAULT_SIGBUS;
 
+out_retry_put_folio:
+	folio_put(folio);
 out_retry:
 	/*
 	 * We dropped the mmap_lock, we need to return to the fault handler to
 	 * re-find the vma and come back and find our hopefully still populated
 	 * page.
 	 */
-	if (folio)
-		folio_put(folio);
 	if (mapping_locked)
 		filemap_invalidate_unlock_shared(mapping);
 	if (fpin)
-- 
2.39.2

