Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 711FD141CA7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 07:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgASGzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 01:55:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52042 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbgASGzY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 01:55:24 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8D746BB766B624487531;
        Sun, 19 Jan 2020 14:55:21 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 14:55:15 +0800
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
 <64d617cc-e7fe-6848-03bb-aab3498c9a07@huawei.com>
 <20200119061402.GA7301@bombadil.infradead.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <fafa0550-184c-e59c-9b79-bd5d716a20cc@huawei.com>
Date:   Sun, 19 Jan 2020 14:55:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200119061402.GA7301@bombadil.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/1/19 14:14, Matthew Wilcox wrote:
> I don't understand your reasoning here.  If another process wants to
> access a page of the file which isn't currently in cache, it would have
> to first read the page in from storage.  If it's under readahead, it
> has to wait for the read to finish.  Why is the second case worse than
> the second?  It seems better to me.

Thanks for your response! My worries is that, for example:

We read page 0, and trigger readahead to read n pages(0 - n-1). While in 
another thread, we read page n-1.

In the current implementation, if readahead is in the process of reading
page 0 - n-2,  later operation doesn't need to wait the former one to 
finish. However, later operation will have to wait if we add all pages
to page cache first. And that is why I said it might cause problem for
performance overhead.

> At the same time, the iomap code is switched from ->readpages to
> ->readahead, so yes, the pages are added to the page cache.

Yes, it's not a problem in your implementation.

Thanks!
Yu Kuai

