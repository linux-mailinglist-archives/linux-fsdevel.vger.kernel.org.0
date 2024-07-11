Return-Path: <linux-fsdevel+bounces-23595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A50992EFE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 21:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66D7281E0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 19:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E669C188CA3;
	Thu, 11 Jul 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/05WNiO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D51157469;
	Thu, 11 Jul 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726854; cv=none; b=vDuY164iP7JT1a4TLGWm+1OvMq+zgRx4fBnk5qkfBYCXS85JL+Feyii0iOyonIxnb4+dZNFUzLd3cxsVVsZCcyAD/56L9K5JBSaoh088HVXmb0l/WJCUUprrHxGL07eisthbJGIK5gRTajlDTIin3fniL1SxCIllzRNq/j58MTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726854; c=relaxed/simple;
	bh=EVnGtV8AHFqpOc+alVUBVW5Ol8gc7DzmHy1wr9gczMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TfxNvHkV74A5ogYbdg+sVH8I1S8UZAD3z+tIkRKMSIU1yeiX8K98WaO81EgEHkei25d+6V2dBk8p5gQgYiJxXlCao7bLijbjU2t9AiU7Ou6BOiurG/psw0yTfBeZLKxeEN8WHyLnEMbKSqni4hMZI9JlBeqlNqUmMSn0Emh3xaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/05WNiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8294C116B1;
	Thu, 11 Jul 2024 19:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720726853;
	bh=EVnGtV8AHFqpOc+alVUBVW5Ol8gc7DzmHy1wr9gczMY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=f/05WNiOm5/jRoAIKleOwYtEiZWO8GkFKlbH+a/sBGr8vHmHTP533Qi/sK++dNV6I
	 pa5Owcvqp/re04OS8MQ2FqY13bZCilE6WR7P7qjCLek5YwhvGFhM8tm+cAc3aCvgg5
	 sP9HM55SsitKekzxqZUAlwdYYdEpGHMIKtB1mfJnWOcICE95Kj8Z3kxcc8OzWONZEe
	 i2QBMw15CsD7G/3e9fEX93vgN7Ia64hbvG+yvRC7gupeCDONU+hs2lvJw8fWY9fIH1
	 mUvQrcoKR1jkb1V3GxnpCYeGZFDMm2yleW1emv9PK5Yoo9oIAe+iZfTSMuJay4LO/X
	 t08oNBRNZNkqw==
Message-ID: <2a1db34612bc5ba6fe7722d2e031e216270dd4c2.camel@kernel.org>
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
Date: Thu, 11 Jul 2024 15:40:49 -0400
In-Reply-To: <20240711191435.GV1998502@frogsfrogsfrogs>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
	 <20240711-mgtime-v5-6-37bb5b465feb@kernel.org>
	 <20240711150920.GU1998502@frogsfrogsfrogs>
	 <95a135dcec10423b9bcb9f53a1420d80b4afdba7.camel@kernel.org>
	 <20240711191435.GV1998502@frogsfrogsfrogs>
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

