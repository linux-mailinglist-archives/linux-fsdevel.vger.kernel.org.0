Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C1E60E26
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 01:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfGEXdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 19:33:12 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:48665 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbfGEXdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 19:33:12 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 98FE814A6E7;
        Sat,  6 Jul 2019 09:33:05 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hjXgL-0005yO-Jj; Sat, 06 Jul 2019 09:31:57 +1000
Date:   Sat, 6 Jul 2019 09:31:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Boaz Harrosh <openosd@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: pagecache locking
Message-ID: <20190705233157.GD7689@dread.disaster.area>
References: <20190613183625.GA28171@kmo-pixel>
 <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
 <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
 <20190617224714.GR14363@dread.disaster.area>
 <CAHk-=wiR3a7+b0cUN45hGp1dvFh=s1i1OkVhoP7CivJxKqsLFQ@mail.gmail.com>
 <CAOQ4uxjqQjrCCt=ixgdUYjBJvKLhw4R9NeMZOB_s2rrWvoDMBw@mail.gmail.com>
 <20190619103838.GB32409@quack2.suse.cz>
 <20190619223756.GC26375@dread.disaster.area>
 <3f394239-f532-23eb-9ff1-465f7d1f3cb4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f394239-f532-23eb-9ff1-465f7d1f3cb4@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=7-415B0cAAAA:8 a=VP1V1_vrrUTVS67bY_cA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 03, 2019 at 03:04:45AM +0300, Boaz Harrosh wrote:
> On 20/06/2019 01:37, Dave Chinner wrote:
> <>
> > 
> > I'd prefer it doesn't get lifted to the VFS because I'm planning on
> > getting rid of it in XFS with range locks. i.e. the XFS_MMAPLOCK is
> > likely to go away in the near term because a range lock can be
> > taken on either side of the mmap_sem in the page fault path.
> > 
> <>
> Sir Dave
> 
> Sorry if this was answered before. I am please very curious. In the zufs
> project I have an equivalent rw_MMAPLOCK that I _read_lock on page_faults.
> (Read & writes all take read-locks ...)
> The only reason I have it is because of lockdep actually.
> 
> Specifically for those xfstests that mmap a buffer then direct_IO in/out
> of that buffer from/to another file in the same FS or the same file.
> (For lockdep its the same case).

Which can deadlock if the same inode rwsem is taken on both sides of
the mmap_sem, as lockdep tells you...

> I would be perfectly happy to recursively _read_lock both from the top
> of the page_fault at the DIO path, and under in the page_fault. I'm
> _read_locking after all. But lockdep is hard to convince. So I stole the
> xfs idea of having an rw_MMAPLOCK. And grab yet another _write_lock at
> truncate/punch/clone time when all mapping traversal needs to stop for
> the destructive change to take place. (Allocations are done another way
> and are race safe with traversal)
> 
> How do you intend to address this problem with range-locks? ie recursively
> taking the same "lock"? because if not for the recursive-ity and lockdep I would
> not need the extra lock-object per inode.

As long as the IO ranges to the same file *don't overlap*, it should
be perfectly safe to take separate range locks (in read or write
mode) on either side of the mmap_sem as non-overlapping range locks
can be nested and will not self-deadlock.

The "recursive lock problem" still arises with DIO and page faults
inside gup, but it only occurs when the user buffer range overlaps
the DIO range to the same file. IOWs, the application is trying to
do something that has an undefined result and is likely to result in
data corruption. So, in that case I plan to have the gup page faults
fail and the DIO return -EDEADLOCK to userspace....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
