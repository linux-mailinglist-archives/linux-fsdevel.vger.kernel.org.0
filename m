Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB592732019
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 20:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjFOSdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 14:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFOSdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:33:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84A02D7B
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 11:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O9gP657NZsBL2lRDWc75zr90wbmqg/UL+31N9kys/6c=; b=Q3vcivezsGX7vZ20vrTVTwHJHP
        4nxKKOWLlUhG6Dnjfx3K0SnvoVcTpetOUNJemrrcFwJD7HXEVxSPAi6/P3f4u3Er8bL2odWaSFk7F
        eMOKqjAIWxnjWAIzPjGXNndl/2mxn5NJ/qBkxWn+PVzLTAD580Ol+J8nTt7KYgf6rddbeiOqculpn
        /Lf11qgaOgVPVSEWrQQpHQJePARr7Ej/LiWtko/FKPPynkmpbP5oGfgeQu7Ed9oZ5OhPxYYGz1oHH
        8ioQLNs3N/9BpfCHkxBxh2kKg/qO8FQO6FV2efrDVFmVtSjELcsy7l8/35gKserTiKvVJheOt/Xgh
        t2PPcO3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9rli-007xc9-VZ; Thu, 15 Jun 2023 18:32:27 +0000
Date:   Thu, 15 Jun 2023 19:32:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] buffer: convert block_truncate_page() to use a folio
Message-ID: <ZItZOt+XxV12HtzL@casper.infradead.org>
References: <330ceb44-8cd7-41ee-8750-648e90cb165e@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <330ceb44-8cd7-41ee-8750-648e90cb165e@moroto.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 04:01:12PM +0300, Dan Carpenter wrote:
> Hello Matthew Wilcox (Oracle),
> 
> The patch dd69ce3382a2: "buffer: convert block_truncate_page() to use
> a folio" from Jun 12, 2023, leads to the following Smatch static
> checker warning:
> 
> fs/buffer.c:1066 grow_dev_page() error: 'folio' dereferencing possible ERR_PTR()
> 
> This one seems like a false positive,  If you call __filemap_get_folio()
> with __GFP_NOFAIL then it only returns valid pointers, right?

That's right.  There was no check for NULL before, and I looked at it
carefully before deciding that I didn't need to add a check for an error
when I converted it from find_or_create_page().

> fs/buffer.c:2689 block_truncate_page() warn: 'folio' is an error pointer or valid
> fs/buffer.c:2692 block_truncate_page() error: 'folio' dereferencing possible ERR_PTR()
> 
> fs/buffer.c
>     2679         length = from & (blocksize - 1);
>     2680 
>     2681         /* Block boundary? Nothing to do */
>     2682         if (!length)
>     2683                 return 0;
>     2684 
>     2685         length = blocksize - length;
>     2686         iblock = (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
>     2687         
>     2688         folio = filemap_grab_folio(mapping, index);
> --> 2689         if (!folio)
> 
> This should be IS_ERR(). 

Yup, that was sloppy.

Andrew, can you add this -fix to "buffer: Convert block_truncate_page()
to use a folio"?

diff --git a/fs/buffer.c b/fs/buffer.c
index 5a5b0c9d9769..248968dbde31 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2617,8 +2617,8 @@ int block_truncate_page(struct address_space *mapping,
 	iblock = (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
 	
 	folio = filemap_grab_folio(mapping, index);
-	if (!folio)
-		return -ENOMEM;
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
 	bh = folio_buffers(folio);
 	if (!bh) {
