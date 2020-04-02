Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A9719C4B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 16:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbgDBOtm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 2 Apr 2020 10:49:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:34210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388516AbgDBOtm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:49:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 408ACAED9;
        Thu,  2 Apr 2020 14:49:39 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, mhocko@suse.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC 3/3] block: avoid deferral of blk_release_queue() work
References: <20200402000002.7442-1-mcgrof@kernel.org>
        <20200402000002.7442-4-mcgrof@kernel.org>
        <774a33e8-43ba-143f-f6fd-9cb0ae0862ac@acm.org>
Date:   Thu, 02 Apr 2020 16:49:37 +0200
In-Reply-To: <774a33e8-43ba-143f-f6fd-9cb0ae0862ac@acm.org> (Bart Van Assche's
        message of "Wed, 1 Apr 2020 20:39:48 -0700")
Message-ID: <87o8saj62m.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bart Van Assche <bvanassche@acm.org> writes:

> On 2020-04-01 17:00, Luis Chamberlain wrote:
>> Commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") moved
>> the blk_release_queue() into a workqueue after a splat floated around
>> with some work here which could sleep in blk_exit_rl().
>> 
>> On recent commit db6d9952356 ("block: remove request_list code") though
>> Jens Axboe removed this code, now merged since v5.0. We no longer have
>> to defer this work.
>> 
>> By doing this we also avoid failing to detach / attach a block
>> device with a BLKTRACESETUP. This issue can be reproduced with
>> break-blktrace [0] using:
>> 
>>   break-blktrace -c 10 -d -s
>> 
>> The kernel does not crash without this commit, it just fails to
>> create the block device because the prior block device removal
>> deferred work is pending. After this commit we can use the above
>> flaky use of blktrace without an issue.
>> 
>> [0] https://github.com/mcgrof/break-blktrace
>> 
>> Cc: Bart Van Assche <bvanassche@acm.org>
>> Cc: Omar Sandoval <osandov@fb.com>
>> Cc: Hannes Reinecke <hare@suse.com>
>> Cc: Nicolai Stange <nstange@suse.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Suggested-by: Nicolai Stange <nstange@suse.de>
>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>  block/blk-sysfs.c | 18 +++++-------------
>>  1 file changed, 5 insertions(+), 13 deletions(-)
>> 
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 20f20b0fa0b9..f159b40899ee 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -862,8 +862,8 @@ static void blk_exit_queue(struct request_queue *q)
>>  
>>  
>>  /**
>> - * __blk_release_queue - release a request queue
>> - * @work: pointer to the release_work member of the request queue to be released
>> + * blk_release_queue - release a request queue
>> + * @kojb: pointer to the kobj representing the request queue
>>   *
>>   * Description:
>>   *     This function is called when a block device is being unregistered. The
>> @@ -873,9 +873,10 @@ static void blk_exit_queue(struct request_queue *q)
>>   *     of the request queue reaches zero, blk_release_queue is called to release
>>   *     all allocated resources of the request queue.
>>   */
>> -static void __blk_release_queue(struct work_struct *work)
>> +static void blk_release_queue(struct kobject *kobj)
>>  {
>> -	struct request_queue *q = container_of(work, typeof(*q), release_work);
>> +	struct request_queue *q =
>> +		container_of(kobj, struct request_queue, kobj);
>>  
>>  	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
>>  		blk_stat_remove_callback(q, q->poll_cb);
>> @@ -905,15 +906,6 @@ static void __blk_release_queue(struct work_struct *work)
>>  	call_rcu(&q->rcu_head, blk_free_queue_rcu);
>>  }
>>  
>> -static void blk_release_queue(struct kobject *kobj)
>> -{
>> -	struct request_queue *q =
>> -		container_of(kobj, struct request_queue, kobj);
>> -
>> -	INIT_WORK(&q->release_work, __blk_release_queue);
>> -	schedule_work(&q->release_work);
>> -}
>> -
>>  static const struct sysfs_ops queue_sysfs_ops = {
>>  	.show	= queue_attr_show,
>>  	.store	= queue_attr_store,
>
> The description of this patch mentions a single blk_release_queue() call
> that happened in the past from a context from which sleeping is not
> allowed and from which sleeping is allowed today. Have all other
> blk_release_queue() / blk_put_queue() calls been verified to see whether
> none of these happens from a context from which sleeping is not allowed?

I've just done this today and found the following potentially
problematic call paths to blk_put_queue().

1.) mem_cgroup_throttle_swaprate() takes a spinlock and
    calls blkcg_schedule_throttle()->blk_put_queue().

    Also note that AFAICS mem_cgroup_try_charge_delay() can be called
    with GFP_ATOMIC.

2.) scsi_unblock_requests() gets called from a lot of drivers and
    invoke blk_put_queue() through
    scsi_unblock_requests() -> scsi_run_host_queues() ->
    scsi_starved_list_run() -> blk_put_queue().

    Most call sites are fine, the ones which are not are:
    a.) pmcraid_complete_ioa_reset(). This gets assigned
        to struct pmcraid_cmd's ->cmd_done and later invoked
        under a spinlock.

    b.) qla82xx_fw_dump() and qla8044_fw_dump().
        These can potentially block w/o this patch already,
        because both invoke qla2x00_wait_for_chip_reset().

	However, they can get called from IRQ context. For example,
        qla82xx_intr_handler(), qla82xx_msix_default() and
        qla82xx_poll() call qla2x00_async_event(), which calls
        ->fw_dump().

	The aforementioned functions can also reach ->fw_dump() through
        qla24xx_process_response_queue()->qlt_handle_abts_recv()->qlt_response_pkt_all_vps()
        ->qlt_response_pkt()->qlt_handle_abts_completion()->qlt_chk_unresolv_exchg()
        -> ->fw_dump().

	But I'd consider this a problem with the driver -- either
	->fw_dump() can sleep and must not be called from IRQ context
        or they must not invoke qla2x00_wait_for_hba_ready().


(I can share the full analysis, but it's lengthy and contains nothing
 interesting except for what is listed above).


One final note though: If I'm not mistaken, then the final
blk_put_queue() can in principle block even today, simply by virtue of
the kernfs operations invoked through
kobject_put()->kobject_release()->kobject_cleanup()->kobject_del()
->sysfs_remove_dir()->kernfs_remove()->mutex_lock()?


Thanks,

Nicolai

-- 
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg), GF: Felix Imendörffer
