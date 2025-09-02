Return-Path: <linux-fsdevel+bounces-60024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D19CB40F30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 23:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F16C7012A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 21:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B957270ECD;
	Tue,  2 Sep 2025 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="FrjqaAYX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAB26B942
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847797; cv=none; b=nPMo1BNw16MbArCsq+VN99Ncr/bYoU09SUzHhFu5oEYxkOnE17JZIoJUFWzmFKfFnDVSInfObvTLhFyUaVh7dO8PmimkOzs32WimoGo1ektuhs4Q8S87lfmO0Lg74ROr1wNs1LTrZPcGiK5Tt1ACLClW36Q9HFL+YI320gmwz28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847797; c=relaxed/simple;
	bh=8E/jvRDOHHG1BVOCMKNkeWwdydTDpXFSm7o5qzkPD7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkZJ9BxMUIfO5TMMubxCH3SeUJ9GJ5nStytxJyHODjx8c3AVEbFQQf+pOpZDMGuaDmG9IgjcX1wEv6tCwcxZwiYpbY/pc95CEA38/OX6FtlLtQkkx3X+wG1qmSOqD8Qd/fGAvxqJbcdbauvWkTndDZivIQSVfNkEl3EWG6piNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=FrjqaAYX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b47052620a6so269501a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 14:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1756847794; x=1757452594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZZ2lB4ISamXFZAgBQq/WzJ34jlGV8NbPOBhhzgO5xc=;
        b=FrjqaAYXTWHYDgaMwVXAK6kFa4V9Rw5rlXggdK7Zalb663iHU/gy+5z8VD8UoQOpap
         l1WNeytFye2dniIUdK75lB4J/yDtNvXaCCo1dXSqhSva+h58F4Hwh/6TKOGAAL/1movw
         ukP7YwSSOQFQK2I/PTE6yaUkTEXSZEqYXfaR4orQhfdCkiXPfGZX1oYwpmpcRe4Q4rcy
         RAxgZk3KKWj8/4CElgCVVKE7yPLWBKm/fO3IjaxCt6r52XGQ04t7oyGaDhRcZ5FVHWUZ
         twXJBqgFZg2cB7AdiUXbJjJN9dCa7aVMzRsxsSLMlChPQAmfQUZwiUSDnVTfOUED8MtX
         /jEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756847794; x=1757452594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZZ2lB4ISamXFZAgBQq/WzJ34jlGV8NbPOBhhzgO5xc=;
        b=tPS9EFNyerjkiYN+1IGmV+tuJhQybbZPk7ycicUsqT3JCHlnL4NOVj5gvjc0MXBNIU
         qujbLjHFFrLQF+rAI/Qj517RW3Q5N7IosditunaCaH2FxJ70jZVP0seQ4gAXOHYGBcoO
         gOltbxRb/E3VBgrGhEhebymnT9kU+wo+JLPwcB/bAq7Icu9s2oHo688xO14rcVXjyTTb
         VynoiuZae2XPL+IOnq/Oi4EuWowleV74GJq76ShbmPf+tMYzznWl3K9c7+Qu/+uZQtko
         SCI0cvxv91f0Wq5P8A8dbddk9pKwDd2g7kOeyWzIqS4958Zo4Snb4Z1WlqXc1aiJxFYB
         IExw==
X-Gm-Message-State: AOJu0YzKXOu5EjKdNrLQbSMJbpCalnvRTz42DCS2XXudHjT8HFlOPdVk
	XlaOhvohpj3FglXcac+NrJiSZDIfLbbBptRboI5Nrwii8W++24TCf3FyZHwXluwMEtY=
X-Gm-Gg: ASbGnctq6fOnZ7Ga26uE5ogRHsdVNKFl7rbRDavS1+RLeo5eoaDKhelr69NTYeEHPFE
	6NbchA3jzoPhn3tOlG0XSbT6q0lfYDNEn5Vij909JFTfHvxLFDDMZZvqkrjBK/cQ8YqLBp/RXpo
	YPrkdAK8sl1c32zw3LcXZmAsJXM7ePgNF5SgtHcBpgW1m1/Anol0O32WpRMZQNulJOcjBf3l5Bo
	N2I9ogWJ8+jUGb9w+IrU/I2QNIk/KLUHpY5sC9pAMCiemgWMGoSUSL/TauiAqcnaZUYJ7TuENxR
	YtZTdriW4pNaQZPvc+e3o8Rocno4eallZ6smXzba8bCdvmjhDTMRjk5pR7i2rYWmircb+ld/UAd
	TsZKuSli8eZiN4P533ycPCw==
