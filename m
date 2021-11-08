Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349A144794A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhKHEYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhKHEYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:24:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA75C061570;
        Sun,  7 Nov 2021 20:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ha9NiX4FcPxrGO/mkLsbPFeCrnWT7y32pniOTYdVCGI=; b=ekP+no7uwAxU/8R4g7L9jpkcCv
        floV/sn0bcv6b/T9HTrGDgDYZ/Ts9EGKbMcDzCvFojZwcXrolTcU8K2/YD8sNrffKW2a9fn4HA3F7
        MNvTtfnp2A3T1lQ/BgGgbB1hrEJGiWtWcnmX6WH9nz3k9OZGKFNDguFvmbXIakulRuZhEpo0wuzQY
        2QazEL4jbAsLnMds2J7xB/ocE+joLQGoxz4LqcQlH9YjLKWdqU2R/0jPoE2JYUgVK2h9spNYoO98c
        aTG8HCYnTNpWV7PIm7lKy4d9SrlKjb4vYd/jO128ruIXwUBnzqAwUFRMNCNzXxjT238Pxfv7FzXK9
        2f3uwXHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjw3m-0089eb-MS; Mon, 08 Nov 2021 04:15:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 04/28] fs: Rename AS_THP_SUPPORT and mapping_thp_support
Date:   Mon,  8 Nov 2021 04:05:27 +0000
Message-Id: <20211108040551.1942823-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are now indicators of multi-page folio support, not THP support.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 471f0c422831..2ad10e1fd224 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -34,7 +34,7 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
-	AS_THP_SUPPORT = 6,	/* THPs supported */
+	AS_LARGE_FOLIO_SUPPORT = 6,
 };
 
 /**
@@ -139,12 +139,12 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  */
 static inline void mapping_set_large_folios(struct address_space *mapping)
 {
-	__set_bit(AS_THP_SUPPORT, &mapping->flags);
+	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
 }
 
-static inline bool mapping_thp_support(struct address_space *mapping)
+static inline bool mapping_large_folio_support(struct address_space *mapping)
 {
-	return test_bit(AS_THP_SUPPORT, &mapping->flags);
+	return test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
 }
 
 static inline int filemap_nr_thps(struct address_space *mapping)
@@ -159,7 +159,7 @@ static inline int filemap_nr_thps(struct address_space *mapping)
 static inline void filemap_nr_thps_inc(struct address_space *mapping)
 {
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
-	if (!mapping_thp_support(mapping))
+	if (!mapping_large_folio_support(mapping))
 		atomic_inc(&mapping->nr_thps);
 #else
 	WARN_ON_ONCE(1);
@@ -169,7 +169,7 @@ static inline void filemap_nr_thps_inc(struct address_space *mapping)
 static inline void filemap_nr_thps_dec(struct address_space *mapping)
 {
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
-	if (!mapping_thp_support(mapping))
+	if (!mapping_large_folio_support(mapping))
 		atomic_dec(&mapping->nr_thps);
 #else
 	WARN_ON_ONCE(1);
-- 
2.33.0

