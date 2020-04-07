Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CF61A0508
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 04:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgDGCrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 22:47:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbgDGCrL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:47:11 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D3634CBD79F8FD698109;
        Tue,  7 Apr 2020 10:47:04 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.66) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Apr 2020
 10:47:03 +0800
Subject: Re: [RFC 0/3] block: address blktrace use-after-free
To:     Ming Lei <ming.lei@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>,
        <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <jack@suse.cz>, <nstange@suse.de>,
        <mhocko@suse.com>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200403081929.GC6887@ming.t460p>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <0e753195-72fb-ce83-16a1-176f2c3cea6a@huawei.com>
Date:   Tue, 7 Apr 2020 10:47:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200403081929.GC6887@ming.t460p>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.66]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/4/3 16:19, Ming Lei wrote:

> BTW, Yu Kuai posted one patch for this issue, looks that approach
> is simpler:
> 
> https://lore.kernel.org/linux-block/20200324132315.22133-1-yukuai3@huawei.com/
> 
> 

I think the issue might not be fixed with the patch seires.

At first, I think there are two key points for the issure:
1. The final release of queue is delayed in a workqueue
2. The creation of 'q->debugfs_dir' might failed(only if 1 exist)
And if we can fix any of the above problem, the UAF issue will be fixed.
(BTW, I did not come up with a good idea for problem 1, and my approach
is for problem 2.)

The third patch "block: avoid deferral of blk_release_queue() work" is
not enough to fix problem 1:
a. if CONFIG_DEBUG_KOBJECT_RELEASE is enable:
static void kobject_release(struct kref *kref)
{
         struct kobject *kobj = container_of(kref, struct kobject, kref);
#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
         unsigned long delay = HZ + HZ * (get_random_int() & 0x3);
         pr_info("kobject: '%s' (%p): %s, parent %p (delayed %ld)\n",
                 ©®kobject_name(kobj), kobj, __func__, kobj->parent, delay);
         INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);

         schedule_delayed_work(&kobj->release, delay);
#else
         kobject_cleanup(kobj);
#endif
}
b. when 'kobject_put' is called from blk_cleanup_queue, can we make sure
it is the last reference?

Futhermore, I do understand the second patch fix the UAF problem by
using 'q->debugfs_dir' instead of 'q->blk_trace->dir', but the problem 2
still exist and need to be fixed.

Thanks!
Yu Kuai

