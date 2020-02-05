Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D58153A94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 22:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBEV7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 16:59:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgBEV7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C144lamQXCWd4qGw8ZnP+cFCyvG4nfsd73fNvpaXgPY=; b=NwrKWzzZzN2JE3U29pn/PlL8Jr
        alMn+RmqkHvLx82hmAMkmymmKdnY7XVj3/ZicGehWZ2wlfFd7DQiJIENS/xoIlBTxZgRuWend5M9W
        ea0Y/t30NVuI6FluDPbmZGdmyGuxCvqv+qyn2s12Em5Nw27j6S3oc7xeaFjOCfhBXpbEVCfLkSG2S
        CHihV5BN7yID01XY0las+bDzTsx34p85VCRInrLXHPIiy+UUdLn4H+undkIJl7nMvXWixPdWQpEvw
        R6iRsbjvDFaiHUXUyJPoCQN1tkjJ0fNQc6XnDYg6IDhxdxTE0U/iRSfTQr9kOdDjkzsf3iW+csGsx
        4F66xvbg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izShM-0005VD-9o; Wed, 05 Feb 2020 21:59:04 +0000
Date:   Wed, 5 Feb 2020 13:59:04 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 8/8] xarray: Don't clear marks in xas_store()
Message-ID: <20200205215904.GT8731@bombadil.infradead.org>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-9-jack@suse.cz>
 <20200205184344.GB28298@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205184344.GB28298@ziepe.ca>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 02:43:44PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 04, 2020 at 03:25:14PM +0100, Jan Kara wrote:
> > When storing NULL in xarray, xas_store() has been clearing all marks
> > because it could otherwise confuse xas_for_each_marked(). That is
> > however no longer true and no current user relies on this behavior.
> > Furthermore it seems as a cleaner API to not do clearing behind caller's
> > back in case we store NULL.
> > 
> > This provides a nice boost to truncate numbers due to saving unnecessary
> > tag initialization when clearing shadow entries. Sample benchmark
> > showing time to truncate 128 files 1GB each on machine with 64GB of RAM
> > (so about half of entries are shadow entries):
> > 
> >          AVG      STDDEV
> > Vanilla  4.825s   0.036
> > Patched  4.516s   0.014
> > 
> > So we can see about 6% reduction in overall truncate time.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> >  lib/xarray.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > diff --git a/lib/xarray.c b/lib/xarray.c
> > index 4e32497c51bd..f165e83652f1 100644
> > +++ b/lib/xarray.c
> > @@ -799,17 +799,8 @@ void *xas_store(struct xa_state *xas, void *entry)
> >  		if (xas->xa_sibs)
> >  			xas_squash_marks(xas);
> >  	}
> > -	if (!entry)
> > -		xas_init_marks(xas);
> >  
> >  	for (;;) {
> > -		/*
> > -		 * Must clear the marks before setting the entry to NULL,
> > -		 * otherwise xas_for_each_marked may find a NULL entry and
> > -		 * stop early.  rcu_assign_pointer contains a release barrier
> > -		 * so the mark clearing will appear to happen before the
> > -		 * entry is set to NULL.
> > -		 */
> >  		rcu_assign_pointer(*slot, entry);
> 
> The above removed comment doesn't sound right (the release is paired
> with READ_ONCE, which is only an acquire for data dependent accesses),
> is this a reflection of the original bug in this thread?

Yes.  I was thinking about a classical race like so:

read mark
			clear mark
load entry
			store NULL

but of course CPUs can execute many instructions asynchronously with
each other, and

read mark
			clear mark
			store NULL
load entry

can't be prevented against for an RCU reader.

> How is RCU mark reading used anyhow?

We iterate over pages in the page cache with, eg, the dirty bit set.
This bug will lead to the loop terminating early and failing to find
dirty pages that it should.

> Actually the clearing of marks by xa_store(, NULL) is creating a very
> subtle bug in drivers/infiniband/core/device.c :( Can you add a Fixes
> line too:
> 
> ib_set_client_data() is assuming the marks for the entry will not
> change, but if the caller passed in NULL they get wrongly reset, and
> three call sites pass in NULL:
>  drivers/infiniband/ulp/srpt/ib_srpt.c
>  net/rds/ib.c
>  net/smc/smc_ib.c
> Fixes: 0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")

There's no bug here.

If you're actually storing NULL in the array, then the marks would go
away.  That's inherent -- imagine you have an array with a single entry
at 64.  Then you store NULL there.  That causes the node to be deleted,
and the marks must necessarily disappear with it -- there's nowhere to
store them!

But you aren't storing NULL in the array.  I mean, you think you are,
and if you load back the entry from the array, you'll get a NULL.
But this is an allocating array, and so when you go to store NULL in
the array it _actually_ stores an XA_ZERO_ENTRY.  Which is converted
back to NULL when you load it.

You have to call xa_erase() to make an entry disappear from an allocating
array.  Just storing NULL isn't going to do it.
