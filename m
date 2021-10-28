Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFEB43F1FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 23:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhJ1Vm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 17:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231401AbhJ1Vm6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:42:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FD7360FF2;
        Thu, 28 Oct 2021 21:40:28 +0000 (UTC)
Date:   Thu, 28 Oct 2021 22:40:25 +0100
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
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
Message-ID: <YXsYyWIKjvm6a9GX@arm.com>
References: <YXCbv5gdfEEtAYo8@arm.com>
 <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com>
 <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
 <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com>
 <YXhH0sBSyTyz5Eh2@arm.com>
 <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
 <YXmkvfL9B+4mQAIo@arm.com>
 <CAHk-=wjQqi9cw1Guz6a8oBB0xiQNF_jtFzs3gW0k7+fKN-mB1g@mail.gmail.com>
 <YXsUNMWFpmT1eQcX@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXsUNMWFpmT1eQcX@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:20:52PM +0100, Catalin Marinas wrote:
> On Wed, Oct 27, 2021 at 02:14:48PM -0700, Linus Torvalds wrote:
> > On Wed, Oct 27, 2021 at 12:13 PM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > As an alternative, you mentioned earlier that a per-thread fault status
> > > was not feasible on x86 due to races. Was this only for the hw poison
> > > case? I think the uaccess is slightly different.
> > 
> > It's not x86-specific, it's very generic.
> > 
> > If we set some flag in the per-thread status, we'll need to be careful
> > about not overwriting it if we then have a subsequent NMI that _also_
> > takes a (completely unrelated) page fault - before we then read the
> > per-thread flag.
> > 
> > Think 'perf' and fetching backtraces etc.
> > 
> > Note that the NMI page fault can easily also be a pointer coloring
> > fault on arm64, for exactly the same reason that whatever original
> > copy_from_user() code was. So this is not a "oh, pointer coloring
> > faults are different". They have the same re-entrancy issue.
> > 
> > And both the "pagefault_disable" and "fault happens in interrupt
> > context" cases are also the exact same 'faulthandler_disabled()'
> > thing. So even at fault time they look very similar.
> 
> They do look fairly similar but we should have the information in the
> fault handler to distinguish: not a page fault (pte permission or p*d
> translation), in_task(), user address, fixup handler. But I agree the
> logic looks fragile.
> 
> I think for nested contexts we can save the uaccess fault state on
> exception entry, restore it on return. Or (needs some thinking on
> atomicity) save it in a local variable. The high-level API would look
> something like:
> 
> 	unsigned long uaccess_flags;	/* we could use TIF_ flags */
> 
> 	uaccess_flags = begin_retriable_uaccess();
> 	copied = copy_page_from_iter_atomic(...);
> 	retry = end_retriable_uaccess(uaccess_flags);

It doesn't work with local flags, so it would need to be saved on
exception entry (interrupt, breakpoint etc.) on the stack, restore on
return. But the API would return pretty close (and probably still more
complicated than copy_*() returning an error code).

-- 
Catalin
