Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8284E4C0257
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbiBVTtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiBVTs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A74BA777
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mEAQaN/BfNQFuF0nkqpkOfHbbB5iQ8PG4eZC+KGarwg=; b=PBKGTA1i0n0AexHJIphXi+CE+X
        YKjfRGwt9v7r7sbspxC9bFxFK+9ITcizydd/pefqAYBbgvI4FCWpANRP5A/GhXDJvYd7TKNmYRKR5
        Ex5W9EzznDH2KytdXO3DzJ9pgwXmeL+5Xx1yUlRu7xRhqXAP9koTLOToxiXMev4O2baR3TgXI0V5Q
        g2l5Fj9feJOUa5huJJTeoXClqYsNY4Omw0amFnl6s929O0Qb1H9Ud0y/BO1T7fahg27ubQH4iQ0pN
        qMh4JqkbKsUDCtB8YWFv4LMLExjluVMmD3ojQWk5O2yWLYuYBZGKwMay0d/JvNRb7Htb4qZaLka8B
        UCQ99PSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb97-00360y-BH; Tue, 22 Feb 2022 19:48:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 20/22] f2fs: Use pagecache_write_begin() & pagecache_write_end()
Date:   Tue, 22 Feb 2022 19:48:18 +0000
Message-Id: <20220222194820.737755-21-willy@infradead.org>
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

Use the convenience wrappers instead of invoking ->write_begin and
->write_end directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index baefd398ec1a..fe4adf761f81 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2487,7 +2487,6 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 {
 	struct inode *inode = sb_dqopt(sb)->files[type];
 	struct address_space *mapping = inode->i_mapping;
-	const struct address_space_operations *a_ops = mapping->a_ops;
 	int offset = off & (sb->s_blocksize - 1);
 	size_t towrite = len;
 	struct page *page;
@@ -2500,7 +2499,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 		tocopy = min_t(unsigned long, sb->s_blocksize - offset,
 								towrite);
 retry:
-		err = a_ops->write_begin(NULL, mapping, off, tocopy, 0,
+		err = pagecache_write_begin(NULL, mapping, off, tocopy,
 							&page, &fsdata);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
@@ -2517,7 +2516,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 		kunmap_atomic(kaddr);
 		flush_dcache_page(page);
 
-		a_ops->write_end(NULL, mapping, off, tocopy, tocopy,
+		pagecache_write_end(NULL, mapping, off, tocopy, tocopy,
 						page, fsdata);
 		offset = 0;
 		towrite -= tocopy;
-- 
2.34.1

