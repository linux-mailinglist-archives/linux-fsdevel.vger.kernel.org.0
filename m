Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087FF414371
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 10:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhIVIRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 04:17:49 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37898 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233427AbhIVIRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:17:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UpCviSN_1632298576;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UpCviSN_1632298576)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Sep 2021 16:16:17 +0800
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, Liu Bo <bo.liu@linux.alibaba.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm> <YRuuRo8jEs5dkfw9@redhat.com>
 <299689e9-bdeb-a715-3f31-8c70369cf0ba@linux.alibaba.com>
 <YUeTP1B+JE5gGudq@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <ef66622c-586c-81e0-86a6-85e01af316c2@linux.alibaba.com>
Date:   Wed, 22 Sep 2021 16:16:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUeTP1B+JE5gGudq@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the replying and suggesting. ;)


On 9/20/21 3:45 AM, Vivek Goyal wrote:
> On Thu, Sep 16, 2021 at 04:21:59PM +0800, JeffleXu wrote:
>> Hi, I add some performance statistics below.
>>
>>
>> On 8/17/21 8:40 PM, Vivek Goyal wrote:
>>> On Tue, Aug 17, 2021 at 10:32:14AM +0100, Dr. David Alan Gilbert wrote:
>>>> * Miklos Szeredi (miklos@szeredi.hu) wrote:
>>>>> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>>
>>>>>> This patchset adds support of per-file DAX for virtiofs, which is
>>>>>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
>>>>>
>>>>> Can you please explain the background of this change in detail?
>>>>>
>>>>> Why would an admin want to enable DAX for a particular virtiofs file
>>>>> and not for others?
>>>>
>>>> Where we're contending on virtiofs dax cache size it makes a lot of
>>>> sense; it's quite expensive for us to map something into the cache
>>>> (especially if we push something else out), so selectively DAXing files
>>>> that are expected to be hot could help reduce cache churn.
>>
>> Yes, the performance of dax can be limited when the DAX window is
>> limited, where dax window may be contended by multiple files.
>>
>> I tested kernel compiling in virtiofs, emulating the scenario where a
>> lot of files contending dax window and triggering dax window reclaiming.
>>
>> Environment setup:
>> - guest vCPU: 16
>> - time make vmlinux -j128
>>
>> type    | cache  | cache-size | time
>> ------- | ------ | ---------- | ----
>> non-dax | always |   --       | real 2m48.119s
>> dax     | always | 64M        | real 4m49.563s
>> dax     | always |   1G       | real 3m14.200s
>> dax     | always |   4G       | real 2m41.141s
>>
>>
>> It can be seen that there's performance drop, comparing to the normal
>> buffered IO, when dax window resource is restricted and dax window
>> relcaiming is triggered. The smaller the cache size is, the worse the
>> performance is. The performance drop can be alleviated and eliminated as
>> cache size increases.
>>
>> Though we may not compile kernel in virtiofs, indeed we may access a lot
>> of small files in virtiofs and suffer this performance drop.
> 
> Hi Jeffle,
> 
> If you access lot of big files or a file bigger than dax window, still
> you will face performance drop due to reclaim. IOW, if data being
> accessed is bigger than dax window, then reclaim will trigger and
> performance drop will be observed. So I think its not fair to assciate
> performance drop with big for small files as such.

Yes, it is. Actually what I mean is that small files (with size smaller
than dax window chunk size) is more likely to consume more dax windows
compared to large files, under the same total file size.


> 
> What makes more sense is that memomry usage argument you have used
> later in the email. That is, we have a fixed chunk size of 2MB. And
> that means we use 512 * 64 = 32K of memory per chunk. So if a file
> is smaller than 32K in size, it might be better to just access it
> without DAX and incur the cost of page cache in guest instead. Even this
> argument also works only if dax window is being utilized fully.

Yes, agreed. In this case, the meaning of per-file dax is that, admin
could control the size of overall dax window under a limited number,
while still sustaining a reasonable performance. But at least, users are
capable of tuning it now.

> 
> Anyway, I think Miklos already asked you to send patches so that
> virtiofs daemon specifies which file to use dax on. So are you
> planning to post patches again for that. (And drop patches to
> read dax attr from per inode from filesystem in guest).

OK. I will send a new version, disabling dax based on the file size on
the host daemon side. Besides, I'm afraid the negotiation phase is also
not needed anymore, since currently the hint whether dax shall be
enabled or not is completely feeded from host daemon, and the guest side
needn't set/clear per inode dax attr now.

-- 
Thanks,
Jeffle
