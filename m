Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385E7373E41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhEEPQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhEEPQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:16:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E488C061574;
        Wed,  5 May 2021 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=27fvFe0ryVXLSHC2zpPkvk9Wh4j4iIi9y7tCdwHH8bI=; b=pWkZbvnAMGeH3RGlEKnTEoPB1V
        W5xiHxfBR0b1+g+1beS4GZSr4FCnecDgYGEtDvw9/WpQgkW3Zxd5KaZ5+mvWCuFZdN48+8+fMKZM0
        2JHWGvUwhs/4Db7X/k2sBaM779W43vczNHC65gJR1wjVOkXL6iqm5a4Nh4nk5UsdVRFvX5FHKFtWi
        cR8okgoZGnCN8UGOzc7r1jJCi5qqle/iS6EUeV+53i4l0PHYrjjyQeD8xuAurNbv2zlBSJxAmMcRv
        7Nd6BkASzI/efM10GE7Sth84ME1zWNdsfmUtqt/Ss8JEgnbYm357xwd6yLFBbBI0cEWI21LkHiHUW
        MSfKv9ZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJDc-000TkJ-7u; Wed, 05 May 2021 15:14:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v9 07/96] mm: Constify page_count and page_ref_count
Date:   Wed,  5 May 2021 16:04:59 +0100
Message-Id: <20210505150628.111735-8-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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

