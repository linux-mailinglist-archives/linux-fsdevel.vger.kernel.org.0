Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EDB4B97E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 05:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiBQExL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 23:53:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiBQExK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:53:10 -0500
Received: from out20-25.mail.aliyun.com (out20-25.mail.aliyun.com [115.124.20.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7091F227D;
        Wed, 16 Feb 2022 20:52:56 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04440251|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0121963-0.000259281-0.987544;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.MrF4LiP_1645073572;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.MrF4LiP_1645073572)
          by smtp.aliyun-inc.com(33.40.85.40);
          Thu, 17 Feb 2022 12:52:52 +0800
Date:   Thu, 17 Feb 2022 12:52:54 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Josef Bacik <josef@toxicpanda.com>, neilb@suse.de
Subject: Re: [PATCH] fs: allow cross-vfsmount reflink/dedupe
Cc:     viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
In-Reply-To: <67ae4c62a4749ae6870c452d1b458cc5f48b8263.1645042835.git.josef@toxicpanda.com>
References: <67ae4c62a4749ae6870c452d1b458cc5f48b8263.1645042835.git.josef@toxicpanda.com>
Message-Id: <20220217125253.0F07.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
Cc: NeilBrown

btrfs cross-vfsmount reflink works well now with these 2 patches.

[PATCH] fs: allow cross-vfsmount reflink/dedupe
[PATCH] btrfs: remove the cross file system checks from remap

But nfs over btrfs still fail to do cross-vfsmount reflink.
need some patch for nfs too?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/02/17

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


