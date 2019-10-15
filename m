Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA4DD77B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 15:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbfJONum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 09:50:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728652AbfJONum (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:50:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 69A1C8D7789845CC527B;
        Tue, 15 Oct 2019 21:50:39 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
 21:50:31 +0800
Subject: Re: [PATCH] iomap: fix the logic about poll io in iomap_dio_bio_actor
To:     Christoph Hellwig <hch@infradead.org>
CC:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <houtao1@huawei.com>
References: <20191014144313.26313-1-yangerkun@huawei.com>
 <20191015080541.GE3055@infradead.org>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <1ed52fe7-b1b8-0a90-5079-16d9b6593ca4@huawei.com>
Date:   Tue, 15 Oct 2019 21:50:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191015080541.GE3055@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/10/15 16:05, Christoph Hellwig wrote:
> On Mon, Oct 14, 2019 at 10:43:13PM +0800, yangerkun wrote:
>> Just set REQ_HIPRI for the last bio in iomap_dio_bio_actor. Because
>> multi bio created by this function can goto different cpu since this
>> process can be preempted by other process. And in iomap_dio_rw we will
>> just poll for the last bio. Fix it by only set polled for the last bio.
> 
> I agree that there is a problem with the separate poll queue now.  But
> doing partially polled I/O also doesn't seem very useful.  Until we
> can find a way to poll for multiple bios from one kiocb I think we need
> to limit polling to iocbs with just a single bio.  Can you look into
> that?  __blkdev_direct_IO do_blockdev_direct_IO probably have the same
> issues.  The former should be just as simple to fix, and for the latter
> it might make sense to drop polling support entirely.
> 
Thanks for your suggestion, i will try to fix it.

Thanks,
Kun.
> 

