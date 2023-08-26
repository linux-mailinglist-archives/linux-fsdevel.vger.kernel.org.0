Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE780789316
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Aug 2023 03:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjHZBan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 21:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjHZBaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:30:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DE6E77
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 18:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=juCKysi6lkqsvER6lP7EQFXRqpGSO+Ma0Vhwz8af498=; b=mi0Xxe8ZOK3hlhEFuPnnfJG/he
        lT3l6j4jAr118ytn3gHkmOmEbcDC+XzN5N8kJTFB+6MP0baKgbvbNIhnbVi/NqF/9UbHmZHchpJbP
        Ct1FPgEI6vcVvXRCOvo6+pn8wDk75k9qt8j/K8pknStfl7oydmtMEvgHhnXHHyipyXp5R2afoS4Mi
        RQv3pD2Vdcbz3/IxA/qUR7EK+kElP2j8GSsp7Eb49Ncf1NYwoXt1x9rc9Mt4eq0faYNd8wvIG1QpZ
        Rwcgv6h+/porZlsAzJ6AP534kSJDxXK2cJi/c6pVOxJBeVRUBAut5rPLhzANTNeRTRU21QSisKPMz
        5Ua8wOFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZi81-002ovo-He; Sat, 26 Aug 2023 01:30:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fscache: Convert __fscache_clear_page_bits() to use a folio
Date:   Sat, 26 Aug 2023 02:30:08 +0100
Message-Id: <20230826013008.672321-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230825201225.348148-16-willy@infradead.org>
References: <20230825201225.348148-16-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Removes the last user of end_page_fscache() so remove that wrapper too.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fscache/io.c       | 6 +++---
 include/linux/netfs.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 0d2b8dec8f82..58a5d4569084 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -213,14 +213,14 @@ void __fscache_clear_page_bits(struct address_space *mapping,
 {
 	pgoff_t first = start / PAGE_SIZE;
 	pgoff_t last = (start + len - 1) / PAGE_SIZE;
-	struct page *page;
+	struct folio *folio;
 
 	if (len) {
 		XA_STATE(xas, &mapping->i_pages, first);
 
 		rcu_read_lock();
-		xas_for_each(&xas, page, last) {
-			end_page_fscache(page);
+		xas_for_each(&xas, folio, last) {
+			folio_end_fscache(folio);
 		}
 		rcu_read_unlock();
 	}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5e43e7010ff5..ed623eb78d21 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -89,11 +89,6 @@ static inline int folio_wait_fscache_killable(struct folio *folio)
 	return folio_wait_private_2_killable(folio);
 }
 
-static inline void end_page_fscache(struct page *page)
-{
-	folio_end_private_2(page_folio(page));
-}
-
 enum netfs_io_source {
 	NETFS_FILL_WITH_ZEROES,
 	NETFS_DOWNLOAD_FROM_SERVER,
-- 
2.40.1

