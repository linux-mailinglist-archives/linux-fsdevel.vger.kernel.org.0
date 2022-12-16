Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8723464F2BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 21:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiLPUy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 15:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiLPUxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:53:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B412269AB5;
        Fri, 16 Dec 2022 12:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+76OCwXauKS5IMcODdPmW9Pj8wgbgGmSARwzkRMnoeA=; b=kOrwVUNNcHVvXRjI/2ixcYizSv
        X1zaI9sZ6+JN9+pmVOE3W+Vl87jZjb7GM0S9LC7TJ/eBREm47jpbxaHg/6QxQPA6CerFN3/qCxL8M
        CoOk/8cmkreYMejYssnA0mUuBjmcpboXmKhs+IsJg0MQnOdJBVwYD02MRm33c2rjKfxk3odETw9xN
        uJIHQPzIio3MtyuXvGTQkXJc+DPxXy/ku5+RUa4ouwoDvisjSeP4P6syWPSVPqaTy/erGLKbzPdw2
        8BGTlwTQzFI1OLjWRwBLVMMAvjA5jCjgogVJVFptIBJQvphwEu62DGe7iPDbVxUM0awHOMvxU4Pf7
        4h64kaoA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6HiI-00Frfs-97; Fri, 16 Dec 2022 20:53:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     reiserfs-devel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 6/8] reiserfs: Convert map_block_for_writepage() to use kmap_local_folio()
Date:   Fri, 16 Dec 2022 20:53:45 +0000
Message-Id: <20221216205348.3781217-7-willy@infradead.org>
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

Removes uses of kmap() and b_page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 0ca2d439510a..b79848111957 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2360,6 +2360,7 @@ static int map_block_for_writepage(struct inode *inode,
 	struct item_head tmp_ih;
 	struct item_head *ih;
 	struct buffer_head *bh;
+	char *p;
 	__le32 *item;
 	struct cpu_key key;
 	INITIALIZE_PATH(path);
@@ -2382,7 +2383,8 @@ static int map_block_for_writepage(struct inode *inode,
 		return -EIO;
 	}
 
-	kmap(bh_result->b_page);
+	p = kmap_local_folio(bh_result->b_folio,
+			offset_in_folio(bh_result->b_folio, byte_offset - 1));
 start_over:
 	reiserfs_write_lock(inode->i_sb);
 	make_cpu_key(&key, inode, byte_offset, TYPE_ANY, 3);
@@ -2413,9 +2415,6 @@ static int map_block_for_writepage(struct inode *inode,
 		set_block_dev_mapped(bh_result,
 				     get_block_num(item, pos_in_item), inode);
 	} else if (is_direct_le_ih(ih)) {
-		char *p;
-		p = page_address(bh_result->b_page);
-		p += (byte_offset - 1) & (PAGE_SIZE - 1);
 		copy_size = ih_item_len(ih) - pos_in_item;
 
 		fs_gen = get_generation(inode->i_sb);
@@ -2491,7 +2490,7 @@ static int map_block_for_writepage(struct inode *inode,
 			}
 		}
 	}
-	kunmap(bh_result->b_page);
+	kunmap_local(p);
 
 	if (!retval && buffer_mapped(bh_result) && bh_result->b_blocknr == 0) {
 		/*
-- 
2.35.1

