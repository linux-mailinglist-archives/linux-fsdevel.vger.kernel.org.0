Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405453CF3ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 07:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbhGTEog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 00:44:36 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:50695 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239421AbhGTEof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 00:44:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgNuj16_1626758711;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UgNuj16_1626758711)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Jul 2021 13:25:12 +0800
Subject: Re: [PATCH v2 0/4] virtiofs,fuse: support per-file DAX
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <YPXu3BefIi7Ts48I@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <031efb1d-7c0d-35fb-c147-dcc3b6cac0ef@linux.alibaba.com>
Date:   Tue, 20 Jul 2021 13:25:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPXu3BefIi7Ts48I@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/20/21 5:30 AM, Vivek Goyal wrote:
> On Fri, Jul 16, 2021 at 06:47:49PM +0800, Jeffle Xu wrote:
>> This patchset adds support of per-file DAX for virtiofs, which is
>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
>>
>> There are three related scenarios:
>> 1. Alloc inode: get per-file DAX flag from fuse_attr.flags. (patch 3)
>> 2. Per-file DAX flag changes when the file has been opened. (patch 3)
>> In this case, the dentry and inode are all marked as DONT_CACHE, and
>> the DAX state won't be updated until the file is closed and reopened
>> later.
>> 3. Users can change the per-file DAX flag inside the guest by chattr(1).
>> (patch 4)
>> 4. Create new files under directories with DAX enabled. When creating
>> new files in ext4/xfs on host, the new created files will inherit the
>> per-file DAX flag from the directory, and thus the new created files in
>> virtiofs will also inherit the per-file DAX flag if the fuse server
>> derives fuse_attr.flags from the underlying ext4/xfs inode's per-file
>> DAX flag.
> 
> Thinking little bit more about this from requirement perspective. I think
> we are trying to address two use cases here.
> 
> A. Client does not know which files DAX should be used on. Only server
>    knows it and server passes this information to client. I suspect
>    that's your primary use case.

Yes, this is the starting point of this patch set.

> 
> B. Client is driving which files are supposed to be using DAX. This is
>    exactly same as the model ext4/xfs are using by storing a persistent
>    flag on inode. 
> 
> Current patches seem to be a hybrid of both approach A and B. 
> 
> If we were to implement B, then fuse client probably needs to have the
> capability to query FS_XFLAG_DAX on inode and decide whether to
> enable DAX or not. (Without extra round trip). Or know it indirectly
> by extending GETATTR and requesting this explicitly.

If guest queries if the file is DAX capable or not by an extra GETATTR,
I'm afraid this will add extra round trip.

Or if we add the DAX flag (ATTR_DAX) by extending LOOKUP, as done by
this patch set, then the FUSE server needs to set ATTR_DAX according to
the FS_XFLAG_DAX of the backend files, *to make the FS_XFLAG_DAX flag
previously set by FUSE client work*. Then it becomes a *mandatory*
requirement when implementing FUSE server. i.e., it becomes part of the
FUSE protocol rather than implementation specific. FUSE server can still
implement some other algorithm deciding whether to set ATTR_DAX or not,
though it must set ATTR_DAX once the backend file is flagged with
FS_XFLAG_DAX.

Besides, as you said, FUSE server needs to add one extra
GETFLAGS/FSGETXATTR ioctl per LOOKUP in this case. To eliminate this
cost, we could negotiate the per-file DAX capability during FUSE_INIT.
Only when the per-file DAX capability is negotiated, will the FUSE
server do extra GETFLAGS/FSGETXATTR ioctl and set ATTR_DAX flag when
doing LOOKUP.


Personally, I prefer the second way, i.e., by extending LOOKUP (adding
ATTR_DAX), to eliminate the extra round trip.

> 
> If we were only implementing A, then server does not have a way to 
> tell client to enable DAX. Server can either look at FS_XFLAG_DAX
> and decide to enable DAX or use some other property. Given querying
> FS_XFLAG_DAX will be an extra ioctl() on every inode lookup/getattr,
> it probably will be a server option. But enabling on server does not
> mean client will enable it.

As I said previously, it can be negotiated whether this per-file DAX
capability is needed. Guest can advertise this capability when '-o
dax=inode' is configured.

> 
> I think my primary concern with this patch right now is trying to
> figure out which requirement we are trying to cater to first and how
> to connect server and client well so they both understand what mode
> they are operating in and interact well.
> 


-- 
Thanks,
Jeffle
