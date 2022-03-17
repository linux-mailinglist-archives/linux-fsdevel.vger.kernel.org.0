Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434C04DD07C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 23:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiCQWGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 18:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCQWG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CDF1A8C36;
        Thu, 17 Mar 2022 15:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B69760C0D;
        Thu, 17 Mar 2022 22:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993F4C340EE;
        Thu, 17 Mar 2022 22:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647554711;
        bh=s2TKRZLFnGU0EKlSfs4YF/g9xlzhAI1h9PrSa2VVJL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q29mtsSHxyGY0R4yINqooi7D6QDJVxj5OHgN6bkCpVf6VYR5EVPql00Uj+IWQsMfg
         hVYHY5UwOQOZb6v4v5Dg/SvJGLhlfqJinEmoesGj8BmhY4AgzXDih6Dd328/r47oFK
         ROcy2KEf7VrZ/ws7st+07EYMMAxjgUyQHBg6ojJUYVy+n9bOy4viFB6NNLIo5KzxCD
         crFxJpPXxVMPyt+r/JhjX868opWMXkUSr3y8jUgBrpburZG9WtI7lXmMQJsCSjNPKX
         YbQ9et4fP+/+1m8k2DQxaVUyKNUrLDqlVbb1sqZyUKJQVWDAJ44/wCOMBWYdNX1WvZ
         J+Bmdlcl48/fQ==
Date:   Thu, 17 Mar 2022 15:05:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Guo Xuenan <guoxuenan@huawei.com>
Cc:     willy@infradead.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, fangwei1@huawei.com,
        hsiangkao@linux.alibaba.com
Subject: Re: [PATCH] iomap: fix an infinite loop in iomap_fiemap
Message-ID: <20220317220511.GA8182@magnolia>
References: <20220315065745.3441989-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315065745.3441989-1-guoxuenan@huawei.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 15, 2022 at 02:57:45PM +0800, Guo Xuenan wrote:
> when get fiemap starting from MAX_LFS_FILESIZE, (maxbytes - *len) < start
> will always true , then *len set zero. because of start offset is byhond
> file size, for erofs filesystem it will always return iomap.length with
> zero,iomap iterate will be infinite loop.
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

Looks fine to me (and I don't even really mind pulling this in) but this
isn't a patch to fs/iomap/ -- doesn't the same issue potentially affect
the fiemap implementations that do not use iomap?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
>  	supported_flags |= FIEMAP_FLAG_SYNC;
>  	supported_flags &= FIEMAP_FLAGS_COMPAT;
>  	incompat_flags = fieinfo->fi_flags & ~supported_flags;
> -- 
> 2.22.0
> 
