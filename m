Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32FC4441E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 13:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhKCMwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 08:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhKCMwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:52:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78026C061714;
        Wed,  3 Nov 2021 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AWxSgl03y6hj3Uclf1xozKOXfzyGEIJRVjgfKOuJfpg=; b=YuVMiK6AS8CrpAonDsTY6eSJVb
        OugD9VsmoHFM7boGrHLu1QNyCytMHEg5N91zyXYRxpdssp5JyGumIRtnDLczTlyGZjvjxZbOfVUSu
        u7Voc9B6hX01wrjNWQ52S3RodehRg4jMLvQ7dSctJVKuaig11MUJMUNnKJGQ5WGkcgnzrRHpn9oh5
        x/pOcow5cBk8Muleo21zE8sYrnuJLCICJrc7wSzHPq5g/+Wq5jS8KofnVayU2t4XMSZRBm5+nWZ3M
        x3Iz+x5zsxxIyb8HG/mzwYgDPnbD82Aniau6Qs8ra5Wo6Cw+aWZbw0HF5+o76aMPh3S6teWu+26zG
        uYXZsPyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miFgM-005Cll-UN; Wed, 03 Nov 2021 12:48:29 +0000
Date:   Wed, 3 Nov 2021 12:47:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 15/21] iomap: Convert iomap_write_begin and
 iomap_write_end to folios
Message-ID: <YYKE/ohWPf7jUBM/@casper.infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-16-willy@infradead.org>
 <20211102232215.GG2237511@magnolia>
 <YYH+wfNdgubpqtyP@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYH+wfNdgubpqtyP@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 03:15:13AM +0000, Matthew Wilcox wrote:
> On Tue, Nov 02, 2021 at 04:22:15PM -0700, Darrick J. Wong wrote:
> > > +	page = folio_file_page(folio, pos >> PAGE_SHIFT);
> > 
> > Isn't this only needed in the BUFFER_HEAD case?
> 
> Good catch.  Want me to fold this in?
> 
> @@ -632,12 +631,12 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>                 goto out_no_page;
>         }
>  
> -       page = folio_file_page(folio, pos >> PAGE_SHIFT);
>         if (srcmap->type == IOMAP_INLINE)
>                 status = iomap_write_begin_inline(iter, folio);
> -       else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
> +       else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
> +               struct page *page = folio_file_page(folio, pos >> PAGE_SHIFT);
>                 status = __block_write_begin_int(page, pos, len, NULL, srcmap);

On second thoughts, this is silly.  __block_write_begin_int() doesn't
want the precise page (because it constructs buffer_heads and attaches
them to the passed-in page).  I should just pass &folio->page here.
And __block_write_begin_int() should be converted to take a folio
at some point.
