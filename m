Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9592E64F2B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 21:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiLPUxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 15:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiLPUxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:53:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B772369A92;
        Fri, 16 Dec 2022 12:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DCrauRLt2EmPZPaFIh9kpV6gYQG4jQQqkdRBmcKkleQ=; b=ao2aqhzjy8BrR4/3l+tH2zQFRf
        acW92hIwDg8JLqfV5XjgbmOGc/DXA0rjsJ5RlRs8GNS/6DVxp3y9vFhYqqC+f+0SZOzKu0UY1zvVz
        F3/s3lLlNo5pmTA+dK5dOz3nO/D5KtsaNn04wcsKz+yFxGTYc4ICpucZJcpds3V8o626YPhaaSwjp
        oZXrAUkhZgA+LSP2Bc8PDclnDFHlkWmyay6BEhst5KdEogj3r3C6EhuAnmFVyuRPC9ZYczX8xsHUb
        TmFGP+n66GIecZVaOg9LPOPo/7zWn4uWWBi4HBR9DS3IQF6Nz2ITBYkQ8fxV67lZHsHWBmLXKXkAs
        FHqQwVwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6HiH-00Frfh-TQ; Fri, 16 Dec 2022 20:53:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     reiserfs-devel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 2/8] reiserfs: use kmap_local_folio() in _get_block_create_0()
Date:   Fri, 16 Dec 2022 20:53:41 +0000
Message-Id: <20221216205348.3781217-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221216205348.3781217-1-willy@infradead.org>
References: <20221216205348.3781217-1-willy@infradead.org>
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

Switch from the deprecated kmap() to kmap_local_folio().  For the
kunmap_local(), I subtract off 'chars' to prevent the possibility that
p has wrapped into the next page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 41c0a785e9ab..0ca2d439510a 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -390,8 +390,7 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 	 * sure we need to.  But, this means the item might move if
 	 * kmap schedules
 	 */
-	p = (char *)kmap(bh_result->b_page);
-	p += offset;
+	p = kmap_local_folio(bh_result->b_folio, offset);
 	memset(p, 0, inode->i_sb->s_blocksize);
 	do {
 		if (!is_direct_le_ih(ih)) {
@@ -439,8 +438,8 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 		ih = tp_item_head(&path);
 	} while (1);
 
-	flush_dcache_page(bh_result->b_page);
-	kunmap(bh_result->b_page);
+	flush_dcache_folio(bh_result->b_folio);
+	kunmap_local(p - chars);
 
 finished:
 	pathrelse(&path);
-- 
2.35.1

