Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB002724FF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbjFFWfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbjFFWey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:34:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22514213F
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZjtnlBLE0yrfk3v9n9nGLR/LNoPZt0d/wxUbdJblwQ4=; b=Zyu0x4Xa+UEG1fc0/NisGzFGd2
        IbL3TpIruL5P50P/ItGam4g0/pr4xzKVZgczQe0t5ATZnSKCYI7WDHivzaPxVli6j5KQhvrKN2NAw
        L6s3QVCviF3Yg73Mhs3HbFTVP1+30n4kEBa9va2dwsA0wifj9vhUkrswt2mEYYyYvizySXh0G0+xI
        rlIrxzUDj4cogyqPyTmG+Jq/5kDXW61q5n3NyF8zmKNVSlAiP6s3A3ym6z0QVrvLbdkaw9q0fT3ZS
        WNKnExzTfdbMTxexS4GdYxfTuM+JwkVDmExa2GNympwVq7h1JTRutK89ybD/1qBIkfiKG5YvuxpY1
        nbRCjRig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6fFV-00DbFL-Qo; Tue, 06 Jun 2023 22:33:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 12/14] buffer: Convert link_dev_buffers to take a folio
Date:   Tue,  6 Jun 2023 23:33:44 +0100
Message-Id: <20230606223346.3241328-13-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230606223346.3241328-1-willy@infradead.org>
References: <20230606223346.3241328-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Its one caller already has a folio, so switch it to use the
folio API.  Removes a hidden call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9b789f109a57..c81b8b20ad64 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -907,8 +907,8 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 }
 EXPORT_SYMBOL_GPL(alloc_page_buffers);
 
-static inline void
-link_dev_buffers(struct page *page, struct buffer_head *head)
+static inline void link_dev_buffers(struct folio *folio,
+		struct buffer_head *head)
 {
 	struct buffer_head *bh, *tail;
 
@@ -918,7 +918,7 @@ link_dev_buffers(struct page *page, struct buffer_head *head)
 		bh = bh->b_this_page;
 	} while (bh);
 	tail->b_this_page = head;
-	attach_page_private(page, head);
+	folio_attach_private(folio, head);
 }
 
 static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
@@ -1013,7 +1013,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	 * run under the folio lock.
 	 */
 	spin_lock(&inode->i_mapping->private_lock);
-	link_dev_buffers(&folio->page, bh);
+	link_dev_buffers(folio, bh);
 	end_block = folio_init_buffers(folio, bdev,
 			(sector_t)index << sizebits, size);
 	spin_unlock(&inode->i_mapping->private_lock);
-- 
2.39.2

