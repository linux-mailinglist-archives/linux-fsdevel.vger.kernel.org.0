Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99C45364F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353661AbiE0PvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352820AbiE0Pup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE5B134E3A
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=e0XmxPlauxAq5iJGHvK9f2GU7KuIll9jS6x2f9sMeng=; b=MDKaxVqoC1OyUk+eWBfs18A3xL
        /9ii/C2wDZ1MNkbvtp3MfXFVQZpxbNKOk/fXOHeD+5Wbz1MlcyROvN1eeiOXPVBsiV/0uYGWo7OvR
        zyn1d5CiojeJ2aoAVNY518jko8t5QPOhU5C1qucKwX4JnS8eTAnuJmxtGgJ8/X4GH1ZKhipDSufhy
        EfFsr4DSLISbxACgLYVXcuftx2npvYtJQrUdOu+zOxXFPUGqJe8w6pj2yo09bImNqp+8BcotBAhs4
        0Q7E9OZ6rtFeVveDja5DgkKJSzPN65wNbiNTIF6JfbKgUGvqFjNub1bm8mHtYJJSt2VXsRgDIdVap
        wLq/lkqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEc-002CXv-AF; Fri, 27 May 2022 15:50:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 23/24] hostfs: Handle page write errors correctly
Date:   Fri, 27 May 2022 16:50:35 +0100
Message-Id: <20220527155036.524743-24-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220527155036.524743-1-willy@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a page can't be written back, we need to call mapping_set_error(),
not clear the page's Uptodate flag.  Also remove the clearing of PageError
on success; that flag is used for read errors, not write errors.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hostfs/hostfs_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index cc1bc6f93a01..07881b76d42f 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -416,15 +416,15 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 
 	err = write_file(HOSTFS_I(inode)->fd, &base, buffer, count);
 	if (err != count) {
-		ClearPageUptodate(page);
+		if (err >= 0)
+			err = -EIO;
+		mapping_set_error(mapping, err);
 		goto out;
 	}
 
 	if (base > inode->i_size)
 		inode->i_size = base;
 
-	if (PageError(page))
-		ClearPageError(page);
 	err = 0;
 
  out:
-- 
2.34.1

