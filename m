Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611FA29093B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410575AbgJPQE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410562AbgJPQEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4E7C061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=U62SUaGW7wvOzK2xtP2u7DsjwRF7PHeB8dtYgkbpx0Q=; b=CdVGkVMaoXabyV+hrVSqK0odLg
        tgot/W/wg6U/L9Bx0gdVcEX7lrcOHYN3Frq5MaulMpsGEaXsKPKLzveb65eQmIPo5V39m0CIeX7fj
        s1KIYMFkLJ7/yAlbPDcQ/TSRJEbMfs6sIuIwL4r8BemNcj6mk1DWLKkiMyn0ph6M6uDQsz7HCFPxC
        BnckCaWY79K4nud1xekf6IU6CP2/DpYTUR9B+cKhsQ5Y7pAMlK7E9OMEOV/fEDlgk9F0EE7dOhEA2
        CApuNcKRL6y9+MNUF+7xe5EU8gQ7VCHJREN5Fp4Bphfd5A0rmXo31I8cPFG7NAjbSoHO8k0A3p6b8
        eOvHL48Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDn-0004t1-8n; Fri, 16 Oct 2020 16:04:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v3 09/18] cramfs: Tell the VFS that readpage was synchronous
Date:   Fri, 16 Oct 2020 17:04:34 +0100
Message-Id: <20201016160443.18685-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The cramfs readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cramfs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 912308600d39..7a642146c074 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -916,15 +916,14 @@ static int cramfs_readpage(struct file *file, struct page *page)
 	flush_dcache_page(page);
 	kunmap(page);
 	SetPageUptodate(page);
-	unlock_page(page);
-	return 0;
+	return AOP_UPDATED_PAGE;
 
 err:
 	kunmap(page);
 	ClearPageUptodate(page);
 	SetPageError(page);
 	unlock_page(page);
-	return 0;
+	return -EIO;
 }
 
 static const struct address_space_operations cramfs_aops = {
-- 
2.28.0

