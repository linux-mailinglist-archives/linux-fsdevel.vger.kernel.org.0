Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A741BDFA32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 03:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfJVBhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 21:37:34 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:51563 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfJVBhd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 21:37:33 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id 9A2FCA3414;
        Tue, 22 Oct 2019 03:37:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id dyNrI7RqNmMC; Tue, 22 Oct 2019 03:37:27 +0200 (CEST)
Date:   Tue, 22 Oct 2019 12:37:17 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v2 2/5] fs: add RWF_ENCODED for reading/writing
 compressed data
Message-ID: <20191022013717.enwdmox4b7la4i74@yavin.dot.cyphar.com>
References: <cover.1571164762.git.osandov@fb.com>
 <7f98cf5409cf2b583cd5b3451fc739fd3428873b.1571164762.git.osandov@fb.com>
 <20191021182806.GA6706@magnolia>
 <20191021183831.mbe4q2beqo76fqxm@yavin.dot.cyphar.com>
 <20191021190010.GC6726@magnolia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tel3pez3twjkfp2c"
Content-Disposition: inline
In-Reply-To: <20191021190010.GC6726@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--tel3pez3twjkfp2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-21, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> On Tue, Oct 22, 2019 at 05:38:31AM +1100, Aleksa Sarai wrote:
> > On 2019-10-21, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > On Tue, Oct 15, 2019 at 11:42:40AM -0700, Omar Sandoval wrote:
> > > > From: Omar Sandoval <osandov@fb.com>
> > > >=20
> > > > Btrfs supports transparent compression: data written by the user ca=
n be
> > > > compressed when written to disk and decompressed when read back.
> > > > However, we'd like to add an interface to write pre-compressed data
> > > > directly to the filesystem, and the matching interface to read
> > > > compressed data without decompressing it. This adds support for
> > > > so-called "encoded I/O" via preadv2() and pwritev2().
> > > >=20
> > > > A new RWF_ENCODED flags indicates that a read or write is "encoded"=
=2E If
> > > > this flag is set, iov[0].iov_base points to a struct encoded_iov wh=
ich
> > > > is used for metadata: namely, the compression algorithm, unencoded
> > > > (i.e., decompressed) length, and what subrange of the unencoded data
> > > > should be used (needed for truncated or hole-punched extents and wh=
en
> > > > reading in the middle of an extent). For reads, the filesystem retu=
rns
> > > > this information; for writes, the caller provides it to the filesys=
tem.
> > > > iov[0].iov_len must be set to sizeof(struct encoded_iov), which can=
 be
