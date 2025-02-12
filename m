Return-Path: <linux-fsdevel+bounces-41576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF68A32504
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 12:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03E11889418
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87B20A5F0;
	Wed, 12 Feb 2025 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ma3Vdv3v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD516205E16;
	Wed, 12 Feb 2025 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359970; cv=none; b=ndLByb+B96ScR6rgSqxu+92UJS912jGudzxnggsFOFniekQfWY4vJAUL1VsOpD8qsm7n46kfC7gs/xixz2OjORRfFj1UDwETPWetOZYY2RD89c/5i+L8QObf8kPedLlD15pfkCFW1ZXkNceDQSlUWw+kgLlNBHsSvqfktDPPSks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359970; c=relaxed/simple;
	bh=EMpRj2ht/tEPGS4+J9CdUCbKV1v6QyKT+z1JosOvVTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+8vfZCHHwnlbZkHRZIfsJoR2lpEmGbsTfg09/hU3sZpW252ZH39YBgDcNOfkl4mDRBm2seqOt+cgUroPbPA6rObsiccOKIZeA81IP7V2fqAJW4vR7TItrH45gOLl9jzjiWKyKIzAm6ohn3kE48QNPqaUlaR/rkjAUiephaJRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ma3Vdv3v; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XDHy3FQtxkSqfqwPef2gf5CYBQiv+4aNXY+HG7ioErU=; b=Ma3Vdv3vd6YYrNB45BDBkv+nIZ
	VfmdsQWf5vTDqfEBoivPGh7Iv4NYMkIWNs0rch2N2VKmEMjPe+fQpM7qqOqE1M4EJFVJwJmdpwZnu
	77hDy4b/TTZLoKU+6SeoO4xuMa/UjOufLvcvX9XSAKq4nBEvdWsL+zoOT/mDy+aLRmMicMF/5aS/V
	Zd2ZcSju7Y1gWNXqt3SLluRJq27OqHxbMt7sbarcWfAzY39K/tzzVHh/zgjlFDkeRIsJwjbCBR6yx
	Un2M5j8fPBujDC/PrSgUw9A65+LAB5wzOmmhMfeAlwt+g2SE0/DGaXXW1u0LSaNy69Kct0FCgkwJj
	h5nGRoGw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tiAyo-008DNr-Vu; Wed, 12 Feb 2025 12:32:40 +0100
From: Luis Henriques <luis@igalia.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matt Harvey <mharvey@jumptrading.com>,
  Bernd Schubert <bschubert@ddn.com>,  Joanne Koong
 <joannelkoong@gmail.com>
Subject: Re: [PATCH v4] fuse: add new function to invalidate cache for all
 inodes
In-Reply-To: <Z6u5dumvZHf_BDHM@dread.disaster.area> (Dave Chinner's message of
	"Wed, 12 Feb 2025 07:56:22 +1100")
References: <20250211092604.15160-1-luis@igalia.com>
	<Z6u5dumvZHf_BDHM@dread.disaster.area>
Date: Wed, 12 Feb 2025 11:32:40 +0000
Message-ID: <875xlf4cvb.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12 2025, Dave Chinner wrote:

> [ FWIW: if the commit message directly references someone else's
> related (and somewhat relevant) work, please directly CC those
> people on the patch(set). I only noticed this by chance, not because
> I read every FUSE related patch that goes by me. ]

Point taken -- I should have included you on CC since the initial RFC.

> On Tue, Feb 11, 2025 at 09:26:04AM +0000, Luis Henriques wrote:
>> Currently userspace is able to notify the kernel to invalidate the cache
>> for an inode.  This means that, if all the inodes in a filesystem need to
>> be invalidated, then userspace needs to iterate through all of them and =
do
>> this kernel notification separately.
>>=20
>> This patch adds a new option that allows userspace to invalidate all the
>> inodes with a single notification operation.  In addition to invalidate
>> all the inodes, it also shrinks the sb dcache.
>
> That, IMO, seems like a bit naive - we generally don't allow user
> controlled denial of service vectors to be added to the kernel. i.e.
> this is the equivalent of allowing FUSE fs specific 'echo 1 >
> /proc/sys/vm/drop_caches' via some fuse specific UAPI. We only allow
> root access to /proc/sys/vm/drop_caches because it can otherwise be
> easily abused to cause system wide performance issues.
>
> It also strikes me as a somewhat dangerous precendent - invalidating
> random VFS caches through user APIs hidden deep in random fs
> implementations makes for poor visibility and difficult maintenance
> of VFS level functionality...

Hmm... OK, I understand the concern and your comment makes perfect sense.
But would it be acceptable to move this API upper in the stack and make it
visible at the VFS layer?  Something similar to the 'drop_caches' but with
a superblock granularity.  I haven't spent any time thinking how could
that be done, but it wouldn't be "hidden deep" anymore.

