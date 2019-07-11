Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54594658A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 16:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfGKOPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 10:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfGKOPc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:15:32 -0400
Received: from [192.168.0.101] (unknown [49.65.245.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF3B421537;
        Thu, 11 Jul 2019 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562854530;
        bh=GFj0EICvmkhKH1DYXsFw4LLZ2hcceo02qWLJh71UgBY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XlhAZlfF6dGjz/D8bF2VFZiHyvRNEZfySjfiCgWfeZgAkNr3i/RFsOAWHCaNhI9FC
         hkRFwC7D29sCOB5meB7LWIFHs4dWDQHM6+fZ6SFyXd0nYA24JiKgHkdi6jB8xHGn7k
         EhDqRDP+RoLyN9QI5vqFi/C903bY1nlyIkT3IQbM=
Subject: Re: [RFC PATCH] iomap: generalize IOMAP_INLINE to cover tail-packing
 case
To:     =?UTF-8?Q?Andreas_Gr=c3=bcnbacher?= <andreas.gruenbacher@gmail.com>,
        Chao Yu <yuchao0@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
References: <20190703075502.79782-1-yuchao0@huawei.com>
 <CAHpGcM+s77hKMXo=66nWNF7YKa3qhLY9bZrdb4-Lkspyg2CCDw@mail.gmail.com>
 <39944e50-5888-f900-1954-91be2b12ea5b@huawei.com>
 <CAHpGcMJ_wPJf8KtF3xMP_28pe4Vq4XozFtmd2EuZ+RTqZKQxLA@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <c0816437-934d-f85f-56b5-e982041e7213@kernel.org>
Date:   Thu, 11 Jul 2019 22:15:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHpGcMJ_wPJf8KtF3xMP_28pe4Vq4XozFtmd2EuZ+RTqZKQxLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-7-11 5:50, Andreas Grünbacher wrote:
> Am Mi., 10. Juli 2019 um 12:31 Uhr schrieb Chao Yu <yuchao0@huawei.com>:
>> Hi Andreas,
>>
>> Thanks for your review in advance. :)
>>
>> On 2019/7/10 7:32, Andreas Grünbacher wrote:
>>> Hi Chao,
>>>
>>> Am Mi., 3. Juli 2019 um 09:55 Uhr schrieb Chao Yu <yuchao0@huawei.com>:
>>>> Some filesystems like erofs/reiserfs have the ability to pack tail
>>>> data into metadata, e.g.:
>>>> IOMAP_MAPPED [0, 8192]
>>>> IOMAP_INLINE [8192, 8200]
>>>>
>>>> However current IOMAP_INLINE type has assumption that:
>>>> - inline data should be locating at page #0.
>>>> - inline size should equal to .i_size
>>>> Those restriction fail to convert to use iomap IOMAP_INLINE in erofs,
>>>> so this patch tries to relieve above limits to make IOMAP_INLINE more
>>>> generic to cover tail-packing case.
>>>
>>> this patch suffers from the following problems:
>>>
>>> * Fiemap distinguishes between FIEMAP_EXTENT_DATA_INLINE and
>>> FIEMAP_EXTENT_DATA_TAIL. Someone will sooner or later inevitably use
>>> iomap_fiemap on a filesystem with tail packing, so if we don't make
>>> the same distinction in iomap, iomap_fiemap will silently produce the
>>> wrong result. This means that IOMAP_TAIL should become a separate
>>> mapping type.
>>
>> I'm a little confused, IIUC, IOMAP_TAIL and FIEMAP_EXTENT_DATA_TAIL are with
>> different semantics:
>>
>> - IOMAP_TAIL:
>>   we may introduce this flag to cover tail-packing case, in where we merge
>> small-sized data in the tail of file into free space of its metadata.
>> - FIEMAP_EXTENT_DATA_TAIL:
>> quoted from Documentation/filesystems/fiemap.txt
>> "  This will also set FIEMAP_EXTENT_NOT_ALIGNED
>> Data is packed into a block with data from other files."
>> It looks like this flag indicates that blocks from different files stores into
>> one common block.
> 
> Well, maybe FIEMAP_EXTENT_DATA_INLINE is indeed the more appropriate
> flag in your scenario. In that case, we should be fine on the fiemap
> front.

Yup.

> 
>> I'm not familiar with fiemap flags' history, but maybe FIEMAP_EXTENT_DATA_TAIL
>> should be better to rename to FIEMAP_EXTENT_DATA_PACKING to avoid ambiguity. And
>> then FIEMAP_EXTENT_DATA_INLINE will be enough to cover normal inline case and
>> tail-packing case?
> 
> Those definitions are user-visible.
> 
>>> * IOMAP_INLINE mappings always start at offset 0 and span an entire
>>> page, so they are always page aligned. IOMAP_TAIL mappings only need
>>
>> Why can't #0 page consist of more than one block/mapping? I didn't get what's
>> difference here.
> 
> Currently, iomap_write_begin will read the inline data into page #0
> and mark that page up-to-date. There's a check for that in
> iomap_write_end_inline. If a page contains more than one mapping, we
> won't be able to mark the entire page up to date anymore; we'd need to
> track which parts of the page are up to date and which are not. Iomap
> supports two tracking mechanisms, buffer heads and iomap_page, and
> we'd need to implement that tracking code for each of those cases.

Okay, I can understand now, so the reason here is the limitation (BUG_ON,
WARM_ON in iomap_inline_xxx functions) makes inline page should only contain one
mapping, then to generalize it, we should consider the unaligned case in between
page size and block size.

> 
>>> to be block aligned. If the block size is smaller than the page size,
>>
>> - reiserfs tries to find last page's content, if the size of that page's valid
>> content is smaller than threshold (at least less than one block), reiserfs can
>> do the packing.
>>
>> - erofs' block size is 4kb which is the same as page size.
>>
>>
>> Actually, for IOMAP_TAIL, there is no users who need to map more than one block
>> into metadata, so I'm not sure that we should support that, or we just need to
>> let code preparing for that to those potential users?
> 
> How about architectures with PAGE_SIZE > 4096? I'm assuming that erofs

We haven't considered the PAGE_SIZE > 4096 case yet.

> doesn't require block size == PAGE_SIZE?

At least now erofs block size is 4KB by default.

> 
>> Thanks,
>>
>>> a tail page can consist of more than one mapping. So
>>> iomap_read_inline_data needs to be changed to only copy a single block
>>> out of iomap->inline_data, and we need to adjust iomap_write_begin and
>>> iomap_readpage_actor accordingly.
>>>
>>> * Functions iomap_read_inline_data, iomap_write_end_inline, and
>>> iomap_dio_inline_actor currently all assume that we are operating on
>>> page 0, and that iomap->inline_data points at the data at offset 0.
>>> That's no longer the case for IOMAP_TAIL mappings. We need to look
>>> only at the offset within the page / block there.
>>>
>>> * There are some asserts like the following int he code:
>>>
>>>   BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
>>>
>>> Those should probably be tightened to check for block boundaries
>>> instead of page boundaries, i.e. something like:
>>>
>>>   BUG_ON(size > i_blocksize(inode) -
>>> offset_in_block(iomap->inline_data, inode));
>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/iomap.c | 4 +---
>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/iomap.c b/fs/iomap.c
>>>> index 12654c2e78f8..d1c16b692d31 100644
>>>> --- a/fs/iomap.c
>>>> +++ b/fs/iomap.c
>>>> @@ -264,13 +264,12 @@ static void
>>>>  iomap_read_inline_data(struct inode *inode, struct page *page,
>>>>                 struct iomap *iomap)
>>>>  {
>>>> -       size_t size = i_size_read(inode);
>>>> +       size_t size = iomap->length;
>>>
>>> Function iomap_read_inline_data fills the entire page here, not only
>>> the iomap->length part, so this is wrong. But see my comment above
>>> about changing iomap_read_inline_data to read a single block above as
>>> well.
>>>
>>>>         void *addr;
>>>>
>>>>         if (PageUptodate(page))
>>>>                 return;
>>>>
>>>> -       BUG_ON(page->index);
>>>>         BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
>>>>
>>>>         addr = kmap_atomic(page);
>>>> @@ -293,7 +292,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>>>>         sector_t sector;
>>>>
>>>>         if (iomap->type == IOMAP_INLINE) {
>>>> -               WARN_ON_ONCE(pos);
>>>>                 iomap_read_inline_data(inode, page, iomap);
>>>>                 return PAGE_SIZE;
>>>>         }
>>>
>>> Those last two changes look right to me.
>>>
>>> Thanks,
>>> Andreas
>>> .
>>>
> 
> At this point, can I ask how important this packing mechanism is to
> you? I can see a point in implementing inline files, which help
> because there tends to be a large number of very small files. But for
> not-so-small files, is saving an extra block really worth the trouble,
> especially given how cheap storage has become?

- Erofs is a readonly filesystem, we don't need to consider/design write path
for tail-pack feature, including writeback and inline conversion cases. So code
complex didn't trouble us.

- The files from real user's scenario are always unaligned to page size or block
size, so it can expect that part of files can be packed its tail data; and erofs
is used in consumer-electronics now (cell phone), there is no such large size
storage, we think that tail-packing can be one of compression/compaction
solutions in erofs to save storage space as much as possible.

Thanks,

> 
> Thanks,
> Andreas
> 
