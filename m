Return-Path: <linux-fsdevel+bounces-33784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208C79BEF90
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 14:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448EB1C232E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2A201011;
	Wed,  6 Nov 2024 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxh6O2Bx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693001DEFD7;
	Wed,  6 Nov 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901377; cv=none; b=O5cdXqNPr6XwPS7N3U0s3SzCdGkPDGF8d7UvZ58eDFf1BiOITPJWbyuBbcM7u9XU87ho90YxqbR7d0EqunbtKlSY9E8/1WDgOofOU4a8O+rM4FKQZOmriThhEpcDbwk6+j7A38v5mW3JIyt7etjbtJ/JYIJTp6wQNRMIHTWqjNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901377; c=relaxed/simple;
	bh=x/rx0P97GGVaU2cesfyl5jCbORsZFflKG0og0UKGsI4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lL23BvIUDKWsPpIdGpNd7tg148ACeZ5xf2Urcw9zoD6Ujxb3kWG/2SFDcKWdxzTdfYn2VqM2/BUv2+CR6FD8My5sTjo/ygs7GhM18948ClgVUxT79C9sqIDSHNhF5jvMp/qWcXBuM2fGSW6SZ91REBJPqm/o3hA54tvkDEVqhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kxh6O2Bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBBDC4CECC;
	Wed,  6 Nov 2024 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730901377;
	bh=x/rx0P97GGVaU2cesfyl5jCbORsZFflKG0og0UKGsI4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Kxh6O2Bx99221H0vH0Jm1ukGN+4mU2A1pmURJBIPADRWePpRfmoFfWwp0vktTEwO/
	 3Qox4Ktv7duV8u1mCZTfSYCf0B2SrCtX3Fz0p+wSroQ0yAy2muqhZ8JUVmGD1oKCDO
	 FMNWXAPDZQRrNt7D7pEJ0tT+SXyZFtH8IHejqT/ztZPemCPX8p8XUksgnxaxDpJKZT
	 HuLyU/WuP/RsIHmGGWKwKhr0zIxNXTTWi1ds0dNjMtPEMgdlEMVRxu5OwADV2YRGrM
	 scskbOK+KalQQLeqyAneY9oD3eqyxaGC2ojO2nvRa+jWqmVL0jjRcNp0rd7GzsSPCU
	 QhUn3iufUDRew==
Message-ID: <82931e78305da9561b668e411d4ac09f4d73d6f1.camel@kernel.org>
Subject: Re: [PATCH] fs: add the ability for statmount() to report the
 fs_subtype
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	 <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Nov 2024 08:56:15 -0500
In-Reply-To: <20241106133715.ellv3pf7ekz34fmi@quack3>
References: <20241106-statmount-v1-1-b93bafd97621@kernel.org>
	 <20241106133715.ellv3pf7ekz34fmi@quack3>
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

On Wed, 2024-11-06 at 14:37 +0100, Jan Kara wrote:
> On Wed 06-11-24 08:29:19, Jeff Layton wrote:
> > /proc/self/mountinfo prints out the sb->s_subtype after the type. In
> > particular, FUSE makes use of this to display the fstype as
> > fuse.<subtype>.
> >=20
> > Add STATMOUNT_FS_SUBTYPE and claim one of the __spare2 fields to point
> > to the offset into the str[] array. The STATMOUNT_FS_SUBTYPE will only
> > be set in the return mask if there is a subtype associated with the
> > mount.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Looks good to me. I'm just curious: Do you have any particular user that =
is
> interested in getting subtype from statmount(2)?
>=20
>=20

Thanks! Can I count that as a R-b?

Meta does. They have some logging internally that tracks mounts, and
knowing what sort of FUSE mounts they have is useful info (when the
driver bothers to fill out the field anyway).

>=20
> > ---
> >  fs/namespace.c             | 20 +++++++++++++++++++-
> >  include/uapi/linux/mount.h |  5 ++++-
> >  2 files changed, 23 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index ba77ce1c6788dfe461814b5826fcbb3aab68fad4..5f2fb692449a9c0a15b6054=
9fb9f7bedd10f1f3d 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -5006,6 +5006,14 @@ static int statmount_fs_type(struct kstatmount *=
s, struct seq_file *seq)
> >  	return 0;
> >  }
> > =20
> > +static int statmount_fs_subtype(struct kstatmount *s, struct seq_file =
*seq)
> > +{
> > +	struct super_block *sb =3D s->mnt->mnt_sb;
> > +
> > +	seq_puts(seq, sb->s_subtype);
> > +	return 0;
> > +}
> > +
> >  static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_names=
pace *ns)
> >  {
> >  	s->sm.mask |=3D STATMOUNT_MNT_NS_ID;
> > @@ -5064,6 +5072,13 @@ static int statmount_string(struct kstatmount *s=
, u64 flag)
> >  		sm->mnt_opts =3D seq->count;
> >  		ret =3D statmount_mnt_opts(s, seq);
> >  		break;
> > +	case STATMOUNT_FS_SUBTYPE:
> > +		/* ignore if no s_subtype */
> > +		if (!s->mnt->mnt_sb->s_subtype)
> > +			return 0;
> > +		sm->fs_subtype =3D seq->count;
> > +		ret =3D statmount_fs_subtype(s, seq);
> > +		break;
> >  	default:
> >  		WARN_ON_ONCE(true);
> >  		return -EINVAL;
> > @@ -5203,6 +5218,9 @@ static int do_statmount(struct kstatmount *s, u64=
 mnt_id, u64 mnt_ns_id,
> >  	if (!err && s->mask & STATMOUNT_MNT_OPTS)
> >  		err =3D statmount_string(s, STATMOUNT_MNT_OPTS);
> > =20
> > +	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
> > +		err =3D statmount_string(s, STATMOUNT_FS_SUBTYPE);
> > +
> >  	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
> >  		statmount_mnt_ns_id(s, ns);
> > =20
> > @@ -5224,7 +5242,7 @@ static inline bool retry_statmount(const long ret=
, size_t *seq_size)
> >  }
> > =20
> >  #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT=
 | \
> > -			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS)
> > +			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | STATMOUNT_FS_SUBTYPE=
)
> > =20
> >  static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req=
 *kreq,
> >  			      struct statmount __user *buf, size_t bufsize,
> > diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> > index 225bc366ffcbf0319929e2f55f1fbea88e4d7b81..fa206fb56b3b25cf80f7d43=
0e1b6bab19c3220e4 100644
> > --- a/include/uapi/linux/mount.h
> > +++ b/include/uapi/linux/mount.h
> > @@ -173,7 +173,9 @@ struct statmount {
> >  	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
> >  	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
> >  	__u64 mnt_ns_id;	/* ID of the mount namespace */
> > -	__u64 __spare2[49];
> > +	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
> > +	__u32 __spare1[1];
> > +	__u64 __spare2[48];
> >  	char str[];		/* Variable size part containing strings */
> >  };
> > =20
> > @@ -207,6 +209,7 @@ struct mnt_id_req {
> >  #define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
> >  #define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
> >  #define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
> > +#define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got subtype */
> > =20
> >  /*
> >   * Special @mnt_id values that can be passed to listmount
> >=20
> > ---
> > base-commit: 26213e1a6caa5a7f508b919059b0122b451f4dfe
> > change-id: 20241106-statmount-3f91a7ed75fa
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

