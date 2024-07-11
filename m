Return-Path: <linux-fsdevel+bounces-23581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88DA92EC2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 17:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555781F20631
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A667416D4D2;
	Thu, 11 Jul 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RilZTT6o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2741642B;
	Thu, 11 Jul 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713544; cv=none; b=J8N0b2Nf8kl1udAgGOt9VmqmILYq8sZLyLF/fjOAKf7QXOl1jq2Xva4KLyLpeGZYA20goED1R1rfVEisTce8WWbG1Byh6ecOCAiwR25+HwamCsQhT4XKSetdPTSQQuKKtRn4QXWXCv+iQK08BnvtEVmynR4+nDsitm/wIb88H/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713544; c=relaxed/simple;
	bh=1iLtZj+CaSFvlN0D+8+pdkXrtfvKV5SmTmwUWZ1gvV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=THgJNlrMH2AirPc8jYoSpWKU+G6hLdFwNzXdUtIc+uwB3HU5aPy8ein3/ZSjLztPnKvCVWJMg+zQkiNtM9ODY670BBBMUm0pVXh9YhyIfmvDpx1wocxE+E4vFz5B/vExT8l4mTtGvJWiLG+WJ0AcTTEq6zXnSpdeXQPI6EI+5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RilZTT6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE46C116B1;
	Thu, 11 Jul 2024 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720713543;
	bh=1iLtZj+CaSFvlN0D+8+pdkXrtfvKV5SmTmwUWZ1gvV0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RilZTT6oQtB3tiFj/GIIBLC/ZRyo/VwTLg6HQJgTA712ulSCbnbRO4v0zINaanpUK
	 ABZ8d+FUa1TePSU4UhYsEfvQh60kgDvbI4e/j/tlO+tAjM9R6/soCKIEYBMlPHBcWv
	 cGrbjS0JEruStBXVgumxtfdnFeSH36LKmMd22fRmlYCDZprXXbDV2Gmz3IWyAAiiZZ
	 hfkUQtRkrfRR6JUGbHe0VYIov2586luk7489V92JJ/E/qguhEy5iuGlQIJ57vMOrsc
	 SUNeO2WIhbtrjGUoFyl/SiU9RRRQ6zQvzunSnGG3mjtAxql0i2eB1qXakgTalIYLOO
	 sPbQM9506Agzg==
Message-ID: <95a135dcec10423b9bcb9f53a1420d80b4afdba7.camel@kernel.org>
Subject: Re: [PATCH v5 6/9] xfs: switch to multigrain timestamps
From: Jeff Layton <jlayton@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Chandan Babu R
 <chandan.babu@oracle.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,  Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Jonathan
 Corbet <corbet@lwn.net>,  Dave Chinner <david@fromorbit.com>, Andi Kleen
 <ak@linux.intel.com>, Christoph Hellwig <hch@infradead.org>,  Uros Bizjak
 <ubizjak@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, Arnd
 Bergmann <arnd@arndb.de>,  Randy Dunlap <rdunlap@infradead.org>,
 kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org,
  linux-doc@vger.kernel.org
Date: Thu, 11 Jul 2024 11:58:59 -0400
In-Reply-To: <20240711150920.GU1998502@frogsfrogsfrogs>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
	 <20240711-mgtime-v5-6-37bb5b465feb@kernel.org>
	 <20240711150920.GU1998502@frogsfrogsfrogs>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-11 at 08:09 -0700, Darrick J. Wong wrote:
