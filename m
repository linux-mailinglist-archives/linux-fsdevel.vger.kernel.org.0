Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C75B57A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 09:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfGAHEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 03:04:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfGAHEN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:04:13 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 05444B0DB3AFBCB53823;
        Mon,  1 Jul 2019 15:04:10 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 1 Jul 2019
 15:03:59 +0800
Subject: Re: [PATCH RFC] iomap: introduce IOMAP_TAIL
To:     Chao Yu <yuchao0@huawei.com>
CC:     <hch@infradead.org>, <darrick.wong@oracle.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <chao@kernel.org>
References: <20190629073020.22759-1-yuchao0@huawei.com>
 <afda5702-1d88-7634-d943-0c413ae3b28f@huawei.com>
 <a27e3502-db75-22fa-4545-e588abbbfbf2@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <58511d64-aa7a-8ac2-0255-affe0e8d49de@huawei.com>
Date:   Mon, 1 Jul 2019 15:03:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <a27e3502-db75-22fa-4545-e588abbbfbf2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/7/1 14:40, Chao Yu wrote:
> Hi Xiang,
> 
> On 2019/6/29 17:34, Gao Xiang wrote:
>> Hi Chao,
>>
>> On 2019/6/29 15:30, Chao Yu wrote:
>>> Some filesystems like erofs/reiserfs have the ability to pack tail
>>> data into metadata, however iomap framework can only support mapping
>>> inline data with IOMAP_INLINE type, it restricts that:
>>> - inline data should be locating at page #0.
>>> - inline size should equal to .i_size
>>> So we can not use IOMAP_INLINE to handle tail-packing case.
>>>
>>> This patch introduces new mapping type IOMAP_TAIL to map tail-packed
>>> data for further use of erofs.
>>>
>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>> ---
>>>  fs/iomap.c            | 22 ++++++++++++++++++++++
>>>  include/linux/iomap.h |  1 +
>>>  2 files changed, 23 insertions(+)
>>>
>>> diff --git a/fs/iomap.c b/fs/iomap.c
>>> index 12654c2e78f8..ae7777ce77d0 100644
>>> --- a/fs/iomap.c
>>> +++ b/fs/iomap.c
>>> @@ -280,6 +280,23 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
>>>  	SetPageUptodate(page);
>>>  }
>>>  
>>> +static void
>>> +iomap_read_tail_data(struct inode *inode, struct page *page,
>>> +		struct iomap *iomap)
>>> +{
>>> +	size_t size = i_size_read(inode) & (PAGE_SIZE - 1);
>>> +	void *addr;
>>> +
>>> +	if (PageUptodate(page))
>>> +		return;
>>> +
>>> +	addr = kmap_atomic(page);
>>> +	memcpy(addr, iomap->inline_data, size);
>>> +	memset(addr + size, 0, PAGE_SIZE - size);
>>
>> need flush_dcache_page(page) here for new page cache page since
>> it's generic iomap code (althrough not necessary for x86, arm), I am not sure...
>> see commit d2b2c6dd227b and c01778001a4f...
> 
> Thanks for your reminding, these all codes were copied from
> iomap_read_inline_data(), so I think we need a separated patch to fix this issue
> if necessary.

Yes, just a reminder, it is good as it-is.

Thanks,
Gao Xiang

> 
> Thanks,
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>> +	kunmap_atomic(addr);
>>> +	SetPageUptodate(page);
>>> +}
>>> +
>>>  static loff_t
>>>  iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>>>  		struct iomap *iomap)
>>> @@ -298,6 +315,11 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>>>  		return PAGE_SIZE;
>>>  	}
>>>  
>>> +	if (iomap->type == IOMAP_TAIL) {
>>> +		iomap_read_tail_data(inode, page, iomap);
>>> +		return PAGE_SIZE;
>>> +	}
>>> +
>>>  	/* zero post-eof blocks as the page may be mapped */
>>>  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
>>>  	if (plen == 0)
>>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>>> index 2103b94cb1bf..7e1ee48e3db7 100644
>>> --- a/include/linux/iomap.h
>>> +++ b/include/linux/iomap.h
>>> @@ -25,6 +25,7 @@ struct vm_fault;
>>>  #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
>>>  #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
>>>  #define IOMAP_INLINE	0x05	/* data inline in the inode */
>>> +#define IOMAP_TAIL	0x06	/* tail data packed in metdata */
>>>  
>>>  /*
>>>   * Flags for all iomap mappings:
>>>
>> .
>>
