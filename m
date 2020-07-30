Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279C5232A47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 05:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgG3DNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 23:13:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8854 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbgG3DNP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:13:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0D9F3ACDF479E1EF6CB6;
        Thu, 30 Jul 2020 11:13:13 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.103) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 11:13:03 +0800
Subject: Re: [RFC PATCH] iomap: add support to track dirty state of sub pages
To:     Gao Xiang <hsiangkao@redhat.com>
CC:     <hch@infradead.org>, <darrick.wong@oracle.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20200730011901.2840886-1-yukuai3@huawei.com>
 <20200730022736.GA23366@xiangao.remote.csb>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <7a5923ce-812f-f372-d751-b59f69d9544f@huawei.com>
Date:   Thu, 30 Jul 2020 11:13:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200730022736.GA23366@xiangao.remote.csb>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.103]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/7/30 10:27, Gao Xiang wrote:
> Hi Kuai,
> 
> On Thu, Jul 30, 2020 at 09:19:01AM +0800, Yu Kuai wrote:
>> commit 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O
>> without buffer heads") replace the per-block structure buffer_head with
>> the per-page structure iomap_page. However, iomap_page can't track the
>> dirty state of sub pages, which will cause performance issue since sub
>> pages will be writeback even if they are not dirty.
>>
>> For example, if block size is 4k and page size is 64k:
>>
>> dd if=/dev/zero of=testfile bs=4k count=16 oflag=sync
>>
>> With buffer_head implementation, the above dd cmd will writeback 4k in
>> each round. However, with iomap_page implementation, the range of
>> writeback in each round is from the start of the page to the end offset
>> we just wrote.
>>
>> Thus add support to track dirty state for sub pages in iomap_page.
> 
> AFAIK, the current focus is also on the numbers in the original
> discussion thread, so it'd be better to show some numbers with
> large PAGE_SIZE on this with some workloads as well.
> 
> https://lore.kernel.org/r/20200729230503.GA2005@dread.disaster.area
> 

Hi, Xiang!

The problem was found by iozone to test 4k sequintail write in my
case, thanks for pointing out the discussion thread. I'll test it if
this patch have any effect on that situation.

Thanks,
Yu Kuai

> e.g. My guess is if the dirty blocks in the page are highly fragmented, maybe
> it'd be better to writeback the whole page in an IO rather than individual blocks.
> 
> At a very quick glance, the approach looks good to me.
> 
> Thanks,
> Gao Xiang
> 
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   fs/iomap/buffered-io.c | 51 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index bcfc288dba3f..ac2676146b98 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -29,7 +29,9 @@ struct iomap_page {
>>   	atomic_t		read_count;
>>   	atomic_t		write_count;
>>   	spinlock_t		uptodate_lock;
>> +	spinlock_t		dirty_lock;
>>   	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
>> +	DECLARE_BITMAP(dirty, PAGE_SIZE / 512);
>>   };
>>   
>>   static inline struct iomap_page *to_iomap_page(struct page *page)
>> @@ -53,7 +55,9 @@ iomap_page_create(struct inode *inode, struct page *page)
>>   	atomic_set(&iop->read_count, 0);
>>   	atomic_set(&iop->write_count, 0);
>>   	spin_lock_init(&iop->uptodate_lock);
>> +	spin_lock_init(&iop->dirty_lock);
>>   	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
>> +	bitmap_zero(iop->dirty, PAGE_SIZE / SECTOR_SIZE);
>>   
>>   	/*
>>   	 * migrate_page_move_mapping() assumes that pages with private data have
>> @@ -135,6 +139,44 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
>>   	*lenp = plen;
>>   }
>>   
>> +static void
>> +iomap_iop_set_or_clear_range_dirty(
>> +	struct page *page,
>> +	unsigned int off,
>> +	unsigned int len,
>> +	bool is_set)
>> +{
>> +	struct iomap_page *iop = to_iomap_page(page);
>> +	struct inode *inode = page->mapping->host;
>> +	unsigned int first = off >> inode->i_blkbits;
>> +	unsigned int last = (off + len - 1) >> inode->i_blkbits;
>> +	unsigned long flags;
>> +	unsigned int i;
>> +
>> +	spin_lock_irqsave(&iop->dirty_lock, flags);
>> +	for (i = first; i <= last; i++)
>> +		if (is_set)
>> +			set_bit(i, iop->dirty);
>> +		else
>> +			clear_bit(i, iop->dirty);
>> +	spin_unlock_irqrestore(&iop->dirty_lock, flags);
>> +}
>> +
>> +static void
>> +iomap_set_or_clear_range_dirty(
>> +	struct page *page,
>> +	unsigned int off,
>> +	unsigned int len,
>> +	bool is_set)
>> +{
>> +	if (PageError(page))
>> +		return;
>> +
>> +	if (page_has_private(page))
>> +		iomap_iop_set_or_clear_range_dirty(
>> +			page, off, len, is_set);
> 3> +}
>> +
>>   static void
>>   iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>>   {
>> @@ -705,6 +747,8 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>>   	if (unlikely(copied < len && !PageUptodate(page)))
>>   		return 0;
>>   	iomap_set_range_uptodate(page, offset_in_page(pos), len);
>> +	iomap_set_or_clear_range_dirty(
>> +		page, offset_in_page(pos), len, true);
>>   	iomap_set_page_dirty(page);
>>   	return copied;
>>   }
>> @@ -1030,6 +1074,8 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
>>   		WARN_ON_ONCE(!PageUptodate(page));
>>   		iomap_page_create(inode, page);
>>   		set_page_dirty(page);
>> +		iomap_set_or_clear_range_dirty(
>> +			page, offset_in_page(pos), length, true);
>>   	}
>>   
>>   	return length;
>> @@ -1386,7 +1432,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>>   	for (i = 0, file_offset = page_offset(page);
>>   	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
>>   	     i++, file_offset += len) {
>> -		if (iop && !test_bit(i, iop->uptodate))
>> +		if (iop && (!test_bit(i, iop->uptodate) ||
>> +		    !test_bit(i, iop->dirty)))
>>   			continue;
>>   
>>   		error = wpc->ops->map_blocks(wpc, inode, file_offset);
>> @@ -1435,6 +1482,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>>   		 */
>>   		set_page_writeback_keepwrite(page);
>>   	} else {
>> +		iomap_set_or_clear_range_dirty(
>> +			page, 0, end_offset - page_offset(page) + 1, false);
>>   		clear_page_dirty_for_io(page);
>>   		set_page_writeback(page);
>>   	}
>> -- 
>> 2.25.4
>>
> 
> 
> .
> 

