Return-Path: <linux-fsdevel+bounces-74037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C45BD2A45D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 03:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63FE7303BAA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 02:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177CE338925;
	Fri, 16 Jan 2026 02:43:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF861EB5E3;
	Fri, 16 Jan 2026 02:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531431; cv=none; b=RgZQL2y+5mnFrPpnjTfMBGMY33M9UpE44SJMo1sRWKUiZQ1AQzTBw1ycihAnGMAyj+wnRDiQ+5O9CuRx62aoZJeJuGaz70EPI+0uMFpTCW+dm9SBjc0f7twKX9szSmG0p8KL1VKllU0vx7n1NxF4bipoDuTeWsMMcjF/Bd7tuxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531431; c=relaxed/simple;
	bh=LsOrtHvZPB03tcYjMqGUlqkZH0sSXg3loHED91xqs+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J85gNAnejQtWgLuMd9gcFuL0evuauAZPwSlWdfa+Cf9fb2KiUcovQZVyy5+qw5mQKj0xf5gMXNSeqnx3vZdU7XnhH3UQuku+OBEtmS5/yowPRkdJ2So6Bw8nySrbhjoxAuumlhquZ1ZvuBZsO/UboWY8dfuLUmErAomlR7Fhx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from [10.26.132.114] (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [61.151.228.145])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30d90dd8e;
	Fri, 16 Jan 2026 10:43:43 +0800 (GMT+08:00)
Message-ID: <bff16d9e-d6e7-4d0e-9a58-6db37ec58ce7@ustc.edu>
Date: Fri, 16 Jan 2026 10:43:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] fuse: Add new flag to reuse the backing file of
 fuse_inode
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, paullawrence@google.com
References: <20260115072032.402-1-luochunsheng@ustc.edu>
 <20260115072032.402-3-luochunsheng@ustc.edu>
 <aWjnHvP5jsafQeag@amir-ThinkPad-T480>
 <a0ccfa28-4107-46ed-af79-faf55c004da0@ustc.edu>
 <CAOQ4uxhOuBXT3tgoLxjh6efAwiOLg=oDxsyivLLMXCrSamSuEA@mail.gmail.com>
From: Chunsheng Luo <luochunsheng@ustc.edu>
In-Reply-To: <CAOQ4uxhOuBXT3tgoLxjh6efAwiOLg=oDxsyivLLMXCrSamSuEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc4aff0e503a2kunm088b3b95245cae
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSUgYVhpDSh1KSk0dT0xKHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlNSlVKTkpVSUlDVUpPTllXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG



On 1/15/26 11:31 PM, Amir Goldstein wrote:
> On Thu, Jan 15, 2026 at 3:35 PM Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>>
>>
>>
>> On 1/15/26 9:09 PM, Amir Goldstein wrote:
>>> Hi Chunsheng,
>>>
>>> Please CC me for future fuse passthrough patch sets.
>>>
>> Ok.
>>
>>> On Thu, Jan 15, 2026 at 03:20:31PM +0800, Chunsheng Luo wrote:
>>>> To simplify crash recovery and reduce performance impact, backing_ids
>>>> are not persisted across daemon restarts. However, this creates a
>>>> problem: when the daemon restarts and a process opens the same FUSE
>>>> file, a new backing_id may be allocated for the same backing file. If
>>>> the inode already has a cached backing file from before the restart,
>>>> subsequent open requests with the new backing_id will fail in
>>>> fuse_inode_uncached_io_start() due to fb mismatch, even though both
>>>> IDs reference the identical underlying file.
>>>
>>> I don't think that your proposal makes this guaranty.
>>>
>>
>> Yes, this proposal does not apply to all situations.
>>
>>>>
>>>> Introduce the FOPEN_PASSTHROUGH_INODE_CACHE flag to address this
>>>> issue. When set, the kernel reuses the backing file already cached in
>>>> the inode.
>>>>
>>>> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
>>>> ---
>>>>    fs/fuse/iomode.c          |  2 +-
>>>>    fs/fuse/passthrough.c     | 11 +++++++++++
>>>>    include/uapi/linux/fuse.h |  2 ++
>>>>    3 files changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
>>>> index 3728933188f3..b200bb248598 100644
>>>> --- a/fs/fuse/iomode.c
>>>> +++ b/fs/fuse/iomode.c
>>>> @@ -163,7 +163,7 @@ static void fuse_file_uncached_io_release(struct fuse_file *ff,
>>>>     */
>>>>    #define FOPEN_PASSTHROUGH_MASK \
>>>>       (FOPEN_PASSTHROUGH | FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRITES | \
>>>> -     FOPEN_NOFLUSH)
>>>> +     FOPEN_NOFLUSH | FOPEN_PASSTHROUGH_INODE_CACHE)
>>>>
>>>>    static int fuse_file_passthrough_open(struct inode *inode, struct file *file)
>>>>    {
>>>> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
>>>> index 72de97c03d0e..fde4ac0c5737 100644
>>>> --- a/fs/fuse/passthrough.c
>>>> +++ b/fs/fuse/passthrough.c
>>>> @@ -147,16 +147,26 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
>>>>    /*
>>>>     * Setup passthrough to a backing file.
>>>>     *
>>>> + * If fuse inode backing is provided and FOPEN_PASSTHROUGH_INODE_CACHE flag
>>>> + * is set, try to reuse it first before looking up backing_id.
>>>> + *
>>>>     * Returns an fb object with elevated refcount to be stored in fuse inode.
>>>>     */
>>>>    struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id)
>>>>    {
>>>>       struct fuse_file *ff = file->private_data;
>>>>       struct fuse_conn *fc = ff->fm->fc;
>>>> +    struct fuse_inode *fi = get_fuse_inode(file->f_inode);
>>>>       struct fuse_backing *fb = NULL;
>>>>       struct file *backing_file;
>>>>       int err;
>>>>
>>>> +    if (ff->open_flags & FOPEN_PASSTHROUGH_INODE_CACHE) {
>>>> +            fb = fuse_backing_get(fuse_inode_backing(fi));
>>>> +            if (fb)
>>>> +                    goto do_open;
>>>> +    }
>>>> +
>>>
>>> Maybe an explicit FOPEN_PASSTHROUGH_INODE_CACHE flag is a good idea,
>>> but just FYI, I intentionally reserved backing_id 0 for this purpose.
>>> For example, for setting up the backing id on lookup [1] and then
>>> open does not need to specify the backing_id.
>>>
>>> [1] https://lore.kernel.org/linux-fsdevel/20250804173228.1990317-1-paullawrence@google.com/
>>>
>>
>> This is a great idea. However, we need to consider the lifecycle
>> management of the backing file associated with a FUSE inode.
>> Specifically, will the same backing_idbe retained for the entire
>> lifetime of the FUSE inode until it is deleted?
> 
> It's not a good fit for servers that want to change the backing file
> (like re-download). For these servers we have the existing file
> open-to-close life cycle.
> 
>>
>> Additionally, since each backing_idcorresponds to an open file
>> descriptor (fd) for the backing file, if a fuse_inode holds onto a
>> backing_id indefinitely without a suitable release mechanism, could this
>> accumulation of file descriptors cause the process to exceed its open
>> files limit?
>>
> 
> There is no such accumulation.
> fuse_inode refers to a single fuse_backing object.
> fuse_file refers to a single fuse_backing object.
> It can be the same (refcounted) object.
> 

Sorry, I wasn't referring to `fuse_backing` refs.

If the lifecycle of `fuse_backing` is the same as `fuse_inode`, and 
there are a large number of FUSE files on the file system, then when I 
iterate through and open the backing files, register the `fuse_backing`, 
and then set it to the `fuse_inode`, the FUSE service will hold a large 
number of backing file file descriptors (FDs).  These backing file FDs 
will only be released when the FUSE files are deleted.

For example, if there are 1000 FUSE files on the file system, and I 
iterate through and set the backing file for each `fuse_inode`, then the 
FUSE service will hold 1000 backing file FDs for a long time.  Extending 
this further, if there are even more files, could the FUSE service 
process exceed the `ulimit` configuration for open files?

```shell
[root@localhost home]# ulimit -a |grep "open files"
open files                          (-n) 1024
```

>>> But what you are proposing is a little bit odd API IMO:
>>> "Use this backing_id with this backing file, unless you find another
>>>    backing file so use that one instead" - this sounds a bit awkward to me.
>>>
>>> I think it would be saner and simpler to relax the check in
>>> fuse_inode_uncached_io_start() to check that old and new fuse_backing
>>> objects refer to the same backing inode:
>>>
>>> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
>>> index 3728933188f30..c6070c361d855 100644
>>> --- a/fs/fuse/iomode.c
>>> +++ b/fs/fuse/iomode.c
>>> @@ -88,9 +88,9 @@ int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_backing *fb)
>>>        int err = 0;
>>>
>>>        spin_lock(&fi->lock);
>>> -     /* deny conflicting backing files on same fuse inode */
>>> +     /* deny conflicting backing inodes on same fuse inode */
>>>        oldfb = fuse_inode_backing(fi);
>>> -     if (fb && oldfb && oldfb != fb) {
>>> +     if (fb && oldfb && file_inode(oldfb->file) != file_inode(fb->file)) {
>>>                err = -EBUSY;
>>>                goto unlock;
>>>        }
>>> --
>>>
>>> I don't think that this requires opt-in flag.
>>>
>>> Thanks,
>>> Amir.
>>
>> I agree that modifying the condition to `file_inode(oldfb->file) !=
>> file_inode(fb->file)` is a reasonable fix, and it does address the first
>> scenario I described.
>>
>> However, it doesn't fully resolve the second scenario: in a read-only
>> FUSE filesystem, the backing file itself might be cleaned up and
>> re-downloaded (resulting in a new inode with identical content). In this
>> case, reusing the cached fuse_inode's fb after a daemon restart still be
>> safe, but the inode comparison would incorrectly reject it. Is there a
>> more robust approach for handling this scenario?
>>
> 
> There is a reason we added the restriction against associating
> fuse file to different backing inodes.
> 
> mmap and reads from different files to the same inode need to be
> cache coherent.
> 
> IOW, we intentionally do not support this setup without server restart
> there is no reason for us to allow that after server restarts because
> the consequense will be the same.
> 
> It does not sound like a good idea for the server to cleanup files
> that are currently opened via fuse passthrough - is that something
> that happens intentionally? after server restarts?
> 
> You could try to take a write lease to check if the file is currently
> open for read/write to avoid cleanup in this case?
> 
> Thanks,
> Amir.
> 
> 

Yes, it happened after the fuse service crash recovery restart, because 
the refs of the backup files were cleaned up, causing them to be 
mistakenly garbage collected.

I will consider how to prevent it from being mistakenly garbage 
collected by the fuse server.

I will resend the patch, modifying only the condition in 
`fuse_inode_uncached_io_start`, changing it to `file_inode(oldfb->file) 
!= file_inode(fb->file)`.

Thanks.
Chunsheng Luo



