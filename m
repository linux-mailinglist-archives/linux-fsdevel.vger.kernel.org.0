Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B84C024A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiBVTsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiBVTsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C269B7179
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ktCHJjHhiesfnbZymFxuxmh+qsVGdl7mQw08EvtdkxM=; b=GY1QJ71PJqZe4REiMjDwq0gpun
        oQkLAJ3wjveAKSEBLF34x+BG1G63OZkF2Qgz1cHDFFf7HJFc32Hv/bKD6egqnjmC1Ei4uAqJ27ZIa
        PyWJpWK6QwAoBd4bZqZ2YYsFcBCL8nvmYVd7zg/oSX2BkVmd2C7D72fEyYLxbJLYL7IzNCOXM3Ihf
        2twqX5sUM03VfuXyxBQx7laLitUtODINalU7bc8eg3EFNVflrhGAsYSo5uLwS6GkcctSSOeS2ydhB
        1j8XwVLXYWQeucWq2sC7Nf/Ooc1wOWPHg/taPUqU4Y3p7dCY65vlZ+mMGV+tZRiBDVXaY+GGDWyeD
        INQHvXew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb95-0035zi-DM; Tue, 22 Feb 2022 19:48:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 04/22] filemap: Remove AOP_FLAG_CONT_EXPAND
Date:   Tue, 22 Feb 2022 19:48:02 +0000
Message-Id: <20220222194820.737755-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220222194820.737755-1-willy@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
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

This flag is no longer used, so remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c        | 3 +--
 include/linux/fs.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 28b9739b719b..c33e681fdeba 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2352,8 +2352,7 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
 	if (err)
 		goto out;
 
-	err = pagecache_write_begin(NULL, mapping, size, 0,
-				    AOP_FLAG_CONT_EXPAND, &page, &fsdata);
+	err = pagecache_write_begin(NULL, mapping, size, 0, 0, &page, &fsdata);
 	if (err)
 		goto out;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2843f789a6db..10ba90e22b4b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -274,7 +274,6 @@ enum positive_aop_returns {
 	AOP_TRUNCATED_PAGE	= 0x80001,
 };
 
-#define AOP_FLAG_CONT_EXPAND		0x0001 /* called from cont_expand */
 #define AOP_FLAG_NOFS			0x0002 /* used by filesystem to direct
 						* helper code (eg buffer layer)
 						* to clear GFP_FS from alloc */
-- 
2.34.1

