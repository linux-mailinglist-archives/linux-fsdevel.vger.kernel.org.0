Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EAC2FA6FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406669AbhARRCr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbhARRCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:02:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FE9C061575;
        Mon, 18 Jan 2021 09:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tpAumgWkpogmmuxrzm5R2ZvMmB2t3bvlyOOtc+rjXKI=; b=L401bso+MVuwSw2K1byR5GsuPn
        X/qA/RfHWxoWBUbGbjlUNrm2aTxa4otA2wWqP0BXW2y6ns/UF2nMKxoIQAAubCc48kaSYMFA2G8Ag
        fxUJOWsXaw1wls2DjllhYVwZ3dEi2QFb4vxOSVqZNAk3fU81HO0qJ/UNave4yTrR46ADrShITLvb4
        sBbAqRJGlx0Gf+txZ8DS6Oc4pby/tFFq1lsIIju7bth7sqMCYtSYhhvMF6rm4ErvuC35piC+qnmVO
        piRIgsYBebjlQ8pb5EZt7uZvYRMUp0ZtDpiBOZerVZUiqXV3/Fju7Jp+I3HS3jmWe3miUNSueGcWT
        osRWU+ow==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xub-00D7Hc-Fa; Mon, 18 Jan 2021 17:01:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/27] mm: Add folio_pgdat
Date:   Mon, 18 Jan 2021 17:01:23 +0000
Message-Id: <20210118170148.3126186-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is just a convenience wrapper for callers with folios; pgdat can
be reached from tail pages as well as head pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0858af6479a3..5b071c226fd6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1500,6 +1500,11 @@ static inline pg_data_t *page_pgdat(const struct page *page)
 	return NODE_DATA(page_to_nid(page));
 }
 
+static inline pg_data_t *folio_pgdat(const struct folio *folio)
+{
+	return page_pgdat(&folio->page);
+}
+
 #ifdef SECTION_IN_PAGE_FLAGS
 static inline void set_page_section(struct page *page, unsigned long section)
 {
-- 
2.29.2

