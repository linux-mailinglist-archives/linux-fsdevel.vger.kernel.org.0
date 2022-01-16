Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E63648FCA1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 13:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiAPMSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 07:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiAPMSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:18:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E591AC061574;
        Sun, 16 Jan 2022 04:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hGAUTyP3YKMieg4ukwDdxrEbr7Dqansun9ibaWHflPg=; b=HW9oxCyfqc71KCw4UsiP8admKH
        P+HlyOF17U8jSApjuJR0uuYs6F64te/Sm7bn23eCPLD4E0dyvrzI1/gVG48RSV9hgjWZ/8BFo/Q+S
        K/Zx4vNotJpvWiUhzJHBXsrLqIIiX+RtBh/Ja38sU7XSvFzK494p7w0TGL3FDgtE7MaQVJX3AOwdN
        KoJN671KIfzeswq2GOqK36nU5MUnI3MT6WFzlGgkwAklV0biF/fc37AI9x4x9n/em2J0Ul2hdbIzO
        GhLB8gSBucCj3Na56/oRSbP69i2BE9N/pkYQ5Ctka8VZXi37usF5yIHBVF8sURG50/SunS3iRcKmu
        aN97bUDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n94UM-007FUh-SL; Sun, 16 Jan 2022 12:18:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     William Kucharski <william.kucharski@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 09/12] mm/readahead: Align file mappings for non-DAX
Date:   Sun, 16 Jan 2022 12:18:19 +0000
Message-Id: <20220116121822.1727633-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220116121822.1727633-1-willy@infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: William Kucharski <william.kucharski@oracle.com>

When we have the opportunity to use PMDs to map a file, we want to follow
the same rules as DAX.

Signed-off-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/huge_memory.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f58524394dc1..28c29a0d854b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -582,13 +582,10 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 	unsigned long ret;
 	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
 
-	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
-		goto out;
-
 	ret = __thp_get_unmapped_area(filp, addr, len, off, flags, PMD_SIZE);
 	if (ret)
 		return ret;
-out:
+
 	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
-- 
2.34.1

