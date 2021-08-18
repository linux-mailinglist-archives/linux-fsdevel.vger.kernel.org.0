Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB9F3EF9D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 07:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhHRFLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 01:11:34 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:40665 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231976AbhHRFLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:11:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ujd6AJ2_1629263457;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Ujd6AJ2_1629263457)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Aug 2021 13:10:57 +0800
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm>
 <CAJfpegvM+S5Xru3Yfc88C64mecvco=f99y-TajQBDfkLD-S8zQ@mail.gmail.com>
 <0896b1f6-c8c4-6071-c05b-a333c6cccacd@linux.alibaba.com>
 <YRvNnmy5Mra/AUix@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <509ea06b-27db-63f9-d32f-563f2f6c2290@linux.alibaba.com>
Date:   Wed, 18 Aug 2021 13:10:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRvNnmy5Mra/AUix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/17/21 10:54 PM, Vivek Goyal wrote:
> On Tue, Aug 17, 2021 at 09:08:35PM +0800, JeffleXu wrote:
>>
>>
>> On 8/17/21 6:09 PM, Miklos Szeredi wrote:
>>> On Tue, 17 Aug 2021 at 11:32, Dr. David Alan Gilbert
>>> <dgilbert@redhat.com> wrote:
>>>>
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
>>>
>>> If this is a performance issue, it should be fixed in a way that
>>> doesn't require hand tuning like you suggest, I think.
>>>
>>> I'm not sure what the  ext4/xfs case for per-file DAX is.  Maybe that
>>> can help understand the virtiofs case as well.
>>>
>>
>> Some hints why ext4/xfs support per-file DAX can be found [1] and [2].
>>
>> "Boaz Harrosh wondered why someone might want to turn DAX off for a
>> persistent memory device. Hellwig said that the performance "could
>> suck"; Williams noted that the page cache could be useful for some
>> applications as well. Jan Kara pointed out that reads from persistent
>> memory are close to DRAM speed, but that writes are not; the page cache
>> could be helpful for frequent writes. Applications need to change to
>> fully take advantage of DAX, Williams said; part of the promise of
>> adding a flag is that users can do DAX on smaller granularities than a
>> full filesystem."
>>
>> In summary, page cache is preferable in some cases, and thus more fine
>> grained way of DAX control is needed.
> 
> In case of virtiofs, we are using page cache on host. So this probably
> is not a factor for us. Writes will go in page cache of host.
> 
>>
>>
>> As for virtiofs, Dr. David Alan Gilbert has mentioned that various files
>> may compete for limited DAX window resource.
>>
>> Besides, supporting DAX for small files can be expensive. Small files
>> can consume DAX window resource rapidly, and if small files are accessed
>> only once, the cost of mmap/munmap on host can not be ignored.
> 
> W.r.r access pattern, same applies to large files also. So if a section
> of large file is accessed only once, it will consume dax window as well
> and will have to be reclaimed.
> 
> Dax in virtiofs provides speed gain only if map file once and access
> it multiple times. If that pattern does not hold true, then dax does
> not seem to provide speed gains and in fact might be slower than
> non-dax.
> 
> So if there is a pattern where we know some files are accessed repeatedly
> while others are not, then enabling/disabling dax selectively will make
> sense. Question is how many workloads really know that and how will
> you make that decision. Do you have any data to back that up.

There's no precise performance data yet. Empirically, small files used
to have worse performance with dax, while frequently accessed files
(such as .so libraries) behave better with dax.

> 
> W.r.t small file, is that a real concern. If that file is being accessed
> mutliple times, then we will still see the speed gain. Only down side
> is that there is little wastage of resources because our minimum dax
> mapping granularity is 2MB. I am wondering can we handle that by
> supporting other dax mapping granularities as well. say 256K and let
> users choose it.


-- 
Thanks,
Jeffle
