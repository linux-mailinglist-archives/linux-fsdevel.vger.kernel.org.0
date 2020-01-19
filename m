Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC22141D82
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 12:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgASLVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 06:21:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbgASLVi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 06:21:38 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0ABED6294A04E21031CF;
        Sun, 19 Jan 2020 19:21:36 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 19:21:26 +0800
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
 <fafa0550-184c-e59c-9b79-bd5d716a20cc@huawei.com>
 <20200119075828.GA4147@bombadil.infradead.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <16241bd6-e3f9-5272-92aa-b31cc0a2b2fa@huawei.com>
Date:   Sun, 19 Jan 2020 19:21:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200119075828.GA4147@bombadil.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/1/19 15:58, Matthew Wilcox wrote:
> On Sun, Jan 19, 2020 at 02:55:14PM +0800, yukuai (C) wrote:
>> On 2020/1/19 14:14, Matthew Wilcox wrote:
>>> I don't understand your reasoning here.  If another process wants to
>>> access a page of the file which isn't currently in cache, it would have
>>> to first read the page in from storage.  If it's under readahead, it
>>> has to wait for the read to finish.  Why is the second case worse than
>>> the second?  It seems better to me.
>>
>> Thanks for your response! My worries is that, for example:
>>
>> We read page 0, and trigger readahead to read n pages(0 - n-1). While in
>> another thread, we read page n-1.
>>
>> In the current implementation, if readahead is in the process of reading
>> page 0 - n-2,  later operation doesn't need to wait the former one to
>> finish. However, later operation will have to wait if we add all pages
>> to page cache first. And that is why I said it might cause problem for
>> performance overhead.
> 
> OK, but let's put some numbers on that.  Imagine that we're using high
> performance spinning rust so we have an access latency of 5ms (200
> IOPS), we're accessing 20 consecutive pages which happen to have their
> data contiguous on disk.  Our CPU is running at 2GHz and takes about
> 100,000 cycles to submit an I/O, plus 1,000 cycles to add an extra page
> to the I/O.
> 
> Current implementation: Allocate 20 pages, place 19 of them in the cache,
> fail to place the last one in the cache.  The later thread actually gets
> to jump the queue and submit its bio first.  Its latency will be 100,000
> cycles (20us) plus the 5ms access time.  But it only has 20,000 cycles
> (4us) to hit this race, or it will end up behaving the same way as below.
> 
> New implementation: Allocate 20 pages, place them all in the cache,
> then takes 120,000 cycles to build & submit the I/O, and wait 5ms for
> the I/O to complete.
> 
> But look how much more likely it is that it'll hit during the window
> where we're waiting for the I/O to complete -- 5ms is 1250 times longer
> than 4us.
> 
> If it _does_ get the latency benefit of jumping the queue, the readahead
> will create one or two I/Os.  If it hit page 18 instead of page 19, we'd
> end up doing three I/Os; the first for page 18, then one for pages 0-17,
> and one for page 19.  And that means the disk is going to be busy for
> 15ms, delaying the next I/O for up to 10ms.  It's actually beneficial in
> the long term for the second thread to wait for the readahead to finish.
> 

Thank you very much for your detailed explanation, I was too blind for
my sided view. And I do agree that your patch series is a better
solution for the problem.

Yu Kuai