On Thu, 2024-07-11 at 12:14 -0700, Darrick J. Wong wrote:
> On Thu, Jul 11, 2024 at 11:58:59AM -0400, Jeff Layton wrote:
> > On Thu, 2024-07-11 at 08:09 -0700, Darrick J. Wong wrote:
> > > On Thu, Jul 11, 2024 at 07:08:10AM -0400, Jeff Layton wrote:
> > > > Enable multigrain timestamps, which should ensure that there is an
> > > > apparent change to the timestamp whenever it has been written after
> > > > being actively observed via getattr.
> > > >=20
> > > > Also, anytime the mtime changes, the ctime must also change, and th=
ose
> > > > are now the only two options for xfs_trans_ichgtime. Have that func=
tion
> > > > unconditionally bump the ctime, and ASSERT that XFS_ICHGTIME_CHG is
> > > > always set.
> > > >=20
> > > > Finally, stop setting STATX_CHANGE_COOKIE in getattr, since the cti=
me
> > > > should give us better semantics now.
> > >=20
> > > Following up on "As long as the fs isn't touching i_ctime_nsec direct=
ly,
> > > you shouldn't need to worry about this" from:
> > > https://lore.kernel.org/linux-xfs/cae5c28f172ac57b7eaaa98a00b23f342f0=
1ba64.camel@kernel.org/
> > >=20
> > > xfs /does/ touch i_ctime_nsec directly when it's writing inodes to di=
sk.
> > > From xfs_inode_to_disk, see:
> > >=20
> > > 	to->di_ctime =3D xfs_inode_to_disk_ts(ip, inode_get_ctime(inode));
> > >=20
> > > AFAICT, inode_get_ctime itself remains unchanged, and still returns
> > > inode->__i_ctime, right?=C2=A0 In which case it's returning a raw tim=
espec64,
> > > which can include the QUERIED flag in tv_nsec, right?
> > >=20
> >=20
> > No, in the first patch in the series, inode_get_ctime becomes this:
> >=20
> > #define I_CTIME_QUERIED         ((u32)BIT(31))
> >=20
> > static inline time64_t inode_get_ctime_sec(const struct inode *inode)
> > {
> >         return inode->i_ctime_sec;
> > }
> >=20
> > static inline long inode_get_ctime_nsec(const struct inode *inode)
> > {
> >         return inode->i_ctime_nsec & ~I_CTIME_QUERIED;
> > }
> >=20
> > static inline struct timespec64 inode_get_ctime(const struct inode *ino=
de)
> > {
> >         struct timespec64 ts =3D { .tv_sec  =3D inode_get_ctime_sec(ino=
de),
> >                                  .tv_nsec =3D inode_get_ctime_nsec(inod=
e) };
> >=20
> >         return ts;
> > }
>=20
> Doh!  I forgot that this has already been soaking in the vfs tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/include/linux/fs.h?h=3Dnext-20240711&id=3D3aa63a569c64e708df547a8913c84e6=
4a06e7853
>=20
> > ...which should ensure that you never store the QUERIED bit.
>=20
> So yep, we're fine here.  Sorry about the noise; this was the very
> subtle clue in the diff that the change had already been applied:
>=20
>  static inline struct timespec64 inode_get_ctime(const struct inode *inod=
e)
> @@ -1626,13 +1637,7 @@ static inline struct timespec64 inode_get_ctime(co=
nst struct inode *inode)
>  	return ts;
>  }
>=20
> (Doh doh doh doh doh...)
>=20
> > > Now let's look at the consumer:
> > >=20
> > > static inline xfs_timestamp_t
> > > xfs_inode_to_disk_ts(
> > > 	struct xfs_inode		*ip,
> > > 	const struct timespec64		tv)
> > > {
> > > 	struct xfs_legacy_timestamp	*lts;
> > > 	xfs_timestamp_t			ts;
> > >=20
> > > 	if (xfs_inode_has_bigtime(ip))
> > > 		return cpu_to_be64(xfs_inode_encode_bigtime(tv));
> > >=20
> > > 	lts =3D (struct xfs_legacy_timestamp *)&ts;
> > > 	lts->t_sec =3D cpu_to_be32(tv.tv_sec);
> > > 	lts->t_nsec =3D cpu_to_be32(tv.tv_nsec);
> > >=20
> > > 	return ts;
> > > }
> > >=20
> > > For the !bigtime case (aka before we added y2038 support) the queried
> > > flag gets encoded into the tv_nsec field since xfs doesn't filter the
> > > queried flag.
> > >=20
> > > For the bigtime case, the timespec is turned into an absolute nsec co=
unt
> > > since the xfs epoch (which is the minimum timestamp possible under th=
e
> > > old encoding scheme):
> > >=20
> > > static inline uint64_t xfs_inode_encode_bigtime(struct timespec64 tv)
> > > {
> > > 	return xfs_unix_to_bigtime(tv.tv_sec) * NSEC_PER_SEC + tv.tv_nsec;
> > > }
> > >=20
> > > Here we'd also be mixing in the QUERIED flag, only now we've encoded =
a
> > > time that's a second in the future.=C2=A0 I think the solution is to =
add a:
> > >=20
> > > static inline struct timespec64
> > > inode_peek_ctime(const struct inode *inode)
> > > {
> > > 	return (struct timespec64){
> > > 		.tv_sec =3D inode->__i_ctime.tv_sec,
> > > 		.tv_nsec =3D inode->__i_ctime.tv_nsec & ~I_CTIME_QUERIED,
> > > 	};
> > > }
> > >=20
> > > similar to what inode_peek_iversion does for iversion; and then
> > > xfs_inode_to_disk can do:
> > >=20
> > > 	to->di_ctime =3D xfs_inode_to_disk_ts(ip, inode_peek_ctime(inode));
> > >=20
> > > which would prevent I_CTIME_QUERIED from going out to disk.
> > >=20
> > > At load time, xfs_inode_from_disk uses inode_set_ctime_to_ts so I thi=
nk
> > > xfs won't accidentally introduce QUERIED when it's loading an inode f=
rom
> > > disk.
> > >=20
> > >=20
> >=20
> > Also already done in this patchset:
> >=20
> > struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct tim=
espec64 ts)
> > {
> >         inode->i_ctime_sec =3D ts.tv_sec;
> >         inode->i_ctime_nsec =3D ts.tv_nsec & ~I_CTIME_QUERIED;
> >         trace_inode_set_ctime_to_ts(inode, &ts);
> >         return ts;
> > }
> > EXPORT_SYMBOL(inode_set_ctime_to_ts);
> >=20
> > Basically, we never want to store or fetch the QUERIED flag from disk,
> > and since it's in an unused bit, we can just universally mask it off
> > when dealing with "external" users of it.
> >=20
> > One caveat -- I am using the sign bit for the QUERIED flag, so I'm
> > assuming that no one should ever pass inode_set_ctime_to_ts a negative
> > tv_nsec value.
> >=20
> > Maybe I should add a WARN_ON_ONCE here to check for that? It seems
> > nonsensical, but you never know...
>=20
> Well in theory filesystems should validate incoming timestamps and
> reject tv_nsec with the high bit set, but I'd bet there's a filesystem
> out there that allows negative nanoseconds, even if the kernel will
> never pass it such a thing. ;)
>=20

