Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9357B6D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 14:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiGTMz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 08:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGTMz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A782C109;
        Wed, 20 Jul 2022 05:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 601A66157A;
        Wed, 20 Jul 2022 12:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C468C3411E;
        Wed, 20 Jul 2022 12:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658321725;
        bh=5Fgm9alDndUYTUlCuwSsvsSTsjxvA5LuweJkUppkAb4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Th3oaYWjsXjSqFBf9fz5IrELHWVI5E16xV2Vsd3Fk9SDZgr83ikg7bB0SvUoQ7hWm
         +LWBn807IIjnjLZecQO1v1yW9AI/UH3L9oLrQJPx9eoO8ZB+g7qUlXwHZqqVMuA136
         jlgto+KOjs8A9xdVKLuy2wUpf2RMZOhc5iSQAAGJtxoq+RZzQQKaWNF6fwO4L+70Sb
         BirInDcccUnHHF+yuPKPb6Vy8eCGfE+JkEKtOsjFHIsgl0SGUbfYyzPEvkV9yZ1A6L
         wXGf3cm4UtmR+AixeEBowmnVISHmPnEBp6/6F2LaTI84yIfkskrvum/86pa0gOdtl7
         3m7WDfvRk23/w==
Message-ID: <8122876aa3afe2b57d2c3153045d3e1936210b98.camel@kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Wed, 20 Jul 2022 08:55:23 -0400
In-Reply-To: <20220720023610.GN3600936@dread.disaster.area>
References: <20220715184433.838521-1-anna@kernel.org>
         <20220715184433.838521-7-anna@kernel.org>
         <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
         <20220718011552.GK3600936@dread.disaster.area>
         <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
         <20220719224434.GL3600936@dread.disaster.area>
         <CF981532-ADC0-43F9-A304-9760244A53D5@oracle.com>
         <20220720023610.GN3600936@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-07-20 at 12:36 +1000, Dave Chinner wrote:
> On Wed, Jul 20, 2022 at 01:26:13AM +0000, Chuck Lever III wrote:
> >=20
> >=20
> > > On Jul 19, 2022, at 6:44 PM, Dave Chinner <david@fromorbit.com> wrote=
:
> > >=20
> > > On Tue, Jul 19, 2022 at 04:46:50PM -0400, Anna Schumaker wrote:
> > > > On Sun, Jul 17, 2022 at 9:16 PM Dave Chinner <david@fromorbit.com> =
wrote:
> > > > >=20
> > > > > On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
> > > > > > > On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org>=
 wrote:
> > > > > > >=20
> > > > > > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > > > >=20
> > > > > > > Rather than relying on the underlying filesystem to tell us w=
here hole
> > > > > > > and data segments are through vfs_llseek(), let's instead do =
the hole
> > > > > > > compression ourselves. This has a few advantages over the old
> > > > > > > implementation:
> > > > > > >=20
> > > > > > > 1) A single call to the underlying filesystem through nfsd_re=
adv() means
> > > > > > >  the file can't change from underneath us in the middle of en=
coding.
> > > > >=20
> > > > > Hi Anna,
> > > > >=20
> > > > > I'm assuming you mean the vfs_llseek(SEEK_HOLE) call at the start
> > > > > of nfsd4_encode_read_plus_data() that is used to trim the data th=
at
> > > > > has already been read out of the file?
> > > >=20
> > > > There is also the vfs_llseek(SEEK_DATA) call at the start of
> > > > nfsd4_encode_read_plus_hole(). They are used to determine the lengt=
h
> > > > of the current hole or data segment.
> > > >=20
> > > > >=20
> > > > > What's the problem with racing with a hole punch here? All it doe=
s
> > > > > is shorten the read data returned to match the new hole, so all i=
t's
> > > > > doing is making the returned data "more correct".
> > > >=20
> > > > The problem is we call vfs_llseek() potentially many times when
> > > > encoding a single reply to READ_PLUS. nfsd4_encode_read_plus() has =
a
> > > > loop where we alternate between hole and data segments until we've
> > > > encoded the requested number of bytes. My attempts at locking the f=
ile
> > > > have resulted in a deadlock since vfs_llseek() also locks the file,=
 so
