Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA3246CA2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 02:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbhLHBka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 20:40:30 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59425 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234326AbhLHBk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:40:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uzp4Fcy_1638927414;
Received: from 30.225.24.52(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Uzp4Fcy_1638927414)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Dec 2021 09:36:54 +0800
Message-ID: <98ec5a66-4809-bf79-5135-2564b53ab95e@linux.alibaba.com>
Date:   Wed, 8 Dec 2021 09:36:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v8 6/7] fuse: mark inode DONT_CACHE when per inode DAX
 hint changes
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
 <20211125070530.79602-7-jefflexu@linux.alibaba.com>
 <Ya+FIsGgn4wsYG+4@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <Ya+FIsGgn4wsYG+4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/8/21 12:00 AM, Vivek Goyal wrote:
> On Thu, Nov 25, 2021 at 03:05:29PM +0800, Jeffle Xu wrote:
>> When the per inode DAX hint changes while the file is still *opened*, it
>> is quite complicated and maybe fragile to dynamically change the DAX
>> state.
>>
>> Hence mark the inode and corresponding dentries as DONE_CACHE once the
>> per inode DAX hint changes, so that the inode instance will be evicted
>> and freed as soon as possible once the file is closed and the last
>> reference to the inode is put. And then when the file gets reopened next
>> time, the new instantiated inode will reflect the new DAX state.
>>
>> In summary, when the per inode DAX hint changes for an *opened* file, the
>> DAX state of the file won't be updated until this file is closed and
>> reopened later.
> 
> Is this true for cache=always mode as well? If inode continues to be
> cached in guest cache, I am assuming we will not refresh inode attrs
> due to cache=always mode and will not get new DAX state from server.
> 
> IOW, changing DAX state of file is combination of two things.
> 
> A. Client comes to know about it using GETATTR.
> B. Once client knows about updated state, it will take affect when
>    existing inode is released and new inode is instantiated.
> 
> And step A might take time depending on cache mode as well as when
> is GETATTR actually initiated by the client. Its not deterministic
> and can't be guaranteed. Right?
> 

Right.

If it is virtiofsd that determines to *change* the DAX state, then guest
kernel has no way knowing that. If the notify queue is ready, maybe a
notify event can be sent to guest kernel to notify that the DAX state is
to be changed, if it is really needed later.

If it is the user inside guest that changes the DAX state, e.g. by
SETFLAGS ioctl, then we can mark the inode/dentry DONTCACHE following
the SETFLAGS ioctl, though it's not included in this patch.

-- 
Thanks,
Jeffle
