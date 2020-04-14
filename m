Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5873B1A83A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 17:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407445AbgDNPpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 11:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440812AbgDNPpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:45:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D338C061A0C;
        Tue, 14 Apr 2020 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ErK/xbIOnOcQ7JQgeBK+2AfF1E/ypnWchFVSpWPrdt4=; b=rCxuW1p/86sqPCJASOfUAwki8t
        b7cbWNmUDJpIfDliejIewsBOQOSgsxKA+phmrHciLBwQmV4GCsket34e0ZRB64w25HeYm6jfu0YC0
        uhphBu05bHUj8T0FbLZI2n6A02TkCK6/G14E2byrP6pa1DzGiyFlVnJ/Bq4MUPcj/DxXZZPUQIgqd
        lnXUlGZ9sbDUn+ZHg3PAMmbcX0qehtty3u211+GKsk2EfUFiyjSSNR+kG/emo2OxW4eyduujosBuf
        fT9l2YKcz2YQVBzVI0BDXAqnRekanwtjcalGR4BLok6M78IPhDjTa6K17ghAW/hIPHUFy5mmp4mv4
        8vAIJz0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jONjz-0001Gk-T0; Tue, 14 Apr 2020 15:44:47 +0000
Date:   Tue, 14 Apr 2020 08:44:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 4/5] mm/swapfile: refcount block and queue before using
 blkcg_schedule_throttle()
Message-ID: <20200414154447.GC25765@infradead.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414041902.16769-5-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 04:19:01AM +0000, Luis Chamberlain wrote:
> block devices are refcounted so to ensure once its final user goes away it
> can be cleaned up by the lower layers properly. The block device's
> request_queue structure is also refcounted, however, if the last
> blk_put_queue() is called under atomic context the block layer has
> to defer removal.
> 
> By refcounting the block device during the use of blkcg_schedule_throttle(),
> we ensure ensure two things:
> 
> 1) the block device remains available during the call
> 2) we ensure avoid having to deal with the fact we're using the
>    request_queue structure in atomic context, since the last
>    blk_put_queue() will be called upon disk_release(), *after*
>    our own bdput().
> 
> This means this code path is *not* going to remove the request_queue
> structure, as we are ensuring some later upper layer disk_release()
> will be the one to release the request_queue structure for us.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Nicolai Stange <nstange@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: yu kuai <yukuai3@huawei.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mm/swapfile.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 6659ab563448..9285ff6030ca 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3753,6 +3753,7 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
>  void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
>  				  gfp_t gfp_mask)
>  {
> +	struct block_device *bdev;
>  	struct swap_info_struct *si, *next;
>  	if (!(gfp_mask & __GFP_IO) || !memcg)
>  		return;
> @@ -3771,8 +3772,17 @@ void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
>  	plist_for_each_entry_safe(si, next, &swap_avail_heads[node],
>  				  avail_lists[node]) {
>  		if (si->bdev) {
> -			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
> -						true);
> +			bdev = bdgrab(si->bdev);
> +			if (!bdev)
> +				continue;
> +			/*
> +			 * By adding our own bdgrab() we ensure the queue
> +			 * sticks around until disk_release(), and so we ensure
> +			 * our release of the request_queue does not happen in
> +			 * atomic context.
> +			 */
> +			blkcg_schedule_throttle(bdev_get_queue(bdev), true);
> +			bdput(bdev);

I don't understand the atomic part of the comment.  How does
bdgrab/bdput help us there?
