Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8337435E99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhJUKIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 06:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231334AbhJUKIL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:08:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 064A8610FF;
        Thu, 21 Oct 2021 10:05:53 +0000 (UTC)
Date:   Thu, 21 Oct 2021 11:05:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
Message-ID: <YXE7fhDkqJbfDk6e@arm.com>
References: <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk>
 <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk>
 <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
 <YWSnvq58jDsDuIik@arm.com>
 <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
 <CAHc6FU7bpjAxP+4dfE-C0pzzQJN1p=C2j3vyXwUwf7fF9JF72w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7bpjAxP+4dfE-C0pzzQJN1p=C2j3vyXwUwf7fF9JF72w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 02:46:10AM +0200, Andreas Gruenbacher wrote:
> On Tue, Oct 12, 2021 at 1:59 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Mon, Oct 11, 2021 at 2:08 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >
> > > +#ifdef CONFIG_ARM64_MTE
> > > +#define FAULT_GRANULE_SIZE     (16)
> > > +#define FAULT_GRANULE_MASK     (~(FAULT_GRANULE_SIZE-1))
> >
> > [...]
> >
> > > If this looks in the right direction, I'll do some proper patches
> > > tomorrow.
> >
> > Looks fine to me. It's going to be quite expensive and bad for caches, though.
> >
> > That said, fault_in_writable() is _supposed_ to all be for the slow
> > path when things go south and the normal path didn't work out, so I
> > think it's fine.
> 
> Let me get back to this; I'm actually not convinced that we need to
> worry about sub-page-size fault granules in fault_in_pages_readable or
> fault_in_pages_writeable.
> 
> From a filesystem point of view, we can get into trouble when a
> user-space read or write triggers a page fault while we're holding
> filesystem locks, and that page fault ends up calling back into the
> filesystem. To deal with that, we're performing those user-space
> accesses with page faults disabled.

Yes, this makes sense.

> When a page fault would occur, we
> get back an error instead, and then we try to fault in the offending
> pages. If a page is resident and we still get a fault trying to access
> it, trying to fault in the same page again isn't going to help and we
> have a true error.

You can't be sure the second fault is a true error. The unlocked
fault_in_*() may race with some LRU scheme making the pte not accessible
or a write-back making it clean/read-only. copy_to_user() with
pagefault_disabled() fails again but that's a benign fault. The
filesystem should re-attempt the fault-in (gup would correct the pte),
disable page faults and copy_to_user(), potentially in an infinite loop.
If you bail out on the second/third uaccess following a fault_in_*()
call, you may get some unexpected errors (though very rare). Maybe the
filesystems avoid this problem somehow but I couldn't figure it out.

> We're clearly looking at memory at a page
> granularity; faults at a sub-page level don't matter at this level of
> abstraction (but they do show similar error behavior). To avoid
> getting stuck, when it gets a short result or -EFAULT, the filesystem
> implements the following backoff strategy: first, it tries to fault in
> a number of pages. When the read or write still doesn't make progress,
> it scales back and faults in a single page. Finally, when that still
> doesn't help, it gives up. This strategy is needed for actual page
> faults, but it also handles sub-page faults appropriately as long as
> the user-space access functions give sensible results.

As I said above, I think with this approach there's a small chance of
incorrectly reporting an error when the fault is recoverable. If you
change it to an infinite loop, you'd run into the sub-page fault
problem.

There are some places with such infinite loops: futex_wake_op(),
search_ioctl() in the btrfs code. I still have to get my head around
generic_perform_write() but I think we get away here because it faults
in the page with a get_user() rather than gup (and copy_from_user() is
guaranteed to make progress if any bytes can still be accessed).

-- 
Catalin
