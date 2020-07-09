Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1A221A473
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 18:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgGIQMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 12:12:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55014 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgGIQML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:12:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069G7pMq194149;
        Thu, 9 Jul 2020 16:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=i3stYrSZ13+uPhOhOyEQWASoeoYjXBvn1KNQ+SmH2qc=;
 b=xc2LG5P/4lNS9g2oVuoaqsMcOwRYCciJ//hjcn48iC94Xcb/ikm6NMuYSp8akPaA/Hc2
 Ukgnu/1J7fBhSZOIJ94UyF2qZlUwGvow6+zz4Z33ucdPYM3U9oQhUVx6f00UgTVXfxxz
 D9BRpfv1K1tgaHMHoyvGIjbviIZxTOWnz/77RITc2E8BpFPrYh9HqYk0V+foKllisLqm
 AyspIoYz/zeo9vlMhY43qKGHS6iqR16pPx4SJrbSFuUXtxN4GTAPTUlmJOqqEJ7LYC9T
 y7eRQKdE3HK0uOCp3gcEhL0b4bLwJahbiTOFP8Ws9eNucKxqOvsdh/8pizuNDqReIddg Ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 325y0ajsgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 09 Jul 2020 16:11:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069G9MgZ139354;
        Thu, 9 Jul 2020 16:09:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 325k3hgsrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jul 2020 16:09:39 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 069G9SSl007389;
        Thu, 9 Jul 2020 16:09:28 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jul 2020 09:09:27 -0700
Date:   Thu, 9 Jul 2020 09:09:26 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, dsterba@suse.cz, cluster-devel@redhat.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: always fall back to buffered I/O after invalidation failures,
 was: Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return if page
 invalidation fails
