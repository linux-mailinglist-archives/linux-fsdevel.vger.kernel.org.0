Return-Path: <linux-fsdevel+bounces-2600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4897E6FEC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B346B20DFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AE820B2A;
	Thu,  9 Nov 2023 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmJG7+FI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F12032E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 17:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58E7C433C7;
	Thu,  9 Nov 2023 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699549979;
	bh=ZdDEDwGaoGmncYko5OyZYolzr0sAOcB5bDJPtsb5AXs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EmJG7+FISQLzAjTsDumxZXycwL6EMQ8BkgVQ1stjsM5XG9cy4xrQzAeVE2JPwEe9v
	 KYhbj+FdvrEhJ5ESsBURTeQQEUm0XhGCWkDodEHI0FgzB2WITjstec52HMnt0uGNUO
	 rjZsGHwNE5X+gzgozl+XywIPZq4pd4SiNtTXXOQ6UuFdmeT4LaWhYdCya0V9GvDT+J
	 Knl9nIkX+XPADckkA0YLz1s8kfPZcpfHC4pRf+KewU3dLYlAfFYm+NX9vp4kZNHNmp
	 dLkhhPjqAjVj/9arjAoitAiaQOnPybHLZCxuUFgYR0LpVlEndKZSbFOB9Mxg0owcd3
	 /hAatsn23Ob6g==
Message-ID: <df19ec64ac7456fbe50885e59a07505f1133f5b6.camel@kernel.org>
Subject: Re: [GIT PULL] xfs: new code for 6.7
From: Jeff Layton <jlayton@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Chandan Babu R
	 <chandanbabu@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: catherine.hoang@oracle.com, cheng.lin130@zte.com.cn,
 dchinner@redhat.com,  djwong@kernel.org, hch@lst.de,
 linux-fsdevel@vger.kernel.org,  linux-xfs@vger.kernel.org, osandov@fb.com
Date: Thu, 09 Nov 2023 12:12:57 -0500
In-Reply-To: <CAHk-=wj3oM3d-Hw2vvxys3KCZ9De+gBN7Gxr2jf96OTisL9udw@mail.gmail.com>
References: <87fs1g1rac.fsf@debian-BULLSEYE-live-builder-AMD64>
	 <CAHk-=wj3oM3d-Hw2vvxys3KCZ9De+gBN7Gxr2jf96OTisL9udw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-08 at 13:29 -0800, Linus Torvalds wrote:
> On Wed, 8 Nov 2023 at 02:19, Chandan Babu R <chandanbabu@kernel.org> wrot=
e:
> >=20
> > I had performed a test merge with latest contents of torvalds/linux.git=
.
> >=20
> > This resulted in merge conflicts. The following diff should resolve the=
 merge
> > conflicts.
>=20
> Well, your merge conflict resolution is the same as my initial
> mindless one, but then when I look closer at it, it turns out that
> it's wrong.
>=20
> It's wrong not because the merge itself would be wrong, but because
> the conflict made me look at the original, and it turns out that
> commit 75d1e312bbbd ("xfs: convert to new timestamp accessors") was
> buggy.
>=20
> I'm actually surprised the compilers don't complain about it, because
> the bug means that the new
>=20
>         struct timespec64 ts;
>=20
> temporary isn't actually initialized for the !XFS_DIFLAG_NEWRTBM case.
>=20
> The code does
>=20
>   xfs_rtpick_extent(..)
>   ...
>         struct timespec64 ts;
>         ..
>         if (!(mp->m_rbmip->i_diflags & XFS_DIFLAG_NEWRTBM)) {
>                 mp->m_rbmip->i_diflags |=3D XFS_DIFLAG_NEWRTBM;
>                 seq =3D 0;
>         } else {
>         ...
>         ts.tv_sec =3D (time64_t)seq + 1;
>         inode_set_atime_to_ts(VFS_I(mp->m_rbmip), ts);
>=20
> and notice how 'ts.tv_nsec' is never initialized. So we'll set the
> nsec part of the atime to random garbage.
>=20
> Oh, I'm sure it doesn't really *matter*, but it's most certainly wrong.
>=20
> I am not very happy about the whole crazy XFS model where people cast
> the 'struct timespec64' pointer to an 'uint64_t' pointer, and then say
> 'now it's a sequence number'. This is not the only place that
> happened, ie we have similar disgusting code in at least
> xfs_rtfree_extent() too.
>=20
> That other place in xfs_rtfree_extent() didn't have this bug - it does
> inode_get_atime() unconditionally and this keeps the nsec field as-is,
> but that other place has the same really ugly code.
>=20
> Doing that "cast struct timespec64 to an uint64_t' is not only ugly
> and wrong, it's _stupid_. The only reason it works in the first place
> is that 'struct timespec64' is
>=20
>   struct timespec64 {
>         time64_t        tv_sec;                 /* seconds */
>         long            tv_nsec;                /* nanoseconds */
>   };
>=20
> so the first field is 'tv_sec', which is a 64-bit (signed) value.
>=20
> So the cast is disgusting - and it's pointless. I don't know why it's
> done that way. It would have been much cleaner to just use tv_sec, and
> have a big comment about it being used as a sequence number here.
>=20
> I _assume_ there's just a simple 32-bit history to this all, where at
> one point it was a 32-bit tv_sec, and the cast basically used both
> 32-bit fields as a 64-bit sequence number.  I get it. But it's most
> definitely wrong now.
>=20
> End result: I ended up fixing that bug and removing the bogus casts in
> my merge. I *think* I got it right, but apologies in advance if I
> screwed up. I only did visual inspection and build testing, no actual
> real testing.
>=20
> Also, xfs people may obviously have other preferences for how to deal
> with the whole "now using tv_sec in the VFS inode as a 64-bit sequence
> number" thing, and maybe you prefer to then update my fix to this all.
> But that horrid casts certainly wasn't the right way to do it.
>=20
> Put another way: please do give my merge a closer look, and decide
> amongst yourself if you then want to deal with this some other way.
>=20
>               Linus

I think when I was looking at that code, I had convinced myself that the
tv_nsec field didn't matter at all, since it wasn't being used, but I
should have done a better job of preserving the existing value. Mea
culpa.

Your fixup looks right to me. Thanks for fixing it.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>

