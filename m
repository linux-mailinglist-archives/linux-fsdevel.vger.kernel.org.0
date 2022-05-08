Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C47651F131
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiEHUeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiEHUdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C9EE03D
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+GqAlDlRWXj80Ax3vG0u9Q+JlowyMcWhOuk9+WoV2qY=; b=ExfUcLbWh516vqSIPlQ3X4wNsY
        WXU0GCayPAle9szhx0/Sd4ajf1k3oARdJCtoO4RvUI8HZfWat56ie6OhD+eUOJEkAfG6mDXfiLjNd
        N6WU27NWGTIWBUmdhPRmhM8Cjc08CjzcZnJDp5qO+k6kYyLVDTszM3QfhQD7eH56hqciLSHipSnfm
        UChUESrIL8g1Gnn4EUjOpFAxcxzHMKO+U/DE9EsDJj8Sk9jkWF98Vpw0LRcV0mkeAq2qzfQqtlTnP
        GcjvbbUCWA668BMgaWdWmxP7qEIAA+yYHgRYsuPkknwfCnEn+GoXJER1WyQY1L+tr7tafJFdc+XI/
        IkwN01BQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXT-002nZL-Ji; Sun, 08 May 2022 20:29:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 17/25] namei: Call aops write_begin() and write_end() directly
Date:   Sun,  8 May 2022 21:29:33 +0100
Message-Id: <20220508202941.667024-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508202941.667024-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202941.667024-1-willy@infradead.org>
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

pagecache_write_begin() and pagecache_write_end() are now trivial
wrappers, so call the aops directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

