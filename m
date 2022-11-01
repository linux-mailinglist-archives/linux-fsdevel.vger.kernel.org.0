Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F48614FE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 17:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiKAQ7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 12:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiKAQ6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:58:40 -0400
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Nov 2022 09:58:39 PDT
Received: from p3plwbeout22-03.prod.phx3.secureserver.net (p3plsmtp22-03-2.prod.phx3.secureserver.net [68.178.252.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2451D644
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 09:58:39 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id puYLoEW4XnKu4puYMoo1r4; Tue, 01 Nov 2022 09:55:54 -0700
X-CMAE-Analysis: v=2.4 cv=G5HZr/o5 c=1 sm=1 tr=0 ts=63614f9a
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=9xFQ1JgjjksA:10 a=i0EeH86SAAAA:8
 a=FXvPX3liAAAA:8 a=W0RyOypqp23DQFCu_TQA:9 a=QEXdDO2ut3YA:10
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  puYLoEW4XnKu4
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp12.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1opuYJ-0008MV-Bf; Tue, 01 Nov 2022 16:55:53 +0000
Message-ID: <02b49261-7dd2-5257-548e-d37bd5d56217@squashfs.org.uk>
Date:   Tue, 1 Nov 2022 16:55:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] squashfs: fix null-ptr-deref in squashfs_fill_super
To:     Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     nixiaoming@huawei.com, linux-fsdevel@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com
References: <20221101073343.3961562-1-libaokun1@huawei.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20221101073343.3961562-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfMJ7OBFiKb1t/5iMS6m78Wvb8upZJ4hcsJAaxOvMcHsrA0a551WMqCyXp3FEynCHW3hwbh+bXyChoibut5xCHg9iySgqXcNCgibdaxQb+/OkJCCxcmU5
 LmoynUQWA4qzI5ExieGpbWwQpGTnZPZDn4/gXdV45zM+QQS8lSm7Rsu265nlpQinXmercIO8q6+PIaX20BnkYwlljfLfsoV/EuxZ93PmMtNC0pi53eU0sX2Z
 uDFQBvRtM9T1omYnIGjxqQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/11/2022 07:33, Baokun Li wrote:
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

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>

> --
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

