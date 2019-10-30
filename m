Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F87EA78A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 00:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfJ3XLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 19:11:45 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:59846 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfJ3XLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 19:11:44 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 473PNG02vYzQlBY;
        Thu, 31 Oct 2019 00:11:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id qMXSaGYO4s9t; Thu, 31 Oct 2019 00:11:38 +0100 (CET)
Date:   Thu, 31 Oct 2019 10:11:27 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v2 2/5] fs: add RWF_ENCODED for reading/writing
 compressed data
Message-ID: <20191030231127.z3c4jb7ocxfd774h@yavin.dot.cyphar.com>
References: <cover.1571164762.git.osandov@fb.com>
 <7f98cf5409cf2b583cd5b3451fc739fd3428873b.1571164762.git.osandov@fb.com>
 <20191021182806.GA6706@magnolia>
 <20191021183831.mbe4q2beqo76fqxm@yavin.dot.cyphar.com>
 <20191021190010.GC6726@magnolia>
 <20191022020215.csdwgi3ky27rfidf@yavin.dot.cyphar.com>
 <20191030222601.GE326591@vader>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g5npfiseklp7ctvo"
Content-Disposition: inline
In-Reply-To: <20191030222601.GE326591@vader>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--g5npfiseklp7ctvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-30, Omar Sandoval <osandov@osandov.com> wrote:
> On Tue, Oct 22, 2019 at 01:02:15PM +1100, Aleksa Sarai wrote:
> > On 2019-10-21, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > On Tue, Oct 22, 2019 at 05:38:31AM +1100, Aleksa Sarai wrote:
> > > > On 2019-10-21, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > > On Tue, Oct 15, 2019 at 11:42:40AM -0700, Omar Sandoval wrote:
> > > > > > From: Omar Sandoval <osandov@fb.com>
> > > > > >=20
> > > > > > Btrfs supports transparent compression: data written by the use=
r can be
> > > > > > compressed when written to disk and decompressed when read back.
> > > > > > However, we'd like to add an interface to write pre-compressed =
data
> > > > > > directly to the filesystem, and the matching interface to read
> > > > > > compressed data without decompressing it. This adds support for
> > > > > > so-called "encoded I/O" via preadv2() and pwritev2().
> > > > > >=20
> > > > > > A new RWF_ENCODED flags indicates that a read or write is "enco=
ded". If
> > > > > > this flag is set, iov[0].iov_base points to a struct encoded_io=
v which
> > > > > > is used for metadata: namely, the compression algorithm, unenco=
ded
> > > > > > (i.e., decompressed) length, and what subrange of the unencoded=
 data
> > > > > > should be used (needed for truncated or hole-punched extents an=
d when
> > > > > > reading in the middle of an extent). For reads, the filesystem =
returns
> > > > > > this information; for writes, the caller provides it to the fil=
esystem.
> > > > > > iov[0].iov_len must be set to sizeof(struct encoded_iov), which=
 can be
