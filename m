Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBA73CF538
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 09:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhGTGjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 02:39:51 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56445 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231201AbhGTGjS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:39:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgP8v15_1626765590;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UgP8v15_1626765590)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Jul 2021 15:19:51 +0800
Subject: Re: [PATCH v2 3/4] fuse: add per-file DAX flag
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-4-jefflexu@linux.alibaba.com>
 <YPXHWmiYXMNxxhf7@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <99f346bf-e08d-3dad-d931-9d7aeb16ad08@linux.alibaba.com>
Date:   Tue, 20 Jul 2021 15:19:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPXHWmiYXMNxxhf7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/20/21 2:41 AM, Vivek Goyal wrote:
> On Fri, Jul 16, 2021 at 06:47:52PM +0800, Jeffle Xu wrote:
>> Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
>> this file.
>>
>> When the per-file DAX flag changes for an *opened* file, the state of
>> the file won't be updated until this file is closed and reopened later.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> [..]
>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> index 36ed092227fa..90c9df10d37a 100644
>> --- a/include/uapi/linux/fuse.h
>> +++ b/include/uapi/linux/fuse.h
>> @@ -184,6 +184,9 @@
>>   *
>>   *  7.34
>>   *  - add FUSE_SYNCFS
>> + *
>> + *  7.35
>> + *  - add FUSE_ATTR_DAX
>>   */
>>  
>>  #ifndef _LINUX_FUSE_H
>> @@ -449,8 +452,10 @@ struct fuse_file_lock {
>>   * fuse_attr flags
>>   *
>>   * FUSE_ATTR_SUBMOUNT: Object is a submount root
>> + * FUSE_ATTR_DAX: Enable DAX for this file in per-file DAX mode
>>   */
>>  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
>> +#define FUSE_ATTR_DAX		(1 << 1)
> 
> Generic fuse changes (addition of FUSE_ATTR_DAX) should probably in
> a separate patch. 

Got it.

> 
> I am not clear on one thing. If we are planning to rely on persistent
> inode attr (FS_XFLAG_DAX as per Documentation/filesystems/dax.rst), then
> why fuse server needs to communicate the state of that attr using a 
> flag? Can client directly query it?  I am not sure where at these
> attrs stored and if fuse protocol currently supports it.

There are two issues.

1. FUSE server side: Algorithm of deciding whether DAX is enabled for a
file.

As I previously replied in [1], FUSE server must enable DAX if the
backend file is flagged with FS_XFLAG_DAX, to make the FS_XFLAG_DAX
previously set by FUSE client effective.

But I will argue that FUSE server also has the flexibility of the
algorithm implementation. Even if guest queries FS_XFLAG_DAX by
GETFLAGS/FSGETXATTR ioctl, FUSE server can still enable DAX when the
backend file is not FS_XFLAG_DAX flagged.


2. The protocol between server and client.

extending LOOKUP vs. LOOKUP + GETFLAGS/FSGETXATTR ioctl

As I said in [1], client can directly query the FS_XFLAG_DAX flag, but
there will be one more round trip.


[1]
https://lore.kernel.org/linux-fsdevel/031efb1d-7c0d-35fb-c147-dcc3b6cac0ef@linux.alibaba.com/T/#m3f3407158b2c028694c85d82d0d6bd0387f4e24e

> 
> What about flag STATX_ATTR_DAX. We probably should report that too
> in stat if we are using dax on the inode?
> 

VFS will automatically report STATX_ATTR_DAX if inode is in DAX mode,
e.g., in vfs_getattr_nosec().



-- 
Thanks,
Jeffle
