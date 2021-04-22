Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FE43682B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 16:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhDVOvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 10:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236019AbhDVOvv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 10:51:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B63461425;
        Thu, 22 Apr 2021 14:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619103076;
        bh=SABrBVqsF72QfA15qnobAparqW+KASuoIMcq/PiBNyQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ISEFHesJOLuYeLHcNDksC5KuWW+5nxW3X+DhvyEAmqF/uRFP5nQxuBuVn5L/aZiYr
         2Cy7HQg4cBmEOyWy/aD5GewKDQib2hy0QHxelQ3fbslJekhlOKA8Vv0qamHl/sHAaa
         zI+F9ko8twDY4PvNrgRcbc715vs98IxZn9EO2++8yAKRZVnQHsTjOXMbGsXu8pyu1S
         7yxSntGlu+TorOs1Ps6BNrZ3UsK/LoNdK7xyDZJxRVyc4X1GriKhZAIkVarearMkBS
         Ex8eq+2aZnRgx41OlNE2DBmA2pe7SPgzHIlqYkoZljNTB+4QBRADLXV1hfqWwTv8f7
         U/aewDPyMcKtQ==
Message-ID: <95de6e0ff902903cfc8825a4e0b7f1c64594630f.camel@kernel.org>
Subject: Re: [PATCH v6 01/30] iov_iter: Add ITER_XARRAY
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 22 Apr 2021 10:51:13 -0400
In-Reply-To: <2293710.1619099492@warthog.procyon.org.uk>
References: <27c369a8f42bb8a617672b2dc0126a5c6df5a050.camel@kernel.org>
         <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
         <161789064740.6155.11932541175173658065.stgit@warthog.procyon.org.uk>
         <2293710.1619099492@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-04-22 at 14:51 +0100, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
> 
> > As a general note, iov_iter.c could really do with some (verbose)
> > comments explaining things. A kerneldoc header that explains the
> > arguments to iterate_all_kinds would sure make this easier to review.
> 
> Definitely.  But that really requires a separate patch.
> 

I suppose.

> > > @@ -1126,7 +1199,12 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
> > >  		return;
> > >  	}
> > >  	unroll -= i->iov_offset;
> > > -	if (iov_iter_is_bvec(i)) {
> > > +	if (iov_iter_is_xarray(i)) {
> > > +		BUG(); /* We should never go beyond the start of the specified
> > > +			* range since we might then be straying into pages that
> > > +			* aren't pinned.
> > > +			*/
> > 
> > It's not needed now, but there are a lot of calls to iov_iter_revert in
> > the kernel, and going backward doesn't necessarily mean we'd be straying
> > into an unpinned range. xarray_start never changes; would it not be ok
> > to allow reverting as long as you don't move to a lower offset than that
> > point?
> 
> This is handled starting a couple of lines above the start of the hunk:
> 
> 	if (unroll <= i->iov_offset) {
> 		i->iov_offset -= unroll;
> 		return;
> 	}
> 
> As long as the amount you want to unroll by doesn't exceed the amount you've
> consumed of the iterator, it will allow you to do it.  The BUG is there to
> catch someone attempting to over-revert (and there's no way to return an
> error).
> 

Ahh thanks. I misread that bit. That makes sense. Sucks about having to
BUG() there, but I'm not sure what else you can do.

> > > +static ssize_t iter_xarray_copy_pages(struct page **pages, struct xarray *xa,
> > > +				       pgoff_t index, unsigned int nr_pages)
> > 
> > nit: This could use a different name -- I was expecting to see page
> > _contents_ copied here, but it's just populating the page array with
> > pointers.
> 
> Fair point.  Um...  how about iter_xarray_populate_pages() or
> iter_xarray_list_pages()?
> 

I like "populate" better.

> > I think you've planned to remove iov_iter_for_each_range as well? I'll
> > assume that this is going away. It might be nice to post the latest
> > version of this patch with that change, just for posterity.
> 
> I'll put that in a separate patch.
> 
> > In any case, this all looks reasonable to me, modulo a few nits and a
> > general dearth of comments.
> > 
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 
> Thanks,
> David
> 

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

