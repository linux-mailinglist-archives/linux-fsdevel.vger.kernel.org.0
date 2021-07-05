Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7083BB51E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 04:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhGECUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 22:20:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:9348 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGECUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 22:20:08 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GJ8Nm0Fdkz75XX;
        Mon,  5 Jul 2021 10:13:12 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 5 Jul 2021 10:17:30 +0800
Subject: Re: [powerpc][5.13.0-next-20210701] Kernel crash while running
 ltp(chdir01) tests
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Jan Kara <jack@suse.cz>, <linuxppc-dev@lists.ozlabs.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <26ACA75D-E13D-405B-9BFC-691B5FB64243@linux.vnet.ibm.com>
 <bf1c5b38-92f1-65db-e210-a97a199718ba@linux.dev>
 <4cc87ab3-aaa6-ed87-b690-5e5b99de8380@huawei.com>
 <03f734bd-f36e-f55b-0448-485b8a0d5b75@huawei.com> <YN86yl5kgVaRixxQ@mit.edu>
 <36778615-86fd-9a19-9bc9-f93a6f2d5817@huawei.com> <YN/a70ucYXu0DqGf@mit.edu>
 <66fb56cd-f1ff-c592-0202-0691372e32f5@huawei.com> <YOG/5ZY1AL05jumi@mit.edu>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <3acc3ee6-3a3d-3b26-7580-b20955270913@huawei.com>
Date:   Mon, 5 Jul 2021 10:17:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <YOG/5ZY1AL05jumi@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/7/4 22:04, Theodore Ts'o wrote:
> On Sat, Jul 03, 2021 at 12:55:09PM +0800, Zhang Yi wrote:
>> Yeah, it sounds good to me. Do you want me to send the fix patch, or you
>> modify your commit 8f9e16badb8fd in another email directly?
> 
> I've gone ahead and made the changes; what do you think?
> 
> I like how it also removes 40 lines of code.  :-)
> 

Thanks for the fix, this patch looks good to me besides one error
handling below.

> 
>>From ef3130d1b0b8ca769252d6a722a2e59a00141383 Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Fri, 2 Jul 2021 18:05:03 -0400
> Subject: [PATCH] ext4: inline jbd2_journal_[un]register_shrinker()
> 
> The function jbd2_journal_unregister_shrinker() was getting called
> twice when the file system was getting unmounted.  On Power and ARM
> platforms this was causing kernel crash when unmounting the file
> system, when a percpu_counter was destroyed twice.
> 
> Fix this by removing jbd2_journal_[un]register_shrinker() functions,
> and inlining the shrinker setup and teardown into
> journal_init_common() and jbd2_journal_destroy().  This means that
> ext4 and ocfs2 now no longer need to know about registering and
> unregistering jbd2's shrinker.
> 
> Also, while we're at it, rename the percpu counter from
> j_jh_shrink_count to j_checkpoint_jh_count, since this makes it
> clearer what this counter is intended to track.
> 
> Fixes: 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to release checkpointed buffers")
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/super.c      |   8 ---
>  fs/jbd2/checkpoint.c |   4 +-
>  fs/jbd2/journal.c    | 148 +++++++++++++++++--------------------------
>  include/linux/jbd2.h |   6 +-
>  4 files changed, 63 insertions(+), 103 deletions(-)
> 
[..]
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 152880c298ca..8a9c94dd3599 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
[..]
>  /*
>   * Management for journal control blocks: functions to create and
>   * destroy journal_t structures, and to initialise and read existing
> @@ -1361,6 +1403,19 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	journal->j_sb_buffer = bh;
>  	journal->j_superblock = (journal_superblock_t *)bh->b_data;
>  
> +	journal->j_shrink_transaction = NULL;
> +	journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
> +	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
> +	journal->j_shrinker.seeks = DEFAULT_SEEKS;
> +	journal->j_shrinker.batch = journal->j_max_transaction_buffers;
> +
> +	if (percpu_counter_init(&journal->j_checkpoint_jh_count, 0, GFP_KERNEL))
> +		goto err_cleanup;
> +
> +	if (register_shrinker(&journal->j_shrinker)) {
> +		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
> +		goto err_cleanup;
> +	}

Need to release j_sb_buffer in above two error path.

Thanks,
Yi.
