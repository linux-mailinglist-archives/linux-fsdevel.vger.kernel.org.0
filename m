Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C99177641C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 17:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjHIPjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 11:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjHIPj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:39:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6AF270D;
        Wed,  9 Aug 2023 08:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9050463ECC;
        Wed,  9 Aug 2023 15:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE33C433CD;
        Wed,  9 Aug 2023 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691595539;
        bh=S1cxndqPMPZizABWybuviHR9Za3B8qEHUkT/adhUNp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cfgzDKekEiX1K1Rnv1dfIlj8rMQ4LyHUDjltohYoYqI2e9Dydbf4hwLagpLhX3jUV
         /1Oeh23YRteYE99F89J3wy71FL0EAN3qjjB5SrYEnJznkOKUWDNTgfh5JX9Ic4kOH8
         Y+4Qqk70gd5yvgorthZ2yPjGsetdwf6NYMi3Ao5U3rhqopkFsY65sVppjmvub2epg+
         nJrQu59+fM4rJn+Z7GEevqj+3V9oYI7XsKaHzvRWY3AFlREqOOc0NYgVS/KnU08go6
         U20Ufa8JDqGTP9T6AGJVFEUVTj8G7HUJ3NhrYEUBP1psHR113FlO02UOmRTSdky1ZG
         UcpcPVLwOAn9Q==
Date:   Wed, 9 Aug 2023 08:38:59 -0700
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
Subject: Re: [PATCH 03/13] xfs: free the mount in ->kill_sb
Message-ID: <20230809153859.GR11352@frogsfrogsfrogs>
References: <20230808161600.1099516-1-hch@lst.de>
 <20230808161600.1099516-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808161600.1099516-4-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:15:50AM -0700, Christoph Hellwig wrote:
> As a rule of thumb everything allocated to the fs_context and moved into
> the super_block should be freed by ->kill_sb so that the teardown
> handling doesn't need to be duplicated between the fill_super error
> path and put_super.  Implement a XFS-specific kill_sb method to do that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_super.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 128f4a2924d49c..d2f3ae6ba8938b 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1143,9 +1143,6 @@ xfs_fs_put_super(
>  	xfs_destroy_percpu_counters(mp);
>  	xfs_destroy_mount_workqueues(mp);
>  	xfs_close_devices(mp);
> -
> -	sb->s_fs_info = NULL;
> -	xfs_mount_free(mp);
>  }
>  
>  static long
> @@ -1487,7 +1484,7 @@ xfs_fs_fill_super(
>  
>  	error = xfs_fs_validate_params(mp);
>  	if (error)
> -		goto out_free_names;
> +		return error;
>  
>  	sb_min_blocksize(sb, BBSIZE);
>  	sb->s_xattr = xfs_xattr_handlers;
> @@ -1514,7 +1511,7 @@ xfs_fs_fill_super(
>  
>  	error = xfs_open_devices(mp);
>  	if (error)
> -		goto out_free_names;
> +		return error;
>  
>  	error = xfs_init_mount_workqueues(mp);
>  	if (error)
> @@ -1734,9 +1731,6 @@ xfs_fs_fill_super(
>  	xfs_destroy_mount_workqueues(mp);
>   out_close_devices:
>  	xfs_close_devices(mp);
> - out_free_names:
> -	sb->s_fs_info = NULL;
> -	xfs_mount_free(mp);
>  	return error;
>  
>   out_unmount:
> @@ -1999,12 +1993,20 @@ static int xfs_init_fs_context(
>  	return 0;
>  }
>  
> +static void
> +xfs_kill_sb(
> +	struct super_block		*sb)
> +{
> +	kill_block_super(sb);
> +	xfs_mount_free(XFS_M(sb));
> +}
> +
>  static struct file_system_type xfs_fs_type = {
>  	.owner			= THIS_MODULE,
>  	.name			= "xfs",
>  	.init_fs_context	= xfs_init_fs_context,
>  	.parameters		= xfs_fs_parameters,
> -	.kill_sb		= kill_block_super,
> +	.kill_sb		= xfs_kill_sb,
>  	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
>  };
>  MODULE_ALIAS_FS("xfs");
> -- 
> 2.39.2
> 
