Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7B94324E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 19:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhJRRYQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 13:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233984AbhJRRYP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:24:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A68E3610C8;
        Mon, 18 Oct 2021 17:13:38 +0000 (UTC)
Date:   Mon, 18 Oct 2021 18:13:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
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
Message-ID: <YW2rPyvwltDb8wdJ@arm.com>
References: <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk>
 <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk>
 <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
 <YWSnvq58jDsDuIik@arm.com>
 <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
 <YWXFagjRVdNanGSy@arm.com>
 <CAHk-=wg3prAnhWZetJvwZdugn7A7CpP4ruz1tdewha=8ZY8AJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg3prAnhWZetJvwZdugn7A7CpP4ruz1tdewha=8ZY8AJw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 10:58:46AM -0700, Linus Torvalds wrote:
> On Tue, Oct 12, 2021 at 10:27 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > Apart from fault_in_pages_*(), there's also fault_in_user_writeable()
> > called from the futex code which uses the GUP mechanism as the write
> > would be destructive. It looks like it could potentially trigger the
> > same infinite loop on -EFAULT.
> 
> Hmm.
> 
> I think the reason we do fault_in_user_writeable() using GUP is that
> 
>  (a) we can avoid the page fault overhead
> 
>  (b) we don't have any good "atomic_inc_user()" interface or similar
> that could do a write with a zero increment or something like that.
> 
> We do have that "arch_futex_atomic_op_inuser()" thing, of course. It's
> all kinds of crazy, but we *could* do
> 
>        arch_futex_atomic_op_inuser(FUTEX_OP_ADD, 0, &dummy, uaddr);
> 
> instead of doing the fault_in_user_writeable().
> 
> That might be a good idea anyway. I dunno.

I gave this a quick try for futex (though MTE is not affected at the
moment):

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=devel/sub-page-faults

However, I still have doubts about fault_in_pages_*() probing every 16
bytes, especially if one decides to change these routines to be
GUP-based.

> > A more invasive change would be to return a different error for such
> > faults like -EACCESS and treat them differently in the caller.
> 
> That's _really_ hard for things like "copy_to_user()", that isn't a
> single operation, and is supposed to return the bytes left.
> 
> Adding another error return would be nasty.
> 
> We've had hacks like "squirrel away the actual error code in the task
> structure", but that tends to be unmaintainable because we have
> interrupts (and NMI's) doing their own possibly nested atomics, so
> even disabling preemption won't actually fix some of the nesting
> issues.

I think we can do something similar to the __get_user_error() on arm64.
We can keep the __copy_to_user_inatomic() etc. returning the number of
bytes left but change the exception handling path in those routines to
set an error code or boolean to a pointer passed at uaccess routine call
time. The caller would do something along these lines:

	bool page_fault;
	left = copy_to_user_inatomic(dst, src, size, &page_fault);
	if (left && page_fault)
		goto repeat_fault_in;

copy_to_user_nofault() could also change its return type from -EFAULT to
something else based on whether page_fault was set or not.

Most architectures will use a generic copy_to_user_inatomic() wrapper
where page_fault == true for any fault. Arm64 needs some adjustment to
the uaccess fault handling to pass the fault code down to the exception
code. This way, at least for arm64, I don't think an interrupt or NMI
would be problematic.

> All of these things make me think that the proper fix ends up being to
> make sure that our "fault_in_xyz()" functions simply should always
> handle all faults.
> 
> Another option may be to teach the GUP code to actually check
> architecture-specific sub-page ranges.

Teaching GUP about this is likely to be expensive. A put_user() for
probing on arm64 uses a STTR instruction that's run with user privileges
on the user address and the user tag checking mode. The GUP code for
MTE, OTOH, would need to explicitly read the tag in memory and compare
it with the user pointer tag (which is normally cleared in the GUP code
by untagged_addr()).

To me it makes more sense for the fault_in_*() functions to only deal
with those permissions the kernel controls, i.e. the pte. Sub-page
permissions like MTE or CHERI are controlled by the user directly, so
the kernel cannot fix them up anyway. Rather than overloading
fault_in_*() with additional checks, I think we should expand the
in-atomic uaccess API to cover the type of fault.

-- 
Catalin
