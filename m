Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2E01AB5F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 04:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbgDPChA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 22:37:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24935 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387983AbgDPCg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587004614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wsXQwfnrCmj0LGzc/sAnLb44iyzxNI7JAf2YStv+s3s=;
        b=N28HWfbxAv+MKqcISec+4KFLy5SJuIvclxmrr5V2dr8rBbSCeKfKkqXR/nMxgs7GotFVlu
        BoEGNkE/KqPpI3rhVnOErS2Znq4a//KK0pFTpyW7nSFxvn9FzPHBy6AylqzbIxHLWAKb0M
        R6xIdJPFDaYKNJsKlhtNJ0xBHH6xxFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-cHKJsk4HMgyqSWDUe5ploQ-1; Wed, 15 Apr 2020 22:36:50 -0400
X-MC-Unique: cHKJsk4HMgyqSWDUe5ploQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9614D8024DA;
        Thu, 16 Apr 2020 02:36:47 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32C575C1D4;
        Thu, 16 Apr 2020 02:36:33 +0000 (UTC)
Date:   Thu, 16 Apr 2020 10:36:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 5/5] block: revert back to synchronous request_queue
 removal
Message-ID: <20200416023629.GC2717677@T590>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414041902.16769-6-mcgrof@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
> + *
> + * @q: request queue to shutdown
> + *
>   */
>  void blk_cleanup_queue(struct request_queue *q)
>  {
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 0285d67e1e4c..859911191ebc 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -860,22 +860,27 @@ static void blk_exit_queue(struct request_queue *q)
>  	bdi_put(q->backing_dev_info);
>  }
>  
> -
>  /**
> - * __blk_release_queue - release a request queue
> - * @work: pointer to the release_work member of the request queue to be released
> + * blk_release_queue - release a request queue
> + *
> + * This function is called as part of the process when a block device is being
> + * unregistered. Releasing a request queue starts with blk_cleanup_queue(),
> + * which set the appropriate flags and then calls blk_put_queue() as the last
> + * step. blk_put_queue() decrements the reference counter of the request queue
> + * and once the reference counter reaches zero, this function is called to
> + * release all allocated resources of the request queue.
>   *
> - * Description:
> - *     This function is called when a block device is being unregistered. The
> - *     process of releasing a request queue starts with blk_cleanup_queue, which
> - *     set the appropriate flags and then calls blk_put_queue, that decrements
> - *     the reference counter of the request queue. Once the reference counter
> - *     of the request queue reaches zero, blk_release_queue is called to release
> - *     all allocated resources of the request queue.
> + * This function can sleep, and so we must ensure that the very last
> + * blk_put_queue() is never called from atomic context.
> + *
> + * @kobj: pointer to a kobject, who's container is a request_queue
>   */
> -static void __blk_release_queue(struct work_struct *work)
> +static void blk_release_queue(struct kobject *kobj)
>  {
> -	struct request_queue *q = container_of(work, typeof(*q), release_work);
> +	struct request_queue *q =
> +		container_of(kobj, struct request_queue, kobj);
> +
> +	might_sleep();
>  
>  	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
>  		blk_stat_remove_callback(q, q->poll_cb);
> @@ -905,15 +910,6 @@ static void __blk_release_queue(struct work_struct *work)
>  	call_rcu(&q->rcu_head, blk_free_queue_rcu);
>  }
>  
> -static void blk_release_queue(struct kobject *kobj)
> -{
> -	struct request_queue *q =
> -		container_of(kobj, struct request_queue, kobj);
> -
> -	INIT_WORK(&q->release_work, __blk_release_queue);
> -	schedule_work(&q->release_work);
> -}
> -
>  static const struct sysfs_ops queue_sysfs_ops = {
>  	.show	= queue_attr_show,
>  	.store	= queue_attr_store,
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index cc43c8e6516c..81f7ddb1587e 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -582,8 +582,6 @@ struct request_queue {
>  
>  	size_t			cmd_size;
>  
> -	struct work_struct	release_work;
> -
>  #define BLK_MAX_WRITE_HINTS	5
>  	u64			write_hints[BLK_MAX_WRITE_HINTS];
>  };
> -- 
> 2.25.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

