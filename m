Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3031A83B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 17:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440910AbgDNPrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440880AbgDNPrm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:47:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5924FC061A0C;
        Tue, 14 Apr 2020 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gaNCciS1ZGObUgDnpsOAZP6AUC2c3uZoCdo1HUWts4c=; b=fhELgt4Fu4afzRcTGwnL1xPM5P
        DL/fB9skhUKTXHo7L0rXtnJJ3BHW88ia7IF+Qcl0FZOY81VT9DNxnqrpJkxH5Zn9+fLnU+2OJbZ3H
        R1GUYoKpMBmph2Iy22aWAPC7cETZpt3NhLARKn5j6QDULr2xUWxaHn2ixo9oXWa4cx7Z3nGtLMWKb
        iajZ1Iy+5ej/MFbgpKLXS1Bvz6IzCw9dwyw/9QTRsDxL0JUR9USuCXtRHkiwKSFY4iSDnBif88s4c
        uKVFWfc+ytLkNvqfq1H2oCOv35cFP3OiiDCigYwXgTFSX4HHxz6bEOEHyOHhesC5zhvY2AY6CaKkN
        Hwlj4epw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jONmX-0004QS-4h; Tue, 14 Apr 2020 15:47:25 +0000
Date:   Tue, 14 Apr 2020 08:47:25 -0700
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
Subject: Re: [PATCH 5/5] block: revert back to synchronous request_queue
 removal
Message-ID: <20200414154725.GD25765@infradead.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414041902.16769-6-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 04:19:02AM +0000, Luis Chamberlain wrote:
> Commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") merged on
> v4.12 moved the work behind blk_release_queue() into a workqueue after a
> splat floated around which indicated some work on blk_release_queue()
> could sleep in blk_exit_rl(). This splat would be possible when a driver
> called blk_put_queue() or blk_cleanup_queue() (which calls blk_put_queue()
> as its final call) from an atomic context.
> 
> blk_put_queue() decrements the refcount for the request_queue
> kobject, and upon reaching 0 blk_release_queue() is called. Although
> blk_exit_rl() is now removed through commit db6d9952356 ("block: remove
> request_list code"), we reserve the right to be able to sleep within
> blk_release_queue() context. If you see no other way and *have* be
> in atomic context when you driver calls the last blk_put_queue()
> you can always just increase your block device's reference count with
> bdgrab() as this can be done in atomic context and the request_queue
> removal would be left to upper layers later. We document this bit of
> tribal knowledge as well now, and adjust kdoc format a bit.
> 
> We revert back to synchronous request_queue removal because asynchronous
> removal creates a regression with expected userspace interaction with
> several drivers. An example is when removing the loopback driver and
> issues ioctl from userspace to do so, upon return and if successful one
> expects the device to be removed. Moving to asynchronous request_queue
> removal could have broken many scripts which relied on the removal to
> have been completed if there was no error.
> 
> Using asynchronous request_queue removal however has helped us find
> other bugs, in the future we can test what could break with this
> arrangement by enabling CONFIG_DEBUG_KOBJECT_RELEASE.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Nicolai Stange <nstange@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: yu kuai <yukuai3@huawei.com>
> Suggested-by: Nicolai Stange <nstange@suse.de>
> Fixes: dc9edc44de6c ("block: Fix a blk_exit_rl() regression")
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  block/blk-core.c       | 19 ++++++++++++++++++-
>  block/blk-sysfs.c      | 38 +++++++++++++++++---------------------
>  include/linux/blkdev.h |  2 --
>  3 files changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 5aaae7a1b338..8346c7c59ee6 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -301,6 +301,17 @@ void blk_clear_pm_only(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_clear_pm_only);
>  
> +/**
> + * blk_put_queue - decrement the request_queue refcount
> + *
> + * Decrements the refcount to the request_queue kobject, when this reaches
> + * 0 we'll have blk_release_queue() called. You should avoid calling
> + * this function in atomic context but if you really have to ensure you
> + * first refcount the block device with bdgrab() / bdput() so that the
> + * last decrement happens in blk_cleanup_queue().
> + *
> + * @q: the request_queue structure to decrement the refcount for
> + */
>  void blk_put_queue(struct request_queue *q)
>  {
>  	kobject_put(&q->kobj);
> @@ -328,10 +339,16 @@ EXPORT_SYMBOL_GPL(blk_set_queue_dying);
>  
>  /**
>   * blk_cleanup_queue - shutdown a request queue
> - * @q: request queue to shutdown
>   *
>   * Mark @q DYING, drain all pending requests, mark @q DEAD, destroy and
>   * put it.  All future requests will be failed immediately with -ENODEV.
> + *
> + * You should not call this function in atomic context. If you need to
> + * refcount a request_queue in atomic context, instead refcount the
> + * block device with bdgrab() / bdput().

I think this needs a WARN_ON thrown in to enforece the calling context.

> + *
> + * @q: request queue to shutdown

Moving the argument documentation seems against the usual kerneldoc
style.

Otherwise this look good, I hope it sticks :)
