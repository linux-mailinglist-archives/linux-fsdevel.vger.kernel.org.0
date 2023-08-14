Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867FA77B752
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 13:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjHNLF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 07:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHNLF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:05:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F19A1B5;
        Mon, 14 Aug 2023 04:05:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9505F63C48;
        Mon, 14 Aug 2023 11:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8AAC433C7;
        Mon, 14 Aug 2023 11:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692011127;
        bh=o2GX9ktf7XmPbMjQ9eJQ/RJAYkU4u146tdoCQwdGLb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bIay++Zk8I7jdq3aa314BvqvMSwSTvUrpfQ7qiM3lFepfXfKvkyxKw+ScOHOeNAeF
         swv1N35AaYHTsafue1ph47qRvF4v7/WNS4m6C/vyxo5D8YlSLO7aA3cWTsuhPBBc5n
         LB+rxQtjAurAl+RNPoAAUTKinsrT3dSVXbCaXI4wxEsLhMQzqaX9UtRxoIsUj5gxfY
         +H3DHAZWgwJJoUhMVb9xrAz/MBkCw+eE9/jjoA6eBhWtNlCNXNEfgNI/4TVQRrEk3+
         iMkeR/oOvgPUnvMrLBKF2FjWxg11L6xc3ZZzJ4Tt6uXZBsaEqVGQza9pz0gzmiarsL
         wVtCOM+YmdytQ==
Date:   Mon, 14 Aug 2023 13:05:19 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 12/12] xfs use fs_holder_ops for the log and RT devices
Message-ID: <20230814110519.i4vjdomisjrez3r3@andromeda>
References: <20230802154131.2221419-1-hch@lst.de>
 <GiAHRRU8GiDH6Pv5bBBlwPA3hI_9kRXKZCNl7-CoadP8Bf7DiWIUnUt9bG1gBU92q5OuJ4Uy1Negt6JqJWxpeg==@protonmail.internalid>
 <20230802154131.2221419-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-13-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:41:31PM +0200, Christoph Hellwig wrote:
> Use the generic fs_holder_ops to shut down the file system when the
> log or RT device goes away instead of duplicating the logic.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

Carlos

> ---
>  fs/xfs/xfs_super.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index d5042419ed9997..338eba71ff8667 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -377,17 +377,6 @@ xfs_setup_dax_always(
>  	return 0;
>  }
> 
> -static void
> -xfs_bdev_mark_dead(
> -	struct block_device	*bdev)
> -{
> -	xfs_force_shutdown(bdev->bd_holder, SHUTDOWN_DEVICE_REMOVED);
> -}
> -
> -static const struct blk_holder_ops xfs_holder_ops = {
> -	.mark_dead		= xfs_bdev_mark_dead,
> -};
> -
>  STATIC int
>  xfs_blkdev_get(
>  	xfs_mount_t		*mp,
> @@ -396,8 +385,8 @@ xfs_blkdev_get(
>  {
>  	int			error = 0;
> 
> -	*bdevp = blkdev_get_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE, mp,
> -				    &xfs_holder_ops);
> +	*bdevp = blkdev_get_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE,
> +				    mp->m_super, &fs_holder_ops);
>  	if (IS_ERR(*bdevp)) {
>  		error = PTR_ERR(*bdevp);
>  		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
> @@ -412,7 +401,7 @@ xfs_blkdev_put(
>  	struct block_device	*bdev)
>  {
>  	if (bdev)
> -		blkdev_put(bdev, mp);
> +		blkdev_put(bdev, mp->m_super);
>  }
> 
>  STATIC void
> --
> 2.39.2
> 