X-Google-Smtp-Source: AGHT+IHqgzWZY4jO3oi/PHem49+FGqRRnap+DIQnalZ/YOlNL3IDg27pqaRPYcFtF0tDB6iYynVJPQ==
X-Received: by 2002:a17:902:cf45:b0:244:5bbe:acdd with SMTP id d9443c01a7336-24944b38adfmr114957675ad.27.1756847793615;
        Tue, 02 Sep 2025 14:16:33 -0700 (PDT)
Received: from localhost ([2600:382:862e:d4b7:c2c3:195b:a4b:5b18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da1b14sm138813495ad.77.2025.09.02.14.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 14:16:32 -0700 (PDT)
Date: Tue, 2 Sep 2025 17:16:29 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 00/54] fs: rework inode reference counting
Message-ID: <20250902211629.GA252154@fedora>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <eeu47pjcaxkfol2o2bltigfjvrz6eecdjwtilnmnprqh7dhdn7@rqi35ya5ilmv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeu47pjcaxkfol2o2bltigfjvrz6eecdjwtilnmnprqh7dhdn7@rqi35ya5ilmv>

On Tue, Sep 02, 2025 at 12:06:01PM +0200, Mateusz Guzik wrote:
> On Tue, Aug 26, 2025 at 11:39:00AM -0400, Josef Bacik wrote:
> 
> Hi Josef,
> 
> I read through the entire patchset and I think I got the hang of it.
> 
> Bottom line is I disagree with the core idea of the patchset and
> majority of the justification raised in the cover letter. :)
> 
> I'll be very to the point, trying to be as clear as possible and
> consequently lacking in soft-speak. Based on your name I presume you are
> also of Slavic descent, hopefully making it fine ;-)
> 
> I don't have a vote per se so this is not really a NAK. Instead I'm
> making a case to you and VFS maintaienrs to not include this.

Mateusz, I always value your feedback and your views. As long as you aren't
personally attacking anybody I have no problems being told that you think I'm
wrong, and I've never seen you be rude or combative, so I wasn't expecting to
see anything in this email I wouldn't want to hear.  I did this as an RFC
specifically hoping you would look at this and come up with a solution I hadn't
thought of. Thank you for thoroughly digging through this and giving a quite
thorough and well thought out response.

> 
> ACHTUNG: this is *really* long and I probably forgot to mention
> something.
> 
> Frankly the patchset seems to be a way to help btrfs by providing a new
> refcount (but not in a generic-friendly manner) while taking issue with
> refcount 0 having a "the inode is good to go if need be" meaning. I
> provide detailed reasoning below.
> 
> It warrants noting there is a lot of plain crap in the VFS layer.
> Between the wtf flags, bad docs for them, poor assert coverage,
> open-coded & repeated access to stuff (including internal state), I have
> to say someone(tm) needs to take a hammer to it.
> 
> However, as far as I can tell, modulo the quality of how things are
> expressed in the code (so to speak), the crux of what the layer is doing
> in terms of inode management follows idiomatic behavior I would expect
> to see, I just needs to be done better.
> 
> While there are perfectly legitimate reasons to introduce a "hold"
> reference counter, I pose the patchset at hand does not justify its
> introduction. If anything I will argue it would be a regression to do it
> the way it is proposed here, even if some variant of the new counter
> will find a use case.
> 
> > This series is the first part of a larger body of work geared towards solving a
> > variety of scalability issues in the VFS.
> > 
> 
> Elsewhere in the thread it is mentioned that there is a plan to remove
> the inode LRU and replace the inode hash with xarray after these changes.
> 
> I don't understand how this patchset paves the way for either of those
> things.
> 
> If anything, per notes from other people, it would probably be best if
> the inode LRU got removed first and this patchset got rebased on it (if
> it is to land at all).
> 
> For the inode hash the real difficulty is not really in terms of
> implementing something, but evaluating available options. Even if the
> statically-allocated hash should go (it probably should), the hashing
> function is not doing a good job (read: the hash is artificially
> underperforming) and merely replacing it with something else might not
> give an accurate picture whether the new pick for the data structure is
> genuinely the right choice (due to skewed comparison as the hash is
> gimped, both in terms of hashing func and global locking).
> 
> The minor technical problem which is there in the stock kernel and which
> remains unaddressed by your patchset is the need to take ->i_lock. Some
> of later commentary in this cover letter claims this is sorted out,
> but that's only true if someone already has a ref (as in the lock is
> only optionally ommitted).
> 
> In particular, if one was to implement fine-grained locking for the hash
> with bitlocks, I'm told the resulting ordering of bitlock -> spinlock
> would be problematic on RT kernels as the former type is a hack which
> literally only spins and does not support any form of preemption. The
> ordering can be swapped around to spinlock -> bitlock thanks to RCU
> (e.g., for deletion from the hash you would find the inode using RCU
> traversal, lock it, lock the chain and only then delete etc.).
> 
> Since your patchset keeps the lock in place, the kernel is in the same
> boat in both cases (also if the new thing only uses spinlocks).
> 
> As far as I know the other non-fs specific bottlenecks for inode
> handling are the super block list and dentry LRU, neither of which
> benefit from the patchset either.
> 
> So again I don't see how scalability work is facilitated by this patchset.
> 

