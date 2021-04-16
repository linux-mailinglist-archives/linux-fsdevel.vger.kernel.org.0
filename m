Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2E9361AFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 10:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbhDPIBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 04:01:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16596 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbhDPIBJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:01:09 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FM7r060msz17QdP;
        Fri, 16 Apr 2021 15:58:24 +0800 (CST)
Received: from [10.174.176.202] (10.174.176.202) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 16 Apr 2021 16:00:35 +0800
Subject: Re: [RFC PATCH v2 6/7] fs: introduce a usage count into the
 superblock
To:     Christoph Hellwig <hch@infradead.org>
CC:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yukuai3@huawei.com>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-7-yi.zhang@huawei.com>
 <20210415144056.GA2069063@infradead.org>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <a35319b2-8d5d-2a32-9284-d1828ec4d9df@huawei.com>
Date:   Fri, 16 Apr 2021 16:00:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210415144056.GA2069063@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Christoph

On 2021/4/15 22:40, Christoph Hellwig wrote:
> On Wed, Apr 14, 2021 at 09:47:36PM +0800, Zhang Yi wrote:
>> Commit <87d8fe1ee6b8> ("add releasepage hooks to block devices which can
>> be used by file systems") introduce a hook that used by ext4 filesystem
>> to release journal buffers, but it doesn't add corresponding concurrency
>> protection that ->bdev_try_to_free_page() could be raced by umount
>> filesystem concurrently. This patch add a usage count on superblock that
>> filesystem can use it to prevent above race and make invoke
>> ->bdev_try_to_free_page() safe.
> 
> We already have two refcounts in the superblock: s_active which counts
> the active refernce, and s_count which prevents the data structures
> from beeing freed.  I don't think we need yet another one.
> .
> 

Thanks you for your response. I checked the s_count and s_active refcounts,
but it seems that we could not use these two refcounts directly.

For the s_active. If we get s_active refcount in blkdev_releasepage(), we may
put the final refcount when doing umount concurrently and have to do resource
recycling, but we got page locked here and lead to deadlock. Maybe we could do
async resource recycling through kworker, but I think it's not a good way.

For the s_count, it is operated under the global sb_lock now, so get this
refcount will serialize page release and affect performance. Besides, It's
semantics are different from the 'usage count' by private fileststem, and we
have to cooperate with sb->s_umount mutex lock to close the above race.

So I introduce another refcount. Am I missing something or any suggestions?

Thanks,
Yi.
