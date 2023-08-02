Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3144576D3B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 18:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjHBQcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 12:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjHBQcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:32:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02091FFA;
        Wed,  2 Aug 2023 09:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5041761A0D;
        Wed,  2 Aug 2023 16:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7D9C433C8;
        Wed,  2 Aug 2023 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690993939;
        bh=GcVu5AKxQx3Xueu/J47RQ71hv6d/lK6wYIHHmRfGqaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wtd/B0tT5WFKMlZ4FcUuBOY403mH8jUVkWi+G6Rc6yRr8xqjh9e6QJP4M5cVaQZjl
         RdSRk087/R+zJKvlBUY6iflSrQVduZHiM7vhrntHc8ykJ5MZ3CsTWNydd8G60nAjjB
         xsTI+0r8XJWzqubQJge2bfArwRHdY+O0Fl3cJpBpiRZiCeObWknsnSeiOIYUNNlQ5n
         gF1Wsh0ENOOBgf0aIBZa5zNVBIhSdH4vc5MXOCvbYSInOKhXU+6gtVD2ABSpP8k6sE
         GxKNKflCh1H01pQA/zivBFr3jCjg3b+DK9HkonEjcCq0iyGozH4qOncit0g9T89zgx
         DasFxOweGYc3Q==
Date:   Wed, 2 Aug 2023 09:32:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 11/12] xfs: drop s_umount over opening the log and RT
 devices
Message-ID: <20230802163219.GW11352@frogsfrogsfrogs>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-12-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:41:30PM +0200, Christoph Hellwig wrote:
> Just like get_tree_bdev needs to drop s_umount when opening the main
> device, we need to do the same for the xfs log and RT devices to avoid a
> potential lock order reversal with s_unmount for the mark_dead path.
> 
> It might be preferable to just drop s_umount over ->fill_super entirely,
> but that will require a fairly massive audit first, so we'll do the easy
> version here first.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_super.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 8185102431301d..d5042419ed9997 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -448,17 +448,21 @@ STATIC int
>  xfs_open_devices(
>  	struct xfs_mount	*mp)
>  {
> -	struct block_device	*ddev = mp->m_super->s_bdev;
> +	struct super_block	*sb = mp->m_super;
> +	struct block_device	*ddev = sb->s_bdev;
>  	struct block_device	*logdev = NULL, *rtdev = NULL;
>  	int			error;
>  
> +	/* see get_tree_bdev why this is needed and safe */

Which part of get_tree_bdev?  Is it this?

		/*
		 * s_umount nests inside open_mutex during
		 * __invalidate_device().  blkdev_put() acquires
		 * open_mutex and can't be called under s_umount.  Drop
		 * s_umount temporarily.  This is safe as we're
		 * holding an active reference.
		 */
		up_write(&s->s_umount);
		blkdev_put(bdev, fc->fs_type);
		down_write(&s->s_umount);

<confused>

> +	up_write(&sb->s_umount);
> +
>  	/*
>  	 * Open real time and log devices - order is important.
>  	 */
>  	if (mp->m_logname) {
>  		error = xfs_blkdev_get(mp, mp->m_logname, &logdev);
>  		if (error)
> -			return error;
> +			goto out_unlock;
>  	}
>  
>  	if (mp->m_rtname) {
> @@ -496,7 +500,10 @@ xfs_open_devices(
>  		mp->m_logdev_targp = mp->m_ddev_targp;
>  	}
>  
> -	return 0;
> +	error = 0;
> +out_unlock:
> +	down_write(&sb->s_umount);

Isn't down_write taking s_umount?  I think the label should be
out_relock or something less misleading.

--D

> +	return error;
>  
>   out_free_rtdev_targ:
>  	if (mp->m_rtdev_targp)
> @@ -508,7 +515,7 @@ xfs_open_devices(
>   out_close_logdev:
>  	if (logdev && logdev != ddev)
>  		xfs_blkdev_put(mp, logdev);
> -	return error;
> +	goto out_unlock;
>  }
>  
>  /*
> -- 
> 2.39.2
> 
