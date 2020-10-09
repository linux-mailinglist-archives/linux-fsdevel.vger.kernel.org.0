Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458EB288B68
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389080AbgJIOdH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388597AbgJIObJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:31:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C12C0613D5;
        Fri,  9 Oct 2020 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HQZhweg8a+1Qpo+qFNQoqVI2WIjKy37atq+XWcCiXOA=; b=geZDyx9zxwDAZMT1kXigMN/NeL
        y6/HNpoOVZM17yr4WSs7XuzAzLshwq8rV9NK+/vsXt6jsWTQxWhH+vHhc4/DVRZcalbVZPc8Yy/NL
        f52u9USjrpHt2Vdpc+Q0yu7uJPyz8uUxtZPaio2gMRZcZuowPskJmHiL6fAeHi6Ajcfh9e9cwrHSI
        TmB+0AFd9Z/t0TIdJXWLWd91z7Pp6JIf5hnIB/SWa+Yy6dCtUU2PL/k26ExALlqokhxxVICHxEv59
        UQBenExGSJ+MvxSnlfXVcMDO3ia2WBU5dNBvo9LboGyaLuY3yZn4ZfDYK8obdEN6KwtUtXt74EgUi
        H+Jfrfig==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQtQI-0005ub-VP; Fri, 09 Oct 2020 14:31:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-xfs@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 03/16] 9p: Tell the VFS that readpage was synchronous
Date:   Fri,  9 Oct 2020 15:30:51 +0100
Message-Id: <20201009143104.22673-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 9p readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/vfs_addr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index cce9ace651a2..506ca0ba2ec7 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -65,7 +65,7 @@ static int v9fs_fid_readpage(void *data, struct page *page)
 	SetPageUptodate(page);
 
 	v9fs_readpage_to_fscache(inode, page);
-	retval = 0;
+	return AOP_UPDATED_PAGE;
 
 done:
 	unlock_page(page);
@@ -280,6 +280,10 @@ static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
 		goto out;
 
 	retval = v9fs_fid_readpage(v9inode->writeback_fid, page);
+	if (retval == AOP_UPDATED_PAGE) {
+		retval = 0;
+		goto out;
+	}
 	put_page(page);
 	if (!retval)
 		goto start;
-- 
2.28.0

