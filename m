Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E839153FB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 09:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgBFIDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 03:03:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:59922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgBFIDJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:03:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6FD5FAF93;
        Thu,  6 Feb 2020 08:03:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6FE6D1E0E31; Thu,  6 Feb 2020 09:03:07 +0100 (CET)
Date:   Thu, 6 Feb 2020 09:03:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/8] xarray: Explicitely set XA_FREE_MARK in
 __xa_cmpxchg()
Message-ID: <20200206080307.GB14001@quack2.suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-4-jack@suse.cz>
 <20200205184512.GC28298@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205184512.GC28298@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-02-20 14:45:12, Jason Gunthorpe wrote:
> On Tue, Feb 04, 2020 at 03:25:09PM +0100, Jan Kara wrote:
> > __xa_cmpxchg() relies on xas_store() to set XA_FREE_MARK when storing
> > NULL into xarray that has free tracking enabled. Make the setting of
> > XA_FREE_MARK explicit similarly as its clearing currently it.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> >  lib/xarray.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/lib/xarray.c b/lib/xarray.c
> > index ae8b7070e82c..4e32497c51bd 100644
> > +++ b/lib/xarray.c
> > @@ -1477,8 +1477,12 @@ void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
> >  		curr = xas_load(&xas);
> >  		if (curr == old) {
> >  			xas_store(&xas, entry);
> > -			if (xa_track_free(xa) && entry && !curr)
> > -				xas_clear_mark(&xas, XA_FREE_MARK);
> > +			if (xa_track_free(xa)) {
> > +				if (entry && !curr)
> > +					xas_clear_mark(&xas, XA_FREE_MARK);
> > +				else if (!entry && curr)
> > +					xas_set_mark(&xas, XA_FREE_MARK);
> > +			}
> 
> This feels like an optimization that should also happen for
> __xa_store, which has very similar code:
> 
> 		curr = xas_store(&xas, entry);
> 		if (xa_track_free(xa))
> 			xas_clear_mark(&xas, XA_FREE_MARK);
> 
> Something like
> 
>                 if (xa_track_free(xa) && entry && !curr)
> 			xas_clear_mark(&xas, XA_FREE_MARK);
> 
> ?

Yeah, entry != NULL is guaranteed for __xa_store() (see how it transforms
NULL to XA_ZERO_ENTRY a few lines above) but !curr is probably a good
condition to add to save some unnecessary clearing when overwriting
existing values. It is unrelated to this patch though, just a separate
optimization so I'll add that as a separate patch to the series. Thanks for
the idea.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
