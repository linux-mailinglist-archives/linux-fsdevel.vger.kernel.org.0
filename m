Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660DF47EC11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351621AbhLXGX1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351567AbhLXGXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4AFC061401;
        Thu, 23 Dec 2021 22:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=62WUftiSKPEas+09QsqZJlxT06BKfMl0aPTnSdTbkJw=; b=V6O7xnHJ8SVgtI++0GA9mp0z4f
        esM6/BRnMuh2XdjFcdSxEcwJolemtHj1CYxTrwmgT7kJSYA740PvcCnvN+4LCEFrug+37+L+IAWJQ
        fRmLqr2QY6B8NHcUKq/zendwXlj3sp3dHUsZ6F18rjUN95JeuKYiPN07Au/fhqJVqHd2AY/th935i
        5OA9tmZmsnHMWcCfvkskOlEa9Z929g+UddD3PPXtu/7f0z/hgzSNFORmQhR7Q5WozfoFq4eLrukhy
        kZkmn1LzSpeTwdrbUOiuIgJkrpev/ry0O69D3GOW0OSm0kqWcswbNskw8BxElgTtA0A7BEr1gx3Tt
        kq1mylxQ==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dyv-00Dn4H-ME; Fri, 24 Dec 2021 06:23:10 +0000
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
Subject: [PATCH 07/13] frontswap: remove the frontswap exports
Date:   Fri, 24 Dec 2021 07:22:40 +0100
Message-Id: <20211224062246.1258487-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
References: <20211224062246.1258487-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

None of the frontswap API is called from modular code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/frontswap.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/frontswap.c b/mm/frontswap.c
index 132d6ad6d70b7..42d554da53bbb 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -151,7 +151,6 @@ void frontswap_register_ops(struct frontswap_ops *ops)
 		}
 	}
 }
-EXPORT_SYMBOL(frontswap_register_ops);
 
 /*
  * Called when a swap device is swapon'd.
@@ -187,7 +186,6 @@ bool __frontswap_test(struct swap_info_struct *sis,
 		return test_bit(offset, sis->frontswap_map);
 	return false;
 }
-EXPORT_SYMBOL(__frontswap_test);
 
 static inline void __frontswap_set(struct swap_info_struct *sis,
 				   pgoff_t offset)
@@ -250,7 +248,6 @@ int __frontswap_store(struct page *page)
 
 	return ret;
 }
-EXPORT_SYMBOL(__frontswap_store);
 
 /*
  * "Get" data from frontswap associated with swaptype and offset that were
@@ -283,7 +280,6 @@ int __frontswap_load(struct page *page)
 		inc_frontswap_loads();
 	return ret;
 }
-EXPORT_SYMBOL(__frontswap_load);
 
 /*
  * Invalidate any data from frontswap associated with the specified swaptype
@@ -305,7 +301,6 @@ void __frontswap_invalidate_page(unsigned type, pgoff_t offset)
 	__frontswap_clear(sis, offset);
 	inc_frontswap_invalidates();
 }
-EXPORT_SYMBOL(__frontswap_invalidate_page);
 
 /*
  * Invalidate all data from frontswap associated with all offsets for the
@@ -327,7 +322,6 @@ void __frontswap_invalidate_area(unsigned type)
 	atomic_set(&sis->frontswap_pages, 0);
 	bitmap_zero(sis->frontswap_map, sis->max);
 }
-EXPORT_SYMBOL(__frontswap_invalidate_area);
 
 static int __init init_frontswap(void)
 {
-- 
2.30.2

