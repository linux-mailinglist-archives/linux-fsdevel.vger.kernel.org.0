Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6269C788FA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 22:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjHYUNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 16:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjHYUMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:12:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E662689;
        Fri, 25 Aug 2023 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=g99Hhk2pP6XTnhJriYN5x3KOeH0Kln5KYpmyrej4TNY=; b=lt+RM7YR+Daq91Y5fUAcC4rbaK
        oxtEvmA7fCyITfYBnHb3WXy0i14oBPWffh16S7h+kFTvLhSOfPaZLOh7RLp9GkpFoJL8WHKH1jRpb
        G3Nu9CHWR/RYd1h77NQvlO3fjwDryJKrOQ/kS1Dxu9xJjHHx6KveTByDuU+AaTk2szZalnfNRzZa0
        bR8fXDWMNDBCEL16zkgNEYONlgIF+ifpyAg1CAXNxF9LTttdZYTp92uZK6psr1hO5Msv47XBCThRv
        iu7eeQoMAqCUMs02b1uVr/nYZhFE5VXA+NDNKHpjcC6ST/rbPLIyEaOJsckyzgw95pI8p3IBhAmb2
        prEPkwFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAV-001SZm-FJ; Fri, 25 Aug 2023 20:12:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/15] ceph: Remove ceph_writepage()
Date:   Fri, 25 Aug 2023 21:12:15 +0100
Message-Id: <20230825201225.348148-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230825201225.348148-1-willy@infradead.org>
References: <20230825201225.348148-1-willy@infradead.org>
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

Now that we have a migrate_folio method, there is no need for a
writepage method.  All writeback will go through the writepages
method instead which is more efficient.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a0a1fac1a0db..785f2983ac0e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -795,30 +795,6 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	return err;
 }
 
-static int ceph_writepage(struct page *page, struct writeback_control *wbc)
-{
-	int err;
-	struct inode *inode = page->mapping->host;
-	BUG_ON(!inode);
-	ihold(inode);
-
-	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    ceph_inode_to_client(inode)->write_congested)
-		return AOP_WRITEPAGE_ACTIVATE;
-
-	wait_on_page_fscache(page);
-
-	err = writepage_nounlock(page, wbc);
-	if (err == -ERESTARTSYS) {
-		/* direct memory reclaimer was killed by SIGKILL. return 0
-		 * to prevent caller from setting mapping/page error */
-		err = 0;
-	}
-	unlock_page(page);
-	iput(inode);
-	return err;
-}
-
 /*
  * async writeback completion handler.
  *
@@ -1555,7 +1531,6 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
 const struct address_space_operations ceph_aops = {
 	.read_folio = netfs_read_folio,
 	.readahead = netfs_readahead,
-	.writepage = ceph_writepage,
 	.writepages = ceph_writepages_start,
 	.write_begin = ceph_write_begin,
 	.write_end = ceph_write_end,
-- 
2.40.1

