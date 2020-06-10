Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A211C1F5C99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgFJUOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730599AbgFJUNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240AC0085C8;
        Wed, 10 Jun 2020 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Syv05ntpXp5OHYqqfiVzAsVsVw2vQPR8ml3h23JrCRo=; b=k38Y8vKbdkeU0De3i2bolBbeNS
        SSCL2Q6QOBrIPOIJD3gJVAC1Xhfp5AlLeatX62Mp4ZTvK3R3F/kg/IZJGEXy5aPbOeq6qIBuVyFtN
        eyVFm0PEI/I6PglMho1hMAsthcYPja6a+C17ZkEompoDPvse2TEvyBRMt0ZV1oellCcxXGsM0xjwD
        tEn/46jEJQxhV9Xla/3bnL65pnz17bIyRgwGG7+s0GnrsODzEiUSZtsW9XwNRtSF4IK7cTpMAAvuG
        Piu1/kELPZEPiwa3JpdGmZhv1iItnVAh2yu+/CvEFmUSzFtvP9pMFR97ViA07JPXTwbDunyDeUxtH
        UgiVNH1Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76b-0003YY-CU; Wed, 10 Jun 2020 20:13:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v6 51/51] mm: Align THP mappings for non-DAX
Date:   Wed, 10 Jun 2020 13:13:45 -0700
Message-Id: <20200610201345.13273-52-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: William Kucharski <william.kucharski@oracle.com>

When we have the opportunity to use transparent huge pages to map a
file, we want to follow the same rules as DAX.

Signed-off-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/huge_memory.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c25d8e2310e8..0fb08e4eeb8e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -577,13 +577,10 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
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
2.26.2

