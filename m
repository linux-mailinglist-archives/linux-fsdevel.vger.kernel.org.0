Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A3D3D1E81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhGVGL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 02:11:59 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33628 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhGVGL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 02:11:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UgaY77V_1626936752;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UgaY77V_1626936752)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 22 Jul 2021 14:52:33 +0800
Subject: Re: [PATCH v2] vfs: only allow SETFLAGS to set DAX flag on files and
 dirs
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <20210719023834.104053-1-jefflexu@linux.alibaba.com>
 <20210719174331.GH22357@magnolia>
 <729b4efa-8903-c5ec-4e29-7f4e0d02ce2a@linux.alibaba.com>
 <20210721232818.GB8639@magnolia>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <79ee050f-1b25-9ae4-7dc8-5c33994d1d86@linux.alibaba.com>
Date:   Thu, 22 Jul 2021 14:52:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721232818.GB8639@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/22/21 7:28 AM, Darrick J. Wong wrote:
> On Tue, Jul 20, 2021 at 03:33:20PM +0800, JeffleXu wrote:
>>
>>
>> On 7/20/21 1:43 AM, Darrick J. Wong wrote:
>>> On Mon, Jul 19, 2021 at 10:38:34AM +0800, Jeffle Xu wrote:
>>>> This is similar to commit dbc77f31e58b ("vfs: only allow FSSETXATTR to
>>>> set DAX flag on files and dirs").
>>>>
>>>> Though the underlying filesystems may have filtered invalid flags, e.g.,
>>>> ext4_mask_flags() called in ext4_fileattr_set(), also check it in VFS
>>>> layer.
>>>>
>>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>>> ---
>>>> changes since v1:
>>>> - add separate parentheses surrounding flag tests
>>>> ---
>>>>  fs/ioctl.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/ioctl.c b/fs/ioctl.c
>>>> index 1e2204fa9963..90cfaa4db03a 100644
>>>> --- a/fs/ioctl.c
>>>> +++ b/fs/ioctl.c
>>>> @@ -835,7 +835,7 @@ static int fileattr_set_prepare(struct inode *inode,
>>>>  	 * It is only valid to set the DAX flag on regular files and
>>>>  	 * directories on filesystems.
>>>>  	 */
>>>> -	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
>>>> +	if (((fa->fsx_xflags & FS_XFLAG_DAX) || (fa->flags & FS_DAX_FL)) &&
>>>
>>> Isn't fileattr_fill_flags supposed to fill out fa->fsx_xflags from
>>> fa->flags for a SETFLAGS call?
>>
>> Yes, but fa->fsx_xflags inherited from fa->flags (at least in ext4 it
>> is) is the original flags/xflags of the file before SETFLAG/FSSETXATTR.
> 
> How?  old_ma is the original flags/xflags of the file.  fa reflects what
> we copied in from userspace.  We use old_ma to set flags in fa that
> couldn't possibly have been set by userspace, but neither DAX flag is in
> that set.
> 
> Ugh, this is so much bookkeeping code to read it makes my head hurt.  Do
> you have a reproducer?  I can't figure out how to trip this problem.
> 
>> Here we want to check *new* flags/xflags.
> 
> AFAICT, SETFLAGS will call ioctl_setflags, which will...
> ...read flags from userspace

> ...fill out struct fileattr via fileattr_fill_flags, which will set
>    fa.fsx_flags from fa.flags, so the state of both fields' DAX flags
>    will be whatever userspace gave us

Sorry I omitted this step and mistakenly thought that fa.fsx_flags was
*completely* copied from old_ma.fsx_xflags...

When calling SETFLAGS ioctl, FS_DAX_FL will still be checked by
following code snippet from fileattr_set_prepare().

```c
	/*
	 * It is only valid to set the DAX flag on regular files and
	 * directories on filesystems.
	 */
	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
		return -EINVAL;
```

I didn't encountered the issue in real environment. I thought it was a
simple fix while I was reading the code...

Sorry for the noise and really thanks to the detailed clarification.


Thanks
Jeffle


> ...call vfs_fileattr_set, which will...
> ...call vfs_fileattr_get to fill out out_ma
> ...update the rest of xflags with the xflags from out_ma that weren't
>    already set
> ...call fileattr_set_prepare, where it shouldn't matter if it checks
>    (fa->xflags & FS_XFLAG_DAX) or (fa->flags & FS_DAX_FL), since they
>    have the same value
> 
> FSSETXATTR will call ioctl_fssetxattr, which will...
> ...call copy_fsxattr_from_user to read fsxattr from userspace
> ...call fileattr_fill_xflags to set fa->flags from fa->xflags, so the
>    state of both fields' DAX flags will be whatever userspace gave us
> ...call vfs_fileattr_set, which will...
> ...call vfs_fileattr_get to fill out out_ma
> ...update the rest of flags with the flags from out_ma that weren't
>    already set
> ...call fileattr_set_prepare, where it shouldn't matter if it checks
>    (fa->xflags & FS_XFLAG_DAX) or (fa->flags & FS_DAX_FL), since they
>    have the same value
> 
> So where did I go wrong?
> 
> --D
> 
>>
>>>
>>>>  	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
>>>>  		return -EINVAL;
>>>>  
>>>> -- 
>>>> 2.27.0
>>>>
>>
>> -- 
>> Thanks,
>> Jeffle

-- 
Thanks,
Jeffle
