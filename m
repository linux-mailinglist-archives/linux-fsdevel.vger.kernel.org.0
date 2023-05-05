Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BFA6F8897
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 20:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjEESXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 14:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjEESXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 14:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA441385C;
        Fri,  5 May 2023 11:23:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAD3163CDA;
        Fri,  5 May 2023 18:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D59FC433D2;
        Fri,  5 May 2023 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683310986;
        bh=zYPM9Ay3UBVL21eu7OLqQN/1/8EOyA31OIHTIskRWQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itIrZG+RMEQT+Q7rRKLUdxgCROUjx/hNLZUyEBubL3PqZZunRPxHE2mB016/qoouS
         2Xi1O0npvW9tn8J76nHb3DE/cZ/NbrocSFI4LMlIkuILaKSmFUl0Ezkae8d1nxj3fY
         +YGL/AnYoEPy2Hgz98AYp24irjf7rOfb/8QOlJ7COmb4NCRl0j+lm2RtaNT8YzoHXc
         u2WL1AJb3mFD+zNLJp9P0JpiOvGi2/RdBNp5GCRPIj9/xJ1fm9GBs6UgsSygj60mQ2
         96a/xELRvrdWIh48cvQzzIcQl1Eq5TFOiTwFToaNpys6O27ArkKRkhm+E/AiKXdw7R
         U9o9Gl323loJg==
Date:   Fri, 5 May 2023 11:23:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 8/9] xfs: wire up sops->shutdown
Message-ID: <20230505182305.GE15394@frogsfrogsfrogs>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505175132.2236632-9-hch@lst.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 01:51:31PM -0400, Christoph Hellwig wrote:
> Wire up the shutdown method to shut down the file system when the
> underlying block device is marked dead.  Add a new message to
> clearly distinguish this shutdown reason from other shutdowns.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_fsops.c | 3 +++
>  fs/xfs/xfs_mount.h | 1 +
>  fs/xfs/xfs_super.c | 8 ++++++++
>  3 files changed, 12 insertions(+)
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
> index f3269c0626f057..a3aa954477d0dc 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -454,6 +454,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, uint32_t flags, char *fname,
>  #define SHUTDOWN_FORCE_UMOUNT	(1u << 2) /* shutdown from a forced unmount */
>  #define SHUTDOWN_CORRUPT_INCORE	(1u << 3) /* corrupt in-memory structures */
>  #define SHUTDOWN_CORRUPT_ONDISK	(1u << 4)  /* corrupt metadata on device */
> +#define SHUTDOWN_DEVICE_REMOVED	(1u << 5) /* device removed underneath us */
>  
>  #define XFS_SHUTDOWN_STRINGS \

Could you add SHUTDOWN_DEVICE_REMOVED to XFS_SHUTDOWN_STRINGS so the
tracepoint data will decode that flag?

(Everything else in here looks fine to me)

--D

>  	{ SHUTDOWN_META_IO_ERROR,	"metadata_io" }, \
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index bc17ad350aea5a..3abe5ae96cc59b 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1156,6 +1156,13 @@ xfs_fs_free_cached_objects(
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
> @@ -1169,6 +1176,7 @@ static const struct super_operations xfs_super_operations = {
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
