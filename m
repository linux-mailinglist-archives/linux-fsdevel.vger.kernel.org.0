Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6311CDD6B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 07:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfJSFCN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 01:02:13 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:36315 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfJSFCN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 01:02:13 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id 56D93A3442;
        Sat, 19 Oct 2019 07:02:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id hkTttXOfoGiA; Sat, 19 Oct 2019 07:02:05 +0200 (CEST)
Date:   Sat, 19 Oct 2019 16:01:55 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com, christian.brauner@ubuntu.com
Subject: Re: [RFC PATCH v2 2/5] fs: add RWF_ENCODED for reading/writing
 compressed data
Message-ID: <20191019050155.mts3dfmnf3i2553p@yavin.dot.cyphar.com>
References: <cover.1571164762.git.osandov@fb.com>
 <7f98cf5409cf2b583cd5b3451fc739fd3428873b.1571164762.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oe3uj6spa3degh5m"
Content-Disposition: inline
In-Reply-To: <7f98cf5409cf2b583cd5b3451fc739fd3428873b.1571164762.git.osandov@fb.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--oe3uj6spa3degh5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-15, Omar Sandoval <osandov@osandov.com> wrote:
> From: Omar Sandoval <osandov@fb.com>
>=20
> Btrfs supports transparent compression: data written by the user can be
> compressed when written to disk and decompressed when read back.
> However, we'd like to add an interface to write pre-compressed data
> directly to the filesystem, and the matching interface to read
> compressed data without decompressing it. This adds support for
> so-called "encoded I/O" via preadv2() and pwritev2().
>=20
> A new RWF_ENCODED flags indicates that a read or write is "encoded". If
> this flag is set, iov[0].iov_base points to a struct encoded_iov which
> is used for metadata: namely, the compression algorithm, unencoded
> (i.e., decompressed) length, and what subrange of the unencoded data
> should be used (needed for truncated or hole-punched extents and when
> reading in the middle of an extent). For reads, the filesystem returns
> this information; for writes, the caller provides it to the filesystem.
> iov[0].iov_len must be set to sizeof(struct encoded_iov), which can be
> used to extend the interface in the future. The remaining iovecs contain
> the encoded extent.
>=20
> Filesystems must indicate that they support encoded writes by setting
> FMODE_ENCODED_IO in ->file_open().
>=20
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  include/linux/fs.h      | 14 +++++++
>  include/uapi/linux/fs.h | 26 ++++++++++++-
>  mm/filemap.c            | 82 ++++++++++++++++++++++++++++++++++-------
>  3 files changed, 108 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e0d909d35763..54681f21e05e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t=
 offset,
