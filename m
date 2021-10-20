Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06534343AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 05:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhJTDGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 23:06:20 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35645 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJTDGT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 23:06:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ut.34vh_1634699043;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Ut.34vh_1634699043)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Oct 2021 11:04:04 +0800
Subject: Re: [PATCH v6 3/7] fuse: support per-file DAX in fuse protocol
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-4-jefflexu@linux.alibaba.com>
 <YW2BLCtThkdrEs3K@redhat.com> <YW2Cyxtijcq5UqYA@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <c5d98a2c-7fe6-47a8-443d-4c4eed02d97a@linux.alibaba.com>
Date:   Wed, 20 Oct 2021 11:04:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YW2Cyxtijcq5UqYA@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/18/21 10:20 PM, Vivek Goyal wrote:
> On Mon, Oct 18, 2021 at 10:14:04AM -0400, Vivek Goyal wrote:
>> On Mon, Oct 11, 2021 at 11:00:48AM +0800, Jeffle Xu wrote:
>>> Expand the fuse protocol to support per-file DAX.
>>>
>>> FUSE_PERFILE_DAX flag is added indicating if fuse server/client
>>
>> Should we call this flag FUSE_INODE_DAX instead? It is per inode property?
>>

Yes, strictly specking, 'per-file' is not correct.

> 
> I realized that you are using FUSE_DAX_INODE to represent dax mode. So it
> will be confusing to use FUSE_INODE_DAX as protocol flag. How about
> FUSE_INODE_DAX_STATE instead?
> 

Emmm, the "_STATE" suffix is not straightforward and clear to me. How
about FUSE_HAS_INODE_DAX or FUSE_DO_INODE_DAX, referring to the existing
'FUSE_HAS_IOCTL_DIR' and 'FUSE_DO_READDIRPLUS'?


>>
>>> supporting per-file DAX. It can be conveyed in both FUSE_INIT request
>>> and reply.
>>>
>>> FUSE_ATTR_DAX flag is added indicating if DAX shall be enabled for
>>> corresponding file. It is conveyed in FUSE_LOOKUP reply.
>>>
>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>> ---
>>>  include/uapi/linux/fuse.h | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>>> index 36ed092227fa..15a1f5fc0797 100644
>>> --- a/include/uapi/linux/fuse.h
>>> +++ b/include/uapi/linux/fuse.h
>>> @@ -184,6 +184,9 @@
>>>   *
>>>   *  7.34
>>>   *  - add FUSE_SYNCFS
>>> + *
>>> + *  7.35
>>> + *  - add FUSE_PERFILE_DAX, FUSE_ATTR_DAX
>>>   */
>>>  
>>>  #ifndef _LINUX_FUSE_H
>>> @@ -219,7 +222,7 @@
>>>  #define FUSE_KERNEL_VERSION 7
>>>  
>>>  /** Minor version number of this interface */
>>> -#define FUSE_KERNEL_MINOR_VERSION 34
>>> +#define FUSE_KERNEL_MINOR_VERSION 35
>>>  
>>>  /** The node ID of the root inode */
>>>  #define FUSE_ROOT_ID 1
>>> @@ -336,6 +339,7 @@ struct fuse_file_lock {
>>>   *			write/truncate sgid is killed only if file has group
>>>   *			execute permission. (Same as Linux VFS behavior).
>>>   * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
>>> + * FUSE_PERFILE_DAX:	kernel supports per-file DAX
>>>   */
>>>  #define FUSE_ASYNC_READ		(1 << 0)
>>>  #define FUSE_POSIX_LOCKS	(1 << 1)
>>> @@ -367,6 +371,7 @@ struct fuse_file_lock {
>>>  #define FUSE_SUBMOUNTS		(1 << 27)
>>>  #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
>>>  #define FUSE_SETXATTR_EXT	(1 << 29)
>>> +#define FUSE_PERFILE_DAX	(1 << 30)
>>>  
>>>  /**
>>>   * CUSE INIT request/reply flags
>>> @@ -449,8 +454,10 @@ struct fuse_file_lock {
>>>   * fuse_attr flags
>>>   *
>>>   * FUSE_ATTR_SUBMOUNT: Object is a submount root
>>> + * FUSE_ATTR_DAX: Enable DAX for this file in per-file DAX mode
>>>   */
>>>  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
>>> +#define FUSE_ATTR_DAX		(1 << 1)
>>>  
>>>  /**
>>>   * Open flags
>>> -- 
>>> 2.27.0
>>>

-- 
Thanks,
Jeffle
