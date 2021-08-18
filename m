Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07C03EF8CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 05:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhHRDkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 23:40:31 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:49101 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234435AbhHRDka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:40:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ujd4Stm_1629257994;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Ujd4Stm_1629257994)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Aug 2021 11:39:55 +0800
Subject: Re: [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRut5sioYfc2M1p7@redhat.com>
 <6043c0b8-0ff1-2e11-0dd0-e23f9ff6b952@linux.alibaba.com>
 <CAJfpegv01k5hEyJ3LPDWJoqB+vL8hwTan9dLu1pkkD0xoRuFzw@mail.gmail.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <1100b711-012d-d68b-7078-20eea6fa4bab@linux.alibaba.com>
Date:   Wed, 18 Aug 2021 11:39:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegv01k5hEyJ3LPDWJoqB+vL8hwTan9dLu1pkkD0xoRuFzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/17/21 10:08 PM, Miklos Szeredi wrote:
> On Tue, 17 Aug 2021 at 15:22, JeffleXu <jefflexu@linux.alibaba.com> wrote:
>>
>>
>>
>> On 8/17/21 8:39 PM, Vivek Goyal wrote:
>>> On Tue, Aug 17, 2021 at 10:06:53AM +0200, Miklos Szeredi wrote:
>>>> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>
>>>>> This patchset adds support of per-file DAX for virtiofs, which is
>>>>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
>>>>
>>>> Can you please explain the background of this change in detail?
>>>>
>>>> Why would an admin want to enable DAX for a particular virtiofs file
>>>> and not for others?
>>>
>>> Initially I thought that they needed it because they are downloading
>>> files on the fly from server. So they don't want to enable dax on the file
>>> till file is completely downloaded.
>>
>> Right, it's our initial requirement.
>>
>>
>>> But later I realized that they should
>>> be able to block in FUSE_SETUPMAPPING call and make sure associated
>>> file section has been downloaded before returning and solve the problem.
>>> So that can't be the primary reason.
>>
>> Saying we want to access 4KB of one file inside guest, if it goes
>> through FUSE request routine, then the fuse daemon only need to download
>> this 4KB from remote server. But if it goes through DAX, then the fuse
>> daemon need to download the whole DAX window (e.g., 2MB) from remote
>> server, so called amplification. Maybe we could decrease the DAX window
>> size, but it's a trade off.
> 
> That could be achieved with a plain fuse filesystem on the host (which
> will get 4k READ requests for accesses to mapped area inside guest).
> Since this can be done selectively for files which are not yet
> downloaded, the extra layer wouldn't be a performance problem.

I'm not sure if I fully understand your idea. Then in this case, host
daemon only prepares 4KB while guest thinks that the whole DAX window
(e.g., 2MB) has been fully mapped. Then when guest really accesses the
remained part (2MB - 4KB), page fault is triggered, and now host daemon
is responsible for downloading the remained part?

> 
> Is there a reason why that wouldn't work?
> 
> Thanks,
> Miklos
> 

-- 
Thanks,
Jeffle
