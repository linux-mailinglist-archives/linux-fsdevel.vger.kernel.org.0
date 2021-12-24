Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D35147EC08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351509AbhLXGXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351502AbhLXGXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9CC061401;
        Thu, 23 Dec 2021 22:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ysp7KI34BFaTU9eSZuM6/aPIu5KK8PLOWYGZFEFmhdw=; b=unTB9+A0BFt91fd/IA+pU8NsCD
        uAxkcmTxIq/io8IlXw4hjtJIi3IoOhOYlcFg7IlLH7unDSePnwd/7I2xFxnUIl1zA1Ebgnz3DphTt
        puduvpbDyw88VXudWJmaShninMheAKwYLUchGptOssTzrlM3Ji7Cpk4oqNe18p0hA6EX0TQ98YJQl
        4pW5QNHmASSXanN4EQ5KRdXJ1xqaPWRt/p3cS6qFLgJpQ5rZn8lWHZ0aDpf+ZYqAgaBjThJzEqpVs
        c5zzYreXHZbBiz0yTQ2bzZjIA6iHbuTFMyWQGdB+EVMF/hKC8iZBcpqV75AqALycW1z1KsNSKuGrc
        4vDAWKqg==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dyh-00DmzR-KB; Fri, 24 Dec 2021 06:22:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 02/13] frontswap: remove frontswap_writethrough
Date:   Fri, 24 Dec 2021 07:22:35 +0100
Message-Id: <20211224062246.1258487-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
References: <20211224062246.1258487-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

frontswap_writethrough is never called, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/vm/frontswap.rst |  6 ------
 include/linux/frontswap.h      |  1 -
 mm/frontswap.c                 | 23 +----------------------
 3 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/Documentation/vm/frontswap.rst b/Documentation/vm/frontswap.rst
index e2e5ab3e375e3..2ab660651d04e 100644
--- a/Documentation/vm/frontswap.rst
+++ b/Documentation/vm/frontswap.rst
@@ -39,12 +39,6 @@ a disk write and, if the data is later read back, a disk read are avoided.
 If a store returns failure, transcendent memory has rejected the data, and the
 page can be written to swap as usual.
 
-If a backend chooses, frontswap can be configured as a "writethrough
-cache" by calling frontswap_writethrough().  In this mode, the reduction
-in swap device writes is lost (and also a non-trivial performance advantage)
-in order to allow the backend to arbitrarily "reclaim" space used to
-store frontswap pages to more completely manage its memory usage.
-
 Note that if a page is stored and the page already exists in transcendent memory
 (a "duplicate" store), either the store succeeds and the data is overwritten,
 or the store fails AND the page is invalidated.  This ensures stale data may
diff --git a/include/linux/frontswap.h b/include/linux/frontswap.h
index b07d88c92bb29..4a03fda415725 100644
--- a/include/linux/frontswap.h
+++ b/include/linux/frontswap.h
@@ -26,7 +26,6 @@ struct frontswap_ops {
 extern void frontswap_register_ops(struct frontswap_ops *ops);
 extern void frontswap_shrink(unsigned long);
 extern unsigned long frontswap_curr_pages(void);
-extern void frontswap_writethrough(bool);
 #define FRONTSWAP_HAS_EXCLUSIVE_GETS
 extern void frontswap_tmem_exclusive_gets(bool);
 
diff --git a/mm/frontswap.c b/mm/frontswap.c
index 6bed12260dea7..51a662a839559 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -32,16 +32,6 @@ static struct frontswap_ops *frontswap_ops __read_mostly;
 #define for_each_frontswap_ops(ops)		\
 	for ((ops) = frontswap_ops; (ops); (ops) = (ops)->next)
 
-/*
- * If enabled, frontswap_store will return failure even on success.  As
- * a result, the swap subsystem will always write the page to swap, in
- * effect converting frontswap into a writethrough cache.  In this mode,
- * there is no direct reduction in swap writes, but a frontswap backend
- * can unilaterally "reclaim" any pages in use with no data loss, thus
- * providing increases control over maximum memory usage due to frontswap.
- */
-static bool frontswap_writethrough_enabled __read_mostly;
-
 /*
  * If enabled, the underlying tmem implementation is capable of doing
  * exclusive gets, so frontswap_load, on a successful tmem_get must
@@ -170,15 +160,6 @@ void frontswap_register_ops(struct frontswap_ops *ops)
 }
 EXPORT_SYMBOL(frontswap_register_ops);
 
-/*
- * Enable/disable frontswap writethrough (see above).
- */
-void frontswap_writethrough(bool enable)
-{
-	frontswap_writethrough_enabled = enable;
-}
-EXPORT_SYMBOL(frontswap_writethrough);
-
 /*
  * Enable/disable frontswap exclusive gets (see above).
  */
@@ -283,9 +264,7 @@ int __frontswap_store(struct page *page)
 	} else {
 		inc_frontswap_failed_stores();
 	}
-	if (frontswap_writethrough_enabled)
-		/* report failure so swap also writes to swap device */
-		ret = -1;
+
 	return ret;
 }
 EXPORT_SYMBOL(__frontswap_store);
-- 
2.30.2

