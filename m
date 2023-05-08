Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4296F6FA375
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 11:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjEHJgy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 05:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjEHJgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 05:36:48 -0400
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4E4234A2
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 May 2023 02:36:44 -0700 (PDT)
Message-ID: <2098f4ba-5b36-9df9-4808-531ff1301723@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683538601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfZjgDP3qOsYzh+80NzUpeT9QjjHP7iQhKbjnDyMq5s=;
        b=OjXXp44MdsjfLCuhbn+ON8U37ykEO59nd8x5C6BOM+Tqr/Y1I0ErCcifIIOqESKJ0zLn9q
        CpdBwA7hHwJHM3bl/OVnj0Ja4HgfY4dG6IsLwyW1HC2OtsepeE1n03WodKRjNp+J8yvoqu
        4v3j43t/csF6XEqpbATxai3iNHeZc6g=
Date:   Mon, 8 May 2023 17:36:32 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] fuse: add a new flag to allow shared mmap in
 FOPEN_DIRECT_IO mode
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     fuse-devel@lists.sourceforge.net, miklos@szeredi.hu,
        bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org
References: <20230505081652.43008-1-hao.xu@linux.dev>
 <ZFVpH1n0VzNe7iVE@redhat.com>
 <ee8380b3-683f-c526-5f10-1ce2ee6f79ad@linux.dev>
In-Reply-To: <ee8380b3-683f-c526-5f10-1ce2ee6f79ad@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/6/23 13:01, Hao Xu wrote:
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
>>>       if (isdir)
>>> -        ff->open_flags &= ~FOPEN_DIRECT_IO;
>>> +        ff->open_flags &=
>>> +            ~(FOPEN_DIRECT_IO | FOPEN_DIRECT_IO_SHARED_MMAP);
>>>       ff->nodeid = nodeid;
>>> @@ -2509,8 +2510,12 @@ static int fuse_file_mmap(struct file *file, 
>>> struct vm_area_struct *vma)
>>>           return fuse_dax_mmap(file, vma);
>>>       if (ff->open_flags & FOPEN_DIRECT_IO) {
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

Bug confirmed, in FOPEN_DIRECT_IO mode, if we first private mmap a file,
then do write() syscall to the same file, the page cache page is stale. 
fuse forgets to invalidate page cache page before write().

> 
> Thanks,
> Hao
> 
>>
>> Thanks
>> Vivek
> 

