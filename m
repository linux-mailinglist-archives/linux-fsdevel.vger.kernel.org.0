Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0AB3F940A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 07:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244234AbhH0F3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 01:29:05 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32169 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S244225AbhH0F3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 01:29:04 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Atei45Kg/Y8j9xKYkcrbfWQ3753BQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.84,355,1620662400"; 
   d="scan'208";a="113551417"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Aug 2021 13:28:14 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id C83874D0D4BD;
        Fri, 27 Aug 2021 13:28:07 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 27 Aug 2021 13:27:58 +0800
Received: from [192.168.22.65] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 27 Aug 2021 13:27:56 +0800
Subject: Re: [PATCH v7 7/8] fsdax: Introduce dax_iomap_ops for end of reflink
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com>
 <20210816060359.1442450-8-ruansy.fnst@fujitsu.com>
 <CAPcyv4jbi=p=SjFYZcHnEAu+KY821pW_k_yA5u6hya4jEfrTUg@mail.gmail.com>
 <c7e68dc8-5a43-f727-c262-58dcf244c711@fujitsu.com>
 <CAPcyv4jM86gy-T5EEZf6M2m44v4MiGqYDhxisX59M5QJii6DVg@mail.gmail.com>
 <32fa5333-b14e-2060-d659-d77f6c75ff16@fujitsu.com>
 <CAPcyv4h801eipbvOpzSnw_GnUcuSxcm6eUfJdoHNW2ZmZgzW=Q@mail.gmail.com>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <2489af0c-ef3c-a293-c652-e1c2b7bd4164@fujitsu.com>
