Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99092467E76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 20:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353576AbhLCTzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 14:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353441AbhLCTzQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:55:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE17C061751;
        Fri,  3 Dec 2021 11:51:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9F269CE2830;
        Fri,  3 Dec 2021 19:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4450C53FCE;
        Fri,  3 Dec 2021 19:51:46 +0000 (UTC)
Date:   Fri, 3 Dec 2021 19:51:43 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Avoid live-lock in fault-in+uaccess loops with
 sub-page faults
Message-ID: <Yap1TzdTNHJDXodO@arm.com>
References: <20211201193750.2097885-1-catalin.marinas@arm.com>
 <CAHc6FU7gXfZk7=Xj+RjxCqkmsrcAhenfbeoqa4AmHd5+vgja7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7gXfZk7=Xj+RjxCqkmsrcAhenfbeoqa4AmHd5+vgja7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andreas,

On Fri, Dec 03, 2021 at 04:29:18PM +0100, Andreas Gruenbacher wrote:
> On Wed, Dec 1, 2021 at 8:38 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Following the discussions on the first series,
> >
> > https://lore.kernel.org/r/20211124192024.2408218-1-catalin.marinas@arm.com
> >
> > this new patchset aims to generalise the sub-page probing and introduce
> > a minimum size to the fault_in_*() functions. I called this 'v2' but I
> > can rebase it on top of v1 and keep v1 as a btrfs live-lock
> > back-portable fix.
> 
> that's what I was actually expecting, an updated patch series that
> changes the btrfs code to keep track of the user-copy fault address,
> the corresponding changes to the fault_in functions to call the
> appropriate arch functions, and the arch functions that probe far
> enough from the fault address to prevent deadlocks. In this step, how
> far the arch functions need to probe depends on the fault windows of
> the user-copy functions.

I have that series as well, see the top patch here (well, you've seen it
already):

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=devel/btrfs-live-lock-fix

But I'm not convinced it's worth it if we go for the approach in v2
here. A key difference between v2 and the above branch is that
probe_subpage_writeable() checks exactly what is given (min_size) in v2
while in the devel/btrfs-live-lock-fix branch it can be given a
PAGE_SIZE or more but only checks the beginning 16 bytes to cover the
copy_to_user() error margin. The latter assumes that the caller will
always attempt the fault_in() from where the uaccess failed rather than
relying on the fault_in() itself to avoid the live-lock.

v1 posted earlier also checks the full range but only in
fault_in_writeable() which seems to be only relevant for btrfs in the
arm64 case.

Maybe I should post the other series as an alternative, get some input
on it.

> A next step (as a patch series on top) would be to make sure direct
> I/O also takes sub-page faults into account. That seems to require
> probing the entire address range before the actual copying. A concern
> I have about this is time-of-check versus time-of-use: what if
> sub-page faults are added after the probing but before the copying?

With direct I/O (that doesn't fall back to buffered), the access is done
via the kernel mapping following a get_user_pages(). Since the access
here cannot cope with exceptions, it must be unchecked. Yes, we do have
the time-of-use vs check problem but I'm not worried. I regard MTE as a
probabilistic security feature. Things get even murkier if the I/O is
done by some DMA engine which ignores tags anyway.

CHERI, OTOH, is a lot more strict but there is no check vs use issue
here since all permissions are encoded in the pointer itself (we might
just expand access_ok() to take this into account).

We could use the min_size logic for this I think in functions like
gfs2_file_direct_read() you'd have to fault in first and than invoke
iomap_dio_rw().

Anyway, like I said before, I'd leave the MTE accesses for direct I/O
unchecked as they currently are, I don't think it's worth the effort and
the potential slow-down (it will be significant).

> Other than that, an approach like adding min_size parameters might
> work except that maybe we can find a better name. Also, in order not
> to make things even more messy, the fault_in functions should probably
> continue to report how much of the address range they've failed to
> fault in. Callers can then check for themselves whether the function
> could fault in min_size bytes or not.

That's fine as well. I did it this way because I found the logic easier
to write.

> > The fault_in_*() API improvements would be a new
> > series. Anyway, I'd first like to know whether this is heading in the
> > right direction and whether it's worth adding min_size to all
> > fault_in_*() (more below).
> >
> > v2 adds a 'min_size' argument to all fault_in_*() functions with current
> > callers passing 0 (or we could make it 1). A probe_subpage_*() call is
> > made for the min_size range, though with all 0 this wouldn't have any
> > effect. The only difference is btrfs search_ioctl() in the last patch
> > which passes a non-zero min_size to avoid the live-lock (functionally
> > that's the same as the v1 series).
> 
> In the btrfs case, the copying will already trigger sub-page faults;
> we only need to make sure that the next fault-in attempt happens at
> the fault address. (And that the fault_in functions take the user-copy
> fuzz into account, which we also need for byte granularity copying
> anyway.) Otherwise, we're creating the same time-of-check versus
> time-of-use disparity as for direct-IO here, unnecessarily.

I don't think it matters for btrfs. In some way, you'd have the time of
check vs use problem even if you fault in from where uaccess failed.
It's just that in practice it's impossible to live-lock as it needs very
precise synchronisation to change the tags from another CPU. But you do
guarantee that the uaccess was correct.

> > In terms of sub-page probing, I don't think with the current kernel
> > anything other than search_ioctl() matters. The buffered file I/O can
> > already cope with current fault_in_*() + copy_*_user() loops (the
> > uaccess makes progress). Direct I/O either goes via GUP + kernel mapping
> > access (and memcpy() can't fault) or, if the user buffer is not PAGE
> > aligned, it may fall back to buffered I/O. So we really only care about
> > fault_in_writeable(), as in v1.
> 
> Yes from a regression point of view, but note that direct I/O still
> circumvents the sub-page fault checking, which seems to defeat the
> whole point.

It doesn't entirely defeat it. From my perspective MTE is more of a best
effort to find use-after-free etc. bugs. It has a performance penalty
and I wouldn't want to make it worse. Some libc allocators even go for
untagged memory (unchecked) if the required size is over some threshold
(usually when it falls back to multiple page allocations). That's more
likely to be involved in direct I/O anyway, so the additional check in
fault_in() won't matter.

> > Linus suggested that we could use the min_size to request a minimum
> > guaranteed probed size (in most cases this would be 1) and put a cap on
> > the faulted-in size, say two pages. All the fault_in_iov_iter_*()
> > callers will need to check the actual quantity returned by fault_in_*()
> > rather than bail out on non-zero but Andreas has a patch already (though
> > I think there are a few cases in btrfs etc.):
> >
> > https://lore.kernel.org/r/20211123151812.361624-1-agruenba@redhat.com
> >
> > With these callers fixed, we could add something like the diff below.
> > But, again, min_size doesn't actually have any current use in the kernel
> > other than fault_in_writeable() and search_ioctl().
> 
> We're trying pretty hard to handle large I/O requests efficiently at
> the filesystem level. A small, static upper limit in the fault-in
> functions has the potential to ruin those efforts. So I'm not a fan of
> that.

I can't comment on this, I haven't spent time in the fs land. But I did
notice that generic_perform_write() for example limits the fault_in() to
PAGE_SIZE. So this min_size potential optimisation wouldn't make any
difference.

-- 
Catalin
