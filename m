Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C341E7338
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391777AbgE2DAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407123AbgE2C6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58BFC08C5C8;
        Thu, 28 May 2020 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7jF/5Wz0vEdYXDOMS0hCwx2KuSkqA3em8Ujbgxg5dVM=; b=JEK3o1tBaHZA1LVR4il0FK0QMX
        XBI/RCuWKsN5MphLDovKuu71Wki7wASaUt5bPllOdaKwFCTK+oWbP0njGw6FbugyWIPDPyzSmbZKZ
        I7qpFaIsH1n2ANu3YF4ItmQ4+s9apZKlYEYknBmxo9KNaeREh9AOOdog877FH4kqUWgRzfYXztb/Q
        Je904OFPWLvxpMZg3XbF2wD+pd5tvTw2q3hQ3FX2Pz8sai50VqnbeT8PnKUrloDWBMmwobb8erTeY
        ki2ucoGEyLn/AfBJT6yu7cjO75v3ja8vPfL2Fez6UIXHog1KbirsafZRrh8/XXqonosFHozK71BMw
        F4YJxytg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008SW-HH; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 25/39] mm: Remove page fault assumption of compound page size
Date:   Thu, 28 May 2020 19:58:10 -0700
Message-Id: <20200529025824.32296-26-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

A compound page in the page cache will not necessarily be of PMD size,
so check explicitly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f703fe8c8346..d68ce428ddd2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3549,13 +3549,14 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	pmd_t entry;
 	int i;
-	vm_fault_t ret;
+	vm_fault_t ret = VM_FAULT_FALLBACK;
 
 	if (!transhuge_vma_suitable(vma, haddr))
-		return VM_FAULT_FALLBACK;
+		return ret;
 
-	ret = VM_FAULT_FALLBACK;
 	page = compound_head(page);
+	if (page_order(page) != HPAGE_PMD_ORDER)
+		return ret;
 
 	/*
 	 * Archs like ppc64 need additonal space to store information
-- 
2.26.2

