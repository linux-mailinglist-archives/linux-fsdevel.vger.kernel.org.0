Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCBB4720C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 06:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhLMFup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 00:50:45 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:48359 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229502AbhLMFuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:50:44 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 8243C58B7A0;
        Mon, 13 Dec 2021 16:50:40 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mwdYm-002S6K-Gx; Mon, 13 Dec 2021 16:07:36 +1100
Date:   Mon, 13 Dec 2021 16:07:36 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jan Kara <jack@suse.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Remove bdi_congested() and wb_congested() and
 related functions
Message-ID: <20211213050736.GS449541@dread.disaster.area>
References: <163936868317.23860.5037433897004720387.stgit@noble.brown>
 <163936886727.23860.5245364396572576756.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163936886727.23860.5245364396572576756.stgit@noble.brown>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=61b6df32
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=IOMw9HtfNCkA:10 a=7-415B0cAAAA:8
        a=HeSqFrNRAXltMStoDEkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 03:14:27PM +1100, NeilBrown wrote:
> These functions are no longer useful as the only bdis that report
> congestion are in ceph, fuse, and nfs.  None of those bdis can be the
> target of the calls in drbd, ext2, nilfs2, or xfs.
> 
> Removing the test on bdi_write_contested() in current_may_throttle()
> could cause a small change in behaviour, but only when PF_LOCAL_THROTTLE
> is set.
> 
> So replace the calls by 'false' and simplify the code - and remove the
> functions.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
....
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 631c5a61d89b..22f73b3e888e 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -843,9 +843,6 @@ xfs_buf_readahead_map(
>  {
>  	struct xfs_buf		*bp;
>  
> -	if (bdi_read_congested(target->bt_bdev->bd_disk->bdi))
> -		return;

Ok, but this isn't a "throttle writeback" test here - it's trying to
avoid having speculative readahead blocking on a full request queue
instead of just skipping the readahead IO. i.e. prevent readahead
thrashing and/or adding unnecessary read load when we already have a
full read queue...

So what is the replacement for that? We want to skip the entire
buffer lookup/setup/read overhead if we're likely to block on IO
submission - is there anything we can use to do this these days?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
