Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4BA141B16
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 02:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgASB5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 20:57:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbgASB5N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:57:13 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 40710B6CE2308EE686D5;
        Sun, 19 Jan 2020 09:57:11 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 09:57:05 +0800
Subject: Re: [RFC] iomap: fix race between readahead and direct write
To:     Matthew Wilcox <willy@infradead.org>
CC:     <hch@infradead.org>, <darrick.wong@oracle.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
References: <20200116063601.39201-1-yukuai3@huawei.com>
 <20200118230826.GA5583@bombadil.infradead.org>
 <f5328338-1a2d-38b4-283f-3fb97ad37133@huawei.com>
 <20200119014213.GA16943@bombadil.infradead.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <857fa4e7-c529-40cf-9916-151d91e815c4@huawei.com>
Date:   Sun, 19 Jan 2020 09:57:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200119014213.GA16943@bombadil.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/1/19 9:42, Matthew Wilcox wrote:
> Did you read my patch series?  The current code allocates pages,
> but does not put them in the page cache until after iomap is called.
> My patch series changes that to put the pages in the page cache as soon
> as they're allocated, and before iomap is called.

The current code to determin if page need to be allocated:

     page = xa_load(&mapping->i_pages, page_offset);
     if (page && !xa_is_value(page)) {
       /*
       ©®* Page already present?  Kick off the current batch of
       ©®* contiguous pages before continuing with the next
       ©®* batch.
       ©®*/
       if (nr_pages)
         read_pages(mapping, filp, &page_pool, nr_pages,
             gfp_mask);
       nr_pages = 0;
       continue;
     }

     page = __page_cache_alloc(gfp_mask);
     if (!page)
       break;

Page will be allocated if the page do not exist in page cache. And I
don't see your patch series change that. Or am I missing something?

Thanks£¡
Yu Kuai

