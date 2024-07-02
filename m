Return-Path: <linux-fsdevel+bounces-22905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F003D91EBCA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 02:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F1A284D53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 00:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943488BFC;
	Tue,  2 Jul 2024 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYYjhApb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F01C27;
	Tue,  2 Jul 2024 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719879731; cv=none; b=XoapwzLRhDPeJN+k5e6a/+vqzS5INzf/VhK5l2p/2EbtGqlD6+z4jQRay8vIPsvSxQKLP85zg2NjSRV19lFkcK/r8XdSpO3hM2IUNlA0orAtaftKMn5kJ5VNmv3ofyswMonFCMzg9y9J7JQA0Fn3pW43RP12155dBpRHDZW/qiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719879731; c=relaxed/simple;
	bh=eilQUQR1hEY1n0+7vh9oO2ffjz4mLnCHXgoFHh9075A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P6AZPYQxCsTsHY0mBYDjJOTyvfqg4ekqK0qS/F+A2Oz8ylIlyD7kYcvpx8znNRpcRLKv9i1Pvc4PqcYfUteUtqK5CpVb5pPn9Lwwt6NHAlaHQzp5gNCMilNWo/IvSULvrdDDTZjzPgkOynZmLY07lKCMXVIxSZqhZNj4daHNrNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYYjhApb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C20C116B1;
	Tue,  2 Jul 2024 00:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719879730;
	bh=eilQUQR1hEY1n0+7vh9oO2ffjz4mLnCHXgoFHh9075A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IYYjhApbHDW/NxyC5Q3C1G5etBVbKHdmHFdwzcNJFv2Izbhy9mFkpPzBs7YgR3aum
	 1AaUcEHTDLbxEJPLHmrAYKyrUlW9eX7ZFQA5Wm6Ovs/EwwqwtSDDZbVv2g9t4vCdgP
	 II/UQWgyLap2u/3qfpXg0xt7JFVPt1BqeBm4yGQl1IAXukM5aaRUY4v2SsphfUN41q
	 ShisS2T+OJxZ8snKNBhLFzrVgwyGauII9kRgPWVkcHvS2BAUMpRaqSuHRLUSB6WzcZ
	 YpmKvfjNaZO4Lg1yCO8wXW6pWvLBrVCvqH0fACgBeiC5euBZMq9WkvH7yV8tk/bOKy
	 ubH5Qzu19+jGA==
Message-ID: <3042db2f803fbc711575ec4f1c4a273912a50904.camel@kernel.org>
Subject: Re: [PATCH 01/10] fs: turn inode ctime fields into a single ktime_t
From: Jeff Layton <jlayton@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Chandan Babu R
 <chandan.babu@oracle.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,  Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 kernel-team@fb.com,  linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org,  linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org,  linux-nfs@vger.kernel.org
Date: Mon, 01 Jul 2024 20:22:07 -0400
In-Reply-To: <20240701224941.GE612460@frogsfrogsfrogs>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
	 <20240626-mgtime-v1-1-a189352d0f8f@kernel.org>
	 <20240701224941.GE612460@frogsfrogsfrogs>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 15:49 -0700, Darrick J. Wong wrote:
> On Wed, Jun 26, 2024 at 09:00:21PM -0400, Jeff Layton wrote:
> > The ctime is not settable to arbitrary values. It always comes from the
> > system clock, so we'll never stamp an inode with a value that can't be
> > represented there. If we disregard people setting their system clock
> > past the year 2262, there is no reason we can't replace the ctime field=
s
> > with a ktime_t.
> >=20
> > Switch the ctime fields to a single ktime_t. Move the i_generation down
> > above i_fsnotify_mask and then move the i_version into the resulting 8
> > byte hole. This shrinks struct inode by 8 bytes total, and should
> > improve the cache footprint as the i_version and ctime are usually
> > updated together.
> >=20
> > The one downside I can see to switching to a ktime_t is that if someone
> > has a filesystem with files on it that has ctimes outside the ktime_t
> > range (before ~1678 AD or after ~2262 AD), we won't be able to display
> > them properly in stat() without some special treatment in the
> > filesystem. The operating assumption here is that that is not a
> > practical problem.
>=20
> What happens if a filesystem with the ability to store ctimes beyond
> whatever ktime_t supports (AFAICT 2^63-1 nanonseconds on either side of
> the Unix epoch)?  I think the behavior with your patch is that ktime_set
> clamps the ctime on iget because the kernel can't handle it?
>=20
> It's a little surprising that the ctime will suddenly jump back in time
> to 2262, but maybe you're right that nobody will notice or care? ;)
>=20
>=20

