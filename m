Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74905364EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240115AbiE0Pu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352173AbiE0Pup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B294F134E2C
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9lB4vg82X1aog+28GWsmbeVPWSeO4zm3Yw9Wz/19ZOE=; b=ag3i1XA7jzfjKuUZ8shp/7sg1h
        wLQ6vjDq9I+L9K7YxSACq06x6pSP2JXcl9ZdntwywcPK7HZFThj8mZLNwg06Y4b2OPyQUfV9P6pIB
        aKN/jkdId0/BHiqh05UlkNtdUiQYLN+OU7oSh7Qqy6jJCu4FEFWwOzC5gmmeoiPWclnweev/6LrTc
        CA64sccsLFtaWGq0C8Z32MBa322W4YmNIxDqNlBX0Hbx6f0RIArhxhHloKwxQiEJ+PUzzwCCmu3Y6
        HbDJ+PRTQPETKaD+YZ0WzgTgZC7pGpKoBHJPVkSeR+CL3ut6C/+ISoMMo2GAD2PyhZ8bVOUL712jO
        KOhxNxxw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEb-002CXX-U1; Fri, 27 May 2022 15:50:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 19/24] nfs: Leave pages in the pagecache if readpage failed
Date:   Fri, 27 May 2022 16:50:31 +0100
Message-Id: <20220527155036.524743-20-willy@infradead.org>
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

The pagecache handles readpage failing by itself; it doesn't want
filesystems to remove pages from under it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nfs/read.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 5a9b043662e9..8ae2c8d1219d 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -120,12 +120,8 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 	if (nfs_error_is_fatal_on_server(error) && error != -ETIMEDOUT)
 		SetPageError(page);
 	if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE)) {
-		struct address_space *mapping = page_file_mapping(page);
-
 		if (PageUptodate(page))
 			nfs_fscache_write_page(inode, page);
-		else if (!PageError(page) && !PagePrivate(page))
-			generic_error_remove_page(mapping, page);
 		unlock_page(page);
 	}
 	nfs_release_request(req);
-- 
2.34.1

