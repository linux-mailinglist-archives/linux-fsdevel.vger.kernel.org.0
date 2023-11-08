Return-Path: <linux-fsdevel+bounces-2449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12487E6081
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 23:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC4DB20E6F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 22:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C11536AE6;
	Wed,  8 Nov 2023 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+YoBAEF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B444E30358
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185AEC433C7;
	Wed,  8 Nov 2023 22:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699483921;
	bh=HEtmjQaJF0gpngzuMd7uAS6GdeVXsEyiEFttrNMCLZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+YoBAEFerirAURfyXz29Snkn78b6MV9g5HF5mNqO3mhbjpSa3K9ugS8HbLPOrKUu
	 EFEUsND0k8tEBjmhHl99oI1KEZgFhPver+cbAg/JwPUmLmKNag9Auw78yP1OndQZBV
	 Bs92t6zY7b5OxwF9nm7B4j908y+wKT+EfafkmebgfsvgaUeTDyO+Lzx+hYCafdoh1p
	 DkV4dhnObJIwh6fcIA1AWNXRqDBnBlxMFeKp7+xX2QbP68VojxrCmpwFdwq0sDy4Dd
	 T3cJ+YoVTNsFwkFR+58v0bXCJkZzdzwsmiFdy71UubyzT/pXq+xx2EeE/0x+jRsScL
	 zGan9Ds9/ATKg==
Date: Wed, 8 Nov 2023 14:52:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>, catherine.hoang@oracle.com,
	cheng.lin130@zte.com.cn, dchinner@redhat.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	osandov@fb.com
Subject: Re: [GIT PULL] xfs: new code for 6.7
Message-ID: <20231108225200.GY1205143@frogsfrogsfrogs>
References: <87fs1g1rac.fsf@debian-BULLSEYE-live-builder-AMD64>
 <CAHk-=wj3oM3d-Hw2vvxys3KCZ9De+gBN7Gxr2jf96OTisL9udw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj3oM3d-Hw2vvxys3KCZ9De+gBN7Gxr2jf96OTisL9udw@mail.gmail.com>

On Wed, Nov 08, 2023 at 01:29:16PM -0800, Linus Torvalds wrote:
> On Wed, 8 Nov 2023 at 02:19, Chandan Babu R <chandanbabu@kernel.org> wrote:
> >
> > I had performed a test merge with latest contents of torvalds/linux.git.
> >
> > This resulted in merge conflicts. The following diff should resolve the merge
> > conflicts.
> 
> Well, your merge conflict resolution is the same as my initial
> mindless one, but then when I look closer at it, it turns out that
> it's wrong.
> 
> It's wrong not because the merge itself would be wrong, but because
> the conflict made me look at the original, and it turns out that
> commit 75d1e312bbbd ("xfs: convert to new timestamp accessors") was
> buggy.
> 
> I'm actually surprised the compilers don't complain about it, because
> the bug means that the new
> 
>         struct timespec64 ts;
> 
> temporary isn't actually initialized for the !XFS_DIFLAG_NEWRTBM case.
> 
> The code does
> 
>   xfs_rtpick_extent(..)

Oh gosh.  Dave might have other things to say, but xfs_rtpick_extent is
the sort of function that I hate with the power of 1,000 suns.

Back in 2.6.x it apparently did this:

	seqp = (__uint64_t *)&mp->m_rbmip->i_d.di_atime;

At the time, xfs_inode.id.di_atime was a struct xfs_ictimestamp:

typedef struct xfs_ictimestamp {
	__int32_t	t_sec;		/* timestamp seconds */
	__int32_t	t_nsec;		/* timestamp nanoseconds */
} xfs_ictimestamp_t;

So the rt allocator thinks its maintaining a u64 new file counter in the
bitmap file's atime.  The lower 32bits ended up in t_sec, and the upper
32bits ended up in t_nsec.

At some point (4.6?) the function started using the VFS i_atime field
instead of the di_atime field.  On 32-bit systems the struct timespec
was still a struct of two int32 values and everything kept working the
way it always had.