> On Thu, Jul 11, 2024 at 07:08:10AM -0400, Jeff Layton wrote:
> > Enable multigrain timestamps, which should ensure that there is an
> > apparent change to the timestamp whenever it has been written after
> > being actively observed via getattr.
> >=20
> > Also, anytime the mtime changes, the ctime must also change, and those
> > are now the only two options for xfs_trans_ichgtime. Have that function
> > unconditionally bump the ctime, and ASSERT that XFS_ICHGTIME_CHG is
> > always set.
> >=20
> > Finally, stop setting STATX_CHANGE_COOKIE in getattr, since the ctime
> > should give us better semantics now.
>=20
> Following up on "As long as the fs isn't touching i_ctime_nsec directly,
> you shouldn't need to worry about this" from:
> https://lore.kernel.org/linux-xfs/cae5c28f172ac57b7eaaa98a00b23f342f01ba6=
4.camel@kernel.org/
>=20
> xfs /does/ touch i_ctime_nsec directly when it's writing inodes to disk.
> From xfs_inode_to_disk, see:
>=20
> 	to->di_ctime =3D xfs_inode_to_disk_ts(ip, inode_get_ctime(inode));
>=20
> AFAICT, inode_get_ctime itself remains unchanged, and still returns
> inode->__i_ctime, right?=C2=A0 In which case it's returning a raw timespe=
c64,
> which can include the QUERIED flag in tv_nsec, right?
>=20

No, in the first patch in the series, inode_get_ctime becomes this:

#define I_CTIME_QUERIED         ((u32)BIT(31))

static inline time64_t inode_get_ctime_sec(const struct inode *inode)
{
        return inode->i_ctime_sec;
}

static inline long inode_get_ctime_nsec(const struct inode *inode)
{
        return inode->i_ctime_nsec & ~I_CTIME_QUERIED;
}

static inline struct timespec64 inode_get_ctime(const struct inode *inode)
{
        struct timespec64 ts =3D { .tv_sec  =3D inode_get_ctime_sec(inode),
                                 .tv_nsec =3D inode_get_ctime_nsec(inode) }=
;

        return ts;
}

...which should ensure that you never store the QUERIED bit.

> Now let's look at the consumer:
>=20
> static inline xfs_timestamp_t
> xfs_inode_to_disk_ts(
> 	struct xfs_inode		*ip,
> 	const struct timespec64		tv)
> {
> 	struct xfs_legacy_timestamp	*lts;
> 	xfs_timestamp_t			ts;
>=20
> 	if (xfs_inode_has_bigtime(ip))
> 		return cpu_to_be64(xfs_inode_encode_bigtime(tv));
>=20
> 	lts =3D (struct xfs_legacy_timestamp *)&ts;
> 	lts->t_sec =3D cpu_to_be32(tv.tv_sec);
> 	lts->t_nsec =3D cpu_to_be32(tv.tv_nsec);
>=20
> 	return ts;
> }
>=20
> For the !bigtime case (aka before we added y2038 support) the queried
> flag gets encoded into the tv_nsec field since xfs doesn't filter the
> queried flag.
>=20
> For the bigtime case, the timespec is turned into an absolute nsec count
> since the xfs epoch (which is the minimum timestamp possible under the
> old encoding scheme):
>=20
> static inline uint64_t xfs_inode_encode_bigtime(struct timespec64 tv)
> {
> 	return xfs_unix_to_bigtime(tv.tv_sec) * NSEC_PER_SEC + tv.tv_nsec;
> }
>=20
> Here we'd also be mixing in the QUERIED flag, only now we've encoded a
> time that's a second in the future.=C2=A0 I think the solution is to add =
a:
>=20
> static inline struct timespec64
> inode_peek_ctime(const struct inode *inode)
> {
> 	return (struct timespec64){
> 		.tv_sec =3D inode->__i_ctime.tv_sec,
> 		.tv_nsec =3D inode->__i_ctime.tv_nsec & ~I_CTIME_QUERIED,
> 	};
> }
>=20
> similar to what inode_peek_iversion does for iversion; and then
> xfs_inode_to_disk can do:
>=20
> 	to->di_ctime =3D xfs_inode_to_disk_ts(ip, inode_peek_ctime(inode));
>=20
> which would prevent I_CTIME_QUERIED from going out to disk.
>=20
> At load time, xfs_inode_from_disk uses inode_set_ctime_to_ts so I think
> xfs won't accidentally introduce QUERIED when it's loading an inode from
> disk.
>=20
>=20

