Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77E5149C3F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2020 19:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgAZST7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jan 2020 13:19:59 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34528 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAZST7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jan 2020 13:19:59 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 484FD58FB25; Sun, 26 Jan 2020 13:19:58 -0500 (EST)
Date:   Sun, 26 Jan 2020 13:19:58 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Andreas Dilger <adilger@dilger.ca>, Christoph Hellwig <hch@lst.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with determining data presence by examining extents?
Message-ID: <20200126181958.GP13306@hungrycats.org>
References: <7233E240-8EE5-4CD1-B8A4-A90925F51A1B@dilger.ca>
 <C0F67EC5-7B5D-4179-9F28-95B84D9CC326@dilger.ca>
 <4467.1579020509@warthog.procyon.org.uk>
 <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com>
 <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca>
 <afa71c13-4f99-747a-54ec-579f11f066a0@gmx.com>
 <20200115133101.GA28583@lst.de>
 <23762.1579121702@warthog.procyon.org.uk>
 <7026.1579129743@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MWF3YmTHhoLNIVQC"
Content-Disposition: inline
In-Reply-To: <7026.1579129743@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--MWF3YmTHhoLNIVQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 11:09:03PM +0000, David Howells wrote:
> Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> > > It would also have to say that blocks of zeros shouldn't be optimised=
 away.
> >=20
> > I don't necessarily see that as a requirement, so long as the filesystem
> > stores a "block" at that offset, but it could dedupe all zero-filled bl=
ocks
> > to the same "zero block".  That still allows saving storage space, while
> > keeping the semantics of "this block was written into the file" rather =
than
> > "there is a hole at this offset".
>=20
> Yeah, that's more what I was thinking of.  Provided I can find out that
> something is present, it should be fine.

I'm curious how this proposal handles an application punching a hole
through the cache?  Does that get cached, or does that operation have
to be synchronous with the server?  Or is it a moot point because no
server supports hole punching, so it gets replaced with equivalent zero
block data writes?

Zero blocks are stupidly common on typical user data corpuses, and a
naive block-oriented deduper can create monster extents with millions
or even billions of references if it doesn't have some special handling
for zero blocks.  Even if they don't trigger filesystem performance bugs
or hit RAM or other implementation limits, it's still bigger and slower
to use zero-filled data blocks than just using holes for zero blocks.

In the bees deduper for btrfs, zero blocks get replaced with holes
unconditionally in uncompressed extents, and in compressed extents if the
extent consists entirely of zeros (a long run of zero bytes is compressed
to a few bits by all supported compression algorithms, and hole metdata
is much larger than a few bits, so no gain is possible if anything less
than the entire compressed extent is eliminated).  That behavior could
be adjusted to support this use case, as a non-default user option.

For defrag a similar optimization is possible:  read a long run of
consecutive zero data blocks, write a prealloc extent.  I don't know of
anyone doing that in real life, but it would play havoc with anything
trying to store information in FIEMAP data (or related ioctls like
GETFSMAP or TREE_SEARCH).

I think an explicit dirty-cache-data metadata structure is a good idea
despite implementation complexity.  It would eliminate dependencies on
non-portable filesystem behavior, and not abuse a facility that might
already be in active (ab)use by other existing things.  If you have
a writeback cache, you need to properly control write ordering with a
purpose-built metadata structure, or fsync() will be meaningless through
your caching layer, and after a crash you'll upload whatever confused,
delalloc-reordered, torn-written steaming crap is on the local disk to
the backing store.

> David
>=20

--MWF3YmTHhoLNIVQC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXi3YRQAKCRCB+YsaVrMb
nLh/AKCKROfCfR3bfjq2IRp4N8QY4UV7mACg5qRzLwLGYnW9Jw7yYndPU4v2i58=
=St1d
-----END PGP SIGNATURE-----

--MWF3YmTHhoLNIVQC--