Agreed, my wording is misleading at best here.

I'm tackling a wide range of things inside of the VFS. My priorities are

1. Simplify. Make everything easier to reason about. Most of our bugs come from
subtle interactions that are hard to reason about. Case in point, Christian took
2 full days to figure out the state of inode refcounting to be able to review
this code. This is a failure. We need core code to be easier to reason about so
it is harder to introduce regressions.

2. Efficiency. We do so many random things that make no sense. We have 4
different things where we loop through all of the inodes. The i_hash no longer
serves us. The LRU is unneeded overhead.

3. Scalability. I think in addressing the above 2, we can get to this one.

You're correct. This patchset doesn't directly address scalability. But it sets
the stage to do these other things safely.

I do not feel safe changing some of these core parts of VFS without a clearer
view of how inode lifetimes exist.

> > We have historically had a variety of foot-guns related to inode freeing.  We
> > have I_WILL_FREE and I_FREEING flags that indicated when the inode was in the
> > different stages of being reclaimed.  This lead to confusion, and bugs in cases
> > where one was checked but the other wasn't.  Additionally, it's frankly
> > confusing to have both of these flags and to deal with them in practice.
> > 
> 
> Per my opening remark I agree this situation is very poorly handled in
> the current code.
> 
> If my grep is right the only real consumer of I_WILL_FREE is ocfs2. In
> your patchset your just remove the usage. Given that other filesystems
> manage without it, I suspect the real solution is to change its
> ->drop_inode to generic_delete_inode() and handle the write in
> ->evict_inode.
> 
> The doc for the flag is most unhelpful, documenting how the flag is used
> but not explaining what for.
> 
> If I understood things correctly the flag is only there to prevent
> ->i_count acquire by other threads while the spin lock is dropped during
> inode write out.
> 
> Whether your ocfs patch lands or this bit gets reworked as described
> above, the flag is gone and we are only left with I_FREEING.
> 
> Hiding this behind a proper accessor (letting you know what's up with
> the inode) should cover your concern (again see bottom of the e-mail for
> a longer explanation).
> 
> > However, this exists because we have an odd behavior with inodes, we allow them
> > to have a 0 reference count and still be usable. This again is a pretty unfun
> > footgun, because generally speaking we want reference counts to be meaningful.
> > 
> 
> This is not an odd behavior. This in fact the idiomatic handling of
> objects which remain cached if there are no active users. I don't know
> about the entirety of the Linux kernel, but dentries are also handled
> the same way.
> 
> I come from the BSD land but I had also seen my share of Solaris and I
> can tell you all of these also follow this core idea in places I looked.
> 
> If anything deviating from this should raise eyebrows.
> 

Yes, it is typical in dcache an icache. It is not typical in every other
reference counting system. My argument is that 0 == "potentially ok to access
under X circumstances" is a bad paradigm to have. We should strive to stick to 0
== this object cannot be used, because this is a far more common practice WRT
reference counting.

