Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77642691369
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 23:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjBIWea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 17:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjBIWe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:34:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E1A24C90;
        Thu,  9 Feb 2023 14:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wPRJFOf9ORgLw15sVlY8kF/QglAmgE41oF0tS8oT+cM=; b=vdG8sFOiH15+Ze4S454DZXNK+r
        0XATjtq/r/R94pBSNaTwOBYDLr1mM8a7arMMf6Fd4qI3Mf9kH+Z8xY+KdPrrkuqbGXB7E3v5/5GTL
        PT33gJXDQLd2N1Xla2pIfZeoOq/Qm7RfVk5Mb0fMDsIhosVny+ljHR0flQ0/AsT+Et9DvD14TfeY/
        3mDGZnBJJqfEl5IjKjh0rP7gBRjlg+OPbihVDrjpjwnCS5hn4jpZFy+ndZkuzasn3ZcFJ6RhilpvY
        Ja9bsNpv9/es8+MePaGQtfgfkY5EeUFWIlReUOL5x0hUUAv74hemy75FLtV6uVtugOI169zw7LXDL
        L/j8lUBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQFUj-002a3X-5R; Thu, 09 Feb 2023 22:34:21 +0000
Date:   Thu, 9 Feb 2023 22:34:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 1/3] xfs: Remove xfs_filemap_map_pages() wrapper
Message-ID: <Y+V07dcDoxP4mjbJ@casper.infradead.org>
References: <20230208145335.307287-1-willy@infradead.org>
 <20230208145335.307287-2-willy@infradead.org>
 <Y+PQN8cLdOXST20D@magnolia>
 <Y+PX5tPyOP2KQqoD@casper.infradead.org>
 <20230208215311.GC360264@dread.disaster.area>
 <Y+ReBH8DFxf+Iab4@casper.infradead.org>
 <20230209215358.GG360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209215358.GG360264@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 10, 2023 at 08:53:58AM +1100, Dave Chinner wrote:
> On Thu, Feb 09, 2023 at 02:44:20AM +0000, Matthew Wilcox wrote:
> > On Thu, Feb 09, 2023 at 08:53:11AM +1100, Dave Chinner wrote:
> > > > If XFS really needs it,
> > > > it can trylock the semaphore and return 0 if it fails, falling back to
> > > > the ->fault path.  But I don't think XFS actually needs it.
> > > >
> > > > The ->map_pages path trylocks the folio, checks the folio->mapping,
> > > > checks uptodate, then checks beyond EOF (not relevant to hole punch).
> > > > Then it takes the page table lock and puts the page(s) into the page
> > > > tables, unlocks the folio and moves on to the next folio.
> > > > 
> > > > The hole-punch path, like the truncate path, takes the folio lock,
> > > > unmaps the folio (which will take the page table lock) and removes
> > > > it from the page cache.
> > > > 
> > > > So what's the race?
> > > 
> > > Hole punch is a multi-folio operation, so while we are operating on
> > > invalidating one folio, another folio in the range we've already
> > > invalidated could be instantiated and mapped, leaving mapped
> > > up-to-date pages over a range we *require* the page cache to empty.
> > 
> > Nope.  ->map_pages is defined to _not_ instantiate new pages.
> > If there are uptodate pages in the page cache, they can be mapped, but
> > missing pages will be skipped, and left to ->fault to bring in.
> 
> Sure, but *at the time this change was made* other operations could
> instantiate pages whilst an invalidate was running, and then
> ->map_pages could also find them and map them whilst that
> invalidation was still running. i.e. the race conditions that
> existed before the mapping->invalidate_lock was introduced (ie. we
> couldn't intercept read page faults instantiating pages in the page
> cache at all) didn't require ->map_pages to instantiate the page for
> it to be able to expose incorrect data to userspace when page faults
> raced with an ongoing invalidation operation.
> 
> While this may not be able to happen now if everything is using the
> mapping->invalidate_lock correctly (because read faults are now
> intercepted before they can instatiate new page cache pages), it
> doesn't mean it wasn't possible in the past.....

Sorry, still not getting it.  Here's the scenario I think you're
talking about.  We have three threads (probably in different tasks
or they may end up getting synchronized on the page table locks).

Thread 1 is calling FALLOC_FL_PUNCH_HOLE over a nice wide range.
Thread 2 has the file mmaped and takes a read page fault.
Thread 3 also has the file mmaped and also takes a read page fault.

Thread 2 calls filemap_map_pages and finds the pages gone.  It proceeds
to call xfs_filemap_fault() which calls filemap_fault() without
taking any XFS locks.  filemap_fault() kicks off some readahead which
allocates some pages & puts them in the page cache.  It calls into
xfs_vm_readahead() which calls iomap_readahead() without taking any XFS
locks.  iomap_readahead() will then call back into xfs_read_iomap_begin()
which takes the XFS_ILOCK_SHARED.

Since thread 1 is holding XFS_IOLOCK_EXCL, I presume thread 2 will
block at this point until thread 1 is done.  At this point, the page
is still not uptodate, so thread 3 will not map the page if it finds it
in >map_pages.

Or have I misunderstood XFS inode locking?  Entirely possible, it
seems quite complicated.  Nevertheless, it seems to me that if there's
locking that's missing, there's ample opportunities for XFS to take those
missing locks in the (slow) fault path, and not take them in the (fast)
map_pages path.
