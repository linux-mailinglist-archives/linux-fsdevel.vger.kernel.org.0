Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174A074D6DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 15:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjGJNEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 09:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjGJNEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:04:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251F6E7F;
        Mon, 10 Jul 2023 06:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TvAG4zvqCXDWU2qbJkekP8mvYlTFnLqtA5p6bdq1nY4=; b=Qbg/E6Jnq1hfaF8D+6CqrhdQu1
        1RIAwvu2eUk7YdWV4MxA0aU3cwU6kZJuAP70mp9CpsrmeJEU5jv7ruOVJlUcprRZSjzK6GcYFgB/7
        d0RskUbIsv0CHUVZm8qMPVEnxIg9RDKGIwoGa4OInHr989/NA/FxfnMEpddMf5KhBKXbqKVILbIMy
        s9nScSoemYxB7MT6Z5FqUP3wVVJO8E+ZpYOl8yGyWzl41/vtneGJqViwJ94T3HZOovQMLwMAIk5Mb
        9RFKRJ+iKikfW9LVgx2IByFf/ps9ELkckPJ/wmNOphUP7VsFIZRCw/ePjjlPq/sRaWsF3Bo/mrMAT
        wtjySNqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIqXX-00EcXB-E8; Mon, 10 Jul 2023 13:02:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v4 2/9] iov_iter: Add copy_folio_from_iter_atomic()
Date:   Mon, 10 Jul 2023 14:02:46 +0100
Message-Id: <20230710130253.3484695-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710130253.3484695-1-willy@infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a folio wrapper around copy_page_from_iter_atomic().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/uio.h | 9 ++++++++-
 lib/iov_iter.c      | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index ff81e5ccaef2..42bce38a8e87 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -163,7 +163,7 @@ static inline size_t iov_length(const struct iovec *iov, unsigned long nr_segs)
 	return ret;
 }
 
-size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
+size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 				  size_t bytes, struct iov_iter *i);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
@@ -184,6 +184,13 @@ static inline size_t copy_folio_to_iter(struct folio *folio, size_t offset,
 {
 	return copy_page_to_iter(&folio->page, offset, bytes, i);
 }
+
+static inline size_t copy_folio_from_iter_atomic(struct folio *folio,
+		size_t offset, size_t bytes, struct iov_iter *i)
+{
+	return copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
+}
+
 size_t copy_page_to_iter_nofault(struct page *page, unsigned offset,
 				 size_t bytes, struct iov_iter *i);
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c728b6e4fb18..8da566a549ad 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -566,7 +566,7 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_zero);
 
-size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
+size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		size_t bytes, struct iov_iter *i)
 {
 	size_t n, copied = 0;
-- 
2.39.2

