Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4460A4C025E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiBVTtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbiBVTs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794A4B715F
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=40D0X4sqJcdU6qLu7zP99T4EYSKCYPgqXyELEoZefms=; b=OK9rAt54b14uttWPxkqp2JPl3f
        pG7XyNw3rLEScj0JCoYP4KiZuYK1EZM64/2epPP8LuIbxAaZ3N/GXXAZKJ3Xx0mhn64YaYSe5w7fq
        F2pEH7P/M/Aco/iAXXMjesNQscX6mALmcBoaubUT2Y75r2/hyt8jSpVT2UmYg2o3GaI+kxLjaU8fR
        FL9DJlteorZUtQiFT8WiYsjO2P7+E2JQgIqoLqxkcgXw4+T9F6yyEkPx7gFDsSb5UWMdF6EfsMZlB
        GmKiPCwaqVan0sPLpKlSX3F9EAa03WwtQ+HvH2CX6xZEsitMyt8Vkh8O46gg6Nfcv2hTjcJiB3wl6
        6M3jePzA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb95-0035zd-9b; Tue, 22 Feb 2022 19:48:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Edward Shishkin <edward.shishkin@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 03/22] reiserfs: Stop using AOP_FLAG_CONT_EXPAND flag
Date:   Tue, 22 Feb 2022 19:48:01 +0000
Message-Id: <20220222194820.737755-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220222194820.737755-1-willy@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
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

From: Edward Shishkin <edward.shishkin@gmail.com>

We can simplify write_begin() and write_end() by handling the
cont_expand case in reiserfs_setattr().

Signed-off-by: Edward Shishkin <edward.shishkin@gmail.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/inode.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index e4221fa85ea2..36c59b25486c 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2763,13 +2763,6 @@ static int reiserfs_write_begin(struct file *file,
 	int old_ref = 0;
 
  	inode = mapping->host;
-	*fsdata = NULL;
- 	if (flags & AOP_FLAG_CONT_EXPAND &&
- 	    (pos & (inode->i_sb->s_blocksize - 1)) == 0) {
- 		pos ++;
-		*fsdata = (void *)(unsigned long)flags;
-	}
-
 	index = pos >> PAGE_SHIFT;
 	page = grab_cache_page_write_begin(mapping, index, flags);
 	if (!page)
@@ -2896,9 +2889,6 @@ static int reiserfs_write_end(struct file *file, struct address_space *mapping,
 	unsigned start;
 	bool locked = false;
 
-	if ((unsigned long)fsdata & AOP_FLAG_CONT_EXPAND)
-		pos ++;
-
 	reiserfs_wait_on_write_block(inode->i_sb);
 	if (reiserfs_transaction_running(inode->i_sb))
 		th = current->journal_info;
@@ -3316,7 +3306,11 @@ int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 		/* fill in hole pointers in the expanding truncate case. */
 		if (attr->ia_size > inode->i_size) {
-			error = generic_cont_expand_simple(inode, attr->ia_size);
+			loff_t pos = attr->ia_size;
+
+			if ((pos & (inode->i_sb->s_blocksize - 1)) == 0)
+				pos++;
+			error = generic_cont_expand_simple(inode, pos);
 			if (REISERFS_I(inode)->i_prealloc_count > 0) {
 				int err;
 				struct reiserfs_transaction_handle th;
-- 
2.34.1

