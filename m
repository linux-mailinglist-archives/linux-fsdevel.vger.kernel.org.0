Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACC23F2641
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 07:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhHTFEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 01:04:05 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54852 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231524AbhHTFED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 01:04:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UkEzb1C_1629435803;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UkEzb1C_1629435803)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 Aug 2021 13:03:24 +0800
Subject: Re: [Virtio-fs] [virtiofsd PATCH v4 4/4] virtiofsd: support per-file
 DAX in FUSE_LOOKUP
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com,
        virtualization@lists.linux-foundation.org
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-5-jefflexu@linux.alibaba.com>
 <YRwHRmL/jUSqgkIU@work-vm>
 <29627110-e4bf-836f-2343-1faeb36ad4d3@linux.alibaba.com>
 <YR5Xzw02IuVAN94b@work-vm>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <4494052b-aff1-e2e3-e704-c8743168f62e@linux.alibaba.com>
Date:   Fri, 20 Aug 2021 13:03:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR5Xzw02IuVAN94b@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/19/21 9:08 PM, Dr. David Alan Gilbert wrote:
> * JeffleXu (jefflexu@linux.alibaba.com) wrote:
>>
>>
>> On 8/18/21 3:00 AM, Dr. David Alan Gilbert wrote:
>>> * Jeffle Xu (jefflexu@linux.alibaba.com) wrote:
>>>> For passthrough, when the corresponding virtiofs in guest is mounted
>>>> with '-o dax=inode', advertise that the file is capable of per-file
>>>> DAX if the inode in the backend fs is marked with FS_DAX_FL flag.
>>>>
>>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>>> ---
>>>>  tools/virtiofsd/passthrough_ll.c | 43 ++++++++++++++++++++++++++++++++
>>>>  1 file changed, 43 insertions(+)
>>>>
>>>> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
>>>> index 5b6228210f..4cbd904248 100644
>>>> --- a/tools/virtiofsd/passthrough_ll.c
>>>> +++ b/tools/virtiofsd/passthrough_ll.c
>>>> @@ -171,6 +171,7 @@ struct lo_data {
>>>>      int allow_direct_io;
>>>>      int announce_submounts;
>>>>      int perfile_dax_cap; /* capability of backend fs */
>>>> +    bool perfile_dax; /* enable per-file DAX or not */
>>>>      bool use_statx;
>>>>      struct lo_inode root;
>>>>      GHashTable *inodes; /* protected by lo->mutex */
>>>> @@ -716,6 +717,10 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
>>>>  
>>>>      if (conn->capable & FUSE_CAP_PERFILE_DAX && lo->perfile_dax_cap ) {
>>>>          conn->want |= FUSE_CAP_PERFILE_DAX;
>>>> +	lo->perfile_dax = 1;
>>>> +    }
>>>> +    else {
>>>> +	lo->perfile_dax = 0;
>>>>      }
>>>>  }
>>>>  
>>>> @@ -983,6 +988,41 @@ static int do_statx(struct lo_data *lo, int dirfd, const char *pathname,
>>>>      return 0;
>>>>  }
>>>>  
>>>> +/*
>>>> + * If the file is marked with FS_DAX_FL or FS_XFLAG_DAX, then DAX should be
>>>> + * enabled for this file.
>>>> + */
>>>> +static bool lo_should_enable_dax(struct lo_data *lo, struct lo_inode *dir,
>>>> +				 const char *name)
>>>> +{
>>>> +    int res, fd;
>>>> +    int ret = false;;
>>>> +    unsigned int attr;
>>>> +    struct fsxattr xattr;
>>>> +
>>>> +    if (!lo->perfile_dax)
>>>> +	return false;
>>>> +
>>>> +    /* Open file without O_PATH, so that ioctl can be called. */
>>>> +    fd = openat(dir->fd, name, O_NOFOLLOW);
>>>> +    if (fd == -1)
>>>> +        return false;
>>>
>>> Doesn't that defeat the whole benefit of using O_PATH - i.e. that we
>>> might stumble into a /dev node or something else we're not allowed to
>>> open?
>>
>> As far as I know, virtiofsd will pivot_root/chroot to the source
>> directory, and can only access files inside the source directory
>> specified by "-o source=". Then where do these unexpected files come
>> from? Besides, fd opened without O_PATH here is temporary and used for
>> FS_IOC_GETFLAGS/FS_IOC_FSGETXATTR ioctl only. It's closed when the
>> function returns.
> 
> The guest is still allowed to mknod.
> See:
>    https://lists.gnu.org/archive/html/qemu-devel/2021-01/msg05461.html
> 
> also it's legal to expose a root filesystem for a guest; the virtiofsd
> should *never* open a device other than O_PATH - and it's really tricky
> to do a check to see if it is a device in a race-free way.
> 

Fine. Got it. However the returned fd (opened without O_PATH) is only
used for FS_IOC_GETFLAGS/FS_IOC_FSGETXATTR ioctl, while in most cases
for special device files, these two ioctls should return -ENOTTY.

If it's really a security issue, then lo_inode_open() could be used to
get a temporary fd, i.e., check if it's a special file before opening.
After all, FUSE_OPEN also handles in this way. Besides, I can't
understand what "race-free way" means.


-- 
Thanks,
Jeffle
