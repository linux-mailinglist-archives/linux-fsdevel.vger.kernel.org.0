Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CE5BC45F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbfIXJAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 05:00:23 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:41214 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729588AbfIXJAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:00:22 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id CD2CF2E1318;
        Tue, 24 Sep 2019 12:00:18 +0300 (MSK)
Received: from sas2-62907d92d1d8.qloud-c.yandex.net (sas2-62907d92d1d8.qloud-c.yandex.net [2a02:6b8:c08:b895:0:640:6290:7d92])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id kRCekL2Kks-0HLSQhvt;
        Tue, 24 Sep 2019 12:00:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1569315618; bh=XWcumQ6LEVVd+nqcjbDRZkT8POGeVs8ZdFkLhiZbTSI=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=hMBfVPo+LVt6lT9a9TMgtbPb13atRa5vC0BbTPaJPzZQEvlN5VYzXH8xP62mYkBVm
         3bkgWYVMffqI4hoMwA+tbFvjJyemGfPUDhrdVumO9hCFnEtAaeRf8GYdTe59TMEC15
         0u/G5ED+L8iRCekkV4E5ujHsjZrWLjLibN01StJo=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by sas2-62907d92d1d8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id XQYXi9VcIO-0HH8Sl58;
        Tue, 24 Sep 2019 12:00:17 +0300
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
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <edafed8a-5269-1e54-fe31-7ba87393eb34@yandex-team.ru>
Date:   Tue, 24 Sep 2019 12:00:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924073940.GM6636@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24/09/2019 10.39, Dave Chinner wrote:
> On Mon, Sep 23, 2019 at 06:06:46PM +0300, Konstantin Khlebnikov wrote:
>> On 23/09/2019 17.52, Tejun Heo wrote:
>>> Hello, Konstantin.
>>>
>>> On Fri, Sep 20, 2019 at 10:39:33AM +0300, Konstantin Khlebnikov wrote:
>>>> With vm.dirty_write_behind 1 or 2 files are written even faster and
>>>
>>> Is the faster speed reproducible?  I don't quite understand why this
>>> would be.
>>
>> Writing to disk simply starts earlier.
> 
> Stupid question: how is this any different to simply winding down
> our dirty writeback and throttling thresholds like so:
> 
> # echo $((100 * 1000 * 1000)) > /proc/sys/vm/dirty_background_bytes
> 
> to start background writeback when there's 100MB of dirty pages in
> memory, and then:
> 
> # echo $((200 * 1000 * 1000)) > /proc/sys/vm/dirty_bytes
> 
> So that writers are directly throttled at 200MB of dirty pages in
> memory?
> 
> This effectively gives us global writebehind behaviour with a
> 100-200MB cache write burst for initial writes.

Global limits affect all dirty pages including memory-mapped and
randomly touched. Write-behind aims only into sequential streams.

> 
> ANd, really such strict writebehind behaviour is going to cause all
> sorts of unintended problesm with filesystems because there will be
> adverse interactions with delayed allocation. We need a substantial
> amount of dirty data to be cached for writeback for fragmentation
> minimisation algorithms to be able to do their job....

I think most sequentially written files never change after close.
Except of knowing final size of huge files (>16Mb in my patch)
there should be no difference for delayed allocation.

Probably write behind could provide hint about streaming pattern:
pass something like "MSG_MORE" into writeback call.

> 
> Cheers,
> 
> Dave.
> 
