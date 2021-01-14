Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5E62F5EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 11:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbhANKZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 05:25:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726374AbhANKZU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610619833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+MMb1/G417jh9jG0BhfvlCwuED50p5s62EpK3Ii+ar8=;
        b=TX8+CDoZfj5fPzD9EWFBp8Xo7p2qsHeSOtIrMyOkCQvL7nvk4fIJ4oUqDsgL14zdvwyPXA
        Jjs6klDJ1DtPyXJLK+QNLAzszGUiiDVJ1nMyPHyTxByz+Ja1p7nzxV7aOsFhuXjf8zKYRc
        2obHRZo711hyy6V08viAB2E2Bkz3SyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-VirEnoeyPVi0Wfw776grDQ-1; Thu, 14 Jan 2021 05:23:51 -0500
X-MC-Unique: VirEnoeyPVi0Wfw776grDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3551C190A7A3;
        Thu, 14 Jan 2021 10:23:50 +0000 (UTC)
Received: from bfoster (ovpn-114-23.rdu2.redhat.com [10.10.114.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76BC674AA0;
        Thu, 14 Jan 2021 10:23:49 +0000 (UTC)
Date:   Thu, 14 Jan 2021 05:23:47 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avi@scylladb.com
Subject: Re: [PATCH 09/10] iomap: add a IOMAP_DIO_NOALLOC flag
Message-ID: <20210114102347.GD1333929@bfoster>
References: <20210112162616.2003366-1-hch@lst.de>
 <20210112162616.2003366-10-hch@lst.de>
 <20210112232923.GD331610@dread.disaster.area>
 <20210113153215.GA1284163@bfoster>
 <20210113224935.GJ331610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113224935.GJ331610@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 14, 2021 at 09:49:35AM +1100, Dave Chinner wrote:
> On Wed, Jan 13, 2021 at 10:32:15AM -0500, Brian Foster wrote:
> > On Wed, Jan 13, 2021 at 10:29:23AM +1100, Dave Chinner wrote:
> > > On Tue, Jan 12, 2021 at 05:26:15PM +0100, Christoph Hellwig wrote:
> > > > Add a flag to request that the iomap instances do not allocate blocks
> > > > by translating it to another new IOMAP_NOALLOC flag.
> > > 
> > > Except "no allocation" that is not what XFS needs for concurrent
> > > sub-block DIO.
> > > 
> > > We are trying to avoid external sub-block IO outside the range of
> > > the user data IO (COW, sub-block zeroing, etc) so that we don't
> > > trash adjacent sub-block IO in flight. This means we can't do
> > > sub-block zeroing and that then means we can't map unwritten extents
> > > or allocate new extents for the sub-block IO.  It also means the IO
> > > range cannot span EOF because that triggers unconditional sub-block
> > > zeroing in iomap_dio_rw_actor().
> > > 
> > > And because we may have to map multiple extents to fully span an IO
> > > range, we have to guarantee that subsequent extents for the IO are
> > > also written otherwise we have a partial write abort case. Hence we
> > > have single extent limitations as well.
> > > 
> > > So "no allocation" really doesn't describe what we want this flag to
> > > at all.
> > > 
> > > If we're going to use a flag for this specific functionality, let's
> > > call it what it is: IOMAP_DIO_UNALIGNED/IOMAP_UNALIGNED and do two
> > > things with it.
> > > 
> > > 	1. Make unaligned IO a formal part of the iomap_dio_rw()
> > > 	behaviour so it can do the common checks to for things that
> > > 	need exclusive serialisation for unaligned IO (i.e. avoid IO
> > > 	spanning EOF, abort if there are cached pages over the
> > > 	range, etc).
> > > 
> > > 	2. require the filesystem mapping callback do only allow
> > > 	unaligned IO into ranges that are contiguous and don't
> > > 	require mapping state changes or sub-block zeroing to be
> > > 	performed during the sub-block IO.
> > > 
> > > 
> > 
> > Something I hadn't thought about before is whether applications might
> > depend on current unaligned dio serialization for coherency and thus
> > break if the kernel suddenly allows concurrent unaligned dio to pass
> > through. Should this be something that is explicitly requested by
> > userspace?
> 
> If applications are relying on an undocumented, implementation
> specific behaviour of a filesystem that only occurs for IOs of a
> certain size for implicit data coherency between independent,
> non-overlapping DIOs and/or page cache IO, then they are already
> broken and need fixing because that behaviour is not guaranteed to
> occur. e.g. 512 byte block size filesystem does not provide such
> serialisation, so if the app depends on 512 byte DIOs being
> serialised completely by the filesytem then it already fails on 512
> byte block size filesystems.
> 

I'm not sure how the block size relates beyond just changing the
alignment requirements..?

> So, no, we simply don't care about breaking broken applications that
> are already broken.
> 

I agree in general, but I'm not sure that helps us on the "don't break
userspace" front. We can call userspace broken all we want, but if some
application has such a workload that historically functions correctly
due to this serialization and all of a sudden starts to cause data
corruption because we decide to remove it, I fear we'd end up taking the
blame regardless. :/

I wonder if other fs' provide similar concurrent unaligned dio
support..? A quick look at ext4 shows it has similar logic to XFS, btrfs
looks like it falls back to buffered I/O...

> > That aside, I agree that the DIO_UNALIGNED approach seems a bit more
> > clear than NOALLOC, but TBH the more I look at this the more Christoph's
> > first approach seems cleanest to me. It is a bit unfortunate to
> > duplicate the mapping lookups and have the extra ILOCK cycle, but the
> > lock is shared and only taken when I/O is unaligned. I don't really see
> > why that is a show stopper yet it's acceptable to fall back to exclusive
> > dio if the target range happens to be discontiguous (but otherwise
> > mapped/written).
> 
> Unnecessary lock cycles in the fast path are always bad. The whole
> reason this change is being done is for performance to bring it up
> to par with block aligned IO. Adding an extra lock cycle to the
> ILOCK on every IO will halve the performance on high IOPs hardware
> because the ILOCK will be directly exposed to userspace IO
> submission and hence become the contention point instead of the
> IOLOCK.
> 
> IOWs, the fact taht we take the ILOCK 2x per IO instead of once
> means that the ILOCK becomes the performance limiting lock (because
> even shared locking causes cacheline contention) and changes the
> entire lock profile for the IO path when unaligned IO is being done.
> 
> This is also ignoring the fact that the ILOCK is held in exclusive
> mode during IO completion while doing file size and extent
> manipulation transactions. IOWs we can block waiting on IO
> completion before we even decide if we can do the IO with shared
> locking. Hence there are new IO submission serialisation points in
> the fast path that will also slow down the cases where we have to do
> exclusive locking....
> 
> So, yeah, I can only see bad things occurring by lifting the ILOCK
> up into the high level IO path. And, of course, once it's taken
> there, people will find new reasons to expand it's scope and the
> problems will only get worse...
> 

I'm not saying the extra ilock cycle is free or even ideal. I'm
questioning that the proposed alternatives provide complete
functionality when things like unaligned dio that span mappings are
always going to fall back to exclusive I/O. There's an obvious tradeoff
there between performance and predictability that IMO isn't as cut and
dry as you describe. I certainly don't consider that as bringing
unaligned dio performance up to par with block aligned dio.

> > So I dunno... to me, I would start with that approach and then as the
> > implementation soaks, perhaps see if we can find a way to optimize away
> > the extra cycle and lookup.
> 
> I don't see how we can determine if we can do the unlaigned IO
> holding a shared lock without doing an extent lookup. It's the
> underlying extent state that makes shared locking possible, and I
> can't think of any other state we can look at to make this decision.
> 

Not sure how you got "without doing an extent lookup" from my comment.
:P I was referring to the extra/early lookup and lock cycle that we're
discussing above wrt to the original series. These subsequent series
already do without it, but to me they sacrifice functionality. I'm
basically saying that it might be worth to try and make it work first,
make it fast(er) second (or otherwise find a way to address the issue in
the latest series).

Of course, based on the behavior of other fs' I'm not totally convinced
this is a great idea in the first place, at least not without some kind
of opt-in from userspace or perhaps broader community consensus..

Brian

> Hence I think this path is simply a dead end with no possibility of
> further optimisation. Of course, if you can solve the problem
> without needing an extent lookup, then we can talk about how to
> avoid racing with actual extent mapping changes done under the
> ILOCK... :)
> 
> Cheers,
> 
> Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> 

