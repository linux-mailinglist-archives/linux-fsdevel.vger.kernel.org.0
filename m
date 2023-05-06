Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56516F8F9C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 09:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjEFHDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 03:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFHDu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 03:03:50 -0400
Received: from out-45.mta0.migadu.com (out-45.mta0.migadu.com [91.218.175.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2482AAD18
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 00:03:47 -0700 (PDT)
Message-ID: <92595369-f378-b6ac-915f-f046921f1d59@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683356625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=deTRnT6majvqIcbAA4+aeFpwQgLJ+x+hzmknl6pAYWg=;
        b=lpXoWT8Rgg5cYt9zL3+V07fUC7Hyok/3z3LrVWFQKpd2sZAfPWoPj+7s6kdUjdGr39ETrP
        FwAJ7xjCvaHdyiGC/nKrWxRvg7ulpePQJpH7kBSm9/HFfolu4qY2atbbwqYl9zVkexNtWH
        MAeOoJLJIr73C6FEREQ7R1+zp2fR7T8=
Date:   Sat, 6 May 2023 15:03:38 +0800
MIME-Version: 1.0
Subject: Re: [fuse-devel] [PATCH] fuse: add a new flag to allow shared mmap in
 FOPEN_DIRECT_IO mode
Content-Language: en-US
To:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        fuse-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
References: <20230505081652.43008-1-hao.xu@linux.dev>
 <fc6fe539-64ae-aa35-8b6e-3b22e07af31f@fastmail.fm>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
In-Reply-To: <fc6fe539-64ae-aa35-8b6e-3b22e07af31f@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bernd,


On 5/5/23 22:39, Bernd Schubert wrote:
>
>
> On 5/5/23 10:16, Hao Xu wrote:
>> From: Hao Xu <howeyxu@tencent.com>
>>
>> FOPEN_DIRECT_IO is usually set by fuse daemon to indicate need of strong
>> coherency, e.g. network filesystems. Thus shared mmap is disabled since
>> it leverages page cache and may write to it, which may cause
>> inconsistence. But FOPEN_DIRECT_IO can be used not for coherency but to
>> reduce memory footprint as well, e.g. reduce guest memory usage with
>> virtiofs. Therefore, add a new flag FOPEN_DIRECT_IO_SHARED_MMAP to allow
>> shared mmap for these cases.
>>
>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>> ---
>>   fs/fuse/file.c            | 11 ++++++++---
>>   include/uapi/linux/fuse.h |  2 ++
>>   2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 89d97f6188e0..655896bdb0d5 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -161,7 +161,8 @@ struct fuse_file *fuse_file_open(struct 
>> fuse_mount *fm, u64 nodeid,
>>       }
>>         if (isdir)
>> -        ff->open_flags &= ~FOPEN_DIRECT_IO;
>> +        ff->open_flags &=
>> +            ~(FOPEN_DIRECT_IO | FOPEN_DIRECT_IO_SHARED_MMAP);
>>         ff->nodeid = nodeid;
>>   @@ -2509,8 +2510,12 @@ static int fuse_file_mmap(struct file *file, 
>> struct vm_area_struct *vma)
>>           return fuse_dax_mmap(file, vma);
>>         if (ff->open_flags & FOPEN_DIRECT_IO) {
>> -        /* Can't provide the coherency needed for MAP_SHARED */
>> -        if (vma->vm_flags & VM_MAYSHARE)
>> +        /* Can't provide the coherency needed for MAP_SHARED.
>> +         * So disable it if FOPEN_DIRECT_IO_SHARED_MMAP is not
>> +         * set, which means we do need strong coherency.
>> +         */
>> +        if (!(ff->open_flags & FOPEN_DIRECT_IO_SHARED_MMAP) &&
>> +            vma->vm_flags & VM_MAYSHARE)
>>               return -ENODEV;
>>             invalidate_inode_pages2(file->f_mapping);
>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> index 1b9d0dfae72d..003dcf42e8c2 100644
>> --- a/include/uapi/linux/fuse.h
>> +++ b/include/uapi/linux/fuse.h
>> @@ -314,6 +314,7 @@ struct fuse_file_lock {
>>    * FOPEN_STREAM: the file is stream-like (no file position at all)
>>    * FOPEN_NOFLUSH: don't flush data cache on close (unless 
>> FUSE_WRITEBACK_CACHE)
>>    * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on 
>> the same inode
>> + * FOPEN_DIRECT_IO_SHARED_MMAP: allow shared mmap when 
>> FOPEN_DIRECT_IO is set
>>    */
>>   #define FOPEN_DIRECT_IO        (1 << 0)
>>   #define FOPEN_KEEP_CACHE    (1 << 1)
>> @@ -322,6 +323,7 @@ struct fuse_file_lock {
>>   #define FOPEN_STREAM        (1 << 4)
>>   #define FOPEN_NOFLUSH        (1 << 5)
>>   #define FOPEN_PARALLEL_DIRECT_WRITES    (1 << 6)
>> +#define FOPEN_DIRECT_IO_SHARED_MMAP    (1 << 7)
>
> Thanks, that is what I had in my mind as well.
>
> I don't have a strong opinion on it (so don't change it before Miklos 
> commented), but maybe FOPEN_DIRECT_IO_WEAK? Just in case there would 
> be later on other conditions that need to be weakened? The comment 
> would say then something like
> "Weakens FOPEN_DIRECT_IO enforcement, allows MAP_SHARED mmap"
>
> Thanks,
> Bernd
>

Hi Bernd,

BTW, I have another question:

```

   static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
{
           struct fuse_file *ff = file->private_data;

           /* DAX mmap is superior to direct_io mmap */
           if (FUSE_IS_DAX(file_inode(file)))
                   return fuse_dax_mmap(file, vma);

           if (ff->open_flags & FOPEN_DIRECT_IO) {
                   /* Can't provide the coherency needed for MAP_SHARED */
                   if (vma->vm_flags & VM_MAYSHARE)
                           return -ENODEV;

invalidate_inode_pages2(file->f_mapping);

                   return generic_file_mmap(file, vma);
}

           if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & 
VM_MAYWRITE))
fuse_link_write_file(file);

file_accessed(file);
           vma->vm_ops = &fuse_file_vm_ops;
           return 0;
}

```

For FOPEN_DIRECT_IO and !FOPEN_DIRECT_IO case, the former set vm_ops to 
generic_file_vm_ops

while the latter set it to fuse_file_vm_ops, and also it does the 
fuse_link_write_file() stuff. Why is so?

What causes the difference here?


Thanks,

Hao

