Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8664543B975
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhJZS0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 14:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231297AbhJZS0t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:26:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9302360F9D;
        Tue, 26 Oct 2021 18:24:21 +0000 (UTC)
Date:   Tue, 26 Oct 2021 19:24:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <YXhH0sBSyTyz5Eh2@arm.com>
References: <20211019134204.3382645-1-agruenba@redhat.com>
 <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com>
 <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com>
 <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com>
 <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
 <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 09:00:43PM +0200, Andreas Gruenbacher wrote:
> On Fri, Oct 22, 2021 at 9:23 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Fri, Oct 22, 2021 at 8:06 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > Probing only the first byte(s) in fault_in() would be ideal, no need to
> > > go through all filesystems and try to change the uaccess/probing order.
> >
> > Let's try that. Or rather: probing just the first page - since there
> > are users like that btrfs ioctl, and the direct-io path.
> 
> For direct I/O, we actually only want to trigger page fault-in so that
> we can grab page references with bio_iov_iter_get_pages. Probing for
> sub-page error domains will only slow things down. If we hit -EFAULT
> during the actual copy-in or copy-out, we know that the error can't be
> page fault related. Similarly, in the buffered I/O case, we only
> really care about the next byte, so any probing beyond that is
> unnecessary.
> 
> So maybe we should split the sub-page error domain probing off from
> the fault-in functions. Or at least add an argument to the fault-in
> functions that specifies the amount of memory to probe.

My preferred option is not to touch fault-in for sub-page faults (though
I have some draft patches, they need testing).

All this fault-in and uaccess with pagefaults_disabled() is needed to
avoid a deadlock when the uaccess fault handling would take the same
lock. With sub-page faults, the kernel cannot fix it up anyway, so the
arch code won't even attempt call handle_mm_fault() (it is not an mm
fault). But the problem is the copy_*_user() etc. API that can only
return the number of bytes not copied. That's what I think should be
fixed. fault_in() feels like the wrong place to address this when it's
not an mm fault.

As for fault_in() getting another argument with the amount of sub-page
probing to do, I think the API gets even more confusing. I was also
thinking, with your patches for fault_in() now returning size_t, is the
expectation to be precise in what cannot be copied? We don't have such
requirement for copy_*_user().

While more intrusive, I'd rather change copy_page_from_iter_atomic()
etc. to take a pointer where to write back an error code. If it's
-EFAULT, retry the loop. If it's -EACCES/EPERM just bail out. Or maybe
simply a bool set if there was an mm fault to be retried. Yet another
option to return an -EAGAIN if it could not process the mm fault due to
page faults being disabled.

Happy to give this a try, unless there's a strong preference for the
fault_in() fix-up (well, I can do both options and post them).

-- 
Catalin
