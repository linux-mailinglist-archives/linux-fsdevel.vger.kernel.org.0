Return-Path: <linux-fsdevel+bounces-60905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89860B52C7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F6A3BC8BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 09:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886B42E7650;
	Thu, 11 Sep 2025 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvYEAs05"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37FC2C0278;
	Thu, 11 Sep 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581261; cv=none; b=amQumAFJLLLJVwt2wgAd3GpvspYpgY0PsGI20C4x7BZA6oRPL30eOJ/cpmhksDpWNwzZHIul69k666hEovpvCou9qnBB5Mbm7Q+tHhB7dmkZS2hlTMLsEhFkpOoogE2VhB+xt3au42aMjDqBW+8WqsuEYOaPAVy9lwv6rVD6C/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581261; c=relaxed/simple;
	bh=xXPHd32JYhgTalG8kpifUNaa8PhrQBlQhGPx/yrDY/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMoGxG8lTcV4e3szNq2AgSMx4njgyf3DMR50Lb2q0GW/wRwJzy2mLQen7Vq07Tao+/k5G5PVvvvPmayS2P5CxCCbLazD3rV1tTQ0ArnX7ZJYbQb0eNPX6eqm8xV1yLCf8vmEnlt9Bll9YsPFgAtmtGd82HdowpiviKgBD7zApzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvYEAs05; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e5190bca95so364932f8f.0;
        Thu, 11 Sep 2025 02:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757581258; x=1758186058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zeJHz6a78NSnyrzDSUKRS5CTm5vg0TjEUba7iWlitWE=;
        b=lvYEAs05Qs12G/WTs+xTRkbrNkor1NpCTIUc56xiL0PQGxI//RfXFVy2uQe+N8Ir7X
         +SYSbU0yHMKTRzdzvvgm1Km55jKh0FQsbZ7SZRonx8oAiCwX9SbStcRLgFHUft5zdIBg
         Jsms50WWmhVVvA/o7jdltGH4ExUlDW7WwERXvbPaZQYKbcaHGbFgMT+HjbUM1jkzcBB5
         6PzLodDxOre9awkV5mwz/7kgTTm7E4loMuhxBjdN50yILWQ6oDwt8uPqx+iwdx2wxwev
         qQXThqhOSrc1zBJfyXRnr+e/jy9F/06iOFVz2xFUknJ/eNotVvDa5eaX64Gt4vHKFnmB
         UMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757581258; x=1758186058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeJHz6a78NSnyrzDSUKRS5CTm5vg0TjEUba7iWlitWE=;
        b=pl4ZC8FdDQ7pGZiCNdv/3F11mkTPC8ZxSJcOaPZtz8q5RF9o7DVlF6zjjGT247cbLT
         375Z6ta8OAJXCxVG1JH4k6aRs83iGxhaDxUlef4eNrkuUc1orU1Ww6dxZGhIoxb/PJha
         tGFa2j7dEruaFeepI4LpVXdXS4cQxeWktAQgIUlGMMpXH/SPRZkZfIpvl4UttGiB8pHh
         Yl6047arPPYGLqIv9l6796GPCzjsxGfPdofKLNp+Cc+rpHVDtrpAKQ+wXmBdTf7cmkQF
         Hhtwwn9TC5QOAwryVa2CD2AXTE52AQzSABrWHBrkiLJ55xISBZkd2AidGageXoZe5sF5
         Z8pA==
X-Forwarded-Encrypted: i=1; AJvYcCUMGodfggPyfmCqBqJOfv4h2y6SY/I/xqotksBiGOQVcG5czNRN0+TF+JM46YB8OmQQkiyJCLmZzyDVbrIatw==@vger.kernel.org, AJvYcCUmPcH3NLC99WzobeHwyIHgwTK9CmXtZ0jnq2xDBskn5i9V5J9YnlbCZcXDKBjpDkcySZ4hiek5HssV@vger.kernel.org, AJvYcCX55iiXoNmVc8FbLkScccsQXmCGWqbB2RjJhhLf/6NPzfAGbHggVfEp2X3Ar77A7x9S8I8K9tG3s0tVdQ==@vger.kernel.org, AJvYcCXBrFKO6wU4XJlyjCQ8NzDbvAZnngAqBlxtuzwblrgp+yW/BZuH5c8oQwTUasm+yHyY85XtCPZakBLn+A==@vger.kernel.org, AJvYcCXgi9f+qTPXlyPqFGgcVsMY4uzm02fxTHSWuQkMWcOsHpn4oAa+Szk2haCBOZZlMNwbxyLoNwoLFGkgQ0FF@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTTNkSdwBP2L9z/3cPi2pj7b9x3WEdEBPKe4UyvZCKMHcIaIp
	GYAOKgHRSsWF8WtrqVafflCdkAxfgXdcJss1CkHNPcXfmuIbNXsFThY3/y0kcQ==
