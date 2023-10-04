Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FEF7B85D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243557AbjJDQxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbjJDQxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB43EE;
        Wed,  4 Oct 2023 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VjQq5vIRQg04dws7PyaymhwSTjm3kTO8DTKw00f2iiE=; b=WlYR7SVyJnVNGNohBfF4SgXWK4
        eiC2zmNKFtHyl0x9NHoD2Qj1GbLuvT9EfwgRXBH1bL+XUgJojOeePsBlj7eT+NoeJgfEXHAG7GTYQ
        oEZxQCk9OpT6d54J6R4sPQVYiJF8CjbPIXDfQ5fDNIaV7apCBlDD45D/7PZfXW3GGnYexS6Kergtq
        y7T4LA9JNaQ10uu2a1zCent9hOjzxoZi1Hsu2yv63P1xWF0B0ohpBTJRPXqYq9fdYxS6Xvw08aGHc
        9cYF6pUKSBX41H5rDJac/ghEXLdcGM5d5+ihGxsw7ysvqGc4z7KoWUcGQDspm4pNnmE0KD9tDht/U
        HUI2ig1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57g-004SG6-Og; Wed, 04 Oct 2023 16:53:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 15/17] mm: Add folio_xor_flags_has_waiters()
Date:   Wed,  4 Oct 2023 17:53:15 +0100
Message-Id: <20231004165317.1061855-16-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231004165317.1061855-1-willy@infradead.org>
References: <20231004165317.1061855-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Optimise folio_end_read() by setting the uptodate bit at the same time
we clear the unlock bit.  This saves at least one memory barrier and
one write-after-write hazard.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 19 +++++++++++++++++++
 mm/filemap.c               | 14 +++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5c02720c53a5..a88e64acebfe 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -692,6 +692,25 @@ TESTPAGEFLAG_FALSE(Ksm, ksm)
 
 u64 stable_page_flags(struct page *page);
 
+/**
+ * folio_xor_flags_has_waiters - Change some folio flags.
+ * @folio: The folio.
+ * @mask: Bits set in this word will be changed.
+ *
+ * This must only be used for flags which are changed with the folio
+ * lock held.  For example, it is unsafe to use for PG_dirty as that
+ * can be set without the folio lock held.  It can also only be used
+ * on flags which are in the range 0-6 as some of the implementations
+ * only affect those bits.
+ *
+ * Return: Whether there are tasks waiting on the folio.
+ */
+static inline bool folio_xor_flags_has_waiters(struct folio *folio,
+		unsigned long mask)
+{
+	return xor_unlock_is_negative_byte(mask, folio_flags(folio, 0));
+}
+
 /**
  * folio_test_uptodate - Is this folio up to date?
  * @folio: The folio.
diff --git a/mm/filemap.c b/mm/filemap.c
index ab8f798eb0af..3dad2615af41 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1499,7 +1499,7 @@ void folio_unlock(struct folio *folio)
 	BUILD_BUG_ON(PG_waiters != 7);
 	BUILD_BUG_ON(PG_locked > 7);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	if (xor_unlock_is_negative_byte(1 << PG_locked, folio_flags(folio, 0)))
+	if (folio_xor_flags_has_waiters(folio, 1 << PG_locked))
 		folio_wake_bit(folio, PG_locked);
 }
 EXPORT_SYMBOL(folio_unlock);
@@ -1520,9 +1520,17 @@ EXPORT_SYMBOL(folio_unlock);
  */
 void folio_end_read(struct folio *folio, bool success)
 {
+	unsigned long mask = 1 << PG_locked;
+
+	/* Must be in bottom byte for x86 to work */
+	BUILD_BUG_ON(PG_uptodate > 7);
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
+
 	if (likely(success))
-		folio_mark_uptodate(folio);
-	folio_unlock(folio);
+		mask |= 1 << PG_uptodate;
+	if (folio_xor_flags_has_waiters(folio, mask))
+		folio_wake_bit(folio, PG_locked);
 }
 EXPORT_SYMBOL(folio_end_read);
 
-- 
2.40.1

