Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C75D3FAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 14:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfJKMjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 08:39:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbfJKMja (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:39:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C80CF3084288;
        Fri, 11 Oct 2019 12:39:30 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 439E85D6C8;
        Fri, 11 Oct 2019 12:39:30 +0000 (UTC)
Date:   Fri, 11 Oct 2019 08:39:28 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/26] xfs: don't allow log IO to be throttled
Message-ID: <20191011123928.GC61257@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-4-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 11 Oct 2019 12:39:30 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:01PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Running metadata intensive workloads, I've been seeing the AIL
> pushing getting stuck on pinned buffers and triggering log forces.
> The log force is taking a long time to run because the log IO is
> getting throttled by wbt_wait() - the block layer writeback
> throttle. It's being throttled because there is a huge amount of
> metadata writeback going on which is filling the request queue.
> 
> IOWs, we have a priority inversion problem here.
> 
> Mark the log IO bios with REQ_IDLE so they don't get throttled
> by the block layer writeback throttle. When we are forcing the CIL,
> we are likely to need to to tens of log IOs, and they are issued as
> fast as they can be build and IO completed. Hence REQ_IDLE is
> appropriate - it's an indication that more IO will follow shortly.
> 
> And because we also set REQ_SYNC, the writeback throttle will no

s/no/now ?

> treat log IO the same way it treats direct IO writes - it will not
> throttle them at all. Hence we solve the priority inversion problem
> caused by the writeback throttle being unable to distinguish between
> high priority log IO and background metadata writeback.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_log.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
> index 6f99d6eae6a4..cf098e19967e 100644
> --- a/fs/xfs/xfs_log.c
> +++ b/fs/xfs/xfs_log.c
> @@ -1751,7 +1751,15 @@ xlog_write_iclog(
>  	iclog->ic_bio.bi_iter.bi_sector = log->l_logBBstart + bno;
>  	iclog->ic_bio.bi_end_io = xlog_bio_end_io;
>  	iclog->ic_bio.bi_private = iclog;
> -	iclog->ic_bio.bi_opf = REQ_OP_WRITE | REQ_META | REQ_SYNC | REQ_FUA;
> +
> +	/*
> +	 * We use REQ_SYNC | REQ_IDLE here to tell the block layer the are more
> +	 * IOs coming immediately after this one. This prevents the block layer
> +	 * writeback throttle from throttling log writes behind background
> +	 * metadata writeback and causing priority inversions.
> +	 */
> +	iclog->ic_bio.bi_opf = REQ_OP_WRITE | REQ_META | REQ_SYNC |
> +				REQ_IDLE | REQ_FUA;
>  	if (need_flush)
>  		iclog->ic_bio.bi_opf |= REQ_PREFLUSH;
>  
> -- 
> 2.23.0.rc1
> 
