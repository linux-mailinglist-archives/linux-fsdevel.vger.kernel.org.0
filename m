Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD9767EABA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 17:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjA0QVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 11:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjA0QVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:21:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E06E3BE;
        Fri, 27 Jan 2023 08:21:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E961E61CFB;
        Fri, 27 Jan 2023 16:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371ECC433D2;
        Fri, 27 Jan 2023 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674836508;
        bh=NhkJVkVhG1e3R3iQroGnIKPMW7SlVe1U91Z9ozjaCJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmtDKElBTons5mJCTLCXcKzZ/yRNIVOO+SngpWRGcYByXsAEp4rNyvd1zhU501aFL
         YKW9ot8PgC8WRdfDmEE986F2orkq/jcvOuX+NMbmnnRIo3T4JtLsxOVb4gJSNY9wEW
         RRVzZDmCO4u3/r/Scbu8on+y3gcLYAZ83117jlK6CVfpaUSlOUfoLrZM/RhBKWzotl
         sScKUuu4vPTCtDP+d94hjs+rr2fFOSqyySX6fQRhPhLDqzRBgdaQ5TW67J5zU4lYp0
         aFZF1eQwCZnmS1tR/7qX7mzUVmTnYp2cLRJ6KcATLr+lVLiGgVFEHVPpKF6Rl1RleW
         I9Ajk1yWpt78w==
Date:   Fri, 27 Jan 2023 08:21:46 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/31] fscrypt: Add some folio helper functions
Message-ID: <Y9P6GkuXHp9Gh6ai@sol.localdomain>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-3-willy@infradead.org>
 <Y9M+tl5CcNfRScds@sol.localdomain>
 <Y9P4MYXE9NcC8+gv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9P4MYXE9NcC8+gv@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 27, 2023 at 04:13:37PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 26, 2023 at 07:02:14PM -0800, Eric Biggers wrote:
> > On Thu, Jan 26, 2023 at 08:23:46PM +0000, Matthew Wilcox (Oracle) wrote:
> > > fscrypt_is_bounce_folio() is the equivalent of fscrypt_is_bounce_page()
> > > and fscrypt_pagecache_folio() is the equivalent of fscrypt_pagecache_page().
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  include/linux/fscrypt.h | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > > 
> > > diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> > > index 4f5f8a651213..c2c07d36fb3a 100644
> > > --- a/include/linux/fscrypt.h
> > > +++ b/include/linux/fscrypt.h
> > > @@ -273,6 +273,16 @@ static inline struct page *fscrypt_pagecache_page(struct page *bounce_page)
> > >  	return (struct page *)page_private(bounce_page);
> > >  }
> > >  
> > > +static inline bool fscrypt_is_bounce_folio(struct folio *folio)
> > > +{
> > > +	return folio->mapping == NULL;
> > > +}
> > > +
> > > +static inline struct folio *fscrypt_pagecache_folio(struct folio *bounce_folio)
> > > +{
> > > +	return bounce_folio->private;
> > > +}
> > 
> > ext4_bio_write_folio() is still doing:
> > 
> > 	bounce_page = fscrypt_encrypt_pagecache_blocks(&folio->page, ...);
> > 
> > Should it be creating a "bounce folio" instead, or is that not in the scope of
> > this patchset?
> 
> It's out of scope for _this_ patchset.  I think it's a patchset that
> could come either before or after, and is needed to support large folios
> with ext4.  The biggest problem with doing that conversion is that
> bounce pages are allocated from a mempool which obviously only allocates
> order-0 folios.  I don't know what to do about that.  Have a mempool
> for each order of folio that the filesystem supports?  Try to allocate
> folios without a mempool and then split the folio if allocation fails?
> Have a mempool containing PMD-order pages and split them ourselves if
> we need to allocate from the mempool?
> 
> Nothing's really standing out to me as the perfect answer.  There are
> probably other alternatives.

Would it be possible to keep using bounce *pages* all the time, even when the
pagecache contains large folios?

- Eric
