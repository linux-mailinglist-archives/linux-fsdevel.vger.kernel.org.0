Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4F01AB7EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 08:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407902AbgDPGZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 02:25:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46908 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407774AbgDPGZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:25:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id n24so981330plp.13;
        Wed, 15 Apr 2020 23:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yXGR4Bg7B4fWxnTesZDbA54bH8hV3HoWza1XGimfjCQ=;
        b=ij3A3+APdQJWzUcKzcLAF4WF18t5tsxqLbyZ5XxJndYYbfZYbEUsiyGj7xpUgN5n96
         aXED9mfpvKLXBw9FN/INB366/gQpXYf72ilJ9Zz322aBGjbSAQfrFI6MHmHrefLp+/h+
         THej5HCGfLWg9RBqdCjzOf8CR+2LwFvVSveg6T7UQNq1L1brDUkmJ6a+x4si1BGa4L+2
         3pX/QJW3QPLxSLYnbvLJKwP0uajeb7XmPmKOHWFGzId+/OmzEdBicgCXTE6k01Znxkjs
         bAS67Af2WJw2bawcQAKkXJ+oXGZBkGwigdtjkci7NtZ/WjkGNwAEh9rfjdgW4Dxmh2BY
         qTaA==
X-Gm-Message-State: AGi0PubxTvldvD8n3+75zyhNmYujNKXdlP5DzALZfJQuRbnZEEb6rLiD
        QeTyQNTRxKxUws/5RvSjvPo=
X-Google-Smtp-Source: APiQypK6Q94irkE310ki9D9P7Ta4hUnFoh9tC5XFqGd/hIiWcNXJbF2na+YajnIaMneHsYoGJn1tfg==
X-Received: by 2002:a17:902:7d89:: with SMTP id a9mr8415747plm.233.1587018334960;
        Wed, 15 Apr 2020 23:25:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a9sm14500113pgv.18.2020.04.15.23.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 23:25:33 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EBF4140277; Thu, 16 Apr 2020 06:25:32 +0000 (UTC)
Date:   Thu, 16 Apr 2020 06:25:32 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 4/5] mm/swapfile: refcount block and queue before using
 blkcg_schedule_throttle()
Message-ID: <20200416062532.GN11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-5-mcgrof@kernel.org>
 <20200416062222.GC2723777@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416062222.GC2723777@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 02:22:22PM +0800, Ming Lei wrote:
> On Tue, Apr 14, 2020 at 04:19:01AM +0000, Luis Chamberlain wrote:
> > block devices are refcounted so to ensure once its final user goes away it
> > can be cleaned up by the lower layers properly. The block device's
> > request_queue structure is also refcounted, however, if the last
> > blk_put_queue() is called under atomic context the block layer has
> > to defer removal.
> > 
> > By refcounting the block device during the use of blkcg_schedule_throttle(),
> > we ensure ensure two things:
> > 
> > 1) the block device remains available during the call
> > 2) we ensure avoid having to deal with the fact we're using the
> >    request_queue structure in atomic context, since the last
> >    blk_put_queue() will be called upon disk_release(), *after*
> >    our own bdput().
> > 
> > This means this code path is *not* going to remove the request_queue
> > structure, as we are ensuring some later upper layer disk_release()
> > will be the one to release the request_queue structure for us.
> > 
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Omar Sandoval <osandov@fb.com>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Nicolai Stange <nstange@suse.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: yu kuai <yukuai3@huawei.com>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  mm/swapfile.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 6659ab563448..9285ff6030ca 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3753,6 +3753,7 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
> >  void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
> >  				  gfp_t gfp_mask)
> >  {
> > +	struct block_device *bdev;
> >  	struct swap_info_struct *si, *next;
> >  	if (!(gfp_mask & __GFP_IO) || !memcg)
> >  		return;
> > @@ -3771,8 +3772,17 @@ void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
> >  	plist_for_each_entry_safe(si, next, &swap_avail_heads[node],
> >  				  avail_lists[node]) {
> >  		if (si->bdev) {
> > -			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
> > -						true);
> > +			bdev = bdgrab(si->bdev);
> 
> When swapon, the block_device has been opened in claim_swapfile(),
> so no need to worry about the queue being gone here.

Thanks, so why bdev_get_queue() before?

   Luis
