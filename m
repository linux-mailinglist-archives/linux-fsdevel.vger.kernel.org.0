Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214635B5BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 09:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfGAH3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 03:29:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727224AbfGAH3I (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:29:08 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8E0CDA2A93B2EA46620D;
        Mon,  1 Jul 2019 15:29:06 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 1 Jul 2019
 15:28:56 +0800
Subject: Re: [PATCH RFC] iomap: introduce IOMAP_TAIL
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <hch@infradead.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <gaoxiang25@huawei.com>,
        <chao@kernel.org>
References: <20190629073020.22759-1-yuchao0@huawei.com>
 <20190630231932.GI1404256@magnolia>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d19c48ad-5a4c-e2e3-e5cc-22c78757334f@huawei.com>
Date:   Mon, 1 Jul 2019 15:28:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190630231932.GI1404256@magnolia>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/7/1 7:19, Darrick J. Wong wrote:
> On Sat, Jun 29, 2019 at 03:30:20PM +0800, Chao Yu wrote:
>> Some filesystems like erofs/reiserfs have the ability to pack tail
>> data into metadata, however iomap framework can only support mapping
>> inline data with IOMAP_INLINE type, it restricts that:
>> - inline data should be locating at page #0.
>> - inline size should equal to .i_size
> 
> Wouldn't it be easier simply to fix the meaning of IOMAP_INLINE so that
> it can be used at something other than offset 0 and length == isize?
> IOWs, make it mean "use the *inline_data pointer to read/write data
> as a direct memory access"?

I thought about that, finally I implemented this by adding a new type because:
-  I checked fs.h, noticing that there are two separated flags:
FS_INLINE_DATA_FL and FS_NOTAIL_FL, I guess they are separated features, but not
sure about it...
- If we keep those restriction of inline data, maybe we can help to do sanity
check on inline data for most inline function callers additionally, since most
filesystems implement inline_data feature with restriction by default.

Anyway, I can change IOMAP_INLINE's restriction, and adjust erofs to use it if
there is no further concern on those restrictions.

> 
> I also don't really like the idea of leaving the write paths
> unimplemented in core code, though I suppose as an erofs developer
> you're not likely to have a good means for testing... :/

Yes, I don't like it too, but previously I didn't add it because I'm not sure
that, recently we have potential user of IOMAP_TAIL's write path except
reiserfs, it may be out-of-{maintain,test} due to lack of user later....

> 
> /me starts wondering if a better solution would be to invent iomaptestfs
> which exists solely to test all iomap code with as little other
> intelligence as possible...

Good idea, any plan on this fs? :)

Now, for erofs, as we don't support mapping hole, so I just inject code to force
covering IOMAP_HOLE path. :P

Thanks,

> 
> --D
> 
>> So we can not use IOMAP_INLINE to handle tail-packing case.
>>
>> This patch introduces new mapping type IOMAP_TAIL to map tail-packed
>> data for further use of erofs.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/iomap.c            | 22 ++++++++++++++++++++++
>>  include/linux/iomap.h |  1 +
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/fs/iomap.c b/fs/iomap.c
>> index 12654c2e78f8..ae7777ce77d0 100644
>> --- a/fs/iomap.c
>> +++ b/fs/iomap.c
>> @@ -280,6 +280,23 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
>>  	SetPageUptodate(page);
>>  }
>>  
>> +static void
>> +iomap_read_tail_data(struct inode *inode, struct page *page,
>> +		struct iomap *iomap)
>> +{
>> +	size_t size = i_size_read(inode) & (PAGE_SIZE - 1);
>> +	void *addr;
>> +
>> +	if (PageUptodate(page))
>> +		return;
>> +
>> +	addr = kmap_atomic(page);
>> +	memcpy(addr, iomap->inline_data, size);
>> +	memset(addr + size, 0, PAGE_SIZE - size);
>> +	kunmap_atomic(addr);
>> +	SetPageUptodate(page);
>> +}
>> +
>>  static loff_t
>>  iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>>  		struct iomap *iomap)
>> @@ -298,6 +315,11 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>>  		return PAGE_SIZE;
>>  	}
>>  
>> +	if (iomap->type == IOMAP_TAIL) {
>> +		iomap_read_tail_data(inode, page, iomap);
>> +		return PAGE_SIZE;
>> +	}
>> +
>>  	/* zero post-eof blocks as the page may be mapped */
>>  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
>>  	if (plen == 0)
>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>> index 2103b94cb1bf..7e1ee48e3db7 100644
>> --- a/include/linux/iomap.h
>> +++ b/include/linux/iomap.h
>> @@ -25,6 +25,7 @@ struct vm_fault;
>>  #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
>>  #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
>>  #define IOMAP_INLINE	0x05	/* data inline in the inode */
>> +#define IOMAP_TAIL	0x06	/* tail data packed in metdata */
>>  
>>  /*
>>   * Flags for all iomap mappings:
>> -- 
>> 2.18.0.rc1
>>
> .
> 
