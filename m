Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EBB5364ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353164AbiE0Puv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348364AbiE0Puo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6A134E1E
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=l7LNbIHxxAJWnDwEjKP+/zdoMebmfgf3sLh/x6oLt/Q=; b=QBmsEGOts8OK8XgPyzg9AOG3DP
        9o97tFXEQG/9M5guQrlWtwgBC8L+MA/Vdu8S1BJFcUpdKKimazSkqbX5YU6nkUVMMGRICMxLjEOjQ
        PgwCHAZTmGUEdtK02zmUV6Vxn2gMC7vDb3vjmzQLHuuT4YpdhC7zOAnqQ6CWxVsXrhA0aMc/ehB9m
        jzHhCB1K4+hwuTNkHbZIUUZNjcYQ78fIklzdz0PExpg9JHpfz0sriucHGoaBEirbs3qykhf7BwkUR
        giLmsGgFkF8Ns66igJzjyqgSnRkn/+VUrumOeM8zDN5LuP2s9KBkfM92fDYiYaxyfebln4jC4dKzt
        a/0nYhOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEb-002CX9-F7; Fri, 27 May 2022 15:50:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 15/24] jfs: Remove check for PageUptodate
Date:   Fri, 27 May 2022 16:50:27 +0100
Message-Id: <20220527155036.524743-16-willy@infradead.org>
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

Pages returned from read_mapping_page() are always uptodate, so
this check is unnecessary.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 387652ae14c2..2e8461ce74de 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -618,7 +618,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 		SetPageUptodate(page);
 	} else {
 		page = read_mapping_page(mapping, page_index, NULL);
-		if (IS_ERR(page) || !PageUptodate(page)) {
+		if (IS_ERR(page)) {
 			jfs_err("read_mapping_page failed!");
 			return NULL;
 		}
-- 
2.34.1

