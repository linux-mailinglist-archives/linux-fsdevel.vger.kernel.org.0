Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5B94DB57A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 16:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345970AbiCPP6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 11:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbiCPP6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:58:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DD85F8F2;
        Wed, 16 Mar 2022 08:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8DB9B81BE7;
        Wed, 16 Mar 2022 15:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1388CC340E9;
        Wed, 16 Mar 2022 15:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647446255;
        bh=3Rn1HC2420Z8wyACO+/5beEN+YDTEg0pBiHwdcCNFrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bwes4M61LG6ClQWNGOevGYvIoPS2SjCfo9vwcYecW2GnPaieXQpRgpwupFx4RX9oM
         UILccW+tMiOeHh4S7CepUEwKmiYQlTDMQUUjLGjDGg3l+ZlLGz1EI5RBwLCjrZz2sN
         or3vfyBtomWUfYnWSQ8ofEB/vGYiOMcdUt5IPLorsMgwUafcUEBtIsxGk2gEOg1STP
         VdWPB2xEYeBLyZxi+klcixVqvrm3XUVZgLQRWVKZPxQWQOz+DJLtwOwE4h2qqqcpmY
         BjPsXV3oROmm6vBGgGnzuGDyxQEVZs1eoPJ+nYvtq/opanZOZeOekSFf+Kow4it5X8
         jNFea5uWr+4pg==
Date:   Wed, 16 Mar 2022 15:57:32 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com
Subject: Re: [PATCH v2 1/4] btrfs: mark resumed async balance as writing
Message-ID: <YjII7HRAZ1HCuwwH@debian9.Home>
References: <cover.1647436353.git.naohiro.aota@wdc.com>
 <bd1ecbdfca4a2873d3825afba00d462a84f7264f.1647436353.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1ecbdfca4a2873d3825afba00d462a84f7264f.1647436353.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 10:22:37PM +0900, Naohiro Aota wrote:
> When btrfs balance is interrupted with umount, the background balance
> resumes on the next mount. There is a potential deadlock with FS freezing
> here like as described in commit 26559780b953 ("btrfs: zoned: mark
> relocation as writing").
> 
> Mark the process as sb_writing. To preserve the order of sb_start_write()
> (or mnt_want_write_file()) and btrfs_exclop_start(), call sb_start_write()
> at btrfs_resume_balance_async() before taking fs_info->super_lock.

This paragraph is now outdated, it should go away as it applied only to v1.
The ordering problem is no longer relevant and we don't do anything at
btrfs_resume_balance_async() anymore.

> 
> Cc: stable@vger.kernel.org # 4.9+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Other than that, it looks good.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/volumes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3fd17e87815a..3471698fd831 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4430,10 +4430,12 @@ static int balance_kthread(void *data)
>  	struct btrfs_fs_info *fs_info = data;
>  	int ret = 0;
>  
> +	sb_start_write(fs_info->sb);
>  	mutex_lock(&fs_info->balance_mutex);
>  	if (fs_info->balance_ctl)
>  		ret = btrfs_balance(fs_info, fs_info->balance_ctl, NULL);
>  	mutex_unlock(&fs_info->balance_mutex);
> +	sb_end_write(fs_info->sb);
>  
>  	return ret;
>  }
> -- 
> 2.35.1
> 
