Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87018707968
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 07:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjERFDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 01:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjERFDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 01:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C710E6;
        Wed, 17 May 2023 22:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F44064D03;
        Thu, 18 May 2023 05:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED04C433D2;
        Thu, 18 May 2023 05:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684386216;
        bh=byDDmPqm2iPLVjCAzgZt/crSdhj7UhBeRfamY2X4ojc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SchaSgteLy8H98a07YU3iJy6g8VeJ93MaJn9zU1ex//RUTjGwwmmzqTeK6TR8BKd6
         OamrQmy8wu+cUqloAP0PW2RodfRRLLsKDK/5HC4n54iIIZyLxgovVl0RD7QX7oOjNJ
         uU4dw2WIL3cOjivfUUcqZsxexzObM5vM2dqYfRfpYDGqNlEcECsYH0lxKJIqDMHvQS
         /VVvrqaz/30x6jvJb+hELlElNEEmyG6J00VK9nLZ1Y0RqsdONXN6hzMzYd0+qtmoeU
         kNyJoGVZwpzAG3PWCcrWYXEnPxz4SKw6tN7YW9pJ3uNRIm8N9/zcIFhTcjXDIPgB7j
         IWmyT9JxHqoJA==
Date:   Wed, 17 May 2023 22:03:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/13] xfs: wire up sops->shutdown
Message-ID: <20230518050335.GA11598@frogsfrogsfrogs>
References: <20230518042323.663189-1-hch@lst.de>
 <20230518042323.663189-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518042323.663189-13-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 06:23:21AM +0200, Christoph Hellwig wrote:
> Wire up the shutdown method to shut down the file system when the
> underlying block device is marked dead.  Add a new message to
> clearly distinguish this shutdown reason from other shutdowns.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_fsops.c | 3 +++
>  fs/xfs/xfs_mount.h | 4 +++-
>  fs/xfs/xfs_super.c | 8 ++++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index 13851c0d640bc8..9ebb8333a30800 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -534,6 +534,9 @@ xfs_do_force_shutdown(
>  	} else if (flags & SHUTDOWN_CORRUPT_ONDISK) {
>  		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
>  		why = "Corruption of on-disk metadata";
> +	} else if (flags & SHUTDOWN_DEVICE_REMOVED) {
> +		tag = XFS_PTAG_SHUTDOWN_IOERROR;
> +		why = "Block device removal";
>  	} else {
>  		tag = XFS_PTAG_SHUTDOWN_IOERROR;
>  		why = "Metadata I/O Error";
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index aaaf5ec13492d2..429a5e12c1036e 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -457,12 +457,14 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, uint32_t flags, char *fname,
>  #define SHUTDOWN_FORCE_UMOUNT	(1u << 2) /* shutdown from a forced unmount */
>  #define SHUTDOWN_CORRUPT_INCORE	(1u << 3) /* corrupt in-memory structures */
>  #define SHUTDOWN_CORRUPT_ONDISK	(1u << 4)  /* corrupt metadata on device */
> +#define SHUTDOWN_DEVICE_REMOVED	(1u << 5) /* device removed underneath us */
>  
>  #define XFS_SHUTDOWN_STRINGS \
>  	{ SHUTDOWN_META_IO_ERROR,	"metadata_io" }, \
>  	{ SHUTDOWN_LOG_IO_ERROR,	"log_io" }, \
>  	{ SHUTDOWN_FORCE_UMOUNT,	"force_umount" }, \
> -	{ SHUTDOWN_CORRUPT_INCORE,	"corruption" }
> +	{ SHUTDOWN_CORRUPT_INCORE,	"corruption" }, \
> +	{ SHUTDOWN_DEVICE_REMOVED,	"device_removed" }
>  
>  /*
>   * Flags for xfs_mountfs
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 5684c538eb76dc..eb469b8f9a0497 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1159,6 +1159,13 @@ xfs_fs_free_cached_objects(
>  	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
>  }
>  
> +static void
> +xfs_fs_shutdown(
> +	struct super_block	*sb)
> +{
> +	xfs_force_shutdown(XFS_M(sb), SHUTDOWN_DEVICE_REMOVED);
> +}
> +
>  static const struct super_operations xfs_super_operations = {
>  	.alloc_inode		= xfs_fs_alloc_inode,
>  	.destroy_inode		= xfs_fs_destroy_inode,
> @@ -1172,6 +1179,7 @@ static const struct super_operations xfs_super_operations = {
>  	.show_options		= xfs_fs_show_options,
>  	.nr_cached_objects	= xfs_fs_nr_cached_objects,
>  	.free_cached_objects	= xfs_fs_free_cached_objects,
> +	.shutdown		= xfs_fs_shutdown,
>  };
>  
>  static int
> -- 
> 2.39.2
> 
