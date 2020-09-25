Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1FC277DEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 04:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgIYCag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 22:30:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33630 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbgIYCag (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 22:30:36 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2A154FD2CAD2270D1B42;
        Fri, 25 Sep 2020 10:30:33 +0800 (CST)
Received: from [10.174.179.103] (10.174.179.103) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 25 Sep 2020 10:30:22 +0800
Subject: Re: [RFC PATCH V4] iomap: add support to track dirty state of sub
 pages
To:     Matthew Wilcox <willy@infradead.org>
CC:     <hch@infradead.org>, <darrick.wong@oracle.com>,
        <david@fromorbit.com>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20200821123306.1658495-1-yukuai3@huawei.com>
 <20200821124424.GQ17456@casper.infradead.org>
 <7fb4bb5a-adc7-5914-3aae-179dd8f3adb1@huawei.com>
 <20200911120529.GZ6583@casper.infradead.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <7b160e03-28b8-32b0-244c-bfa7f4127434@huawei.com>
Date:   Fri, 25 Sep 2020 10:30:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200911120529.GZ6583@casper.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.103]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2020/09/11 20:05, Matthew Wilcox wrote:
>> @@ -683,7 +736,7 @@ static size_t __iomap_write_end(struct inode *inode,
>> loff_t pos, size_t len,
>>   	if (unlikely(copied < len && !PageUptodate(page)))
>>   		return 0;
>>   	iomap_set_range_uptodate(page, offset_in_page(pos), len);
>> -	iomap_set_page_dirty(page);
>> +	iomap_set_range_dirty(page, offset_in_page(pos), len);
> I_think_  the call to set_range_uptodate here is now unnecessary.  The
> blocks should already have been set uptodate in write_begin.  But please
> check!

Hi, Matthew

Sorry it took me so long to get back to this.

I found that set_range_uptodate() might be skipped in write_begin()
in this case:

                  if (!(flags & IOMAP_WRITE_F_UNSHARE) &&
                   ©®   (from <= poff || from >= poff + plen) &&
                   ©®   (to <= poff || to >= poff + plen))
                           continue;

And iomap_adjust_read_range() can set 'poff' greater than 'from'
and 'poff + len' less than 'to'.

Thanks
Yu Kuai