X-Gm-Gg: ASbGncuzkrdo8EeqGde5KxDtvoN2t2lOeeb4YfUi+jvTkBHM4R1zkZfMafKyoUR9EKO
	lUW6N7VgxB0mH9lTCkGBqrEUWRQWCrs5LEC/BV4Op/bykzfvbAIbXBCZ7qRqweCe/v6/JL9Q7Y+
	0fYbpcBdyVH52JfFONoekqh0omj79iDSn2IPrceXWvSe7KVl5NPOQcPjAjuovrN0CJ4nzi/JJmV
	4ub6HP0EGKSEA9vLHUl0l5PjyrTuQUIhTooRpUtIWokZu7CbS3L0Egj9Pq1ow9QXGplByuEcJpS
	7gWwVmI4f/OfH8PUGzJYi4HousllAmpnVw/MW3KfM8CBgjVahsCPPBFaYP6Ir+rSXUev56oUmdf
	M0EybCWXw9Wyl2tPrHxPccL81xL6vaM7m3J296FlsxgE0YTli
X-Google-Smtp-Source: AGHT+IEr7GQvDvEi9B/FGoDaoY53lnDrmqIQU4qVQ9+EBa2w2qrimBRdy3GV1iB3/C8Nxe/T2qgEEg==
X-Received: by 2002:a05:6000:2486:b0:3e5:394d:10bb with SMTP id ffacd0b85a97d-3e6440ef9b6mr15894371f8f.41.1757581257820;
        Thu, 11 Sep 2025 02:00:57 -0700 (PDT)
