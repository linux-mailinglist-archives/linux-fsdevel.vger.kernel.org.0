Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943A0440174
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 19:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhJ2RxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 13:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhJ2RxK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:53:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7CA9610C7;
        Fri, 29 Oct 2021 17:50:38 +0000 (UTC)
Date:   Fri, 29 Oct 2021 18:50:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
Message-ID: <YXw0a9n+/PLAcObB@arm.com>
References: <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com>
 <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
 <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com>
 <YXhH0sBSyTyz5Eh2@arm.com>
 <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
 <YXmkvfL9B+4mQAIo@arm.com>
 <CAHk-=wjQqi9cw1Guz6a8oBB0xiQNF_jtFzs3gW0k7+fKN-mB1g@mail.gmail.com>
 <YXsUNMWFpmT1eQcX@arm.com>
 <CAHk-=wgzEKEYKRoR_abQRDO=R8xJX_FK+XC3gNhKfu=KLdxt3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgzEKEYKRoR_abQRDO=R8xJX_FK+XC3gNhKfu=KLdxt3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 28, 2021 at 03:32:23PM -0700, Linus Torvalds wrote:
> The pointer color fault (or whatever some other architecture may do to
> generate sub-page faults) is not only not recoverable in the sense
> that we can't fix it up, it also ends up being a forced SIGSEGV (ie it
> can't be blocked - it has to either be caught or cause the process to
> be killed).
> 
> And the thing is, I think we could just make the rule be that kernel
> code that has this kind of retry loop with fault_in_pages() would
> force an EFAULT on a pending SIGSEGV.
> 
> IOW, the pending SIGSEGV could effectively be exactly that "thread flag".
> 
> And that means that fault_in_xyz() wouldn't need to worry about this
> situation at all: the regular copy_from_user() (or whatever flavor it
> is - to/from/iter/whatever) would take the fault. And if it's a
> regular page fault,. it would act exactly like it does now, so no
> changes.
> 
> If it's a sub-page fault, we'd just make the rule be that we send a
> SIGSEGV even if the instruction in question has a user exception
> fixup.
> 
> Then we just need to add the logic somewhere that does "if active
> pending SIGSEGV, return -EFAULT".
> 
> Of course, that logic might be in fault_in_xyz(), but it migth also be
> a separate function entirely.
> 
> So this does effectively end up being a thread flag, but it's also
> slightly more than that - it's that a sub-page fault from kernel mode
> has semantics that a regular page fault does not.
> 
> The whole "kernel access doesn't cause SIGSEGV, but returns -EFAULT
> instead" has always been an odd and somewhat wrong-headed thing. Of
> course it should cause a SIGSEGV, but that's not how Unix traditionall
> worked. We would just say "color faults always raise a signal, even if
> the color fault was triggered in a system call".

It's doable and, at least for MTE, people have asked for a signal even
when the fault was caused by a kernel uaccess. But there are some
potentially confusing aspects to sort out:

First of all, a uaccess in interrupt should not force such signal as it
had nothing to do with the interrupted context. I guess we can do an
in_task() check in the fault handler.

Second, is there a chance that we enter the fault-in loop with a SIGSEGV
already pending? Maybe it's not a problem, we just bail out of the loop
early and deliver the signal, though unrelated to the actual uaccess in
the loop.

Third is the sigcontext.pc presented to the signal handler. Normally for
SIGSEGV it points to the address of a load/store instruction and a
handler could disable MTE and restart from that point. With a syscall we
don't want it to point to the syscall place as it shouldn't be restarted
in case it copied something. Pointing it to the next instruction after
syscall is backwards-compatible but it may confuse the handler (if it
does some reporting). I think we need add a new si_code that describes a
fault in kernel mode to differentiate from the genuine user access.

There was a discussion back in August on infinite loops with hwpoison
and Tony said that Andy convinced him that the kernel should not send a
SIGBUS for uaccess:

https://lore.kernel.org/linux-edac/20210823152437.GA1637466@agluck-desk2.amr.corp.intel.com/

I personally like the approach of a SIG{SEGV,BUS} on uaccess and I don't
think the ABI change is significant but ideally we should have a unified
approach that's not just for MTE.

Adding Andy and Tony (the background is potentially infinite loops with
faults at sub-page granularity: arm64 MTE, hwpoison, sparc ADI).

Thanks.

-- 
Catalin
