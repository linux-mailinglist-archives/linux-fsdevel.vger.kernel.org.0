Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231F419F251
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 11:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgDFJSR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 6 Apr 2020 05:18:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:40378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgDFJSR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:18:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2B854AC19;
        Mon,  6 Apr 2020 09:18:14 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, mhocko@suse.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [RFC 2/3] blktrace: fix debugfs use after free
References: <20200402000002.7442-1-mcgrof@kernel.org>
        <20200402000002.7442-3-mcgrof@kernel.org>
        <3640b16b-abda-5160-301a-6a0ee67365b4@acm.org>
        <b827d03c-e097-06c3-02ab-00df42b5fc0e@sandeen.net>
        <75aa4cff-1b90-ebd4-17a4-c1cb6d390b30@acm.org>
Date:   Mon, 06 Apr 2020 11:18:13 +0200
In-Reply-To: <75aa4cff-1b90-ebd4-17a4-c1cb6d390b30@acm.org> (Bart Van Assche's
        message of "Sun, 5 Apr 2020 21:25:41 -0700")
Message-ID: <87d08lj7l6.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bart Van Assche <bvanassche@acm.org> writes:

> On 2020-04-05 18:27, Eric Sandeen wrote:
>> The thing I can't figure out from reading the change log is
>> 
>> 1) what the root cause of the problem is, and
>> 2) how this patch fixes it?
>
> I think that the root cause is that do_blk_trace_setup() uses
> debugfs_lookup() and that debugfs_lookup() may return a pointer
> associated with a previous incarnation of the block device.

That's correct, the debugfs_lookup() can find a previous incarnation's
dir of the same name which is about to get removed from a not yet
schedule work.

I.e. something like the following is possible:

  LOOP_CTL_DEL(loop0) /* schedule __blk_release_queue() work_struct */
  LOOP_CTL_ADD(loop0) /* debugfs_create_dir() from
		       * blk_mq_debugfs_register() fails with EEXIST
                       */
  BLKTRACE_SETUP(loop0) /* debugfs_lookup() finds the directory about to
			 * get deleted and blktrace files will be created
			 * thereunder.
			 */

  The work_struct gets scheduled and the debugfs dir debugfs_remove()ed
  recursively, which includes the blktrace files just created. blktrace's
  dentry pointers are now dangling and there will be a UAF when it
  attempts to delete those again.

Luis' patch [2/3] fixes the issue of the debugfs_lookup() from
blk_mq_debugfs_register() potentially returning an existing directory
associated with a previous block device incarnation of the same name and
thus, fixes the UAF.


However, the problem that the debugfs_create_dir() from
blk_mq_debugfs_register() in a sequence of
  LOOP_CTL_DEL(loop0)
  LOOP_CTL_ADD(loop0)
could silently fail still remains. The RFC patch [3/3] from Luis
attempts to address this issue by folding the delayed
__blk_release_queue() work back into blk_release_queue(), the release
handler associated with the queue kobject and executed from the final
blk_queue_put(). However, that's still no full solution, because the
kobject release handler can run asynchronously, long after
blk_unregister_queue() has returned (c.f. also
CONFIG_DEBUG_KOBJECT_RELEASE).

Note that I proposed this change here (internally) as a potential
cleanup, because I missed the kobject_del() from blk_unregister_queue()
and *wrongly* concluded that blk_queue_put() must be allowed to sleep
nowadays. However, that kobject_del() is in place and moreover, the
analysis requested by Bart (c.f. [1] in this thread) revealed that there
are indeed a couple of sites calling blk_queue_put() from atomic
context.

So I'd suggest to drop patch [3/3] from this series and modify this
patch [2/3] here to move the blk_q_debugfs_unregister(q) invocation from
__blk_release_queue() to blk_unregister_queue() instead.


> Additionally, I think the following changes fix that problem by using
> q->debugfs_dir in the blktrace code instead of debugfs_lookup():

That would fix the UAF, but !queue_is_mq() queues wouldn't get a debugfs
directory created for them by blktrace anymore?


Thanks,

Nicolai

[1] https://lkml.kernel.org/r/87o8saj62m.fsf@suse.de


> [ ... ]
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -311,7 +311,6 @@ static void blk_trace_free(struct blk_trace *bt)
>  	debugfs_remove(bt->msg_file);
>  	debugfs_remove(bt->dropped_file);
>  	relay_close(bt->rchan);
> -	debugfs_remove(bt->dir);
>  	free_percpu(bt->sequence);
>  	free_percpu(bt->msg_data);
>  	kfree(bt);
> [ ... ]
> @@ -509,21 +510,19 @@ static int do_blk_trace_setup(struct request_queue
> *q, char *name, dev_t dev,
>
>  	ret = -ENOENT;
>
> -	dir = debugfs_lookup(buts->name, blk_debugfs_root);
> -	if (!dir)
> -		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> -
>  	bt->dev = dev;
>  	atomic_set(&bt->dropped, 0);
>  	INIT_LIST_HEAD(&bt->running_list);
>
>  	ret = -EIO;
> -	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
> +	bt->dropped_file = debugfs_create_file("dropped", 0444,
> +					       q->debugfs_dir, bt,
>  					       &blk_dropped_fops);
> [ ... ]
>
> Bart.

-- 
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg), GF: Felix Imendörffer