Now I'm not saying we shouldn't every do something different, but having been in
file systems for a while, I don't think icache is a place where we need to be
special.

> I can however agree that the current magic flags + refcount do make for
> a buggy combination, but that's not an inherent property of using this
> method.
> 
> > The problem with the way we reference inodes is the final iput(). The majority
> > of file systems do their final truncate of a unlinked inode in their
> > ->evict_inode() callback, which happens when the inode is actually being
> > evicted. This can be a long process for large inodes, and thus isn't safe to
> > happen in a variety of contexts. Btrfs, for example, has an entire delayed iput
> > infrastructure to make sure that we do not do the final iput() in a dangerous
> > context. We cannot expand the use of this reference count to all the places the
> > inode is used, because there are cases where we would need to iput() in an IRQ
> > context  (end folio writeback) or other unsafe context, which is not allowed.
> > 
> 
> I don't believe ->i_obj_count is needed to facilitate this.
> 
> Suppose iput() needs to become callable from any context, just like
> fput().
> 
> What it can do is atomically drop the ref it is not the last one or punt
> all of it to task_work/a dedicated task queue.

Agreed. Btrfs does this with the delayed iput. I had actually thought of doing
this originally. I was worried that the overhead of adding this would be
unwanted, so I went for the dual refcount solution instead.

I'm totally happy if we want to say delayed iput is the solution and then we can
avoid the second reference count.

However, I think that i_obj_count does provide value in the cases where we want
a lighter-weight refcount for internal tracking. ->s_inodes and the various
writeback lists are where this is used and I think it makes the most sense. But
again, delayed iput also accomplishes the same thing so I'm totally open to this
being the desired solution.

> 
> Basically same thing as fput(), except the ref is expected to be dropped
> by the code doing deferred processing if ->i_count == 1.
> 
> Note that with your patchset iput() still takes spinlocks, which
> prevents it from being callable from IRQs at least.
> 
> But suppose ->i_obj_count makes sense to add. Below I explain why I
> disagree with the way it is done.
> 
> > To that end, resolve this by introducing a new i_obj_count reference count. This
> > will be used to control when we can actually free the inode. We then can use
> > this reference count in all the places where we may reference the inode. This
> > removes another huge footgun, having ways to access the inode itself without
> > having an actual reference to it. The writeback code is one of the main places
> > where we see this. Inodes end up on all sorts of lists here without a proper
> > reference count. This allows us to protect the inode from being freed by giving
> > this an other code mechanisms to protect their access to the inode.
> > 
> 
> I read through writeback vs iput() handling and it is very oddly
> written, indeed looking fishy.  I don't know the history here, given the
> state of the code I 300% believe there were bugs in terms of lifetime
> management/racing against iput().

Exactly, this is my main argument, and I didn't do a good job articulating that
in my summary email, my apologies.

It takes a ridiculuous amount of effort to reason about what we're doing in
these places. I want to make it simpler to reason about. Because from there we
can start making bigger changes.

> 
> But the crux of what the code is doing is perfectly sane and in fact
> what I would expect to happen unless there is a good reason not to.
> 
> The crucial point here is setting up the inode for teardown (and thus
> preventing new refs from showing up) and stalling it as long as there
> are pending consumers. That way they can still safely access everything
> they need.
> 
> For this work the code needs a proper handshake (if you will), which
> *is* arranged with locking -- writeback (or other code with similar
> needs) either wins against teardown and does the write or loses and
> pretends the inode is not there (or fails to see it). If writeback wins,
> teardown waits. This only needs readable helpers to not pose a problem,
> which is not hard to implement.
> 
> Note your patchset does not remove the need to do this, it merely
> possibly simplifies clean up after (but see below).

Agreed, that is my goal.

> 
> This brings me to the problem with how ->i_obj_count is proposed. In
> this patchset it merely gates the actual free of the inode, allowing all
> other teardown to progress.
> 
> Suppose one was to use ->i_obj_count in writeback to guarantee inode
> liveness -- worst case iobj_put() from writeback ends up freeing the
> inode.
> 
> As mentioned above, the first side of the problem is still there with
> your patchset: you still need to synchronize against writeback starting
> to work on the inode.
> 
> But let's assume the other side -- just the freeing -- is now sorted out
> with the count.
> 
> The problem with it is the writeback code historically was able to
> access the entire of the inode. With teardown progressing in parallel
> this is no longer true an what is no longer accessible depends entirely
> on timing. If there are "bad" accesses, you are going to find the hard
> way.
> 

