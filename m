Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6111E4D95E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 09:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbiCOIGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 04:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345723AbiCOIGR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:06:17 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087E74BFC5;
        Tue, 15 Mar 2022 01:05:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7Gi8nm_1647331499;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7Gi8nm_1647331499)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Mar 2022 16:05:01 +0800
Date:   Tue, 15 Mar 2022 16:04:59 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Guo Xuenan <guoxuenan@huawei.com>
Cc:     willy@infradead.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, fangwei1@huawei.com,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] iomap: fix an infinite loop in iomap_fiemap
Message-ID: <YjBIq3hFg+RlyAOF@B-P7TQMD6M-0146.local>
Mail-Followup-To: Guo Xuenan <guoxuenan@huawei.com>, willy@infradead.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, houtao1@huawei.com,
        fangwei1@huawei.com, "Darrick J. Wong" <djwong@kernel.org>
References: <20220315065745.3441989-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220315065745.3441989-1-guoxuenan@huawei.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Xuenan,

(+ Cc Darrick.. )

On Tue, Mar 15, 2022 at 02:57:45PM +0800, Guo Xuenan wrote:
> when get fiemap starting from MAX_LFS_FILESIZE, (maxbytes - *len) < start
> will always true , then *len set zero. because of start offset is byhond
> file size, for erofs filesystem it will always return iomap.length with
> zero,iomap iterate will be infinite loop.

Thanks! If my understanding is correct, we once had a similar
behavior in compressed inodes and it has been worked around with
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/zmap.c?h=v5.17-rc8#n762

But yeah, if iomap can define or handle post-EOF extent length
behavior exactly, it would be much better!

So on my side,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(Also you might need to inform iomap maintainer Darrick as well..)

Thanks,
Gao Xiang


> 
> In order to avoid this situation, it is better to calculate the actual
> mapping length at first. If the len is 0, there is no need to continue
> the operation.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 7 PID: 905 at fs/iomap/iter.c:35 iomap_iter+0x97f/0xc70
> Modules linked in: xfs erofs
> CPU: 7 PID: 905 Comm: iomap Tainted: G        W         5.17.0-rc8 #27
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:iomap_iter+0x97f/0xc70
> Code: 85 a1 fc ff ff e8 71 be 9c ff 0f 1f 44 00 00 e9 92 fc ff ff e8 62 be 9c ff 0f 0b b8 fb ff ff ff e9 fc f8 ff ff e8 51 be 9c ff <0f> 0b e9 2b fc ff ff e8 45 be 9c ff 0f 0b e9 e1 fb ff ff e8 39 be
> RSP: 0018:ffff888060a37ab0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888060a37bb0 RCX: 0000000000000000
> RDX: ffff88807e19a900 RSI: ffffffff81a7da7f RDI: ffff888060a37be0
> RBP: 7fffffffffffffff R08: 0000000000000000 R09: ffff888060a37c20
> R10: ffff888060a37c67 R11: ffffed100c146f8c R12: 7fffffffffffffff
> R13: 0000000000000000 R14: ffff888060a37bd8 R15: ffff888060a37c20
> FS:  00007fd3cca01540(0000) GS:ffff888108780000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020010820 CR3: 0000000054b92000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  iomap_fiemap+0x1c9/0x2f0
>  erofs_fiemap+0x64/0x90 [erofs]
>  do_vfs_ioctl+0x40d/0x12e0
>  __x64_sys_ioctl+0xaa/0x1c0
>  do_syscall_64+0x35/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> watchdog: BUG: soft lockup - CPU#7 stuck for 26s! [iomap:905]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> ---
>  fs/ioctl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1ed097e94af2..7f70e90766ed 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -171,8 +171,6 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	u32 incompat_flags;
>  	int ret = 0;
>  
> -	if (*len == 0)
> -		return -EINVAL;
>  	if (start > maxbytes)
>  		return -EFBIG;
>  
> @@ -182,6 +180,9 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	if (*len > maxbytes || (maxbytes - *len) < start)
>  		*len = maxbytes - start;
>  
> +	if (*len == 0)
> +		return -EINVAL;
> +
>  	supported_flags |= FIEMAP_FLAG_SYNC;
>  	supported_flags &= FIEMAP_FLAGS_COMPAT;
>  	incompat_flags = fieinfo->fi_flags & ~supported_flags;
> -- 
> 2.22.0
