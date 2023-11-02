Return-Path: <linux-fsdevel+bounces-1802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E76E17DEF96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 11:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7545C281AE4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A114F13ADF;
	Thu,  2 Nov 2023 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZJ9pBBp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B4113AC8
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 10:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3897C433C8;
	Thu,  2 Nov 2023 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698920115;
	bh=Q2Pw88Smwr2tP11TBVI1gQsAdzs/pokawrj4+qe5P3o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GZJ9pBBpUlY69n1aPU0VTU2Nb/im1AXs0bYUAdqqHUvx80F3Pni3V0mAHxi6nJnL9
	 xKer34VF3ykecUHUrKHi6CjlqBJp5lBq568F3gAIt55L21QnCydXqEXkKbItSfgTUG
	 jYkwZ0XkLZVxiwZ3B1q1wRuKtFgVajJL19+tnsuFgQUc1hHrm+iIEv0ZHMRPrYgqap
	 SuGPqC/4K8YM+rT3O0tru3SquBHNU7/YJxMuonL22dCgE0hyj9ypyDnQOgxxnwBsQr
	 KHJfaTCu3Lo3fBx2/lt1iIS14RL/+rFrGqejCCKJmdGTy0sf+IhgClCvCf2aJXRVdi
	 Tbxy/yjqnFaZw==
Message-ID: <d28e527ebb9375f3aad89532e09ff875bd9572eb.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, Amir Goldstein <amir73il@gmail.com>,
  Kent Overstreet <kent.overstreet@linux.dev>, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, John Stultz
 <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd
 <sboyd@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J.
 Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,  Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara
 <jack@suse.de>, David Howells <dhowells@redhat.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org
Date: Thu, 02 Nov 2023 06:15:11 -0400
In-Reply-To: <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com>
References: <ZTjMRRqmlJ+fTys2@dread.disaster.area>
	 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
	 <ZTnNCytHLGoJY9ds@dread.disaster.area>
	 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
	 <ZUAwFkAizH1PrIZp@dread.disaster.area>
	 <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
	 <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
	 <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
	 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
	 <ZUF4NTxQXpkJADxf@dread.disaster.area>
	 <20231101101648.zjloqo5su6bbxzff@quack3>
	 <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-01 at 10:10 -1000, Linus Torvalds wrote:
> On Wed, 1 Nov 2023 at 00:16, Jan Kara <jack@suse.cz> wrote:
> >=20
> > OK, but is this compatible with the current XFS behavior? AFAICS curren=
tly
> > XFS sets sb->s_time_gran to 1 so timestamps currently stored on disk wi=
ll
> > have some mostly random garbage in low bits of the ctime.
>=20
> I really *really* don't think we can use ctime as a "i_version"
> replacement. The whole fine-granularity patches were well-intentioned,
> but I do think they were broken.
>=20

I have to take some issue here. I still the basic concept is sound. The
original implementation was flawed but I think I have a scheme that
could address the problems with the multigrain series.

That said, everyone seems to be haring off after other solutions. I
don't much care which one we end up with, as long as the problem gets
fixed.

> Note that we can't use ctime as a "i_version" replacement for other
> reasons too - you have filesystems like FAT - which people do want to
> export - that have a single-second (or is it 2s?) granularity in
> reality, even though they report a 1ns value in s_time_gran.
>=20
> But here's a suggestion that people may hate, but that might just work
> in practice:
>=20
>  - get rid of i_version entirely
>=20
>  - use the "known good" part of ctime as the upper bits of the change
> counter (and by "known good" I mean tv_sec - or possibly even "tv_sec
> / 2" if that dim FAT memory of mine is right)
>=20
>  - make the rule be that ctime is *never* updated for atime updates
> (maybe that's already true, I didn't check - maybe it needs a new
> mount flag for nfsd)
>=20
>  - have a per-inode in-memory and vfs-internal (entirely invisible to
> filesystems) "ctime modification counter" that is *NOT* a timestamp,
> and is *NOT* i_version
>=20
>  - make the rule be that the "ctime modification counter" is always
> zero, *EXCEPT* if
>     (a) I_VERSION_QUERIED is set
>    AND
>     (b) the ctime modification doesn't modify the "known good" part of ct=
ime
>=20
> so how the "statx change cookie" ends up being "high bits tv_sec of
> ctime, low bits ctime modification cookie", and the end result of that
> is:
>=20
>  - if all the reads happen after the last write (common case), then
> the low bits will be zero, because I_VERSION_QUERIED wasn't set when
> ctime was modified
>=20
>  - if you do a write *after* a modification, the ctime cookie is
> guaranteed to change, because either the known good (sec/2sec) part of
> ctime is new, *or* the counter gets updated
>=20
>  - if the nfs server reboots, the in-memory counter will be cleared
> again, and so the change cookie will cause client cache invalidations,
> but *only* for those "ctime changed in the same second _after_
> somebody did a read".
>=20
>  - any long-time caches of files that don't get modified are all fine,
> because they will have those low bits zero and depend on just the
> stable part of ctime that works across filesystems. So there should be
> no nasty thundering herd issues on long-lived caches on lots of
> clients if the server reboots, or atime updates every 24 hours or
> anything like that.
>=20
> and note that *NONE* of this requires any filesystem involvement
> (except for the rule of "no atime changes ever impact ctime", which
> may or may not already be true).
>=20
> The filesystem does *not* know about that modification counter,
> there's no new on-disk stable information.
>=20
> It's entirely possible that I'm missing something obvious, but the
> above sounds to me like the only time you'd have stale invalidations
> is really the (unusual) case of having writes after cached reads, and
> then a reboot.
>=20
> We'd get rid of "inode_maybe_inc_iversion()" entirely, and instead
> replace it with logic in inode_set_ctime_current() that basically does
>=20
>  - if the stable part of ctime changes, clear the new 32-bit counter
>=20
>  - if I_VERSION_QUERIED isn't set, clear the new 32-bit counter
>=20
>  - otherwise, increment the new 32-bit counter
>=20
> and then the STATX_CHANGE_COOKIE code basically just returns
>=20
>    (stable part of ctime << 32) + new 32-bit counter
>=20
> (and again, the "stable part of ctime" is either just tv_sec, or it's
> "tv_sec >> 1" or whatever).
>=20
> The above does not expose *any* changes to timestamps to users, and
> should work across a wide variety of filesystems, without requiring
> any special code from the filesystem itself.
>=20
> And now please all jump on me and say "No, Linus, that won't work, becaus=
e XYZ".
>=20
> Because it is *entirely* possible that I missed something truly
> fundamental, and the above is completely broken for some obvious
> reason that I just didn't think of.
>=20

Yeah, I think this scheme is problematic for the reasons Trond pointed
out. I also don't quite see the advantage of this over what Dave Chinner
is proposing (using low-order bits of the ctime nsec field to hold a
change counter).
--=20
Jeff Layton <jlayton@kernel.org>

