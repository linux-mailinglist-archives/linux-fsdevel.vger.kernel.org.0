Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873E25151F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379526AbiD2RaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379574AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A39A5E86
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TAxcWC6FMiXuwr7R63PsgyvedCcLMofVrsLaAeQ1AwY=; b=fy+nHMZsYK4lfImxWNWGQ/fpbz
        vzkUsx53jXY0hrjgClRZ1INfAnqp0t5HBPf7q9e/MFsChZOtmxjyKlrjRFDUqkH6MHROMkhApYWDY
        /I/xcYhlcqeeyDpa38O+1ZBt9hIx+B6Q9QeG0/oQMpqUx3pUQmPtuHo32xt9hr3NNXi2qjQeKjmkD
        TNjUpaGy9D7d5jH9t2BOR03bIN3S8Zgp5phPUT87UAuftdUoW074afJHXs+KMfVeX/CgiksCTNzki
        IjOAYtCykQKqafdp0srhZIT2vC5ARQhl3xQvi7FN4C27kCXLwyKQW+O0DJm0IzAUvyeAvfW7ykGCf
        FUdrLHqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNb-00Cdb0-M9; Fri, 29 Apr 2022 17:26:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 45/69] coda: Convert coda to read_folio
Date:   Fri, 29 Apr 2022 18:25:32 +0100
Message-Id: <20220429172556.3011843-46-willy@infradead.org>
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
 fs/coda/symlink.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/coda/symlink.c b/fs/coda/symlink.c
index 8907d0508198..8adf81042498 100644
--- a/fs/coda/symlink.c
+++ b/fs/coda/symlink.c
@@ -20,9 +20,10 @@
 #include "coda_psdev.h"
 #include "coda_linux.h"
 
-static int coda_symlink_filler(struct file *file, struct page *page)
+static int coda_symlink_filler(struct file *file, struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
+	struct page *page = &folio->page;
+	struct inode *inode = folio->mapping->host;
 	int error;
 	struct coda_inode_info *cii;
 	unsigned int len = PAGE_SIZE;
@@ -44,5 +45,5 @@ static int coda_symlink_filler(struct file *file, struct page *page)
 }
 
 const struct address_space_operations coda_symlink_aops = {
-	.readpage	= coda_symlink_filler,
+	.read_folio	= coda_symlink_filler,
 };
-- 
2.34.1

