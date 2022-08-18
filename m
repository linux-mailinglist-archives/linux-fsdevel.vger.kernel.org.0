Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B374C597A79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 02:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242284AbiHRAFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 20:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiHRAFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01D090C56;
        Wed, 17 Aug 2022 17:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7590A6135F;
        Thu, 18 Aug 2022 00:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D45C433D6;
        Thu, 18 Aug 2022 00:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660781098;
        bh=qcZsvpEmhW2ANyH2exw1+yii4wiyCGM8J+EJmzbWQ8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZBGz6wKspJhZry6qteIXfWbgVqUUU2FslZhUNI42LfiUhO6lriJbFR3or6sgmqg2
         d2VfmraQsrCH+jnqffs11xiD7Cb3/qOxTi3TEzS2IWyXC4Sg3yr4JJmElFcBDc7631
         yGgVKsddzJ9Fj0ddt7zGE/0CHxt0M1C+QjlEO8jfZdvOUWXEGNjeWOV8yuCpyuOLdY
         wh9GWJoHIyNIxRQkB6nAvNK/y5b0nNSQlVDITt/UslorWQ85ZA21TFfvHNm+rZ/njE
         teWmSR+CPdxFOFvfRNQ/SCsATKoqEjLC0i5z0TAlxCUUFdI9HzWvKkZ4QescTkK1vE
         7AqN5VeWiqtfg==
Date:   Wed, 17 Aug 2022 17:04:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] xfs: don't bump the i_version on an atime update in
 xfs_vn_update_time
Message-ID: <Yv2CKmNC+893l2GG@magnolia>
References: <20220817130002.93592-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817130002.93592-1-jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 09:00:02AM -0400, Jeff Layton wrote:
> xfs will update the i_version when updating only the atime value, which
> is not desirable for any of the current consumers of i_version. Doing so
> leads to unnecessary cache invalidations on NFS and extra measurement
> activity in IMA.
> 
> Add a new XFS_ILOG_NOIVER flag, and use that to indicate that the
> transaction should not update the i_version. Set that value in
> xfs_vn_update_time if we're only updating the atime.

I suppose that would work, since explicit atime updates from futimens()
go through notify_change/setattr and not ->update_time.

--D

> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_log_format.h  |  2 +-
>  fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
>  fs/xfs/xfs_iops.c               | 10 +++++++---
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> Dave,
> 
> How about this for an alternate approach? This just explicitly ensures
> that we don't bump the i_version on an atime-only update, and seems to
> fix the testcase I have.
> 
> diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
> index b351b9dc6561..866a4c5cf70c 100644
> --- a/fs/xfs/libxfs/xfs_log_format.h
> +++ b/fs/xfs/libxfs/xfs_log_format.h
> @@ -323,7 +323,7 @@ struct xfs_inode_log_format_32 {
>  #define	XFS_ILOG_ABROOT	0x100	/* log i_af.i_broot */
>  #define XFS_ILOG_DOWNER	0x200	/* change the data fork owner on replay */
>  #define XFS_ILOG_AOWNER	0x400	/* change the attr fork owner on replay */
> -
> +#define XFS_ILOG_NOIVER	0x800	/* don't bump i_version */
>  
>  /*
>   * The timestamps are dirty, but not necessarily anything else in the inode
> diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> index 8b5547073379..ffe6d296e7f9 100644
> --- a/fs/xfs/libxfs/xfs_trans_inode.c
> +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> @@ -126,7 +126,7 @@ xfs_trans_log_inode(
>  	 * unconditionally.
>  	 */
>  	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
> -		if (IS_I_VERSION(inode) &&
> +		if (!(flags & XFS_ILOG_NOIVER) && IS_I_VERSION(inode) &&
>  		    inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
>  			iversion_flags = XFS_ILOG_CORE;
>  	}
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 45518b8c613c..54db85a43dfb 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1021,7 +1021,7 @@ xfs_vn_update_time(
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> -	int			log_flags = XFS_ILOG_TIMESTAMP;
> +	int			log_flags = XFS_ILOG_TIMESTAMP|XFS_ILOG_NOIVER;
>  	struct xfs_trans	*tp;
>  	int			error;
>  
> @@ -1041,10 +1041,14 @@ xfs_vn_update_time(
>  		return error;
>  
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> -	if (flags & S_CTIME)
> +	if (flags & S_CTIME) {
>  		inode->i_ctime = *now;
> -	if (flags & S_MTIME)
> +		log_flags &= ~XFS_ILOG_NOIVER;
> +	}
> +	if (flags & S_MTIME) {
>  		inode->i_mtime = *now;
> +		log_flags &= ~XFS_ILOG_NOIVER;
> +	}
>  	if (flags & S_ATIME)
>  		inode->i_atime = *now;
>  
> -- 
> 2.37.2
> 
