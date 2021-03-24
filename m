Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C32A3472FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 08:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhCXHuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 03:50:09 -0400
Received: from relay.corp-email.com ([222.73.234.233]:32718 "EHLO
        relay.corp-email.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhCXHtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:49:32 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Mar 2021 03:49:31 EDT
Received: from ([183.47.25.45])
        by relay.corp-email.com ((LNX1044)) with ASMTP (SSL) id RAP00019;
        Wed, 24 Mar 2021 15:43:19 +0800
Received: from GCY-EXS-15.TCL.com (10.74.128.165) by GCY-EXS-09.TCL.com
 (10.74.128.159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 24 Mar
 2021 15:43:15 +0800
Received: from [172.16.34.11] (172.16.34.11) by GCY-EXS-15.TCL.com
 (10.74.128.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 24 Mar
 2021 15:43:13 +0800
Subject: Re: [PATCH RESEND V12 1/8] fs: Generic function to convert iocb to rw
 flags
To:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>
CC:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        "David Anderson" <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        "Jann Horn" <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        <fuse-devel@lists.sourceforge.net>, <kernel-team@android.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <24bb27b5804fb64238f2f9c1f3c860d5@sslemail.net>
 <YA71ydLBbKmZg5/O@google.com>
From:   Rokudo Yan <wu-yan@tcl.com>
Message-ID: <d136923d-dd50-3cb4-7771-b3c0dceabd24@tcl.com>
Date:   Wed, 24 Mar 2021 15:43:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YA71ydLBbKmZg5/O@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.34.11]
X-ClientProxiedBy: GCY-EXS-04.TCL.com (10.74.128.154) To GCY-EXS-15.TCL.com
 (10.74.128.165)
tUid:   2021324154319ee4718069e689e9be20fa256228811a6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/21 12:46 AM, Alessio Balsini wrote:
> On Mon, Jan 25, 2021 at 03:30:50PM +0000, Alessio Balsini wrote:
>> OverlayFS implements its own function to translate iocb flags into rw
>> flags, so that they can be passed into another vfs call.
>> With commit ce71bfea207b4 ("fs: align IOCB_* flags with RWF_* flags")
>> Jens created a 1:1 matching between the iocb flags and rw flags,
>> simplifying the conversion.
>>
>> Reduce the OverlayFS code by making the flag conversion function generic
>> and reusable.
>>
>> Signed-off-by: Alessio Balsini <balsini@android.com>
>> ---
>>   fs/overlayfs/file.c | 23 +++++------------------
>>   include/linux/fs.h  |  5 +++++
>>   2 files changed, 10 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>> index bd9dd38347ae..56be2ffc5a14 100644
>> --- a/fs/overlayfs/file.c
>> +++ b/fs/overlayfs/file.c
>> @@ -15,6 +15,8 @@
>>   #include <linux/fs.h>
>>   #include "overlayfs.h"
>>   
>> +#define OVL_IOCB_MASK (IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
>> +
>>   struct ovl_aio_req {
>>   	struct kiocb iocb;
>>   	struct kiocb *orig_iocb;
>> @@ -236,22 +238,6 @@ static void ovl_file_accessed(struct file *file)
>>   	touch_atime(&file->f_path);
>>   }
>>   
>> -static rwf_t ovl_iocb_to_rwf(int ifl)
>> -{
>> -	rwf_t flags = 0;
>> -
>> -	if (ifl & IOCB_NOWAIT)
>> -		flags |= RWF_NOWAIT;
>> -	if (ifl & IOCB_HIPRI)
>> -		flags |= RWF_HIPRI;
>> -	if (ifl & IOCB_DSYNC)
>> -		flags |= RWF_DSYNC;
>> -	if (ifl & IOCB_SYNC)
>> -		flags |= RWF_SYNC;
>> -
>> -	return flags;
>> -}
>> -
>>   static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
>>   {
>>   	struct kiocb *iocb = &aio_req->iocb;
>> @@ -299,7 +285,8 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>>   	old_cred = ovl_override_creds(file_inode(file)->i_sb);
>>   	if (is_sync_kiocb(iocb)) {
>>   		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
>> -				    ovl_iocb_to_rwf(iocb->ki_flags));
>> +				    iocb_to_rw_flags(iocb->ki_flags,
>> +						     OVL_IOCB_MASK));
>>   	} else {
>>   		struct ovl_aio_req *aio_req;
>>   
>> @@ -356,7 +343,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>>   	if (is_sync_kiocb(iocb)) {
>>   		file_start_write(real.file);
>>   		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
>> -				     ovl_iocb_to_rwf(ifl));
>> +				     iocb_to_rw_flags(ifl, OVL_IOCB_MASK));
>>   		file_end_write(real.file);
>>   		/* Update size */
>>   		ovl_copyattr(ovl_inode_real(inode), inode);
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index fd47deea7c17..647c35423545 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -3275,6 +3275,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>>   	return 0;
>>   }
>>   
>> +static inline rwf_t iocb_to_rw_flags(int ifl, int iocb_mask)
>> +{
>> +	return ifl & iocb_mask;
>> +}
>> +
>>   static inline ino_t parent_ino(struct dentry *dentry)
>>   {
>>   	ino_t res;
>> -- 
>> 2.30.0.280.ga3ce27912f-goog
>>
> 
> For some reason lkml.org and lore.kernel.org are not showing this change
> as part of the thread.
> Let's see if replying to the email fixes the indexing.
> 
> Regards,
> Alessio
> 

Hi, Alessio

This change imply IOCB_* and RWF_* flags are properly aligned, which is 
not true for kernel version 5.4/4.19/4.14. As the patch ("fs: align 
IOCB_* flags with RWF_* flags") is not back-ported to these stable 
kernel branches. The issue was found when applying these patches
to kernel-5.4(files open with passthrough enabled can't do append 
write). I think the issue exists in AOSP common kernel too.
Could you please fix this?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ce71bfea207b4d7c21d36f24ec37618ffcea1da8

https://android-review.googlesource.com/c/kernel/common/+/1556243

Thanks
yanwu
