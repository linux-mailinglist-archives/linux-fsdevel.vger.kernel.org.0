Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6324A6A7093
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 17:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCAQKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 11:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjCAQKJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:10:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5912C1E5C5
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 08:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tiTLtaf44OTHX6JNi5JcQtkJWh5JJ8tHWlceD0V0oXM=; b=WYa9+guoW67+ttQS72oi8wPBaG
        QWqA7PoKKzJdo7Qas3iHJEGB4nFYeTFgmEWsyhgFFv2vr7VSPELBxsb8hC4ABCwYa3JhpeMmOonwN
        INzXF72jn3Z+hj6Ak/9HFObrwEc2XtEVcsYy/bMC74ziicRlY45n7qHZywE9comi6lEoEgffu4zzs
        nuPObG7McYSrp8Fco/6jZ2JAi7FUxmQLc2L8SQjbUQ2bYpgToGWwVi9VV77CLvlOWvUU4r7ClSuQ7
        1Swj/KsXOyWWEj4yWgA0DoYRJqJqa6Ybsjn+zbylAHw9rOjGwLEbCbntRt+H+KBogXybswsmPQJJ6
        TcMbxqBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXP1o-001jSY-2i; Wed, 01 Mar 2023 16:10:04 +0000
Date:   Wed, 1 Mar 2023 16:10:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] udf: Fix lost writes in udf_adinicb_writepage()
Message-ID: <Y/943PNn3gOKGALv@casper.infradead.org>
References: <20230301133937.24267-1-jack@suse.cz>
 <20230301134641.11819-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301134641.11819-1-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 02:46:35PM +0100, Jan Kara wrote:
> The patch converting udf_adinicb_writepage() to avoid manually kmapping
> the page used memcpy_to_page() however that copies in the wrong
> direction (effectively overwriting file data with the old contents).
> What we should be using is memcpy_from_page() to copy data from the page
> into the inode and then mark inode dirty to store the data.
> 
> Fixes: 5cfc45321a6d ("udf: Convert udf_adinicb_writepage() to memcpy_to_page()")
> Signed-off-by: Jan Kara <jack@suse.cz>

Oops.  Now you're copying in the right direction, we have a folio
function for that, so we could just folio-ise the entire function?
Maybe you'd rather keep the fix minimal and apply this later.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index f7a9607c2b95..890be63ddd02 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -188,14 +188,14 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
 static int udf_adinicb_writepage(struct folio *folio,
 				 struct writeback_control *wbc, void *data)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 
-	BUG_ON(!PageLocked(page));
-	memcpy_to_page(page, 0, iinfo->i_data + iinfo->i_lenEAttr,
+	BUG_ON(!folio_test_locked(folio));
+	BUG_ON(folio->index != 0);
+	memcpy_from_file_folio(iinfo->i_data + iinfo->i_lenEAttr, folio, 0,
 		       i_size_read(inode));
-	unlock_page(page);
+	folio_unlock(folio);
 	mark_inode_dirty(inode);
 
 	return 0;