Agreed, but that was also always the case before. Now we at least have
i_obj_count to make sure the object itself doesn't go away.

A file system could always (and still can) redirty an inode while it's going
down and writeback could miss it.  These patches do not eliminate this, it just
makes sure we are super clear that the object itself will not be deleted.

> In order to feel safe here one would need to audit the entire of
> writeback code to make sure it does not do anything wrong here and
> probably do quite a bit of fuzzing with KMSAN et al.

I think that i_obj_count accomplishes this without all of that work.

> 
> Furthermore, imagine some time in the future one would need to add
> something which needs to remain valid for the duration of writeback in
> progress. Then you are back to the current state vs waiting on writeback
> or you need to move more things around after i_obj_count drops to 0.
> 
> Or you can make sure iput() can safely wait for a wakeup from writeback
> and not worry about a thorough audit of all inode accessess nor any
> future work adding more. This is the current approach.
> 
> General note is that a hold count merely gating the actual free invites
> misuse where consumers race against teardown thinking something is still
> accessible and only crapping out when they get unlucky.
> 
> The ->i_obj_count refs/puts around hash and super block list
> manipulation only serve as overhead. Suppose they are not there. With
> the rest of your proposal it is an invariant that i_obj_count is at
> least 1 when iput() is being called. Meaning whatever refs are present
> or not on super block or the hash literally play no role. In fact, if
> they are there, it is an invariant they are not the last refs to drop.
> 
> Even in the btrfs case you are just trying to defer actual free of the
> inode, which is not necessarily all that safe in the long run given the
> remarks above.
> 
> But suppose for whatever reason you really want to punt ->evict_inodes()
> processing.
> 
> My suggestion would be the following:
> 
> The hooks for ->evict_inodes() can start returning -EAGAIN. Then if you
> conclude you can't do the work in context you got called from, evict()
> can defer you elsewhere and then you get called from a spot where you
> CAN do it, after which the rest of evict() is progressing.
> 
> Something like:
> 
> the_rest_of_evict() {
>         if (S_ISCHR(inode->i_mode) && inode->i_cdev)
>                 cd_forget(inode);
> 
>         remove_inode_hash(inode);
> 	....
> }
> 
> /* runs from task_work, some task queue or whatever applicable */
> evict_deferred() {
> 	ret = op->evict_inode(inode);
> 	BUG_ON(ret == -EAGAIN);
> 	the_rest_of_evict(inode);
> }
> 
> evict() {
> 	....
>         if (op->evict_inode) {
>                 ret = op->evict_inode(inode);
> 		if (ret == -EAGAIN) {
> 			evict_defer(inode);
> 			return;
> 		}
>         } else {
>                 truncate_inode_pages_final(&inode->i_data);
>                 clear_inode(inode);
>         }
> 	
> 	the_rest_of_evict(inode);
> }
> 
> Optionally ->evict_inodes() func can get gain an argument denoting who
> is doing the call (evict() or evict_deferred()).
> 
> > With this we can separate the concept of the inode being usable, and the inode
> > being freed. 
> [snip]
> > With not allowing inodes to hit a refcount of 0, we can take advantage of that
> > common pattern of using refcount_inc_not_zero() in all of the lockless places
> > where we do inode lookup in cache.  From there we can change all the users who
> > check I_WILL_FREE or I_FREEING to simply check the i_count. If it is 0 then they
> > aren't allowed to do their work, othrwise they can proceed as normal.
> 
> But this is already doable, just avoidably open-coded.
> 
> In your patchset this is open-coded with icount_read() == 0, which is
> also leaking state it should not.
> 
> You could hide this behind can_you_grab_a_ref().
> 
> On the current kernel the new helper would check the count + flags
> instead.
> 
> Your consumers which no longer openly do it in this patchset would look
> the same.
> 
> So here is an outline of what I suggest. First I'm going to talk about
> sorting out ->i_state and then about inode transition tracking.
> 
> Accesses to ->i_state are open-coded everywhere, some places use
> READ_ONCE/WRITE_ONCE while others use plain loads/stores. None of this
> validates whether ->i_lock is held and for cases where the caller is
> fine with unstable flags, there is no way to validate this is what they
> are signing up for (for example maybe the place assumes ->i_lock is in
> fact held?).
> 
> As an absolute minimum this should hide behind 3 accessors:
> 
> 1. istate_store, asserting the lock is held. WRITE_ONCE
> 2. istate_load, asserting the lock is held. READ_ONCE or plain load
> 3. istate_load_unlocked, no asserts. the consumer explicitly spells out
> they understand the value can change from under them. another READ_ONCE
> to prevent the compiler from fucking with reloads.
> 
> Maybe hide the field behind a struct so that spelled out i_state access
> fails to compile (similarly to how atomics are handled).
> 
> Suppose the I_WILL_FREE flag got sorted out.
> 
> Then the kernel is left with I_NEW, I_CLEAR, I_FREEING and maybe
> something extra.
> 
> I think this is much more manageable but still primitive.
> 
> An equivalent can be done with enums in a way which imo is much more
> handy.
> 
> Then various spots all over the VFS layer can validate they got a state
> which can be legally observed for their usage. Note mere refcount being
> 0 or not does not provide that granularity as a collection of flags or
> an enum.
> 
> For illustrative purposes, suppose:
> DEAD -- either hanging out after rcu freed or never used to begin with
> UNDER_CONSTRUCTION -- handed out by the allocator, still being created.
> invalid (equivalent to I_NEW?)
> CONSTRUCTED -- all done (equivalent to no flags?)
> DESTROYING -- equivalent to I_FREEING?
> 
> With this in place it is handy to validate that for example you are
> transitionting from CONSTRUCTED to DESTROYING, but not from CONSTRUCTED
> to DEAD.
> 
> You can also assert no UNDER_CONSTRUCTION inode escaped into the wild
> (this would happen in various vfs primitives, e.g., prior to taking the
> inode rwsem)
> 
> This is all equivalent to the flag manipulation, except imo clearer.
> 
> Suppose the flags are to stay. They can definitely hide behind helpers,
> there is no good reason for anyone outside of fs.h or inode.c to know
> about their meaning.
> 
> I claim the enums *can* escape as they can be easily reasoned about.
> 
> So... I don't offer to do any of this, I hope I made a convincing case
> against the patchset at least.


