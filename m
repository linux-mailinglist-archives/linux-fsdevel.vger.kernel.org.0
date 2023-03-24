Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31CB6C8473
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjCXSEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjCXSC3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D291C32E;
        Fri, 24 Mar 2023 11:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8fvAIpVHPNF+3bUB5cbw/cVz3lzrHE7MjwOU7M8nQTQ=; b=ilpxX33sEUXweM5cHL8rn69SEK
        ongJBeZVKdt8PEnDLnQ3+Zd2MJWbmFuF4LMifsKuxQpbK8dCdobo6Eo+teflrPhJK0I93K92P53pX
        b+yU+Pglrh02ZtINkJSxieOl2FCvz0zx2rwPMlGaNdhj9ta80usEFhjwE3WsuXMYL+h6VuTPEmkvz
        azDE+IsjlC0Mo91DgTY3S20wjbygU9J5Httke1HKjgxWNojoKmM9XRa+MjwQYTwzGVEpUknno4B3p
        aWJQ0OCP37R9fVW5TwCFBbgKP81lEMUDo+9kDhsKaX53Yi2l8EiFU9xqXPp1ljWOJ/WiP+JjST2Hl
        jy4KMrDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljK-0057Yr-V8; Fri, 24 Mar 2023 18:01:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 02/29] fscrypt: Add some folio helper functions
Date:   Fri, 24 Mar 2023 18:01:02 +0000
Message-Id: <20230324180129.1220691-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fscrypt_is_bounce_folio() is the equivalent of fscrypt_is_bounce_page()
and fscrypt_pagecache_folio() is the equivalent of fscrypt_pagecache_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 include/linux/fscrypt.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index a69f1302051d..c895b12737a1 100644
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
@@ -446,6 +456,17 @@ static inline struct page *fscrypt_pagecache_page(struct page *bounce_page)
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
2.39.2

