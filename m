Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59A7A9FE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjIUU2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjIUU2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:28:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580BD3BE19;
        Thu, 21 Sep 2023 13:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MrSoluGCY0RkfJ7LMGD8f0s00qedWA5ibN1YzRdIqeI=; b=thOt56isfl93if/g9mytqyCLeG
        Ks9Q8qpnuGmXXpOYg7aIodR53wVzOrYnra38jO6RgPpUodwuqCD6a+YUfKvwauMqkSQMsZQYhR18R
        8GCH/scc39BK4hOrPryEg+F37SdIEfGfjMF7uRKwzFbsV+KhWONI1nQXVqzF4QOxzPKIotN7iCrqJ
        BxMPwV1r3qa6U13aco8KyRsYA7eQDR1dh9S7ro21hiIV+mo8rAyZJCAhrqri4bRZowxJ/Xvtph4K2
        B1nQcGz55t2358gHKXqg91qoeu87BLmhR9fTAOBWeEpyTpU545R/udqWm1L2EClCBLIBQUEeZ0US+
        WO1K7nNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjPxj-00DrVg-KT; Thu, 21 Sep 2023 20:07:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jan Kara <jack@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 01/10] highmem: Add folio_release_kmap()
Date:   Thu, 21 Sep 2023 21:07:38 +0100
Message-Id: <20230921200746.3303942-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of unmap_and_put_page(), which remains as
a wrapper for it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 99c474de800d..4cacc0e43b51 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -551,10 +551,24 @@ static inline void folio_zero_range(struct folio *folio,
 	zero_user_segments(&folio->page, start, start + length, 0, 0);
 }
 
-static inline void unmap_and_put_page(struct page *page, void *addr)
+/**
+ * folio_release_kmap - Unmap a folio and drop a refcount.
+ * @folio: The folio to release.
+ * @addr: The address previously returned by a call to kmap_local_folio().
+ *
+ * It is common, eg in directory handling to kmap a folio.  This function
+ * unmaps the folio and drops the refcount that was being held to keep the
+ * folio alive while we accessed it.
+ */
+static inline void folio_release_kmap(struct folio *folio, void *addr)
 {
 	kunmap_local(addr);
-	put_page(page);
+	folio_put(folio);
+}
+
+static inline void unmap_and_put_page(struct page *page, void *addr)
+{
+	folio_release_kmap(page_folio(page), addr);
 }
 
 #endif /* _LINUX_HIGHMEM_H */
-- 
2.40.1

