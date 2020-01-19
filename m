Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3F141B53
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgASDCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:02:17 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2930 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727403AbgASDCR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:02:17 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id D0202295F3B082559A47;
        Sun, 19 Jan 2020 11:02:12 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 19 Jan 2020 11:02:11 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sun, 19 Jan 2020 11:02:10 +0800
Date:   Sun, 19 Jan 2020 11:01:25 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
CC:     Matthew Wilcox <willy@infradead.org>, <hch@infradead.org>,
        <darrick.wong@oracle.com>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <houtao1@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>
Subject: Re: [RFC] iomap: fix race between readahead and direct write
Message-ID: <20200119030123.GA223124@architecture4>
References: <20200116063601.39201-1-yukuai3@huawei.com>
 <20200118230826.GA5583@bombadil.infradead.org>
 <f5328338-1a2d-38b4-283f-3fb97ad37133@huawei.com>
 <20200119014213.GA16943@bombadil.infradead.org>
 <64d617cc-e7fe-6848-03bb-aab3498c9a07@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64d617cc-e7fe-6848-03bb-aab3498c9a07@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 19, 2020 at 10:51:37AM +0800, yukuai (C) wrote:
> 
> 
> Then, there might be a problem in your implementation.
> if 'use_list' is set to true here:
> +	bool use_list = mapping->a_ops->readpages;
> 
> Your code do not call add_to_page_cache_lru for the page.

IMO, if use_list == true, it will call read_pages -> .readpages
and go just like the current implementation.

->.readahead is just alloc_page and then add_to_page_cache_lru
right after in time and in principle it saves some extra page
allocation.

Thanks,
Gao Xiang

> +		if (use_list) {
> +			page->index = page_offset;
> +			list_add(&page->lru, &page_pool);
> +		} else if (!add_to_page_cache_lru(page, mapping, page_offset,
> +					gfp_mask)) {
> +			if (nr_pages)
> +				read_pages(mapping, filp, &page_pool,
> +						page_offset - nr_pages,
> +						nr_pages);
> +			nr_pages = 0;
> +			continue;
> +		}
> 