>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>> * Changes since v3
>> - Added comments to clarify semantic changes in fuse_reverse_inval_inode=
()
>>   when called with FUSE_INVAL_ALL_INODES (suggested by Bernd).
>> - Added comments to inodes iteration loop to clarify __iget/iput usage
>>   (suggested by Joanne)
>> - Dropped get_fuse_mount() call -- fuse_mount can be obtained from
>>   fuse_ilookup() directly (suggested by Joanne)
>>=20
>> (Also dropped the RFC from the subject.)
>>=20
>> * Changes since v2
>> - Use the new helper from fuse_reverse_inval_inode(), as suggested by Be=
rnd.
>> - Also updated patch description as per checkpatch.pl suggestion.
>>=20
>> * Changes since v1
>> As suggested by Bernd, this patch v2 simply adds an helper function that
>> will make it easier to replace most of it's code by a call to function
>> super_iter_inodes() when Dave Chinner's patch[1] eventually gets merged.
>>=20
>> [1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.c=
om
>
> That doesn't make the functionality any more palatable.
>
> Those iterators are the first step in removing the VFS inode list
> and only maintaining it in filesystems that actually need this
> functionality. We want this list to go away because maintaining it
> is a general VFS cache scalability limitation.
>
> i.e. if a filesystem has internal functionality that requires
> iterating all instantiated inodes, the filesystem itself should
> maintain that list in the most efficient manner for the filesystem's
> iteration requirements not rely on the VFS to maintain this
> information for it.

Right, and in my use-case that's exactly what is currently being done: the
FUSE API to invalidate individual inodes is being used.  This new
functionality just tries to make life easier to userspace when *all* the
inodes need to be invalidated. (For reference, the use-case is CVMFS, a
read-only FS, where new generations of a filesystem snapshot may become
available at some point and the previous one needs to be wiped from the
cache.)

> That's the point of the iterator methods the above patchset adds -
> it allows the filesystem to provide the VFS with a method for
> iterating all inodes in the filesystem whilst the transition period
> where we rework the inode cache structure (i.e. per-sb hash tables
> for inode lookup, inode LRU caching goes away, etc). Once that
> rework gets done, there won't be a VFS inode cache to iterate.....

And re-reading the cover-letter in that patchset helped understanding that
that is indeed the goal.  My patch mentioned that iterator because we
could eventually take advantage of it, but clearly no new users are
expected/desired.

>>  fs/fuse/inode.c           | 83 +++++++++++++++++++++++++++++++++++----
>>  include/uapi/linux/fuse.h |  3 ++
>>  2 files changed, 79 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index e9db2cb8c150..5aa49856731a 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -547,25 +547,94 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u=
64 nodeid,
>>  	return NULL;
>>  }
>>=20=20
>> +static void inval_single_inode(struct inode *inode, struct fuse_conn *f=
c)
>> +{
>> +	struct fuse_inode *fi;
>> +
>> +	fi =3D get_fuse_inode(inode);
>> +	spin_lock(&fi->lock);
>> +	fi->attr_version =3D atomic64_inc_return(&fc->attr_version);
>> +	spin_unlock(&fi->lock);
>> +	fuse_invalidate_attr(inode);
>> +	forget_all_cached_acls(inode);
>> +}
>> +
>> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
>> +{
>> +	struct fuse_mount *fm;
>> +	struct super_block *sb;
>> +	struct inode *inode, *old_inode =3D NULL;
>> +
>> +	inode =3D fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
>> +	if (!inode || !fm)
>> +		return -ENOENT;
>> +
>> +	iput(inode);
>> +	sb =3D fm->sb;
>> +
>> +	spin_lock(&sb->s_inode_list_lock);
>> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>> +		spin_lock(&inode->i_lock);
>> +		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
>> +		    !atomic_read(&inode->i_count)) {
>> +			spin_unlock(&inode->i_lock);
>> +			continue;
>> +		}
>
> This skips every inode that is unreferenced and cached on the
> LRU. i.e. it only invalidates inodes that have a current reference
> (e.g. dentry pins it, has an open file, etc).
>
> What's the point of only invalidating actively referenced inodes?
>
>> +		/*
>> +		 * This __iget()/iput() dance is required so that we can release
>> +		 * the sb lock and continue the iteration on the previous
>> +		 * inode.  If we don't keep a ref to the old inode it could have
>> +		 * disappear.  This way we can safely call cond_resched() when
>> +		 * there's a huge amount of inodes to iterate.
>> +		 */
>
> If there's a huge amount of inodes to iterate, then most of them are
> going to be on the LRU and unreferenced, so this code won't even get
> here to be able to run cond_resched().

Sigh.  Looks like I got this wrong.  With capital 'W'.

>> +		__iget(inode);
>> +		spin_unlock(&inode->i_lock);
>> +		spin_unlock(&sb->s_inode_list_lock);
>> +		iput(old_inode);
>> +
>> +		inval_single_inode(inode, fc);
>> +
>> +		old_inode =3D inode;
>> +		cond_resched();
>> +		spin_lock(&sb->s_inode_list_lock);
>> +	}
>> +	spin_unlock(&sb->s_inode_list_lock);
>> +	iput(old_inode);
>> +
>> +	shrink_dcache_sb(sb);
>
> Why drop all the referenced inodes held by the dentry cache -after-
> inode invalidation? Doesn't this mean that racing operations are
> going to see a valid dentries backed by an invalidated inode?  Why
> aren't the dentries pruned from the cache first, and new lookups
> blocked until the invalidation completes?
>
> I'm left to ponder why the invalidation isn't simply:
>
> 	/* Remove all possible active references to cached inodes */
> 	shrink_dcache_sb();
>
> 	/* Remove all unreferenced inodes from cache */
> 	invalidate_inodes();
>
> Which will result in far more of the inode cache for the filesystem
> being invalidated than the above code....

To be honest, my initial attempt to implement this feature actually used
invalidate_inodes().  For some reason that I don't remember anymore why I
decided to implement the iterator myself.  I'll go look at that code again
and run some tests on this (much!) simplified version of the invalidation
function your suggesting.

Also, thanks a lot for your comments, Dave.  Much appreciated!  I'll make
sure any other rev of this patch will include you ;-)

Cheers,
--=20
Lu=C3=ADs