> > > > the file could change from underneath us during each iteration of t=
he
> > > > loop.
> > >=20
> > > So the problem being solved is that the current encoding is not
> > > atomic, rather than trying to avoid any computational overhead of
> > > multiple vfs_llseek calls (which are largely just the same extent
> > > lookups as we do during the read call)?
> >=20
> > Reviewing [1] and [2] I don't find any remarks about atomicity
> > guarantees. If a client needs an uncontended view of a file's
> > data, it's expected to fence other accessors via a OPEN(deny)
> > or LOCK operation, or serialize the requests itself.
>=20
> You've got the wrong "atomicity" scope :)
>=20
> What I was talking about is the internal server side data operation
> atomicity. that is, what is returned from the read to the READ_PLUS
> code is not atomic w.r.t. the vfs_llseek() that are then used to
> determine where there holes in the data returned by the read are.
>=20
> Hence after the read has returned data to READ_PLUS, something else
> can modify the data in the file (e.g. filling a hole or punching a
> new one out) and then the ranges vfs_llseek() returns to READ_PLUS
> does not match the data that is has in it's local buffer.
>=20
> i.e. to do what the READ_PLUS operation is doing now, it would
> somehow need to ensure no modifications can be made between the read
> starting and the last vfs_llseek() call completing. IOWs, they need
> to be performed as an atomic operation, not as a set of
> independently locked (or unlocked!) operations as they are now.
>=20
> > > The implementation just seems backwards to me - rather than reading
> > > data and then trying to work out where the holes are, I suspect it
> > > should be working out where the holes are and then reading the data.
> > > This is how the IO path in filesystems work, so it would seem like a
> > > no-brainer to try to leverage the infrastructure we already have to
> > > do that.
> > >=20
> > > The information is there and we have infrastructure that exposes it
> > > to the IO path, it's just *underneath* the page cache and the page
> > > cache destroys the information that it used to build the data it
> > > returns to the NFSD.
> > >=20
> > > IOWs, it seems to me that what READ_PLUS really wants is a "sparse
> > > read operation" from the filesystem rather than the current "read
> > > that fills holes with zeroes". i.e. a read operation that sets an
> > > iocb flag like RWF_SPARSE_READ to tell the filesystem to trim the
> > > read to just the ranges that contain data.
> > >=20
> > > That way the read populates the page cache over a single contiguous
> > > range of data and returns with the {offset, len} that spans the
> > > range that is read and mapped. The caller can then read that region
> > > out of the page cache and mark all the non-data regions as holes in
> > > whatever manner they need to.
> > >=20
> > > The iomap infrastructure that XFS and other filesystems use provide
> > > this exact "map only what contains data" capability - an iomap tells
> > > the page cache exactly what underlies the data range (hole, data,
> > > unwritten extents, etc) in an efficient manner, so it wouldn't be a
> > > huge stretch just to limit read IO ranges to those that contain only
> > > DATA extents.
> > >=20
> > > At this point READ_PLUS then just needs to iterate doing sparse
> > > reads and recording the ranges that return data as vector of some
> > > kind that is then passes to the encoding function to encode it as
> > > a sparse READ_PLUS data range....
> >=20
> > The iomap approach
>=20
> Not actually what I proposed - I'm suggesting a new kiocb flag that
> changes what the read passed to the filesystem does. My comments
> about iomap are that this infrastructure already provides the extent
> range query mechanisms that allow us to efficiently perform such
> "restricted range" IO operations.
>=20
> > seems sensible to me and covers the two basic
> > usage scenarios:
> >=20
> > - Large sparse files, where we want to conserve both network
> >   bandwidth and client (and intermediate) cache occupancy.
> >   These are best served by exposing data and holes.
>=20
> *nod*
>=20
> > - Everyday files that are relatively small and generally will
> >   continue few, if any, holes. These are best served by using
> >   a splice read (where possible) -- that is, READ_PLUS in this
> >   case should work exactly like READ.
>=20
> *nod*
>=20
> > My impression of client implementations is that, a priori,
> > a client does not know whether a file contains holes or not,
> > but will probably always use READ_PLUS and let the server
> > make the choice for it.
>=20
> *nod*
>=20
> > Now how does the server make that choice? Is there an attribute
> > bit that indicates when a file should be treated as sparse? Can
> > we assume that immutable files (or compressed files) should
> > always be treated as sparse? Alternately, the server might use
> > the file's data : hole ratio.
>=20
> None of the above. The NFS server has no business knowing intimate
> details about how the filesystem has laid out the file. All it cares
> about ranges containing data and ranges that have no data (holes).
>=20
> If the filesystem can support a sparse read, it returns sparse
> ranges containing data to the NFS server. If the filesystem can't
> support it, or it's internal file layout doesn't allow for efficient
> hole/data discrimination, then it can just return the entire read
> range.
>=20
> Alternatively, in this latter case, the filesystem could call a
> generic "sparse read" implementation that runs memchr_inv() to find
> the first data range to return. Then the NFS server doesn't have to
> code things differently, filesystems don't need to advertise
> support for sparse reads, etc because every filesystem could
> support sparse reads.
>=20
> The only difference is that some filesystems will be much more
> efficient and faster at it than others. We already see that sort
> of thing with btrfs and seek hole/data on large cached files so I
> don't see "filesystems perform differently" as a problem here...
>=20

^^^
This seems like more trouble than it's worth, and would probably result
in worse performance. The generic implementation should just return a
single non-sparse extent in the sparse read reply if it doesn't know how
to fill out a sparse read properly. IOW, we shouldn't try to find holes,
unless the underlying filesystem can do that itself via iomap sparse
read or some similar mechanism.
--=20
Jeff Layton <jlayton@kernel.org>
