Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34956330A0C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 10:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCHJOR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 04:14:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229922AbhCHJOI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615194847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWnNUTDO1hly14NTXoKrUQ+xczjUU5YkbfVHZZK6bcA=;
        b=MHKbHGC/1VQ6/6g/ooW/T7uM86qIM0l4OlC8CRhowwZ6zTPgU0x4imH881W82Hjp/Nojq0
        NxwMYF4/UJ78P5CkeZanuJHUnW5u/vW6MUiKYqcMiEfCpfNJ8OWR7mvI1pveSytQ97Vps2
        lFfg+XUzPjO1umyyAUKMvT71jSlmdNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-L_eZHGN_Ph2p8Nw_BC8gZQ-1; Mon, 08 Mar 2021 04:14:05 -0500
X-MC-Unique: L_eZHGN_Ph2p8Nw_BC8gZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92E7C1084C95;
        Mon,  8 Mar 2021 09:14:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-79.rdu2.redhat.com [10.10.112.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE6B36267B;
        Mon,  8 Mar 2021 09:13:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOQ4uxhxwKHLT559f8v5aFTheKgPUndzGufg0E58rkEqa9oQ3Q@mail.gmail.com>
References: <CAOQ4uxhxwKHLT559f8v5aFTheKgPUndzGufg0E58rkEqa9oQ3Q@mail.gmail.com> <2653261.1614813611@warthog.procyon.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: fscache: Redesigning the on-disk cache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <517183.1615194835.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 08 Mar 2021 09:13:55 +0000
Message-ID: <517184.1615194835@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> wrote:

> >  (0a) As (0) but using SEEK_DATA/SEEK_HOLE instead of bmap and opening=
 the
> >       file for every whole operation (which may combine reads and writ=
es).
> =

> I read that NFSv4 supports hole punching, so when using ->bmap() or SEEK=
_DATA
> to keep track of present data, it's hard to distinguish between an
> invalid cached range and a valid "cached hole".

I wasn't exactly intending to permit caching over NFS.  That leads to fun
making sure that the superblock you're caching isn't the one that has the
cache in it.

However, we will need to handle hole-punching being done on a cached netfs=
,
even if that's just to completely invalidate the cache for that file.

> With ->fiemap() you can at least make the distinction between a non exis=
ting
> and an UNWRITTEN extent.

I can't use that for XFS, Ext4 or btrfs, I suspect.  Christoph and Dave's
assertion is that the cache can't rely on the backing filesystem's metadat=
a
because these can arbitrarily insert or remove blocks of zeros to bridge o=
r
split extents.

> You didn't say much about crash consistency or durability requirements o=
f the
> cache. Since cachefiles only syncs the cache on shutdown, I guess you
> rely on the hosting filesystem to provide the required ordering guarante=
es.

There's an xattr on each file in the cache to record the state.  I use thi=
s
mark a cache file "open".  If, when I look up a file, the file is marked o=
pen,
it is just discarded at the moment.

Now, there are two types of data stored in the cache: data that has to be
stored as a single complete blob and is replaced as such (e.g. symlinks an=
d
AFS dirs) and data that might be randomly modified (e.g. regular files).

For the former, I have code, though in yet another branch, that writes thi=
s in
a tmpfile, sets the xattrs and then uses vfs_link(LINK_REPLACE) to cut ove=
r.

For the latter, that's harder to do as it would require copying the data t=
o
the tmpfile before we're allowed to modify it.  However, if it's possible =
to
create a tmpfile that's a CoW version of a data file, I could go down that
route.

But after I've written and sync'd the data, I set the xattr to mark the fi=
le
not open.  At the moment I'm doing this too lazily, only doing it when a n=
etfs
file gets evicted or when the cache gets withdrawn, but I really need to a=
dd a
queue of objects to be sealed as they're closed.  The balance is working o=
ut
how often to do the sealing as something like a shell script can do a lot =
of
consecutive open/write/close ops.

> How does this work with write through network fs cache if the client sys=
tem
> crashes but the write gets to the server?

The presumption is that the coherency info on the server will change, but
won't get updated in the cache.

> Client system get restart with older cached data because disk caches wer=
e
> not flushed before crash. Correct?  Is that case handled? Are the caches
> invalidated on unclean shutdown?

The netfs provides some coherency info for the cache to store.  For AFS, f=
or
example, this is the data version number (though it should probably includ=
e
the volume creation time too).  This is stored with the state info in the =
same
xattr and is only updated when the "open" state is cleared.

When the cache file is reopened, if the coherency info doesn't match what
we're expecting (presumably we queried the server), the file is discarded.

(Note that the coherency info is netfs-specific)

> Anyway, how are those ordering requirements going to be handled when ent=
ire
> indexing is in a file? You'd practically need to re-implement a filesyst=
em

Yes, the though has occurred to me too.  I would be implementing a "simple=
"
filesystem - and we have lots of those:-/.  The most obvious solution is t=
o
use the backing filesystem's metadata - except that that's not possible.

> journal or only write cache updates to a temp file that can be discarded=
 at
> any time?

It might involve keeping a bitmap of "open" blocks.  Those blocks get
invalidated when the cache restarts.  The simplest solution would be to wi=
pe
the entire cache in such a situation, but that goes against one of the
important features I want out of it.

Actually, a journal of open and closed blocks might be better, though all =
I
really need to store for each block is a 32-bit number.

It's a particular problem if I'm doing DIO to the data storage area but
buffering the changes to the metadata.  Further, the metadata and data mig=
ht
be on different media, just to add to the complexity.

Another possibility is only to cull blocks when the parent file is culled.
That probably makes more sense as, as long as the file is registered culle=
d on
disk first and I don't reuse the file slot too quickly, I can write to the
data store before updating the metadata.

> If you come up with a useful generic implementation of a "file data
> overlay", overlayfs could also use it for "partial copy up" as well as f=
or
> implementation of address space operations, so please keep that in mind.

I'm trying to implement things so that the netfs does look-aside when read=
ing,
and multi-destination write-back when writing - but the netfs is in the
driving seat and the cache is invisible to the user.  I really want to avo=
id
overlaying the cache on the netfs so that the cache is the primary access
point.

David

