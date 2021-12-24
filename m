Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FFC47EC0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351520AbhLXGXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351512AbhLXGXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29286C061757;
        Thu, 23 Dec 2021 22:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gHqv6kMDsq/2+y1n4ZZkTVYmU0VIRJiHvL8ybQks4bw=; b=eX99TK5vA8W9CJKecAaI2PFNuU
        GuyMw9RXR48sk3sYubW92CcupEDBWC1oj8RM+7vAyLz6NJXtvx20kbgNllyxKaBsgQ44+YDCitYBe
        BHIjWysMsh+dnDsLDhwFMjOfbpoO10huxP+bnNH60zrj9mJ/8s5bYtd6ETmP75wbrcEBb67EPmPsC
        0yxtgyWqhayzUdZ3VW8w6giyQKeny1FzsFaMK4JbOx/1H4SFCLY4uZK66IyYAAhpJj9Auwz7xJdca
        yWEo95XfCGSCasonwBQQT9EQlWSqSPp0NSGM3D0L5ubP0QPXDxZbl3gJJGJB900IVYhhDr8F0QB/x
        ecqKL6tQ==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dyk-00Dn0B-AW; Fri, 24 Dec 2021 06:22:58 +0000
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
Subject: [PATCH 03/13] frontswap: remove frontswap_tmem_exclusive_gets
Date:   Fri, 24 Dec 2021 07:22:36 +0100
Message-Id: <20211224062246.1258487-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
References: <20211224062246.1258487-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

frontswap_tmem_exclusive_gets is never called, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/frontswap.h |  2 --
 mm/frontswap.c            | 23 +----------------------
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/include/linux/frontswap.h b/include/linux/frontswap.h
index 4a03fda415725..83a56392cc7f6 100644
--- a/include/linux/frontswap.h
+++ b/include/linux/frontswap.h
@@ -26,8 +26,6 @@ struct frontswap_ops {
 extern void frontswap_register_ops(struct frontswap_ops *ops);
 extern void frontswap_shrink(unsigned long);
 extern unsigned long frontswap_curr_pages(void);
-#define FRONTSWAP_HAS_EXCLUSIVE_GETS
-extern void frontswap_tmem_exclusive_gets(bool);
 
 extern bool __frontswap_test(struct swap_info_struct *, pgoff_t);
 extern void __frontswap_init(unsigned type, unsigned long *map);
diff --git a/mm/frontswap.c b/mm/frontswap.c
index 51a662a839559..dba7f087ee862 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -32,13 +32,6 @@ static struct frontswap_ops *frontswap_ops __read_mostly;
 #define for_each_frontswap_ops(ops)		\
 	for ((ops) = frontswap_ops; (ops); (ops) = (ops)->next)
 
-/*
- * If enabled, the underlying tmem implementation is capable of doing
- * exclusive gets, so frontswap_load, on a successful tmem_get must
- * mark the page as no longer in frontswap AND mark it dirty.
- */
-static bool frontswap_tmem_exclusive_gets_enabled __read_mostly;
-
 #ifdef CONFIG_DEBUG_FS
 /*
  * Counters available via /sys/kernel/debug/frontswap (if debugfs is
@@ -160,15 +153,6 @@ void frontswap_register_ops(struct frontswap_ops *ops)
 }
 EXPORT_SYMBOL(frontswap_register_ops);
 
-/*
- * Enable/disable frontswap exclusive gets (see above).
- */
-void frontswap_tmem_exclusive_gets(bool enable)
-{
-	frontswap_tmem_exclusive_gets_enabled = enable;
-}
-EXPORT_SYMBOL(frontswap_tmem_exclusive_gets);
-
 /*
  * Called when a swap device is swapon'd.
  */
@@ -296,13 +280,8 @@ int __frontswap_load(struct page *page)
 		if (!ret) /* successful load */
 			break;
 	}
-	if (ret == 0) {
+	if (ret == 0)
 		inc_frontswap_loads();
-		if (frontswap_tmem_exclusive_gets_enabled) {
-			SetPageDirty(page);
-			__frontswap_clear(sis, offset);
-		}
-	}
 	return ret;
 }
 EXPORT_SYMBOL(__frontswap_load);
-- 
2.30.2

