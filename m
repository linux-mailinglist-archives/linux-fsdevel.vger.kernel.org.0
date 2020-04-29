Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EF51BDF2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgD2NlF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 09:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgD2NhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:37:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02285C035493;
        Wed, 29 Apr 2020 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7jF/5Wz0vEdYXDOMS0hCwx2KuSkqA3em8Ujbgxg5dVM=; b=dBK7yFj/JmjuhLlR+U0eT0TW3f
        wQu7LsAg/m1llsfBMqNeYklmfsFXV7MV98YxOwQOy2IxLOSNX1wcl0AIP0WsyjDLLdkzPul9a1I0R
        D7icGCmgTquHd9wcU38JFHKQF6mpO2oCOCQr79dvOiL9TAaQoNu+v7jVNUoyJxbSG1hQaU2LGm7cE
        EiHBnyV6mACvAKLNsXAHxFXUHwjGOgX7EMiq/KtYyHiKNZYJENx5cmoSk7PRyVI/1f61rsU7D4GXq
        QzZj5c5qiiGoqvCRJCtumWpBzkvMKfObBx5D8OZTc28WYguirycNKTdGgQ6xpi+bUkG0m0dkUopyH
        127uhj2g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmtX-0005wQ-RF; Wed, 29 Apr 2020 13:36:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/25] mm: Remove page fault assumption of compound page size
Date:   Wed, 29 Apr 2020 06:36:52 -0700
Message-Id: <20200429133657.22632-21-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
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

