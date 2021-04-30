Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0119436FD58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 17:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhD3PGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhD3PGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:06:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F79C06138B
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=27fvFe0ryVXLSHC2zpPkvk9Wh4j4iIi9y7tCdwHH8bI=; b=bCgiIdKZfp8hXijO5K4VjhQ28z
        tTQSVyYOncTCLiLNpnXnX0OzkI2qxbG1JPGV+qDLPEc4LrJ6cOdEK94+EsWsz5JWlsrqLj3XNZvT9
        mzlI0+Gy6xogrBpja/O3M0wCbnYTtJctrJeVjI3Puocw4WDH5aCeNFM0B3xiN8QODLE/TrU31165p
        J5zFbfQ4BB9ssEVO5AIx00ppKIMBoKzUTfYTA4Go7oVEDyBqixdxB+LX0o6dhyFuy5DnyhG0bUPZB
        Qyb31kio9TMyimzvJwWzTc+XKZXd0SZktx4Z5i1H/ztGpLDCBYXrzDDs5u/9eAkHLDtENd+FKkpmF
        byJqO0iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcUgc-00BBFh-KU; Fri, 30 Apr 2021 15:04:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 7/8] mm: Constify page_count and page_ref_count
Date:   Fri, 30 Apr 2021 15:55:48 +0100
Message-Id: <20210430145549.2662354-8-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430145549.2662354-1-willy@infradead.org>
References: <20210430145549.2662354-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that compound_head() accepts a const struct page pointer, these two
functions can be marked as not modifying the page pointer they are passed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/page_ref.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index f3318f34fc54..7ad46f45df39 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -62,12 +62,12 @@ static inline void __page_ref_unfreeze(struct page *page, int v)
 
 #endif
 
-static inline int page_ref_count(struct page *page)
+static inline int page_ref_count(const struct page *page)
 {
 	return atomic_read(&page->_refcount);
 }
 
-static inline int page_count(struct page *page)
+static inline int page_count(const struct page *page)
 {
 	return atomic_read(&compound_head(page)->_refcount);
 }
-- 
2.30.2

