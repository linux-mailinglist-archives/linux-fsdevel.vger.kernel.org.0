Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5D4B16AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 21:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245227AbiBJUEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 15:04:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbiBJUEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:04:51 -0500
X-Greylist: delayed 575 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 12:04:51 PST
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F140026F3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 12:04:51 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 700749BBC4; Thu, 10 Feb 2022 19:55:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1644522912;
        bh=TscPwRMZbtooAB9SKGv6b38BiFERDq6tJFMRJ0rrB9w=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=RBu9W+uwqYuWCppMYNP0tC8LfFKTbtCdKcCVTkMBK/4qdR2G+YbVIxv6daZomKHAl
         k1SYiujSWRnDDiKcKvXo5hVXc3o3U9hHAKV54PE1NkkUHPfG3ZyTAQy/50hwAzNdqN
         IUCa2g4nrCT1qig9AjlU95rmR6rCsc9wcOYcA4F+bxIQVqlHxVhXtVypBAFRk/dl9c
         h3XOIGT1GQ4/GI5iwWI3YCspfl2DVXxj8ZbYxlw3o6eIJae8kS6q4kT2DHDRRUH3mM
         VBy0235BPTr++y2Uk9NMB3CfbZDQ/IWXYRIqHQ8W4rhqigTqyywf1kb3Evfpw3MBRD
         6t9bvxIiqOYMw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 157AA9B89E;
        Thu, 10 Feb 2022 19:54:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1644522853;
        bh=TscPwRMZbtooAB9SKGv6b38BiFERDq6tJFMRJ0rrB9w=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=O3ECeqZBjcwUpv0WuGsGKfr8F9SxO0DngLqmwMTB27cYkv2jeG4EdDJ7Ma6YhUUJn
         FHl8YpvWM0OKCPM64/xcE6/3dPYAFZkfbqsr2SVPsTND6mzDafotVuYjxqqq0LQFdd
         cyNOi8+pt1zfY95Oclz16PPskKS836+qBfsOxvsUvCLkwMIS6GwoeT8P9RiUDjyiHC
         Es7OLeKBxVZa9gyOEK5iUqK2Fuiq8pVWeHH3RhvEedcASWS6cmX2FyJq+8L9cRYZZG
         3l6js5TiHAFKtcWqg7Krd6Zhe42DNIzhNTVcA8+vlRjiNyeFsA3z+BL+OzJCjd9bBh
         u5tHhC6AkShZA==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id C7C5911EF67;
        Thu, 10 Feb 2022 19:54:12 +0000 (GMT)
Message-ID: <2db10c6d-513a-3b73-c694-0ef112baa389@cobb.uk.net>
Date:   Thu, 10 Feb 2022 19:54:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH] Fix read-only superblock in case of subvol RO remount
Content-Language: en-US
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, fvogt@suse.com
References: <20220210165142.7zfgotun5qdtx4rq@fiona>
In-Reply-To: <20220210165142.7zfgotun5qdtx4rq@fiona>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/02/2022 16:51, Goldwyn Rodrigues wrote:
> If a read-write root mount is remounted as read-only, the subvolume
> is also set to read-only.

Errrr... Isn't that exactly what I want?

If I have a btrfs filesystem with hundreds of subvols, some of which may
be mounted into various places in my filesystem, I would expect that if
I remount the main mountpoint as RO, that all the subvols become RO as
well. I actually don't mind if the behaviour went further and remounting
ANY of the mount points as RO would make them all RO.

My mental model is that mounting a subvol somewhere is rather like a
bind mount. And a bind mount goes RO if the underlying fs goes RO -
doesn't it?

Or am I just confused about what this patch is discussing?

Graham

> 
> Use a rw_mounts counter to check the number of read-write mounts, and change
> superblock to read-only only in case there are no read-write subvol mounts.
> 
> Since sb->s_flags can change while calling legacy_reconfigure(), use
> sb->s_flags instead of fc->sb_flags to re-evaluate sb->s_flags in
> reconfigure_super().
> 
> Test case:
> dd if=/dev/zero of=btrfsfs seek=240 count=0 bs=1M
> mkfs.btrfs btrfsfs
> mount btrfsfs /mnt
> btrfs subvol create /mnt/sv
> mount -o remount,ro /mnt
> mount -osubvol=/sv btrfsfs /mnt/sv
> findmnt # /mnt is RO, /mnt/sv RW
> mount -o remount,ro /mnt
> findmnt # /mnt is RO, /mnt/sv RO as well
> umount /mnt{/sv,}
> rm btrfsfs
> 
> Reported-by: Fabian Vogt <fvogt@suse.com>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index a2991971c6b5..2bb6869f15af 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1060,6 +1060,9 @@ struct btrfs_fs_info {
>  	spinlock_t zone_active_bgs_lock;
>  	struct list_head zone_active_bgs;
>  
> +	/* Count of subvol mounts read-write */
> +	int rw_mounts;
> +
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	spinlock_t ref_verify_lock;
>  	struct rb_root block_tree;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 33cfc9e27451..32941e11e551 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1835,6 +1835,11 @@ static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
>  	/* mount_subvol() will free subvol_name and mnt_root */
>  	root = mount_subvol(subvol_name, subvol_objectid, mnt_root);
>  
> +	if (!IS_ERR(root) && !(flags & SB_RDONLY)) {
> +		struct btrfs_fs_info *fs_info = btrfs_sb(mnt_root->mnt_sb);
> +		fs_info->rw_mounts++;
> +	}
> +
>  out:
>  	return root;
>  }
> @@ -1958,6 +1963,9 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  		goto out;
>  
>  	if (*flags & SB_RDONLY) {
> +
> +		if (--fs_info->rw_mounts > 0)
> +			goto out;
>  		/*
>  		 * this also happens on 'umount -rf' or on shutdown, when
>  		 * the filesystem is busy.
> @@ -2057,6 +2065,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  		if (ret)
>  			goto restore;
>  
> +		fs_info->rw_mounts++;
> +
>  		btrfs_clear_sb_rdonly(sb);
>  
>  		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
> diff --git a/fs/super.c b/fs/super.c
> index f1d4a193602d..fd528f76f14b 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -913,7 +913,8 @@ int reconfigure_super(struct fs_context *fc)
>  	}
>  
>  	WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
> -				 (fc->sb_flags & fc->sb_flags_mask)));
> +				 (sb->s_flags & fc->sb_flags_mask)));
> +
>  	/* Needs to be ordered wrt mnt_is_readonly() */
>  	smp_wmb();
>  	sb->s_readonly_remount = 0;
> 

