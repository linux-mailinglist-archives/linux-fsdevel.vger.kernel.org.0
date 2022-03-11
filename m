Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A444D62F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 15:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347197AbiCKOKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 09:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345071AbiCKOKA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:10:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCF81B1DE2;
        Fri, 11 Mar 2022 06:08:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BFF061E62;
        Fri, 11 Mar 2022 14:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44074C340E9;
        Fri, 11 Mar 2022 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007724;
        bh=xkpgIH/pHjb+6lo/TEX7upnysWXuZL4j8uiXiuPyrA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXSKSJsAfGkMgpC/Igsk9zBzetBdPOVkSmlx7aOXTSrn3Wu9nNoQJDBxnZ3L4DYqn
         cgE7t0ibrEKakPIXGRH1qeJep5FH70//GPmd/WcTpwWrQQ5KyDiWb82gUTVZzx9wao
         P4zRHjVIFMUPhA8AynAP+ibO2nWc33hcFOGrp2iqgDLP78Nh9AZG+VgiqCqqkZ9CBT
         RcchV8JIgSEDssJsF2AJ5mLADE4Qnk0AUMX0Wc7f8wlzPdhR5oflJnzD85d6U3ZnZ8
         vI8XVq3lPRWzTs9kaBbtNyIUUCR6Xk5u7GKG5Sv61u0JH78ZuO6F1WVoS9G1KogKpM
         SdLnRjB1eGP0A==
Date:   Fri, 11 Mar 2022 14:08:37 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com
Subject: Re: [PATCH 1/4] btrfs: mark resumed async balance as writing
Message-ID: <YitX5fpZcC/P70o6@debian9.Home>
References: <cover.1646983176.git.naohiro.aota@wdc.com>
 <65730df62341500bfcbde7d86eeaa3e9b15f1bcb.1646983176.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65730df62341500bfcbde7d86eeaa3e9b15f1bcb.1646983176.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 04:38:02PM +0900, Naohiro Aota wrote:
> When btrfs balance is interrupted with umount, the background balance
> resumes on the next mount. There is a potential deadlock with FS freezing
> here like as described in commit 26559780b953 ("btrfs: zoned: mark
> relocation as writing").
> 
> Mark the process as sb_writing. To preserve the order of sb_start_write()
> (or mnt_want_write_file()) and btrfs_exclop_start(), call sb_start_write()
> at btrfs_resume_balance_async() before taking fs_info->super_lock.
> 
> Fixes: 5accdf82ba25 ("fs: Improve filesystem freezing handling")

This seems odd to me. I read the note you left on the cover letter about
this, but honestly I don't think it's fair to blame that commit. I see
it more as btrfs specific problem.

Plus it's a 10 years old commit, so instead of the Fixes tag, adding a
minimal kernel version to the CC stable tag below makes more sense.

> Cc: stable@vger.kernel.org
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/volumes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1be7cb2f955f..0d27d8d35c7a 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4443,6 +4443,7 @@ static int balance_kthread(void *data)
>  	if (fs_info->balance_ctl)
>  		ret = btrfs_balance(fs_info, fs_info->balance_ctl, NULL);
>  	mutex_unlock(&fs_info->balance_mutex);
> +	sb_end_write(fs_info->sb);
>  
>  	return ret;
>  }
> @@ -4463,6 +4464,7 @@ int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info)
>  		return 0;
>  	}
>  
> +	sb_start_write(fs_info->sb);

I don't understand this.

We are doing the sb_start_write() here, in the task doing the mount, and then
we do the sb_end_write() at the kthread that runs balance_kthread().

Why not do the sb_start_write() in the kthread?

This is also buggy in the case the call below to kthread_run() fails, as
we end up never calling sb_end_write().

Thanks.

>  	spin_lock(&fs_info->super_lock);
>  	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
>  	fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
> -- 
> 2.35.1
> 
