Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F129BBD9A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 10:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437609AbfIYIPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 04:15:35 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:54580 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437303AbfIYIPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:15:35 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id B38152E14FF;
        Wed, 25 Sep 2019 11:15:31 +0300 (MSK)
Received: from myt4-4db2488e778a.qloud-c.yandex.net (myt4-4db2488e778a.qloud-c.yandex.net [2a02:6b8:c00:884:0:640:4db2:488e])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id PLUDrWnc5m-FU2CcNFu;
        Wed, 25 Sep 2019 11:15:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1569399331; bh=HF6YUnXbxku3Mhtk3A5NH7rcf030Ym9OwhuMB5F9CyI=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=y/ntVFSQHlcgQ8zEapV79qFKiGZ+Jy6AHoiw9NXCPRGwQHb9EzewdMzr1WYCCkICD
         HZpjFFFbNUDZeJ/gWjf3UZk35n4F+xSYtJFiWnvFdD3qDwL0a8UZdp62LTskjVAAp8
         ZlFX7DlZJz9fH8S5PRLvDE0B86JRY4hDZNUmCFSY=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by myt4-4db2488e778a.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id rDiuIcqJka-FUIKcAUR;
        Wed, 25 Sep 2019 11:15:30 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
To:     Dave Chinner <david@fromorbit.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <875f3b55-4fe1-e2c3-5bee-ca79e4668e72@yandex-team.ru>
 <20190923145242.GF2233839@devbig004.ftw2.facebook.com>
 <ed5d930c-88c6-c8e4-4a6c-529701caa993@yandex-team.ru>
 <20190924073940.GM6636@dread.disaster.area>
 <edafed8a-5269-1e54-fe31-7ba87393eb34@yandex-team.ru>
 <20190925071854.GC804@dread.disaster.area>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <aeede806-db6b-3e94-3fed-60af5481e0d3@yandex-team.ru>
Date:   Wed, 25 Sep 2019 11:15:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925071854.GC804@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25/09/2019 10.18, Dave Chinner wrote:
> On Tue, Sep 24, 2019 at 12:00:17PM +0300, Konstantin Khlebnikov wrote:
>> On 24/09/2019 10.39, Dave Chinner wrote:
>>> On Mon, Sep 23, 2019 at 06:06:46PM +0300, Konstantin Khlebnikov wrote:
>>>> On 23/09/2019 17.52, Tejun Heo wrote:
>>>>> Hello, Konstantin.
>>>>>
>>>>> On Fri, Sep 20, 2019 at 10:39:33AM +0300, Konstantin Khlebnikov wrote:
>>>>>> With vm.dirty_write_behind 1 or 2 files are written even faster and
>>>>>
>>>>> Is the faster speed reproducible?  I don't quite understand why this
>>>>> would be.
>>>>
>>>> Writing to disk simply starts earlier.
>>>
>>> Stupid question: how is this any different to simply winding down
>>> our dirty writeback and throttling thresholds like so:
>>>
>>> # echo $((100 * 1000 * 1000)) > /proc/sys/vm/dirty_background_bytes
>>>
>>> to start background writeback when there's 100MB of dirty pages in
>>> memory, and then:
>>>
>>> # echo $((200 * 1000 * 1000)) > /proc/sys/vm/dirty_bytes
>>>
>>> So that writers are directly throttled at 200MB of dirty pages in
>>> memory?
>>>
>>> This effectively gives us global writebehind behaviour with a
>>> 100-200MB cache write burst for initial writes.
>>
>> Global limits affect all dirty pages including memory-mapped and
>> randomly touched. Write-behind aims only into sequential streams.
> 
> There are  apps that do sequential writes via mmap()d files.
> They should do writebehind too, yes?

I see no reason for that. This is different scenario.

Mmap have no clear signal about "end of write", only page fault at
beginning. Theoretically we could implement similar sliding window and
start writeback on consequent page faults.

But applications who use memory mapped files probably knows better what
to do with this data. I prefer to leave them alone for now.

> 
>>> ANd, really such strict writebehind behaviour is going to cause all
>>> sorts of unintended problesm with filesystems because there will be
>>> adverse interactions with delayed allocation. We need a substantial
>>> amount of dirty data to be cached for writeback for fragmentation
>>> minimisation algorithms to be able to do their job....
>>
>> I think most sequentially written files never change after close.
> 
> There are lots of apps that write zeros to initialise and allocate
> space, then go write real data to them. Database WAL files are
> commonly initialised like this...

Those zeros are just bunch of dirty pages which have to be written.
Sync and memory pressure will do that, why write-behind don't have to?

> 
>> Except of knowing final size of huge files (>16Mb in my patch)
>> there should be no difference for delayed allocation.
> 
> There is, because you throttle the writes down such that there is
> only 16MB of dirty data in memory. Hence filesystems will only
> typically allocate in 16MB chunks as that's all the delalloc range
> spans.
> 
> I'm not so concerned for XFS here, because our speculative
> preallocation will handle this just fine, but for ext4 and btrfs
> it's going to interleave the allocate of concurrent streaming writes
> and fragment the crap out of the files.
> 
> In general, the smaller you make the individual file writeback
> window, the worse the fragmentation problems gets....

AFAIR ext4 already preallocates extent beyond EOF too.

But this must be carefully tested for all modern fs for sure.

> 
>> Probably write behind could provide hint about streaming pattern:
>> pass something like "MSG_MORE" into writeback call.
> 
> How does that help when we've only got dirty data and block
> reservations up to EOF which is no more than 16MB away?

Block allocator should interpret this flags as "more data are
expected" and preallocate extent bigger than data and beyond EOF.

> 
> Cheers,
> 
> Dave.
> 
