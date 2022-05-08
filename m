Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262C551F16B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiEHUg2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiEHUfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B321121
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FBVTiOMvlPZSoDA0qENoBLUC+UtSA69cBDDlOQEHp1w=; b=WLnNG7DPpc33ER1d3PisVyx0BI
        5HAhVUiKOw2EIBtYyAV5r64DQHmVc3ytuqFqC8YtJTNNCkzjZcDKWEddhRnRekqIO4d0uOfS7wiPc
        wsmAmXpYvi3l9kNwkWPK8lxb4aMUYBL51Y7Ic9MwQBqp6yywVkgHRjz/PX7+DjfLuYWKyHFsiYPRO
        FEdr8N5fqmr89SYGXUAi6SK1FVN26wpEwvWel/6dbZDgcDTR6ymolhP/KpRVFjOqwpRHAv/Q8XCoi
        8qGeLS1J+NlrT0tygFc/74MQE5Lo5ng3yGmyoJYyXStUZOWV3c5c23lXOiShgOG1Vy1umjzZx0y7r
        3sl5Tt3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ7-002nqD-Db; Sun, 08 May 2022 20:31:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 35/37] vboxsf: Convert vboxsf to read_folio
Date:   Sun,  8 May 2022 21:31:29 +0100
Message-Id: <20220508203131.667959-36-willy@infradead.org>
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

