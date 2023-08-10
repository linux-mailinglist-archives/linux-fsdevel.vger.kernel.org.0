Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050F8777CDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 17:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjHJPzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 11:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjHJPzG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:55:06 -0400
Received: from out-93.mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960C22705
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 08:55:03 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691682901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AVdMMf3Ez0nvXnUUCcYf/CVTU5jvk8S0rTLkWGsI3Ww=;
        b=ZaNmm/wUCM4tF2qUB6wyl0PsUehvP6wFsmy+WMMvK96Mqo1CXP/aV6RKOxIaO45T9ri40Y
        1CJStFarmbHSrFPy8kEfx4XhQXF8/nbQy9FpSwUfRoHLuWLZNP/WBwmtqAeaE2brCBLdTL
        zQ3Zc3xF50Vg0KQP4RSu4z/GsYf1N6g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding Jens to the CC:

On Tue, Aug 08, 2023 at 06:27:29PM -0700, Linus Torvalds wrote:
> [ *Finally* getting back to this, I wanted to start reviewing the
> changes immediately after the merge window, but something else always
> kept coming up .. ]
> 
> On Tue, 11 Jul 2023 at 19:55, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > So: looks like we missed the merge window. Boo :)
> 
> Well, looking at the latest 'bcachefs-for-upstream' state I see, I'm
> happy to see the pre-requisites outside bcachefs being much smaller.
> 
> The six locks are now contained within bcachefs, and I like what I see
> more now that it doesn't play games with 'u64' and lots of bitfields.

Heh, I liked the bitfields - I prefer that to open coding structs, which
is a major pet peeve of mine. But the text size went down a lot a lot
without them (would like to know why the compiler couldn't constant fold
all that stuff out, but... not enough to bother).

Anyways...

> I'm still not actually convinced the locks *work* correctly, but I'm
> not seeing huge red flags. I do suspect there are memory ordering
> issues in there that would all be hidden on x86, and some of it looks
> strange, but not necessarily unfixable.
> 
> Example of oddity:
> 
>                 barrier();
>                 w->lock_acquired = true;
> 
> which really smells like it should be
> 
>                 smp_store_release(&w->lock_acquired, true);
> 
> (and the reader side in six_lock_slowpath() should be a
> smp_load_acquire()) because otherwise the preceding __list_del()
> writes would seem to possibly by re-ordered by the CPU to past the
> lock_acquired write, causing all kinds of problems.
> 
> On x86, you'd never see that as an issue, since all writes are
> releases, so the 'barrier()' compiler ordering ends up forcing the
> right magic.

Yep, agreed.

Also, there's a mildly interesting optimization here: the thread doing
the unlock is taking the lock on behalf of the thread waiting for the
lock, and signalling via the waitlist entry: this means the thread
waiting for the lock doesn't have to touch the cacheline the lock is on
at all. IOW, a better version of the handoff that rwsem/mutex do.

Been meaning to experiment with dropping osq_lock and instead just
adding to the waitlist and spinning on w->lock_acquired; this should
actually simplify the code and be another small optimization (less
bouncing of the lock cacheline).

> Some of the other oddity is around the this_cpu ops, but I suspect
> that is at least partly then because we don't have acquire/release
> versions of the local cpu ops that the code looks like it would want.

You mean using full barriers where acquire/release would be sufficient?

> I did *not* look at any of the internal bcachefs code itself (apart
> from the locking, obviously). I'm not that much of a low-level
> filesystem person (outside of the vfs itself), so I just don't care
> deeply. I care that it's maintained and that people who *are*
> filesystem people are at least not hugely against it.
> 
> That said, I do think that the prerequisites should go in first and
> independently, and through maintainers.

Matthew was planning on sending the iov_iter patch to you - right around
now, I believe, as a bugfix, since right now
copy_page_from_iter_atomic() silently does crazy things if you pass it a
compound page.

Block layer patches aside, are there any _others_ you really want to go
via maintainers? Because the consensus in the past when I was feeding in
prereqs for bcachefs was that patches just for bcachefs should go with
the bcachefs pull request.

> And there clearly is something very strange going on with superblock
> handling

This deserves an explanation because sget() is a bit nutty.

The way sget() is conventionally used for block device filesystems, the
block device open _isn't actually exclusive_ - sure, FMODE_EXCL is used,
but the holder is the fs type pointer, so it won't exclude with other
opens of the same fs type.

That means the only protection from multiple opens scribbling over each
other is sget() itself - but if the bdev handle ever outlives the
superblock we're completely screwed; that's a silent data corruption bug
that we can't easily catch, and if the filesystem teardown path has any
asynchronous stuff going on (and of course it does) that's not a hard
mistake to make. I've observed at least one bug that looked suspiciously
like that, but I don't think I quite pinned it down at the time.

