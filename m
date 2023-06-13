Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4848972D789
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 04:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbjFMC5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 22:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbjFMC5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:57:04 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854ED172A
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 19:57:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vl0D7Sf_1686625017;
Received: from 30.221.148.254(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vl0D7Sf_1686625017)
          by smtp.aliyun-inc.com;
          Tue, 13 Jun 2023 10:56:58 +0800
Message-ID: <cdb8f5d4-5a47-4c17-9f9c-8de24aede4c5@linux.alibaba.com>
Date:   Tue, 13 Jun 2023 10:56:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] fuse: add a new flag to allow shared mmap in
 FOPEN_DIRECT_IO mode
Content-Language: en-US
To:     Hao Xu <hao.xu@linux.dev>, Vivek Goyal <vgoyal@redhat.com>
Cc:     fuse-devel@lists.sourceforge.net, miklos@szeredi.hu,
        bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org
References: <20230505081652.43008-1-hao.xu@linux.dev>
 <ZFVpH1n0VzNe7iVE@redhat.com>
 <ee8380b3-683f-c526-5f10-1ce2ee6f79ad@linux.dev>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <ee8380b3-683f-c526-5f10-1ce2ee6f79ad@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/6/23 1:01 PM, Hao Xu wrote:
> Hi Vivek,
> 
> On 5/6/23 04:37, Vivek Goyal wrote:
>> On Fri, May 05, 2023 at 04:16:52PM +0800, Hao Xu wrote:
>>> From: Hao Xu <howeyxu@tencent.com>
>>>
>>> FOPEN_DIRECT_IO is usually set by fuse daemon to indicate need of strong
>>> coherency, e.g. network filesystems. Thus shared mmap is disabled since
>>> it leverages page cache and may write to it, which may cause
>>> inconsistence. But FOPEN_DIRECT_IO can be used not for coherency but to
>>> reduce memory footprint as well, e.g. reduce guest memory usage with
>>> virtiofs. Therefore, add a new flag FOPEN_DIRECT_IO_SHARED_MMAP to allow
>>> shared mmap for these cases.
>>>
>>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>>> ---
>>>   fs/fuse/file.c            | 11 ++++++++---
>>>   include/uapi/linux/fuse.h |  2 ++
>>>   2 files changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index 89d97f6188e0..655896bdb0d5 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -161,7 +161,8 @@ struct fuse_file *fuse_file_open(struct
>>> fuse_mount *fm, u64 nodeid,
>>>       }
>>>         if (isdir)
>>> -        ff->open_flags &= ~FOPEN_DIRECT_IO;
>>> +        ff->open_flags &=
>>> +            ~(FOPEN_DIRECT_IO | FOPEN_DIRECT_IO_SHARED_MMAP);
>>>         ff->nodeid = nodeid;
>>>   @@ -2509,8 +2510,12 @@ static int fuse_file_mmap(struct file *file,
>>> struct vm_area_struct *vma)
>>>           return fuse_dax_mmap(file, vma);
>>>         if (ff->open_flags & FOPEN_DIRECT_IO) {
>>> -        /* Can't provide the coherency needed for MAP_SHARED */
>>> -        if (vma->vm_flags & VM_MAYSHARE)
>>> +        /* Can't provide the coherency needed for MAP_SHARED.
>>> +         * So disable it if FOPEN_DIRECT_IO_SHARED_MMAP is not
>>> +         * set, which means we do need strong coherency.
>>> +         */
>>> +        if (!(ff->open_flags & FOPEN_DIRECT_IO_SHARED_MMAP) &&
>>> +            vma->vm_flags & VM_MAYSHARE)
>>>               return -ENODEV;
>>
>> Can you give an example how this is useful and how do you plan to
>> use it?
>>
>> If goal is not using guest cache (either for saving memory or for cache
>> coherency with other clients) and hence you used FOPEN_DIRECT_IO,
>> then by allowing page cache for mmap(), we are contracting that goal.
>> We are neither saving memory and at the same time we are not
>> cache coherent.
> 
> We use it to reduce guest memory "as possible as we can", which means we
> first have to ensure the functionality so shared mmap should work when
> users call it, then second reduce memory when users use read/write
> (from/to other files).
> 
> In cases where users do read/write in most time and calls shared mmap
> sometimes, disabling shared mmap makes this case out of service, but
> with this flag we still reduce memory and the application works.
> 
>>
>> IIUC, for virtiofs, you want to use cache=none but at the same time
>> allow guest applications to do shared mmap() hence you are introducing
>> this change. There have been folks who have complained about it
>> and I think 9pfs offers a mode which does this. So solving this
>> problem will be nice.
>>
>> BTW, if "-o dax" is used, it solves this problem. But unfortunately qemu
>> does not have DAX support yet and we also have issues with page
>> truncation
>> on host and MCE not travelling into the guest. So DAX is not a perfect
>> option yet.
> 
> Yea, just like I relied in another mail, users' IO pattern may be a
> bunch of small IO to a bunch of small files, dax may help but not so
> much in that case.
> 
>>
>> I agree that solving this problem will be nice. Just trying to
>> understand the behavior better. How these cache pages will
>> interact with read/write?
> 
> I went through the code, it looks like there are issues when users mmap
> a file and then write to it, this may cause coherency problem between
> the backend file and the frontend page cache.
> I think this problem exists before this patchset: when we private mmap
> a file and then write to it in FOPEN_DIRECT_IO mode, the change doesn't
> update to the page cache because we falsely assume there is no page
> cache under FOPEN_DIRECT_IO mode. I need to go over the code and do some
> test to see if it is really there and to solve it.

IIUC, I guess the current read/write routine will still initiate DIRECT
IO to server in FOPEN_DIRECT_IO mode, even there's page cache initiated
by shared mmap?

Private mmap doesn't need to care about the coherency issue, as private
mmap is private and doesn't need to be flushed to server.  Thus IMHO the
weakened DIRECT_IO, or dio_shared_mmap mode only applies to scenarios
where strong coherency is not needed.

-- 
Thanks,
Jingbo
