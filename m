Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6726337FE58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 21:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhEMTkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 15:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhEMTkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 15:40:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3085C061574;
        Thu, 13 May 2021 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O8VUCTzxVSvxa3wVLPh12tovGUEtpcQQ1uxw15XLCZg=; b=S6oimQ+wSggkHbM04qw7qRcCif
        KxJ6s1XOGzoOpDq2Ik3+iRiwQfDzyBbe0DuWvzC9OR6jXy0kTrw+5iOA+LaoPKGquDRsAkhwtB1fn
        RAzftQHw1WIHsSHGyasEKCqK6uNc5md/QTdqO/gAX92LY/xjc3aThySb167Hsk1QbFODw0SI99hZD
        FJ7grq8hsbbFuQNaq3roe74z070sMG/wQF5s2VcKbYsspDgU3/f5jnSJCnX9ybUtPMZoBzeRLnZAR
        rt44B26yeOFUgC3PP1bOEdl/6GZRpu188I1tXE0mY9mkIB2XhLxPk/VtnEIL19/rPQgwFkGk1TQkJ
        GlbkDIiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lhHAV-009iZc-F6; Thu, 13 May 2021 19:39:06 +0000
Date:   Thu, 13 May 2021 20:38:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>
Subject: Re: [PATCH 03/11] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <YJ2AR0IURFzz+52G@casper.infradead.org>
References: <20210512101639.22278-1-jack@suse.cz>
 <20210512134631.4053-3-jack@suse.cz>
 <YJvo1bGG1tG+gtgC@casper.infradead.org>
 <20210513190114.GJ2734@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513190114.GJ2734@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 13, 2021 at 09:01:14PM +0200, Jan Kara wrote:
> On Wed 12-05-21 15:40:21, Matthew Wilcox wrote:
> > Remind me (or, rather, add to the documentation) why we have to hold the
> > invalidate_lock during the call to readpage / readahead, and we don't just
> > hold it around the call to add_to_page_cache / add_to_page_cache_locked
> > / add_to_page_cache_lru ?  I appreciate that ->readpages is still going
> > to suck, but we're down to just three implementations of ->readpages now
> > (9p, cifs & nfs).
> 
> There's a comment in filemap_create_page() trying to explain this. We need
> to protect against cases like: Filesystem with 1k blocksize, file F has
> page at index 0 with uptodate buffer at 0-1k, rest not uptodate. All blocks
> underlying page are allocated. Now let read at offset 1k race with hole
> punch at offset 1k, length 1k.
> 
> read()					hole punch
> ...
>   filemap_read()
>     filemap_get_pages()
>       - page found in the page cache but !Uptodate
>       filemap_update_page()
> 					  locks everything
> 					  truncate_inode_pages_range()
> 					    lock_page(page)
> 					    do_invalidatepage()
> 					    unlock_page(page)
>         locks page
>           filemap_read_page()

Ah, this is the partial_start case, which means that page->mapping
is still valid.  But that means that do_invalidatepage() was called
with (offset 1024, length 1024), immediately after we called
zero_user_segment().  So isn't this a bug in the fs do_invalidatepage()?
The range from 1k-2k _is_ uptodate.  It's been zeroed in memory,
and if we were to run after the "free block" below, we'd get that
memory zeroed again.

>             ->readpage()
>               block underlying offset 1k
> 	      still allocated -> map buffer
> 					  free block under offset 1k
> 	      submit IO -> corrupted data
> 
> If you think I should expand it to explain more details, please tell.
> Or maybe I can put more detailed discussion like above into the changelog?

> > Why not:
> > 
> > 	__init_rwsem(&mapping->invalidate_lock, "mapping.invalidate_lock",
> > 			&sb->s_type->invalidate_lock_key);
> 
> I replicated what we do for i_rwsem but you're right, this is better.
> Updated.

Hmm, there's a few places we should use __init_rwsem() ... something
for my "when bored" pile of work.
