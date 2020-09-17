Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2A626D556
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 09:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgIQHz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 03:55:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:38418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgIQHys (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:54:48 -0400
X-Greylist: delayed 791 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 03:53:54 EDT
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50DC9AC92;
        Thu, 17 Sep 2020 07:40:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 647241E12E1; Thu, 17 Sep 2020 09:40:30 +0200 (CEST)
Date:   Thu, 17 Sep 2020 09:40:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
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
Message-ID: <20200917074030.GA9555@quack2.suse.cz>
References: <20200623052059.1893966-1-david@fromorbit.com>
 <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
 <20200916155851.GA1572@quack2.suse.cz>
 <20200917014454.GZ12131@dread.disaster.area>
 <df9eb392-8b86-591a-b1be-535a13b874d9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df9eb392-8b86-591a-b1be-535a13b874d9@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-09-20 08:37:17, Nikolay Borisov wrote:
> On 17.09.20 г. 4:44 ч., Dave Chinner wrote:
> > On Wed, Sep 16, 2020 at 05:58:51PM +0200, Jan Kara wrote:
> >> On Sat 12-09-20 09:19:11, Amir Goldstein wrote:
> >>> On Tue, Jun 23, 2020 at 8:21 AM Dave Chinner <david@fromorbit.com> wrote:
> 
> <snip>
> 
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
> > 
> > That doesn't seem good to me.
> > 
> > Sure, maybe the page hasn't been freed back to the free lists
> > because of elevated refcounts. But it's been released by the
> > filesystem and not longer in the page cache so nothing good can come
> > of this situation...
> > 
> > AFAICT, this race condition exists for the truncate case as well
> > as filemap_map_pages() doesn't have a "page beyond inode size" check
> > in it. 
> 
> (It's not relevant to the discussion at hand but for the sake of
> completeness):
> 
> It does have a check:
> 
>  max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
>  if (page->index >= max_idx)
>       goto unlock;

Yes, but this does something meaningful only for truncate. For other
operations such as hole punch this check doesn't bring anything. That's why
only filesystems supporting hole punching and similar advanced operations
need an equivalent of mmap_lock.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
