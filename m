Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E0D515205
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379663AbiD2Ran (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379587AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA5A5E8E
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Cha7rdYhynQkzfrMoZf+OEIc5RWuGXtJ7jbLzk85xcY=; b=vm111IiruDj4EXD/yuURb3sWkR
        ty6OQnONqeV/dWAQfj0yY2uxOKiHC8JakCVgMYsrS7WGvf5EqCmZRySwGVFYDhL/JiTHyl/r4P60W
        pEwCIPbCRv4j64YB8oTPIENDTFcU5BKA+6DoPyc6f02Vtq0buobz2IXvm9Hlud8QIjap6S7coZati
        Hd3ImXnrOaX4srSnic0StgEzM4RyhRWc1VtK2XkuOMwXH3lG1jOD9pqjqIRUQU7bWARJ5nx2JhUdB
        dT16iLxSH0X2NG4S5KXFJ78TuHow0GUfm9QHDex9UXPCO1mGT+IhueI5V2R826ltxc5hgXzeRZ1uY
        0p7xWPZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNc-00CdbT-2d; Fri, 29 Apr 2022 17:26:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 48/69] efs: Convert efs symlinks to read_folio
Date:   Fri, 29 Apr 2022 18:25:35 +0100
Message-Id: <20220429172556.3011843-49-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

