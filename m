Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52ED43504C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhJTQjT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 12:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhJTQjR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:39:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0616061374;
        Wed, 20 Oct 2021 16:36:59 +0000 (UTC)
Date:   Wed, 20 Oct 2021 17:36:56 +0100
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
Message-ID: <YXBFqD9WVuU8awIv@arm.com>
References: <20211019134204.3382645-1-agruenba@redhat.com>
 <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 05:40:13AM -1000, Linus Torvalds wrote:
> On Tue, Oct 19, 2021 at 3:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >  * Will Catalin Marinas's work for supporting arm64 sub-page faults
> >    be queued behind these patches?  We have an overlap in
> >    fault_in_[pages_]readable fault_in_[pages_]writeable, so one of
> >    the two patch queues will need some adjustments.
> 
> I think that on the whole they should be developed separately, I don't
> think it's going to be a particularly difficult conflict.
> 
> That whole discussion does mean that I suspect that we'll have to
> change fault_in_iov_iter_writeable() to do the "every 16 bytes" or
> whatever thing, and make it use an actual atomic "add zero" or
> whatever rather than walk the page tables. But that's a conceptually
> separate discussion from this one, I wouldn't actually want to mix up
> the two issues too much.

I agree we shouldn't mix the two at the moment. The MTE fix requires
some more thinking and it's not 5.16 material yet.

The atomic "add zero" trick isn't that simple for MTE since the arm64
atomic or exclusive instructions run with kernel privileges and
therefore with the kernel tag checking mode. We could toggle the mode to
match user's just for those atomic ops but it will make this probing
even more expensive (though normally it's done on the slow path).

The quick/backportable fix for MTE is probably to just disable tag
checking on user addresses during pagefault_disabled(). As I mentioned
in the other thread, a more elaborate fix I think is to change the
uaccess routines to update an error code somewhere in a similar way to
the arm64 __put_user_error(). But that would require changing lots of
callers.

-- 
Catalin
