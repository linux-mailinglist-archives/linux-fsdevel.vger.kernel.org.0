Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99FDBD5CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 02:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403842AbfIYAwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 20:52:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391736AbfIYAwS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gfc79DzYRzAqx05Od1Rvplr/Hq8No1idlzxjKEIY6m4=; b=b1WCC3Fic73cDDRDtJp3WWeVnN
        97AuG5Jt9tVQDpbibgk2a9TQRVt2ouezcRrIJX2ZCAqd3ziWD/FjFZAXCQDiSxslqN0yHGMaaUxiv
        RWklDZNuzNQN9LRk8bpbSeuNDy/pLNKD4pULWXu8xQvbe6sN3YmVhKNhctDwiiAXezlrHBufNBXlG
        iC6BiWo3AWcYPKyjKz6x8Nh2d47BuZAr8/YyS2HSqrWUfSAzGMTgxxiTVDAqta7T7LDMXTWonX2CP
        fOKvyYwjlEStSmDVxuFiZdzjp1Pg5Hx9+21Gqnt/Omnnt7pn2AzYsMg8fniitqbf4N6F98oLX+Egb
        xW0lI/6w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCvXV-00077N-Va; Wed, 25 Sep 2019 00:52:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     William Kucharski <william.kucharski@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 14/15] mm: Align THP mappings for non-DAX
Date:   Tue, 24 Sep 2019 17:52:13 -0700
Message-Id: <20190925005214.27240-15-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925005214.27240-1-willy@infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
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
 mm/huge_memory.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cbe7d0619439..670a1780bd2f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -563,8 +563,6 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 
 	if (addr)
 		goto out;
-	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
-		goto out;
 
 	addr = __thp_get_unmapped_area(filp, len, off, flags, PMD_SIZE);
 	if (addr)
-- 
2.23.0

