Return-Path: <linux-fsdevel+bounces-705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFC57CE95F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 22:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECC2281D16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 20:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB1F1EB46;
	Wed, 18 Oct 2023 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fr/C19Mv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503763E016
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 20:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB2EC433C8;
	Wed, 18 Oct 2023 20:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697662060;
	bh=ur7fcft+INev6z8sCndtms845O1A1/aPF0TIAWbDkS0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fr/C19MvlG9QXl+vWS+SXplZgTRgBQJ3oLvKh1kARFT7tBHh79vH1tQShLD9PgLut
	 yPZrIF6BgYRMGKSa+4ap23iDicA29QlHgzuc9wqzo0Nftd/kvOQdbsaY6bOG1qheYd
	 Y9a+XBPDNkWWvKeE21tf85ThZM1Yvzaxd6qJkorN/EjBNO6hEAj1453J1cA1zPxRg8
	 d73AoURNDxaS06VsO2r0Ebq1GKLSGcS8s+x9s7VDua0bPXIME2bPgCmGsdgY5GC1n0
	 728Bvsyu5URh5eysAXOVYsTdp1fk/mIc49hpShHVLnYnU22T1HYUNgKffNe2HDOjRA
	 oYHiZjfKG+3KQ==
Message-ID: <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, John Stultz <jstultz@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Chandan Babu R
 <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, Dave
 Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>, Andreas
 Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Amir
 Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, David Howells
 <dhowells@redhat.com>,  linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org,  linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org
Date: Wed, 18 Oct 2023 16:47:37 -0400
In-Reply-To: <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
	 <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
	 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-10-18 at 12:18 -0700, Linus Torvalds wrote:
> On Wed, 18 Oct 2023 at 10:41, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > One way to prevent this is to ensure that when we stamp a file with a
> > fine-grained timestamp, that we use that value to establish a floor for
> > any later timestamp update.
>=20
> I'm very leery of this.
>=20
> I don't like how it's using a global time - and a global fine-grained
> offset - when different filesystems will very naturally have different
> granularities. I also don't like how it's no using that global lock.
>=20
> Yes, yes, since the use of this all is then gated by the 'is_mgtime()'
> thing, any filesystem with big granularities will presumably never set
> FS_MGTIME in the first time, and that hides the worst pointless cases.
> But it still feels iffy to me.
>=20

Thanks for taking a look!

I'm not too crazy about the global lock either, but the global fine
grained value ensures that when we have mtime changes that occur across
filesystems that they appear to be in the correct order.

We could (hypothetically) track an offset per superblock or something,
but then you could see out-of-order timestamps in inodes across
different filesystems (even of the same type). I think it'd better not
to do that if we can get away with it.


> Also, the whole current_ctime() logic seems wrong. Later (in 4/9), you do=
 this:
>=20
>  static struct timespec64 current_ctime(struct inode *inode)
>  {
>         if (is_mgtime(inode))
>                 return current_mgtime(inode);
>=20
> and current_mgtime() does
>=20
>         if (nsec & I_CTIME_QUERIED) {
>                 ktime_get_real_ts64(&now);
>                 return timestamp_truncate(now, inode);
>         }
>=20
> so once the code has set I_CTIME_QUERIED, it will now use the
> expensive fine-grained time - even when it makes no sense.
>=20
> As far as I can tell, there is *never* a reason to get the
> fine-grained time if the old inode ctime is already sufficiently far
> away.
>=20
> IOW, my gut feel is that all this logic should always not only be
> guarded by FS_MGTIME (like you do seem to do), *and* by "has anybody
> even queried this time" - it should *also* always be guarded by "if I
> get the coarse-grained time, is that sufficient?"
>=20
> So I think the current_ctime() logic should be something along the lines =
of
>=20
>     static struct timespec64 current_ctime(struct inode *inode)
>     {
>         struct timespec64 ts64 =3D current_time(inode);
>         unsigned long old_ctime_sec =3D inode->i_ctime_sec;
>         unsigned int old_ctime_nsec =3D inode->i_ctime_nsec;
>=20
>         if (ts64.tv_sec !=3D old_ctime_sec)
>                 return ts64;
>=20
>         /*
>          * No need to check is_mgtime(inode) - the I_CTIME_QUERIED
>          * flag is only set for mgtime filesystems
>          */
>         if (!(old_ctime_nsec & I_CTIME_QUERIED))
>                 return ts64;
>         old_ctime_nsec &=3D ~I_CTIME_QUERIED;
>         if (ts64.tv_nsec > old_ctime_nsec + inode->i_sb->s_time_gran)
>                 return ts64;
>=20

Does that really do what you expect here? current_time will return a
value that has already been through timestamp_truncate. Regardless, I
don't think this function makes as big a difference as you might think.

>
>         /* Ok, only *now* do we do a finegrained value */
>         ktime_get_real_ts64(&ts64);
>         return timestamp_truncate(ts64);
>     }
>=20
> or whatever. Make it *very* clear that the finegrained timestamp is
> the absolute last option, after we have checked that the regular one
> isn't possible.

current_mgtime is calling ktime_get_real_ts64, which is an existing
interface that does not take the global spinlock and won't advance the
global offset. That call should be quite cheap.

The reason we can use that call here is because current_ctime and
current_mgtime are only called from  inode_needs_update_time, which is
only called to check whether we need to get write access to the
inode.=A0What we do is look at the current clock and see whether the
timestamps would perceivably change if we were to do the update right
then.

If so, we get write access and then call inode_set_ctime_current(). That
will fetch its own timestamps and reevaluate what sort of update to do.
That's the only place that fetches an expensive fine-grained timestamp
that advances the offset.

So, I think this set already is only getting the expensive fine-grained
timestamps as a last resort.

This is probably an indicator that I need to document this code better
though. It may also be a good idea to reorganize
inode_needs_update_time, current_ctime and current_mgtime for better
clarity.

Many thanks for the comments!
--=20
Jeff Layton <jlayton@kernel.org>

