Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4247A0849
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240639AbjINPA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjINPA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:00:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDF41FC4;
        Thu, 14 Sep 2023 08:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mcrGwSkF+6OwQWImjSXOMYUqYp7VefHyx1rISBthABo=; b=Psp7ROkiRaKM3PQDd2UIvqXd2p
        QOyh9pFddfnxcyQECPyjYdSDes/iIGEdtTQG5+iCSdZwtFBjXWhWJxd54Zwg3dfwJ5ZwUlJ2jfiYm
        L8OkcW8AsmQOpaJe8FnEgnPYW9f+5ZAbnGstZp6fzNduQABWpUTKAlYunwluQ8a5JE7MZu0xcDrcg
        3ouTbfWSRfHHXOsNlFtW368bLPnuFL5iK8JrnnMjQGuaQUhPdVhdLw28KH1UWXoUm2KIqAz/VYGQv
        RUxNDeVhHzmzh6/UfactOUk5UQ1npWS++3J/e9vl1U73bsPC585IHsw9KU8FFB8pcKzbcXesxpM2S
        fToDBgZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgnpG-003XOU-90; Thu, 14 Sep 2023 15:00:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2 6/8] buffer: Convert sb_getblk() to call __getblk()
Date:   Thu, 14 Sep 2023 16:00:09 +0100
Message-Id: <20230914150011.843330-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230914150011.843330-1-willy@infradead.org>
References: <20230914150011.843330-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that __getblk() is in the right place in the file, it is
trivial to call it from sb_getblk().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/buffer_head.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index e92f604a423e..9ea4b6337251 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -359,13 +359,12 @@ static inline struct buffer_head *__getblk(struct block_device *bdev,
 	return bdev_getblk(bdev, block, size, gfp);
 }
 
-static inline struct buffer_head *
-sb_getblk(struct super_block *sb, sector_t block)
+static inline struct buffer_head *sb_getblk(struct super_block *sb,
+		sector_t block)
 {
-	return __getblk_gfp(sb->s_bdev, block, sb->s_blocksize, __GFP_MOVABLE);
+	return __getblk(sb->s_bdev, block, sb->s_blocksize);
 }
 
-
 static inline struct buffer_head *
 sb_getblk_gfp(struct super_block *sb, sector_t block, gfp_t gfp)
 {
-- 
2.40.1