Also already done in this patchset:

struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespe=
c64 ts)
{
        inode->i_ctime_sec =3D ts.tv_sec;
        inode->i_ctime_nsec =3D ts.tv_nsec & ~I_CTIME_QUERIED;
        trace_inode_set_ctime_to_ts(inode, &ts);
        return ts;
}
EXPORT_SYMBOL(inode_set_ctime_to_ts);

Basically, we never want to store or fetch the QUERIED flag from disk,
and since it's in an unused bit, we can just universally mask it off
when dealing with "external" users of it.

One caveat -- I am using the sign bit for the QUERIED flag, so I'm
assuming that no one should ever pass inode_set_ctime_to_ts a negative
tv_nsec value.

Maybe I should add a WARN_ON_ONCE here to check for that? It seems
nonsensical, but you never know...

> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > =C2=A0fs/xfs/libxfs/xfs_trans_inode.c |=C2=A0 6 +++---
> > =C2=A0fs/xfs/xfs_iops.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++-------
> > =C2=A0fs/xfs/xfs_super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A03 files changed, 7 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_=
inode.c
> > index 69fc5b981352..1f3639bbf5f0 100644
> > --- a/fs/xfs/libxfs/xfs_trans_inode.c
> > +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> > @@ -62,12 +62,12 @@ xfs_trans_ichgtime(
> > =C2=A0	ASSERT(tp);
> > =C2=A0	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
> > =C2=A0
> > -	tv =3D current_time(inode);
> > +	/* If the mtime changes, then ctime must also change */
> > +	ASSERT(flags & XFS_ICHGTIME_CHG);
> > =C2=A0
> > +	tv =3D inode_set_ctime_current(inode);
> > =C2=A0	if (flags & XFS_ICHGTIME_MOD)
> > =C2=A0		inode_set_mtime_to_ts(inode, tv);
> > -	if (flags & XFS_ICHGTIME_CHG)
> > -		inode_set_ctime_to_ts(inode, tv);
> > =C2=A0	if (flags & XFS_ICHGTIME_CREATE)
> > =C2=A0		ip->i_crtime =3D tv;
> > =C2=A0}
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index a00dcbc77e12..d25872f818fa 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -592,8 +592,9 @@ xfs_vn_getattr(
> > =C2=A0	stat->gid =3D vfsgid_into_kgid(vfsgid);
> > =C2=A0	stat->ino =3D ip->i_ino;
> > =C2=A0	stat->atime =3D inode_get_atime(inode);
> > -	stat->mtime =3D inode_get_mtime(inode);
> > -	stat->ctime =3D inode_get_ctime(inode);
> > +
> > +	fill_mg_cmtime(stat, request_mask, inode);
> > +
> > =C2=A0	stat->blocks =3D XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed=
_blks);
> > =C2=A0
> > =C2=A0	if (xfs_has_v3inodes(mp)) {
> > @@ -603,11 +604,6 @@ xfs_vn_getattr(
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > -	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> > -		stat->change_cookie =3D inode_query_iversion(inode);
> > -		stat->result_mask |=3D STATX_CHANGE_COOKIE;
> > -	}
> > -
> > =C2=A0	/*
> > =C2=A0	 * Note: If you add another clause to set an attribute flag, ple=
ase
> > =C2=A0	 * update attributes_mask below.
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 27e9f749c4c7..210481b03fdb 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -2052,7 +2052,7 @@ static struct file_system_type xfs_fs_type =3D {
> > =C2=A0	.init_fs_context	=3D xfs_init_fs_context,
> > =C2=A0	.parameters		=3D xfs_fs_parameters,
> > =C2=A0	.kill_sb		=3D xfs_kill_sb,
> > -	.fs_flags		=3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> > +	.fs_flags		=3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
> > =C2=A0};
> > =C2=A0MODULE_ALIAS_FS("xfs");
> > =C2=A0
> >=20
> > --=20
> > 2.45.2
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

