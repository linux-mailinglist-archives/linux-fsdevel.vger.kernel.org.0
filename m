Return-Path: <linux-fsdevel+bounces-34440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A49C578E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F5E1F22BD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BDF1F778B;
	Tue, 12 Nov 2024 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc0VV3md"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8671CD218;
	Tue, 12 Nov 2024 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414006; cv=none; b=EhJs8WNDVtFcYDRRYzVsMbna5NHO8zZgvgge5VylCnN9Qz/Pvqc+9ctxexlZpjjaX3lxxRaSrKEN2rpUtFmiQDB+XXLxg6bRJqdvFawbjt1rvNtoG7g8leumux8FaonXj4ElWsPAwxpyo5v4rWcrpByFCMiERuV53Gun7CFW+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414006; c=relaxed/simple;
	bh=NeCS+o94jbktdL4jV/mzav8wOjxmbd7d7nRqgBNRQyc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=liU3lUw7Pp1TMinJwkEKyQ9LQSq16CYhQOMPUHWxo+5gWxdlGBiarlZVXPruIIxbRQSHdRHEPhQ92NNGPlzN5RPL1w78JhMWlLKkFXDdv0qcn7DRPyTe02OYjSfcAG74tLDSYyU9sHkM+1b0GwEvsQZMFNqSUoVDeCr5FBZVhNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc0VV3md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D540FC4CED0;
	Tue, 12 Nov 2024 12:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731414005;
	bh=NeCS+o94jbktdL4jV/mzav8wOjxmbd7d7nRqgBNRQyc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bc0VV3mdRX2CkhdozhkVXkF0EmEZLwv/5w8y/GN/fgB6OW8EfJ9uzSHx3zB41yijC
	 y24ExCt0orNuo1Yzmly0WAloWLrsDUMhaKLt3F97uYWOHd8zWNgAqiwXA7Gpeg63fz
	 TL5mPfFydUzwaz9bUc06Bc0pjh56AQErJvlBcaT2q/vNd3A5f3yScRbYaPFYsV+sBr
	 456VwrE6BQy10yAKDVz3GUqQJ1s0xunq523JLEM+vkDeqWwPblpuIbSZSqWErK7pU5
	 HB6t6oVDw7VLy2GhNqHr1T8KEWQahPWtSQ24fF65oW1fSrpcMv3g45k0dVLknYKPy0
	 3FxLTuVE7euvA==
Message-ID: <2faa89f0ad18d8f8015f65b202f8ddc64a810a71.camel@kernel.org>
Subject: Re: [PATCH] statmount: add flag to retrieve unescaped options
From: Jeff Layton <jlayton@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org, Karel Zak <kzak@redhat.com>, Christian
 Brauner <christian@brauner.io>, Josef Bacik <josef@toxicpanda.com>
Date: Tue, 12 Nov 2024 07:20:03 -0500
In-Reply-To: <20241112101006.30715-1-mszeredi@redhat.com>
References: <20241112101006.30715-1-mszeredi@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-12 at 11:10 +0100, Miklos Szeredi wrote:
> Filesystem options can be retrieved with STATMOUNT_MNT_OPTS, which
> returns a string of comma separated options, where some characters are
> escaped using the \OOO notation.
>=20
> Add a new flag, STATMOUNT_OPT_ARRAY, which instead returns the raw
> option values separated with '\0' charaters.
>=20
> Since escaped charaters are rare, this inteface is preferable for
> non-libmount users which likley don't want to deal with option
> de-escaping.
>=20
> Example code:
>=20
> 	if (st->mask & STATMOUNT_OPT_ARRAY) {
> 		const char *opt =3D st->str + st->opt_array;
>=20
> 		for (unsigned int i =3D 0; i < st->opt_num; i++) {
> 			printf("opt_array[%i]: <%s>\n", i, opt);
> 			opt +=3D strlen(opt) + 1;
> 		}
> 	}
>=20

If the options are separated by NULs, how does userland know where to
stop?

At some point we will probably end up adding a new string value that
would go after the opt array, and userland will need some way to
clearly tell where that new string begins and the NUL-terminated
options array ends.

> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/namespace.c             | 42 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/mount.h |  7 +++++--
>  2 files changed, 47 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 9a4ab1bc8b94..a16f75011610 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5074,6 +5074,41 @@ static int statmount_mnt_opts(struct kstatmount *s=
, struct seq_file *seq)
>  	return 0;
>  }
> =20
> +static int statmount_opt_array(struct kstatmount *s, struct seq_file *se=
q)
> +{
> +	struct vfsmount *mnt =3D s->mnt;
> +	struct super_block *sb =3D mnt->mnt_sb;
> +	size_t start =3D seq->count;
> +	u32 count =3D 0;
> +	char *p, *end, *next, *u =3D seq->buf + start;
> +	int err;
> +
> +       if (!sb->s_op->show_options)
> +               return 0;
> +
> +       err =3D sb->s_op->show_options(seq, mnt->mnt_root);
> +       if (err)
> +	       return err;
> +
> +       if (unlikely(seq_has_overflowed(seq)))
> +	       return -EAGAIN;
> +
> +       end =3D seq->buf + seq->count;
> +       *end =3D '\0';
> +       for (p =3D u + 1; p < end; p =3D next + 1) {
> +               next =3D strchrnul(p, ',');
> +               *next =3D '\0';
> +               u +=3D string_unescape(p, u, 0, UNESCAPE_OCTAL) + 1;
> +	       count++;
> +	       if (!count)
> +		       return -EOVERFLOW;
> +       }
> +       seq->count =3D u - 1 - seq->buf;
> +       s->sm.opt_num =3D count;
> +
> +       return 0;
> +}
> +
>  static int statmount_string(struct kstatmount *s, u64 flag)
>  {
>  	int ret =3D 0;
> @@ -5099,6 +5134,10 @@ static int statmount_string(struct kstatmount *s, =
u64 flag)
>  		sm->mnt_opts =3D start;
>  		ret =3D statmount_mnt_opts(s, seq);
>  		break;
> +	case STATMOUNT_OPT_ARRAY:
> +		sm->opt_array =3D start;
> +		ret =3D statmount_opt_array(s, seq);
> +		break;
>  	case STATMOUNT_FS_SUBTYPE:
>  		sm->fs_subtype =3D start;
>  		statmount_fs_subtype(s, seq);
> @@ -5252,6 +5291,9 @@ static int do_statmount(struct kstatmount *s, u64 m=
nt_id, u64 mnt_ns_id,
>  	if (!err && s->mask & STATMOUNT_MNT_OPTS)
>  		err =3D statmount_string(s, STATMOUNT_MNT_OPTS);
> =20
> +	if (!err && s->mask & STATMOUNT_OPT_ARRAY)
> +		err =3D statmount_string(s, STATMOUNT_OPT_ARRAY);
> +
>  	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
>  		err =3D statmount_string(s, STATMOUNT_FS_SUBTYPE);
> =20
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 2b49e9131d77..c0fda4604187 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -154,7 +154,7 @@ struct mount_attr {
>   */
>  struct statmount {
>  	__u32 size;		/* Total size, including strings */
> -	__u32 mnt_opts;		/* [str] Mount options of the mount */
> +	__u32 mnt_opts;		/* [str] Options (comma separated, escaped) */
>  	__u64 mask;		/* What results were written */
>  	__u32 sb_dev_major;	/* Device ID */
>  	__u32 sb_dev_minor;
> @@ -175,7 +175,9 @@ struct statmount {
>  	__u64 mnt_ns_id;	/* ID of the mount namespace */
>  	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
>  	__u32 sb_source;	/* [str] Source string of the mount */
> -	__u64 __spare2[48];
> +	__u32 opt_num;		/* Number of fs options */
> +	__u32 opt_array;	/* [str] Array of nul terminated fs options */
> +	__u64 __spare2[47];
>  	char str[];		/* Variable size part containing strings */
>  };
> =20
> @@ -211,6 +213,7 @@ struct mnt_id_req {
>  #define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
>  #define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
>  #define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
> +#define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
> =20
>  /*
>   * Special @mnt_id values that can be passed to listmount

--=20
Jeff Layton <jlayton@kernel.org>

