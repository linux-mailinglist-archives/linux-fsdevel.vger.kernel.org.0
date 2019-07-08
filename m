Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2AD961F92
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 15:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfGHNbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 09:31:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:33506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728124AbfGHNbT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:31:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04C9FAFF5;
        Mon,  8 Jul 2019 13:31:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 39BF51E159B; Mon,  8 Jul 2019 15:31:14 +0200 (CEST)
Date:   Mon, 8 Jul 2019 15:31:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Boaz Harrosh <openosd@gmail.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
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
Message-ID: <20190708133114.GC20507@quack2.suse.cz>
References: <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
 <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
 <20190617224714.GR14363@dread.disaster.area>
 <CAHk-=wiR3a7+b0cUN45hGp1dvFh=s1i1OkVhoP7CivJxKqsLFQ@mail.gmail.com>
 <CAOQ4uxjqQjrCCt=ixgdUYjBJvKLhw4R9NeMZOB_s2rrWvoDMBw@mail.gmail.com>
 <20190619103838.GB32409@quack2.suse.cz>
 <20190619223756.GC26375@dread.disaster.area>
 <3f394239-f532-23eb-9ff1-465f7d1f3cb4@gmail.com>
 <20190705233157.GD7689@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705233157.GD7689@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 06-07-19 09:31:57, Dave Chinner wrote:
> On Wed, Jul 03, 2019 at 03:04:45AM +0300, Boaz Harrosh wrote:
> > On 20/06/2019 01:37, Dave Chinner wrote:
> > <>
> > > 
> > > I'd prefer it doesn't get lifted to the VFS because I'm planning on
> > > getting rid of it in XFS with range locks. i.e. the XFS_MMAPLOCK is
> > > likely to go away in the near term because a range lock can be
> > > taken on either side of the mmap_sem in the page fault path.
> > > 
> > <>
> > Sir Dave
> > 
> > Sorry if this was answered before. I am please very curious. In the zufs
> > project I have an equivalent rw_MMAPLOCK that I _read_lock on page_faults.
> > (Read & writes all take read-locks ...)
> > The only reason I have it is because of lockdep actually.
> > 
> > Specifically for those xfstests that mmap a buffer then direct_IO in/out
> > of that buffer from/to another file in the same FS or the same file.
> > (For lockdep its the same case).
> 
> Which can deadlock if the same inode rwsem is taken on both sides of
> the mmap_sem, as lockdep tells you...
> 
> > I would be perfectly happy to recursively _read_lock both from the top
> > of the page_fault at the DIO path, and under in the page_fault. I'm
> > _read_locking after all. But lockdep is hard to convince. So I stole the
> > xfs idea of having an rw_MMAPLOCK. And grab yet another _write_lock at
> > truncate/punch/clone time when all mapping traversal needs to stop for
> > the destructive change to take place. (Allocations are done another way
> > and are race safe with traversal)
> > 
> > How do you intend to address this problem with range-locks? ie recursively
> > taking the same "lock"? because if not for the recursive-ity and lockdep I would
> > not need the extra lock-object per inode.
> 
> As long as the IO ranges to the same file *don't overlap*, it should
> be perfectly safe to take separate range locks (in read or write
> mode) on either side of the mmap_sem as non-overlapping range locks
> can be nested and will not self-deadlock.

I'd be really careful with nesting range locks. You can have nasty
situations like:

Thread 1		Thread 2
read_lock(0,1000)	
			write_lock(500,1500) -> blocks due to read lock
read_lock(1001,1500) -> blocks due to write lock (or you have to break
  fairness and then deal with starvation issues).

So once you allow nesting of range locks, you have to very carefully define
what is and what is not allowed. That's why in my range lock implementation
ages back I've decided to treat range lock as a rwsem for deadlock
verification purposes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
