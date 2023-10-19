Return-Path: <linux-fsdevel+bounces-799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04AA7D04FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 00:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77DADB20DD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 22:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1C74292A;
	Thu, 19 Oct 2023 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr1q75UN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00819440
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 22:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA01C433C7;
	Thu, 19 Oct 2023 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697755273;
	bh=QrXcJSvkmaQhGlxDlCzTaTqOEgDsZKKUGEg6yjmzxzg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tr1q75UNywUIX/G6rnqagELNuFJwsL6pDbS6FlXWZlik9RgUeQusLFYc5diqKK9ql
	 mPjhMDQEuo8T1/QLme8z+3R0ZkNkPifdGSSwtsihpkHyjk8zrZ4bs4nfZMqb+RYomH
	 XCkUotEhvIKc70pvPqo7Hn7c9pK+iaGc8QakV7aEv9AkvvYxFRdoJPJC08VvICsx7O
	 wI8hLrYDRlOYjC4B7ldOO0oIL1GWcH7h16/zWoqPqjyZPVhwwvj37JF480Bx7XLNLq
	 eMckjH8mw2HavbZ1wfJqhXhq/euFpxU2lvg6uyIVp1VQNmfOE2UgS+b6AWTZyRGyjS
	 FrUgtEfZHaF+w==
Message-ID: <69b627f565d6ca92182b7100cd1178a28646eef0.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
 <dsterba@suse.com>,  Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Amir Goldstein <amir73il@gmail.com>, Jan Kara
 <jack@suse.de>, David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org
Date: Thu, 19 Oct 2023 18:41:09 -0400
In-Reply-To: <87o7gu2rxw.ffs@tglx>
References: <87o7gu2rxw.ffs@tglx>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-20 at 00:00 +0200, Thomas Gleixner wrote:
> Jeff!
>=20
> On Wed, Oct 18 2023 at 13:41, Jeff Layton wrote:
> > +void ktime_get_mg_fine_ts64(struct timespec64 *ts)
> > +{
> > +	struct timekeeper *tk =3D &tk_core.timekeeper;
> > +	unsigned long flags;
> > +	u32 nsecs;
> > +
> > +	WARN_ON(timekeeping_suspended);
> > +
> > +	raw_spin_lock_irqsave(&timekeeper_lock, flags);
> > +	write_seqcount_begin(&tk_core.seq);
>=20
> Depending on the usage scenario, this will end up as a scalability issue
> which affects _all_ of timekeeping.
>=20
> The usage of timekeeper_lock and the sequence count has been carefully
> crafted to be as non-contended as possible. We went a great length to
> optimize that because the ktime_get*() functions are really hotpath all
> over the place.
>=20

> Exposing such an interface which wreckages that is a recipe for disaster
> down the road. It might be a non-issue today, but once we hit the
> bottleneck of that global lock, we are up the creek without a
> paddle.
>=20

Thanks for taking the explanation, Thomas. That's understandable, and
that was my main worry with this set. I'll look at doing this another
way given your feedback. I just started by plumbing this into the
timekeeping code since that seemed like the most obvious place to do it.

I think it's probably still possible to do this by caching the values
returned by the timekeeper at the vfs layer, but there seems to be some
reticence to the basic idea that I don't quite understand yet.

> Well not really, but all we can do then is fall back to
> ktime_get_real(). So let me ask the obvious question:
>=20
>      Why don't we do that right away?
>=20
> Many moons ago when we added ktime_get_real_coarse() the main reason was
> that reading the time from the underlying hardware was insanely
> expensive.
>=20
> Many moons later this is not true anymore, except for the stupid case
> where the BIOS wreckaged the TSC, but that's a hopeless case for
> performance no matter what. Optimizing for that would be beyond stupid.
>=20
> I'm well aware that ktime_get_real_coarse() is still faster than
> ktime_get_real() in micro-benchmarks, i.e. 5ns vs. 15ns on the four
> years old laptop I'm writing this.
>=20
> Many moons ago it was in the ballpark of 40ns vs. 5us due to TSC being
> useless and even TSC read was way more expensive (factor 8-10x IIRC) in
> comparison. That really mattered for FS, but does todays overhead still
> make a difference in the real FS use case scenario?
>=20
> I'm not in the position of running meaningful FS benchmarks to analyze
> that, but I think the delta between ktime_get_real_coarse() and
> ktime_get_real() on contemporary hardware is small enough that it
> justifies this question.
>=20
> The point is that both functions have pretty much the same D-cache
> pattern because they access the same data in the very same
> cacheline. The only difference is the actual TSC read and the extra
> conversion, but that's it. The TSC read has been massively optimized by
> the CPU vendors. I know that the ARM64 counter has been optimized too,
> though I have no idea about PPC64 and S390, but I would be truly
> surprised if they didn't optimize the hell out of it because time read
> is really used heavily both in kernel and user space.
>=20
> Does anyone have numbers on contemporary hardware to shed some light on
> that in the context of FS and the problem at hand?

That was sort of my suspicion and it's good to have confirmation that
fetching a fine-grained timespec64 from the timekeeper is cheap. It
looked that way when I was poking around in there, but I wasn't sure
whether it was always the case.

It turns out however that the main benefit of using a coarse-grained
timestamp is that it allows the file system to skip a lot of inode
metadata updates.

The way it works today is that when we go to update the timestamp on an
inode, we check whether they have made any visible change, and we dirty
the inode metadata if so. This means that we only really update the
inode on disk once per jiffy or so when an inode is under heavy writes.

The idea with this set is to only use fine-grained timestamps when
someone is actively fetching them via getattr. When the mtime or ctime
is viewed via getattr, we mark the inode and then the following
timestamp update will get a fine-grained timestamp (unless the coarse-
grained clock has already ticked).

That allows us to keep the number of inode updates down to a bare
minimum, but still allows an observer to always see a change in the
timestamp when there have been changes to the inode.

Thanks again for the review! For the next iteration I (probably) won't
need to touch the timekeeper.
--=20
Jeff Layton <jlayton@kernel.org>

