Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB8926D171
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 05:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIQDIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 23:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIQDIL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 23:08:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3599EC061354;
        Wed, 16 Sep 2020 20:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uMnEgq9vaCRYsRSBlvAbbXAo3XKw/rA3rHucz8CqYPs=; b=tsk5XKZMdogbEKddhS+kYKFpSD
        tILj0/PIxWt27O5LKM5LnkW0dVmd2e+wSOuIwwD/69G1QTC0K9EZq/JtTGUiu5IJQdbq8E5/9vX/5
        Z4nAYPlyd3jGV/ixISlEA7eQg04hLVeQo8y8AyhP2/sQczxD/DKca/SQK0h1Xz+cidtDCb3TKeHWI
        NcAVLTA5afy+MX63+apM1DVpm5l3NmZAKe8s8l+9gymmzr2KzdJ5+DL8szLk64FlPa77tf4peRqyT
        mFvJ+NQZGfSNvdy7S+pd84wgCtbEXDVhZpnujB3NB666Vc8G8mRJzth09++ywm/yC2Qk8joI2zn7U
        G9IawJkw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIkAY-0006Co-3p; Thu, 17 Sep 2020 03:01:10 +0000
Date:   Thu, 17 Sep 2020 04:01:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, nborisov@suse.de
Subject: Re: More filesystem need this fix (xfs: use MMAPLOCK around
 filemap_map_pages())
Message-ID: <20200917030110.GP5449@casper.infradead.org>
References: <20200623052059.1893966-1-david@fromorbit.com>
 <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
 <20200916155851.GA1572@quack2.suse.cz>
 <20200917014454.GZ12131@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917014454.GZ12131@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:44:54AM +1000, Dave Chinner wrote:
> So....
> 
> P0					p1
> 
> hole punch starts
>   takes XFS_MMAPLOCK_EXCL
>   truncate_pagecache_range()

... locks page ...

>     unmap_mapping_range(start, end)
>       <clears ptes>
> 					<read fault>
> 					do_fault_around()
> 					  ->map_pages
> 					    filemap_map_pages()

... trylock page fails ...

> 					      page mapping valid,
> 					      page is up to date
> 					      maps PTEs
> 					<fault done>
>     truncate_inode_pages_range()
>       truncate_cleanup_page(page)
>         invalidates page
>       delete_from_page_cache_batch(page)
>         frees page
> 					<pte now points to a freed page>
> 
> That doesn't seem good to me.
> 
> Sure, maybe the page hasn't been freed back to the free lists
> because of elevated refcounts. But it's been released by the
> filesystem and not longer in the page cache so nothing good can come
> of this situation...
> 
> AFAICT, this race condition exists for the truncate case as well
> as filemap_map_pages() doesn't have a "page beyond inode size" check
> in it. However, exposure here is very limited in the truncate case
> because truncate_setsize()->truncate_pagecache() zaps the PTEs
> again after invalidating the page cache.
> 
> Either way, adding the XFS_MMAPLOCK_SHARED around
> filemap_map_pages() avoids the race condition for fallocate and
> truncate operations for XFS...
> 
> > As such it is a rather
> > different beast compared to the fault handler from fs POV and does not need
> > protection from hole punching (current serialization on page lock and
> > checking of page->mapping is enough).
> > That being said I agree this is subtle and the moment someone adds e.g. a
> > readahead call into filemap_map_pages() we have a real problem. I'm not
> > sure how to prevent this risk...
> 
> Subtle, yes. So subtle, in fact, I fail to see any reason why the
> above race cannot occur as there's no obvious serialisation in the
> page cache between PTE zapping and page invalidation to prevent a
> fault from coming in an re-establishing the PTEs before invalidation
> occurs.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
