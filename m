Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1051647EC0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351577AbhLXGXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351525AbhLXGXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54988C061759;
        Thu, 23 Dec 2021 22:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rCuzByWk/UBcQEl9w7lyfHY1O6NBiGqe+DaoOZw9lf4=; b=WZgFE/0ht2Dhs+huwb3RV6nCRV
        laDZzK2vPGT3eiF21vo7mCuWOptjzCOz8DCELmp75DNIykNhHazH3OOmiusTDqdb3X7byyd5foqeI
        yCT0F3ra2iDpIkBJBRlR6rxKwGxVeA4MbPc2sfcxpnPd/SMKskDnbmQWgoGa06t+aD/oWkuRukmlA
        0DL6RcrByaBwJKFjzdySB8brl5XnegdQsJe1LHcwNXrTZYEgm2Tc/yUflQwIgCUreNmkckTz+235C
        tJTtUErycBfpQdTCi7Jj3ZN1pu4XC40YVWgEgkYOR2p2IcjK5Gdg8ba7mrqkQtf3WtwE8SgQAqhfn
        78NKxupQ==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dyp-00Dn1I-RV; Fri, 24 Dec 2021 06:23:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 05/13] frontswap: remove frontswap_curr_pages
Date:   Fri, 24 Dec 2021 07:22:38 +0100
Message-Id: <20211224062246.1258487-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
References: <20211224062246.1258487-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

frontswap_curr_pages is never called, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/frontswap.h |  1 -
 mm/frontswap.c            | 28 ----------------------------
 2 files changed, 29 deletions(-)

diff --git a/include/linux/frontswap.h b/include/linux/frontswap.h
index d268d7bb65134..5205c2977b208 100644
--- a/include/linux/frontswap.h
+++ b/include/linux/frontswap.h
@@ -24,7 +24,6 @@ struct frontswap_ops {
 };
 
 extern void frontswap_register_ops(struct frontswap_ops *ops);
-extern unsigned long frontswap_curr_pages(void);
 
 extern bool __frontswap_test(struct swap_info_struct *, pgoff_t);
 extern void __frontswap_init(unsigned type, unsigned long *map);
diff --git a/mm/frontswap.c b/mm/frontswap.c
index a77ebba6101bd..af8f68d0e5cc0 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -330,34 +330,6 @@ void __frontswap_invalidate_area(unsigned type)
 }
 EXPORT_SYMBOL(__frontswap_invalidate_area);
 
-static unsigned long __frontswap_curr_pages(void)
-{
-	unsigned long totalpages = 0;
-	struct swap_info_struct *si = NULL;
-
-	assert_spin_locked(&swap_lock);
-	plist_for_each_entry(si, &swap_active_head, list)
-		totalpages += atomic_read(&si->frontswap_pages);
-	return totalpages;
-}
-
-/*
- * Count and return the number of frontswap pages across all
- * swap devices.  This is exported so that backend drivers can
- * determine current usage without reading debugfs.
- */
-unsigned long frontswap_curr_pages(void)
-{
-	unsigned long totalpages = 0;
-
-	spin_lock(&swap_lock);
-	totalpages = __frontswap_curr_pages();
-	spin_unlock(&swap_lock);
-
-	return totalpages;
-}
-EXPORT_SYMBOL(frontswap_curr_pages);
-
 static int __init init_frontswap(void)
 {
 #ifdef CONFIG_DEBUG_FS
-- 
2.30.2

