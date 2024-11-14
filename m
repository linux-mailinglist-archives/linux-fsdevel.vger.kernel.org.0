Return-Path: <linux-fsdevel+bounces-34797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE719C8D4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829FC1F24538
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 14:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B717603A;
	Thu, 14 Nov 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ohjkqg3k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898D1BA53;
	Thu, 14 Nov 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595904; cv=none; b=M9JXiXfe8yBkEF1rPmzZDU2VefSXgKzw+eFLa4AdiLFo0O0HGj/atIUApnfKq5ah4bvAFkQhbtQIYXURdBmZX+9wRfJ4TV1VcXR8YBqcAJWNWMN7dyJGjpqwGd5IWFBOPt83NLCUCUwOPg/RlwPYSfYfEUgDQKID29aFKimvWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595904; c=relaxed/simple;
	bh=xp+Bhxv5r8EcpXhSA5YmDDGrAUJ46l9ijkOPI3rtDuE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K6XBmdUN5um5M00uy1nQaf88Q+IhALIVpoBhoqNOq7zxe3FoHaGcpLUmZV95u+mySvsfJLDlqKV7NH3G1LG45WJhBD0IzwJwq1mke3nWRDNHlAS7QXEwbdtCD9XLkzsvhUOriVOXtGkx0fSvMfywfMDEMqG8NCrl7Yn5wY9EO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ohjkqg3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCF1C4CED0;
	Thu, 14 Nov 2024 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731595904;
	bh=xp+Bhxv5r8EcpXhSA5YmDDGrAUJ46l9ijkOPI3rtDuE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ohjkqg3k26ZBOHzonCipDDOtzN7G3v51H2jrzEPYCfzIYiuKndV6s6gekbdea4GPp
	 QoUa7xuiz/oONizMjRuOWNvoJdgH6oOgjnTkH1ZZfCMRgwASN3utEJQGERb8SWwMWs
	 A+VDCZysUNq/QQEkplQ/o1P2tdUjVcJPIlSRMkXMSXlsryTiB+Fm+kgX8C6eBwjmhi
	 OyG6lLWc31d9fWY4zy0RRuyAee8R/qGoV0ZwBymjp8aLiAAog5fr7AqBud8uXWAGp9
	 eeK5x0QUAL1VuKnDwzkut1AS+Rr5EKpgD61IcuB0wSUYVW9oFJ5KYCrYZfNuEG+QhE
	 zp4ma9qojzqpg==
Message-ID: <d65340299e27ea3f187f05002c1d30d4c9fe8bf8.camel@kernel.org>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and
 sb_source
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <miklos@szeredi.hu>
Cc: Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, Josef Bacik
 <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>
Date: Thu, 14 Nov 2024 09:51:42 -0500
In-Reply-To: <20241114-oberteil-villen-419f96aad840@brauner>
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
	 <20241112-antiseptisch-kinowelt-6634948a413e@brauner>
	 <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
	 <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org>
	 <20241114-umzog-garage-b1c1bb8b80f2@brauner>
	 <3e6454f8a6b9176e9e1f98523be35f8eb6457eba.camel@kernel.org>
	 <CAJfpegtZ6hiars5+JHCr6TEj=TgFFpFbk_TVM_b=YNpbLG0=ig@mail.gmail.com>
	 <20241114-oberteil-villen-419f96aad840@brauner>
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

On Thu, 2024-11-14 at 15:48 +0100, Christian Brauner wrote:
> On Thu, Nov 14, 2024 at 02:16:05PM +0100, Miklos Szeredi wrote:
> > On Thu, 14 Nov 2024 at 13:29, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > > Ordinarily, I might agree, but we're now growing a new mount option
> > > field that has them separated by NULs. Will we need two extra fields
> > > for this? One comma-separated, and one NUL separated?
> > >=20
> > > /proc/#/mountinfo and mounts prepend these to the output of
> > > ->show_options, so the simple solution would be to just prepend those
> > > there instead of adding a new field. FWIW, only SELinux has any extra
> > > mount options to show here.
> >=20
> > Compromise: tack them onto the end of the comma separated list, but
> > add a new field for the nul separated security options.
> >=20
> > I think this would be logical, since the comma separated list is more
> > useful for having a /proc/$$/mountinfo compatible string than for
> > actually interpreting what's in there.
>=20
> Fair. Here's an incremental for the array of security options.
>=20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 4f39c4aba85d..a9065a9ab971 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5072,13 +5072,30 @@ static int statmount_mnt_opts(struct kstatmount *=
s, struct seq_file *seq)
>  	return 0;
>  }
> =20
> +static inline int statmount_opt_unescape(struct seq_file *seq, char *buf=
_start)
> +{
> +	char *buf_end, *opt_start, *opt_end;
> +	int count =3D 0;
> +
> +	buf_end =3D seq->buf + seq->count;
> +	*buf_end =3D '\0';
> +	for (opt_start =3D buf_start + 1; opt_start < buf_end; opt_start =3D op=
t_end + 1) {
> +		opt_end =3D strchrnul(opt_start, ',');
> +		*opt_end =3D '\0';
> +		buf_start +=3D string_unescape(opt_start, buf_start, 0, UNESCAPE_OCTAL=
) + 1;
> +		if (WARN_ON_ONCE(++count =3D=3D INT_MAX))
> +			return -EOVERFLOW;
> +	}
> +	seq->count =3D buf_start - 1 - seq->buf;
> +	return count;
> +}
> +
>  static int statmount_opt_array(struct kstatmount *s, struct seq_file *se=
q)
>  {
>  	struct vfsmount *mnt =3D s->mnt;
>  	struct super_block *sb =3D mnt->mnt_sb;
>  	size_t start =3D seq->count;
> -	char *buf_start, *buf_end, *opt_start, *opt_end;
> -	u32 count =3D 0;
> +	char *buf_start;
>  	int err;
> =20
>  	if (!sb->s_op->show_options)
> @@ -5095,17 +5112,39 @@ static int statmount_opt_array(struct kstatmount =
*s, struct seq_file *seq)
>  	if (seq->count =3D=3D start)
>  		return 0;
> =20
> -	buf_end =3D seq->buf + seq->count;
> -	*buf_end =3D '\0';
> -	for (opt_start =3D buf_start + 1; opt_start < buf_end; opt_start =3D op=
t_end + 1) {
> -		opt_end =3D strchrnul(opt_start, ',');
> -		*opt_end =3D '\0';
> -		buf_start +=3D string_unescape(opt_start, buf_start, 0, UNESCAPE_OCTAL=
) + 1;
> -		if (WARN_ON_ONCE(++count =3D=3D 0))
> -			return -EOVERFLOW;
> -	}
> -	seq->count =3D buf_start - 1 - seq->buf;
> -	s->sm.opt_num =3D count;
> +	err =3D statmount_opt_unescape(seq, buf_start);
> +	if (err < 0)
> +		return err;
> +
> +	s->sm.opt_num =3D err;
> +	return 0;
> +}
> +
> +static int statmount_opt_sec_array(struct kstatmount *s, struct seq_file=
 *seq)
