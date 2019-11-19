Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F39E1022F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 12:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfKSLXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 06:23:02 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37364 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbfKSLXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:23:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TiYLaXm_1574162574;
Received: from ali-186590e05fa3.local(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0TiYLaXm_1574162574)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Nov 2019 19:22:54 +0800
Subject: Re: [PATCH 2/2] ovl: implement async IO routines
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <1574129643-14664-1-git-send-email-jiufei.xue@linux.alibaba.com>
 <1574129643-14664-3-git-send-email-jiufei.xue@linux.alibaba.com>
 <CAOQ4uxhU0NGqX-P4XTJ+kf6sXNCnUCBxgp1u2-aDV5p15Jh+tg@mail.gmail.com>
 <142a7524-2587-7b1c-c5e0-3eb2d42b2762@linux.alibaba.com>
 <CAOQ4uxgR3KO9kXGdqif0A-QBrVLn9id2eFANMDprCz62jSAmaQ@mail.gmail.com>
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
Message-ID: <e88b8262-c475-f969-ef65-d888aee20e20@linux.alibaba.com>
Date:   Tue, 19 Nov 2019 19:22:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgR3KO9kXGdqif0A-QBrVLn9id2eFANMDprCz62jSAmaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Amir,
On 2019/11/19 下午5:38, Amir Goldstein wrote:
> On Tue, Nov 19, 2019 at 10:37 AM Jiufei Xue
> <jiufei.xue@linux.alibaba.com> wrote:
>>
>> Hi Amir,
>>
>> On 2019/11/19 下午12:22, Amir Goldstein wrote:
>>> On Tue, Nov 19, 2019 at 4:14 AM Jiufei Xue <jiufei.xue@linux.alibaba.com> wrote:
>>>>
>>>> A performance regression is observed since linux v4.19 when we do aio
>>>> test using fio with iodepth 128 on overlayfs. And we found that queue
>>>> depth of the device is always 1 which is unexpected.
>>>>
>>>> After investigation, it is found that commit 16914e6fc7
>>>> (“ovl: add ovl_read_iter()”) and commit 2a92e07edc
>>>> (“ovl: add ovl_write_iter()”) use do_iter_readv_writev() to submit
>>>> requests to real filesystem. Async IOs are converted to sync IOs here
>>>> and cause performance regression.
>>>>
>>>> So implement async IO for stacked reading and writing.
>>>>
>>>> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
>>>> ---
>>>>  fs/overlayfs/file.c      | 97 +++++++++++++++++++++++++++++++++++++++++-------
>>>>  fs/overlayfs/overlayfs.h |  2 +
>>>>  fs/overlayfs/super.c     | 12 +++++-
>>>>  3 files changed, 95 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>>>> index e235a63..07d94e7 100644
>>>> --- a/fs/overlayfs/file.c
>>>> +++ b/fs/overlayfs/file.c
>>>> @@ -11,6 +11,14 @@
>>>>  #include <linux/uaccess.h>
>>>>  #include "overlayfs.h"
>>>>
>>>> +struct ovl_aio_req {
>>>> +       struct kiocb iocb;
>>>> +       struct kiocb *orig_iocb;
>>>> +       struct fd fd;
>>>> +};
>>>> +
>>>> +static struct kmem_cache *ovl_aio_request_cachep;
>>>> +
>>>>  static char ovl_whatisit(struct inode *inode, struct inode *realinode)
>>>>  {
>>>>         if (realinode != ovl_inode_upper(inode))
>>>> @@ -225,6 +233,21 @@ static rwf_t ovl_iocb_to_rwf(struct kiocb *iocb)
>>>>         return flags;
>>>>  }
>>>>
>>>> +static void ovl_aio_rw_complete(struct kiocb *iocb, long res, long res2)
>>>> +{
>>>> +       struct ovl_aio_req *aio_req = container_of(iocb, struct ovl_aio_req, iocb);
>>>> +       struct kiocb *orig_iocb = aio_req->orig_iocb;
>>>> +
>>>> +       if (iocb->ki_flags & IOCB_WRITE)
>>>> +               file_end_write(iocb->ki_filp);
>>>> +
>>>> +       orig_iocb->ki_pos = iocb->ki_pos;
>>>> +       orig_iocb->ki_complete(orig_iocb, res, res2);
>>>> +
>>>> +       fdput(aio_req->fd);
>>>> +       kmem_cache_free(ovl_aio_request_cachep, aio_req);
>>>> +}
>>>> +
>>>>  static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>>>>  {
>>>>         struct file *file = iocb->ki_filp;
>>>> @@ -240,14 +263,28 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>>>>                 return ret;
>>>>
>>>>         old_cred = ovl_override_creds(file_inode(file)->i_sb);
>>>> -       ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
>>>> -                           ovl_iocb_to_rwf(iocb));
>>>> +       if (is_sync_kiocb(iocb)) {
>>>> +               ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
>>>> +                                   ovl_iocb_to_rwf(iocb));
>>>> +               ovl_file_accessed(file);
>>>> +               fdput(real);
>>>> +       } else {
>>>> +               struct ovl_aio_req *aio_req = kmem_cache_alloc(ovl_aio_request_cachep,
>>>> +                                                              GFP_NOFS);
>>>> +               aio_req->fd = real;
>>>> +               aio_req->orig_iocb = iocb;
>>>> +               kiocb_clone(&aio_req->iocb, iocb, real.file);
>>>> +               aio_req->iocb.ki_complete = ovl_aio_rw_complete;
>>>> +               ret = vfs_iocb_iter_read(real.file, &aio_req->iocb, iter);
>>>> +               ovl_file_accessed(file);
>>>
>>> That should be done in completion/error
>>>
>>
>> Refer to function generic_file_read_iter(), in direct IO path,
>> file_accessed() is done before IO submission, so I think ovl_file_accessed()
>> should be done here no matter completion/error or IO is queued.
> 
> Mmm, it doesn't matter much if atime is updated before or after,
> but ovl_file_accessed() does not only update atime, it also copies
> ctime which could have been modified as a result of the io, so
> I think it is safer to put it in the cleanup hook.
>

Can you give a more detailed description that a read op will modify
ctime as a result of the io?

I found that it will trigger BUG_ON(irqs_disabled()) while
calling ovl_file_accessed() on async IO return path. The calltrace
is pasted below:

ovl_file_accessed
  -> touch_atime
    -> ovl_update_time
      -> generic_update_time
        -> __mark_inode_dirty
          -> ext4_dirty_inode
            -> __ext4_get_inode_loc
              -> __find_get_block
                -> lookup_bh_lru
                   -> check_irqs_on

So I need more detail to find how to fix this issue.

Thanks,
Jiufei.

> Thanks,
> Amir.
> 
