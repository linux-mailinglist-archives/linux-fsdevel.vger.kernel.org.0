Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CC13005DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 15:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbhAVOnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 09:43:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:60932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbhAVOdQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:33:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D71C5ADA2;
        Fri, 22 Jan 2021 14:32:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 94D161E14C3; Fri, 22 Jan 2021 15:32:32 +0100 (CET)
Date:   Fri, 22 Jan 2021 15:32:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/3 RFC] fs: Hole punch vs page cache filling races
Message-ID: <20210122143232.GA1175@quack2.suse.cz>
References: <20210120160611.26853-1-jack@suse.cz>
 <20210121192755.GC4127393@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121192755.GC4127393@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-01-21 19:27:55, Matthew Wilcox wrote:
> On Wed, Jan 20, 2021 at 05:06:08PM +0100, Jan Kara wrote:
> > Hello,
> > 
> > Amir has reported [1] a that ext4 has a potential issues when reads can race
> > with hole punching possibly exposing stale data from freed blocks or even
> > corrupting filesystem when stale mapping data gets used for writeout. The
> > problem is that during hole punching, new page cache pages can get instantiated
> > in a punched range after truncate_inode_pages() has run but before the
> > filesystem removes blocks from the file.  In principle any filesystem
> > implementing hole punching thus needs to implement a mechanism to block
> > instantiating page cache pages during hole punching to avoid this race. This is
> > further complicated by the fact that there are multiple places that can
> > instantiate pages in page cache.  We can have regular read(2) or page fault
> > doing this but fadvise(2) or madvise(2) can also result in reading in page
> > cache pages through force_page_cache_readahead().
> 
> Doesn't this indicate that we're doing truncates in the wrong order?
> ie first we should deallocate the blocks, then we should free the page
> cache that was caching the contents of those blocks.  We'd need to
> make sure those pages in the page cache don't get written back to disc
> (either by taking pages in the page cache off the lru list or having
> the filesystem handle writeback of pages to a freed extent as a no-op).

Well, it depends on how much you wish to complicate the matters :).
Filesystems have metadata information attached to pages (e.g. buffer
heads), once you are removing blocks from a file, this information is
becoming stale. So it makes perfect sense to first evict page cache to
remove this metadata caching information and then remove blocks from
on-disk structures.

You can obviously try to do it the other way around - i.e., first remove
blocks from on-disk structures and then remove the cached information from
the page cache. But then you have to make sure stale cached information
isn't used until everything is in sync. So whichever way you slice it, you
have information in two places, you need to keep it in sync and you need
some synchronization between different updaters of this information
in both places so that they cannot get those two places out of sync...

TLDR: I don't see much benefit in switching the ordering.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
