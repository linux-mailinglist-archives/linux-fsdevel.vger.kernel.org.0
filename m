Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CC2516A5E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383345AbiEBFpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 01:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383315AbiEBFpj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 01:45:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4403584B;
        Sun,  1 May 2022 22:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vlN2HcnECiY2e6tZKUSRm49KVG3UlkoH2PCURMTgL+I=; b=PYoWeoEmvkFY2pnSHECNrTnbFa
        gYgxdKxwGxpknMRzz6Y8P0J4dI3MoHWm13mgoHmJcxbi+swiK0C31n/Xkc7iZ0TUdkYLXmgHJRzya
        HdGM4m8iSPaT9WZ+m9rtWtELH31PLdqIGeG8Cx68Ma/xC8dv56buH7D9P1kFKMQ1Ol4MSr1dxWuUu
        RVxUHwcDQDwx3XuTrEvNtdtOWuxoQBSLZvHGWfUTbFudk6+H7LR0pgq6HoJbiHpa9iQ4lrUvlpWvF
        Bhfp9s6AvuzvLo25J1dI68WNDJVbFWXGvA34wy4CE4GqIFwHUcvB/GghFM9MXiquNoaCYFsZ8O5BI
        3P0zbZFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlOot-00EZ03-Sh; Mon, 02 May 2022 05:42:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, linux-mtd@lists.infradead.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] nfs: Pass the file pointer to nfs_symlink_filler()
Date:   Mon,  2 May 2022 06:41:58 +0100
Message-Id: <20220502054159.3471078-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502054159.3471078-1-willy@infradead.org>
References: <20220502054159.3471078-1-willy@infradead.org>
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

In preparation for unifying the read_cache_page() and read_folio()
implementations, make nfs_symlink_filler() get the inode
from the page instead of passing it in from read_cache_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nfs/symlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 25ba299fdac2..8b53538bcc75 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -28,7 +28,7 @@
 
 static int nfs_symlink_filler(void *data, struct page *page)
 {
-	struct inode *inode = data;
+	struct inode *inode = page->mapping->host;
 	int error;
 
 	error = NFS_PROTO(inode)->readlink(inode, page, 0, PAGE_SIZE);
@@ -67,7 +67,7 @@ static const char *nfs_get_link(struct dentry *dentry,
 		if (err)
 			return err;
 		page = read_cache_page(&inode->i_data, 0, nfs_symlink_filler,
-				inode);
+				NULL);
 		if (IS_ERR(page))
 			return ERR_CAST(page);
 	}
-- 
2.34.1