Hmm, in that case, we probably should normalize the timestamp in this
function before setting the ctime to it. That way we can ensure that
the bit will be meaningless when we use it. I think the kernel has a
way to do that. I'll take a look tomorrow.

Thanks!

> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > =C2=A0fs/xfs/libxfs/xfs_trans_inode.c |=C2=A0 6 +++---
> > > > =C2=A0fs/xfs/xfs_iops.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++-------
> > > > =C2=A0fs/xfs/xfs_super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > =C2=A03 files changed, 7 insertions(+), 11 deletions(-)
> > > >=20
> > > > diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_tr=
ans_inode.c
> > > > index 69fc5b981352..1f3639bbf5f0 100644
> > > > --- a/fs/xfs/libxfs/xfs_trans_inode.c
> > > > +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> > > > @@ -62,12 +62,12 @@ xfs_trans_ichgtime(
> > > > =C2=A0	ASSERT(tp);
> > > > =C2=A0	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
> > > > =C2=A0
> > > > -	tv =3D current_time(inode);
> > > > +	/* If the mtime changes, then ctime must also change */
> > > > +	ASSERT(flags & XFS_ICHGTIME_CHG);
> > > > =C2=A0
> > > > +	tv =3D inode_set_ctime_current(inode);
> > > > =C2=A0	if (flags & XFS_ICHGTIME_MOD)
> > > > =C2=A0		inode_set_mtime_to_ts(inode, tv);
> > > > -	if (flags & XFS_ICHGTIME_CHG)
> > > > -		inode_set_ctime_to_ts(inode, tv);
> > > > =C2=A0	if (flags & XFS_ICHGTIME_CREATE)
> > > > =C2=A0		ip->i_crtime =3D tv;
>=20
> And as I mentioned elsewhere in this thread, 6.11 contains a change to
> make it so that xfs_trans_ichgtime can set the access time.  That breaks
> the old assertion that XFS_ICHGTIME_CHG is always set, but I think we
> can work around that easily.
>=20
> 	if (flags & XFS_ICHGTIME_CHG)
> 		tv =3D inode_set_ctime_current(inode);
> 	else
> 		tv =3D current_time(inode);
>=20
> --D
>=20
> > > > =C2=A0}
> > > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > > index a00dcbc77e12..d25872f818fa 100644
> > > > --- a/fs/xfs/xfs_iops.c
> > > > +++ b/fs/xfs/xfs_iops.c
> > > > @@ -592,8 +592,9 @@ xfs_vn_getattr(
> > > > =C2=A0	stat->gid =3D vfsgid_into_kgid(vfsgid);
> > > > =C2=A0	stat->ino =3D ip->i_ino;
> > > > =C2=A0	stat->atime =3D inode_get_atime(inode);
> > > > -	stat->mtime =3D inode_get_mtime(inode);
> > > > -	stat->ctime =3D inode_get_ctime(inode);
> > > > +
> > > > +	fill_mg_cmtime(stat, request_mask, inode);
> > > > +
> > > > =C2=A0	stat->blocks =3D XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_del=
ayed_blks);
> > > > =C2=A0
> > > > =C2=A0	if (xfs_has_v3inodes(mp)) {
> > > > @@ -603,11 +604,6 @@ xfs_vn_getattr(
> > > > =C2=A0		}
> > > > =C2=A0	}
> > > > =C2=A0
> > > > -	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) =
{
> > > > -		stat->change_cookie =3D inode_query_iversion(inode);
> > > > -		stat->result_mask |=3D STATX_CHANGE_COOKIE;
> > > > -	}
> > > > -
> > > > =C2=A0	/*
> > > > =C2=A0	 * Note: If you add another clause to set an attribute flag,=
 please
> > > > =C2=A0	 * update attributes_mask below.
> > > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > > index 27e9f749c4c7..210481b03fdb 100644
> > > > --- a/fs/xfs/xfs_super.c
> > > > +++ b/fs/xfs/xfs_super.c
> > > > @@ -2052,7 +2052,7 @@ static struct file_system_type xfs_fs_type =
=3D {
> > > > =C2=A0	.init_fs_context	=3D xfs_init_fs_context,
> > > > =C2=A0	.parameters		=3D xfs_fs_parameters,
> > > > =C2=A0	.kill_sb		=3D xfs_kill_sb,
> > > > -	.fs_flags		=3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> > > > +	.fs_flags		=3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
> > > > =C2=A0};
> > > > =C2=A0MODULE_ALIAS_FS("xfs");
> > > > =C2=A0
> > > >=20
> > > > --=20
> > > > 2.45.2
> > > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>

