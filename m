Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC843F1320
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 08:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhHSGOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 02:14:40 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:58972 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230292AbhHSGOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 02:14:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ujyf7dO_1629353642;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Ujyf7dO_1629353642)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Aug 2021 14:14:03 +0800
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
Message-ID: <b36a4258-cba1-8185-3e23-78a7e4856fc1@linux.alibaba.com>
Date:   Thu, 19 Aug 2021 14:14:02 +0800
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
[...]
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

Empirically, some files are naturally accessed only once, such as
configuration files under /etc/ directory, .py, .js files, etc. It's the
real case that we have met in real world. While some others are most
likely accessed multiple times, such as .so libraries. With per-file DAX
feature, administrator can decide on their own which files shall be dax
enabled and thus gain most benefit from dax, while others not.

As for how we can distinguish the file access mode, besides the
intuitive insights described previously, we can develop more advanced
method distinguishing it, e.g., scanning the DAX window map and finding
the hot files. With the mechanism offered by kernel, more advanced
strategy can be developed then.

> 
> W.r.t small file, is that a real concern. If that file is being accessed
> mutliple times, then we will still see the speed gain. Only down side
> is that there is little wastage of resources because our minimum dax
> mapping granularity is 2MB. I am wondering can we handle that by
> supporting other dax mapping granularities as well. say 256K and let
> users choose it.
> 


-- 
Thanks,
Jeffle
