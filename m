Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AE72EEE42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 09:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbhAHIBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 03:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727265AbhAHIBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 03:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610092785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t2Uqdb9txLxEPVkApRsygTFUuNyR++VCv2wK5tWRd0Q=;
        b=XhOupzEYT/d4yG4GJaISeW4PeOg3eZIHybGr4q77Bl18cS/4ZRNGnXS8fM6aDpnLtpZlNn
        OYKtyJlQZfekY+UU6jWJeI31bo+PlllZ6B46Al1ga4A8i0/GDX7i1lw1r4xSsEUd5Uy1Yr
        yQJRr6PynPf6xYJ/8DecmqbHQ9WHVTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-FVuK9KCNNw61Br6hOlN66Q-1; Fri, 08 Jan 2021 02:59:40 -0500
X-MC-Unique: FVuK9KCNNw61Br6hOlN66Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2A8418C9F40;
        Fri,  8 Jan 2021 07:59:38 +0000 (UTC)
Received: from T590 (ovpn-13-115.pek2.redhat.com [10.72.13.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8EA060C17;
        Fri,  8 Jan 2021 07:59:28 +0000 (UTC)
Date:   Fri, 8 Jan 2021 15:59:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: block_dev: compute nr_vecs hint for improving
 writeback bvecs allocation
Message-ID: <20210108075922.GB3982620@T590>
References: <20210105132647.3818503-1-ming.lei@redhat.com>
 <20210105183938.GA3878@lst.de>
 <20210106084548.GA3845805@T590>
 <20210106222111.GE331610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106222111.GE331610@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 09:21:11AM +1100, Dave Chinner wrote:
> On Wed, Jan 06, 2021 at 04:45:48PM +0800, Ming Lei wrote:
> > On Tue, Jan 05, 2021 at 07:39:38PM +0100, Christoph Hellwig wrote:
> > > At least for iomap I think this is the wrong approach.  Between the
> > > iomap and writeback_control we know the maximum size of the writeback
> > > request and can just use that.
> > 
> > I think writeback_control can tell us nothing about max pages in single
> > bio:
> 
> By definition, the iomap tells us exactly how big the IO is going to
> be. i.e. an iomap spans a single contiguous range that we are going
> to issue IO on. Hence we can use that to size the bio exactly
> right for direct IO.

When I trace wpc->iomap.length in iomap_add_to_ioend() on the following fio
randwrite/write, the length is 1GB most of times, maybe because it is
one fresh XFS.

fio --size=1G --bsrange=4k-4k --runtime=30 --numjobs=2 --ioengine=psync --iodepth=32 \
	--directory=$DIR --group_reporting=1 --unlink=0 --direct=0 --fsync=0 --name=f1 \
	--stonewall --rw=$RW
sync

Another reason is that pages in the range may be contiguous physically,
so lots of pages may share one single bvec.

> 
> > - wbc->nr_to_write controls how many pages to writeback, this pages
> >   usually don't belong to same bio. Also this number is often much
> >   bigger than BIO_MAX_PAGES.
> > 
> > - wbc->range_start/range_end is similar too, which is often much more
> >   bigger than BIO_MAX_PAGES.
> > 
> > Also page/blocks_in_page can be mapped to different extent too, which is
> > only available when wpc->ops->map_blocks() is returned,
> 
> We only allocate the bio -after- calling ->map_blocks() to obtain
> the iomap for the given writeback range request. Hence we
> already know how large the BIO could be before we allocate it.
> 
> > which looks not
> > different with mpage_writepages(), in which bio is allocated with
> > BIO_MAX_PAGES vecs too.
> 
> __mpage_writepage() only maps a page at a time, so it can't tell
> ahead of time how big the bio is going to need to be as it doesn't
> return/cache a contiguous extent range. So it's actually very
> different to the iomap writeback code, and effectively does require
> a BIO_MAX_PAGES vecs allocation all the time...
> 
> > Or you mean we can use iomap->length for this purpose? But iomap->length
> > still is still too big in case of xfs.
> 
> if we are doing small random writeback into large extents (i.e.
> iomap->length is large), then it is trivial to detect that we are
> doing random writes rather than sequential writes by checking if the
> current page is sequential to the last sector in the current bio.
> We already do this non-sequential IO checking to determine if a new
> bio needs to be allocated in iomap_can_add_to_ioend(), and we also
> know how large the current contiguous range mapped into the current
> bio chain is (ioend->io_size). Hence we've got everything we need to
> determine whether we should do a large or small bio vec allocation
> in the iomap writeback path...

page->index should tell us if the workload is random or sequential, however
still not easy to decide how many pages there will be in the next bio
when iomap->length is large.


Thanks,
Ming

