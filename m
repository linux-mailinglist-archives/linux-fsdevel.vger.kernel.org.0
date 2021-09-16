Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55D140D465
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 10:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhIPIXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 04:23:23 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:49742 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235005AbhIPIXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:23:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UoZbq6m_1631780519;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UoZbq6m_1631780519)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Sep 2021 16:22:00 +0800
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To:     Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, Liu Bo <bo.liu@linux.alibaba.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm> <YRuuRo8jEs5dkfw9@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <299689e9-bdeb-a715-3f31-8c70369cf0ba@linux.alibaba.com>
Date:   Thu, 16 Sep 2021 16:21:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YRuuRo8jEs5dkfw9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, I add some performance statistics below.


On 8/17/21 8:40 PM, Vivek Goyal wrote:
> On Tue, Aug 17, 2021 at 10:32:14AM +0100, Dr. David Alan Gilbert wrote:
>> * Miklos Szeredi (miklos@szeredi.hu) wrote:
>>> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>>>>
>>>> This patchset adds support of per-file DAX for virtiofs, which is
>>>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
>>>
>>> Can you please explain the background of this change in detail?
>>>
>>> Why would an admin want to enable DAX for a particular virtiofs file
>>> and not for others?
>>
>> Where we're contending on virtiofs dax cache size it makes a lot of
>> sense; it's quite expensive for us to map something into the cache
>> (especially if we push something else out), so selectively DAXing files
>> that are expected to be hot could help reduce cache churn.

Yes, the performance of dax can be limited when the DAX window is
limited, where dax window may be contended by multiple files.

I tested kernel compiling in virtiofs, emulating the scenario where a
lot of files contending dax window and triggering dax window reclaiming.

Environment setup:
- guest vCPU: 16
- time make vmlinux -j128

type    | cache  | cache-size | time
------- | ------ | ---------- | ----
non-dax | always |   --       | real 2m48.119s
dax     | always | 64M        | real 4m49.563s
dax     | always |   1G       | real 3m14.200s
dax     | always |   4G       | real 2m41.141s


It can be seen that there's performance drop, comparing to the normal
buffered IO, when dax window resource is restricted and dax window
relcaiming is triggered. The smaller the cache size is, the worse the
performance is. The performance drop can be alleviated and eliminated as
cache size increases.

Though we may not compile kernel in virtiofs, indeed we may access a lot
of small files in virtiofs and suffer this performance drop.


> In that case probaly we should just make DAX window larger. I assume

Yes, as the DAX window gets larger, it is less likely that we can run
short of dax window resource.

However it doesn't come without cost. 'struct page' descriptor for dax
window will consume guest memory at a ratio of ~1.5% (64/4096 = ~1.5%,
page descriptor is of 64 bytes size, assuming 4K sized page). That is,
every 1GB cache size will cost 16MB guest memory. As the cache size
increases, the memory footprint for page descriptors also increases,
which may offset the benefit of dax by eliminating guest page cache.

In summary, per-file dax feature tries to achieve a balance between
performance and memory overhead, by offering a finer gained control for
dax to users.


> that selecting which files to turn DAX on, will itself will not be
> a trivial. Not sure what heuristics are being deployed to determine
> that. Will like to know more about it.

Currently we enable dax for hot and large blob files, while disabling
dax for other miscellaneous small files.



-- 
Thanks,
Jeffle
