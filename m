Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DEE5436C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 17:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243464AbiFHPNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 11:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243525AbiFHPMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:12:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F502F677;
        Wed,  8 Jun 2022 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description;
        bh=+wB/nqOESlmBKGsPGGPvPk+1JR7GdqX/FHAB3WXgdkI=; b=RNFSUCreMEUz8c9RdJFErzY9Oq
        EKV47HQd1TVXLX0ekY7V6SwObNC7KGrbTOousoXYSZDcH2dMldeK+cVGzqvmLl3TqgY3+/WoiiQeG
        NhHbQw8iawjh1njiisBBaWAK4tFuAcYRs0WE0rungjaQqcICzYIE+aXMXEGW1ojCLD0TxsvJyBpgX
        JGgMIkng/FB3p8d8uDWIUqZDKR0EO1CLYOBg799oqrwJ5+1nxI+O9kabupy9IfMWMbS6kOoJ41Gl/
        7AwH2qxEWH7TL3S+rf3YHCJmnfU1peJMtru9bn6Kiscb1WP4uQ7Xmy0uWWJHioThqLRXwVvC94WLc
        EOLZk+ww==;
Received: from [2001:4bb8:190:726c:66c4:f635:4b37:bdda] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyxEy-00DtIM-Cn; Wed, 08 Jun 2022 15:05:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH 2/5] jfs: stop using the nobh helper
Date:   Wed,  8 Jun 2022 17:04:48 +0200
Message-Id: <20220608150451.1432388-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608150451.1432388-1-hch@lst.de>
References: <20220608150451.1432388-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The nobh mode is an obscure feature to save lowlevel for large memory
32-bit configurations while trading for much slower performance and
has been long obsolete.  Switch to the regular buffer head based helpers
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/jfs/inode.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 259326556ada6..d1ec920aa030a 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -301,13 +301,25 @@ static int jfs_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
-	ret = nobh_write_begin(mapping, pos, len, pagep, fsdata, jfs_get_block);
+	ret = block_write_begin(mapping, pos, len, pagep, jfs_get_block);
 	if (unlikely(ret))
 		jfs_write_failed(mapping, pos + len);
 
 	return ret;
 }
 
+static int jfs_write_end(struct file *file, struct address_space *mapping,
+		loff_t pos, unsigned len, unsigned copied, struct page *page,
+		void *fsdata)
+{
+	int ret;
+
+	ret = generic_write_end(file, mapping, pos, len, copied, page, fsdata);
+	if (ret < len)
+		jfs_write_failed(mapping, pos + len);
+	return ret;
+}
+
 static sector_t jfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, jfs_get_block);
@@ -346,7 +358,7 @@ const struct address_space_operations jfs_aops = {
 	.writepage	= jfs_writepage,
 	.writepages	= jfs_writepages,
 	.write_begin	= jfs_write_begin,
-	.write_end	= nobh_write_end,
+	.write_end	= jfs_write_end,
 	.bmap		= jfs_bmap,
 	.direct_IO	= jfs_direct_IO,
 };
@@ -399,7 +411,7 @@ void jfs_truncate(struct inode *ip)
 {
 	jfs_info("jfs_truncate: size = 0x%lx", (ulong) ip->i_size);
 
-	nobh_truncate_page(ip->i_mapping, ip->i_size, jfs_get_block);
+	block_truncate_page(ip->i_mapping, ip->i_size, jfs_get_block);
 
 	IWRITE_LOCK(ip, RDWRLOCK_NORMAL);
 	jfs_truncate_nolock(ip, ip->i_size);
-- 
2.30.2

