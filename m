Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260C8BD5E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 02:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392556AbfIYAwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 20:52:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391738AbfIYAwS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5PLjU7Lobfecd7nUe18LQeptBQVP1uzg6vaKwytBhAY=; b=bQLt4tYKFfbdCslX+iJsC68nvC
        hqFYBs6pZfNJEIfkUqkUd9cB+0IO+KHSyaEWSPs+DOCDiI31/qEtQ5QH4N+XYvdujhobGoR8jPrjS
        rIVmX0rCcroUfXV2BYhTnf2hjOe0IHpAozn56Pl4dVXUeOpNrbYYawdiSHTC0SPLTPrHXfvmbmt/g
        p+/rUPCwPwGncy+1fYolF97BZqaSEViNQQtj+qSPuOGzERdSnkC0ThVBCCYv3sFPsWP13SaMU/AXO
        2wpKx035Y45cSpEy0ijiT5k4yOI4uesHAxZZE0kejzkFTFKmrF3tLLauy9RtJ7GzgRaVV1eyHAA5U
        KNopRiXA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCvXW-00077V-1g; Wed, 25 Sep 2019 00:52:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 15/15] xfs: Use filemap_huge_fault
Date:   Tue, 24 Sep 2019 17:52:14 -0700
Message-Id: <20190925005214.27240-16-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925005214.27240-1-willy@infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/xfs_file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index d952d5962e93..9445196f8056 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1156,6 +1156,8 @@ __xfs_filemap_fault(
 	} else {
 		if (write_fault)
 			ret = iomap_page_mkwrite(vmf, &xfs_iomap_ops);
+		else if (pe_size)
+			ret = filemap_huge_fault(vmf, pe_size);
 		else
 			ret = filemap_fault(vmf);
 	}
@@ -1181,9 +1183,6 @@ xfs_filemap_huge_fault(
 	struct vm_fault		*vmf,
 	enum page_entry_size	pe_size)
 {
-	if (!IS_DAX(file_inode(vmf->vma->vm_file)))
-		return VM_FAULT_FALLBACK;
-
 	/* DAX can shortcut the normal fault path on write faults! */
 	return __xfs_filemap_fault(vmf, pe_size,
 			(vmf->flags & FAULT_FLAG_WRITE));
-- 
2.23.0

