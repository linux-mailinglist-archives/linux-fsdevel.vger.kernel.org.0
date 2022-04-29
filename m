Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E655151E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379648AbiD2R3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379516AbiD2R3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8EC9D060
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UFDZIRx1hkM0Ul5+W881mhRPV4GLz1eVueiPIgyeI6o=; b=Xc22LtdzGhIfVWHRgThCkjairv
        wiYyyaJytaCjqdlqXruQdmnswkg74Y8KFa9caEc5yBNMbCqbbvWOx9VzJZ9m/Eyl2fhpmZySvUBZ/
        eT8lYPIGqkqJ521kOsVpQQ4leCnligAqYcZh+axF6VSEbDyvaAPywkku+A2f21GnTIVZlyAMJ2gQO
        4GhNyEQR3sScdcILSgqsmLziHPx0/YxuE/Nb7I7UPZE0OAyM7FGEC0+1w1cXSFEgp2A5rnNJrQuWW
        MMkshUiZzZHNlgHcWYF0KbwpahVap/zR/uMZo+zmteBtVNwkg+vb1UfzLDclUcz5oYT7Xfjg9zvdi
        Mikct9RQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNY-00CdYV-Cu; Fri, 29 Apr 2022 17:26:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 18/69] namei: Call aops write_begin() and write_end() directly
Date:   Fri, 29 Apr 2022 18:25:05 +0100
Message-Id: <20220429172556.3011843-19-willy@infradead.org>
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

pagecache_write_begin() and pagecache_write_end() are now trivial
wrappers, so call the aops directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/namei.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 0c84b4326dc9..896ade8b7400 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5005,6 +5005,7 @@ EXPORT_SYMBOL(page_readlink);
 int page_symlink(struct inode *inode, const char *symname, int len)
 {
 	struct address_space *mapping = inode->i_mapping;
+	const struct address_space_operations *aops = mapping->a_ops;
 	bool nofs = !mapping_gfp_constraint(mapping, __GFP_FS);
 	struct page *page;
 	void *fsdata;
@@ -5014,8 +5015,7 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 retry:
 	if (nofs)
 		flags = memalloc_nofs_save();
-	err = pagecache_write_begin(NULL, mapping, 0, len-1,
-				0, &page, &fsdata);
+	err = aops->write_begin(NULL, mapping, 0, len-1, &page, &fsdata);
 	if (nofs)
 		memalloc_nofs_restore(flags);
 	if (err)
@@ -5023,7 +5023,7 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 
 	memcpy(page_address(page), symname, len-1);
 
-	err = pagecache_write_end(NULL, mapping, 0, len-1, len-1,
+	err = aops->write_end(NULL, mapping, 0, len-1, len-1,
 							page, fsdata);
 	if (err < 0)
 		goto fail;
-- 
2.34.1

