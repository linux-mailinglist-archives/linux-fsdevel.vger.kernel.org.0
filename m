Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E83524ACAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 03:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHTBjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 21:39:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgHTBjD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 21:39:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 69F0E3C0B36DF5F8F594;
        Thu, 20 Aug 2020 09:39:00 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.103) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 09:38:54 +0800
Subject: Re: [RFC PATCH V3] iomap: add support to track dirty state of sub
 pages
To:     Gao Xiang <hsiangkao@redhat.com>
CC:     <hch@infradead.org>, <darrick.wong@oracle.com>,
        <willy@infradead.org>, <david@fromorbit.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20200819120542.3780727-1-yukuai3@huawei.com>
 <20200819125608.GA24051@xiangao.remote.csb>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <43dc04bf-17bb-9f15-4f1c-dfd6c47c3fb1@huawei.com>
Date:   Thu, 20 Aug 2020 09:38:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200819125608.GA24051@xiangao.remote.csb>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.103]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/8/19 20:56, Gao Xiang wrote:
> On Wed, Aug 19, 2020 at 08:05:42PM +0800, Yu Kuai wrote:
> 
> ...
> 
>> +static void
>> +iomap_iop_set_range_dirty(struct page *page, unsigned int off,
>> +		unsigned int len)
>> +{
>> +	struct iomap_page *iop = to_iomap_page(page);
>> +	struct inode *inode = page->mapping->host;
>> +	unsigned int first = DIRTY_BITS(off >> inode->i_blkbits);
>> +	unsigned int last = DIRTY_BITS((off + len - 1) >> inode->i_blkbits);
>> +	unsigned long flags;
>> +	unsigned int i;
>> +
>> +	spin_lock_irqsave(&iop->state_lock, flags);
>> +	for (i = first; i <= last; i++)
>> +		set_bit(i, iop->state);
>> +
>> +	if (last >= first)
>> +		iomap_set_page_dirty(page);
> 
> set_page_dirty() in the atomic context?
> 

Hi,

You'are right, this shouldn't be inside spin_lock.

>> +
>> +	spin_unlock_irqrestore(&iop->state_lock, flags);
>> +}
>> +
>> +static void
>> +iomap_set_range_dirty(struct page *page, unsigned int off,
>> +		unsigned int len)
>> +{
>> +	if (PageError(page))
>> +		return;
>> +
>> +	if (page_has_private(page))
>> +		iomap_iop_set_range_dirty(page, off, len);
> 
> 
> I vaguely remembered iomap doesn't always set up PagePrivate.
>

If so, maybe I should move iomap_set_page_dirty() to
ioamp_set_range_dirty().

Thanks,
Yu Kuai

> 
> @@ -705,7 +770,7 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>   	if (unlikely(copied < len && !PageUptodate(page)))
>   		return 0;
>   	iomap_set_range_uptodate(page, offset_in_page(pos), len);
> -	iomap_set_page_dirty(page);
> +	iomap_set_range_dirty(page, offset_in_page(pos), len);
>   	return copied;
>   }
> 
> so here could be suspectable, but I might be wrong here since
> I just take a quick look.
> 
> Thanks,
> Gao Xiang
> 
> 
> .
> 

