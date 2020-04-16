Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03581ACB55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442554AbgDPPqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 11:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896197AbgDPPqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:46:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9739FC061A0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=U3XbVI/G3k9Tca1zKvDwvCI1RNjoXRMlSqZER3XJ0Ko=; b=GVCnmJ8bueTlIyCZ/zDWPwzeHg
        X2LImeSYBkbh8Tn6+/S19ppU0O5iS2ShjgsgupP7Ths1ZkcEekA5uAzjGDVcY1K+URNX4dtxgIw+q
        2ygQGDMXz8xC32MLbpJszwYvrlk9eOiRzP9c7Usd9r1cASknXeGKZI5D7QbwKLiJZ1lPPjKCmxsZ7
        FWTYjh20ee5qLXlzwwH/dw8bpctSrXZ/cBQ2DdGAFmLh25hz7WheDd9psyV7nI4gwRoTzAhD01xnM
        YW4LW8WHSno/4ZhUPkSrCqSJd0ZDM0MoDdyt4jvyeE+XxTyuNTYLrtEfTqVLTrRO//N8dzeY9YpeN
        Z+Df2CHQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6iN-00006N-Dq; Thu, 16 Apr 2020 15:46:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 1/5] mm: Remove definition of clear_bit_unlock_is_negative_byte
Date:   Thu, 16 Apr 2020 08:46:02 -0700
Message-Id: <20200416154606.306-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416154606.306-1-willy@infradead.org>
References: <20200416154606.306-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This local definition hasn't been used since commit 84c6591103db
("locking/atomics, asm-generic/bitops/lock.h: Rewrite using
atomic_fetch_*()") which provided a default definition.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Cc: Will Deacon <will@kernel.org>
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

