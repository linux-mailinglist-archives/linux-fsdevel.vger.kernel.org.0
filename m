Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CD6435608
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 00:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhJTWqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 18:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhJTWqf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 18:46:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CBE26115B;
        Wed, 20 Oct 2021 22:44:18 +0000 (UTC)
Date:   Wed, 20 Oct 2021 23:44:15 +0100
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
Message-ID: <YXCbv5gdfEEtAYo8@arm.com>
References: <20211019134204.3382645-1-agruenba@redhat.com>
 <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com>
 <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 10:11:19AM -1000, Linus Torvalds wrote:
> On Wed, Oct 20, 2021 at 6:37 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > The atomic "add zero" trick isn't that simple for MTE since the arm64
> > atomic or exclusive instructions run with kernel privileges and
> > therefore with the kernel tag checking mode.
> 
> Are there any instructions that are useful for "probe_user_write()"
> kind of thing?

If it's on a user address, the only single-instruction that works with
MTE is STTR (as in put_user()) but that's destructive. Other "add zero"
constructs require some potentially expensive system register accesses
just to set the tag checking mode of the current task.

A probe_user_write() on the kernel linear address involves reading the
tag from memory and comparing it with the tag in the user pointer. In
addition, it needs to take into account the current task's tag checking
mode and the vma vm_flags. We should have most of the information in the
gup code.

> Although at least for MTE, I think the solution was to do a regular
> read, and that checks the tag, and then we could use the gup machinery
> for the writability checks.

Yes, for MTE this should work. For CHERI I think an "add zero" would
do the trick (it should have atomics that work on capabilities
directly). However, with MTE doing both get_user() every 16 bytes and
gup can get pretty expensive. The problematic code is
fault_in_safe_writable() in this series.

I can give this 16-byte probing in gup a try (on top of -next) but IMHO
we unnecessarily overload the fault_in_*() logic with something the
kernel cannot fix up. The only reason we do it is so that we get an
error code and bail out of a loop but the uaccess routines could be
extended to report the fault type instead. It looks like we pretty much
duplicate the uaccess in the fault_in_*() functions (four accesses per
cache line).

-- 
Catalin
