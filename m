Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533F77B0761
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjI0Oyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjI0Oyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:54:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05032F5
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 07:54:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA20C433C8;
        Wed, 27 Sep 2023 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695826474;
        bh=yFBbOHqagygOKI/s3kIoNI5TvlV5zBwMyHGvJnOH8hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPE7fS7c24OmpiVmCnDiCG3E7Xz5vd0gva+HPyMayWDk6P/YYNPB0rG43bDvNOLp7
         sCPLtIlOUTNSP82j0N/0F90YjV5NVm7nqTDvXGxr2lINmYu2ggypX/yxAZyLw4jAcC
         11UqrEttjr+JyxmCbKqy+wZPUuqkfbRjYaVIVjLmfuAQLoTVBQnyqZ4JUUUrVLmuIB
         gVykFCpV5BG3Z893AmVlRZYT/935/3rAWStIMgOSd/eJQHGzDwbcPp5XOzhVV8Yqfm
         zEIQouPqNnd93Jbifm4O9gJTfBEdKCRJOXYLXmnGb/9kRWD4QzofOOwoN7oWkxTzbg
         OCNjy+3LNaymQ==
Date:   Wed, 27 Sep 2023 07:54:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] fs: remove get_active_super()
Message-ID: <20230927145434.GD11414@frogsfrogsfrogs>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-4-ecc36d9ab4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-vfs-super-freeze-v1-4-ecc36d9ab4d9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:21:17PM +0200, Christian Brauner wrote:
> This function is now unused so remove it. One less function that uses
> the global superblock list.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/super.c         | 28 ----------------------------
>  include/linux/fs.h |  1 -
>  2 files changed, 29 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 672f1837fbef..181ac8501301 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1016,34 +1016,6 @@ void iterate_supers_type(struct file_system_type *type,
>  
>  EXPORT_SYMBOL(iterate_supers_type);
>  
> -/**
> - * get_active_super - get an active reference to the superblock of a device
> - * @bdev: device to get the superblock for
> - *
> - * Scans the superblock list and finds the superblock of the file system
> - * mounted on the device given.  Returns the superblock with an active
> - * reference or %NULL if none was found.
> - */
> -struct super_block *get_active_super(struct block_device *bdev)
> -{
> -	struct super_block *sb;
> -
> -	if (!bdev)
> -		return NULL;
> -
> -	spin_lock(&sb_lock);
> -	list_for_each_entry(sb, &super_blocks, s_list) {
> -		if (sb->s_bdev == bdev) {
> -			if (!grab_super(sb))
> -				return NULL;
> -			super_unlock_excl(sb);
> -			return sb;
> -		}
> -	}
> -	spin_unlock(&sb_lock);
> -	return NULL;
> -}
> -
>  struct super_block *user_get_super(dev_t dev, bool excl)
>  {
>  	struct super_block *sb;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b528f063e8ff..ad0ddc10d560 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3052,7 +3052,6 @@ extern int vfs_readlink(struct dentry *, char __user *, int);
>  extern struct file_system_type *get_filesystem(struct file_system_type *fs);
>  extern void put_filesystem(struct file_system_type *fs);
>  extern struct file_system_type *get_fs_type(const char *name);
> -extern struct super_block *get_active_super(struct block_device *bdev);
>  extern void drop_super(struct super_block *sb);
>  extern void drop_super_exclusive(struct super_block *sb);
>  extern void iterate_supers(void (*)(struct super_block *, void *), void *);
> 
> -- 
> 2.34.1
> 
