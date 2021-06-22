Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B083B030E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 13:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFVLpV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 07:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhFVLpS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:45:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5226FC061574;
        Tue, 22 Jun 2021 04:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vS9S0qtqM0bMVrmGqUgopcPW1FyGemIPeDn4hOJeRhs=; b=cop1+SZaoUMuggg6qPW1bjS685
        nZAoXdIZsEov3uEtYjJudPmrs0TTW3wQSYp4ZGwr2P6xM3dwi+Q06fjUqmmXJhjG6CHMPx4T61lS6
        T5oKECa2ZSx2XdT1qoncnHXNxTFHiQH7Cqp7qnzq+RgGrLeFRXnIPfsB4rR2Dz4jJ2/QdJUhamhxj
        F+p0ZWMAFD/17nciN5/oLUv3jTc/YM100jP9eDTweLC9Ml0x9sIZufr9Lb94wghBqdRZMH1bL50x1
        gLOT5Y39RIbMJKwGj0AjaWCdxkN/51kkhcPKZrSLGXctd4tX1kGWnwMNcC8NADMPwrWJBpDBC048Z
        zffgME/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvenA-00EDVF-VI; Tue, 22 Jun 2021 11:42:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 01/33] mm: Convert get_page_unless_zero() to return bool
Date:   Tue, 22 Jun 2021 12:40:46 +0100
Message-Id: <20210622114118.3388190-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622114118.3388190-1-willy@infradead.org>
References: <20210622114118.3388190-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

atomic_add_unless() returns bool, so remove the widening casts to int
in page_ref_add_unless() and get_page_unless_zero().  This causes gcc
to produce slightly larger code in isolate_migratepages_block(), but
it's not clear that it's worse code.  Net +19 bytes of text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h       | 2 +-
 include/linux/page_ref.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2c0612209ab1..cc08ec4329b8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -757,7 +757,7 @@ static inline int put_page_testzero(struct page *page)
  * This can be called when MMU is off so it must not access
  * any of the virtual mappings.
  */
-static inline int get_page_unless_zero(struct page *page)
+static inline bool get_page_unless_zero(struct page *page)
 {
 	return page_ref_add_unless(page, 1, 0);
 }
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 7ad46f45df39..3a799de8ad52 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -161,9 +161,9 @@ static inline int page_ref_dec_return(struct page *page)
 	return ret;
 }
 
-static inline int page_ref_add_unless(struct page *page, int nr, int u)
+static inline bool page_ref_add_unless(struct page *page, int nr, int u)
 {
-	int ret = atomic_add_unless(&page->_refcount, nr, u);
+	bool ret = atomic_add_unless(&page->_refcount, nr, u);
 
 	if (page_ref_tracepoint_active(page_ref_mod_unless))
 		__page_ref_mod_unless(page, nr, ret);
-- 
2.30.2

