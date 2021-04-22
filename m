Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61B03681E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 15:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhDVNw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 09:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236414AbhDVNwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619099505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JGmS/xLoW189jty2r0t6cwkKx1CTQrOOThGSNPhaRfs=;
        b=JIalaxZqb7qBarpDnOuqCfMkqjRuo4ecr8Rxy+StDC9sYKvT9rTAULMSbQB2tkNpA8BgI+
        rZC1SrNqwJqS2iLdPrHM+tPH0GJqi36to9dvE7DHpt/giI+SmT/N9M1uZGtjX3iSPMjmnQ
        OOKZmqHP1KoEZw8KGxVAz9cmCKEIrP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-D-9gXEBGPL-JfVdk-rKe9g-1; Thu, 22 Apr 2021 09:51:42 -0400
X-MC-Unique: D-9gXEBGPL-JfVdk-rKe9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7A82107ACF6;
        Thu, 22 Apr 2021 13:51:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0935760938;
        Thu, 22 Apr 2021 13:51:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <27c369a8f42bb8a617672b2dc0126a5c6df5a050.camel@kernel.org>
References: <27c369a8f42bb8a617672b2dc0126a5c6df5a050.camel@kernel.org> <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk> <161789064740.6155.11932541175173658065.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
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
Subject: Re: [PATCH v6 01/30] iov_iter: Add ITER_XARRAY
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2293709.1619099492.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 22 Apr 2021 14:51:32 +0100
Message-ID: <2293710.1619099492@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> As a general note, iov_iter.c could really do with some (verbose)
> comments explaining things. A kerneldoc header that explains the
> arguments to iterate_all_kinds would sure make this easier to review.

Definitely.  But that really requires a separate patch.

> > @@ -1126,7 +1199,12 @@ void iov_iter_revert(struct iov_iter *i, size_t=
 unroll)
> >  		return;
> >  	}
> >  	unroll -=3D i->iov_offset;
> > -	if (iov_iter_is_bvec(i)) {
> > +	if (iov_iter_is_xarray(i)) {
> > +		BUG(); /* We should never go beyond the start of the specified
> > +			* range since we might then be straying into pages that
> > +			* aren't pinned.
> > +			*/
> =

> It's not needed now, but there are a lot of calls to iov_iter_revert in
> the kernel, and going backward doesn't necessarily mean we'd be straying
> into an unpinned range. xarray_start never changes; would it not be ok
> to allow reverting as long as you don't move to a lower offset than that
> point?

This is handled starting a couple of lines above the start of the hunk:

	if (unroll <=3D i->iov_offset) {
		i->iov_offset -=3D unroll;
		return;
	}

As long as the amount you want to unroll by doesn't exceed the amount you'=
ve
consumed of the iterator, it will allow you to do it.  The BUG is there to
catch someone attempting to over-revert (and there's no way to return an
error).

> > +static ssize_t iter_xarray_copy_pages(struct page **pages, struct xar=
ray *xa,
> > +				       pgoff_t index, unsigned int nr_pages)
> =

> nit: This could use a different name -- I was expecting to see page
> _contents_ copied here, but it's just populating the page array with
> pointers.

Fair point.  Um...  how about iter_xarray_populate_pages() or
iter_xarray_list_pages()?

> I think you've planned to remove iov_iter_for_each_range as well? I'll
> assume that this is going away. It might be nice to post the latest
> version of this patch with that change, just for posterity.

I'll put that in a separate patch.

> In any case, this all looks reasonable to me, modulo a few nits and a
> general dearth of comments.
> =

> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks,
David

