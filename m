Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84621369137
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhDWLj4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 07:39:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17032 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhDWLjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 07:39:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FRXL52N1dzPrtw;
        Fri, 23 Apr 2021 19:36:13 +0800 (CST)
Received: from [10.174.176.202] (10.174.176.202) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Fri, 23 Apr 2021 19:39:10 +0800
Subject: Re: [RFC PATCH v2 7/7] ext4: fix race between blkdev_releasepage()
 and ext4_put_super()
To:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
CC:     Christoph Hellwig <hch@infradead.org>,
        <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-8-yi.zhang@huawei.com>
 <20210415145235.GD2069063@infradead.org>
 <ca810e21-5f92-ee6c-a046-255c70c6bf78@huawei.com>
 <20210420130841.GA3618564@infradead.org>
 <20210421134634.GT8706@quack2.suse.cz> <YIBZgx4cm0j7OObj@mit.edu>
 <20210422090410.GA26221@quack2.suse.cz>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <9c83866e-7517-2051-8894-bca2892df1b6@huawei.com>
Date:   Fri, 23 Apr 2021 19:39:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210422090410.GA26221@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/4/22 17:04, Jan Kara wrote:
> On Wed 21-04-21 12:57:39, Theodore Ts'o wrote:
>> On Wed, Apr 21, 2021 at 03:46:34PM +0200, Jan Kara wrote:
>>>
>>> Indeed, after 12 years in kernel .bdev_try_to_free_page is implemented only
>>> by ext4. So maybe it is not that important? I agree with Zhang and
>>> Christoph that getting the lifetime rules sorted out will be hairy and it
>>> is questionable, whether it is worth the additional pages we can reclaim.
>>> Ted, do you remember what was the original motivation for this?
>>
>> The comment in fs/ext4/super.c is I thought a pretty good explanation:
>>
>> /*
>>  * Try to release metadata pages (indirect blocks, directories) which are
>>  * mapped via the block device.  Since these pages could have journal heads
>>  * which would prevent try_to_free_buffers() from freeing them, we must use
>>  * jbd2 layer's try_to_free_buffers() function to release them.
>>  */
>>
>> When we modify a metadata block, we attach a journal_head (jh)
>> structure to the buffer_head, and bump the ref count to prevent the
>> buffer from being freed.  Before the transaction is committed, the
>> buffer is marked jbddirty, but the dirty bit is not set until the
>> transaction commit.
>>
>> At that back, writeback happens entirely at the discretion of the
>> buffer cache.  The jbd layer doesn't get notification when the I/O is
>> completed, nor when there is an I/O error.  (There was an attempt to
>> add a callback but that was NACK'ed because of a complaint that it was
>> jbd specific.)
>>
>> So we don't actually know when it's safe to detach the jh from the
>> buffer_head and can drop the refcount so that the buffer_head can be
>> freed.  When the space in the journal starts getting low, we'll look
>> at at the jh's attached to completed transactions, and see how many of
>> them have clean bh's, and at that point, we can release the buffer
>> heads.
>>
>> The other time when we'll attempt to detach jh's from clean buffers is
>> via bdev_try_to_free_buffers().  So if we drop the
>> bdev_try_to_free_page hook, then when we are under memory pressure,
>> there could be potentially a large percentage of the buffer cache
>> which can't be freed, and so the OOM-killer might trigger more often.
> 
> Yes, I understand that. What I was more asking about is: Does it really
> matter we leave those buffer heads and journal heads unreclaimed. I
> understand it could be triggering premature OOM in theory but is it a
> problem in practice? Was there some observed practical case for which this
> was added or was it just added due to the theoretical concern?
> 
>> Now, if we could get a callback on I/O completion on a per-bh basis,
>> then we could detach the jh when the buffer is clean --- and as a
>> bonus, we'd get a notification when there was an I/O error writing
>> back a metadata block, which would be even better.
>>
>> So how about an even swap?  If we can get a buffer I/O completion
>> callback, we can drop bdev_to_free_swap hook.....
> 
> I'm OK with that because mainly for IO error reporting it makes sense to
> me. For this memory reclaim problem I think we have also other reasonably
> sensible options. E.g. we could have a shrinker that would just walk the
> checkpoint list and reclaim journal heads for whatever is already written
> out... Or we could just release journal heads already after commit and
> during checkpoint we'd fetch the list of blocks that may need to be written
> out e.g. from journal descriptor blocks. This would be a larger overhaul
> but as a bonus we'd get rid of probably the last place in the kernel which
> can write out page contents through buffer heads without updating page
> state properly (and thus get rid of some workarounds in mm code as well).

Thanks for these suggestions, I get your first solution and sounds good, but
I do not understand your last sentence, how does ext4 not updating page state
properly? Could you explain it more clearly?

Thanks,
Yi.
