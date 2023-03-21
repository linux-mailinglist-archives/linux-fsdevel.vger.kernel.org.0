Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA296C34EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 16:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjCUPAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 11:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjCUPAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:00:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F88D328;
        Tue, 21 Mar 2023 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m9bL0KOnysBAibLI8w6lm45Z5wnCZBOkn23yAA0iJvc=; b=dAQYw4k5ZrZRxlzfG+MNeaXDVQ
        zgoyf0lkO9E+CSiKf9dSSdFYTL7H9n2ksIeg5/FSGnADOyiohhjCzoUv1C0s5SQEO3o6agYtof6iX
        4xi4gcJdHzzPa4IT9cTQ67Ygn4/1UY0b1N9jxcdjbV7g9Dq3EtZxdiWUmhCQh/RMMN67tXLVFsSyk
        EXjs2C0WOg9D5VImqqgGX46azDo7z1RYhPKZa+F1iSprF4ZAjvdQnpSwc8ilnojYZ3dOyyrdyxd9T
        VW/s67Qi9X3YDKsVxUfQ8R32Dgh/SrUtiQT/KmSbTKXq5sNpoRfYvd5GaMWET66BArKMuDQ/HqWN5
        bPKjmhQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pedT1-00288y-DT; Tue, 21 Mar 2023 15:00:03 +0000
Date:   Tue, 21 Mar 2023 15:00:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/5] brd: convert to folios
Message-ID: <ZBnGc4WbBOlnRUgd@casper.infradead.org>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-2-hare@suse.de>
 <ZAYk5wOUaXAIouQ5@casper.infradead.org>
 <76613838-fa4c-7f3e-3417-7a803fafc6c2@suse.de>
 <ZAboHUp/YUkEs/D1@casper.infradead.org>
 <a4489f7b-912c-e68f-4a4c-c14d96026bd6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4489f7b-912c-e68f-4a4c-c14d96026bd6@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 09:14:27AM +0100, Hannes Reinecke wrote:
> On 3/7/23 08:30, Matthew Wilcox wrote:
> > On Tue, Mar 07, 2023 at 07:55:32AM +0100, Hannes Reinecke wrote:
> > > On 3/6/23 18:37, Matthew Wilcox wrote:
> > > > On Mon, Mar 06, 2023 at 01:01:23PM +0100, Hannes Reinecke wrote:
> > > > > -	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
> > > > > -	if (!page)
> > > > > +	folio = folio_alloc(gfp | __GFP_ZERO, 0);
> > > > > +	if (!folio)
> > > > 
> > > > Did you drop HIGHMEM support on purpose?
> > > 
> > > No; I thought that folios would be doing that implicitely.
> > > Will be re-adding.
> > 
> > We can't ... not all filesystems want to allocate every folio from
> > HIGHMEM.  eg for superblocks, it often makes more sense to allocate the
> > folio from lowmem than allocate it from highmem and keep it kmapped.
> > The only GFP flag that folios force-set is __GFP_COMP because folios by
> > definition are compound pages.
> 
> Oh well.
> 
> However, when playing with the modified brd and setting the logical&physical
> blocksize to 16k the whole thing crashes
> (not unexpectedly).
> It does crash, however, in block_read_full_folio(), which rather
> surprisingly (at least for me) is using create_page_buffers();
> I would have expected something like create_folio_buffers().
> Is this work in progress or what is the plan here?

Supporting folios > PAGE_SIZE in blockdev is definitely still WIP.
I know of at least one bug, which is:

#define bh_offset(bh)           ((unsigned long)(bh)->b_data & ~PAGE_MASK)

That needs to be something like

static size_t bh_offset(const struct buffer_head *bh)
{
	return (unsigned long)bh->b_data & (folio_size(bh->b_folio) - 1);
}

I haven't done a thorough scan for folio-size problems in the block
layer; I've just been fixing up things as I notice them.

Yes, create_page_buffers() should now be create_folio_buffers().  Just
didn't get round to it yet.