Yeah, it'd be clamped at KTIME_MAX when we pull in the inode from disk,
a'la ktime_set.

I think it's important to note that the ctime is not settable from
userland, so if an on-disk ctime is outside of the ktime_t range, there
are only two possibilities:

1) the system clock was set to some time (far) in the future when the
file's metadata was last altered (bad clock? time traveling fs?).

...or...

2) the filesystem has been altered (fuzzing? deliberate doctoring?).

None of these seem like legitimate use cases so I'm arguing that we
shouldn't worry about them.

(...ok maybe the time travel one could be legit, but someone needs to
step up and make a case for it, if so.)

> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  include/linux/fs.h | 26 +++++++++++---------------
> >  1 file changed, 11 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 5ff362277834..5139dec085f2 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -662,11 +662,10 @@ struct inode {
> >  	loff_t			i_size;
> >  	time64_t		i_atime_sec;
> >  	time64_t		i_mtime_sec;
> > -	time64_t		i_ctime_sec;
> >  	u32			i_atime_nsec;
> >  	u32			i_mtime_nsec;
> > -	u32			i_ctime_nsec;
> > -	u32			i_generation;
> > +	ktime_t			__i_ctime;
> > +	atomic64_t		i_version;
> >  	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
> >  	unsigned short          i_bytes;
> >  	u8			i_blkbits;
> > @@ -701,7 +700,6 @@ struct inode {
> >  		struct hlist_head	i_dentry;
> >  		struct rcu_head		i_rcu;
> >  	};
> > -	atomic64_t		i_version;
> >  	atomic64_t		i_sequence; /* see futex */
> >  	atomic_t		i_count;
> >  	atomic_t		i_dio_count;
> > @@ -724,6 +722,8 @@ struct inode {
> >  	};
> > =20
> > =20
> > +	u32			i_generation;
> > +
> >  #ifdef CONFIG_FSNOTIFY
> >  	__u32			i_fsnotify_mask; /* all events this inode cares about */
> >  	/* 32-bit hole reserved for expanding i_fsnotify_mask */
> > @@ -1608,29 +1608,25 @@ static inline struct timespec64 inode_set_mtime=
(struct inode *inode,
> >  	return inode_set_mtime_to_ts(inode, ts);
> >  }
> > =20
> > -static inline time64_t inode_get_ctime_sec(const struct inode *inode)
> > +static inline struct timespec64 inode_get_ctime(const struct inode *in=
ode)
> >  {
> > -	return inode->i_ctime_sec;
> > +	return ktime_to_timespec64(inode->__i_ctime);
> >  }
> > =20
> > -static inline long inode_get_ctime_nsec(const struct inode *inode)
> > +static inline time64_t inode_get_ctime_sec(const struct inode *inode)
> >  {
> > -	return inode->i_ctime_nsec;
> > +	return inode_get_ctime(inode).tv_sec;
> >  }
> > =20
> > -static inline struct timespec64 inode_get_ctime(const struct inode *in=
ode)
> > +static inline long inode_get_ctime_nsec(const struct inode *inode)
> >  {
> > -	struct timespec64 ts =3D { .tv_sec  =3D inode_get_ctime_sec(inode),
> > -				 .tv_nsec =3D inode_get_ctime_nsec(inode) };
> > -
> > -	return ts;
> > +	return inode_get_ctime(inode).tv_nsec;
> >  }
> > =20
> >  static inline struct timespec64 inode_set_ctime_to_ts(struct inode *in=
ode,
> >  						      struct timespec64 ts)
> >  {
> > -	inode->i_ctime_sec =3D ts.tv_sec;
> > -	inode->i_ctime_nsec =3D ts.tv_nsec;
> > +	inode->__i_ctime =3D ktime_set(ts.tv_sec, ts.tv_nsec);
> >  	return ts;
> >  }
> > =20
> >=20
> > --=20
> > 2.45.2
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

