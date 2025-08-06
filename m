Return-Path: <linux-fsdevel+bounces-56830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A15DB1C311
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94522162F4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D1B288C9A;
	Wed,  6 Aug 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="D2TzrBjm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167DB1D63F7
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471843; cv=none; b=jGl920qYNvKV4vov2bkE8yhkxqWYvKLrsPoYsLvZmdUk0V1ozNV7c85hBsl4yfyGX5AwPPtYOp3d++rvWIBZ4CpscsvAnMW1lYzTvnjiZIvl4+rH+gT9k9xL3vlFc7bfUUIqfjIvNcS8pV/7k1RePEYt2rQ9jLbEDxpnhjOpPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471843; c=relaxed/simple;
	bh=RAyPjyPla8dgUmqc08NO4yBxH/e+oBRJ+pxblozDaB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JY7rFb42rtdGlwWHlQ8YyRjJ35IH5vALdycW8cvG9+L0nW+z5cvEEoiCR9HbZJoeVudwb/zK4ymJZM5GZPvyKjMuAOrM8FRSbOSuZwmV/x2cxKlibUgIoR9P7lz2RztpHtzKYvKGmNYafOSDtSbO3cwn3MDyUnCwedGj4YWOE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=D2TzrBjm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nslNYFTqhFa2HYo3JVDnJOBYlhCXHvYL4hCVtDjfuq8=; b=D2TzrBjmjwab1okP4Muz0FGDqD
	NeHOKp2jPxg9wBLIy+9v376AVhEUmdOW/M7gwdgKm9xsMUMZ4Fu6VAz15VIggd2vSMbxBmzsPLFpy
	E9Q9GlkRD21/H3TUJPHrnhPqzgc8Vz6WxvbBs4wVe5Rm6kQcHicnSNOqTPONAttnBB8T4HArv4zGw
	lfP7Fqh1It7mH1rOjwkhPpjyjT/7nVXX4A1ADuuDhcZpiGXRF0xLuwV0N5YfvIDRk6zvLgppmJR69
	wBDmTbf3ArFIusX8/D/1+pg59ktfLMRLC9JpCQxS5vwWYuSoGZE4EG1A3CeL0RSi8Li0ZmgmJpXsT
	kxsUq3eA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ujaGl-00AS5g-Nv; Wed, 06 Aug 2025 11:17:11 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,  Bernd Schubert <bschubert@ddn.com>,
  Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 1/2] fuse: fix COPY_FILE_RANGE interface
In-Reply-To: <20250805183017.4072973-1-mszeredi@redhat.com> (Miklos Szeredi's
	message of "Tue, 5 Aug 2025 20:30:15 +0200")
References: <20250805183017.4072973-1-mszeredi@redhat.com>
Date: Wed, 06 Aug 2025 10:17:06 +0100
Message-ID: <87pld8kdwt.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05 2025, Miklos Szeredi wrote:

> The FUSE protocol uses struct fuse_write_out to convey the return value of
> copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_RANGE
> interface supports a 64-bit size copies.
>
> Currently the number of bytes copied is silently truncated to 32-bit, whi=
ch
> is unfortunate at best.
>
> Introduce a new op COPY_FILE_RANGE_64, which is identical, except the
> number of bytes copied is returned in a 64-bit value.
>
> If the fuse server does not support COPY_FILE_RANGE_64, fall back to
> COPY_FILE_RANGE and truncate the size to UINT_MAX - 4096.

I was wondering if it wouldn't make more sense to truncate the size to
MAX_RW_COUNT instead.  My reasoning is that, if I understand the code
correctly (which is probably a big 'if'!), the VFS will fallback to
splice() if the file system does not implement copy_file_range.  And in
this case splice() seems to limit the operation to MAX_RW_COUNT.

Cheers,
--=20
Lu=C3=ADs


