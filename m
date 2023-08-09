Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7906776449
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 17:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjHIPpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjHIPpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:45:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4573F2139;
        Wed,  9 Aug 2023 08:45:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2AEE614DC;
        Wed,  9 Aug 2023 15:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B11BC433C8;
        Wed,  9 Aug 2023 15:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691595933;
        bh=xC/U1SwIhXg/9IzHIU+jYILOUKvTiOGIUTdlEC2+11Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XrynVFtAjJdRyGWkjPIGxrEK167oTiS3kpmr3Cm87CEZMlUwz8NZ9QUPHRWlaobMV
         CjNPw7H+W3X+xUMuS8/5EHVAYrN2yfMUVSiLhO80FD8/okEYh0Vj70HX70d3EW2fqB
         zyonxdtU0XaKQSoev3dIzv/Iimz1BUOOlqG9Ce6vsrab3Qfby+nYlg2FubP7Pjb/Q9
         klksR3ppHNDtU4Kr5C5+fmxsJ0GVW1ajqdjFcVGDsHWqo/QLhBUjvvwbz7hNbgFvsg
         CstD01lXDIkkmrMgGTabpyVf76AzmfEzAmnZa/Be0cg+g0n1y+0al8ZUKwN1nlDrgM
         HNKbfE+zQHTIQ==
Date:   Wed, 9 Aug 2023 08:45:32 -0700
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
Subject: Re: [PATCH 06/13] xfs: close the RT and log block devices in
 xfs_free_buftarg
Message-ID: <20230809154532.GT11352@frogsfrogsfrogs>
References: <20230808161600.1099516-1-hch@lst.de>
 <20230808161600.1099516-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808161600.1099516-7-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:15:53AM -0700, Christoph Hellwig wrote:
> Closing the block devices logically belongs into xfs_free_buftarg,  So instead
> of open coding it in the caller move it there and add a check for the s_bdev
> so that the main device isn't close as that's done by the VFS helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_buf.c   |  5 +++++
>  fs/xfs/xfs_super.c | 12 ++----------
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 83b8702030f71d..c57e6e03dfa80c 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1938,6 +1938,8 @@ void
>  xfs_free_buftarg(
>  	struct xfs_buftarg	*btp)
>  {
> +	struct block_device	*bdev = btp->bt_bdev;
> +
>  	unregister_shrinker(&btp->bt_shrinker);
>  	ASSERT(percpu_counter_sum(&btp->bt_io_count) == 0);
>  	percpu_counter_destroy(&btp->bt_io_count);
> @@ -1945,6 +1947,9 @@ xfs_free_buftarg(
>  
>  	blkdev_issue_flush(btp->bt_bdev);
>  	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
> +	/* the main block device is closed by kill_block_super */
> +	if (bdev != btp->bt_mount->m_super->s_bdev)
> +		blkdev_put(bdev, btp->bt_mount->m_super);

Hmm... I feel like this would be cleaner if the data dev buftarg could
get its own refcount separate from super_block.s_bdev, but I looked
through the code and couldn't identify a simple way to do that. Soo...

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


>  
>  	kmem_free(btp);
>  }
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index f00d1162815d19..37b1b763a0bef0 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -399,18 +399,10 @@ STATIC void
>  xfs_close_devices(
>  	struct xfs_mount	*mp)
>  {
> -	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
> -		struct block_device *logdev = mp->m_logdev_targp->bt_bdev;
> -
> +	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
>  		xfs_free_buftarg(mp->m_logdev_targp);
> -		blkdev_put(logdev, mp->m_super);
> -	}
> -	if (mp->m_rtdev_targp) {
> -		struct block_device *rtdev = mp->m_rtdev_targp->bt_bdev;
> -
> +	if (mp->m_rtdev_targp)
>  		xfs_free_buftarg(mp->m_rtdev_targp);
> -		blkdev_put(rtdev, mp->m_super);
> -	}
>  	xfs_free_buftarg(mp->m_ddev_targp);
>  }
>  
> -- 
> 2.39.2
> 
