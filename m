Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E49B42AAB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 19:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhJLR3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 13:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhJLR3O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 13:29:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0EB460EFE;
        Tue, 12 Oct 2021 17:27:09 +0000 (UTC)
Date:   Tue, 12 Oct 2021 18:27:06 +0100
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
Message-ID: <YWXFagjRVdNanGSy@arm.com>
References: <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk>
 <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk>
 <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
 <YWSnvq58jDsDuIik@arm.com>
 <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 04:59:28PM -0700, Linus Torvalds wrote:
> On Mon, Oct 11, 2021 at 2:08 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > +#ifdef CONFIG_ARM64_MTE
> > +#define FAULT_GRANULE_SIZE     (16)
> > +#define FAULT_GRANULE_MASK     (~(FAULT_GRANULE_SIZE-1))
> 
> [...]
> 
> > If this looks in the right direction, I'll do some proper patches
> > tomorrow.
> 
> Looks fine to me. It's going to be quite expensive and bad for caches,
> though.
> 
> That said, fault_in_writable() is _supposed_ to all be for the slow
> path when things go south and the normal path didn't work out, so I
> think it's fine.
> 
> I do wonder how the sub-page granularity works. Is it sufficient to
> just read from it?

For arm64 MTE and I think SPARC ADI, just reading should be sufficient.
There is CHERI in the long run, if it takes off, where the user can set
independent read/write permissions and uaccess would use the capability
rather than a match-all pointer (hence checked).

> Because then a _slightly_ better option might be to
> do one write per page (to catch page table writability) and then one
> read per "granule" (to catch pointer coloring or cache poisoning
> issues)?
> 
> That said, since this is all preparatory to us wanting to write to it
> eventually anyway, maybe marking it all dirty in the caches is only
> good.

It depends on how much would be written in the actual copy. For
significant memcpy on arm CPUs, write streaming usually kicks in and the
cache dirtying is skipped. This probably matters more for
copy_page_to_iter_iovec() than the btrfs search ioctl.

Apart from fault_in_pages_*(), there's also fault_in_user_writeable()
called from the futex code which uses the GUP mechanism as the write
would be destructive. It looks like it could potentially trigger the
same infinite loop on -EFAULT. For arm64 MTE, we get away with this by
disabling the tag checking around the arch futex code (we did it for an
unrelated issue - we don't have LDXR/STXR that would run with user
permissions in kernel mode like we do with LDTR/STTR).

I wonder whether we should actually just disable tag checking around the
problematic accesses. What these callers seem to have in common is using
pagefault_disable/enable(). We could abuse this to disable tag checking
or maybe in_atomic() when handling the exception to lazily disable such
faults temporarily.

A more invasive change would be to return a different error for such
faults like -EACCESS and treat them differently in the caller.

-- 
Catalin
