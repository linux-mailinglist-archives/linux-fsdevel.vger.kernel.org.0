Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E884C342AFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 06:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhCTFme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 01:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhCTFmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:42:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52237C061762;
        Fri, 19 Mar 2021 22:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KpUjZvi6Y6AV1bv/yTlf7kQsi0VFFip0qDHS1+05VZk=; b=hT15opsHDRQS3S+27H7DSOEqdf
        uRBLjm5zM4JcfSAAJhNs9rvf5VwrXcmY8Ik4veP3kOkQSGxhfGifXit5FUbclu2N+EVWYENwrhlPW
        EQMMCxTewxxRlqwKts2pdEgMywzYPliJin+6cqNAm0kZ3aHy9ex9ajmFC5q9lKXqHrLeDt7qRwKin
        zU7t9fvVftKxX7CwVy8vRDTTtMZ/oVRQR7Hxb4W+hfgA1p4e0r75QbbqTjFWeKJH9o5D5RGCMuwlZ
        V1Jg4A7nu1lv0lp2oDsCRSe60LZx2i7Lr8FKjrDcnO0R5E7kYUzu8xdB6n9N878XnI6Xp4gB22nTQ
        k0fqnLsg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNUMs-005STP-BE; Sat, 20 Mar 2021 05:41:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v5 05/27] mm: Add folio_pgdat and folio_zone
Date:   Sat, 20 Mar 2021 05:40:42 +0000
Message-Id: <20210320054104.1300774-6-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are just convenience wrappers for callers with folios; pgdat and
zone can be reached from tail pages as well as head pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/mm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9b7e3fa12fd3..e176e9c9990f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1544,6 +1544,16 @@ static inline pg_data_t *page_pgdat(const struct page *page)
 	return NODE_DATA(page_to_nid(page));
 }
 
+static inline struct zone *folio_zone(const struct folio *folio)
+{
+	return page_zone(&folio->page);
+}
+
+static inline pg_data_t *folio_pgdat(const struct folio *folio)
+{
+	return page_pgdat(&folio->page);
+}
+
 #ifdef SECTION_IN_PAGE_FLAGS
 static inline void set_page_section(struct page *page, unsigned long section)
 {
-- 
2.30.2

