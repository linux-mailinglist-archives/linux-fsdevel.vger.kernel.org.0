Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1FD132E30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 19:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgAGSQc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 13:16:32 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40270 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgAGSQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:16:32 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 306E756028F; Tue,  7 Jan 2020 13:16:31 -0500 (EST)
Date:   Tue, 7 Jan 2020 13:16:31 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/2] Btrfs: make deduplication with range including the
 last block work
Message-ID: <20200107181630.GB24056@hungrycats.org>
References: <20191216182656.15624-1-fdmanana@kernel.org>
 <20191216182656.15624-3-fdmanana@kernel.org>
 <20191229052240.GG13306@hungrycats.org>
 <CAL3q7H5FcdsA3NEcRae4iE5k8j8tHe-3KjKo_tTg6=fu0c_0gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <CAL3q7H5FcdsA3NEcRae4iE5k8j8tHe-3KjKo_tTg6=fu0c_0gw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 04:18:42PM +0000, Filipe Manana wrote:
> On Sun, Dec 29, 2019 at 5:22 AM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On Mon, Dec 16, 2019 at 06:26:56PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Since btrfs was migrated to use the generic VFS helpers for clone and
> > > deduplication, it stopped allowing for the last block of a file to be
> > > deduplicated when the source file size is not sector size aligned (wh=
en
> > > eof is somewhere in the middle of the last block). There are two reas=
ons
> > > for that:
> > >
> > > 1) The generic code always rounds down, to a multiple of the block si=
ze,
> > >    the range's length for deduplications. This means we end up never
> > >    deduplicating the last block when the eof is not block size aligne=
d,
> > >    even for the safe case where the destination range's end offset ma=
tches
> > >    the destination file's size. That rounding down operation is done =
at
> > >    generic_remap_check_len();
> > >
> > > 2) Because of that, the btrfs specific code does not expect anymore a=
ny
> > >    non-aligned range length's for deduplication and therefore does not
> > >    work if such nona-aligned length is given.
> > >
> > > This patch addresses that second part, and it depends on a patch that
> > > fixes generic_remap_check_len(), in the VFS, which was submitted eali=
er
> > > and has the following subject:
> > >
> > >   "fs: allow deduplication of eof block into the end of the destinati=
on file"
> > >
> > > These two patches address reports from users that started seeing lower
> > > deduplication rates due to the last block never being deduplicated wh=
en
> > > the file size is not aligned to the filesystem's block size.
> > >
> > > Link: https://lore.kernel.org/linux-btrfs/2019-1576167349.500456@svIo=
=2EN5dq.dFFD/
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > Should these patches be marked for stable (5.0+, but see below for
> > caveats about 5.0)?  The bug affects 5.3 and 5.4 which are still active,
> > and dedupe is an important feature for some users.
>=20
> Usually I only mark things for stable that are critical: corruptions,
> crashes and memory leaks for example.
> I don't think this is a critical issue, since none of those things
> happen. It's certainly inconvenient to not have
> an extent fully deduplicated, but it's just that.

In btrfs the reference counting is done by extent and extents are
immutable, so extents are either fully deduplicated, or not deduplicated
at all.  We have to dedupe every part of an extent, and if we fail to
do so, no data space is saved while metadata usage increases for the
new partial extent reference.

This bug means the dedupe feature is not usable _at all_ for single-extent
files with non-aligned EOF, and that is a significant problem for users
that rely on dedupe to manage space usage on btrfs (e.g. for build
servers where there are millions of duplicate odd-sized small files, and
the space savings from working dedupe can be 90% or more).  Doubling or
tripling space usage for the same data is beyond inconvenience.

It is possible to work around the bug in userspace and recover the space
with clone, but there is no way to do it safely on live data without a
working dedupe-range ioctl.

> If a maintainer wants to add it for stable, I'm fine with it.

At this point it would only affect 5.4--all the other short-term kernels
are closed, and none of the LTS kernels need the patch--but it would be
nice if 5.4 had working dedupe.

> >
> > > ---
> > >  fs/btrfs/ioctl.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > index 3418decb9e61..c41c276ff272 100644
> > > --- a/fs/btrfs/ioctl.c
> > > +++ b/fs/btrfs/ioctl.c
> > > @@ -3237,6 +3237,7 @@ static void btrfs_double_extent_lock(struct ino=
de *inode1, u64 loff1,
> > >  static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 =
len,
> > >                                  struct inode *dst, u64 dst_loff)
> > >  {
> > > +     const u64 bs =3D BTRFS_I(src)->root->fs_info->sb->s_blocksize;
> > >       int ret;
> > >
> > >       /*
> > > @@ -3244,7 +3245,7 @@ static int btrfs_extent_same_range(struct inode=
 *src, u64 loff, u64 len,
> > >        * source range to serialize with relocation.
> > >        */
> > >       btrfs_double_extent_lock(src, loff, dst, dst_loff, len);
> > > -     ret =3D btrfs_clone(src, dst, loff, len, len, dst_loff, 1);
> > > +     ret =3D btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_lo=
ff, 1);
> >
> > A heads-up for anyone backporting this to 5.0:  this patch depends on
> >
> >         57a50e2506df Btrfs: remove no longer needed range length checks=
 for deduplication
>=20
> For any kernel without that cleanup patch, backporting the first patch
> in the series (the one touching only fs/read_write.c) is enough.
> For any kernel with that cleanup patch, then both patches in the
> series are needed.
>=20
> Thanks.
>=20
> >
> > Simply resolving the git conflict without including 57a50e2506df produc=
es
> > a kernel where dedupe rounds the size of the dst file up to the next
> > block boundary.  This is because 57a50e2506df changes the value of
> > "len".  Before 57a50e2506df, "len" is equivalent to "ALIGN(len, bs)"
> > at the btrfs_clone line; after 57a50e2506df, "len" is the unaligned
> > dedupe request length passed to the btrfs_extent_same_range function.
> > This changes the semantics of the btrfs_clone line significantly.
> >
> > 57a50e2506df is in 5.1, so 5.1+ kernels do not require any additional
> > patches.
> >
> > 4.20 and earlier don't have the bug, so don't need a fix.
> >
> > >       btrfs_double_extent_unlock(src, loff, dst, dst_loff, len);
> > >
> > >       return ret;
> > > --
> > > 2.11.0
> > >
>=20

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXhTK/AAKCRCB+YsaVrMb
nDX5AKDCixhO+bYov3oH6QkygkXlvW6BbwCeJ5Bq6HXmpuBiVrm6RrXMA4HnyK0=
=6TDx
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
