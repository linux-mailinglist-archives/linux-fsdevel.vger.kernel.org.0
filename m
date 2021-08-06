Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D433E2BC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 15:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344365AbhHFNnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 09:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344325AbhHFNnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628257369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7thEIdn3uQfSfpiv9JfERg3aXycT77hyEyLdlaCx5tA=;
        b=dIm+eD+WvIe04AAFnfFhjF5tJ52suPTywCX+yUTfyq2aGvHdflqoNBYQuitdjQXKmfSGvt
        i9RMfWO0CGV+4tI8KFYYoD9N/Z2yBWMqcw9tuc8Kbl+STIUPD1KQ5kI8d7t/87zJQKCXS7
        EB1kVqi+VyRBh2ZMmh0KT4NvI2zMO78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-BiOv2USdOOOPtwWmafxTSQ-1; Fri, 06 Aug 2021 09:42:48 -0400
X-MC-Unique: BiOv2USdOOOPtwWmafxTSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9B688B5D61;
        Fri,  6 Aug 2021 13:42:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15ACD5C1B4;
        Fri,  6 Aug 2021 13:42:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YQxh/G0xGl3GtC8y@casper.infradead.org>
References: <YQxh/G0xGl3GtC8y@casper.infradead.org> <YQv+iwmhhZJ+/ndc@casper.infradead.org> <YQvpDP/tdkG4MMGs@casper.infradead.org> <YQvbiCubotHz6cN7@casper.infradead.org> <1017390.1628158757@warthog.procyon.org.uk> <1170464.1628168823@warthog.procyon.org.uk> <1186271.1628174281@warthog.procyon.org.uk> <1219713.1628181333@warthog.procyon.org.uk> <CAHk-=wjyEk9EuYgE3nBnRCRd_AmRYVOGACEjt0X33QnORd5-ig@mail.gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@redhat.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Canvassing for network filesystem write size vs page size
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1302670.1628257357.1@warthog.procyon.org.uk>
Date:   Fri, 06 Aug 2021 14:42:37 +0100
Message-ID: <1302671.1628257357@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > It's fairly important to be able to do streaming writes without having
> > to read the old contents for some loads. And read-modify-write cycles
> > are death for performance, so you really want to coalesce writes until
> > you have the whole page.
> 
> I completely agree with you.  The context you're missing is that Dave
> wants to do RMW twice.  He doesn't do the delaying SetPageUptodate dance.

Actually, I do the delaying of SetPageUptodate in the new write helpers that
I'm working on - at least to some extent.  For a write of any particular size
(which may be more than a page), I only read the first and last pages affected
if they're not completely changed by the write.  Note that I have my own
version of generic_perform_write() that allows me to eliminate write_begin and
write_end for any filesystem using it.

Keeping track of which regions are dirty allows merging of contiguous dirty
regions.

It has occurred to me that I don't actually need the pages to be uptodate and
completely filled out.  I'm tracking which bits are dirty - I could defer
reading the missing bits till someone wants to read or mmap.

But that kind of screws with local caching.  The local cache might need to
track the missing bits, and we are likely to be using blocks larger than a
page.

Basically, there are a lot of scenarios where not having fully populated pages
sucks.  And for streaming writes, wouldn't it be better if you used DIO
writes?

> If the write is less than the whole page, AFS, Ceph and anybody else
> using netfs_write_begin() will first read the entire page in and mark
> it Uptodate.

Indeed - but that function is set to be replaced.  What you're missing is that
if someone then tries to read the partially modified page, you may have to do
two reads from the server.

> Then he wants to track which parts of the page are dirty (at byte
> granularity) and send only those bytes to the server in a write request.

Yes.  Because other constraints may apply, for example the handling of
conflicting third-party writes.  The question here is how much we care about
that - and that's why I'm trying to write back only what's changed where
possible.

That said, if content encryption is thrown into the mix, the minimum we can
write back is whatever the size of the blocks on which encryption is
performed, so maybe we shouldn't care.

Add disconnected operation reconnection resolution, where it might be handy to
have a list of what changed on a file.

> So it's worst of both worlds; first the client does an RMW, then the
> server does an RMW (assuming the client's data is no longer in the
> server's cache.

Actually, it's not necessarily what you make out.  You have to compare the
server-side RMW with cost of setting up a read or a write operation.

And then there's this scenario:  Imagine I'm going to modify the middle of a
page which doesn't yet exist.  I read the bit at the beginning and the bit at
the end and then try to fill the middle, but now get an EFAULT error.  I'm
going to have to do *three* reads if someone wants to read the page.

> The NFS code moves the RMW from the client to the server, and that makes
> a load of sense.

No, it very much depends.  It might suck if you have the folio partly cached
locally in fscache, and it doesn't work if you have content encryption and
would suck if you're doing disconnected operation.

I presume you're advocating that the change is immediately written to the
server, and then you read it back from the server?

> > That said, I suspect it's also *very* filesystem-specific, to the
> > point where it might not be worth trying to do in some generic manner.
> 
> It certainly doesn't make sense for block filesystems.  Since they
> can only do I/O on block boundaries, a sub-block write has to read in
> the surrounding block, and once you're doing that, you might as well
> read in the whole page.

I'm not trying to do this for block filesystems!  However, a block filesystem
- or even a blockdev - might be involved in terms of the local cache.

> Tracking sub-page dirty bits still makes sense.  It's on my to-do
> list for iomap.

/me blinks

"bits" as in parts of a page or "bits" as in the PG_dirty bits on the pages
contributing to a folio?

> > [ goes off and looks. See "nfs_write_begin()" and friends in
> > fs/nfs/file.c for some of the examples of these things, althjough it
> > looks like the code is less aggressive about avoding the
> > read-modify-write case than I thought I remembered, and only does it
> > for write-only opens ]
> 
> NFS is missing one trick; it could implement aops->is_partially_uptodate
> and then it would be able to read back bytes that have already been
> written by this client without writing back the dirty ranges and fetching
> the page from the server.

As mentioned above, I have been considering the possibility of keeping track
of partially dirty non-uptodate pages.  Jeff and I have been discussing that
we might want support for explicit RMW anyway for various reasons (e.g. doing
DIO that's not crypto-block aligned,
remote-invalidation/reconnection-resolution handling).

David

