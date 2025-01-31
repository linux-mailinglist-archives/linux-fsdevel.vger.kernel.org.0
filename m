Return-Path: <linux-fsdevel+bounces-40461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30ADA2385E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 01:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE74166988
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 00:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE23208CA;
	Fri, 31 Jan 2025 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J7bvUW8n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E31BC41
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738285006; cv=none; b=JN6aIHs/pDR/v7kEVaUPhq2zVJrgsLl/PfGXOiEk4gNgHQmSCdp3n8AuYoyxlZdefqOzqiVVIXmFsnGX2qXfMoDh+AwEczlqZp0zozRH2jtt4zItHW/bSr3FxEHm6rk6sUuTs7pG58JQVBtsSUNSA4yZyfXjCkmmnvwPajTjKm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738285006; c=relaxed/simple;
	bh=DmlkNGIwBq2BHFfe9dTN8ulaWDFYJ9ajgeQxzc4gLcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDoeDX2UzUkEc/KNZQX+XD5FgU4FpwpZ3OINhPDVvK7MdWg5XJOwJDJTcUmeKDCKS1QFkSF7OVdF+k3XcYoA2P4vvRNjjoRgAtQsOMyTC/7+PLvwj/xnpUhcg8F08Ihd1Z8sXrn0GZLio3UnwUP4+/60CVnffx+TwV8oCiJfZRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J7bvUW8n; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 30 Jan 2025 19:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738284992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=avPaJpVH7Pab5E/nLZyJe7cNB2w6WY4JGgMxsQQZoLo=;
	b=J7bvUW8n2NgMEXZfxwPtNK23tPZ8+mIgYT4W3XuWAuPzEMMTvfECV0iGcuG4YXwhhthKs2
	91dHafAdZJe4aUK/OlNIGFIJv1yRInCsiwlx4Jnepv0D1RIs5nXKJoYN7IDfKPCpQNzr9j
	RLaQ35L+7VIjl210A9SG64wpAI7tdJ0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Ted Ts'o <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev, miklos@szeredi.hu, 
	linux-bcachefs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev
Subject: Re: [PATCH 0/7] Move prefaulting into write slow paths
Message-ID: <t7rjw6a462k5sm2tdviyd7sq6n44uxb3haai566m4hm7dvvlpi@btt3blanouck>
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
 <qpeao3ezywdn5ojpcvchaza7gd6qeb57kvvgbxt2j4qsk4qoey@vrf4oy2icixd>
 <f35aa9a2-edac-4ada-b10b-8a560460d358@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f35aa9a2-edac-4ada-b10b-8a560460d358@intel.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 30, 2025 at 08:04:49AM -0800, Dave Hansen wrote:
> On 1/29/25 23:44, Kent Overstreet wrote:
> > On Wed, Jan 29, 2025 at 10:17:49AM -0800, Dave Hansen wrote:
> >> tl;dr: The VFS and several filesystems have some suspect prefaulting
> >> code. It is unnecessarily slow for the common case where a write's
> >> source buffer is resident and does not need to be faulted in.
> >>
> >> Move these "prefaulting" operations to slow paths where they ensure
> >> forward progress but they do not slow down the fast paths. This
> >> optimizes the fast path to touch userspace once instead of twice.
> >>
> >> Also update somewhat dubious comments about the need for prefaulting.
> >>
> >> This has been very lightly tested. I have not tested any of the fs/
> >> code explicitly.
> > 
> > Q: what is preventing us from posting code to the list that's been
> > properly tested?
> > 
> > I just got another bcachefs patch series that blew up immediately when I
> > threw it at my CI.
> > 
> > This is getting _utterly ridiculous_.
> 
> In this case, I started with a single patch for generic code that I knew
> I could test. In fact, I even had the 9-year-old binary sitting on my
> test box.
> 
> Dave Chinner suggested that I take the generic pattern go look a _bit_
> more widely in the tree for a similar pattern. That search paid off, I
> think. But I ended up touching corners of the tree I don't know well and
> don't have test cases for.

That's all well and good, but the testing thing is really coming to a
head. I have enough on my plate without back-and-forth 

