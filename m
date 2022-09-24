Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F1D5E8FDD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 23:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiIXVn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 17:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiIXVn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 17:43:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB4D4598B
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/T1K9H4cqIrx2jFYKt/1fJNM9FlFSI/20esrT8RENcA=; b=q+tkSzSZ2STIpOlz8/ynaLNm1h
        nUhyQDDnAzXADzXu/E07U6RSUShoxjmTrmdE9GwIRj5nzJ6k2FvAiy8Ry5sPQsrPnEsWZOZz+OV0A
        OES19e3imYXQLa09Xl1dRLNOI2IUB4kdE6ZKYR+nPAH1AB0Vp8Cii1ICotI8W8/s0Eo/K4N0t02Rb
        3XOX8C75ugD8nJ56pZPoo+0/mymbj05I1LFq/lo4yoFMCIaRTYPUbnyJyk/zryqYkZECLsudeHLGC
        HazDrNEKcqhUJD2h1cgp+D3zYtfNiN2Uo+2VkE+HVkNDPIS9Z/HT64ReDztZoa9RoWr86t2Ur5Wyg
        Jf6h2qIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocCwD-0093GY-Jl; Sat, 24 Sep 2022 21:43:53 +0000
Date:   Sat, 24 Sep 2022 22:43:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexander Larsson <alexl@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] filemap: Fix error propagation in do_read_cache_page()
Message-ID: <Yy96GSW6o7tm8GKy@casper.infradead.org>
References: <20220921091010.1309093-1-alexl@redhat.com>
 <YytG4sTn5OF44mXH@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YytG4sTn5OF44mXH@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 06:16:18PM +0100, Al Viro wrote:
> On Wed, Sep 21, 2022 at 11:10:10AM +0200, Alexander Larsson wrote:
> > When do_read_cache_folio() returns an error pointer the code
> > was dereferencing it rather than forwarding the error via
> > ERR_CAST().
> > 
> > Found during code review.
> > 
> > Fixes: 539a3322f208 ("filemap: Add read_cache_folio and read_mapping_folio")
> > Signed-off-by: Alexander Larsson <alexl@redhat.com>
> > ---
> >  mm/filemap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 15800334147b..6bc55506f7a8 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3560,7 +3560,7 @@ static struct page *do_read_cache_page(struct address_space *mapping,
> >  
> >  	folio = do_read_cache_folio(mapping, index, filler, file, gfp);
> >  	if (IS_ERR(folio))
> > -		return &folio->page;
> > +		return ERR_CAST(folio);
> 
> Where do you see a dereference?  I agree that your variant is cleaner,
> but &folio->page does *NOT* dereference anything - it's an equivalent of
> 
> 	(struct page *)((unsigned long)folio + offsetof(struct folio, page))
> 
> and the reason it happens to work is that page is the first member in
> struct folio, so the offsetof ends up being 0 and we are left with a cast
> from struct folio * to struct page *, i.e. the same thing ERR_CAST()
> variant end up with (it casts to void *, which is converted to struct
> page * since return acts as assignment wrt type conversions).
> 
> It *is* brittle and misguiding, and your patch is a much more clear
> way to spell that thing, no arguments about it; just that your patch
> is not changing behaviour.

I don't see it that way.  &folio->page is the idiomatic way to do this.
What it really is, is an indicator that code needs to be converted from
calling do_read_cache_page() and friends to calling the folio equivalents.
Also, I should have moved this code to folio-compat.c where it would be
with all the other code that uses this idiom.