Alright I see what you're suggesting. What I want is to have the refcounts be
the ultimate arbiter of the state of the inode. We still need I_NEW and
I_CREATING. I want to separate the dirty flags off to the side so we can use
bitops for I_CREATING and I_NEW. From there we can do simple things about
waiting where we need to, and eliminate i_lock for those accesses. That way
inode lookup becomes xarray walk under RCU,
refcount_inc_not_zero(&inode->i_count), if (unlikely(test_bit(I_NEW))) etc.

This has all been long and I think I've got the gist of what you're suggesting.
I'm going to restate it here so I'm sure we're on the same page.

1. Don't do the i_obj_count thing.
2. Clean-up all the current weirdness by defining helpers that clearly define
the flow of the inode lifetime.
3. Remove the flags that are no longer necessary.
4. Continue on with my other work to remove i_hash and the i_lru.

I don't disagree with this approach. I would however like to argue that changing
the refcounting rules to be clear accomplishes a lot of the above goals, and
gives us access to refcount_t which allows us to capture all sorts of bad
behavior without needing to duplicate the effort.

As an alternative approach, I could do the following.

1. Pull the delayed iput work from btrfs into the core VFS.
2. In all the places where we have dubious lifetime stuff (aka where I use
i_obj_count), replace it with more i_count usage, and rely on the delayed iput
infrastructure to save us here.
3. Change the rules so we never have 0 refcount objects.
4. Convert to refcount_t.
5. Remove the various flags.
6. Continue with my existing plans.

Does this sound like a reasonable compromise?  Do my explanations make sense?
Did I misunderstand something fundamentally in your response?

I'm not married to my work, I want to find a solution we're all happy with. I'm
starting a new job this week so my ability to pay a lot of attention to this is
going to be slightly diminished, so I apologize if I missed something.  Thanks,

Josef