> +{
> +	struct vfsmount *mnt =3D s->mnt;
> +	struct super_block *sb =3D mnt->mnt_sb;
> +	size_t start =3D seq->count;
> +	char *buf_start;
> +	int err;
> +
> +	buf_start =3D seq->buf + start;
> +
> +	err =3D security_sb_show_options(seq, sb);
> +	if (!err)
> +		return err;
> +
> +	if (unlikely(seq_has_overflowed(seq)))
> +		return -EAGAIN;
> +
> +	if (seq->count =3D=3D start)
> +		return 0;
> +
> +	err =3D statmount_opt_unescape(seq, buf_start);
> +	if (err < 0)
> +		return err;
> +
> +	s->sm.opt_sec_num =3D err;
>  	return 0;
>  }
> =20
> @@ -5138,6 +5177,10 @@ static int statmount_string(struct kstatmount *s, =
u64 flag)
>  		sm->opt_array =3D start;
>  		ret =3D statmount_opt_array(s, seq);
>  		break;
> +	case STATMOUNT_OPT_SEC_ARRAY:
> +		sm->opt_sec_array =3D start;
> +		ret =3D statmount_opt_sec_array(s, seq);
> +		break;
>  	case STATMOUNT_FS_SUBTYPE:
>  		sm->fs_subtype =3D start;
>  		statmount_fs_subtype(s, seq);
> @@ -5294,6 +5337,9 @@ static int do_statmount(struct kstatmount *s, u64 m=
nt_id, u64 mnt_ns_id,
>  	if (!err && s->mask & STATMOUNT_OPT_ARRAY)
>  		err =3D statmount_string(s, STATMOUNT_OPT_ARRAY);
> =20
> +	if (!err && s->mask & STATMOUNT_OPT_SEC_ARRAY)
> +		err =3D statmount_string(s, STATMOUNT_OPT_SEC_ARRAY);
> +
>  	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
>  		err =3D statmount_string(s, STATMOUNT_FS_SUBTYPE);
> =20
> @@ -5323,7 +5369,7 @@ static inline bool retry_statmount(const long ret, =
size_t *seq_size)
>  #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT |=
 \
>  			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | \
>  			      STATMOUNT_FS_SUBTYPE | STATMOUNT_SB_SOURCE | \
> -			      STATMOUNT_OPT_ARRAY)
> +			      STATMOUNT_OPT_ARRAY | STATMOUNT_OPT_SEC_ARRAY)
> =20
>  static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *=
kreq,
>  			      struct statmount __user *buf, size_t bufsize,
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index c0fda4604187..569d938a5757 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -177,7 +177,9 @@ struct statmount {
>  	__u32 sb_source;	/* [str] Source string of the mount */
>  	__u32 opt_num;		/* Number of fs options */
>  	__u32 opt_array;	/* [str] Array of nul terminated fs options */
> -	__u64 __spare2[47];
> +	__u32 opt_sec_num;	/* Number of security options */
> +	__u32 opt_sec_array;	/* [str] Array of nul terminated security options =
*/
> +	__u64 __spare2[45];

shouldn't that be 46 ?

>  	char str[];		/* Variable size part containing strings */
>  };
> =20
> @@ -214,6 +216,7 @@ struct mnt_id_req {
>  #define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
>  #define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
>  #define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
> +#define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
> =20
>  /*
>   * Special @mnt_id values that can be passed to listmount

The rest looks good to me though!
--=20
Jeff Layton <jlayton@kernel.org>

