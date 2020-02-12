Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA8E159FFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgBLETe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:19:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rIiQdfF70UH/NrhNrIlb2hDhHJTI1cNopc0LJtiqgNw=; b=QgJ8JI65whKFKU40aTGC2KbUv3
        BOdg/4SyM3pmx8HK0RKR0bP0589Kia3x6ulK2ToRDjDsrVpakDyE40tBu88D3EmHYynUa5oa0x+vc
        P/Vjoatctq97kYIa2S2vMPDKfP4r2k/f0gNCt62+MxHeqanSZ8qOyxEvD2jNCUdjh46X0lt5y8esb
        S7OVD4wbUosgzfkOI/s3dIYt8CU6AWifyjf0xFKTHvPILoi7jnbFXffxzvggiwGWHV/hRquBL2D9O
        O0T4AU04ap+pZLPolLLlUVH51OTrxxe90oEQdd1CP0m62bmrSIRBjfQKMvVWSLqAbqIE3StRc5Ces
        IvgLH8Tw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU7-0006pL-Ic; Wed, 12 Feb 2020 04:18:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 25/25] mm: Align THP mappings for non-DAX
Date:   Tue, 11 Feb 2020 20:18:45 -0800
Message-Id: <20200212041845.25879-26-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
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
index b52e007f0856..b8d9e0d76062 100644
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
2.25.0

