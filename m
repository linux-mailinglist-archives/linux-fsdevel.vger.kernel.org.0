Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2679A26B6E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgIPANG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:13:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34374 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgIPAM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 20:12:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G0AYZN024263;
        Wed, 16 Sep 2020 00:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=e1CZMmxxOxk5Somji13MpI0sJgU05tCxqG++5ZRhyYw=;
 b=Yn1NsFHf6rmXXCSR80ZGl6Gqn5PvrQRR2HeGCODn2wcXZoOYiGzfuiZKhH5CET9Y8NWa
 wAUo+txVYpgOsC4zZmtsy4WSu4IFs2TmSy1o8KvjM+oNUMq3nunAIJpHRgXIAwJIyGvv
 DmU8dClLBcqVxmL7upk0v8xKGj9eTXTBk3WMdZok0sFx/1qCO5QcIggD+opOHBQA9Stm
 0w9kmagAg6kEgh1GmBZohMatgdXqk9X7RqWUObGrUdsy/xiDpb+6jjVzQjLhIxxVG0Uu
 QgvEDeo5bBTJ0+ld5TXFoea5GGBgKX/GnytHdc8wXplHSNwld2eLb+Jum+ispnLkApLI 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33j91dhrk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 00:12:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G0BRPt074325;
        Wed, 16 Sep 2020 00:12:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33h886ep2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 00:12:45 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08G0ChVr015693;
        Wed, 16 Sep 2020 00:12:43 GMT
