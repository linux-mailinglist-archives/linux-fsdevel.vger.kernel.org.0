Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ED9775452
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 09:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjHIHkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 03:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjHIHkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:40:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499F01BCF;
        Wed,  9 Aug 2023 00:40:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE14A6300B;
        Wed,  9 Aug 2023 07:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0DEC433CA;
        Wed,  9 Aug 2023 07:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691566842;
        bh=HOTjbEFChdLj05S67I4O/yFTYMaI/dI1GFp47encdz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XjhQHfmsWsRH7cp9xs0NJOMREotTp4ZX639WbH4eOCbhUIB97I893rQMjT5I0tTkd
         9JBb0xSdbmeb+ZiUc+Son3W98MrJcZoeITbov6NE5pjVpd/vzoecJ3hunW7xMIaN3D
         OhVA3OPnLvhicRjQF/SYBGt0yjBKD8BNaS4Zc3N/qhuXecrpy7HzTQ4uN1WinxzyCa
         fH0NDkozMsf6mKlHWQEFWlJ4OTZfQ545pJmm/pS49rKpzr7SSD74+Jx5iQzdSprQIU
         MyenJa2EcG23FhvX9zMbNeSLAjmxt3p89AwT/S3lI91a3Nc7r3rG7w+dNNjIRMqqvG
         DQ3NbfF9BILmg==
Date:   Wed, 9 Aug 2023 09:40:37 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 04/13] xfs: remove xfs_blkdev_put
Message-ID: <20230809-duell-fetzen-4a24f2c2b8da@brauner>
References: <20230808161600.1099516-1-hch@lst.de>
 <20230808161600.1099516-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808161600.1099516-5-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

nit: I think there's a stray space here.

Otherwise,
Reviewed-by: Christian Brauner <brauner@kernel.org>
