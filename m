Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DDB288B0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388869AbgJIObQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388846AbgJIObL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:31:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DA7C0613D5;
        Fri,  9 Oct 2020 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jmv1iA6ONHdhBCtewTigT8o0CWZcxoZXOX5KqmVgnTU=; b=XNzZbSwQBr1O0Cq9RqMvPhd6Th
        3/cZhq8AKMqNDl+YLfIMFJ16Mi8FFxIl13HW+TS4wCj+ArkMasaZPuF0/mGpLKUUXuYxafLrMqSHb
        GoxSJfWliAqjmPOnj3b0ZKft/67A6g9Fr10aR4luuXWMrQ2NR4t8PS/XdVIMXeE1ZS0NxTBE7GnuS
        4nljrczeHw39ur1ALlok+R9tqGltRa9YMBoWceemPmxeu73aaHuzxMnScDcSq5wwPvWPo6mBaRDyp
        AcmBkgLjznHCcnIMJfCL6gB8B1l7faHSRU3ubSlA+JJl2CHNImoG5KSRQJ7ZwGlHs3l9m11pvBhVq
        Bu8cManA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQtQK-0005vD-9J; Fri, 09 Oct 2020 14:31:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-xfs@vger.kernel.org
Subject: [PATCH v2 08/16] ecryptfs: Tell the VFS that readpage was synchronous
Date:   Fri,  9 Oct 2020 15:30:56 +0100
Message-Id: <20201009143104.22673-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
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

