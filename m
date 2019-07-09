Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2386374E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 15:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfGINwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 09:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfGINwd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:52:33 -0400
Received: from [192.168.0.101] (unknown [49.65.245.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51DD520844;
        Tue,  9 Jul 2019 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562680352;
        bh=xarlzDc9XL3XreQ+2eiaoGghb7avU3rBbaxLzUdH5VY=;
        h=Subject:Cc:References:To:From:Date:In-Reply-To:From;
        b=QpgxXBy3Ik7Yy0x02Ut3hhM0Agi+n/vn1AALkpCs3rqJGKfpG7O/4aqhcUBe0Hw2N
         sGFarVvEQ28ZsNX6Sc1hEPj6Hf2LGy7PpxLYUe+q+4G9e9wPzkaAOwtbfan1mTS5Xa
         KC8AQmyCJTUtwRrhY+IFH1B2wDmTv0OAWDLZwgRk=
Subject: Re: [RFC PATCH] iomap: generalize IOMAP_INLINE to cover tail-packing
 case
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gaoxiang25@huawei.com
References: <20190703075502.79782-1-yuchao0@huawei.com>
 <20190708160346.GA17715@infradead.org>
To:     andreas.gruenbacher@gmail.com
From:   Chao Yu <chao@kernel.org>
Message-ID: <1c3f46ba-c1e4-3177-d77e-627995bc8f21@kernel.org>
Date:   Tue, 9 Jul 2019 21:52:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190708160346.GA17715@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-7-9 0:03, Christoph Hellwig wrote:
> On Wed, Jul 03, 2019 at 03:55:02PM +0800, Chao Yu wrote:
>> Some filesystems like erofs/reiserfs have the ability to pack tail
>> data into metadata, e.g.:
>> IOMAP_MAPPED [0, 8192]
>> IOMAP_INLINE [8192, 8200]
>>
>> However current IOMAP_INLINE type has assumption that:
>> - inline data should be locating at page #0.
>> - inline size should equal to .i_size
>> Those restriction fail to convert to use iomap IOMAP_INLINE in erofs,
>> so this patch tries to relieve above limits to make IOMAP_INLINE more
>> generic to cover tail-packing case.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> 
> This looks good to me, but I'd also like to see a review and gfs2
> testing from Andreas.

Thanks for your reply. :)

Well, so, Andreas, could you please take a look at this patch and do related
test on gfs2 if you have time?

Thanks,

> 
