Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBC7193EC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 13:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgCZMYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 08:24:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgCZMYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bjDpq9aWp0c7sT1Qd53mP4H8OeuVc80SeveQdwhk3LU=; b=Fm+Cp8Kb6EtCcMDoqdlSwEsvKp
        +piZOjIxfM8rJpI2mpTxIJFrtl1ambnfGjaYzFDV58CZW/CyRWyRNJNpN2h89HhoHn0ACv1hYiwaZ
        ZeZtFe3SHs7eiN5a00r4BZWsZTKcfSy5uhJVPSvayvjUfmoWo7jZLXRis4ekYUvCQgXEDftEPPuzn
        6MxZngYmuRtvA7JD1XIlmJRvkFmphIO2Xm4x2p4z1nvE73qJ5XLLXG4YqJoVvPIqlO0iPQSGXrtoj
        iK/ApkgkvOmE7cm7QpwbAK2J36XmjZm3jifDI5ZL4VgmCE7uWZFltDS18nlKfR0DYMFsHQLt7eKwe
        ROvxK4aQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHRYk-0005P0-6M; Thu, 26 Mar 2020 12:24:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/2] mm: Remove definition of clear_bit_unlock_is_negative_byte
Date:   Thu, 26 Mar 2020 05:24:28 -0700
Message-Id: <20200326122429.20710-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200326122429.20710-1-willy@infradead.org>
References: <20200326122429.20710-1-willy@infradead.org>
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
Cc: Will Deacon <will.deacon@arm.com>
---
 mm/filemap.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 80f7e1ae744c..312afbfcb49a 100644
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

