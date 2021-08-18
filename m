Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A66A3EF9EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 07:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbhHRFVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 01:21:21 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53939 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236055AbhHRFVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:21:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UjdW34i_1629264044;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UjdW34i_1629264044)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Aug 2021 13:20:44 +0800
Subject: Re: [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
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
 <YRvOZI3CvLsF96JA@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <bde1d657-0aa4-324d-064e-711efa893c2f@linux.alibaba.com>
Date:   Wed, 18 Aug 2021 13:20:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRvOZI3CvLsF96JA@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/17/21 10:57 PM, Vivek Goyal wrote:
> On Tue, Aug 17, 2021 at 09:22:53PM +0800, JeffleXu wrote:
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
> Downloading 2MB chunk should not be a big issue (IMHO). 

Then the latency increases. Latency really matters in our use case.


> And if this
> turns out to be real concern, we could experiment with a smaller
> mapping granularity.
> 


-- 
Thanks,
Jeffle
