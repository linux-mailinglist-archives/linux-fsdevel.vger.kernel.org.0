Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D604AFE53
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiBIUXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D098E040DDF
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QDNy07HZIggGcuEgPDu9pwfo3nir8IeZXfZl5FLngKg=; b=UqaLtxWkDZquDOPunNz5guV3uL
        EWAc4pf/z1FI/e3cbczPxyttcdHsBPZY5ZpqtClyDswKg/ciL4vf7gTJZ3YCvIBe2kNtupEUwUTQF
        LDDd7pmqzV3X8l+OcLyRF0rZBLVN5uqP7/Nj4NEzTbny/O/TDo9eDMFGjFRXhfS/V3ZlX/t6wsTId
        SdX+bRYwHcZ1VQMYvB4SVNS0Syc2BNRHeyIspuCZhwdXidmeM/3oiL/Xi5mlS2asbSrbYruUp5Eml
        T2pg8rdw54s8McvLWf/xLWCO1vM9ZSwJpOoVCs1OvO3B9dEQBOewJu/XIBu1XwSxAGpHaB2A1YB7I
        tDNZBNAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTv-008csQ-Le; Wed, 09 Feb 2022 20:22:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 40/56] fs: Remove aops->launder_page
Date:   Wed,  9 Feb 2022 20:21:59 +0000
Message-Id: <20220209202215.2055748-41-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With all users converted to ->launder_folio, remove ->launder_page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0af3075cdff2..055be40084f1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -399,10 +399,7 @@ struct address_space_operations {
 			struct page *, struct page *, enum migrate_mode);
 	bool (*isolate_page)(struct page *, isolate_mode_t);
 	void (*putback_page)(struct page *);
-	union {
-		int (*launder_page) (struct page *);
-		int (*launder_folio) (struct folio *);
-	};
+	int (*launder_folio)(struct folio *);
 	bool (*is_partially_uptodate) (struct folio *, size_t from,
 			size_t count);
 	void (*is_dirty_writeback) (struct page *, bool *, bool *);
-- 
2.34.1

