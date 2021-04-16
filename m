Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3ED361B00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 10:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbhDPIBW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 04:01:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16468 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbhDPIBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:01:21 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FM7rF5mHJzwS9k;
        Fri, 16 Apr 2021 15:58:37 +0800 (CST)
Received: from [10.174.176.202] (10.174.176.202) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 16 Apr 2021 16:00:48 +0800
Subject: Re: [RFC PATCH v2 7/7] ext4: fix race between blkdev_releasepage()
 and ext4_put_super()
To:     Christoph Hellwig <hch@infradead.org>
CC:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yukuai3@huawei.com>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-8-yi.zhang@huawei.com>
 <20210415145235.GD2069063@infradead.org>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <ca810e21-5f92-ee6c-a046-255c70c6bf78@huawei.com>
Date:   Fri, 16 Apr 2021 16:00:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210415145235.GD2069063@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Christoph

On 2021/4/15 22:52, Christoph Hellwig wrote:
> On Wed, Apr 14, 2021 at 09:47:37PM +0800, Zhang Yi wrote:
>> There still exist a use after free issue when accessing the journal
>> structure and ext4_sb_info structure on freeing bdev buffers in
>> bdev_try_to_free_page(). The problem is bdev_try_to_free_page() could be
>> raced by ext4_put_super(), it dose freeing sb->s_fs_info and
>> sbi->s_journal while release page progress are still accessing them.
>> So it could end up trigger use-after-free or NULL pointer dereference.
> 
> I think the right fix is to not even call into ->bdev_try_to_free_page
> unless the superblock is active.
> .
> 
Thanks for your suggestions.

Now, we use already use "if (bdev->bd_super)" to prevent call into
->bdev_try_to_free_page unless the super is alive, and the problem is
bd_super becomes NULL concurrently after this check. So, IIUC, I think it's
the same to switch to check the superblock is active or not. The acvive
flag also could becomes inactive (raced by umount) after we call into
bdev_try_to_free_page().

In order to close this race, One solution is introduce a lock to synchronize
the active state between kill_block_super() and blkdev_releasepage(), but
the releasing page process have to try to acquire this lock in
blkdev_releasepage() for each page, and the umount process still need to wait
until the page release if some one invoke into ->bdev_try_to_free_page().
I think this solution may affect performace and is not a good way.
Think about it in depth, use percpu refcount seems have the smallest
performance effect on blkdev_releasepage().

If you don't like the refcount, maybe we could add synchronize_rcu_expedited()
in ext4_put_super(), it also could prevent this race. Any suggestions?

Thanks,
Yi.
