Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A724368BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJURLw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 13:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhJURLr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:11:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA4EE61A0A;
        Thu, 21 Oct 2021 17:09:28 +0000 (UTC)
Date:   Thu, 21 Oct 2021 18:09:26 +0100
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
Message-ID: <YXGexrdprC+NTslm@arm.com>
References: <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk>
 <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk>
 <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
 <YWSnvq58jDsDuIik@arm.com>
 <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
 <CAHc6FU7bpjAxP+4dfE-C0pzzQJN1p=C2j3vyXwUwf7fF9JF72w@mail.gmail.com>
 <YXE7fhDkqJbfDk6e@arm.com>
 <CAHc6FU5xTMOxuiEDyc9VO_V98=bvoDc-0OFi4jsGPgWJWjRJWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5xTMOxuiEDyc9VO_V98=bvoDc-0OFi4jsGPgWJWjRJWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 04:42:33PM +0200, Andreas Gruenbacher wrote:
> On Thu, Oct 21, 2021 at 12:06 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Thu, Oct 21, 2021 at 02:46:10AM +0200, Andreas Gruenbacher wrote:
> > > When a page fault would occur, we
> > > get back an error instead, and then we try to fault in the offending
> > > pages. If a page is resident and we still get a fault trying to access
> > > it, trying to fault in the same page again isn't going to help and we
> > > have a true error.
> >
> > You can't be sure the second fault is a true error. The unlocked
> > fault_in_*() may race with some LRU scheme making the pte not accessible
> > or a write-back making it clean/read-only. copy_to_user() with
> > pagefault_disabled() fails again but that's a benign fault. The
> > filesystem should re-attempt the fault-in (gup would correct the pte),
> > disable page faults and copy_to_user(), potentially in an infinite loop.
> > If you bail out on the second/third uaccess following a fault_in_*()
> > call, you may get some unexpected errors (though very rare). Maybe the
> > filesystems avoid this problem somehow but I couldn't figure it out.
> 
> Good point, we can indeed only bail out if both the user copy and the
> fault-in fail.
> 
> But probing the entire memory range in fault domain granularity in the
> page fault-in functions still doesn't actually make sense. Those
> functions really only need to guarantee that we'll be able to make
> progress eventually. From that point of view, it should be enough to
> probe the first byte of the requested memory range, so when one of
> those functions reports that the next N bytes should be accessible,
> this really means that the first byte surely isn't permanently
> inaccessible and that the rest is likely accessible. Functions
> fault_in_readable and fault_in_writeable already work that way, so
> this only leaves function fault_in_safe_writeable to worry about.

I agree, that's why generic_perform_write() works. It does a get_user()
from the first byte in that range and the subsequent copy_from_user()
will make progress of at least one byte if it was readable. Eventually
it will hit the byte that faults. The gup-based fault_in_*() are a bit
more problematic.

Your series introduces fault_in_safe_writeable() and I think for MTE
doing a _single_ get_user(uaddr) (in addition to the gup checks for
write) would be sufficient as long as generic_file_read_iter() advances
by at least one byte (eventually).

This discussion started with the btrfs search_ioctl() where, even if
some bytes were written in copy_to_sk(), it always restarts from an
earlier position, reattempting to write the same bytes. Since
copy_to_sk() doesn't guarantee forward progress even if some bytes are
writable, Linus' suggestion was for fault_in_writable() to probe the
whole range. I consider this overkill since btrfs is the only one that
needs probing every 16 bytes. The other cases like the new
fault_in_safe_writeable() can be fixed by probing the first byte only
followed by gup.

I think we need to better define the semantics of the fault_in + uaccess
sequences. For uaccess, we document "a hard requirement that not storing
anything at all (i.e. returning size) should happen only when nothing
could be copied" (from linux/uaccess.h). I think we can add a
requirement for the new size_t-based fault_in_* variants without
mandating that the whole range is probed, something like: "returning
leftover < size guarantees that a subsequent user access at uaddr copies
at least one byte eventually". I said "eventually" but maybe we can come
up with some clearer wording for a liveness property.

Such requirement would ensure that infinite loops of fault_in_* +
uaccess make progress as long as they don't reset the probed range. Code
like btrfs search_ioctl() would need to be adjusted to avoid such range
reset and guarantee forward progress.

-- 
Catalin
