Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE68461468E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 10:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiKAJY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 05:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAJY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:24:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0DB1209B;
        Tue,  1 Nov 2022 02:24:55 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1l370vNRzHvWF;
        Tue,  1 Nov 2022 17:24:35 +0800 (CST)
Received: from [10.67.110.83] (10.67.110.83) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:24:52 +0800
Subject: Re: [PATCH] squashfs: fix null-ptr-deref in squashfs_fill_super
To:     Baokun Li <libaokun1@huawei.com>, <linux-kernel@vger.kernel.org>
CC:     <phillip@squashfs.org.uk>, <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
References: <20221101073343.3961562-1-libaokun1@huawei.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <97e67924-3394-5135-64a1-b205824d0dc3@huawei.com>
Date:   Tue, 1 Nov 2022 17:24:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20221101073343.3961562-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/11/1 15:33, Baokun Li wrote:
> When squashfs_read_table() returns an error or `sb->s_magic
> != SQUASHFS_MAGIC`, enters the error branch and calls
> msblk->thread_ops->destroy(msblk) to destroy msblk.
> However, msblk->thread_ops has not been initialized.
> Therefore, the following problem is triggered:
> 
> ==================================================================
> BUG: KASAN: null-ptr-deref in squashfs_fill_super+0xe7a/0x13b0
> Read of size 8 at addr 0000000000000008 by task swapper/0/1
> 
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc3-next-20221031 #367
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x73/0x9f
>   print_report+0x743/0x759
>   kasan_report+0xc0/0x120
>   __asan_load8+0xd3/0x140
>   squashfs_fill_super+0xe7a/0x13b0
>   get_tree_bdev+0x27b/0x450
>   squashfs_get_tree+0x19/0x30
>   vfs_get_tree+0x49/0x150
>   path_mount+0xaae/0x1350
>   init_mount+0xad/0x100
>   do_mount_root+0xbc/0x1d0
>   mount_block_root+0x173/0x316
>   mount_root+0x223/0x236
>   prepare_namespace+0x1eb/0x237
>   kernel_init_freeable+0x528/0x576
>   kernel_init+0x29/0x250
>   ret_from_fork+0x1f/0x30
>   </TASK>
> ==================================================================
> 
> To solve this issue, msblk->thread_ops is initialized immediately after
> msblk is assigned a value.
> 
> Fixes: b0645770d3c7 ("squashfs: add the mount parameter theads=<single|multi|percpu>")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
Thank you for helping to identify and fix this bug.

Reviewed-by: Xiaoming Ni <nixiaoming@huawei.com>



>   fs/squashfs/super.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
> index 1e428ca9414e..7d5265a39d20 100644
> --- a/fs/squashfs/super.c
> +++ b/fs/squashfs/super.c
> @@ -197,6 +197,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
>   		return -ENOMEM;
>   	}
>   	msblk = sb->s_fs_info;
> +	msblk->thread_ops = opts->thread_ops;
>   
>   	msblk->panic_on_errors = (opts->errors == Opt_errors_panic);
>   
> @@ -231,7 +232,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
>   			       sb->s_bdev);
>   		goto failed_mount;
>   	}
> -	msblk->thread_ops = opts->thread_ops;
> +
>   	if (opts->thread_num == 0) {
>   		msblk->max_thread_num = msblk->thread_ops->max_decompressors();
>   	} else {
> 

