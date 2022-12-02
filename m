Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FCD63FC81
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 01:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiLBAGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 19:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiLBAGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:06:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51BDCAFB9;
        Thu,  1 Dec 2022 16:06:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85701B8205C;
        Fri,  2 Dec 2022 00:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3409CC433D6;
        Fri,  2 Dec 2022 00:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669939572;
        bh=63vUhcPQdMfauePUZuSQg5BuGkSYOTlt9Lj7wyu+QIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+UNDGTZuMbIQ52OO0Qz5qODqnLSwQz/+QmkUeieTUy0KTsHLyc3tw2S2HVgqfjno
         FpGZBGaUEOO5yW8UVTSZq528dQEDbcVkDR/75uLEKDpgS32ERYRKoBSwRQTDdUpIWY
         587I8vPPAp2jV23nwwpcKgoEauLaH/eK//+P/9ienT/Rbb/cdC9iHOD7nF5KH+aThA
         l7XWKUkhInSrCTXvRE7rP6szm3GQw2TK87nm8dQ1ui/dGQyBlKkX7GYc6En6CYsOZu
         a341iBdbHEs+tj5HQvmFOE45K4xFfG1hO96lqd5PHGpv/v9oy4ViwsUhf5jxn/PaWy
         ZjHcJhW63S3xA==
Date:   Thu, 1 Dec 2022 16:06:11 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, dan.j.williams@intel.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 8/8] xfs: remove restrictions for fsdax and reflink
Message-ID: <Y4lBcyIgHaXgoTRc@magnolia>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1669908773-207-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669908773-207-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:32:53PM +0000, Shiyang Ruan wrote:
> Since the basic function for fsdax and reflink has been implemented,
> remove the restrictions of them for widly test.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_ioctl.c | 4 ----
>  fs/xfs/xfs_iops.c  | 4 ----
>  2 files changed, 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 1f783e979629..13f1b2add390 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1138,10 +1138,6 @@ xfs_ioctl_setattr_xflags(
>  	if ((fa->fsx_xflags & FS_XFLAG_REALTIME) && xfs_is_reflink_inode(ip))
>  		ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
>  
> -	/* Don't allow us to set DAX mode for a reflinked file for now. */
> -	if ((fa->fsx_xflags & FS_XFLAG_DAX) && xfs_is_reflink_inode(ip))
> -		return -EINVAL;
> -
>  	/* diflags2 only valid for v3 inodes. */
>  	i_flags2 = xfs_flags2diflags2(ip, fa->fsx_xflags);
>  	if (i_flags2 && !xfs_has_v3inodes(mp))
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 2e10e1c66ad6..bf0495f7a5e1 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1185,10 +1185,6 @@ xfs_inode_supports_dax(
>  	if (!S_ISREG(VFS_I(ip)->i_mode))
>  		return false;
>  
> -	/* Only supported on non-reflinked files. */
> -	if (xfs_is_reflink_inode(ip))
> -		return false;
> -
>  	/* Block size must match page size */
>  	if (mp->m_sb.sb_blocksize != PAGE_SIZE)
>  		return false;
> -- 
> 2.38.1
> 