> > > > used to extend the interface in the future. The remaining iovecs co=
ntain
> > > > the encoded extent.
> > > >=20
> > > > Filesystems must indicate that they support encoded writes by setti=
ng
> > > > FMODE_ENCODED_IO in ->file_open().
> > > >=20
> > > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > > ---
> > > >  include/linux/fs.h      | 14 +++++++
> > > >  include/uapi/linux/fs.h | 26 ++++++++++++-
> > > >  mm/filemap.c            | 82 ++++++++++++++++++++++++++++++++++---=
----
> > > >  3 files changed, 108 insertions(+), 14 deletions(-)
> > > >=20
> > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > index e0d909d35763..54681f21e05e 100644
> > > > --- a/include/linux/fs.h
> > > > +++ b/include/linux/fs.h
> > > > @@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, =
loff_t offset,
> > > >  /* File does not contribute to nr_files count */
> > > >  #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
> > > > =20
> > > > +/* File supports encoded IO */
> > > > +#define FMODE_ENCODED_IO	((__force fmode_t)0x40000000)
> > > > +
> > > >  /*
> > > >   * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
> > > >   * that indicates that they should check the contents of the iovec=
 are
> > > > @@ -314,6 +317,7 @@ enum rw_hint {
> > > >  #define IOCB_SYNC		(1 << 5)
> > > >  #define IOCB_WRITE		(1 << 6)
> > > >  #define IOCB_NOWAIT		(1 << 7)
> > > > +#define IOCB_ENCODED		(1 << 8)
> > > > =20
> > > >  struct kiocb {
> > > >  	struct file		*ki_filp;
> > > > @@ -3088,6 +3092,11 @@ extern int sb_min_blocksize(struct super_blo=
ck *, int);
> > > >  extern int generic_file_mmap(struct file *, struct vm_area_struct =
*);
> > > >  extern int generic_file_readonly_mmap(struct file *, struct vm_are=
a_struct *);
> > > >  extern ssize_t generic_write_checks(struct kiocb *, struct iov_ite=
r *);
> > > > +struct encoded_iov;
> > > > +extern int generic_encoded_write_checks(struct kiocb *, struct enc=
oded_iov *);
> > > > +extern ssize_t check_encoded_read(struct kiocb *, struct iov_iter =
*);
> > > > +extern int import_encoded_write(struct kiocb *, struct encoded_iov=
 *,
> > > > +				struct iov_iter *);
> > > >  extern int generic_remap_checks(struct file *file_in, loff_t pos_i=
n,
> > > >  				struct file *file_out, loff_t pos_out,
> > > >  				loff_t *count, unsigned int remap_flags);
> > > > @@ -3403,6 +3412,11 @@ static inline int kiocb_set_rw_flags(struct =
kiocb *ki, rwf_t flags)
> > > >  			return -EOPNOTSUPP;
> > > >  		ki->ki_flags |=3D IOCB_NOWAIT;
> > > >  	}
> > > > +	if (flags & RWF_ENCODED) {
> > > > +		if (!(ki->ki_filp->f_mode & FMODE_ENCODED_IO))
> > > > +			return -EOPNOTSUPP;
> > > > +		ki->ki_flags |=3D IOCB_ENCODED;
> > > > +	}
> > > >  	if (flags & RWF_HIPRI)
> > > >  		ki->ki_flags |=3D IOCB_HIPRI;
> > > >  	if (flags & RWF_DSYNC)
> > > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > > index 379a612f8f1d..ed92a8a257cb 100644
> > > > --- a/include/uapi/linux/fs.h
> > > > +++ b/include/uapi/linux/fs.h
> > > > @@ -284,6 +284,27 @@ struct fsxattr {
> > > > =20
> > > >  typedef int __bitwise __kernel_rwf_t;
> > > > =20
> > > > +enum {
> > > > +	ENCODED_IOV_COMPRESSION_NONE,
> > > > +	ENCODED_IOV_COMPRESSION_ZLIB,
> > > > +	ENCODED_IOV_COMPRESSION_LZO,
> > > > +	ENCODED_IOV_COMPRESSION_ZSTD,
> > > > +	ENCODED_IOV_COMPRESSION_TYPES =3D ENCODED_IOV_COMPRESSION_ZSTD,
> > > > +};
> > > > +
> > > > +enum {
> > > > +	ENCODED_IOV_ENCRYPTION_NONE,
> > > > +	ENCODED_IOV_ENCRYPTION_TYPES =3D ENCODED_IOV_ENCRYPTION_NONE,
> > > > +};
> > > > +
> > > > +struct encoded_iov {
> > > > +	__u64 len;
> > > > +	__u64 unencoded_len;
> > > > +	__u64 unencoded_offset;
> > > > +	__u32 compression;
> > > > +	__u32 encryption;
> > >=20
> > > Can we add some must-be-zero padding space at the end here for whomev=
er
> > > comes along next wanting to add more encoding info?
> >=20
> > I would suggest to copy the extension design of copy_struct_from_user().
> > Adding must-be-zero padding is a less-ideal solution to the extension
> > problem than length-based extension.
>=20
> Come to think of it, you /do/ have to specify iov_len so... yeah, do
> that instead; we can always extend the structure later.
>=20
> > Also (I might be wrong) but shouldn't the __u64s be __aligned_u64 (as
> > with syscall structure arguments)?
>=20
> <shrug> No idea, that's the first I've heard of that type and it doesn't
> seem to be used by the fs code.  Why would we care about alignment for
> an incore structure?

When passing u64s from userspace, it's generally considered a good idea
to use __aligned_u64 -- the main reason is that 32-bit userspace on a
64-bit kernel will use different structure alignment for 64-bit fields.

This means you'd need to implement a bunch of COMPAT_SYSCALL-like
handling for that case. It's much simpler to use __aligned_u64 (and on
the plus side I don't think you need to add any fields to ensure the
padding is zero).

> >=20
> > > (And maybe a manpage and some basic testing, to reiterate Dave...)
> > >=20
> > > --D
> > >=20
> > > > +};
> > > > +
> > > >  /* high priority request, poll if possible */
> > > >  #define RWF_HIPRI	((__force __kernel_rwf_t)0x00000001)
> > > > =20
> > > > @@ -299,8 +320,11 @@ typedef int __bitwise __kernel_rwf_t;
> > > >  /* per-IO O_APPEND */
> > > >  #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
> > > > =20
> > > > +/* encoded (e.g., compressed or encrypted) IO */
> > > > +#define RWF_ENCODED	((__force __kernel_rwf_t)0x00000020)
> > > > +
> > > >  /* mask of flags supported by the kernel */
> > > >  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWA=
IT |\
> > > > -			 RWF_APPEND)
> > > > +			 RWF_APPEND | RWF_ENCODED)
> > > > =20
> > > >  #endif /* _UAPI_LINUX_FS_H */
> > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > index 1146fcfa3215..d2e6d9caf353 100644
> > > > --- a/mm/filemap.c
> > > > +++ b/mm/filemap.c
> > > > @@ -2948,24 +2948,15 @@ static int generic_write_check_limits(struc=
t file *file, loff_t pos,
> > > >  	return 0;
> > > >  }
> > > > =20
> > > > -/*
> > > > - * Performs necessary checks before doing a write
> > > > - *
> > > > - * Can adjust writing position or amount of bytes to write.
> > > > - * Returns appropriate error code that caller should return or
> > > > - * zero in case that write should be allowed.
> > > > - */
> > > > -inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov=
_iter *from)
> > > > +static int generic_write_checks_common(struct kiocb *iocb, loff_t =
*count)
> > > >  {
> > > >  	struct file *file =3D iocb->ki_filp;
> > > >  	struct inode *inode =3D file->f_mapping->host;
> > > > -	loff_t count;
> > > > -	int ret;
> > > > =20
> > > >  	if (IS_SWAPFILE(inode))
> > > >  		return -ETXTBSY;
> > > > =20
> > > > -	if (!iov_iter_count(from))
> > > > +	if (!*count)
> > > >  		return 0;
> > > > =20
> > > >  	/* FIXME: this is for backwards compatibility with 2.4 */
> > > > @@ -2975,8 +2966,21 @@ inline ssize_t generic_write_checks(struct k=
iocb *iocb, struct iov_iter *from)
> > > >  	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIR=
ECT))
> > > >  		return -EINVAL;
> > > > =20
> > > > -	count =3D iov_iter_count(from);
> > > > -	ret =3D generic_write_check_limits(file, iocb->ki_pos, &count);
> > > > +	return generic_write_check_limits(iocb->ki_filp, iocb->ki_pos, co=
unt);
> > > > +}
> > > > +
> > > > +/*
> > > > + * Performs necessary checks before doing a write
> > > > + *
> > > > + * Can adjust writing position or amount of bytes to write.
> > > > + * Returns a negative errno or the new number of bytes to write.
> > > > + */
> > > > +inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov=
_iter *from)
> > > > +{
> > > > +	loff_t count =3D iov_iter_count(from);
> > > > +	int ret;
> > > > +
> > > > +	ret =3D generic_write_checks_common(iocb, &count);
> > > >  	if (ret)
> > > >  		return ret;
> > > > =20
> > > > @@ -2985,6 +2989,58 @@ inline ssize_t generic_write_checks(struct k=
iocb *iocb, struct iov_iter *from)
> > > >  }
> > > >  EXPORT_SYMBOL(generic_write_checks);
> > > > =20
> > > > +int generic_encoded_write_checks(struct kiocb *iocb,
> > > > +				 struct encoded_iov *encoded)
> > > > +{
> > > > +	loff_t count =3D encoded->unencoded_len;
> > > > +	int ret;
> > > > +
> > > > +	ret =3D generic_write_checks_common(iocb, &count);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	if (count !=3D encoded->unencoded_len) {
> > > > +		/*
> > > > +		 * The write got truncated by generic_write_checks_common(). We
> > > > +		 * can't do a partial encoded write.
> > > > +		 */
> > > > +		return -EFBIG;
> > > > +	}
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL(generic_encoded_write_checks);
> > > > +
> > > > +ssize_t check_encoded_read(struct kiocb *iocb, struct iov_iter *it=
er)
> > > > +{
> > > > +	if (!(iocb->ki_filp->f_flags & O_ENCODED))
> > > > +		return -EPERM;
> > > > +	if (iov_iter_single_seg_count(iter) !=3D sizeof(struct encoded_io=
v))
> > > > +		return -EINVAL;
> > > > +	return iov_iter_count(iter) - sizeof(struct encoded_iov);
> > > > +}
> > > > +EXPORT_SYMBOL(check_encoded_read);
> > > > +
> > > > +int import_encoded_write(struct kiocb *iocb, struct encoded_iov *e=
ncoded,
> > > > +			 struct iov_iter *from)
> > > > +{
> > > > +	if (!(iocb->ki_filp->f_flags & O_ENCODED))
> > > > +		return -EPERM;
> > > > +	if (iov_iter_single_seg_count(from) !=3D sizeof(*encoded))
> > > > +		return -EINVAL;
> > > > +	if (copy_from_iter(encoded, sizeof(*encoded), from) !=3D sizeof(*=
encoded))
> > > > +		return -EFAULT;
> > > > +	if (encoded->compression =3D=3D ENCODED_IOV_COMPRESSION_NONE &&
> > > > +	    encoded->encryption =3D=3D ENCODED_IOV_ENCRYPTION_NONE)
> > > > +		return -EINVAL;
> > > > +	if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
> > > > +	    encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
> > > > +		return -EINVAL;
> > > > +	if (encoded->unencoded_offset >=3D encoded->unencoded_len)
> > > > +		return -EINVAL;
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL(import_encoded_write);
> > > > +
> > > >  /*
> > > >   * Performs necessary checks before doing a clone.
> > > >   *

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--tel3pez3twjkfp2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXa5dSQAKCRCdlLljIbnQ
EmxRAPsGpqeyAWpLA0wtXYC//gRIdEqupPZnfJCvZPvY3+Bw6AEAo8W6ZMfu8/XN
i9uZlXnDzE5uE0/SQfeliX1xRJWUbgM=
=jjFU
-----END PGP SIGNATURE-----

--tel3pez3twjkfp2c--