> > > > > > used to extend the interface in the future. The remaining iovec=
s contain
> > > > > > the encoded extent.
> > > > > >=20
> > > > > > Filesystems must indicate that they support encoded writes by s=
etting
> > > > > > FMODE_ENCODED_IO in ->file_open().
> > > > > >=20
> > > > > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > > > > ---
> > > > > >  include/linux/fs.h      | 14 +++++++
> > > > > >  include/uapi/linux/fs.h | 26 ++++++++++++-
> > > > > >  mm/filemap.c            | 82 +++++++++++++++++++++++++++++++++=
+-------
> > > > > >  3 files changed, 108 insertions(+), 14 deletions(-)
> > > > > >=20
> > > > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > > > index e0d909d35763..54681f21e05e 100644
> > > > > > --- a/include/linux/fs.h
> > > > > > +++ b/include/linux/fs.h
> > > > > > @@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *io=
cb, loff_t offset,
> > > > > >  /* File does not contribute to nr_files count */
> > > > > >  #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
> > > > > > =20
> > > > > > +/* File supports encoded IO */
> > > > > > +#define FMODE_ENCODED_IO	((__force fmode_t)0x40000000)
> > > > > > +
> > > > > >  /*
> > > > > >   * Flag for rw_copy_check_uvector and compat_rw_copy_check_uve=
ctor
> > > > > >   * that indicates that they should check the contents of the i=
ovec are
> > > > > > @@ -314,6 +317,7 @@ enum rw_hint {
> > > > > >  #define IOCB_SYNC		(1 << 5)
> > > > > >  #define IOCB_WRITE		(1 << 6)
> > > > > >  #define IOCB_NOWAIT		(1 << 7)
> > > > > > +#define IOCB_ENCODED		(1 << 8)
> > > > > > =20
> > > > > >  struct kiocb {
> > > > > >  	struct file		*ki_filp;
> > > > > > @@ -3088,6 +3092,11 @@ extern int sb_min_blocksize(struct super=
_block *, int);
> > > > > >  extern int generic_file_mmap(struct file *, struct vm_area_str=
uct *);
> > > > > >  extern int generic_file_readonly_mmap(struct file *, struct vm=
_area_struct *);
> > > > > >  extern ssize_t generic_write_checks(struct kiocb *, struct iov=
_iter *);
> > > > > > +struct encoded_iov;
> > > > > > +extern int generic_encoded_write_checks(struct kiocb *, struct=
 encoded_iov *);
> > > > > > +extern ssize_t check_encoded_read(struct kiocb *, struct iov_i=
ter *);
> > > > > > +extern int import_encoded_write(struct kiocb *, struct encoded=
_iov *,
> > > > > > +				struct iov_iter *);
> > > > > >  extern int generic_remap_checks(struct file *file_in, loff_t p=
os_in,
> > > > > >  				struct file *file_out, loff_t pos_out,
> > > > > >  				loff_t *count, unsigned int remap_flags);
> > > > > > @@ -3403,6 +3412,11 @@ static inline int kiocb_set_rw_flags(str=
uct kiocb *ki, rwf_t flags)
> > > > > >  			return -EOPNOTSUPP;
> > > > > >  		ki->ki_flags |=3D IOCB_NOWAIT;
> > > > > >  	}
> > > > > > +	if (flags & RWF_ENCODED) {
> > > > > > +		if (!(ki->ki_filp->f_mode & FMODE_ENCODED_IO))
> > > > > > +			return -EOPNOTSUPP;
> > > > > > +		ki->ki_flags |=3D IOCB_ENCODED;
> > > > > > +	}
> > > > > >  	if (flags & RWF_HIPRI)
> > > > > >  		ki->ki_flags |=3D IOCB_HIPRI;
> > > > > >  	if (flags & RWF_DSYNC)
> > > > > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > > > > index 379a612f8f1d..ed92a8a257cb 100644
> > > > > > --- a/include/uapi/linux/fs.h
> > > > > > +++ b/include/uapi/linux/fs.h
> > > > > > @@ -284,6 +284,27 @@ struct fsxattr {
> > > > > > =20
> > > > > >  typedef int __bitwise __kernel_rwf_t;
> > > > > > =20
> > > > > > +enum {
> > > > > > +	ENCODED_IOV_COMPRESSION_NONE,
> > > > > > +	ENCODED_IOV_COMPRESSION_ZLIB,
> > > > > > +	ENCODED_IOV_COMPRESSION_LZO,
> > > > > > +	ENCODED_IOV_COMPRESSION_ZSTD,
> > > > > > +	ENCODED_IOV_COMPRESSION_TYPES =3D ENCODED_IOV_COMPRESSION_ZST=
D,
> > > > > > +};
> > > > > > +
> > > > > > +enum {
> > > > > > +	ENCODED_IOV_ENCRYPTION_NONE,
> > > > > > +	ENCODED_IOV_ENCRYPTION_TYPES =3D ENCODED_IOV_ENCRYPTION_NONE,
> > > > > > +};
> > > > > > +
> > > > > > +struct encoded_iov {
> > > > > > +	__u64 len;
> > > > > > +	__u64 unencoded_len;
> > > > > > +	__u64 unencoded_offset;
> > > > > > +	__u32 compression;
> > > > > > +	__u32 encryption;
> > > > >=20
> > > > > Can we add some must-be-zero padding space at the end here for wh=
omever
> > > > > comes along next wanting to add more encoding info?
> > > >=20
> > > > I would suggest to copy the extension design of copy_struct_from_us=
er().
> > > > Adding must-be-zero padding is a less-ideal solution to the extensi=
on
> > > > problem than length-based extension.
> > >=20
> > > Come to think of it, you /do/ have to specify iov_len so... yeah, do
> > > that instead; we can always extend the structure later.
> >=20
> > Just to clarify -- if we want to make the interface forward-compatible
> > from the outset (programs built 4 years from now running on 5.5), we
> > will need to implement this in the original merge. Otherwise userspace
> > will need to handle backwards-compatibility themselves once new features
> > are added.
> >=20
> > @Omar: If it'd make your life easier, I can send some draft patches
> > 	   which port copy_struct_from_user() to iovec-land.
>=20
> You're right, I didn't think about the case of newer programs on older
> kernels. I can do that for the next submission. RWF_ENCODED should
> probably translate the E2BIG from copy_struct_from_user() to EINVAL,
> though, to avoid ambiguity with the case that the buffer wasn't big
> enough to return the encoded data.

Yeah, that seems fair enough. I would've preferred to keep the error
semantics the same everywhere, but adding additional ambiguity to such
error cases isn't a good idea.

It's a bit of a shame we don't have more granular EINVALs to make it
easier to figure out *why* you got an EINVAL (then we wouldn't have had
to abuse E2BIG to indicate to userspace "you're using a new feature on
an old kernel") -- but that's a more generic problem that probably won't
be solved any time soon.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--g5npfiseklp7ctvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXboYnAAKCRCdlLljIbnQ
Er2sAQC2VN2o2Lz85TnRXvI+410gb7l6v49AP888CDb1aU7NIAEAnSuthq3EWWZG
aePx57k+ODDR3R3+iOlq6CbxrmSaUwg=
=R5ek
-----END PGP SIGNATURE-----

--g5npfiseklp7ctvo--
