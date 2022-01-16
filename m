Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DE048FC9A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 13:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiAPMS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 07:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiAPMS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:18:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DAFC06173E;
        Sun, 16 Jan 2022 04:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=x22IDWNKLOZQBYNT5ZnUP/ws3USwr++SKpDySW8y9SA=; b=HyvtLeCzLmcJvJgRUexW0kzX6z
        +CRkAaXfZ/sTESZXnMn5cpVO7vkJEmjCnKIAk9RLbndO0OCnmumRMxPCQOkB1h+hACL+eHJGozBpV
        YR5aEcdeM3fb+OMfI6dAAXefLBP+ZijUN+2RDaQodeu2/GSvNBpUFyE/8wVkcRrCN3spFVOwfaE5H
        FhgDkdNCnn4Gn5WzHWwSWrKrPM9IeQIENcEda5qztngwQTt9WBudC3M9mKx+/ZxC50QDup2/c+SXQ
        IODSc9BcXn9j2IDVgDVnrKAQqCPWOnMAufdlvb149RlGDdTxN2yB9IlfjR+VSYfduJaiteCUzzcM/
        ZMKSG3cA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n94UM-007FUS-LE; Sun, 16 Jan 2022 12:18:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 07/12] mm: Make large folios depend on THP
Date:   Sun, 16 Jan 2022 12:18:17 +0000
Message-Id: <20220116121822.1727633-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220116121822.1727633-1-willy@infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some parts of the VM still depend on THP to handle large folios
correctly.  Until those are fixed, prevent creating large folios
if THP are disabled.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 877dabed0316..3e348e0a9e4e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -192,9 +192,14 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
 	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
 }
 
+/*
+ * Large folio support currently depends on THP.  These dependencies are
+ * being worked on but are not yet fixed.
+ */
 static inline bool mapping_large_folio_support(struct address_space *mapping)
 {
-	return test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
+		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
 }
 
 static inline int filemap_nr_thps(struct address_space *mapping)
-- 
2.34.1

