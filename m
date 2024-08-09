Return-Path: <linux-fsdevel+bounces-25492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D956594C79D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 02:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E291F214DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 00:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D203033D1;
	Fri,  9 Aug 2024 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lngIqQXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371AD23BB;
	Fri,  9 Aug 2024 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723163360; cv=none; b=gPDTmr5J4Fm1s4+g6ph2XKSlf9u6HpPjcAut5F4gvAYNm2xGXmJqUv4PuyeHoPfLB+DsfcJAGncnkcJkmN2EtjJo7SvUekHTDgvPrQoF6TxiY6Bhx4Yg2I9rubKw0wB7UweHRxoCmwZtSR57klBJbr9BVFGdog3m6DoFTwWaDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723163360; c=relaxed/simple;
	bh=L7N8uUVHrw09j7LRpNUl7Yt1FGkSGaZzLOi9UF1nk2M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SbOSM+1jgnb5uB4xi/uVaCUiUOUfiWtsGcZwwPfDgQB0aV87VxjLM1ykComERDXFKMK2HjhQsgHYb/6nCzE4h1iL50UR+HmU79hMc0bV5FuEF2wjWdUTXP03k3WmjMAQSwD7g+BVintCAkKdGEF0j3jxvanTipg/GSTNLLdj3KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lngIqQXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C8BC32782;
	Fri,  9 Aug 2024 00:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723163359;
	bh=L7N8uUVHrw09j7LRpNUl7Yt1FGkSGaZzLOi9UF1nk2M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lngIqQXfmlcSY2j3GFiGEAdUGfPfAJdmJLFa+hie1nPcmrkKY0TryHDe0YL2vq8d2
	 aysHqGT1AxOiWvMgeAQ6yaKOm+OwV3W5Ac0dOLnwnbzk8U8XtafNnrKzmYtZoPnCqf
	 DTwk3JLq1G6J+s7gTOrvS9utxiKNDrsrtTdy05xdw2PZDwSCb8ICGVbAC2SLMhrtIZ
	 RXlDlue17G2ozZF8t5LV9X3/dm5EaFu27pE08AVJXQgJiHNWuoxAn7DaRdP92NqgH+
	 /XLVgkxNtxXJO7XEx55oBoSCjBG+ABUjPN5RM1c75hq5fQG8BCQrEvgC7LYV5b5YXS
	 U0xE4/u6A8NEg==
Message-ID: <165c8f15eec4412cf76f46fcff794ae1792ac8db.camel@kernel.org>
Subject: Re: [PATCH v6 1/9] fs: add infrastructure for multigrain timestamps
From: Jeff Layton <jlayton@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 08 Aug 2024 20:29:18 -0400
In-Reply-To: <gcn5kkrc2eeger6uzwqe5iinxtevhrgi3qz6ru3th3bkt4nrfd@ldkkwu4ndpnn>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
	 <20240715-mgtime-v6-1-48e5d34bd2ba@kernel.org>
	 <gcn5kkrc2eeger6uzwqe5iinxtevhrgi3qz6ru3th3bkt4nrfd@ldkkwu4ndpnn>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-09 at 01:43 +0200, Mateusz Guzik wrote:
