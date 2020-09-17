Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4500C26E573
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 21:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgIQPOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 11:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgIQPL1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:11:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D00CC061351;
        Thu, 17 Sep 2020 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jmv1iA6ONHdhBCtewTigT8o0CWZcxoZXOX5KqmVgnTU=; b=UY+WWn03vEnSCFKL2cQHuVM2i1
        QWe+kigsY5nChj3dZW/h0aA6t4GCygWRYiPrbLnPJyTb6ae0uBq7cwL0EVmUXxakpgq2oapyhxDVe
        kBTCeumlVxnjVbvMWT8TED6H5Lcw3uow0f5XM1VjF7pOlh95YVKHtIN/5KguGYPRny3fc7WmToepE
        6Jv3+/5X4HTO12zMC+BPVGhiLP9iGEug/FLiAS+EZQ5RUi5fhnhqUz6TLDBMJmQh4+piAUkJgSqEP
        GBPJGhPkoKX4qDNExrVMjUWBmj38ZJGRM5eAJLVtOUR4LK3uM6CBTW568DQXcnfRhTgPg5qDs7lV7
        kS4OBj7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIvYj-0001Pz-KI; Thu, 17 Sep 2020 15:10:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 07/13] ecryptfs: Tell the VFS that readpage was synchronous
Date:   Thu, 17 Sep 2020 16:10:44 +0100
Message-Id: <20200917151050.5363-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917151050.5363-1-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ecryptfs readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/mmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 019572c6b39a..dee35181d789 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -219,12 +219,13 @@ static int ecryptfs_readpage(struct file *file, struct page *page)
 		}
 	}
 out:
-	if (rc)
-		ClearPageUptodate(page);
-	else
-		SetPageUptodate(page);
-	ecryptfs_printk(KERN_DEBUG, "Unlocking page with index = [0x%.16lx]\n",
+	ecryptfs_printk(KERN_DEBUG, "Returning page with index = [0x%.16lx]\n",
 			page->index);
+	if (!rc) {
+		SetPageUptodate(page);
+		return AOP_UPDATED_PAGE;
+	}
+	ClearPageUptodate(page);
 	unlock_page(page);
 	return rc;
 }
-- 
2.28.0

