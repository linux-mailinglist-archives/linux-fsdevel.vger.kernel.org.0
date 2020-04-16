Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6141AD274
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 00:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgDPWBd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 18:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727998AbgDPWBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:01:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D8C061A0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6nnPlD6yNmurx3gJbzRxQonr2FAcOIdGlhNqGMTRzlA=; b=uRHQGprXdszqvevb0pyd2gDUee
        9jHxUj+A9+OjhbmwojSnIJjaKBeW8N3J9fA2XWwM2Y0KlVw1AYkPEX3DrGL5g9/8wHcjxAabn4Kf4
        U3tfrHeDy4zlMGst6IoFp7WDhAFDfOpfYnlpAUrfnWmCZ8W5c6t5aUgvYzDuu3GCcWk5CjB1CKCcv
        9lqaiCkObHdGjPeCU6NtAtpN4lz70CmVi0lZHSETeP+VhrHDSxFQuiSQoUHuCuXGgbgKQd2ObAe92
        rVF79gaU7GD6fYZn3jpP540LeuHqm3AL02mWRNHB2dJTkladUA58sp0WbsvMHNfEGFRPG/T69D05r
        N1rbHYqg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPCZg-0003UZ-KC; Thu, 16 Apr 2020 22:01:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v3 07/11] mm: Remove definition of clear_bit_unlock_is_negative_byte
Date:   Thu, 16 Apr 2020 15:01:26 -0700
Message-Id: <20200416220130.13343-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416220130.13343-1-willy@infradead.org>
References: <20200416220130.13343-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

All architectures now have a definition of
clear_bit_unlock_is_negative_byte(), either their own or through
asm-generic/bitops/lock.h

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/filemap.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 23a051a7ef0f..e475117e89eb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1248,29 +1248,6 @@ void add_page_wait_queue(struct page *page, wait_queue_entry_t *waiter)
 }
 EXPORT_SYMBOL_GPL(add_page_wait_queue);
 
-#ifndef clear_bit_unlock_is_negative_byte
-
-/*
- * PG_waiters is the high bit in the same byte as PG_lock.
- *
- * On x86 (and on many other architectures), we can clear PG_lock and
- * test the sign bit at the same time. But if the architecture does
- * not support that special operation, we just do this all by hand
- * instead.
- *
- * The read of PG_waiters has to be after (or concurrently with) PG_locked
- * being cleared, but a memory barrier should be unneccssary since it is
- * in the same byte as PG_locked.
- */
-static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem)
-{
-	clear_bit_unlock(nr, mem);
-	/* smp_mb__after_atomic(); */
-	return test_bit(PG_waiters, mem);
-}
-
-#endif
-
 /**
  * unlock_page - unlock a locked page
  * @page: the page
-- 
2.25.1