Date:   Fri, 27 Aug 2021 13:27:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h801eipbvOpzSnw_GnUcuSxcm6eUfJdoHNW2ZmZgzW=Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: C83874D0D4BD.A227B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/8/27 13:04, Dan Williams wrote:
> On Thu, Aug 26, 2021 at 8:30 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>>
>>
>>
>> On 2021/8/20 23:18, Dan Williams wrote:
>>> On Thu, Aug 19, 2021 at 11:13 PM ruansy.fnst <ruansy.fnst@fujitsu.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2021/8/20 上午11:01, Dan Williams wrote:
>>>>> On Sun, Aug 15, 2021 at 11:05 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>>>>>>
>>>>>> After writing data, reflink requires end operations to remap those new
>>>>>> allocated extents.  The current ->iomap_end() ignores the error code
>>>>>> returned from ->actor(), so we introduce this dax_iomap_ops and change
>>>>>> the dax_iomap_*() interfaces to do this job.
>>>>>>
>>>>>> - the dax_iomap_ops contains the original struct iomap_ops and fsdax
>>>>>>        specific ->actor_end(), which is for the end operations of reflink
>>>>>> - also introduce dax specific zero_range, truncate_page
>>>>>> - create new dax_iomap_ops for ext2 and ext4
>>>>>>
>>>>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>>>>>> ---
>>>>>>     fs/dax.c               | 68 +++++++++++++++++++++++++++++++++++++-----
>>>>>>     fs/ext2/ext2.h         |  3 ++
>>>>>>     fs/ext2/file.c         |  6 ++--
>>>>>>     fs/ext2/inode.c        | 11 +++++--
>>>>>>     fs/ext4/ext4.h         |  3 ++
>>>>>>     fs/ext4/file.c         |  6 ++--
>>>>>>     fs/ext4/inode.c        | 13 ++++++--
>>>>>>     fs/iomap/buffered-io.c |  3 +-
>>>>>>     fs/xfs/xfs_bmap_util.c |  3 +-
>>>>>>     fs/xfs/xfs_file.c      |  8 ++---
>>>>>>     fs/xfs/xfs_iomap.c     | 36 +++++++++++++++++++++-
>>>>>>     fs/xfs/xfs_iomap.h     | 33 ++++++++++++++++++++
>>>>>>     fs/xfs/xfs_iops.c      |  7 ++---
>>>>>>     fs/xfs/xfs_reflink.c   |  3 +-
>>>>>>     include/linux/dax.h    | 21 ++++++++++---
>>>>>>     include/linux/iomap.h  |  1 +
>>>>>>     16 files changed, 189 insertions(+), 36 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/dax.c b/fs/dax.c
>>>>>> index 74dd918cff1f..0e0536765a7e 100644
>>>>>> --- a/fs/dax.c
>>>>>> +++ b/fs/dax.c
>>>>>> @@ -1348,11 +1348,30 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>>>>>>            return done ? done : ret;
>>>>>>     }
>>>>>>
>>>>>> +static inline int
>>>>>> +__dax_iomap_iter(struct iomap_iter *iter, const struct dax_iomap_ops *ops)
>>>>>> +{
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       /*
>>>>>> +        * Call dax_iomap_ops->actor_end() before iomap_ops->iomap_end() in
>>>>>> +        * each iteration.
>>>>>> +        */
>>>>>> +       if (iter->iomap.length && ops->actor_end) {
>>>>>> +               ret = ops->actor_end(iter->inode, iter->pos, iter->len,
>>>>>> +                                    iter->processed);
>>>>>> +               if (ret < 0)
>>>>>> +                       return ret;
>>>>>> +       }
>>>>>> +
>>>>>> +       return iomap_iter(iter, &ops->iomap_ops);
>>>>>
>>>>> This reorganization looks needlessly noisy. Why not require the
>>>>> iomap_end operation to perform the actor_end work. I.e. why can't
>>>>> xfs_dax_write_iomap_actor_end() just be the passed in iomap_end? I am
>>>>> not seeing where the ->iomap_end() result is ignored?
>>>>>
>>>>
>>>> The V6 patch[1] was did in this way.
>>>> [1]https://lore.kernel.org/linux-xfs/20210526005159.GF202144@locust/T/#m79a66a928da2d089e2458c1a97c0516dbfde2f7f
>>>>
>>>> But Darrick reminded me that ->iomap_end() will always take zero or
>>>> positive 'written' because iomap_apply() handles this argument.
>>>>
>>>> ```
>>>>           if (ops->iomap_end) {
>>>>                   ret = ops->iomap_end(inode, pos, length,
>>>>                                        written > 0 ? written : 0,
>>>>                                        flags, &iomap);
>>>>           }
>>>> ```
>>>>
>>>> So, we cannot get actual return code from CoW in ->actor(), and as a
>>>> result, we cannot handle the xfs end_cow correctly in ->iomap_end().
>>>> That's where the result of CoW was ignored.
>>>
>>> Ah, thank you for the explanation.
>>>
>>> However, this still seems like too much code thrash just to get back
>>> to the original value of iter->processed. I notice you are talking
>>> about iomap_apply(), but that routine is now gone in Darrick's latest
>>> iomap-for-next branch. Instead iomap_iter() does this:
>>>
>>>           if (iter->iomap.length && ops->iomap_end) {
>>>                   ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
>>>                                   iter->processed > 0 ? iter->processed : 0,
>>
>> As you can see, here is the same logic as the old iomap_apply(): the
>> negative iter->processed won't be passed into ->iomap_end().
>>
>>>                                   iter->flags, &iter->iomap);
>>>                   if (ret < 0 && !iter->processed)
>>>                           return ret;
>>>           }
>>>
>>>
>>> I notice that the @iomap argument to ->iomap_end() is reliably coming
>>> from @iter. So you could do the following in your iomap_end()
>>> callback:
>>>
>>>           struct iomap_iter *iter = container_of(iomap, typeof(*iter), iomap);
>>>           struct xfs_inode *ip = XFS_I(inode);
>>>           ssize_t written = iter->processed;
>>
>> The written will be 0 or positive.  The original error code is ingnored.
> 
> Correct, but you can use container_of() to get back to the iter and
> consider the raw untranslated value of iter->processed. As Christoph
> mentioned this needs a comment explaining the layering violation, but
> that's a cleaner change than the dax_iomap_ops approach.
> 

Understood.  Thanks.

--
Ruan.


