Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A41221890
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 01:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgGOXmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 19:42:10 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:35404 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbgGOXmJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:42:09 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 30842D7C575;
        Thu, 16 Jul 2020 09:42:04 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jvr2J-0001Fq-DD; Thu, 16 Jul 2020 09:42:03 +1000
Date:   Thu, 16 Jul 2020 09:42:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: KCSAN: data-race in generic_file_buffered_read /
 generic_file_buffered_read
Message-ID: <20200715234203.GK5369@dread.disaster.area>
References: <0000000000004a4d6505aa7c688a@google.com>
 <20200715152912.GA2209203@elver.google.com>
 <20200715163256.GB1167@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715163256.GB1167@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8
        a=eU0e3LhYAAAA:20 a=hSkVLCK3AAAA:8 a=7-415B0cAAAA:8
        a=ZUY0gg6SJnirf6z4UTcA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
        a=biEYGPWJfzWAr4FL6Ov7:22 a=pHzHmUro8NiASowvMSCR:22
        a=nt3jZW36AmriUCFCBwmW:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 09:32:56AM -0700, Eric Biggers wrote:
> [+Cc linux-fsdevel]
> 
> On Wed, Jul 15, 2020 at 05:29:12PM +0200, 'Marco Elver' via syzkaller-bugs wrote:
> > On Wed, Jul 15, 2020 at 08:16AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    e9919e11 Merge branch 'for-linus' of git://git.kernel.org/..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1217a83b100000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=570eb530a65cd98e
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0f1e470df6a4316e0a11
> > > compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com
> > > 
> > > ==================================================================
> > > BUG: KCSAN: data-race in generic_file_buffered_read / generic_file_buffered_read
> > 
> > Our guess is that this is either misuse of an API from userspace, or a
> > bug. Can someone clarify?
> > 
> > Below are the snippets of code around these accesses.
> 
> Concurrent reads on the same file descriptor are allowed.  Not with sys_read(),
> as that implicitly uses the file position.  But it's allowed with sys_pread(),
> and also with sys_sendfile() which is the case syzbot is reporting here.

Concurrent read()s are fine, they'll just read from the same offset.


> 
> > 
> > > write to 0xffff8880968747b0 of 8 bytes by task 6336 on cpu 0:
> > >  generic_file_buffered_read+0x18be/0x19e0 mm/filemap.c:2246
> > 
> > 	...
> > 	would_block:
> > 		error = -EAGAIN;
> > 	out:
> > 		ra->prev_pos = prev_index;
> > 		ra->prev_pos <<= PAGE_SHIFT;
> > 2246)		ra->prev_pos |= prev_offset;
> > 
> > 		*ppos = ((loff_t)index << PAGE_SHIFT) + offset;
> > 		file_accessed(filp);
> > 		return written ? written : error;
> > 	}
> > 	EXPORT_SYMBOL_GPL(generic_file_buffered_read);
> > 	...
> 
> Well, it's a data race.  Each open file descriptor has just one readahead state
> (struct file_ra_state), and concurrent reads of the same file descriptor
> use/change that readahead state without any locking.
> 
> Presumably this has traditionally been considered okay, since readahead is
> "only" for performance and doesn't affect correctness.  And for performance
> reasons, we want to avoid locking during file reads.
> 
> So we may just need to annotate all access to file_ra_state with
> READ_ONCE() and WRITE_ONCE()...

Please, no. Can we stop making the code hard to read, more difficult
to maintain and preventing the compiler from optimising it by doing
stupid "turn off naive static checker warnings" stuff like this?

If the code is fine with races, then -leave it alone-. If it's not
fine with a data race, then please go and work out the correct
ordering and place well documented barriers and/or release/acquire
ordering semantics in the code so that we do not need to hide data
races behind a compiler optimisation defeating macro....

Yes, I know data_race() exists to tell the tooling that it should
ignore data races in the expression, but that makes just as much
mess of the code as READ_ONCE/WRITE_ONCE being spewed everywhere
indiscriminately because <some tool said we need to do that>.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
