Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A176C6E7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 18:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCWRPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 13:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCWRPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:15:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DB11ADE2;
        Thu, 23 Mar 2023 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LaXylfNi8bpz1BBW0lX81CGYCQrmMNDssRUOAZBiH+U=; b=LKb6v0hDdAu0sIuC5TUubwuEQH
        dZq0rAHl8Bv+V0o6vCEYEhyDrZw4D+0eDJaTcHieFBl7I4GfHuKQuR6C/Q+iSwROptPZ5n6k+eBdL
        omZ/QtDRzYoCvaqACYxbyAFBi6pvYcS1ITSft2ggjSe4RCCQOPku66Y8gYHO4VNa++SezkHh/FSPz
        goZk0MLvYyS8Zc5q/Dv5oZwcE7ptNtXFNyIngzBfjqe22vxzbS/Csz0rbVslNpYPYiaIWEcbJI2tA
        lh4jm8WlkJ5JbjX0ndOeqcFz/Flj+lHaYhR2TgRPb0BHJkzEp3g2+WlnuncJdyzk6ldgc+EJLsvws
        HFs3l93A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfOWd-0046ux-Eq; Thu, 23 Mar 2023 17:14:55 +0000
Date:   Thu, 23 Mar 2023 17:14:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/31] ext4: Convert ext4_convert_inline_data_to_extent()
 to use a folio
Message-ID: <ZByJD2ufs9hM5usF@casper.infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-11-willy@infradead.org>
 <20230314223621.GY860405@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314223621.GY860405@mit.edu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 06:36:21PM -0400, Theodore Ts'o wrote:
> On Thu, Jan 26, 2023 at 08:23:54PM +0000, Matthew Wilcox (Oracle) wrote:
> > Saves a number of calls to compound_head().
> 
> Is this left over from an earlier version of this patch series?  There
> are no changes to calls to compound_head() that I can find in this
> patch.

They're hidden.  Here are the ones from this patch:

-       if (!PageUptodate(page)) {
-               unlock_page(page);
-               put_page(page);
-               unlock_page(page);
-               put_page(page);

That's five.  I may have missed some.

> > @@ -565,10 +564,9 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
> >  
> >  	/* We cannot recurse into the filesystem as the transaction is already
> >  	 * started */
> > -	flags = memalloc_nofs_save();
> > -	page = grab_cache_page_write_begin(mapping, 0);
> > -	memalloc_nofs_restore(flags);
> > -	if (!page) {
> > +	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
> > +			mapping_gfp_mask(mapping));
> > +	if (!folio) {
> >  		ret = -ENOMEM;
> >  		goto out;
> >  	}
> 
> Is there a reason why to use FGP_NOFS as opposed to using
> memalloc_nofs_{save,restore}()?
> 
> I thought using memalloc_nofs_save() is considered the perferred
> approach by mm-folks.

Ideally, yes, we'd use memalloc_nofs_save(), but not like this!  The way
it's supposed to be used is at the point where you do something which
makes the fs non-reentrant.  ie when you start the transaction, you should
be calling memalloc_nofs_save() and when you finish the transaction,
you should be calling memalloc_nofs_restore().  That way, you don't
need to adorn the entire filesystem with GFP_NOFS/FGP_NOFS/whatever,
you have one place where you mark yourself non-reentrant and you're done.

Once ext4 does this every time it starts a transaction, we can drop
the FGP_NOFS flag usage in ext4, and once every filesystem does it,
we can drop the entire flag, and that will make me happy.  It's a long
road, though.