> > I built multiuser test infrastructure with a nice dashboard that anyone
> > can use, and the only response I've gotten from the old guard is Ted
> > jumping in every time I talk about it to say "no, we just don't want to
> > rewrite our stuff on _your_ stuff!". Real helpful, that.
> 
> Sounds pretty cool! Is this something that I could have and should have
> used to test the bcachefs patch?  I see some trees in here:
> 
> 	https://evilpiepirate.org/~testdashboard/ci
> 
> But I'm not sure how to submit patches to it. Do you need to add users
> manually? I wonder, though, how we could make it easier to find. I
> didn't see anything Documentation/filesystems/bcachefs/ about this.

Yes, I give out user accounts and that gives you a config file you can
edit to specify branches to test and tests to run; it then automatically
watches those branch(es).

Here's the thing though, the servers cost real money. I give out
accounts to community members (and people working on bcachefs are using
it and it's working wel), but if you've got a big tech company email
address you (or your managers) will have to be pitching in. Not
subsidizing you guys :)

> 
> >>  1. Deadlock avoidance if the source and target are the same
> >>     folios.
> >>  2. To check the user address that copy_folio_from_iter_atomic()
> >>     will touch because atomic user copies do not check the address.
> >>  3. "Optimization"
> >>
> >> I'm not sure any of these are actually valid reasons.
> >>
> >> The "atomic" user copy functions disable page fault handling because
> >> page faults are not very atomic. This makes them naturally resistant
> >> to deadlocking in page fault handling. They take the page fault
> >> itself but short-circuit any handling.
> > 
> > #1 is emphatically valid: the deadlock avoidance is in _both_ using
> > _atomic when we have locks held, and doing the actual faulting with
> > locks dropped... either alone would be a buggy incomplete solution.
> 
> I was (badly) attempting to separate out the two different problems:
> 
> 	1. Doing lock_page() twice, which I was mostly calling the
> 	   "deadlock"
> 	2. Retrying the copy_folio_from_iter_atomic() forever which I
> 	   was calling the "livelock"
> 
> Disabling page faults fixes #1.
> Doing faulting outside the locks somewhere fixes #2.
> 
> So when I was talking about "Deadlock avoidance" in the cover letter, I
> was trying to focus on the double lock_page() problem.
> 
> > This needs to be reflected and fully described in the comments, since
> > it's subtle and a lot of people don't fully grok what's going on.
> 
> Any suggestions for fully describing the situation? I tried to sprinkle
> comments liberally but I'm also painfully aware that I'm not doing a
> perfect job of talking about the fs code.

The critical thing to cover is the fact that mmap means that page faults
can recurse into arbitrary filesystem code, thus blowing a hole in all
our carefully crafted lock ordering if we allow that while holding
locks - you didn't mention that at all.

> > I'm fairly certain we have ioctl code where this is mishandled and thus
> > buggy, because it takes some fairly particular testing for lockdep to
> > spot it.
> 
> Yeah, I wouldn't be surprised. It was having a little chuckle thinking
> about how many engineers have discovered and fixed this problem
> independently over the years in all the file system code in all the OSes.

Oh, this is the easy one - mmap and dio is where it really gets into
"stories we tell young engineers to keep them awake at night".

> 
> >> copy_folio_from_iter_atomic() also *does* have user address checking.
> >> I get a little lost in the iov_iter code, but it does know when it's
> >> dealing with userspace versus kernel addresses and does seem to know
> >> when to do things like copy_from_user_iter() (which does access_ok())
> >> versus memcpy_from_iter().[1]
> >>
> >> The "optimization" is for the case where 'source' is not faulted in.
> >> It can avoid the cost of a "failed" page fault (it will fail to be
> >> handled because of the atomic copy) and then needing to drop locks and
> >> repeat the fault.
> > 
> > I do agree on moving it to the slowpath - I think we can expect the case
> > where the process's immediate workingset is faulted out while it's
> > running to be vanishingly small.
> 
> Great! I'm glad we're on the same page there.
> 
> For bcachefs specifically, how should we move forward? If you're happy
> with the concept, would you prefer that I do some manual bcachefs
> testing? Or leave a branch sitting there for a week and pray the robots
> test it?

No to the sit and pray. If I see one more "testing? that's something
other people do" conversation I'll blow another gasket.

xfstests supports bcachefs, and if you need a really easy way to run it
locally on all the various filesystems, I have a solution for that:

https://evilpiepirate.org/git/ktest.git/

If you want access to my CI that runs all that in parallel across 120
VMs with the nice dashboard - shoot me an email and I'll outline server
costs and we can work something out.

