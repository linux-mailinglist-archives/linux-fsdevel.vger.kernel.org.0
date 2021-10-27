Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7354343D179
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 21:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbhJ0TPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 15:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240552AbhJ0TPc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:15:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EAE960EB4;
        Wed, 27 Oct 2021 19:13:04 +0000 (UTC)
Date:   Wed, 27 Oct 2021 20:13:01 +0100
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
Message-ID: <YXmkvfL9B+4mQAIo@arm.com>
References: <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com>
 <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com>
 <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com>
 <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
 <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com>
 <YXhH0sBSyTyz5Eh2@arm.com>
 <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:50:04AM -0700, Linus Torvalds wrote:
> On Tue, Oct 26, 2021 at 11:24 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > While more intrusive, I'd rather change copy_page_from_iter_atomic()
> > etc. to take a pointer where to write back an error code.
[...]
> That said, the fact that these sub-page faults are always
> non-recoverable might be a hint to a solution to the problem: maybe we
> could extend the existing return code with actual negative error
> numbers.
> 
> Because for _most_ cases of "copy_to/from_user()" and friends by far,
> the only thing we look for is "zero for success".
> 
> We could extend the "number of bytes _not_ copied" semantics to say
> "negative means fatal", and because there are fairly few places that
> actually look at non-zero values, we could have a coccinelle script
> that actually marks those places.

As you already replied, there are some odd places where the returned
uncopied of bytes is used. Also for some valid cases like
copy_mount_options(), it's likely that it will fall back to
byte-at-a-time with MTE since it's a good chance it would hit a fault in
a 4K page (not a fast path though). I'd have to go through all the cases
and check whether the return value is meaningful. The iter_iov.c
functions and their callers also seem to make use of the bytes copied in
case they need to call iov_iter_revert() (though I suppose the
iov_iter_iovec_advance() would skip the update in case of an error).

As an alternative, you mentioned earlier that a per-thread fault status
was not feasible on x86 due to races. Was this only for the hw poison
case? I think the uaccess is slightly different.

We can add a current->non_recoverable_uaccess variable cleared on
pagefault_disable(), only set by uaccess faults and checked by the fs
code before re-attempting the fault_in(). An interrupt shouldn't do a
uaccess (well, if it does a _nofault one, we can detect in_interrupt()
in the MTE exception handler). Last time I looked at io_uring it was
running in a separate kernel thread, not sure whether this was changed.
I don't see what else would be racing with such
current->non_recoverable_uaccess variable. If that's doable, I think
it's the least intrusive approach.

-- 
Catalin
