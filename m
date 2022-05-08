Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FBF51F15C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiEHUf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiEHUfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A485B21BD
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Cha7rdYhynQkzfrMoZf+OEIc5RWuGXtJ7jbLzk85xcY=; b=F6HteLccKYZnZVR1CeDeU5LEnv
        yIQwdQOmix/iM3R/25ewgXRM5ibfPKw/sffaulF+ILOwFJC0XyV1BHcrMcPRFjYlk8NO6ZQ0d3Jqw
        /YIxzQi+WTPEh5kkAne3EqM1cTl85p0RgTurV/Bhh8GCFk5ypAKfzpC4vTLrwKleyEzk/lXEhaYNa
        fC3+QRIbUq5gbn3ofURcYl36Bi6ps03WrFiYed0g/UPHUryfJLSVUYLdv6rcvmhe//LBp7t35zqXT
        egN46oPHQOIaHkVelNGNg5uer2eonUlBxTFjtY5VaTkYqdRaBRy/rZD7PopwYpOuNbKs/sslkuUkd
        2fifsfKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ4-002noF-UF; Sun, 08 May 2022 20:31:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 16/37] efs: Convert efs symlinks to read_folio
Date:   Sun,  8 May 2022 21:31:10 +0100
Message-Id: <20220508203131.667959-17-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
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

This is a "weak" conversion which converts straight back to using pages.
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/efs/symlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/efs/symlink.c b/fs/efs/symlink.c
index 923eb91654d5..3b03a573cb1a 100644
--- a/fs/efs/symlink.c
+++ b/fs/efs/symlink.c
@@ -12,8 +12,9 @@
 #include <linux/buffer_head.h>
 #include "efs.h"
 
-static int efs_symlink_readpage(struct file *file, struct page *page)
+static int efs_symlink_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	char *link = page_address(page);
 	struct buffer_head * bh;
 	struct inode * inode = page->mapping->host;
@@ -49,5 +50,5 @@ static int efs_symlink_readpage(struct file *file, struct page *page)
 }
 
 const struct address_space_operations efs_symlink_aops = {
-	.readpage	= efs_symlink_readpage
+	.read_folio	= efs_symlink_read_folio
 };
-- 
2.34.1

