Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCDF606269
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJTOEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 10:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJTOET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202B51D6A64
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666274652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9nCYnpDiF6jG8sTPBwmH96ryJf+ugRaTkdwBFuQTVY4=;
        b=epg4c/xL4iGpUPIyjIT2WEw2VjzPhhlswHjMCgXOnSIlUros6dzGSmbw3bOOlzNrqEa47N
        4tRWp8CleZz1CydqiJD/AoM8fK9fd1s2a4S4QYxF6eDhZLWyZyfBvNlut3Etj4dR0xT8v9
        c40DQZvj4x+FbrHles7bCBPy9KMR87M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-3ruEITnrN6ywsi0u79TsCA-1; Thu, 20 Oct 2022 10:04:04 -0400
X-MC-Unique: 3ruEITnrN6ywsi0u79TsCA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 603E9858282;
        Thu, 20 Oct 2022 14:03:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D84B40315C;
        Thu, 20 Oct 2022 14:03:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y01VjOE2RrLVA2T6@infradead.org>
References: <Y01VjOE2RrLVA2T6@infradead.org> <1762414.1665761217@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        willy@infradead.org, dchinner@redhat.com,
        Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: How to convert I/O iterators to iterators, sglists and RDMA lists
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1415914.1666274636.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 20 Oct 2022 15:03:56 +0100
Message-ID: <1415915.1666274636@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> >  (1) Async direct I/O.
> > =

> >      In the async case direct I/O, we cannot hold on to the iterator w=
hen we
> >      return, even if the operation is still in progress (ie. we return
> >      EIOCBQUEUED), as it is likely to be on the caller's stack.
> > =

> >      Also, simply copying the iterator isn't sufficient as virtual use=
rspace
> >      addresses cannot be trusted and we may have to pin the pages that
> >      comprise the buffer.
> =

> This is very related to the discussion we are having related to pinning
> for O_DIRECT with Ira and Al.

Do you have a link to that discussion?  I don't see anything obvious on
fsdevel including Ira.

I do see a discussion involving iov_iter_pin_pages, but I don't see Ira
involved in that.

> What block file systems do is to take the pages from the iter and some f=
lags
> on what is pinned.  We can generalize this to store all extra state in a
> flags word, or byte the bullet and allow cloning of the iter in one form=
 or
> another.

Yeah, I know.  A list of pages is not an ideal solution.  It can only hand=
le
contiguous runs of pages, possibly with a partial page at either end.  A b=
vec
iterator would be of more use as it can handle a series of partial pages.

Note also that I would need to turn the pages *back* into an iterator in o=
rder
to commune with sendmsg() in the nether reaches of some network filesystem=
s.

> >  (2) Crypto.
> > =

> >      The crypto interface takes scatterlists, not iterators, so we nee=
d to
> >      be able to convert an iterator into a scatterlist in order to do
> >      content encryption within netfslib.  Doing this in netfslib makes=
 it
> >      easier to store content-encrypted files encrypted in fscache.
> =

> Note that the scatterlist is generally a pretty bad interface.  We've
> been talking for a while to have an interface that takes a page array
> as an input and return an array of { dma_addr, len } tuples.  Thinking
> about it taking in an iter might actually be an even better idea.

It would be nice to be able to pass an iterator to the crypto layer.  I'm =
not
sure what the crypto people think of that.

> >  (3) RDMA.
> > =

> >      To perform RDMA, a buffer list needs to be presented as a QPE arr=
ay.
> >      Currently, cifs converts the iterator it is given to lists of pag=
es,
> >      then each list to a scatterlist and thence to a QPE array.  I hav=
e
> >      code to pass the iterator down to the bottom, using an intermedia=
te
> >      BVEC iterator instead of a page list if I can't pass down the
> >      original directly (eg. an XARRAY iterator on the pagecache), but =
I
> >      still end up converting it to a scatterlist, which is then conver=
ted
> >      to a QPE.  I'm trying to go directly from an iterator to a QPE ar=
ray,
> >      thus avoiding the need to allocate an sglist.
> =

> I'm not sure what you mean with QPE.  The fundamental low-level
> interface in RDMA is the ib_sge.

Sorry, yes. ib_sge array.  I think it appears as QPs on the wire.

> If you feed it to RDMA READ/WRITE requests the interface for that is the
> RDMA R/W API in drivers/infiniband/core/rw.c, which currently takes a
> scatterlist but to which all of the above remarks on DMA interface apply=
.
> For RDMA SEND that ULP has to do a dma_map_single/page to fill it, which=
 is
> a quite horrible layering violation and should move into the driver, but
> that is going to a massive change to the whole RDMA subsystem, so unlike=
ly
> to happen anytime soon.

In cifs, as it is upstream, in RDMA transmission, the iterator is converte=
d
into a clutch of pages in the top, which is converted back into iterators
(smbd_send()) and those into scatterlists (smbd_post_send_data()), thence =
into
sge lists (see smbd_post_send_sgl()).

I have patches that pass an iterator (which it decants to a bvec if async)=
 all
the way down to the bottom layer.  Snippets are then converted to scatterl=
ists
and those to sge lists.  I would like to skip the scatterlist intermediate=
 and
convert directly to sge lists.

On the other hand, if you think the RDMA API should be taking scatterlists
rather than sge lists, that would be fine.  Even better if I can just pass=
 an
iterator in directly - though neither scatterlist nor iterator has a place=
 to
put the RDMA local_dma_key - though I wonder if that's actually necessary =
for
each sge element, or whether it could be handed through as part of the req=
uest
as a hole.

> Neither case has anything to do with what should be in common iov_iter
> code, all this needs to live in the RDMA subsystem as a consumer.

That's fine in principle.  However, I have some extraction code that can
convert an iterator to another iterator, an sglist or an rdma sge list, us=
ing
a common core of code to do all three.

I can split it up if that is preferable.

Do you have code that's ready to be used?  I can make immediate use of it.

David

