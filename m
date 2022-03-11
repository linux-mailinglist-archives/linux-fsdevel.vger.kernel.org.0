Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB084D634F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 15:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348830AbiCKOWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 09:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345180AbiCKOWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:22:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E291C7E9F;
        Fri, 11 Mar 2022 06:21:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60363B82BF1;
        Fri, 11 Mar 2022 14:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2411C340F4;
        Fri, 11 Mar 2022 14:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647008477;
        bh=LP2CwAkkYloJnrNiObdWW0KUKuYj+JmRTLKunCk7ckc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTVqhrWPxl262m6p0rTegOcUnpj1yrGT//GaeMjXnmujPyaHzEz3Q40UXBCjmMxUW
         23d9L5zZRa1tkDRdaBEEL90wsOhiXWbNETtYYHtHoEhMlesD7ey4rgeg6GEeA2loFP
         uY3Fd52KH8t8gPNXtbrTWSkC4Wwbpw8/8gjjUCifmFwgnTEaTVysYIR5sgaNpgRp92
         FoW9/fcMTFHKxtJicrRW9JmDMz8zc+nVIsHxw6PmnB48xOqCQfFCXtPqW/rwbymHha
         KuHs6/mzbL+RJgyUNrhAmYp8tzpBJ5unNOVwAE4I1M3jB9gjxMBj10m/0s5be4g9Fj
         dn4rPSpGaFnKg==
Date:   Fri, 11 Mar 2022 14:21:14 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com
Subject: Re: [PATCH 2/4] btrfs: mark device addition as sb_writing
Message-ID: <Yita2kwuHzjCkH+z@debian9.Home>
References: <cover.1646983176.git.naohiro.aota@wdc.com>
 <09e63a62afe0c03bac24cfbfe37316f97e13e113.1646983176.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e63a62afe0c03bac24cfbfe37316f97e13e113.1646983176.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 04:38:03PM +0900, Naohiro Aota wrote:
> btrfs_init_new_device() calls btrfs_relocate_sys_chunk() which incurs
> file-system internal writing. That writing can cause a deadlock with
> FS freezing like as described in like as described in commit
> 26559780b953 ("btrfs: zoned: mark relocation as writing").
> 
> Mark the device addition as sb_writing. This is also consistent with
> the removing device ioctl counterpart.
> 
> Fixes: 5accdf82ba25 ("fs: Improve filesystem freezing handling")

Same comment as the previous patch about this.

> Cc: stable@vger.kernel.org
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/ioctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 238cee5b5254..ffa30fd3eed2 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3484,6 +3484,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
>  		return -EINVAL;
>  	}
>  
> +	sb_start_write(fs_info->sb);

Why not use mnt_want_write_file(), just like all the other ioctls that need
to do some change to the fs?

We don't have the struct file * here at btrfs_ioctl_add_dev(), but we have
it in its caller, btrfs_ioctl().

Thanks.

>  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
>  		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
>  			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> @@ -3516,6 +3517,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
>  		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
>  	else
>  		btrfs_exclop_finish(fs_info);
> +	sb_end_write(fs_info->sb);
>  	return ret;
>  }
>  
> -- 
> 2.35.1
> 
