Return-Path: <linux-fsdevel+bounces-56881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FAAB1CC99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 21:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC82A18C18C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25BE273D94;
	Wed,  6 Aug 2025 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nkyiPhtf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99D1FBCB5
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754509734; cv=none; b=JDNBWcLoxsPD8mWsGGFr7KyqHrlyJ6tsXAsDgpupncTBrMqnKCBbGWeNT22SVL9Y8bOCtPYCVow+URhwycJ2yV4IXR93Jcy0kD8mke4bZ4FuV/Xwfkhev/KCZ/B2PyHg3IVc8dwqxbm/DsaLREf5SgjcCt6R5PoMYIWhveThL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754509734; c=relaxed/simple;
	bh=pWb3FUWt59y+44xejSFu66F+fW2m5wvDtQPpvMX3yTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JZxSp8jgJVWs1CB6SwX/FlDm5k1LjsuECJQ2Ys2fr82X7fZ+yndL1/XZV/IYWZLlLB5NbsHQ1dNWKky5Wh3eq2uIRh5qYAfqvzEhKL/aF3+tL144DGaSgz25W4UA/KNtxuwhmffxC9wkJjG/WdrfV5IqQrgW9X4XO3LrbdhR0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nkyiPhtf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ykYk8RoojWVSwctN2fkwNGf/wWZu6Uh5ZPIaX7IQU5U=; b=nkyiPhtfSKI/fsobupZVjYr8c3
	ovddgrMCxdrwX7O+uxA863GsF77AEfIAEaREl7b/FWesHC6M2ra8uRkljqIJX0nmzw5oLKepFsAPY
	MGeaw8ROrx9DH9ed7Nwr9+kuZD62ns7KbJzT0XKTKgIJ7GGLfTC3zHSAqOlKjYPWeR28ikXSc62zg
	HmBKOvQcHRy4knvEOG6GZdVi6RCL8r4kONZlURDWRW9mESHMYlRdpydbIWgZlQpkOlxR07TMyl7hl
	QcW0zzSrJmvlKqXkuSloHctWQkA5wuNXNWF7vx2PyTXyy7guMtuJaUVj/NtpaThknPKG9/M3sN2V0
	fKYur0Rw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ujk7u-00AgBk-Jc; Wed, 06 Aug 2025 21:48:42 +0200
From: Luis Henriques <luis@igalia.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,  linux-fsdevel@vger.kernel.org,
  Bernd Schubert <bschubert@ddn.com>,  Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 1/2] fuse: fix COPY_FILE_RANGE interface
In-Reply-To: <20250806160142.GF2672029@frogsfrogsfrogs> (Darrick J. Wong's
	message of "Wed, 6 Aug 2025 09:01:42 -0700")
References: <20250805183017.4072973-1-mszeredi@redhat.com>
	<87pld8kdwt.fsf@wotan.olymp>
	<20250806160142.GF2672029@frogsfrogsfrogs>
Date: Wed, 06 Aug 2025 20:48:41 +0100
Message-ID: <87ldnw44fa.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06 2025, Darrick J. Wong wrote:

> On Wed, Aug 06, 2025 at 10:17:06AM +0100, Luis Henriques wrote:
>> On Tue, Aug 05 2025, Miklos Szeredi wrote:
>>=20
>> > The FUSE protocol uses struct fuse_write_out to convey the return valu=
e of
>> > copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_R=
ANGE
>> > interface supports a 64-bit size copies.
>> >
>> > Currently the number of bytes copied is silently truncated to 32-bit, =
which
>> > is unfortunate at best.
>> >
>> > Introduce a new op COPY_FILE_RANGE_64, which is identical, except the
>> > number of bytes copied is returned in a 64-bit value.
>> >
>> > If the fuse server does not support COPY_FILE_RANGE_64, fall back to
>> > COPY_FILE_RANGE and truncate the size to UINT_MAX - 4096.
>>=20
>> I was wondering if it wouldn't make more sense to truncate the size to
>> MAX_RW_COUNT instead.  My reasoning is that, if I understand the code
>> correctly (which is probably a big 'if'!), the VFS will fallback to
>> splice() if the file system does not implement copy_file_range.  And in
>> this case splice() seems to limit the operation to MAX_RW_COUNT.
>
> It doesn't, because copy_file_range implementations can do other things
> (like remapping/reflinking file blocks) that produce a very small amount
> of disk IO for what is effectively a very large change to file contents.
> That's why the VFS doesn't cap len at MAX_RW_COUNT bytes.

Oh, OK.  So looks like I misunderstood that code.  In vfs_copy_file_range(),
I assumed that the fallback to splice ('splice =3D true;') would cap the IO
with the following:

	ret =3D do_splice_direct(file_in, &pos_in, file_out, &pos_out,
			       min_t(size_t, len, MAX_RW_COUNT), 0);

And that's why I suggested to do the same here instead of UINT_MAX - 4096.

Cheers,
--=20
Lu=C3=ADs


