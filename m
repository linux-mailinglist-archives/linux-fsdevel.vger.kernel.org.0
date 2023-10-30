Return-Path: <linux-fsdevel+bounces-1538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C0E7DB9BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 13:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664DE1C20B3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA1A15AE0;
	Mon, 30 Oct 2023 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmeWL7aE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF79815487;
	Mon, 30 Oct 2023 12:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03338C433C8;
	Mon, 30 Oct 2023 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698668315;
	bh=pjvwmMveD0Rl5oeHnCgOSQWlEHgXIC6eubBzyAKJuW4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WmeWL7aEI+1EUPvLdw4G0aYb1xm32YQKLePlBjLDIoaRkInzHZBzCC9twHRlHn6iL
	 Lg4C4O6f+vebKcHpf+fTA7GSZH/GvfAU6cU2HmnyPz+6SUCLLGyvEEeiV+98yRfHKH
	 UvBN/V/tdr/j5tGZMSscy4btSCJVAHpeZz7xUvrCPtsgVyd00qP1uFC3E/63Gg2l5u
	 Tq1HUirFUKxqMBuk5ntA7i8JvDQfS0pWpaWzsn5WkPT1hKghVvOJWj3hIHMxLbDx5p
	 dAIfwTs/5QYS46KSyYDfkBkU3hRq5y1mfLxTGSON/SFMnHvDbAe0cCE8cU3TTPXcJ0
	 4PuDRNHB8O7pQ==
Message-ID: <5cc3b0c8cf428c74c88ae87c6c5556561f40cdaa.camel@kernel.org>
Subject: Re: [RFC][PATCH] get rid of passing callbacks to ceph
 __dentry_leases_walk()
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Date: Mon, 30 Oct 2023 08:18:33 -0400
In-Reply-To: <20231029204635.GV800259@ZenIV>
References: <20231029204635.GV800259@ZenIV>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-10-29 at 20:46 +0000, Al Viro wrote:
> __dentry_leases_walk() is gets a callback and calls it for
> a bunch of denties; there are exactly two callers and
> we already have a flag telling them apart - lwc->dir_lease.
>=20
> Seeing that indirect calls are costly these days, let's
> get rid of the callback and just call the right function
> directly.  Has a side benefit of saner signatures...
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 854cbdd66661..30b06d171a40 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1550,10 +1550,12 @@ struct ceph_lease_walk_control {
>  	unsigned long dir_lease_ttl;
>  };
> =20
> +static int __dir_lease_check(const struct dentry *, struct ceph_lease_wa=
lk_control *);
> +static int __dentry_lease_check(const struct dentry *);
> +
>  static unsigned long
>  __dentry_leases_walk(struct ceph_mds_client *mdsc,
> -		     struct ceph_lease_walk_control *lwc,
> -		     int (*check)(struct dentry*, void*))
> +		     struct ceph_lease_walk_control *lwc)
>  {
>  	struct ceph_dentry_info *di, *tmp;
>  	struct dentry *dentry, *last =3D NULL;
> @@ -1581,7 +1583,10 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
>  			goto next;
>  		}
> =20
> -		ret =3D check(dentry, lwc);
> +		if (lwc->dir_lease)
> +			ret =3D __dir_lease_check(dentry, lwc);
> +		else
> +			ret =3D __dentry_lease_check(dentry);
>  		if (ret & TOUCH) {
>  			/* move it into tail of dir lease list */
>  			__dentry_dir_lease_touch(mdsc, di);
> @@ -1638,7 +1643,7 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
>  	return freed;
>  }
> =20
> -static int __dentry_lease_check(struct dentry *dentry, void *arg)
> +static int __dentry_lease_check(const struct dentry *dentry)
>  {
>  	struct ceph_dentry_info *di =3D ceph_dentry(dentry);
>  	int ret;
> @@ -1653,9 +1658,9 @@ static int __dentry_lease_check(struct dentry *dent=
ry, void *arg)
>  	return DELETE;
>  }
> =20
> -static int __dir_lease_check(struct dentry *dentry, void *arg)
> +static int __dir_lease_check(const struct dentry *dentry,
> +			     struct ceph_lease_walk_control *lwc)
>  {
> -	struct ceph_lease_walk_control *lwc =3D arg;
>  	struct ceph_dentry_info *di =3D ceph_dentry(dentry);
> =20
>  	int ret =3D __dir_lease_try_check(dentry);
> @@ -1694,7 +1699,7 @@ int ceph_trim_dentries(struct ceph_mds_client *mdsc=
)
> =20
>  	lwc.dir_lease =3D false;
>  	lwc.nr_to_scan  =3D CEPH_CAPS_PER_RELEASE * 2;
> -	freed =3D __dentry_leases_walk(mdsc, &lwc, __dentry_lease_check);
> +	freed =3D __dentry_leases_walk(mdsc, &lwc);
>  	if (!lwc.nr_to_scan) /* more invalid leases */
>  		return -EAGAIN;
> =20
> @@ -1704,7 +1709,7 @@ int ceph_trim_dentries(struct ceph_mds_client *mdsc=
)
>  	lwc.dir_lease =3D true;
>  	lwc.expire_dir_lease =3D freed < count;
>  	lwc.dir_lease_ttl =3D mdsc->fsc->mount_options->caps_wanted_delay_max *=
 HZ;
> -	freed +=3D__dentry_leases_walk(mdsc, &lwc, __dir_lease_check);
> +	freed +=3D__dentry_leases_walk(mdsc, &lwc);
>  	if (!lwc.nr_to_scan) /* more to check */
>  		return -EAGAIN;
> =20
>=20

Nice cleanup.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