Received: from f (cst-prg-67-222.cust.vodafone.cz. [46.135.67.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e2eb5sm1628684f8f.58.2025.09.11.02.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:00:57 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:00:49 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v3 2/4] fs: hide ->i_state handling behind accessors
Message-ID: <h4xj2os657va3ylszf6hgqp2aab5bc7mywdacj3sl6py4tadhy@3eqqcdhxrdtc>
References: <20250911045557.1552002-1-mjguzik@gmail.com>
 <20250911045557.1552002-3-mjguzik@gmail.com>
 <aMJxydmz_azN7Kce@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMJxydmz_azN7Kce@dread.disaster.area>

On Thu, Sep 11, 2025 at 04:52:57PM +1000, Dave Chinner wrote:
> On Thu, Sep 11, 2025 at 06:55:55AM +0200, Mateusz Guzik wrote:
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> 
> So why did you choose these specific wrapper functions?
> 
> Some commentary on why you choose this specific API would be very
> useful here.
> 

Hi Dave,

thanks for the reply.

I believe the end state we are both aiming for is similar. I did not
spend any time in this cover letter outlining the state I consider
desirable for the long run, so I see why you would assume the new
i_state helpers are the endgame in what I'm looking for. I wrote about
it at length in my responses to the refcount thread, but maybe I failed
to convey it. Bottom line is I do support dedicated helpers, I don't
believe the kernel is in a good position to add them as is.

> > diff --git a/block/bdev.c b/block/bdev.c
> > index b77ddd12dc06..77f04042ac67 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -67,7 +67,7 @@ static void bdev_write_inode(struct block_device *bdev)
> >  	int ret;
> >  
> >  	spin_lock(&inode->i_lock);
> > -	while (inode->i_state & I_DIRTY) {
> > +	while (inode_state_read(inode) & I_DIRTY) {
> >  		spin_unlock(&inode->i_lock);
> >  		ret = write_inode_now(inode, true);
> >  		if (ret)
> 
> This isn't an improvement.
> 
> It makes the code harder to read, and now I have to go look at the
> implementation of a set of helper functions to determine if that's
> the right helper to use for the context the code is operating in.
> 
> What would be an improvement is making all the state flags disappear
> behind the same flag APIs as other high level objects that
> filesystems interface with. e.g. folio flags use
> folio_test.../folio_set.../folio_clear...
> 
> Looking wider, at least XFS, ext4 and btrfs use these same
> set/test/clear flag APIs for feature and mount option flags. XFS
> also uses them for oeprational state in mount, journal and per-ag
> structures, etc. It's a pretty common pattern.
> 
> Using it for the inode state flags would lead to code like this:
> 
> 	spin_lock(&inode->i_lock);
> 	while (inode_test_dirty(inode)) {
> 	.....
> 
> That's far cleaner and easier to understand and use than an API that
> explicitly encodes the locking context of the specific access being
> made in the helper names.
> 
> IOWs, the above I_DIRTY flag ends up with a set of wrappers that
> look like:
> 
> bool inode_test_dirty_unlocked(struct inode *inode)
> {
> 	return inode->i_state & I_DIRTY;
> }
> 
> bool inode_test_dirty(struct inode *inode)
> {
> 	lockdep_assert_held(&inode->i_lock);
> 	return inode_test_dirty_unlocked(inode);
> }
> 
> void inode_set_dirty(struct inode *inode)
> {
> 	lockdep_assert_held(&inode->i_lock);
> 	inode->i_state |= I_DIRTY;
> }
> 
> void inode_clear_dirty(struct inode *inode)
> {
> 	lockdep_assert_held(&inode->i_lock);
> 	inode->i_state &= ~I_DIRTY;
> }
> 
> With this, almost no callers need to know about the I_DIRTY flag -
> direct use of it is a red flag and/or an exceptional case.  It's
> self documenting that it is an exceptional case, and it better have
> a comment explaining why it is safe....
> 
> This also gives us the necessary lockdep checks to ensure the right
> locks are held when modifications are being made.
> 
> And best of all, the wrappers can be generated by macros; they don't
> need to be directly coded and maintained.
> 
> Yes, we have compound state checks, but like page-flags.h we can
> manually implement those few special cases such as this one:
> 

I need to make a statement that the current flag situation is just
horrid. Even ignoring the open-coded access, the real work will boil
down to sanitizing semantics (and hopefully removing numerous flags in
the process).

AFAICS you do agree i_state accesses need to be hidden, you just
disagree with how I did it.

The material difference between your proposal and mine is that you also
hide flags.

I very much would like to see consumers stop messing with them and
instead have consumer use well-defined helpers, but my idea how to get
there boils down to small incremental steps (assert-checked accesses
instead of open-codeding them being one of the first things to do).

Doing it with the current situation looks like a temporary API explosion
to me. I would like sanitized semantics instead, likely avoiding any
need to generate helpers and whatnot. It should also be easier to get
there with the smaller steps. I'm elaborating on this later.

I don't get the rest of the criticism though, most notably this part
from earlier:
> It makes the code harder to read, and now I have to go look at the
> implementation of a set of helper functions to determine if that's
> the right helper to use for the context the code is operating in.

If code like in your proposal does not require checking if that's the
right helper:
 	spin_lock(&inode->i_lock);
 	while (inode_test_dirty(inode)) {
	 	.....

I don't understand how this does:
 	spin_lock(&inode->i_lock);
 	while (inode_state_read(inode) & I_DIRTY) {
	 	.....

The funcs as proposed by me are very much self-documenting.  I would
expect people will need to look at them about once and be done with the
transition.

As I see it, it's the same as direct i_state access, except when you are
operating without the spinlock held you need to spell out you are
knowingly doing it.

The API is:
inode_state_read() -- no qualifiers, so you need the lock
inode_state_add() -- no qualifiers, so you need the lock
inode_state_del() -- no qualifiers, so you need the lock

Note misuse is caught by lockdep, like in your proposal.

inode_state_read_unstable() -- the developer explicitly spells out they
acknowledge i_state can change from under them. routine trivial to find
if you need it. I chose "_unstable" instead of "_unlocked" as the suffix
because the latter leads to fishy-looking code in practice, for example: 
@@ -1638,7 +1638,7 @@ cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
                cifs_fattr_to_inode(inode, fattr, false);
                if (sb->s_flags & SB_NOATIME)
                        inode->i_flags |= S_NOATIME | S_NOCMTIME;
-               if (inode->i_state & I_NEW) {
+               if (inode_state_read_unstable(inode) & I_NEW) {
                        inode->i_ino = hash;
                        cifs_fscache_get_inode_cookie(inode);
                        unlock_new_inode(inode);

inode_state_read_unlocked() followed by unlock_new_inode() would raise
my eyebrow.

Finally:
inode_state_add_unchecked() -- the developer explicitly asks to forego
sanity checks. this one has few users and is a kludge until vfs gets
better lifecycle tracking (as in it will go away). also note even in
your proposal you would need variants of this sort to account for XFS
not taking the lock

So at the end of it I don't believe my proposal adds any real
work/mental load/whatever on the count of the developer having to use
it. At the same time I claim it is an improvement as is because:
- it prevents surprise reloads thanks to READ_ONCE
- it adds the asserts to most consumers

The last bit helping pave the way to saner internals.

> > @@ -1265,7 +1265,7 @@ void sync_bdevs(bool wait)
> >  		struct block_device *bdev;
> >  
> >  		spin_lock(&inode->i_lock);
> > -		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
> > +		if (inode_state_read(inode) & (I_FREEING|I_WILL_FREE|I_NEW) ||
> 
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
> +		if (inode_test_new_or_freeing(inode)) ||
> 
> bool inode_test_new_or_freeing(struct inode *inode)
> {
> 	lockdep_assert_held(&inode->i_lock);
> 	return inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW);
> }
> 
> Or if we want to avoid directly using flags in these wrappers,
> we write them like this:
> 
> bool inode_test_new_or_freeing(struct inode *inode)
> {
> 	return inode_test_freeing(inode) ||
> 		inode_test_will_free(inode) ||
> 		inode_test_new(inode);
> }
> 

This I_FREEING, I_WILL_FREE and I_NEW stuff serves as a great example
why the kernel would use quite a bit of sanitizing before one rolls with
helpers hiding flag usage.

There are tests for:
- I_FREEING
- I_FREEING | I_WILL_FREE
- I_FREEING | I_NEW
- I_FREEING | I_WILL_FREE | I_NEW

I_WILL_FREE needs to die and I have WIP to do it (different than the
thing I posted). Reasoning about the flag is already convoluted and
would be much easier to review if it was not preceeded by introduction
of soon-to-go-away helpers.  Note I don't consider "inode->i_state &
I_FLAG" replaced with "inode_state_read(inode) & I_FLAG" to constitute a
readability problem (if anything it helps because you know the lock is
held at that spot).

Say I_WILL_FREE is gone. Even then the current tests are pretty wierd,
because they are *sometimes* in the vicinity of tests for I_CREATING.
The flag is inconsitently used and at best the inode hash APIs need some
sanitizing to make it clear what's going on, at worst some of it is
plain bugs. I may end up writing about it separately.

I_FREEING | I_NEW checks are also stemming from the kernel not having a
flag to denote "the inode is ready to use" (i.e., it should probably
grow a flag to explicitly say it. or maybe use a completely separate
mechanism (I mentioned enums as one idea in my responses to the refcount
patchset)).

And so on.

So assuming someone(tm) will clean these problems up (I intend to sort
out I_WILL_FREE, I don't know about the rest), vast majority of helpers
which would need to be added now will be stale immediately after.
I don't see any value spending time/churn on them.

> Writing the compound wrappers this way then allows future
> improvements such as changing the state flags to atomic bitops so
> we can remove all the dependencies on holding inode->i_lock to
> manipulate state flags safely.
> 
> Hence I think moving the state flags behind an API similar to folio
> state flags makes the code easier to read and use correctly, whilst
> also providing the checking that the correct locks are held at the
> correct times. It also makes it  easier to further improve the
> implementation in future because all the users of the API are
> completely isolated from the implmentation....
> 

So I think with the assumption someone would go with your proposal, but
also start sanitizing all the behavior (whacking I_WILL_FREE and so on),
I think the kernel would end up in a similar spot to the one I'm aiming
for.

However, I claim my steps are more feasible to go with.

