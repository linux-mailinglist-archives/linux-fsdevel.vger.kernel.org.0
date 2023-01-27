Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25A567EA86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 17:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjA0QN5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 11:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbjA0QNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:13:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630FF3E617;
        Fri, 27 Jan 2023 08:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=guDMVzYjdZz1bYag9yiUOEHJdCfyOWFmojUP2yy7Ma8=; b=oXofzRqd0E1o1NMzs/PGbkHxHq
        cS5RpcPbFQR2emq8rQ2qH+0wAA7rmsz5MEYCp3g1qBpugqCRCx1iQhE87W9ZtG72KqFHvwnHldcS8
        FjKbjjDWodwIeIidFqvH6dtt01RN6x70H5R+ezjKpxiXE0Plw1/kBmqXeHv9HpFpJ7VKX1S87IjWm
        WAU+qPBgunPKkknrewVpdoxTMiJGdvNUGrp2f161YeLKrNphDOv8YD3E7pdjyBTaikkGL4jNfRk8d
        15WjuPxuDxR54L6yLjtt/Z1kLl/RX5RcpP1CMUnG8LgfgFR0lH3HIvv9lXCGpe0JUnRb/yNGsTD4r
        delwybyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLRM9-007rH5-MZ; Fri, 27 Jan 2023 16:13:37 +0000
Date:   Fri, 27 Jan 2023 16:13:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/31] fscrypt: Add some folio helper functions
Message-ID: <Y9P4MYXE9NcC8+gv@casper.infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-3-willy@infradead.org>
 <Y9M+tl5CcNfRScds@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9M+tl5CcNfRScds@sol.localdomain>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 07:02:14PM -0800, Eric Biggers wrote:
> On Thu, Jan 26, 2023 at 08:23:46PM +0000, Matthew Wilcox (Oracle) wrote:
> > fscrypt_is_bounce_folio() is the equivalent of fscrypt_is_bounce_page()
> > and fscrypt_pagecache_folio() is the equivalent of fscrypt_pagecache_page().
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  include/linux/fscrypt.h | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> > index 4f5f8a651213..c2c07d36fb3a 100644
> > --- a/include/linux/fscrypt.h
> > +++ b/include/linux/fscrypt.h
> > @@ -273,6 +273,16 @@ static inline struct page *fscrypt_pagecache_page(struct page *bounce_page)
> >  	return (struct page *)page_private(bounce_page);
> >  }
> >  
> > +static inline bool fscrypt_is_bounce_folio(struct folio *folio)
> > +{
> > +	return folio->mapping == NULL;
> > +}
> > +
> > +static inline struct folio *fscrypt_pagecache_folio(struct folio *bounce_folio)
> > +{
> > +	return bounce_folio->private;
> > +}
> 
> ext4_bio_write_folio() is still doing:
> 
> 	bounce_page = fscrypt_encrypt_pagecache_blocks(&folio->page, ...);
> 
> Should it be creating a "bounce folio" instead, or is that not in the scope of
> this patchset?

It's out of scope for _this_ patchset.  I think it's a patchset that
could come either before or after, and is needed to support large folios
with ext4.  The biggest problem with doing that conversion is that
bounce pages are allocated from a mempool which obviously only allocates
order-0 folios.  I don't know what to do about that.  Have a mempool
for each order of folio that the filesystem supports?  Try to allocate
folios without a mempool and then split the folio if allocation fails?
Have a mempool containing PMD-order pages and split them ourselves if
we need to allocate from the mempool?

Nothing's really standing out to me as the perfect answer.  There are
probably other alternatives.
