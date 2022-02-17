Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702954B9652
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 04:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiBQDGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 22:06:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiBQDGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:06:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D7B23D5D6;
        Wed, 16 Feb 2022 19:05:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5F0CB81FC8;
        Thu, 17 Feb 2022 03:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E241C004E1;
        Thu, 17 Feb 2022 03:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645067156;
        bh=pC5tlqzsTwhwxJ/F2dJWVL0yWJY+RD+MVytDuM7sOJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JzG5UcQ55xQ8W1CLPcAuhildAz8A1BLffvZCQ57ckcog+mE/AI8J+M5UvRuZxP/hm
         ktBSWlvbWNDHmF1/R8dRPg3uDhZ4n38z+PVDyJ95WtleOMZ6e6fExeqiKr7v1TFE87
         gZ6zwsTdrfoVOTefknfnsnST5pzsm3eARRrYdtNBoHtdmYwr6Wa6+tKtl4HbiKLGwq
         9ELbCuqm4Vj6TuAWTYv3OIqvkWUSXUXCPYtU6It2Hzb9Zt6ly3TmAVi/rbP5dUKha+
         MOE3WXO7W2RLdIXIpouEeNi7a8m+2IkCjLJDJrbWC1iZX15bfB0kXqUxrQgVFW9Mda
         gzZo7ApUKLz/g==
Date:   Wed, 16 Feb 2022 19:05:55 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] fs: allow cross-vfsmount reflink/dedupe
Message-ID: <20220217030555.GA8253@magnolia>
References: <67ae4c62a4749ae6870c452d1b458cc5f48b8263.1645042835.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ae4c62a4749ae6870c452d1b458cc5f48b8263.1645042835.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 16, 2022 at 03:21:23PM -0500, Josef Bacik wrote:
> Currently we disallow reflink and dedupe if the two files aren't on the
> same vfsmount.  However we really only need to disallow it if they're
> not on the same super block.  It is very common for btrfs to have a main
> subvolume that is mounted and then different subvolumes mounted at
> different locations.  It's allowed to reflink between these volumes, but
> the vfsmount check disallows this.  Instead fix dedupe to check for the
> same superblock, and simply remove the vfsmount check for reflink as it
> already does the superblock check.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Seems pretty spiffy to /me/... ;)
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/ioctl.c       | 4 ----
>  fs/remap_range.c | 7 +------
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1ed097e94af2..090bf47606ab 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -236,9 +236,6 @@ static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
>  
>  	if (!src_file.file)
>  		return -EBADF;
> -	ret = -EXDEV;
> -	if (src_file.file->f_path.mnt != dst_file->f_path.mnt)
> -		goto fdput;
>  	cloned = vfs_clone_file_range(src_file.file, off, dst_file, destoff,
>  				      olen, 0);
>  	if (cloned < 0)
> @@ -247,7 +244,6 @@ static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
>  		ret = -EINVAL;
>  	else
>  		ret = 0;
> -fdput:
>  	fdput(src_file);
>  	return ret;
>  }
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 231159682907..bc5fb006dc79 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -362,11 +362,6 @@ loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
>  
>  	WARN_ON_ONCE(remap_flags & REMAP_FILE_DEDUP);
>  
> -	/*
> -	 * FICLONE/FICLONERANGE ioctls enforce that src and dest files are on
> -	 * the same mount. Practically, they only need to be on the same file
> -	 * system.
> -	 */
>  	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
>  		return -EXDEV;
>  
> @@ -458,7 +453,7 @@ loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
>  		goto out_drop_write;
>  
>  	ret = -EXDEV;
> -	if (src_file->f_path.mnt != dst_file->f_path.mnt)
> +	if (file_inode(src_file)->i_sb != file_inode(dst_file)->i_sb)
>  		goto out_drop_write;
>  
>  	ret = -EISDIR;
> -- 
> 2.26.3
> 
