Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6585744CF38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 02:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhKKBtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 20:49:17 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:42664 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232723AbhKKBtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:49:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UvyQtrw_1636595186;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UvyQtrw_1636595186)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 09:46:27 +0800
Subject: Re: [PATCH v7 6/7] fuse: mark inode DONT_CACHE when per inode DAX
 hint changes
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20211102052604.59462-1-jefflexu@linux.alibaba.com>
 <20211102052604.59462-7-jefflexu@linux.alibaba.com>
 <CAJfpegvfQbA32HjqWv9-Ds04W7Qs2idTOP7w5_NvKS_n=0Td7Q@mail.gmail.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <c41837f0-a183-d911-885d-cf3bcdd9b7c8@linux.alibaba.com>
Date:   Thu, 11 Nov 2021 09:46:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegvfQbA32HjqWv9-Ds04W7Qs2idTOP7w5_NvKS_n=0Td7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/10/21 11:50 PM, Miklos Szeredi wrote:
> On Tue, 2 Nov 2021 at 06:26, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>>
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
> This patch does nothing, since fuse already uses .drop_inode =
> generic_delete_inode, which is has the same effect as setting
> I_DONTCACHE, at least in the fuse case (inode should never be dirty at
> eviction).  

Yes, it is. .drop_inode() of FUSE will always free inode. Here we only
need to set dentry as DCACHE_DONTCACHE. Here I just call
d_mark_dontcache() directly, though I_DONTCACHE is useless but harmless
in the case of FUSE...


> In fact it may be cleaner to set I_DONTCACHE
> unconditionally and remove the .drop_inode callback setting.

It works in both cases, I mean, in current case (current code retained
untouched) and the case you described above.

-- 
Thanks,
Jeffle
