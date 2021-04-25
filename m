Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20F336A7A0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 15:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhDYN67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 09:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230286AbhDYN64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 09:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619359096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tkR6qD5kFFU7w0xAxQydFKnMtqNPY2fVynwZMz3s6nE=;
        b=fejcL2asGcdUY25j+zymd0preIZpfeWn8oDJOMWDn6qKkOFdlbqJtdfoBZnP2EpR+VypL1
        9E3PM9rYgsN/WBJVPfpW0Qxv+HDr1jPZuTu+U9sn/OGo3jXta4Evd6UMx8wd1t5NFNQXJa
        UbiYzNDbbv3GQPP4rLlgKPX2zAAEruY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-JCMVJMmJOvqSmTvfeS4GuA-1; Sun, 25 Apr 2021 09:58:12 -0400
X-MC-Unique: JCMVJMmJOvqSmTvfeS4GuA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95608DF8A3;
        Sun, 25 Apr 2021 13:58:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B9C06062F;
        Sun, 25 Apr 2021 13:58:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YIVrJT8GwLI0Wlgx@zeniv-ca.linux.org.uk>
References: <YIVrJT8GwLI0Wlgx@zeniv-ca.linux.org.uk> <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk> <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/31] iov_iter: Add ITER_XARRAY
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3388474.1619359082.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Sun, 25 Apr 2021 14:58:02 +0100
Message-ID: <3388475.1619359082@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> > +struct address_space;
> >  struct pipe_inode_info;
> >  =

> >  struct kvec {
> =

> What is that chunk for?

Ah, that can go.  It used to be ITER_MAPPING.

> > +		}),
> > +		({
> > +		rem =3D copy_mc_to_page(v.bv_page, v.bv_offset,
> > +				      (from +=3D v.bv_len) - v.bv_len, v.bv_len);
> > +		if (rem) {
> > +			curr_addr =3D (unsigned long) from;
> > +			bytes =3D curr_addr - s_addr - rem;
> > +			rcu_read_unlock();
> > +			return bytes;
> > +		}
> =

> That's broken, same way as kvec and bvec cases are in the same primitive=
.
> Iterator not advanced on failure halfway through.

Okay.  I just copied what ITER_BVEC does.  Should this be handled in
iterate_and_advance() rather than in the code snippets it takes as paramet=
ers?

But for the moment, I guess I should just add:

	i->iov_offset +=3D bytes;

to all three (kvec, bvec and xarray)?

> > @@ -1246,7 +1349,8 @@ unsigned long iov_iter_alignment(const struct io=
v_iter *i)
> >  	iterate_all_kinds(i, size, v,
> >  		(res |=3D (unsigned long)v.iov_base | v.iov_len, 0),
> >  		res |=3D v.bv_offset | v.bv_len,
> > -		res |=3D (unsigned long)v.iov_base | v.iov_len
> > +		res |=3D (unsigned long)v.iov_base | v.iov_len,
> > +		res |=3D v.bv_offset | v.bv_len
> >  	)
> >  	return res;
> >  }
> =

> Hmm...  That looks like a really bad overkill - do you need anything bey=
ond
> count and iov_offset in that case + perhaps "do we have the very last pa=
ge"?
> IOW, do you need to iterate anything at all here?  What am I missing her=
e?

Good point.  I wonder, even, if the alignment could just be set to 1.  The=
re's
no kdoc description on the function that says what the result is meant to
represent.

> > @@ -1268,7 +1372,9 @@ unsigned long iov_iter_gap_alignment(const struc=
t iov_iter *i)
> > ...
> Very limited use; it shouldn't be called for anything other than IOV_ITE=
R case.
Should that just be cut down, then?

> > @@ -1849,7 +2111,12 @@ int iov_iter_for_each_range(struct iov_iter *i,=
 size_t bytes,
> > ...
> =

> Would be easier to have that sucker removed first...

I could do that.  I'd rather not do that here since it hasn't sat in
linux-next, but since nothing uses it, but Linus might permit it.

David

