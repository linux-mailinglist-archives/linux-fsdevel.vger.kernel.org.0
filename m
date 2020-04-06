Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7168119EF1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 03:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgDFB1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Apr 2020 21:27:39 -0400
Received: from sandeen.net ([63.231.237.45]:56456 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgDFB1i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Apr 2020 21:27:38 -0400
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 86E7F11664;
        Sun,  5 Apr 2020 20:27:32 -0500 (CDT)
Subject: Re: [RFC 2/3] blktrace: fix debugfs use after free
To:     Bart Van Assche <bvanassche@acm.org>,
        Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de
Cc:     mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200402000002.7442-3-mcgrof@kernel.org>
 <3640b16b-abda-5160-301a-6a0ee67365b4@acm.org>
From:   Eric Sandeen <sandeen@sandeen.net>
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <b827d03c-e097-06c3-02ab-00df42b5fc0e@sandeen.net>
Date:   Sun, 5 Apr 2020 20:27:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3640b16b-abda-5160-301a-6a0ee67365b4@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/4/20 10:39 PM, Bart Van Assche wrote:
> On 2020-04-01 17:00, Luis Chamberlain wrote:
>> korg#205713 then was used to create CVE-2019-19770 and claims that
>> the bug is in a use-after-free in the debugfs core code. The
>> implications of this being a generic UAF on debugfs would be
>> much more severe, as it would imply parent dentries can sometimes
>> not be possitive, which is something claim is not possible.
>          ^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>          positive?  is there perhaps a word missing here?
> 
>> It turns out that the issue actually is a mis-use of debugfs for
>> the multiqueue case, and the fragile nature of how we free the
>> directory used to keep track of blktrace debugfs files. Omar's
>> commit assumed the parent directory would be kept with
>> debugfs_lookup() but this is not the case, only the dentry is
>> kept around. We also special-case a solution for multiqueue
>> given that for multiqueue code we always instantiate the debugfs
>> directory for the request queue. We were leaving it only to chance,
>> if someone happens to use blktrace, on single queue block devices
>> for the respective debugfs directory be created.
> 
> Since the legacy block layer is gone, the above explanation may have to
> be rephrased.
> 
>> We can fix the UAF by simply using a debugfs directory which is
>> always created for singlequeue and multiqueue block devices. This
>> simplifies the code considerably, with the only penalty now being
>> that we're always creating the request queue directory debugfs
>> directory for the block device on singlequeue block devices.
> 
> Same comment here - the legacy block layer is gone. I think that today
> all block drivers are either request-based and multiqueue or so-called
> make_request drivers. See also the output of git grep -nHw
> blk_alloc_queue for examples of the latter category.
> 
>> This patch then also contends the severity of CVE-2019-19770 as
>> this issue is only possible using root to shoot yourself in the
>> foot by also misuing blktrace.
>                ^^^^^^^
>                misusing?

Honestly I think the whole "misusing blktrace" narrative is not relevant
here; the kernel has to deal with whatever ioctls it receives, right.

The thing I can't figure out from reading the change log is

1) what the root cause of the problem is, and
2) how this patch fixes it?

>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index b3f2ba483992..bda9378eab90 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -823,9 +823,6 @@ void blk_mq_debugfs_register(struct request_queue *q)
>>  	struct blk_mq_hw_ctx *hctx;
>>  	int i;
>>  
>> -	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
>> -					    blk_debugfs_root);
>> -
>>  	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
>>  
>>  	/*
> 
> [ ... ]
> 
>>  static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index fca9b158f4a0..20f20b0fa0b9 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -895,6 +895,7 @@ static void __blk_release_queue(struct work_struct *work)
>>  
>>  	blk_trace_shutdown(q);
>>  
>> +	blk_q_debugfs_unregister(q);
>>  	if (queue_is_mq(q))
>>  		blk_mq_debugfs_unregister(q);
> 
> Does this patch change the behavior of the block layer from only
> registering a debugfs directory for request-based block devices to
> registering a debugfs directory for request-based and make_request based
> block devices? Is that behavior change an intended behavior change?

Seems to be:

"This simplifies the code considerably, with the only penalty now being
that we're always creating the request queue directory debugfs
directory for the block device on singlequeue block devices."

?

-Eric

