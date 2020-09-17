Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4C226D3E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 08:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgIQGpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 02:45:43 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:56699 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgIQGpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:45:42 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 463313ABB8A;
        Thu, 17 Sep 2020 16:45:34 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kInfg-0001hZ-Oc; Thu, 17 Sep 2020 16:45:32 +1000
Date:   Thu, 17 Sep 2020 16:45:32 +1000
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
Message-ID: <20200917064532.GI12131@dread.disaster.area>
References: <20200623052059.1893966-1-david@fromorbit.com>
 <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
 <20200916155851.GA1572@quack2.suse.cz>
 <20200917014454.GZ12131@dread.disaster.area>
 <alpine.LSU.2.11.2009161853220.2087@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2009161853220.2087@eggly.anvils>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=XJ9OtjpE c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=x_xy7cVlXMNUeJvnttQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 07:04:46PM -0700, Hugh Dickins wrote:
> On Thu, 17 Sep 2020, Dave Chinner wrote:
> > 
> > So....
> > 
> > P0					p1
> > 
> > hole punch starts
> >   takes XFS_MMAPLOCK_EXCL
> >   truncate_pagecache_range()
> >     unmap_mapping_range(start, end)
> >       <clears ptes>
> > 					<read fault>
> > 					do_fault_around()
> > 					  ->map_pages
> > 					    filemap_map_pages()
> > 					      page mapping valid,
> > 					      page is up to date
> > 					      maps PTEs
> > 					<fault done>
> >     truncate_inode_pages_range()
> >       truncate_cleanup_page(page)
> >         invalidates page
> >       delete_from_page_cache_batch(page)
> >         frees page
> > 					<pte now points to a freed page>
> 
> No.  filemap_map_pages() checks page->mapping after trylock_page(),
> before setting up the pte; and truncate_cleanup_page() does a one-page
> unmap_mapping_range() if page_mapped(), while holding page lock.

Ok, fair, I missed that.

So why does truncate_pagecache() talk about fault races and require
a second unmap range after the invalidation "for correctness" if
this sort of race cannot happen?

Why is that different to truncate_pagecache_range() which -doesn't-i
do that second removal? It's called for more than just hole_punch -
from the filesystem's persepective holepunch should do exactly the
same as truncate to the page cache, and for things like
COLLAPSE_RANGE it is absolutely essential because the data in that
range is -not zero- and will be stale if the mappings are not
invalidated completely....

Also, if page->mapping == NULL is sufficient to detect an invalidated
page in all cases, then why does page_cache_delete() explicitly
leave page->index intact:

	page->mapping = NULL;
	/* Leave page->index set: truncation lookup relies upon it */


Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
