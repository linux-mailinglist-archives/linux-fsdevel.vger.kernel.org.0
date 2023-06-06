Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A247235BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 05:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjFFDW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 23:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFFDW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:22:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90364127
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 20:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bgQl2HcDSX0CQG5MtHS5EcgGmE+fwx2fMW6fGk5Fo9s=; b=r8SM0Hez73vG3zZ5Qt/3Z7ELWO
        krNzTksNO63lUwn/bCphcv3Ps1oD7ACXalF2JOMCHCFNsdt+DDgtJBiqxft6JMVxr7apoqfmPfwsy
        CfzQnTqkFuFUyUBFYVGejW1boJxGZ22oCYlW+3iSd009UVF/3bmviCuM02MUnGn4rS1dbSAgvFaEK
        DZCyZWQPqdhOO+TG5pwQr9V2JTxsrhNW7Uq87SJzHOO7EAJtMsjGuLVkwcNPo/yF8BXclo8yMs46U
        94oIf7XGULfMkTmiRKwJQdSZfiWOXQjY5NQRb+ZCKPeNb/c21bB8xR/dz6euPtVRZruHmR3HDavlb
        UFRHM+vw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6NHX-00ChDl-GY; Tue, 06 Jun 2023 03:22:51 +0000
Date:   Tue, 6 Jun 2023 04:22:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/4] ubifs: Convert do_writepage() to take a folio
Message-ID: <ZH6mixCMHce1S+vK@casper.infradead.org>
References: <20230605165029.2908304-1-willy@infradead.org>
 <20230605165029.2908304-5-willy@infradead.org>
 <2059298337.3685966.1686001020185.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2059298337.3685966.1686001020185.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 11:37:00PM +0200, Richard Weinberger wrote:
> > -	addr = kmap(page);
> > -	block = page->index << UBIFS_BLOCKS_PER_PAGE_SHIFT;
> > +	addr = kmap_local_folio(folio, offset);
> > +	block = folio->index << UBIFS_BLOCKS_PER_PAGE_SHIFT;
> > 	i = 0;
> > -	while (len) {
> > -		blen = min_t(int, len, UBIFS_BLOCK_SIZE);
> > +	for (;;) {
> 
> This change will cause a file system corruption.
> If len is zero (it can be) then a zero length data node will be written.
> The while(len) made sure that upon zero length nothing is written.

I don't see how 'len' can be 0.  len is modified each time around the
loop, and if it's decremented to 0, we break.  So you must be referring
to a case where the caller of do_writepage passes 0.

There are three callers of do_writepage, two in ubifs_writepage():

        int err, len = folio_size(folio);
...
        if (folio_pos(folio) + len < i_size) {
...
                return do_writepage(folio, len);

len is folio_size(), which is not 0.

        len = offset_in_folio(folio, i_size);

Here, we know that len is not 0.  We already tested earlier:
        if (folio_pos(folio) >= i_size) {

so we know that i_size > folio_pos() and i_size < folio_pos() +
folio_size().  Actually, I should make this more explicit:

	len = i_size - folio_pos(folio);

Now it should be clear that len cannot be zero.

The third caller is do_truncation():

        loff_t old_size = inode->i_size, new_size = attr->ia_size;
        int offset = new_size & (UBIFS_BLOCK_SIZE - 1), budgeted = 1;
        if (offset) {
                pgoff_t index = new_size >> PAGE_SHIFT;
                                       offset = offset_in_folio(folio,
                                                        new_size);
                                err = do_writepage(folio, offset);

It's not large-folio-safe, but it's definitely not 0.

Did I miss something?
