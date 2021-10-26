Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632B743AB97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 07:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhJZFQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 01:16:12 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54457 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234445AbhJZFQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 01:16:10 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19Q5Crw3021006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:12:54 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C967515C3F84; Tue, 26 Oct 2021 01:12:53 -0400 (EDT)
Date:   Tue, 26 Oct 2021 01:12:53 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <YXeOVZqer+GFBkXO@mit.edu>
References: <20211019134204.3382645-1-agruenba@redhat.com>
 <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com>
 <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com>
 <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com>
 <CAHc6FU6JC4ZOwA8t854WbNdmuiNL9DPq0FPga8guATaoCtvsaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU6JC4ZOwA8t854WbNdmuiNL9DPq0FPga8guATaoCtvsaw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 08:24:26PM +0200, Andreas Gruenbacher wrote:
> > For generic_perform_write() Dave Hansen attempted to move the fault-in
> > after the uaccess in commit 998ef75ddb57 ("fs: do not prefault
> > sys_write() user buffer pages"). This was reverted as it was exposing an
> > ext4 bug. I don't [know] whether it was fixed but re-applying Dave's commit
> > avoids the performance drop.
> 
> Interesting. The revert of commit 998ef75ddb57 is in commit
> 00a3d660cbac. Maybe Dave and Ted can tell us more about what went
> wrong in ext4 and whether it's still an issue.

The context for the revert can be found here[1].

[1] https://lore.kernel.org/lkml/20151005152236.GA8140@thunk.org/

And "what went wrong in ext4" was fixed here[2].

[2] https://lore.kernel.org/lkml/20151005152236.GA8140@thunk.org/

which landed upstream as commit b90197b65518 ("ext4: use private
version of page_zero_new_buffers() for data=journal mode").

So it looks like the original issue which triggered the revert in 2015
should be addressed, and we can easily test it by using generic/208
with data=journal mode.

There also seems to be a related discussion about whether we should
unrevert 998ef75ddb57 here[3].  Hmm. there is a mention on that thread
in [3], "Side note: search for "iov_iter_fault_in_writeable()" on lkml
for a gfs2 patch-series that is buggy, exactly because it does *not*
use the atomic user space accesses, and just tries to do the fault-in
to hide the real bug."  I assume that's related to the discussion on
this thread?

[3] https://lore.kernel.org/all/3221175.1624375240@warthog.procyon.org.uk/T/#u

						- Ted