> --D
>
>> Cheers,
>> --=20
>> Lu=C3=ADs
>>=20
>>=20
>> > Reported-by: Florian Weimer <fweimer@redhat.com>
>> > Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redh=
at.com/
>> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> > ---
>> >  fs/fuse/file.c            | 34 ++++++++++++++++++++++++++--------
>> >  fs/fuse/fuse_i.h          |  3 +++
>> >  include/uapi/linux/fuse.h | 12 +++++++++++-
>> >  3 files changed, 40 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> > index adc4aa6810f5..bd6624885855 100644
>> > --- a/fs/fuse/file.c
>> > +++ b/fs/fuse/file.c
>> > @@ -3017,6 +3017,8 @@ static ssize_t __fuse_copy_file_range(struct fil=
e *file_in, loff_t pos_in,
>> >  		.flags =3D flags
>> >  	};
>> >  	struct fuse_write_out outarg;
>> > +	struct fuse_copy_file_range_out outarg_64;
>> > +	u64 bytes_copied;
>> >  	ssize_t err;
>> >  	/* mark unstable when write-back is not used, and file_out gets
>> >  	 * extended */
>> > @@ -3066,30 +3068,46 @@ static ssize_t __fuse_copy_file_range(struct f=
ile *file_in, loff_t pos_in,
>> >  	if (is_unstable)
>> >  		set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
>> >=20=20
>> > -	args.opcode =3D FUSE_COPY_FILE_RANGE;
>> > +	args.opcode =3D FUSE_COPY_FILE_RANGE_64;
>> >  	args.nodeid =3D ff_in->nodeid;
>> >  	args.in_numargs =3D 1;
>> >  	args.in_args[0].size =3D sizeof(inarg);
>> >  	args.in_args[0].value =3D &inarg;
>> >  	args.out_numargs =3D 1;
>> > -	args.out_args[0].size =3D sizeof(outarg);
>> > -	args.out_args[0].value =3D &outarg;
>> > +	args.out_args[0].size =3D sizeof(outarg_64);
>> > +	args.out_args[0].value =3D &outarg_64;
>> > +	if (fc->no_copy_file_range_64) {
>> > +fallback:
>> > +		/* Fall back to old op that can't handle large copy length */
>> > +		args.opcode =3D FUSE_COPY_FILE_RANGE;
>> > +		args.out_args[0].size =3D sizeof(outarg);
>> > +		args.out_args[0].value =3D &outarg;
>> > +		inarg.len =3D min_t(size_t, len, 0xfffff000);
>> > +	}
>> >  	err =3D fuse_simple_request(fm, &args);
>> >  	if (err =3D=3D -ENOSYS) {
>> > -		fc->no_copy_file_range =3D 1;
>> > -		err =3D -EOPNOTSUPP;
>> > +		if (fc->no_copy_file_range_64) {
>> > +			fc->no_copy_file_range =3D 1;
>> > +			err =3D -EOPNOTSUPP;
>> > +		} else {
>> > +			fc->no_copy_file_range_64 =3D 1;
>> > +			goto fallback;
>> > +		}
>> >  	}
>> >  	if (err)
>> >  		goto out;
>> >=20=20
>> > +	bytes_copied =3D fc->no_copy_file_range_64 ?
>> > +		outarg.size : outarg_64.bytes_copied;
>> > +
>> >  	truncate_inode_pages_range(inode_out->i_mapping,
>> >  				   ALIGN_DOWN(pos_out, PAGE_SIZE),
>> > -				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
>> > +				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
>> >=20=20
>> >  	file_update_time(file_out);
>> > -	fuse_write_update_attr(inode_out, pos_out + outarg.size, outarg.size=
);
>> > +	fuse_write_update_attr(inode_out, pos_out + bytes_copied, bytes_copi=
ed);
>> >=20=20
>> > -	err =3D outarg.size;
>> > +	err =3D bytes_copied;
>> >  out:
>> >  	if (is_unstable)
>> >  		clear_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
>> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> > index b54f4f57789f..a8be19f686b1 100644
>> > --- a/fs/fuse/fuse_i.h
>> > +++ b/fs/fuse/fuse_i.h
>> > @@ -850,6 +850,9 @@ struct fuse_conn {
>> >  	/** Does the filesystem support copy_file_range? */
>> >  	unsigned no_copy_file_range:1;
>> >=20=20
>> > +	/** Does the filesystem support copy_file_range_64? */
>> > +	unsigned no_copy_file_range_64:1;
>> > +
>> >  	/* Send DESTROY request */
>> >  	unsigned int destroy:1;
>> >=20=20
>> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> > index 122d6586e8d4..94621f68a5cc 100644
>> > --- a/include/uapi/linux/fuse.h
>> > +++ b/include/uapi/linux/fuse.h
>> > @@ -235,6 +235,10 @@
>> >   *
>> >   *  7.44
>> >   *  - add FUSE_NOTIFY_INC_EPOCH
>> > + *
>> > + *  7.45
>> > + *  - add FUSE_COPY_FILE_RANGE_64
>> > + *  - add struct fuse_copy_file_range_out
>> >   */
>> >=20=20
>> >  #ifndef _LINUX_FUSE_H
>> > @@ -270,7 +274,7 @@
>> >  #define FUSE_KERNEL_VERSION 7
>> >=20=20
>> >  /** Minor version number of this interface */
>> > -#define FUSE_KERNEL_MINOR_VERSION 44
>> > +#define FUSE_KERNEL_MINOR_VERSION 45
>> >=20=20
>> >  /** The node ID of the root inode */
>> >  #define FUSE_ROOT_ID 1
>> > @@ -657,6 +661,7 @@ enum fuse_opcode {
>> >  	FUSE_SYNCFS		=3D 50,
>> >  	FUSE_TMPFILE		=3D 51,
>> >  	FUSE_STATX		=3D 52,
>> > +	FUSE_COPY_FILE_RANGE_64	=3D 53,
>> >=20=20
>> >  	/* CUSE specific operations */
>> >  	CUSE_INIT		=3D 4096,
>> > @@ -1148,6 +1153,11 @@ struct fuse_copy_file_range_in {
>> >  	uint64_t	flags;
>> >  };
>> >=20=20
>> > +/* For FUSE_COPY_FILE_RANGE_64 */
>> > +struct fuse_copy_file_range_out {
>> > +	uint64_t	bytes_copied;
>> > +};
>> > +
>> >  #define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
>> >  #define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
>> >  struct fuse_setupmapping_in {
>> > --=20
>> > 2.49.0
>> >
>>=20
>>=20


