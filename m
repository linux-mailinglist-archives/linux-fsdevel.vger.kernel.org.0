Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D843D3D0ED4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 14:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhGULv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 07:51:59 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52462 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234910AbhGULvq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:51:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgWKU3Y_1626870739;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UgWKU3Y_1626870739)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Jul 2021 20:32:20 +0800
Subject: Re: [PATCH v2 0/4] virtiofs,fuse: support per-file DAX
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <YPXu3BefIi7Ts48I@redhat.com>
 <031efb1d-7c0d-35fb-c147-dcc3b6cac0ef@linux.alibaba.com>
 <YPchgf665bwUMKWU@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <38e9da34-cc2b-f496-7ebb-18db8da1aa01@linux.alibaba.com>
Date:   Wed, 21 Jul 2021 20:32:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPchgf665bwUMKWU@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/21/21 3:18 AM, Vivek Goyal wrote:
> On Tue, Jul 20, 2021 at 01:25:11PM +0800, JeffleXu wrote:
>>
>>
>> On 7/20/21 5:30 AM, Vivek Goyal wrote:
>>> On Fri, Jul 16, 2021 at 06:47:49PM +0800, Jeffle Xu wrote:
>>>> This patchset adds support of per-file DAX for virtiofs, which is
>>>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
>>>>
>>>> There are three related scenarios:
>>>> 1. Alloc inode: get per-file DAX flag from fuse_attr.flags. (patch 3)
>>>> 2. Per-file DAX flag changes when the file has been opened. (patch 3)
>>>> In this case, the dentry and inode are all marked as DONT_CACHE, and
>>>> the DAX state won't be updated until the file is closed and reopened
>>>> later.
>>>> 3. Users can change the per-file DAX flag inside the guest by chattr(1).
>>>> (patch 4)
>>>> 4. Create new files under directories with DAX enabled. When creating
>>>> new files in ext4/xfs on host, the new created files will inherit the
>>>> per-file DAX flag from the directory, and thus the new created files in
>>>> virtiofs will also inherit the per-file DAX flag if the fuse server
>>>> derives fuse_attr.flags from the underlying ext4/xfs inode's per-file
>>>> DAX flag.
>>>
>>> Thinking little bit more about this from requirement perspective. I think
>>> we are trying to address two use cases here.
>>>
>>> A. Client does not know which files DAX should be used on. Only server
>>>    knows it and server passes this information to client. I suspect
>>>    that's your primary use case.
>>
>> Yes, this is the starting point of this patch set.
>>
>>>
>>> B. Client is driving which files are supposed to be using DAX. This is
>>>    exactly same as the model ext4/xfs are using by storing a persistent
>>>    flag on inode. 
>>>
>>> Current patches seem to be a hybrid of both approach A and B. 
>>>
>>> If we were to implement B, then fuse client probably needs to have the
>>> capability to query FS_XFLAG_DAX on inode and decide whether to
>>> enable DAX or not. (Without extra round trip). Or know it indirectly
>>> by extending GETATTR and requesting this explicitly.
>>
>> If guest queries if the file is DAX capable or not by an extra GETATTR,
>> I'm afraid this will add extra round trip.
>>
>> Or if we add the DAX flag (ATTR_DAX) by extending LOOKUP, as done by
>> this patch set, then the FUSE server needs to set ATTR_DAX according to
>> the FS_XFLAG_DAX of the backend files, *to make the FS_XFLAG_DAX flag
>> previously set by FUSE client work*. Then it becomes a *mandatory*
>> requirement when implementing FUSE server. i.e., it becomes part of the
>> FUSE protocol rather than implementation specific. FUSE server can still
>> implement some other algorithm deciding whether to set ATTR_DAX or not,
>> though it must set ATTR_DAX once the backend file is flagged with
>> FS_XFLAG_DAX.
>>
>> Besides, as you said, FUSE server needs to add one extra
>> GETFLAGS/FSGETXATTR ioctl per LOOKUP in this case. To eliminate this
>> cost, we could negotiate the per-file DAX capability during FUSE_INIT.
>> Only when the per-file DAX capability is negotiated, will the FUSE
>> server do extra GETFLAGS/FSGETXATTR ioctl and set ATTR_DAX flag when
>> doing LOOKUP.
>>
>>
>> Personally, I prefer the second way, i.e., by extending LOOKUP (adding
>> ATTR_DAX), to eliminate the extra round trip.
> 
> Negotiating a fuse feature say FUSE_FS_XFLAG_DAX makes sense. If
> client is mounted with "-o dax=inode", then client will negotitate
> this feature and if server does not support it, mount can fail.
> 
> But this probably will be binding on server that it needs to return
> the state of FS_XFLAG_DAX attr on inode upon lookup/getattr. I don't
> this will allow server to implement its own separate policy which
> does not follow FS_XFLAG_DAX xattr. 

That means the backend fs must be ext4/xfs supporting per-file DAX feature.

If given more right to construct its own policy, FUSE server could
support per-file DAX upon other backend fs, though it will always fail
when virtiofs wants to set FS_XFLAG_DAX inside guest.

> 
> IOW, I don't think server can choose to implement its own policy
> for enabling dax for "-o dax=inode".
> 
> If there is really a need to for something new where server needs
> to dynamically decide which inodes should use dax (and not use
> FS_XFLAG_FS), I guess that probably should be a separate mount
> option say "-o dax=server" and it negotiates a separate feature
> say FUSE_DAX_SERVER. Once that's negotiated, now both client
> and server know that DAX will be used on files as determined
> by server and not necessarily by using file attr FS_XFLAG_DAX.
> 
> So is "dax=inode" enough for your needs? What's your requirement,
> can you give little bit of more details.

In our use case, the backend fs is something like SquashFS on host. The
content of the file on host is downloaded *as needed*. When the file is
not completely ready (completely downloaded), the guest will follow the
normal IO routine, i.e., by FUSE_READ/FUSE_WRITE request. While the file
is completely ready, per-file DAX is enabled for this file. IOW the FUSE
server need to dynamically decide if per-file DAX shall be enabled,
depending on if the file is completely downloaded.

Our strategy and design is still under discussion and may change. Any
comment and discussion is welcomed.

> 
>>
>>>
>>> If we were only implementing A, then server does not have a way to 
>>> tell client to enable DAX. Server can either look at FS_XFLAG_DAX
>>> and decide to enable DAX or use some other property. Given querying
>>> FS_XFLAG_DAX will be an extra ioctl() on every inode lookup/getattr,
>>> it probably will be a server option. But enabling on server does not
>>> mean client will enable it.
>>
>> As I said previously, it can be negotiated whether this per-file DAX
>> capability is needed. Guest can advertise this capability when '-o
>> dax=inode' is configured.
>>
>>>
>>> I think my primary concern with this patch right now is trying to
>>> figure out which requirement we are trying to cater to first and how
>>> to connect server and client well so they both understand what mode
>>> they are operating in and interact well.
>>>
>>
>>
>> -- 
>> Thanks,
>> Jeffle
>>

-- 
Thanks,
Jeffle