> Reported-by: Florian Weimer <fweimer@redhat.com>
> Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redhat.=
com/
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/file.c            | 34 ++++++++++++++++++++++++++--------
>  fs/fuse/fuse_i.h          |  3 +++
>  include/uapi/linux/fuse.h | 12 +++++++++++-
>  3 files changed, 40 insertions(+), 9 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index adc4aa6810f5..bd6624885855 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3017,6 +3017,8 @@ static ssize_t __fuse_copy_file_range(struct file *=
file_in, loff_t pos_in,
>  		.flags =3D flags
>  	};
>  	struct fuse_write_out outarg;
> +	struct fuse_copy_file_range_out outarg_64;
> +	u64 bytes_copied;
>  	ssize_t err;
>  	/* mark unstable when write-back is not used, and file_out gets
>  	 * extended */
> @@ -3066,30 +3068,46 @@ static ssize_t __fuse_copy_file_range(struct file=
 *file_in, loff_t pos_in,
>  	if (is_unstable)
>  		set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
>=20=20
> -	args.opcode =3D FUSE_COPY_FILE_RANGE;
> +	args.opcode =3D FUSE_COPY_FILE_RANGE_64;
>  	args.nodeid =3D ff_in->nodeid;
>  	args.in_numargs =3D 1;
>  	args.in_args[0].size =3D sizeof(inarg);
>  	args.in_args[0].value =3D &inarg;
>  	args.out_numargs =3D 1;
> -	args.out_args[0].size =3D sizeof(outarg);
> -	args.out_args[0].value =3D &outarg;
> +	args.out_args[0].size =3D sizeof(outarg_64);
> +	args.out_args[0].value =3D &outarg_64;
> +	if (fc->no_copy_file_range_64) {
> +fallback:
> +		/* Fall back to old op that can't handle large copy length */
> +		args.opcode =3D FUSE_COPY_FILE_RANGE;
> +		args.out_args[0].size =3D sizeof(outarg);
> +		args.out_args[0].value =3D &outarg;
> +		inarg.len =3D min_t(size_t, len, 0xfffff000);
> +	}
>  	err =3D fuse_simple_request(fm, &args);
>  	if (err =3D=3D -ENOSYS) {
> -		fc->no_copy_file_range =3D 1;
> -		err =3D -EOPNOTSUPP;
> +		if (fc->no_copy_file_range_64) {
> +			fc->no_copy_file_range =3D 1;
> +			err =3D -EOPNOTSUPP;
> +		} else {
> +			fc->no_copy_file_range_64 =3D 1;
> +			goto fallback;
> +		}
>  	}
>  	if (err)
>  		goto out;
>=20=20
> +	bytes_copied =3D fc->no_copy_file_range_64 ?
> +		outarg.size : outarg_64.bytes_copied;
> +
>  	truncate_inode_pages_range(inode_out->i_mapping,
>  				   ALIGN_DOWN(pos_out, PAGE_SIZE),
> -				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
> +				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
>=20=20
>  	file_update_time(file_out);
> -	fuse_write_update_attr(inode_out, pos_out + outarg.size, outarg.size);
> +	fuse_write_update_attr(inode_out, pos_out + bytes_copied, bytes_copied);
>=20=20
> -	err =3D outarg.size;
> +	err =3D bytes_copied;
>  out:
>  	if (is_unstable)
>  		clear_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index b54f4f57789f..a8be19f686b1 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -850,6 +850,9 @@ struct fuse_conn {
>  	/** Does the filesystem support copy_file_range? */
>  	unsigned no_copy_file_range:1;
>=20=20
> +	/** Does the filesystem support copy_file_range_64? */
> +	unsigned no_copy_file_range_64:1;
> +
>  	/* Send DESTROY request */
>  	unsigned int destroy:1;
>=20=20
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 122d6586e8d4..94621f68a5cc 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -235,6 +235,10 @@
>   *
>   *  7.44
>   *  - add FUSE_NOTIFY_INC_EPOCH
> + *
> + *  7.45
> + *  - add FUSE_COPY_FILE_RANGE_64
> + *  - add struct fuse_copy_file_range_out
>   */
>=20=20
>  #ifndef _LINUX_FUSE_H
> @@ -270,7 +274,7 @@
>  #define FUSE_KERNEL_VERSION 7
>=20=20
>  /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 44
> +#define FUSE_KERNEL_MINOR_VERSION 45
>=20=20
>  /** The node ID of the root inode */
>  #define FUSE_ROOT_ID 1
> @@ -657,6 +661,7 @@ enum fuse_opcode {
>  	FUSE_SYNCFS		=3D 50,
>  	FUSE_TMPFILE		=3D 51,
>  	FUSE_STATX		=3D 52,
> +	FUSE_COPY_FILE_RANGE_64	=3D 53,
>=20=20
>  	/* CUSE specific operations */
>  	CUSE_INIT		=3D 4096,
> @@ -1148,6 +1153,11 @@ struct fuse_copy_file_range_in {
>  	uint64_t	flags;
>  };
>=20=20
> +/* For FUSE_COPY_FILE_RANGE_64 */
> +struct fuse_copy_file_range_out {
> +	uint64_t	bytes_copied;
> +};
> +
>  #define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
>  #define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
>  struct fuse_setupmapping_in {
> --=20
> 2.49.0
>