Message-ID: <20200709160926.GO7606@magnolia>
References: <20200629192353.20841-1-rgoldwyn@suse.de>
 <20200629192353.20841-3-rgoldwyn@suse.de>
 <20200701075310.GB29884@lst.de>
 <20200707124346.xnr5gtcysuzehejq@fiona>
 <20200707125705.GK25523@casper.infradead.org>
 <20200707130030.GA13870@lst.de>
 <20200708065127.GM2005@dread.disaster.area>
 <20200708135437.GP25523@casper.infradead.org>
 <20200709022527.GQ2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709022527.GQ2005@dread.disaster.area>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=7
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=7 mlxlogscore=999 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090116
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 12:25:27PM +1000, Dave Chinner wrote:
> On Wed, Jul 08, 2020 at 02:54:37PM +0100, Matthew Wilcox wrote:
> > On Wed, Jul 08, 2020 at 04:51:27PM +1000, Dave Chinner wrote:
> > > On Tue, Jul 07, 2020 at 03:00:30PM +0200, Christoph Hellwig wrote:
> > > > On Tue, Jul 07, 2020 at 01:57:05PM +0100, Matthew Wilcox wrote:
> > > > > Indeed, I'm in favour of not invalidating
> > > > > the page cache at all for direct I/O.  For reads, I think the page cache
> > > > > should be used to satisfy any portion of the read which is currently
> > > > > cached.  For writes, I think we should write into the page cache pages
> > > > > which currently exist, and then force those pages to be written back,
> > > > > but left in cache.
> > > > 
> > > > Something like that, yes.
> > > 
> > > So are we really willing to take the performance regression that
> > > occurs from copying out of the page cache consuming lots more CPU
> > > than an actual direct IO read? Or that direct IO writes suddenly
> > > serialise because there are page cache pages and now we have to do
> > > buffered IO?
> > > 
> > > Direct IO should be a deterministic, zero-copy IO path to/from
> > > storage. Using the CPU to copy data during direct IO is the complete
> > > opposite of the intended functionality, not to mention the behaviour
> > > that many applications have been careful designed and tuned for.
> > 
> > Direct I/O isn't deterministic though.
> 
> When all the application is doing is direct IO, it is as
> deterministic as the underlying storage behaviour. This is the best
> we can possibly do from the perspective of the filesystem, and this
> is largely what Direct IO requires from the filesystem.
> 
> Direct IO starts from delegating all responsibility for IO
> synchronisation data coherency and integrity to userspace, and then
> follows up by requiring the filesystem and kernel to stay out of the
> IO path except where it is absolutely necessary to read or write
> data to/from the underlying storage hardware. Serving Direct IO from
> the page cache violates the second of these requirements.
> 
> > If the file isn't shared, then
> > it works great, but as soon as you get mixed buffered and direct I/O,
> > everything is already terrible.
> 
> Right, but that's *the rare exception* for applications using direct
> IO, not the common fast path. It is the slow path where -shit has
> already gone wrong on the production machine-, and it most
> definitely does not change the DIO requirements that the filesystem
> needs to provide userspace via the direct IO path.
> 
> Optimising the slow exception path is fine if it does not affect the
> guarantees we try to provide through the common/fast path. If it is
> does affect behaviour of the fast path, then we must be able to
> either turn it off or provide our own alternative implementation
> that does not have that cost.
> 
> > Direct I/Os perform pagecache lookups
> > already, but instead of using the data that we found in the cache, we
> > (if it's dirty) write it back, wait for the write to complete, remove
> > the page from the pagecache and then perform another I/O to get the data
> > that we just wrote out!  And then the app that's using buffered I/O has
> > to read it back in again.
> 
> Yup, that's because we have a history going back 20+ years of people
> finding performance regressions in applications using direct IO when
> we leave incorrectly left pages in the page cache rather than
> invalidating them and continuing to do direct IO.
> 
> 
> > Nobody's proposing changing Direct I/O to exclusively work through the
> > pagecache.  The proposal is to behave less weirdly when there's already
> > data in the pagecache.
> 
> No, the proposal it to make direct IO behave *less
> deterministically* if there is data in the page cache.
> 
> e.g. Instead of having a predicatable submission CPU overhead and
> read latency of 100us for your data, this proposal makes the claim
> that it is always better to burn 10x the IO submission CPU for a
> single IO to copy the data and give that specific IO 10x lower
> latency than it is to submit 10 async IOs to keep the IO pipeline
> full.
> 
> What it fails to take into account is that in spending that CPU time
> to copy the data, we haven't submitted 10 other IOs and so the
> actual in-flight IO for the application has decreased. If
> performance comes from keeping the IO pipeline as close to 100% full
> as possible, then copying the data out of the page cache will cause
> performance regressions.
> 
> i.e. Hit 5 page cache pages in 5 IOs in a row, and the IO queue
> depth craters because we've only fulfilled 5 complete IOs instead of
> submitting 50 entire IOs. This is the hidden cost of synchronous IO
> via CPU data copying vs async IO via hardware offload, and if we
> take that into account we must look at future hardware performance
> trends to determine if this cost is going to increase or decrease in
> future.
> 
> That is: CPUs are not getting faster anytime soon. IO subsystems are
> still deep in the "performance doubles every 2 years" part of the
> technology curve (pcie 3.0->4.0 just happened, 4->5 is a year away,
> 5->6 is 3-4 years away, etc). Hence our reality is that we are deep
> within a performance trend curve that tells us synchronous CPU
> operations are not getting faster, but IO bandwidth and IOPS are
> going to increase massively over the next 5-10 years. Hence putting
> (already expensive) synchronous CPU operations in the asynchronous
> zero-data-touch IO fast path is -exactly the wrong direction to be
> moving-.
> 
> This is simple math. The gap between IO latency and bandwidth and
> CPU addressable memory latency and bandwidth is closing all the
> time, and the closer that gap gets the less sense it makes to use
> CPU addressable memory for buffering syscall based read and write
> IO. We are not quite yet at the cross-over point, but we really
> aren't that far from it.
> 
> > I have had an objection raised off-list.  In a scenario with a block
> > device shared between two systems and an application which does direct
> > I/O, everything is normally fine.  If one of the systems uses tar to
> > back up the contents of the block device then the application on that
> > system will no longer see the writes from the other system because
> > there's nothing to invalidate the pagecache on the first system.
> 
> I'm sorry you have to deal with that. :(
> 
> Back in the world of local filesystems, sharing block device across
> systems without using a clustered filesystem to maintain storage
> device level data coherency across those multiple machines is not
> supported in any way, shape or form, direct IO or not.
> 
> > Unfortunately, this is in direct conflict with the performance
> > problem caused by some little arsewipe deciding to do:
> > 
> > $ while true; do dd if=/lib/x86_64-linux-gnu/libc-2.30.so iflag=direct of=/dev/null; done
> 
> This has come up in the past, and I'm pretty sure I sent a patch to
> stop iomap from invalidating the cache on DIO reads because the same
> data is on disk as is in memory and it solves this whole problem.  I
> cannot find that patch in the archives - I must have sent it inline
> to the discussion as I'm about to do again.

And, um, it'll get buried in the archives again. :(

Though I guess I could just suck it in and see what happens, and maybe
"the mists of time" won't be an issue this time around.  Particularly
since I was the one asking you about this very hunk of code last night
on irc. :P

Oh well, onto the review...

> Yeah, now it comes back to me - the context was about using
> RWF_NOWAIT to detect page cache residency for page cache timing
> attacks and I mentioned doing exactly the above as a mechanism to
> demand trigger invalidation of the mapped page cache. The
> solution was to only invalidate the page cache on DIO writes, but we
> didn't do it straight away because I needed to audit the XFS code to
> determine if there were still real reasons it was necessary.
> 
> The patch is attached below. The DIO read path is unchanged except
> for the fact it skips the invalidation.  i.e. the dio read still
> goes to disk, but we can leave the data in memory because it is the
> same as what was on disk. This does not perturb DIO behaviour by
> inserting synchronous page cache copies or exclusive inode locking
> into the async DIO path and so will not cause DIO performance
> regressions. However, it does allow mmap() and read() to be served
> from cache at the same time as we issue overlapping DIO reads.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
> iomap: Only invalidate page cache pages on direct IO writes
> 
> From: Dave Chinner <dchinner@redhat.com>
> 
> The historic requirement for XFS to invalidate cached pages on
> direct IO reads has been lost in the twisty pages of history - it was
> inherited from Irix, which implemented page cache invalidation on
> read as a method of working around problems synchronising page
> cache state with uncached IO.

Urk.

> XFS has carried this ever since. In the initial linux ports it was
> necessary to get mmap and DIO to play "ok" together and not
> immediately corrupt data. This was the state of play until the linux
> kernel had infrastructure to track unwritten extents and synchronise
> page faults with allocations and unwritten extent conversions
> (->page_mkwrite infrastructure). IOws, the page cache invalidation
> on DIO read was necessary to prevent trivial data corruptions. This
> didn't solve all the problems, though.
> 
> There were peformance problems if we didn't invalidate the entire
> page cache over the file on read - we couldn't easily determine if
> the cached pages were over the range of the IO, and invalidation
> required taking a serialising lock (i_mutex) on the inode. This
> serialising lock was an issue for XFS, as it was the only exclusive
> lock in the direct Io read path.
> 
> Hence if there were any cached pages, we'd just invalidate the
> entire file in one go so that subsequent IOs didn't need to take the
> serialising lock. This was a problem that prevented ranged
> invalidation from being particularly useful for avoiding the
> remaining coherency issues. This was solved with the conversion of
> i_mutex to i_rwsem and the conversion of the XFS inode IO lock to
> use i_rwsem. Hence we could now just do ranged invalidation and the
> performance problem went away.
> 
> However, page cache invalidation was still needed to serialise
> sub-page/sub-block zeroing via direct IO against buffered IO because
> bufferhead state attached to the cached page could get out of whack
> when direct IOs were issued.  We've removed bufferheads from the
> XFS code, and we don't carry any extent state on the cached pages
> anymore, and so this problem has gone away, too.
> 
> IOWs, it would appear that we don't have any good reason to be
> invalidating the page cache on DIO reads anymore. Hence remove the
> invalidation on read because it is unnecessary overhead,
> not needed to maintain coherency between mmap/buffered access and
> direct IO anymore, and prevents anyone from using direct IO reads
> from intentionally invalidating the page cache of a file.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/iomap/direct-io.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index ec7b78e6feca..ef0059eb34b5 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -475,23 +475,24 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (ret)
>  		goto out_free_dio;
>  
> -	/*
> -	 * Try to invalidate cache pages for the range we're direct
> -	 * writing.  If this invalidation fails, tough, the write will
> -	 * still work, but racing two incompatible write paths is a
> -	 * pretty crazy thing to do, so we don't support it 100%.

I always wondered about the repeated use of 'write' in this comment
despite the lack of any sort of WRITE check logic.  Seems fine to me,
let's throw it on the fstests pile and see what happens.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> -	 */
> -	ret = invalidate_inode_pages2_range(mapping,
> -			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> -	if (ret)
> -		dio_warn_stale_pagecache(iocb->ki_filp);
> -	ret = 0;
> +	if (iov_iter_rw(iter) == WRITE) {
> +		/*
> +		 * Try to invalidate cache pages for the range we're direct
> +		 * writing.  If this invalidation fails, tough, the write will
> +		 * still work, but racing two incompatible write paths is a
> +		 * pretty crazy thing to do, so we don't support it 100%.
> +		 */
> +		ret = invalidate_inode_pages2_range(mapping,
> +				pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> +		if (ret)
> +			dio_warn_stale_pagecache(iocb->ki_filp);
> +		ret = 0;
>  
> -	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
> -	    !inode->i_sb->s_dio_done_wq) {
> -		ret = sb_init_dio_done_wq(inode->i_sb);
> -		if (ret < 0)
> -			goto out_free_dio;
> +		if (!wait_for_completion &&
> +		    !inode->i_sb->s_dio_done_wq) {
> +			ret = sb_init_dio_done_wq(inode->i_sb);
> +			if (ret < 0)
> +				goto out_free_dio;
>  	}
>  
>  	inode_dio_begin(inode);