Received: from localhost (/10.159.137.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 00:12:43 +0000
Date:   Tue, 15 Sep 2020 17:12:42 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        minlei@redhat.com
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200916001242.GE7955@magnolia>
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200820231140.GE7941@dread.disaster.area>
 <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
 <20200821215358.GG7941@dread.disaster.area>
 <20200822131312.GA17997@infradead.org>
 <20200824142823.GA295033@bfoster>
 <20200824150417.GA12258@infradead.org>
 <20200824154841.GB295033@bfoster>
 <20200825004203.GJ12131@dread.disaster.area>
 <20200825144917.GA321765@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825144917.GA321765@bfoster>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=1 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=1 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150192
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:49:17AM -0400, Brian Foster wrote:
> cc Ming
> 
> On Tue, Aug 25, 2020 at 10:42:03AM +1000, Dave Chinner wrote:
> > On Mon, Aug 24, 2020 at 11:48:41AM -0400, Brian Foster wrote:
> > > On Mon, Aug 24, 2020 at 04:04:17PM +0100, Christoph Hellwig wrote:
> > > > On Mon, Aug 24, 2020 at 10:28:23AM -0400, Brian Foster wrote:
> > > > > Do I understand the current code (__bio_try_merge_page() ->
> > > > > page_is_mergeable()) correctly in that we're checking for physical page
> > > > > contiguity and not necessarily requiring a new bio_vec per physical
> > > > > page?
> > > > 
> > > > 
> > > > Yes.
> > > > 
> > > 
> > > Ok. I also realize now that this occurs on a kernel without commit
> > > 07173c3ec276 ("block: enable multipage bvecs"). That is probably a
> > > contributing factor, but it's not clear to me whether it's feasible to
> > > backport whatever supporting infrastructure is required for that
> > > mechanism to work (I suspect not).
> > > 
> > > > > With regard to Dave's earlier point around seeing excessively sized bio
> > > > > chains.. If I set up a large memory box with high dirty mem ratios and
> > > > > do contiguous buffered overwrites over a 32GB range followed by fsync, I
> > > > > can see upwards of 1GB per bio and thus chains on the order of 32+ bios
> > > > > for the entire write. If I play games with how the buffered overwrite is
> > > > > submitted (i.e., in reverse) however, then I can occasionally reproduce
> > > > > a ~32GB chain of ~32k bios, which I think is what leads to problems in
> > > > > I/O completion on some systems. Granted, I don't reproduce soft lockup
> > > > > issues on my system with that behavior, so perhaps there's more to that
> > > > > particular issue.
> > > > > 
> > > > > Regardless, it seems reasonable to me to at least have a conservative
> > > > > limit on the length of an ioend bio chain. Would anybody object to
> > > > > iomap_ioend growing a chain counter and perhaps forcing into a new ioend
> > > > > if we chain something like more than 1k bios at once?
> > > > 
> > > > So what exactly is the problem of processing a long chain in the
> > > > workqueue vs multiple small chains?  Maybe we need a cond_resched()
> > > > here and there, but I don't see how we'd substantially change behavior.
> > > > 
> > > 
> > > The immediate problem is a watchdog lockup detection in bio completion:
> > > 
> > >   NMI watchdog: Watchdog detected hard LOCKUP on cpu 25
> > > 
> > > This effectively lands at the following segment of iomap_finish_ioend():
> > > 
> > > 		...
> > >                /* walk each page on bio, ending page IO on them */
> > >                 bio_for_each_segment_all(bv, bio, iter_all)
> > >                         iomap_finish_page_writeback(inode, bv->bv_page, error);
> > > 
> > > I suppose we could add a cond_resched(), but is that safe directly
> > > inside of a ->bi_end_io() handler? Another option could be to dump large
> > > chains into the completion workqueue, but we may still need to track the
> > > length to do that. Thoughts?
> > 
> > We have ioend completion merging that will run the compeltion once
> > for all the pending ioend completions on that inode. IOWs, we do not
> > need to build huge chains at submission time to batch up completions
> > efficiently. However, huge bio chains at submission time do cause
> > issues with writeback fairness, pinning GBs of ram as unreclaimable
> > for seconds because they are queued for completion while we are
> > still submitting the bio chain and submission is being throttled by
> > the block layer writeback throttle, etc. Not to mention the latency
> > of stable pages in a situation like this - a mmap() write fault
> > could stall for many seconds waiting for a huge bio chain to finish
> > submission and run completion processing even when the IO for the
> > given page we faulted on was completed before the page fault
> > occurred...
> > 
> > Hence I think we really do need to cap the length of the bio
> > chains here so that we start completing and ending page writeback on
> > large writeback ranges long before the writeback code finishes
> > submitting the range it was asked to write back.
> > 
> 
> Ming pointed out separately that limiting the bio chain itself might not
> be enough because with multipage bvecs, we can effectively capture the
> same number of pages in much fewer bios. Given that, what do you think
> about something like the patch below to limit ioend size? This
> effectively limits the number of pages per ioend regardless of whether
> in-core state results in a small chain of dense bios or a large chain of
> smaller bios, without requiring any new explicit page count tracking.
> 
> Brian

Dave was asking on IRC if I was going to pull this patch in.  I'm unsure
of its status (other than it hasn't been sent as a proper [PATCH]) so I
wonder, is this necessary, and if so, can it be cleaned up and
submitted?

--D

> --- 8< ---
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6ae98d3cb157..4aa96705ffd7 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1301,7 +1301,7 @@ iomap_chain_bio(struct bio *prev)
>  
>  static bool
>  iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
> -		sector_t sector)
> +		unsigned len, sector_t sector)
>  {
>  	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
>  	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
> @@ -1312,6 +1312,8 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
>  		return false;
>  	if (sector != bio_end_sector(wpc->ioend->io_bio))
>  		return false;
> +	if (wpc->ioend->io_size + len > IOEND_MAX_IOSIZE)
> +		return false;
>  	return true;
>  }
>  
> @@ -1329,7 +1331,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
>  	unsigned poff = offset & (PAGE_SIZE - 1);
>  	bool merged, same_page = false;
>  
> -	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
> +	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, len, sector)) {
>  		if (wpc->ioend)
>  			list_add(&wpc->ioend->io_list, iolist);
>  		wpc->ioend = iomap_alloc_ioend(inode, wpc, offset, sector, wbc);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 4d1d3c3469e9..5d1b1a08ec96 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -200,6 +200,8 @@ struct iomap_ioend {
>  	struct bio		io_inline_bio;	/* MUST BE LAST! */
>  };
>  
> +#define IOEND_MAX_IOSIZE	(262144 << PAGE_SHIFT)
> +
>  struct iomap_writeback_ops {
>  	/*
>  	 * Required, maps the blocks so that writeback can be performed on
> 