>  /* File does not contribute to nr_files count */
>  #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
> =20
> +/* File supports encoded IO */
> +#define FMODE_ENCODED_IO	((__force fmode_t)0x40000000)
> +
>  /*
>   * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
>   * that indicates that they should check the contents of the iovec are
> @@ -314,6 +317,7 @@ enum rw_hint {
>  #define IOCB_SYNC		(1 << 5)
>  #define IOCB_WRITE		(1 << 6)
>  #define IOCB_NOWAIT		(1 << 7)
> +#define IOCB_ENCODED		(1 << 8)
> =20
>  struct kiocb {
>  	struct file		*ki_filp;
> @@ -3088,6 +3092,11 @@ extern int sb_min_blocksize(struct super_block *, =
int);
>  extern int generic_file_mmap(struct file *, struct vm_area_struct *);
>  extern int generic_file_readonly_mmap(struct file *, struct vm_area_stru=
ct *);
>  extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
> +struct encoded_iov;
> +extern int generic_encoded_write_checks(struct kiocb *, struct encoded_i=
ov *);
> +extern ssize_t check_encoded_read(struct kiocb *, struct iov_iter *);
> +extern int import_encoded_write(struct kiocb *, struct encoded_iov *,
> +				struct iov_iter *);
>  extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  				struct file *file_out, loff_t pos_out,
>  				loff_t *count, unsigned int remap_flags);
> @@ -3403,6 +3412,11 @@ static inline int kiocb_set_rw_flags(struct kiocb =
*ki, rwf_t flags)
>  			return -EOPNOTSUPP;
>  		ki->ki_flags |=3D IOCB_NOWAIT;
>  	}
> +	if (flags & RWF_ENCODED) {
> +		if (!(ki->ki_filp->f_mode & FMODE_ENCODED_IO))
> +			return -EOPNOTSUPP;
> +		ki->ki_flags |=3D IOCB_ENCODED;
> +	}
>  	if (flags & RWF_HIPRI)
>  		ki->ki_flags |=3D IOCB_HIPRI;
>  	if (flags & RWF_DSYNC)
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 379a612f8f1d..ed92a8a257cb 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -284,6 +284,27 @@ struct fsxattr {
> =20
>  typedef int __bitwise __kernel_rwf_t;
> =20
> +enum {
> +	ENCODED_IOV_COMPRESSION_NONE,
> +	ENCODED_IOV_COMPRESSION_ZLIB,
> +	ENCODED_IOV_COMPRESSION_LZO,
> +	ENCODED_IOV_COMPRESSION_ZSTD,
> +	ENCODED_IOV_COMPRESSION_TYPES =3D ENCODED_IOV_COMPRESSION_ZSTD,
> +};
> +
> +enum {
> +	ENCODED_IOV_ENCRYPTION_NONE,
> +	ENCODED_IOV_ENCRYPTION_TYPES =3D ENCODED_IOV_ENCRYPTION_NONE,
> +};
> +
> +struct encoded_iov {
> +	__u64 len;
> +	__u64 unencoded_len;
> +	__u64 unencoded_offset;
> +	__u32 compression;
> +	__u32 encryption;
> +};
> +
>  /* high priority request, poll if possible */
>  #define RWF_HIPRI	((__force __kernel_rwf_t)0x00000001)
> =20
> @@ -299,8 +320,11 @@ typedef int __bitwise __kernel_rwf_t;
>  /* per-IO O_APPEND */
>  #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
> =20
> +/* encoded (e.g., compressed or encrypted) IO */
> +#define RWF_ENCODED	((__force __kernel_rwf_t)0x00000020)
> +
>  /* mask of flags supported by the kernel */
>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
> -			 RWF_APPEND)
> +			 RWF_APPEND | RWF_ENCODED)
> =20
>  #endif /* _UAPI_LINUX_FS_H */
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1146fcfa3215..d2e6d9caf353 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2948,24 +2948,15 @@ static int generic_write_check_limits(struct file=
 *file, loff_t pos,
>  	return 0;
>  }
> =20
> -/*
> - * Performs necessary checks before doing a write
> - *
> - * Can adjust writing position or amount of bytes to write.
> - * Returns appropriate error code that caller should return or
> - * zero in case that write should be allowed.
> - */
> -inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter =
*from)
> +static int generic_write_checks_common(struct kiocb *iocb, loff_t *count)
>  {
>  	struct file *file =3D iocb->ki_filp;
>  	struct inode *inode =3D file->f_mapping->host;
> -	loff_t count;
> -	int ret;
> =20
>  	if (IS_SWAPFILE(inode))
>  		return -ETXTBSY;
> =20
> -	if (!iov_iter_count(from))
> +	if (!*count)
>  		return 0;
> =20
>  	/* FIXME: this is for backwards compatibility with 2.4 */
> @@ -2975,8 +2966,21 @@ inline ssize_t generic_write_checks(struct kiocb *=
iocb, struct iov_iter *from)
>  	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
>  		return -EINVAL;
> =20
> -	count =3D iov_iter_count(from);
> -	ret =3D generic_write_check_limits(file, iocb->ki_pos, &count);
> +	return generic_write_check_limits(iocb->ki_filp, iocb->ki_pos, count);
> +}
> +
> +/*
> + * Performs necessary checks before doing a write
> + *
> + * Can adjust writing position or amount of bytes to write.
> + * Returns a negative errno or the new number of bytes to write.
> + */
> +inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter =
*from)
> +{
> +	loff_t count =3D iov_iter_count(from);
> +	int ret;
> +
> +	ret =3D generic_write_checks_common(iocb, &count);
>  	if (ret)
>  		return ret;
> =20
> @@ -2985,6 +2989,58 @@ inline ssize_t generic_write_checks(struct kiocb *=
iocb, struct iov_iter *from)
>  }
>  EXPORT_SYMBOL(generic_write_checks);
> =20
> +int generic_encoded_write_checks(struct kiocb *iocb,
> +				 struct encoded_iov *encoded)
> +{
> +	loff_t count =3D encoded->unencoded_len;
> +	int ret;
> +
> +	ret =3D generic_write_checks_common(iocb, &count);
> +	if (ret)
> +		return ret;
> +
> +	if (count !=3D encoded->unencoded_len) {
> +		/*
> +		 * The write got truncated by generic_write_checks_common(). We
> +		 * can't do a partial encoded write.
> +		 */
> +		return -EFBIG;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(generic_encoded_write_checks);
> +
> +ssize_t check_encoded_read(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	if (!(iocb->ki_filp->f_flags & O_ENCODED))
> +		return -EPERM;
> +	if (iov_iter_single_seg_count(iter) !=3D sizeof(struct encoded_iov))
> +		return -EINVAL;

I'm not sure what is precisely the right way of doing this within the
iov_iter world (maybe we should write some new helpers for that
usecase), but if you want to make forwards-compatibility much more
smooth please take a look at the new copy_struct_from_user() semantics
(it allows you to extend userspace-exposed structures without making it
painful for new software on old kernels).

Basically the semantics boil down to the following (ksize is the
kernel's struct size, and usize is the size that userspace used). All
new features must have their zero-value mean "don't use the new
feature".

  1. If ksize =3D=3D usize, use it verbatim.
  2. If ksize > usize (old userspace), zero-fill the rest of the kernel
	 struct -- thus if userspace doesn't know about a new feature, it is
	 disabled.
  3. If ksize < usize (old kernel), check whether the trailing
     (usize - ksize) bytes are zero. If they are, then just use the
	 ksize prefix of the userspace struct. If they are non-zero then
	 give -E2BIG. Thus if userspace is newer than the kernel but isn't
	 using a new feature, it won't get an error.

This is how clone3(2) works (and openat2(2) will work), as well as some
older syscalls like perf_event_open(2) and sched_setattr(2). BPF also
has some similar semantics.

I really would like us to have a much more uniform way of defining
extensible APIs in Linux. By returning -EINVAL for all differently-sized
structs means that any new programs will give errors on older kernels
(even if they aren't using any new features).

> +	return iov_iter_count(iter) - sizeof(struct encoded_iov);
> +}
> +EXPORT_SYMBOL(check_encoded_read);
> +
> +int import_encoded_write(struct kiocb *iocb, struct encoded_iov *encoded,
> +			 struct iov_iter *from)
> +{
> +	if (!(iocb->ki_filp->f_flags & O_ENCODED))
> +		return -EPERM;
> +	if (iov_iter_single_seg_count(from) !=3D sizeof(*encoded))
> +		return -EINVAL;
> +	if (copy_from_iter(encoded, sizeof(*encoded), from) !=3D sizeof(*encode=
d))
> +		return -EFAULT;
> +	if (encoded->compression =3D=3D ENCODED_IOV_COMPRESSION_NONE &&
> +	    encoded->encryption =3D=3D ENCODED_IOV_ENCRYPTION_NONE)
> +		return -EINVAL;
> +	if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
> +	    encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
> +		return -EINVAL;
> +	if (encoded->unencoded_offset >=3D encoded->unencoded_len)
> +		return -EINVAL;
> +	return 0;
> +}
> +EXPORT_SYMBOL(import_encoded_write);
> +
>  /*
>   * Performs necessary checks before doing a clone.
>   *

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--oe3uj6spa3degh5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXaqYvgAKCRCdlLljIbnQ
EkKXAP0dqxk8bVzOSbg/ToIoVEmHEOdrOcf3R3RDcQAnHIbzLwD/bn06sg9cZgD7
zuN4CiE9K/tJhGVfuufqc/9y/f3iDQc=
=3nsn
-----END PGP SIGNATURE-----

--oe3uj6spa3degh5m--
