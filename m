Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8535A67D621
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjAZUYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjAZUYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE1227B3;
        Thu, 26 Jan 2023 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JxIQZn3422NDRY12n3JlUPEqNl1W1UN0M9UUk/21xXM=; b=T6Ay8mfAYuSc+NIdbPNt/22zLu
        GwR8VR1dDxaZtsSonYe/KSslkeADUfr7xnd1gcytQamWjAObCqCSPPCoX/EzWnuSEJrR+u5+eNbui
        R/trHdABnl2oBfjhIyV2c50fuVZnoPCdpvb0jJpngzOO3gkC9DghE5o/wPkQFXuTvkeBI6T49319x
        cNMuVf1Qibh1eOQ3N5IenEg93En0+gPdLgY/zdPMQ7r5fW2oNQ49tFx0U21DujCzKpKecM25KaFJN
        8LGGMzIcICQh9urodOyJW9lsTQVRIO3pzgEZs4KHciiHPLH7o7IQ+vIxJ++sFOZFWFjXr9WUnnlSB
        z/stQl9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nC-0073jO-Kn; Thu, 26 Jan 2023 20:24:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/31] fscrypt: Add some folio helper functions
Date:   Thu, 26 Jan 2023 20:23:46 +0000
Message-Id: <20230126202415.1682629-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
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

fscrypt_is_bounce_folio() is the equivalent of fscrypt_is_bounce_page()
and fscrypt_pagecache_folio() is the equivalent of fscrypt_pagecache_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fscrypt.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 4f5f8a651213..c2c07d36fb3a 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -273,6 +273,16 @@ static inline struct page *fscrypt_pagecache_page(struct page *bounce_page)
 	return (struct page *)page_private(bounce_page);
 }
 
+static inline bool fscrypt_is_bounce_folio(struct folio *folio)
+{
+	return folio->mapping == NULL;
+}
+
+static inline struct folio *fscrypt_pagecache_folio(struct folio *bounce_folio)
+{
+	return bounce_folio->private;
+}
+
 void fscrypt_free_bounce_page(struct page *bounce_page);
 
 /* policy.c */
@@ -448,6 +458,17 @@ static inline struct page *fscrypt_pagecache_page(struct page *bounce_page)
 	return ERR_PTR(-EINVAL);
 }
 
+static inline bool fscrypt_is_bounce_folio(struct folio *folio)
+{
+	return false;
+}
+
+static inline struct folio *fscrypt_pagecache_folio(struct folio *bounce_folio)
+{
+	WARN_ON_ONCE(1);
+	return ERR_PTR(-EINVAL);
+}
+
 static inline void fscrypt_free_bounce_page(struct page *bounce_page)
 {
 }
-- 
2.35.1

