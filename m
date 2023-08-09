Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D73776429
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 17:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjHIPkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 11:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjHIPj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A582111;
        Wed,  9 Aug 2023 08:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DCD863EF0;
        Wed,  9 Aug 2023 15:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A01C433C8;
        Wed,  9 Aug 2023 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691595597;
        bh=dQE+RASJ+WDjK57/vU1wDt04A/BkrRWGNzNOeEPqfMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MnTsxCBCuNf7QYuTl5G1UWJHouZmmLFUZV73mSsbusEcpOKVohobwa8ECUh7yKtzK
         H8BS8iTOhbBGhbQooojkGgkW52elK0GImlv01P3/Iqek17cguNdxTHSwpcdCPy/X6a
         srAUFU2MpJoUUSn3KwkH7G7Rtz40sTjnFTTjZ4kShPgUeauE0EagIR2nWWfxQazeel
         HfaeyGQaIKaJsBqPL7kUHSemHb8T4cQ8mX0xdQPxM6XbrRchooRzBEuGsCAz16327w
         meY3hZ6Lq591ZFQn9l9zHAkSssGrIEmJm1F0OGaz7FtsFeMMPe5z9jhDs8ctTSrrfi
         9VBHInaHrCAeg==
Date:   Wed, 9 Aug 2023 08:39:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 04/13] xfs: remove xfs_blkdev_put
Message-ID: <20230809153956.GS11352@frogsfrogsfrogs>
References: <20230808161600.1099516-1-hch@lst.de>
 <20230808161600.1099516-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808161600.1099516-5-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:15:51AM -0700, Christoph Hellwig wrote:
> There isn't much use for this trivial wrapper, especially as the NULL
> check is only needed in a single call site.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_super.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index d2f3ae6ba8938b..f00d1162815d19 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -395,15 +395,6 @@ xfs_blkdev_get(
>  	return error;
>  }
>  
> -STATIC void
> -xfs_blkdev_put(
> -	struct xfs_mount	*mp,
> -	struct block_device	*bdev)
> -{
> -	if (bdev)
> -		blkdev_put(bdev, mp->m_super);
> -}
> -
>  STATIC void
>  xfs_close_devices(
>  	struct xfs_mount	*mp)
> @@ -412,13 +403,13 @@ xfs_close_devices(
>  		struct block_device *logdev = mp->m_logdev_targp->bt_bdev;
>  
>  		xfs_free_buftarg(mp->m_logdev_targp);
> -		xfs_blkdev_put(mp, logdev);
> +		blkdev_put(logdev, mp->m_super);
>  	}
>  	if (mp->m_rtdev_targp) {
>  		struct block_device *rtdev = mp->m_rtdev_targp->bt_bdev;
>  
>  		xfs_free_buftarg(mp->m_rtdev_targp);
> -		xfs_blkdev_put(mp, rtdev);
> +		blkdev_put(rtdev, mp->m_super);
>  	}
>  	xfs_free_buftarg(mp->m_ddev_targp);
>  }
> @@ -503,10 +494,11 @@ xfs_open_devices(
>   out_free_ddev_targ:
>  	xfs_free_buftarg(mp->m_ddev_targp);
>   out_close_rtdev:
> -	xfs_blkdev_put(mp, rtdev);
> + 	if (rtdev)

   ^ extra space here

With that removed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> +		blkdev_put(rtdev, sb);
>   out_close_logdev:
>  	if (logdev && logdev != ddev)
> -		xfs_blkdev_put(mp, logdev);
> +		blkdev_put(logdev, sb);
>  	goto out_relock;
>  }
>  
> -- 
> 2.39.2
> 
