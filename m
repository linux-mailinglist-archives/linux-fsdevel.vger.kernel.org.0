Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17AF1E7343
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390334AbgE2DCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391660AbgE2C6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E96C008633;
        Thu, 28 May 2020 19:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dCuwc6lPrWLCWGlcIKBzmB9RkztZJkAJ0HO0XKrh/mk=; b=nqrLqlklg9zWWrebiQnuM/OYkv
        RccBmN311y6GSCPJeWIqyVsJ/c/JdGMsnNuMUhsesOUqWSvhdiKAEF4+1J9ZE3HloliuvNwrTuS/5
        IP9//JHm02AMD3/scahLwvwlWnDYI6v1GKWPRB7nFmS80halFRtjT/3EU9fCDSQoL3YvlfFd/Cm8v
        l0k9rhpmmoEkw77bK3BGQSPAfUQVsyL4gForquL+bUtPP/em7CBroOBtbSjrHGcSF4W6IUJwoFMRK
        U1afh1r6WCAmXnyZY1Uriu/SXK/4oD/2dnD+Tf35LY/Q5LvbQeWtctXDCSjAj0y59zuolC2vcLVEo
        AHtGsz7A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008Rk-9a; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 19/39] iomap: Handle tail pages in iomap_page_mkwrite
Date:   Thu, 28 May 2020 19:58:04 -0700
Message-Id: <20200529025824.32296-20-willy@infradead.org>
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

iomap_page_mkwrite() can be called with a tail page.  If we are,
operate on the head page, since we're treating the entire thing as a
single unit and the whole page is dirtied at the same time.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5b37844b7d97..78098b94fade 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1064,7 +1064,7 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
 
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 {
-	struct page *page = vmf->page;
+	struct page *page = compound_head(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	unsigned long length;
 	loff_t offset;
-- 
2.26.2