It also forces the caller to separate opening of the block devices from
the rest of filesystem initialization, which is a bit less than ideal.

Anyways, bcachefs just wants to be able to do real exclusive opens of
the block devices, and we do all filesystem bringup with a single
bch2_fs_open() call. I think this could be made to work with the way
sget() wants to work, but it'd require reworking the locking in
sget() - it does everything, including the test() and set() calls, under
a single spinlock.

> and the whole crazy discussion about fput being delayed. It
> is what it is, and the patches I saw in this thread to not delay them
> were bad.

Jens claimed AIO was broken in the same way as io_uring, but it turned
out that it's not - the test he posted was broken.

And io_uring really is broken here. Look, the tests that are breaking
because of this are important ones (generic/388 in particular), and
those tests are no good to us if they're failing because of io_uring
crap and Jens is throwing up his hands and saying "trainwreck!" when we
try to get it fixed.

> As to the actual prereqs:
> 
> I'm not sure why 'd_mark_tmpfile()' didn't do the d_instantiate() that
> everybody seems to want, but it looks fine to me. Maybe just because
> Kent wanted the "mark" semantics for the naming. Fine.

Originally, we were doing d_instantiate() separately, in common code,
and the d_mark_tmpfile() was separate. Looking over the code again that
would still be a reasonable approach, so I'd keep it that way.

> The bio stuff should preferably go through Jens, or at least at a
> minimum be acked.

So, the block layer patches have been out on the list and been
discussed, and they got an "OK" from Jens -
https://lore.kernel.org/linux-fsdevel/aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk/

But that's a little ambiguous - Jens, what do you want to do with those
patches? I can re-send them to you now if you want to take them through
your tree, or an ack would be great.

> The '.faults_disabled_mapping' thing is a bit odd, but I don't hate
> it, and I could imagine that other filesystems could possibly use that
> approach instead of the current 'pagefault_disable/enable' games and
> ->nofault games to avoid the whole "use mmap to have the source and
> the destination of a write be the same page" thing.
> 
> So as things stand now, the stuff outside bcachefs itself I don't find
> objectionable.
> 
> The stuff _inside_ bcachefs I care about only in the sense that I
> really *really* would like a locking person to look at the six locks,
> but at the same time as long as it's purely internal to bcachefs and
> doesn't possibly affect anything else, I'm not *too* worried about
> what I see.
> 
> The thing that actually bothers me most about this all is the personal
> arguments I saw.  That I don't know what to do about. I don't actually
> want to merge this over the objections of Christian, now that we have
> a responsible vfs maintainer.

I don't want to do that to Christian either, I think highly of the work
he's been doing and I don't want to be adding to his frustration. So I
apologize for loosing my cool earlier; a lot of that was frustration
from other threads spilling over.

But: if he's going to be raising objections, I need to know what his
concerns are if we're going to get anywhere. Raising objections without
saying what the concerns are shuts down discussion; I don't think it's
unreasonable to ask people not to do that, and to try and stay focused
on the code.

He's got an open invite to the bcachefs meeting, and we were scheduled
to talk Tuesday but he was out sick - anyways, I'm looking forward to
hearing what he has to say.

More broadly, it would make me really happy if we could get certain
people to take a more constructive, "what do we really care about here
and how do we move forward" attitude instead of turning every
interaction into an opportunity to dig their heels in on process and
throw up barriers.

That burns people out, fast. And it's getting to be a problem in
-fsdevel land; I've lost count of the times I've heard Eric Sandeen
complain about how impossible it is to get things merge, and I _really_
hope people are taking notice about Darrick stepping away from XFS and
asking themselves what needs to be sorted out. Darrick writes
meticulous, well documented code; when I think of people who slip by
hacks other people are going to regret later, he's not one of them. And
yet, online fsck for XFS has been pushed back repeatedly because of
petty bullshit.

Scaling laws being what they are, that's a feature we're going to need,
and more importantly XFS cannot afford to lose more people - especially
Darrick.

To speak a bit to what's been driving _me_ a bit nuts in these
discussions, top of my list is that the guy who's been the most
obstinate and argumentative _to this day_ refuses to CC me when touching
code I wrote - and as a result we've had some really nasty bugs (memory
corruption, _silent data corruption_).

So that really needs to change. Let's just please have a little more
focus on not eating people's data, and being more responsible about
bugs.

Anyways, I just want to write the best code I can. That's all I care
about, and I'm always happy to interact with people who share that goal.

Cheers,
Kent
