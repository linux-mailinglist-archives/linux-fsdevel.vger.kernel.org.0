Return-Path: <linux-fsdevel+bounces-28771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3477496E155
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E56DB2143B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29CD15689A;
	Thu,  5 Sep 2024 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkuhJ5dE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3B1C2E;
	Thu,  5 Sep 2024 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558377; cv=none; b=qVQ058oJfDdoRHEqsKIL1JNd6ahAsdc5ihjWgtbgwqBg3uLfQafdzX5dBR62mXs0K6GjhncQJVvOJ09SZ9M+MIvrkVDu0ZmZ3pv3sP37tR5Pd3spizCbdd7TD41gUIDOSCeACOGd0mOOe3tBPSYN2eH/WTyVHRNRhAMvILawPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558377; c=relaxed/simple;
	bh=OuKJvkHhw4bBeupAGb2gNMqTJ9MxH6quUMlr3VCYPF0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKfJwWTvwynNY7A9Ubo9aZS7e0Pkr9adk4EQ5tQsJmHo6QnOyRuFADo6oJrmR/ls8m2Lxe/DvfNo4hmVD6UEWQbGO4i83RZYllQAJ1dz+wEu+dZquXLyOnZyHcaK0J4XyxhRg6hLl8K7PTFqlVQiNYZxDqpj5b8MHy4c3ACnMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkuhJ5dE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200B9C4CEC6;
	Thu,  5 Sep 2024 17:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725558376;
	bh=OuKJvkHhw4bBeupAGb2gNMqTJ9MxH6quUMlr3VCYPF0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZkuhJ5dEjieQpnnBMmLjY4CKuuQZcG+TntuQjyG8uU/jEBk5IA8orjjYgTQy37Ow8
	 tGdPfAH8kvI66vN/RTqBA/8MyswWakUcijtj3J93WPPGqVt1+vVkv6DcyrixOGftsx
	 YrsC9vX5H31QDQ3vE8RBiDZSj42F8vXaCYksqeexEaSeVMVXpPs6XJ4HndV8goUIzF
	 c1VVXUQnOV/JUHysPmVzHEYxVxQTX9T1fc/qFI0X2SZpmnVdlNPRJKR/APzTjoGodJ
	 +xzH5p9oDpNyolv+mu88wEwAw9cy3pdeskJZowYuL86AYtsfggBl6yQ5BfTemB2ADr
	 74gMCjCTc9NIA==
Message-ID: <c955b19c00026a2237c9224c8224f1ac6f249d4c.camel@kernel.org>
Subject: Re: [PATCH v4 09/11] fs: handle delegated timestamps in
 setattr_copy_mgtime
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Christian Brauner
 <brauner@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>,  Anna Schumaker <anna@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Tom Haynes <loghyr@gmail.com>,  linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Date: Thu, 05 Sep 2024 13:46:14 -0400
In-Reply-To: <ZtnR7x6pYz1x7LvK@tissot.1015granger.net>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
	 <20240905-delstid-v4-9-d3e5fd34d107@kernel.org>
	 <ZtnR7x6pYz1x7LvK@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-05 at 11:44 -0400, Chuck Lever wrote:
