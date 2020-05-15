Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DCF1D4EE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgEONSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgEONRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD9BC061A0C;
        Fri, 15 May 2020 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7jF/5Wz0vEdYXDOMS0hCwx2KuSkqA3em8Ujbgxg5dVM=; b=bThR5XdcGlFQIv9J5sxkcNpxLe
        3bVHB29orPrx+KmFcA/Ab8Ls5Trsf8Y1fG/Oug3dqYaKmpXnUi3RLY8q4THZGctwPj5rk/VYg1BNc
        ZbE9OKHL9jgbu+6GmTAVBhDy0SjKKxTrm9vEK8L0Dl3xYMd8ob8x0ZTXWIkFGEtecGDTbh0JXRqBL
        NNz3YIiJW8Kzm5bL+garMuDv5MSov9vdW9w/zAzdAWb23oRmQejaUzni2VOFkwtZKan+8QBAsyFjf
        T+TAH6E0gtEfk9LHFkQvOECH4MPoGGvVo32a93kRagAi3pufRGPbC9XVq2Hkw1YJokt7seva3rOU5
        TckdIrOg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaD0-0005jB-4C; Fri, 15 May 2020 13:17:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 24/36] mm: Remove page fault assumption of compound page size
Date:   Fri, 15 May 2020 06:16:44 -0700
Message-Id: <20200515131656.12890-25-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
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