On 64-bit systems, tv_sec is 64-bits which means the sequence counter
was only stored (incore, anyway) in tv_sec.  XFS truncates the upper
32-bits when writing the inode to disk because (at the time) it didn't
handle y2038.

IOWs, we broke the ondisk format in 2016 and nobody noticed.  Because
the allocator calls xfs_highbit64 on the sequence counter, the only
observable behavior change would be the starting location of a free
space search for the first rt file allocation after an upgrade from 4.5
to a newer kernel on a 64-bit machine.

(Or going back, obviously)

But then in 4.18 or so, the VFS inode switched to timespec64, at which
point /all/ of the 32-bit kernels "migrated" to storing the sequence
counter in tv_sec and truncating it when it goes out to disk.

Then in 5.10 we added y2038 support, so post-Covid filesystems truncate
less of the sequence counter.  #winning

>   ...
>         struct timespec64 ts;
>         ..
>         if (!(mp->m_rbmip->i_diflags & XFS_DIFLAG_NEWRTBM)) {
>                 mp->m_rbmip->i_diflags |= XFS_DIFLAG_NEWRTBM;
>                 seq = 0;
>         } else {
>         ...
>         ts.tv_sec = (time64_t)seq + 1;
>         inode_set_atime_to_ts(VFS_I(mp->m_rbmip), ts);

So... according to the pre-4.6 definition of the sequence counter this
is wrong, but OTOH it's not inconsistent with what was there in 6.4.

> and notice how 'ts.tv_nsec' is never initialized. So we'll set the
> nsec part of the atime to random garbage.
> 
> Oh, I'm sure it doesn't really *matter*, but it's most certainly wrong.

tv_nsec isn't explicitly initialized by rtpick_extent, but IIRC mkfs
initializes the ondisk inode's tv_nsec field and the kernel reads that
into the incore inode, so I dont't think it's leaking kernel memory
contents.

> I am not very happy about the whole crazy XFS model where people cast
> the 'struct timespec64' pointer to an 'uint64_t' pointer, and then say
> 'now it's a sequence number'. This is not the only place that
> happened, ie we have similar disgusting code in at least
> xfs_rtfree_extent() too.
> 
> That other place in xfs_rtfree_extent() didn't have this bug - it does
> inode_get_atime() unconditionally and this keeps the nsec field as-is,
> but that other place has the same really ugly code.
> 
> Doing that "cast struct timespec64 to an uint64_t' is not only ugly
> and wrong, it's _stupid_. The only reason it works in the first place
> is that 'struct timespec64' is
> 
>   struct timespec64 {
>         time64_t        tv_sec;                 /* seconds */
>         long            tv_nsec;                /* nanoseconds */
>   };
> 
> so the first field is 'tv_sec', which is a 64-bit (signed) value.

(yep)

> So the cast is disgusting - and it's pointless. I don't know why it's
> done that way. It would have been much cleaner to just use tv_sec, and
> have a big comment about it being used as a sequence number here.
> 
> I _assume_ there's just a simple 32-bit history to this all, where at
> one point it was a 32-bit tv_sec, and the cast basically used both
> 32-bit fields as a 64-bit sequence number.  I get it. But it's most
> definitely wrong now.

I don't even think it was good C back whenever it was written, but I was
probably in high school at that point. ;)

> End result: I ended up fixing that bug and removing the bogus casts in
> my merge. I *think* I got it right, but apologies in advance if I
> screwed up. I only did visual inspection and build testing, no actual
> real testing.

My opinion is that you've kept your tree consistent with what the kernel
has been doing for the last 5 years.  No comment about the s**tshow that
went on before that.

> Also, xfs people may obviously have other preferences for how to deal
> with the whole "now using tv_sec in the VFS inode as a 64-bit sequence
> number" thing, and maybe you prefer to then update my fix to this all.
> But that horrid casts certainly wasn't the right way to do it.

Yeah, I can work on that for the rt modernization patchset.

> Put another way: please do give my merge a closer look, and decide
> amongst yourself if you then want to deal with this some other way.

Let's see what the other devs say.  Thank you for taking Chandan's pull
request, by the way.

--D

> 
>               Linus

