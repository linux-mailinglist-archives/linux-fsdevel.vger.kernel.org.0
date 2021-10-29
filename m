Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8566A43FCA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 14:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhJ2Mwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 08:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231367AbhJ2Mwl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:52:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAE10611CC;
        Fri, 29 Oct 2021 12:50:09 +0000 (UTC)
Date:   Fri, 29 Oct 2021 13:50:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
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
Message-ID: <YXvt/mNABVv6a5nO@arm.com>
References: <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com>
 <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
 <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com>
 <YXhH0sBSyTyz5Eh2@arm.com>
 <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
 <YXmkvfL9B+4mQAIo@arm.com>
 <CAHk-=wjQqi9cw1Guz6a8oBB0xiQNF_jtFzs3gW0k7+fKN-mB1g@mail.gmail.com>
 <YXsUNMWFpmT1eQcX@arm.com>
 <CAHpGcMLeiXSjCJGY6SCJJ=bdNOspHLHofmTE8aC_sZtfHRG5ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMLeiXSjCJGY6SCJJ=bdNOspHLHofmTE8aC_sZtfHRG5ZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 12:15:55AM +0200, Andreas Grünbacher wrote:
> Am Do., 28. Okt. 2021 um 23:21 Uhr schrieb Catalin Marinas
> <catalin.marinas@arm.com>:
> > I think for nested contexts we can save the uaccess fault state on
> > exception entry, restore it on return. Or (needs some thinking on
> > atomicity) save it in a local variable. The high-level API would look
> > something like:
> >
> >         unsigned long uaccess_flags;    /* we could use TIF_ flags */
> >
> >         uaccess_flags = begin_retriable_uaccess();
> >         copied = copy_page_from_iter_atomic(...);
> >         retry = end_retriable_uaccess(uaccess_flags);
> >         ...
> >
> >         if (!retry)
> >                 break;
> >
> > I think we'd need a TIF flag to mark the retriable region and another to
> > track whether a non-recoverable fault occurred. It needs prototyping.
> >
> > Anyway, if you don't like this approach, I'll look at error codes being
> > returned but rather than changing all copy_from_user() etc., introduce a
> > new API that returns different error codes depending on the fault
> > (e.g -EFAULT vs -EACCES). We already have copy_from_user_nofault(), we'd
> > need something for the iov_iter stuff to use in the fs code.
> 
> We won't need any of that on the filesystem read and write paths. The
> two cases there are buffered and direct I/O:

Thanks for the clarification, very useful.

> * In the buffered I/O case, the copying happens with page faults
> disabled, at a byte granularity. If that returns a short result, we
> need to enable page faults, check if the exact address that failed
> still fails (in which case we have a sub-page fault),  fault in the
> pages, disable page faults again, and repeat. No probing for sub-page
> faults beyond the first byte of the fault-in address is needed.
> Functions fault_in_{readable,writeable} implicitly have this behavior;
> for fault_in_safe_writeable() the choice we have is to either add
> probing of the first byte for sub-page faults to this function or
> force callers to do that probing separately. At this point, I'd vote
> for the former.

This sounds fine to me (and I have some draft patches already on top of
your series).

> * In the direct I/O case, the copying happens while we're holding page
> references, so the only page faults that can occur during copying are
> sub-page faults.

Does holding a page reference guarantee that the user pte pointing to
such page won't change, for example a pte_mkold()? I assume for direct
I/O, the PG_locked is not held. But see below, it may not be relevant.

> When iomap_dio_rw or its legacy counterpart is called
> with page faults disabled, we need to make sure that the caller can
> distinguish between page faults triggered during
> bio_iov_iter_get_pages() and during the copying, but that's a separate
> problem. (At the moment, when iomap_dio_rw fails with -EFAULT, the
> caller *cannot* distinguish between a bio_iov_iter_get_pages failure
> and a failure during synchronous copying, but that could be fixed by
> returning unique error codes from iomap_dio_rw.)

Since the direct I/O pins the pages in memory, does it even need to do a
uaccess? It could copy the data via the kernel mapping (kmap). For arm64
MTE, all such accesses are not checked (they use a match-all pointer
tag) since the kernel is not set up to handle such sub-page faults (no
copy_from/to_user but a direct access).

> So as far as I can see, the only problematic case we're left with is
> copying bigger than byte-size chunks with page faults disabled when we
> don't know whether the underlying pages are resident or not. My guess
> would be that in this case, if the copying fails, it would be
> perfectly acceptable to explicitly probe the entire chunk for sub-page
> faults.

Yeah, if there are only a couple of places left, we can add the explicit
probing (via some probe_user_writable function).

-- 
Catalin
