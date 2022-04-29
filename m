Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A673751520D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379653AbiD2Raz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379636AbiD2R3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405F69E9D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FBVTiOMvlPZSoDA0qENoBLUC+UtSA69cBDDlOQEHp1w=; b=AdL4H8B4xUKKWBlVXQWuyZwVot
        PmZznv6kYzAdsyfD53728z9aBuMv+9iiheVt0JMi8Ynxqdc6dcFqgWOQPsWhkzVMdDpHZ4sXKCkCC
        7TH7JjV1IjQ9m50nfkK4TI6Aoc+212OCTIHgka1X3+6jKnt6MVi133ItR3txR85KoFpFYwwXhCnTF
        rGNz5eDCj3SULSCcZE5guwhV6r9T8CuWjZLos8FKzti8L2SvSC7y3ozI8D8b3OwKq8YnGG4BEUVaH
        8nWY+TTTJYxMq8xA930p4gQ5+a2lx/zKrtedvBzyWEa6lutZ1SsVAxRDZEqkOiEIqrQGqMS7Lif4l
        Hkc2s85g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNf-00Cddn-9G; Fri, 29 Apr 2022 17:26:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 67/69] vboxsf: Convert vboxsf to read_folio
Date:   Fri, 29 Apr 2022 18:25:54 +0100
Message-Id: <20220429172556.3011843-68-willy@infradead.org>
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
 fs/vboxsf/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index d74e0d336995..572aa1c43b37 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -225,8 +225,9 @@ const struct inode_operations vboxsf_reg_iops = {
 	.setattr = vboxsf_setattr
 };
 
-static int vboxsf_readpage(struct file *file, struct page *page)
+static int vboxsf_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct vboxsf_handle *sf_handle = file->private_data;
 	loff_t off = page_offset(page);
 	u32 nread = PAGE_SIZE;
@@ -352,7 +353,7 @@ static int vboxsf_write_end(struct file *file, struct address_space *mapping,
  * page and it does not call SetPageUptodate for partial writes.
  */
 const struct address_space_operations vboxsf_reg_aops = {
-	.readpage = vboxsf_readpage,
+	.read_folio = vboxsf_read_folio,
 	.writepage = vboxsf_writepage,
 	.dirty_folio = filemap_dirty_folio,
 	.write_begin = simple_write_begin,
-- 
2.34.1

