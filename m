Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75735143FC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 15:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgAUOkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 09:40:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:51572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbgAUOki (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:40:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 03C37AE33;
        Tue, 21 Jan 2020 14:40:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 03AAE1E0A4A; Tue, 21 Jan 2020 12:36:27 +0100 (CET)
Date:   Tue, 21 Jan 2020 12:36:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: Re: [RFC v2 0/9] Replacing the readpages a_op
Message-ID: <20200121113627.GA1746@quack2.suse.cz>
References: <20200115023843.31325-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115023843.31325-1-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew!

On Tue 14-01-20 18:38:34, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This is an attempt to add a ->readahead op to replace ->readpages.  I've
> converted two users, iomap/xfs and cifs.  The cifs conversion is lacking
> fscache support, and that's just because I didn't want to do that work;
> I don't believe there's anything fundamental to it.  But I wanted to do
> iomap because it is The Infrastructure Of The Future and cifs because it
> is the sole remaining user of add_to_page_cache_locked(), which enables
> the last two patches in the series.  By the way, that gives CIFS access
> to the workingset shadow infrastructure, which it had to ignore before
> because it couldn't put pages onto the lru list at the right time.
> 
> v2: Chris asked me to show what this would look like if we just have
> the implementation look up the pages in the page cache, and I managed
> to figure out some things I'd done wrong last time.  It's even simpler
> than v1 (net 104 lines deleted).

I have an unfinished patch series laying around that pulls the ->readpage
/ ->readpages API in somewhat different direction so I'd like to discuss
whether it's possible to solve my problem using your API. The problem I
have is that currently some operations such as hole punching can race with
->readpage / ->readpages like:

CPU0						CPU1
fallocate(fd, FALLOC_FL_PUNCH_HOLE, off, len)
  filemap_write_and_wait_range()
  down_write(inode->i_rwsem);
  truncate_pagecache_range();
						readahead(fd, off, len)
						  creates pages in page cache
						  looks up block mapping
  removes blocks from inode and frees them
						  issues bio
						    - reads stale data -
						      potential security
						      issue

Now how I wanted to address this is that I'd change the API convention for
->readpage() so that we call it with the page unlocked and the function
would lock the page, check it's still OK, and do what it needs. And this
will allow ->readpage() and also ->readpages() to grab lock
(EXT4_I(inode)->i_mmap_sem in case of ext4) to synchronize with hole punching
while we are adding pages to page cache and mapping underlying blocks.

Now your API makes even ->readpages() (actually ->readahead) called with
pages locked so that makes this approach problematic because of lock
inversions. So I'd prefer if we could keep the situation that ->readpages /
->readahead gets called without any pages in page cache locked...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
