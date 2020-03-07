Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF48F17CD24
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 10:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgCGJN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Mar 2020 04:13:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11609 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbgCGJN4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Mar 2020 04:13:56 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C784D585F193C9508FCB;
        Sat,  7 Mar 2020 17:13:45 +0800 (CST)
Received: from [10.173.220.74] (10.173.220.74) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Sat, 7 Mar 2020 17:13:41 +0800
Subject: Re: [PATCH v2 3/7] bdi: protect device lifetime with RCU
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <jack@suse.cz>,
        <bvanassche@acm.org>, <tytso@mit.edu>
References: <20200226111851.55348-1-yuyufen@huawei.com>
 <20200226111851.55348-4-yuyufen@huawei.com>
 <20200304170543.GJ189690@mtj.thefacebook.com>
 <20200304172221.GA1864270@kroah.com>
 <20200304185056.GM189690@mtj.thefacebook.com>
 <20200304200559.GA1906005@kroah.com> <20200305012211.GA33199@mtj.duckdns.org>
 <20200306162547.GB3838587@kroah.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <e7e6de5b-4282-2f0e-eaa6-f8c2c0d63ea3@huawei.com>
Date:   Sat, 7 Mar 2020 17:13:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200306162547.GB3838587@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.74]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/3/7 0:25, Greg Kroah-Hartman wrote:
> On Wed, Mar 04, 2020 at 08:22:11PM -0500, Tejun Heo wrote:
>> Hello,
>>
>> On Wed, Mar 04, 2020 at 09:05:59PM +0100, Greg Kroah-Hartman wrote:
>>>> Lifetime rules in block layer are kinda nebulous. Some of it comes
>>>> from the fact that some objects are reused. Instead of the usual,
>>>> create-use-release, they get repurposed to be associated with
>>>> something else. When looking at such an object from some paths, we
>>>> don't necessarily have ownership of all of the members.
>>>
>>> That's horrid, it's not like block devices are on some "fast path" for
>>> tear-down, we should do it correctly.
>>
>> Yeah, it got retrofitted umpteenth times from the really early days. I
>> don't think much of it is intentionally designed to be this way.
>>
>>>>> backing_device_info?  Are these being destroyed/used so often that rcu
>>>>> really is the best solution and the existing reference counting doesn't
>>>>> work properly?
>>>>
>>>> It's more that there are entry points which can only ensure that just
>>>> the top level object is valid and the member objects might be going or
>>>> coming as we're looking at it.
>>>
>>> That's not ok, a "member object" can only be valid if you have a
>>> reference to it.  If you remove the object, you then drop the reference,
>>> shouldn't that be the correct thing to do?
>>
>> I mean, it depends. There are two layers of objects and the top level
>> object has two stacked lifetime rules. The "active" usage pins
>> everything as usual. The "shallower" usage only has full access to the
>> top level and when it reaches down into members it needs a different
>> mechanism to ensure its validity. Given a clean slate, I don't think
>> we'd go for this design for these objects but the usage isn't
>> fundamentally broken.
>>
>> Idk, for the problem at hand, the choice is between patching it up by
>> copying the name and RCU protecting ->dev access at least for now.
>> Both are nasty in their own ways but copying does have a smaller blast
>> radius. So, copy for now?
> 
> Yes, copy for now, don't mess with RCU and the struct device lifetime,
> that is not going to solve anything.

Okay, I will try to rework the fix by copying the name. Thanks so much for all
response and suggestion.

Thanks,
Yufen

