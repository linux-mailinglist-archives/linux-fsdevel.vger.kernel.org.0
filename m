Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748815A3861
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 17:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiH0Pe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiH0Pe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 11:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D601EC74;
        Sat, 27 Aug 2022 08:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C865A60B87;
        Sat, 27 Aug 2022 15:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4B3C433D6;
        Sat, 27 Aug 2022 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661614494;
        bh=OwdC3zQvx/KCzeSOjSzdhVsw26TrxSO5sfbmeSj3vF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXmb0bD8ESyNwnRhmb8IR14oLDFELGHgM5LbDriucEEumr3NzmxZa3KYqDkTDA84U
         ob5PwgU3nlrEsIUThmRhklgxtfWxXONGAo3XfnYjJ/K0R5ZHrHSASCq5WFXqxGxZbA
         pnl2HIEXo3yTpIt6sSXX07EEcxRGw5QnhFmjNbCuwvt1bk5dbaShy30tgXRfh6VWCb
         +lleWEXp6G02g40n6LJx5+RIz77SsYmEqsElHu0c6tTJzFso2fF1DMd+yWC2HyEbKI
         a0Fu1555e1QfSccC1hDHagmRilh25cKV8qw9KrbXliotwabiE6mxisiJYjtHwwc3ZX
         cCABO4ZAwi3vA==
Date:   Sat, 27 Aug 2022 08:34:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 8/8] xfs: support STATX_DIOALIGN
Message-ID: <Ywo5nQpqKNUzm/0y@magnolia>
References: <20220827065851.135710-1-ebiggers@kernel.org>
 <20220827065851.135710-9-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827065851.135710-9-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 11:58:51PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add support for STATX_DIOALIGN to xfs, so that direct I/O alignment
> restrictions are exposed to userspace in a generic way.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me; I particularly like the adjustment to report the
device's DMA alignment.  Someone should probably fix DIONINFO, or
perhaps turn it into a getattr wrapper and hoist it?  IMHO none of those
suggestions are necessary to land this patch, though.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iops.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 45518b8c613c9a..f51c60d7e2054a 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -604,6 +604,16 @@ xfs_vn_getattr(
>  		stat->blksize = BLKDEV_IOSIZE;
>  		stat->rdev = inode->i_rdev;
>  		break;
> +	case S_IFREG:
> +		if (request_mask & STATX_DIOALIGN) {
> +			struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +			struct block_device	*bdev = target->bt_bdev;
> +
> +			stat->result_mask |= STATX_DIOALIGN;
> +			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
> +			stat->dio_offset_align = bdev_logical_block_size(bdev);
> +		}
> +		fallthrough;
>  	default:
>  		stat->blksize = xfs_stat_blksize(ip);
>  		stat->rdev = 0;
> -- 
> 2.37.2
> 
