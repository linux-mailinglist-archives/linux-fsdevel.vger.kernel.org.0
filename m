Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0F8221A7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 05:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgGPDD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 23:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbgGPDD7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:03:59 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A75D2076C;
        Thu, 16 Jul 2020 03:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594868638;
        bh=v3Bqa4cOJJvz9YfwAqdgDudvEV9FyMcI2b5gw82oJMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAls4WTWjsI5YbeQ94NmG1Ky2Dcn/OjsqhjAMI+0sxn0L0tOx7DwjQkLX+SPJF14B
         CLn8vyq0lzGY3pr/8nApMvH3xFH2bk3Wwg3lkrmSvhto3HVxVHgy3MEPm2uq+RG3HL
         AcNIGbr/Fg6EYDdnV6u+gUNyMHKM2USKEGXc4WuY=
Date:   Wed, 15 Jul 2020 20:03:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: KCSAN: data-race in generic_file_buffered_read /
 generic_file_buffered_read
Message-ID: <20200716030357.GE1167@sol.localdomain>
References: <0000000000004a4d6505aa7c688a@google.com>
 <20200715152912.GA2209203@elver.google.com>
 <20200715163256.GB1167@sol.localdomain>
 <20200715234203.GK5369@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715234203.GK5369@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 09:42:03AM +1000, Dave Chinner wrote:
> On Wed, Jul 15, 2020 at 09:32:56AM -0700, Eric Biggers wrote:
> > [+Cc linux-fsdevel]
> > 
> > On Wed, Jul 15, 2020 at 05:29:12PM +0200, 'Marco Elver' via syzkaller-bugs wrote:
> > > On Wed, Jul 15, 2020 at 08:16AM -0700, syzbot wrote:
> > > > Hello,
> > > > 
> > > > syzbot found the following issue on:
> > > > 
> > > > HEAD commit:    e9919e11 Merge branch 'for-linus' of git://git.kernel.org/..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1217a83b100000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=570eb530a65cd98e
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0f1e470df6a4316e0a11
> > > > compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
> > > > 
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > 
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com
> > > > 
> > > > ==================================================================
> > > > BUG: KCSAN: data-race in generic_file_buffered_read / generic_file_buffered_read
> > > 
> > > Our guess is that this is either misuse of an API from userspace, or a
> > > bug. Can someone clarify?
> > > 
> > > Below are the snippets of code around these accesses.
> > 
> > Concurrent reads on the same file descriptor are allowed.  Not with sys_read(),
> > as that implicitly uses the file position.  But it's allowed with sys_pread(),
> > and also with sys_sendfile() which is the case syzbot is reporting here.
> 
> Concurrent read()s are fine, they'll just read from the same offset.
> 

Actually the VFS serializes concurrent read()'s on the same fd, at least for
regular files.  Anyway, doesn't matter since we can consider pread() instead.

> 
> > 
> > > 
> > > > write to 0xffff8880968747b0 of 8 bytes by task 6336 on cpu 0:
> > > >  generic_file_buffered_read+0x18be/0x19e0 mm/filemap.c:2246
> > > 
> > > 	...
> > > 	would_block:
> > > 		error = -EAGAIN;
> > > 	out:
> > > 		ra->prev_pos = prev_index;
> > > 		ra->prev_pos <<= PAGE_SHIFT;
> > > 2246)		ra->prev_pos |= prev_offset;
> > > 
> > > 		*ppos = ((loff_t)index << PAGE_SHIFT) + offset;
> > > 		file_accessed(filp);
> > > 		return written ? written : error;
> > > 	}
> > > 	EXPORT_SYMBOL_GPL(generic_file_buffered_read);
> > > 	...
> > 
> > Well, it's a data race.  Each open file descriptor has just one readahead state
> > (struct file_ra_state), and concurrent reads of the same file descriptor
> > use/change that readahead state without any locking.
> > 
> > Presumably this has traditionally been considered okay, since readahead is
> > "only" for performance and doesn't affect correctness.  And for performance
> > reasons, we want to avoid locking during file reads.
> > 
> > So we may just need to annotate all access to file_ra_state with
> > READ_ONCE() and WRITE_ONCE()...
> 
> Please, no. Can we stop making the code hard to read, more difficult
> to maintain and preventing the compiler from optimising it by doing
> stupid "turn off naive static checker warnings" stuff like this?
> 
> If the code is fine with races, then -leave it alone-. If it's not
> fine with a data race, then please go and work out the correct
> ordering and place well documented barriers and/or release/acquire
> ordering semantics in the code so that we do not need to hide data
> races behind a compiler optimisation defeating macro....
> 
> Yes, I know data_race() exists to tell the tooling that it should
> ignore data races in the expression, but that makes just as much
> mess of the code as READ_ONCE/WRITE_ONCE being spewed everywhere
> indiscriminately because <some tool said we need to do that>.
> 

Data races are undefined behavior, so it's never guaranteed "fine".  We can only
attempt to conclude that it's fine "in practice" and is too difficult to fix,
and therefore doesn't meet the bar to be fixed (for now).

Of course, in most cases the preferred solution for data races is to introduce
proper synchronization.  As I said, I'm not sure that's feasible here.  Memory
barriers aren't the issue here; we'd need *locking*, which would mean concurrent
readers would start contending for the lock.  Other suggestions appreciated...

- Eric
