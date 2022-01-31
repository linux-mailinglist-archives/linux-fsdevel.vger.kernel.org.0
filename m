Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA094A47D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 14:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378586AbiAaNMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 08:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378573AbiAaNM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:12:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4799C061714;
        Mon, 31 Jan 2022 05:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a0hve9Zah0GLqzeFulizCrPjPl4njK9R2PBNHZL7apA=; b=g1/eWZJ918eTkgUtvMoL5izh9i
        Owrg8UXzWhZ4euJ5rmNmyKv8w3D5s3PzqdRFd4JGFN1v8KvZWfOislDJeYS/2HhBHEbzl0ZVwks7Y
        s52PZ0PrtSTTxWmiZnIQc/3zfoxLDw4sWIuiSYdaNFoIuq4MDeZNIYuwe/rweivtHGroM3x98FRTF
        RD2fV7EJBoS70u7wUR0dBKam5/B7VEzyyF2M8/vsplRvhFSU59jGKvXo6aK2LxZDKzZT65BgX1EmO
        SJDx0NRR1aXlsG8bgesE4+QBS8/+Nr/BYDMO2gPBh9TRKADGKKpap+xqNNmYfvgj5BWfhju/FPydz
        YxLQzzDg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEWTa-009sqV-3i; Mon, 31 Jan 2022 13:12:10 +0000
Date:   Mon, 31 Jan 2022 13:12:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fuse: remove reliance on bdi congestion
Message-ID: <YffgKva2Dz3cTwhr@casper.infradead.org>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>
 <164360183348.4233.761031466326833349.stgit@noble.brown>
 <YfdlbxezYSOSYmJf@casper.infradead.org>
 <164360446180.18996.6767388833611575467@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164360446180.18996.6767388833611575467@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 03:47:41PM +1100, NeilBrown wrote:
> On Mon, 31 Jan 2022, Matthew Wilcox wrote:
> > > +++ b/fs/fuse/file.c
> > > @@ -958,6 +958,8 @@ static void fuse_readahead(struct readahead_control *rac)
> > >  
> > >  	if (fuse_is_bad(inode))
> > >  		return;
> > > +	if (fc->num_background >= fc->congestion_threshold)
> > > +		return;
> > 
> > This seems like a bad idea to me.  If we don't even start reads on
> > readahead pages, they'll get ->readpage called on them one at a time
> > and the reading thread will block.  It's going to lead to some nasty
> > performance problems, exactly when you don't want them.  Better to
> > queue the reads internally and wait for congestion to ease before
> > submitting the read.
> > 
> 
> Isn't that exactly what happens now? page_cache_async_ra() sees that
> inode_read_congested() returns true, so it doesn't start readahead.
> ???

It's rather different.  Imagine the readahead window has expanded to
256kB (64 pages).  Today, we see congestion and don't do anything.
That means we miss the async readahed opportunity, find a missing
page and end up calling into page_cache_sync_ra(), by which time
we may or may not be congested.

If the inode_read_congested() in page_cache_async_ra() is removed and
the patch above is added to replace it, we'll allocate those 64 pages and
add them to the page cache.  But then we'll return without starting IO.
When we hit one of those !uptodate pages, we'll call ->readpage on it,
but we won't do anything to the other 63 pages.  So we'll go through a
protracted slow period of sending 64 reads, one at a time, whether or
not congestion has eased.  Then we'll hit a missing page and proceed
to the sync ra case as above.

(I'm assuming this is a workload which does a linear scan and so
readahead is actually effective)
