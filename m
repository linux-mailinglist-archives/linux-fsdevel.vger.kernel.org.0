Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691D5342AF6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 06:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCTFmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 01:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhCTFls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:41:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7FDC061762;
        Fri, 19 Mar 2021 22:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=e0Ok76DtBipIYFoxH3AU3GubyGE5PN2GtFP1WyzCpvQ=; b=eBdfloupkaEMexbkEbuEfzKhcO
        oBrh+QMU204rwPxpc/L90BPmil9fpoueOSXBQfzUNN5dTA+b/Y9lOQfiskB7AdKHW31yr/d8666Aq
        FgeYcBuTwPTHkna6LoqHp5HlwvbY1v4XKRSf7bdH/+PrI//Rc4+uafjMx+qg4gOPjfH8lphCzGeo7
        5lvuX2paWAw33/NCM3Dgzi3yVxtkNRL+5u8mmd2AyW5JVW3rKPHQc4kuYEKYj1cLDzQCV5flrHD3y
        aeyTVSjb4ebohpTFYrpAFbJJ+5QXPFEJKagkZMrraOTcHwETCcQS4FzGvMxfOaRuP/VU2g97F9SWQ
        sCF/PDiA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNUMc-005SQR-F2; Sat, 20 Mar 2021 05:41:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v5 03/27] afs: Use wait_on_page_writeback_killable
Date:   Sat, 20 Mar 2021 05:40:40 +0000
Message-Id: <20210320054104.1300774-4-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Open-coding this function meant it missed out on the recent bugfix
for waiters being woken by a delayed wake event from a previous
instantiation of the page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/write.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index b2e03de09c24..106a864b6a93 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -850,8 +850,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 		return VM_FAULT_RETRY;
 #endif
 
-	if (PageWriteback(page) &&
-	    wait_on_page_bit_killable(page, PG_writeback) < 0)
+	if (wait_on_page_writeback_killable(page))
 		return VM_FAULT_RETRY;
 
 	if (lock_page_killable(page) < 0)
-- 
2.30.2

