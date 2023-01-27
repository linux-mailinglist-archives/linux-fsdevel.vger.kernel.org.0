Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB9C67EB09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 17:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjA0QiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 11:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjA0QiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:38:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76112EC7F;
        Fri, 27 Jan 2023 08:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X3sZG6YT4e1cd8R14oPBhXJnjRzul+FbROxn9J75/K0=; b=ptB/48lvFwK++L3qy23e27/NB2
        tHFMn3tCtRW9n+50nnnep+w+XF52bRKZ3bP+CuOl5S7LyKgrA70qe3QkGN7MrBdSxnKCeXLqLoVhO
        8mMEKk9eNccyQGULhM3Bd/DJuK0gifS0++8qPXM+qNzA77NBizCUntj3Hs477IhfX5lamG1jkRqVZ
        jxq+PEhWAAsSNw+GmcXDBMemxlfGVZKTRx8Ay3cTAMmE95HYLs8sV6uw8MuZm4fIB0XRYBGnX9KL2
        frByO5IXxLtT3qRSoMJ2sK/vLhqX9/ai2epenMSpIWKK+HGMl44la6Cr1D7KC7e9plu4k4LVmwkA0
        OJViKFAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLRjj-007sAw-Uh; Fri, 27 Jan 2023 16:37:59 +0000
Date:   Fri, 27 Jan 2023 16:37:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/31] fscrypt: Add some folio helper functions
Message-ID: <Y9P959mJherU8Yru@casper.infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-3-willy@infradead.org>
 <Y9M+tl5CcNfRScds@sol.localdomain>
 <Y9P4MYXE9NcC8+gv@casper.infradead.org>
 <Y9P6GkuXHp9Gh6ai@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9P6GkuXHp9Gh6ai@sol.localdomain>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 27, 2023 at 08:21:46AM -0800, Eric Biggers wrote:
> On Fri, Jan 27, 2023 at 04:13:37PM +0000, Matthew Wilcox wrote:
> > On Thu, Jan 26, 2023 at 07:02:14PM -0800, Eric Biggers wrote:
> > > On Thu, Jan 26, 2023 at 08:23:46PM +0000, Matthew Wilcox (Oracle) wrote:
> > > > fscrypt_is_bounce_folio() is the equivalent of fscrypt_is_bounce_page()
> > > > and fscrypt_pagecache_folio() is the equivalent of fscrypt_pagecache_page().
> > > > 
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > ---
> > > >  include/linux/fscrypt.h | 21 +++++++++++++++++++++
> > > >  1 file changed, 21 insertions(+)
> > > > 
> > > > diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> > > > index 4f5f8a651213..c2c07d36fb3a 100644
> > > > --- a/include/linux/fscrypt.h
> > > > +++ b/include/linux/fscrypt.h
> > > > @@ -273,6 +273,16 @@ static inline struct page *fscrypt_pagecache_page(struct page *bounce_page)
> > > >  	return (struct page *)page_private(bounce_page);
> > > >  }
> > > >  
> > > > +static inline bool fscrypt_is_bounce_folio(struct folio *folio)
> > > > +{
> > > > +	return folio->mapping == NULL;
> > > > +}
> > > > +
> > > > +static inline struct folio *fscrypt_pagecache_folio(struct folio *bounce_folio)
> > > > +{
> > > > +	return bounce_folio->private;
> > > > +}
> > > 
> > > ext4_bio_write_folio() is still doing:
> > > 
> > > 	bounce_page = fscrypt_encrypt_pagecache_blocks(&folio->page, ...);
> > > 
> > > Should it be creating a "bounce folio" instead, or is that not in the scope of
> > > this patchset?
> > 
> > It's out of scope for _this_ patchset.  I think it's a patchset that
> > could come either before or after, and is needed to support large folios
> > with ext4.  The biggest problem with doing that conversion is that
> > bounce pages are allocated from a mempool which obviously only allocates
> > order-0 folios.  I don't know what to do about that.  Have a mempool
> > for each order of folio that the filesystem supports?  Try to allocate
> > folios without a mempool and then split the folio if allocation fails?
> > Have a mempool containing PMD-order pages and split them ourselves if
> > we need to allocate from the mempool?
> > 
> > Nothing's really standing out to me as the perfect answer.  There are
> > probably other alternatives.
> 
> Would it be possible to keep using bounce *pages* all the time, even when the
> pagecache contains large folios?

I _think_ so.  Probably the best solution is to attempt to allocate an
order-N folio (with GFP_NOWAIT?) and then fall back to allocating 2^N
pages from the mempool.  It'll require some surgery to ext4_finish_bio()
as well as ext4_bio_write_folio(), fscrypt_encrypt_pagecache_blocks()
and fscrypt_free_bounce_page(), but I think it's doable.  I'll try
to whip something up.