> On Thu, Sep 05, 2024 at 08:41:53AM -0400, Jeff Layton wrote:
> > When updating the ctime on an inode for a SETATTR with a multigrain
> > filesystem, we usually want to take the latest time we can get for the
> > ctime. The exception to this rule is when there is a nfsd write
> > delegation and the server is proxying timestamps from the client.
> >=20
> > When nfsd gets a CB_GETATTR response, we want to update the timestamp
> > value in the inode to the values that the client is tracking. The clien=
t
> > doesn't send a ctime value (since that's always determined by the
> > exported filesystem), but it can send a mtime value. In the case where
> > it does, then we may need to update the ctime to a value commensurate
> > with that instead of the current time.
> >=20
> > If ATTR_DELEG is set, then use ia_ctime value instead of setting the
> > timestamp to the current time.
> >=20
> > With the addition of delegated timestamps we can also receive a request
> > to update only the atime, but we may not need to set the ctime. Trust
> > the ATTR_CTIME flag in the update and only update the ctime when it's
> > set.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/attr.c          | 28 +++++++++++++--------
> >  fs/inode.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/fs.h |  2 ++
> >  3 files changed, 94 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/fs/attr.c b/fs/attr.c
> > index 3bcbc45708a3..392eb62aa609 100644
> > --- a/fs/attr.c
> > +++ b/fs/attr.c
> > @@ -286,16 +286,20 @@ static void setattr_copy_mgtime(struct inode *ino=
de, const struct iattr *attr)
> >  	unsigned int ia_valid =3D attr->ia_valid;
> >  	struct timespec64 now;
> > =20
> > -	/*
> > -	 * If the ctime isn't being updated then nothing else should be
> > -	 * either.
> > -	 */
> > -	if (!(ia_valid & ATTR_CTIME)) {
> > -		WARN_ON_ONCE(ia_valid & (ATTR_ATIME|ATTR_MTIME));
> > -		return;
> > +	if (ia_valid & ATTR_CTIME) {
> > +		/*
> > +		 * In the case of an update for a write delegation, we must respect
> > +		 * the value in ia_ctime and not use the current time.
> > +		 */
> > +		if (ia_valid & ATTR_DELEG)
> > +			now =3D inode_set_ctime_deleg(inode, attr->ia_ctime);
> > +		else
> > +			now =3D inode_set_ctime_current(inode);
> > +	} else {
> > +		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
> > +		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
> >  	}
> > =20
> > -	now =3D inode_set_ctime_current(inode);
> >  	if (ia_valid & ATTR_ATIME_SET)
> >  		inode_set_atime_to_ts(inode, attr->ia_atime);
> >  	else if (ia_valid & ATTR_ATIME)
> > @@ -354,8 +358,12 @@ void setattr_copy(struct mnt_idmap *idmap, struct =
inode *inode,
> >  		inode_set_atime_to_ts(inode, attr->ia_atime);
> >  	if (ia_valid & ATTR_MTIME)
> >  		inode_set_mtime_to_ts(inode, attr->ia_mtime);
> > -	if (ia_valid & ATTR_CTIME)
> > -		inode_set_ctime_to_ts(inode, attr->ia_ctime);
> > +	if (ia_valid & ATTR_CTIME) {
> > +		if (ia_valid & ATTR_DELEG)
> > +			inode_set_ctime_deleg(inode, attr->ia_ctime);
> > +		else
> > +			inode_set_ctime_to_ts(inode, attr->ia_ctime);
> > +	}
> >  }
> >  EXPORT_SYMBOL(setattr_copy);
> > =20
>=20
> This patch fails to apply cleanly to my copy of nfsd-next:
>=20
>   error: `git apply --index`: error: patch failed: fs/attr.c:286
>   error: fs/attr.c: patch does not apply
>=20
> Before I try jiggling this to get it to apply, is there anything
> I should know? I worry about a potential merge conflict here,
> hopefully it will be no more complicated than that.
>=20
>=20

This is based on a combo of your nfsd-next branch and Christian's
vfs.mgtime branch. This patch in particular depends on the multigrain
patches in his tree.

I think we can just drop this patch from the series in your tree, and
I'll get Christian to pick it up in his tree. The ctime setting will be
a bit racy without it but everything should still work.

Sound ok? Christian, are you OK with picking this up in vfs.mgtime?

> > diff --git a/fs/inode.c b/fs/inode.c
> > index 01f7df1973bd..f0fbfd470d8e 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -2835,6 +2835,80 @@ struct timespec64 inode_set_ctime_current(struct=
 inode *inode)
> >  }
> >  EXPORT_SYMBOL(inode_set_ctime_current);
> > =20
> > +/**
> > + * inode_set_ctime_deleg - try to update the ctime on a delegated inod=
e
> > + * @inode: inode to update
> > + * @update: timespec64 to set the ctime
> > + *
> > + * Attempt to atomically update the ctime on behalf of a delegation ho=
lder.
> > + *
> > + * The nfs server can call back the holder of a delegation to get upda=
ted
> > + * inode attributes, including the mtime. When updating the mtime we m=
ay
> > + * need to update the ctime to a value at least equal to that.
> > + *
> > + * This can race with concurrent updates to the inode, in which
> > + * case we just don't do the update.
> > + *
> > + * Note that this works even when multigrain timestamps are not enable=
d,
> > + * so use it in either case.
> > + */
> > +struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct ti=
mespec64 update)
> > +{
> > +	ktime_t now, floor =3D atomic64_read(&ctime_floor);
> > +	struct timespec64 now_ts, cur_ts;
> > +	u32 cur, old;
> > +
> > +	/* pairs with try_cmpxchg below */
> > +	cur =3D smp_load_acquire(&inode->i_ctime_nsec);
> > +	cur_ts.tv_nsec =3D cur & ~I_CTIME_QUERIED;
> > +	cur_ts.tv_sec =3D inode->i_ctime_sec;
> > +
> > +	/* If the update is older than the existing value, skip it. */
> > +	if (timespec64_compare(&update, &cur_ts) <=3D 0)
> > +		return cur_ts;
> > +
> > +	now =3D coarse_ctime(floor);
> > +	now_ts =3D ktime_to_timespec64(now);
> > +
> > +	/* Clamp the update to "now" if it's in the future */
> > +	if (timespec64_compare(&update, &now_ts) > 0)
> > +		update =3D now_ts;
> > +
> > +	update =3D timestamp_truncate(update, inode);
> > +
> > +	/* No need to update if the values are already the same */
> > +	if (timespec64_equal(&update, &cur_ts))
> > +		return cur_ts;
> > +
> > +	/*
> > +	 * Try to swap the nsec value into place. If it fails, that means
> > +	 * we raced with an update due to a write or similar activity. That
> > +	 * stamp takes precedence, so just skip the update.
> > +	 */
> > +retry:
> > +	old =3D cur;
> > +	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, update.tv_nsec)) {
> > +		inode->i_ctime_sec =3D update.tv_sec;
> > +		mgtime_counter_inc(mg_ctime_swaps);
> > +		return update;
> > +	}
> > +
> > +	/*
> > +	 * Was the change due to someone marking the old ctime QUERIED?
> > +	 * If so then retry the swap. This can only happen once since
> > +	 * the only way to clear I_CTIME_QUERIED is to stamp the inode
> > +	 * with a new ctime.
> > +	 */
> > +	if (!(old & I_CTIME_QUERIED) && (cur =3D=3D (old | I_CTIME_QUERIED)))
> > +		goto retry;
> > +
> > +	/* Otherwise, it was a new timestamp. */
> > +	cur_ts.tv_sec =3D inode->i_ctime_sec;
> > +	cur_ts.tv_nsec =3D cur & ~I_CTIME_QUERIED;
> > +	return cur_ts;
> > +}
> > +EXPORT_SYMBOL(inode_set_ctime_deleg);
> > +
> >  /**
> >   * in_group_or_capable - check whether caller is CAP_FSETID privileged
> >   * @idmap:	idmap of the mount @inode was found from
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index eff688e75f2f..ea7ed437d2b1 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1544,6 +1544,8 @@ static inline bool fsuidgid_has_mapping(struct su=
per_block *sb,
> > =20
> >  struct timespec64 current_time(struct inode *inode);
> >  struct timespec64 inode_set_ctime_current(struct inode *inode);
> > +struct timespec64 inode_set_ctime_deleg(struct inode *inode,
> > +					struct timespec64 update);
> > =20
> >  static inline time64_t inode_get_atime_sec(const struct inode *inode)
> >  {
> >=20
> > --=20
> > 2.46.0
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