> On Mon, Jul 15, 2024 at 08:48:52AM -0400, Jeff Layton wrote:
> >  /**
> >   * inode_set_ctime_current - set the ctime to current_time
> >   * @inode: inode
> >   *
> > - * Set the inode->i_ctime to the current value for the inode. Returns
> > - * the current value that was assigned to i_ctime.
> > + * Set the inode's ctime to the current value for the inode. Returns t=
he
> > + * current value that was assigned. If this is not a multigrain inode,=
 then we
> > + * just set it to whatever the coarse_ctime is.
> > + *
> > + * If it is multigrain, then we first see if the coarse-grained timest=
amp is
> > + * distinct from what we have. If so, then we'll just use that. If we =
have to
> > + * get a fine-grained timestamp, then do so, and try to swap it into t=
he floor.
> > + * We accept the new floor value regardless of the outcome of the cmpx=
chg.
> > + * After that, we try to swap the new value into i_ctime_nsec. Again, =
we take
> > + * the resulting ctime, regardless of the outcome of the swap.
> >   */
> >  struct timespec64 inode_set_ctime_current(struct inode *inode)
> >  {
> > -	struct timespec64 now =3D current_time(inode);
> > +	ktime_t now, floor =3D atomic64_read(&ctime_floor);
> > +	struct timespec64 now_ts;
> > +	u32 cns, cur;
> > +
> > +	now =3D coarse_ctime(floor);
> > +
> > +	/* Just return that if this is not a multigrain fs */
> > +	if (!is_mgtime(inode)) {
> > +		now_ts =3D timestamp_truncate(ktime_to_timespec64(now), inode);
> > +		inode_set_ctime_to_ts(inode, now_ts);
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * We only need a fine-grained time if someone has queried it,
> > +	 * and the current coarse grained time isn't later than what's
> > +	 * already there.
> > +	 */
> > +	cns =3D smp_load_acquire(&inode->i_ctime_nsec);
> > +	if (cns & I_CTIME_QUERIED) {
> > +		ktime_t ctime =3D ktime_set(inode->i_ctime_sec, cns & ~I_CTIME_QUERI=
ED);
> > +
> > +		if (!ktime_after(now, ctime)) {
> > +			ktime_t old, fine;
> > +
> > +			/* Get a fine-grained time */
> > +			fine =3D ktime_get();
> > =20
> > -	inode_set_ctime_to_ts(inode, now);
> > -	return now;
> > +			/*
> > +			 * If the cmpxchg works, we take the new floor value. If
> > +			 * not, then that means that someone else changed it after we
> > +			 * fetched it but before we got here. That value is just
> > +			 * as good, so keep it.
> > +			 */
> > +			old =3D floor;
> > +			if (!atomic64_try_cmpxchg(&ctime_floor, &old, fine))
> > +				fine =3D old;
> > +			now =3D ktime_mono_to_real(fine);
> > +		}
> > +	}
> > +	now_ts =3D timestamp_truncate(ktime_to_timespec64(now), inode);
> > +	cur =3D cns;
> > +
> > +	/* No need to cmpxchg if it's exactly the same */
> > +	if (cns =3D=3D now_ts.tv_nsec && inode->i_ctime_sec =3D=3D now_ts.tv_=
sec)
> > +		goto out;
> > +retry:
> > +	/* Try to swap the nsec value into place. */
> > +	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now_ts.tv_nsec)) {
> > +		/* If swap occurred, then we're (mostly) done */
> > +		inode->i_ctime_sec =3D now_ts.tv_sec;
>=20
>=20
> Linux always had rather lax approach to consistency of getattr results
> and I wonder if with this patchset it is no longer viable.
>=20
> Ignoring the flag, suppose ctime on the inode is { nsec =3D 12, sec =3D 1=
 },
> while the new timestamp is { nsec =3D 1, sec =3D 2 }
>=20
> The current update method results in a transient state where { nsec =3D 1=
,
> sec =3D 1 }. But this represents an earlier point in time.
>=20
> Thus a thread which observed the first state and spotted the transient
> value in the second one is going to conclude time went backwards. Is
> this considered fine given what the multigrain stuff is trying to
> accomplish?
>=20

Yes, I think so.

> As for fixing this, off hand I note there is a 4-byte hole in struct
> inode, just enough to store a sequence counter which fill_mg_cmtime
> could use to safely read the sec/nsec pair. The write side would take
> the inode spinlock.
>=20

Note that this is also a problem today with always-coarse timestamps.
We track timestamps in two separate words, and "torn reads" are always
a possibility. I suspect it happens occasionally and we just never
notice.

The main goal with the multigrain series was to make sure that
measuring the ctime of the same inode on both sides of a change always
shows a change in value. I think we'll still achieve that here, even
with a torn read (unless we're just exceptionally unlucky).

As far as the ordering of timestamps between two different files; this
patchset doesn't make that any worse.

I did have an earlier version of this patchset that converted the
i_ctime fields to a ktime_t. That would have solved this problem too,
but it had other drawbacks. We could reconsider that though.

In any case, I think that's really a separate project from the
multigrain work. Given that no one has complained about torn reads so
far, I wouldn't bother at this point.

> > +	} else {
> > +		/*
> > +		 * Was the change due to someone marking the old ctime QUERIED?
> > +		 * If so then retry the swap. This can only happen once since
> > +		 * the only way to clear I_CTIME_QUERIED is to stamp the inode
> > +		 * with a new ctime.
> > +		 */
> > +		if (!(cns & I_CTIME_QUERIED) && (cns | I_CTIME_QUERIED) =3D=3D cur) =
{
> > +			cns =3D cur;
> > +			goto retry;
> > +		}
> > +		/* Otherwise, keep the existing ctime */
> > +		now_ts.tv_sec =3D inode->i_ctime_sec;
> > +		now_ts.tv_nsec =3D cur & ~I_CTIME_QUERIED;
> > +	}
> > +out:
> > +	return now_ts;
> >  }
> >  EXPORT_SYMBOL(inode_set_ctime_current);

--=20
Jeff Layton <jlayton@kernel.org>

