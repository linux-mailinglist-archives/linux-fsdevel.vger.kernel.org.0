Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F83E48FCA9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 13:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiAPMSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 07:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiAPMSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:18:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171D7C061574;
        Sun, 16 Jan 2022 04:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mH8MdEUBlsPhf7ilWJH9nUxsrJCyVKcinjFNzwz2y+c=; b=HADWwBMt7yDSfmBsMV6lI8Kdp9
        gBuwraxP0C+hBTdLIjfFIK3OLLD/DrTdQ8u0qr2PVGguULrYpoZWChFHZKCPTRqeSOeEdo2ZHl78i
        ln6sfaOTz/vKTy4odQlD+D1Cv7jnk716fdVa/oVFspyPHrEZUNO3ZMBWUL1F/RF9wwVTg9BKnFAK6
        s/InMwuxOMbmtWo7c74ctnEu829l5uNC4HvoAabVtrd7xNbHTUoluLkZ/QfP5aG9fzOMABVwmMvwq
        I9JTaoUNHsQlLKBZzf15ab5vTu533gYiccgQMgqx35DA/D7xeRk8YGksLRKrjlaZqz80HyXf8kURD
        jOZLZwtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n94UM-007FUJ-FF; Sun, 16 Jan 2022 12:18:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 05/12] mm: Fix READ_ONLY_THP warning
Date:   Sun, 16 Jan 2022 12:18:15 +0000
Message-Id: <20220116121822.1727633-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220116121822.1727633-1-willy@infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These counters only exist if CONFIG_READ_ONLY_THP_FOR_FS is defined,
but we do not need to warn if the filesystem natively supports large
folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 270bf5136c34..877dabed0316 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -212,7 +212,7 @@ static inline void filemap_nr_thps_inc(struct address_space *mapping)
 	if (!mapping_large_folio_support(mapping))
 		atomic_inc(&mapping->nr_thps);
 #else
-	WARN_ON_ONCE(1);
+	WARN_ON_ONCE(mapping_large_folio_support(mapping) == 0);
 #endif
 }
 
@@ -222,7 +222,7 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
 	if (!mapping_large_folio_support(mapping))
 		atomic_dec(&mapping->nr_thps);
 #else
-	WARN_ON_ONCE(1);
+	WARN_ON_ONCE(mapping_large_folio_support(mapping) == 0);
 #endif
 }
 
-- 
2.34.1

