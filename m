Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70054271DE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 10:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgIUI0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 04:26:13 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41029 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726318AbgIUI0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:26:13 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3400982635B;
        Mon, 21 Sep 2020 18:26:01 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kKH96-0006yw-7S; Mon, 21 Sep 2020 18:26:00 +1000
Date:   Mon, 21 Sep 2020 18:26:00 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Theodore Tso <tytso@mit.edu>,
        Martin Brandenburg <martin@omnibond.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, nborisov@suse.de
Subject: Re: More filesystem need this fix (xfs: use MMAPLOCK around
 filemap_map_pages())
Message-ID: <20200921082600.GO12131@dread.disaster.area>
References: <20200623052059.1893966-1-david@fromorbit.com>
 <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
 <20200916155851.GA1572@quack2.suse.cz>
 <20200917014454.GZ12131@dread.disaster.area>
 <alpine.LSU.2.11.2009161853220.2087@eggly.anvils>
 <20200917064532.GI12131@dread.disaster.area>
 <alpine.LSU.2.11.2009170017590.8077@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2009170017590.8077@eggly.anvils>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=esqhMbhX c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=Rl2tvrQ78qD9MlTf7ZcA:9 a=0JP9OAGvzaOLfl4_:21 a=MdB2K0HZLmbF2jdA:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:47:10AM -0700, Hugh Dickins wrote:
> On Thu, 17 Sep 2020, Dave Chinner wrote:
> > On Wed, Sep 16, 2020 at 07:04:46PM -0700, Hugh Dickins wrote:
> > > On Thu, 17 Sep 2020, Dave Chinner wrote:
> > > > 					<pte now points to a freed page>
> > > 
> > > No.  filemap_map_pages() checks page->mapping after trylock_page(),
> > > before setting up the pte; and truncate_cleanup_page() does a one-page
> > > unmap_mapping_range() if page_mapped(), while holding page lock.
> > 
> > Ok, fair, I missed that.
> > 
> > So why does truncate_pagecache() talk about fault races and require
> > a second unmap range after the invalidation "for correctness" if
> > this sort of race cannot happen?
> 
> I thought the comment
> 	 * unmap_mapping_range is called twice, first simply for
> 	 * efficiency so that truncate_inode_pages does fewer
> 	 * single-page unmaps.  However after this first call, and
> 	 * before truncate_inode_pages finishes, it is possible for
> 	 * private pages to be COWed, which remain after
> 	 * truncate_inode_pages finishes, hence the second
> 	 * unmap_mapping_range call must be made for correctness.
> explains it fairly well.

Not to me. It explains what the code is doing, and the why is simply
"correctness".

I have no idea what "correctness" actually means in this context
because there is no reference to what correct behaviour should be.
Nor do I have any idea why COW faults might behave differently to a
normal read/write page fault...

> It's because POSIX demanded that when a file
> is truncated, the user will get SIGBUS on trying to access even the
> COWed pages beyond EOF in a MAP_PRIVATE mapping.  Page lock on the
> cache page does not serialize the pages COWed from it very well.

And there's the "why". I don't find the "page lock doesn't
serialise COW faults very well" particularly reassuring in this
case....

> But there's no such SIGBUS requirement in the case of hole-punching,
> and trying to unmap those pages racily instantiated just after the
> punching cursor passed, would probably do more harm than good.

There isn't a SIGBUS requirement for fallocate operations, just a
"don't expose stale data to userspace" requirement.

FWIW, how does a COW fault even work with file backed pages? We can
only have a single page attached to the inode address space for a given
offset, so if there's been a COW fault and a new page faulted in for
the write fault in that VMA, doesn't that imply the user data then
written to that page is never going to be written back to storage
because the COW page is not tracked by the inode address space?

> > Why is that different to truncate_pagecache_range() which -doesn't-i
> > do that second removal? It's called for more than just hole_punch -
> > from the filesystem's persepective holepunch should do exactly the
> > same as truncate to the page cache, and for things like
> > COLLAPSE_RANGE it is absolutely essential because the data in that
> > range is -not zero- and will be stale if the mappings are not
> > invalidated completely....
> 
> I can't speak to COLLAPSE_RANGE.

It moves data around, doesn't replace data with zeros. Hence the
contents of any page that isn't invalidated entirely by
truncate_pagecache_range() is now entirely incorrect...

> > Also, if page->mapping == NULL is sufficient to detect an invalidated
> > page in all cases, then why does page_cache_delete() explicitly
> > leave page->index intact:
> > 
> > 	page->mapping = NULL;
> > 	/* Leave page->index set: truncation lookup relies upon it */
> 
> Because there was, and I think still is (but might it now be xarrayed
> away?), code (mainly in mm/truncate.c) which finds it convenient to
> check page->index for end of range, without necessitating the overhead
> of getting page lock.  I've no doubt it's an (minor) optimization that
> could be discarded if there were ever a need to invalidate page->index
> when deleting; but nobody has required that yet.

And that's exactly my concern w.r.t. fallocate based invalidation:
checking the page is beyond EOF without locking the page or checking
the mapping does not detect pages invalidated by hole punching and
other fallocate() operations because page->index on the invalidated
pages is never beyond EOF....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
