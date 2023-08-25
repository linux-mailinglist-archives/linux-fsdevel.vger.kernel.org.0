Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F60788F93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 22:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjHYUNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 16:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjHYUMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:12:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61E82689;
        Fri, 25 Aug 2023 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kJEWs/zTwR9XqadQ8p9jchKyiNdrOh/HBD/K05G0XYU=; b=rR8PC09HXzfsw2IrkuZaOFYzB/
        35OFFFzugy6N3tIZ4AoXm0pHfRwk7THSDXfr5m4IOLsOIpg0G/vLSRoIdVuxVJrVG5H4rxL6XHrYx
        +jmaR1WIsyjVgT146QoZPU3/ld/Ig9DiTbd1sU9M6Lh1hKUqlZSLLH+vVDROzI3/qSBmR1n1r2VBH
        FP/AJn4fwRNK5F4fR2BjBdJV4kM1Bdke5pggefqXPxjrVvWKuBQNMBp79hsUfCSsbw+y2M9Rw/NXB
        xwiVjKMijiZHJQQUO5I1Uubg6kmpSb4ICw0QCy9h8NBZKtbg24w5CcpcVZOMM/1aqN7HtjM41E60o
        7fjYb2yQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAW-001SaT-E8; Fri, 25 Aug 2023 20:12:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/15] ceph: Convert ceph_set_page_fscache() to ceph_folio_start_fscache()
Date:   Fri, 25 Aug 2023 21:12:24 +0100
Message-Id: <20230825201225.348148-15-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230825201225.348148-1-willy@infradead.org>
References: <20230825201225.348148-1-willy@infradead.org>
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

Both callers have the folio, so turn this wrapper into one for
folio_start_fscache().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 79d8f2fddd49..c2a81b67fc58 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -514,9 +514,9 @@ const struct netfs_request_ops ceph_netfs_ops = {
 };
 
 #ifdef CONFIG_CEPH_FSCACHE
-static void ceph_set_page_fscache(struct page *page)
+static void ceph_folio_start_fscache(struct folio *folio)
 {
-	set_page_fscache(page);
+	folio_start_fscache(folio);
 }
 
 static void ceph_fscache_write_terminated(void *priv, ssize_t error, bool was_async)
@@ -536,7 +536,7 @@ static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, b
 			       ceph_fscache_write_terminated, inode, caching);
 }
 #else
-static inline void ceph_set_page_fscache(struct page *page)
+static inline void ceph_folio_start_fscache(struct folio *folio)
 {
 }
 
@@ -727,7 +727,7 @@ static int writepage_nounlock(struct folio *folio, struct writeback_control *wbc
 
 	folio_start_writeback(folio);
 	if (caching)
-		ceph_set_page_fscache(&folio->page);
+		ceph_folio_start_fscache(folio);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	if (IS_ENCRYPTED(inode)) {
@@ -1242,7 +1242,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 			folio_start_writeback(folio);
 			if (caching)
-				ceph_set_page_fscache(pages[i]);
+				ceph_folio_start_fscache(folio);
 			len += folio_size(folio);
 		}
 		ceph_fscache_write_to_cache(inode, offset, len, caching);
-- 
2.40.1

