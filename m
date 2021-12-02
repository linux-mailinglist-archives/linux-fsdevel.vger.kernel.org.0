Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8091466947
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 18:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348106AbhLBRoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 12:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242325AbhLBRoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:44:00 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFC7C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 09:40:37 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id t23so658676oiw.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Dec 2021 09:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aBEJaYz7MuWYBXU9wgKUuVWjwJ5jmrK/6tU/SP+ufB8=;
        b=BETmiF71tKn6R8BctOUSH34Ar8gyYmC3cdfICzIYOWjJlDwUXv+28DAYPkNV1SHihv
         ZiUWoQ7RvaoFv4N+dx82XBDoL0UdUPRqGsbVHm1Kh9/TGI20M6m37nEduNoOxmem452i
         ZkpVKQFbHcKZTEuHx1XOeVbVU+OSOotGL9458=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aBEJaYz7MuWYBXU9wgKUuVWjwJ5jmrK/6tU/SP+ufB8=;
        b=H33NbTDTsPv/rZFtb3ZcKor4MJHiYWY7H52BB3mK/U+CROJwH35QDJCL47FnzOhO3F
         MfB0yEs3U6QqGJemZUiUYFlFmg1BfBEj6I16cCWzjI0C9s5CtiwCO8SpyVb1fufeKTJ4
         +OHWiHkLpGwd6LpWIW8N9mGD9zMosZAReVD2db8YAPYTieQXIwzoneR/pUCu8gwnnwYf
         QVLJ3UFoEpuKFXPtaY5HZxkLqZEtoUVEsKjL5nEeJttxl9qbPjHNCL6O7fWR0XNdYsc0
         mawjGSpaCcOOsjvVW7nHO5wp3hTkNqTcefia1IvUafEqtc0nKrqdTVoW1qkWUfXlqBBh
         7TpQ==
X-Gm-Message-State: AOAM531GwrmCtXlWSSecojwL2S6K3oXbv4TnFpINkFyAOKp3IPhRYJHP
        LQp6zbaE37qOx7FcZeMNdiJEgQ==
X-Google-Smtp-Source: ABdhPJwzRVD5GkV6S0yZADxeKu/KJlg6sxnxi3x7hlXPy4BgdA6OKvjiZ2uoR49uL6Heec3u+S5YXA==
X-Received: by 2002:a05:6808:ec9:: with SMTP id q9mr5413169oiv.160.1638466837332;
        Thu, 02 Dec 2021 09:40:37 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:49aa:e3a:9f96:cf34])
        by smtp.gmail.com with ESMTPSA id l23sm155757oti.16.2021.12.02.09.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:40:37 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:40:36 -0600
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 08/10] fs: port higher-level mapping helpers
Message-ID: <YakFFPgnhJpYdNc1@do-x1extreme>
References: <20211130121032.3753852-1-brauner@kernel.org>
 <20211130121032.3753852-9-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130121032.3753852-9-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:10:30PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Enable the mapped_fs{g,u}id() helpers to support filesystems mounted
> with an idmapping. Apart from core mapping helpers that use
> mapped_fs{g,u}id() to initialize struct inode's i_{g,u}id fields xfs is
> the only place that uses these low-level helpers directly.
> 
> The patch only extends the helpers to be able to take the filesystem
> idmapping into account. Since we don't actually yet pass the
> filesystem's idmapping in no functional changes happen. This will happen
> in a final patch.
> 
> Link: https://lore.kernel.org/r/20211123114227.3124056-9-brauner@kernel.org (v1)
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Seth Forshee <sforshee@digitalocean.com>

> ---
> /* v2 */
> - Amir Goldstein <amir73il@gmail.com>:
>   - Avoid using local variable and simply pass down initial idmapping
>     directly.
> ---
>  fs/xfs/xfs_inode.c            |  8 ++++----
>  fs/xfs/xfs_symlink.c          |  4 ++--
>  include/linux/fs.h            |  8 ++++----
>  include/linux/mnt_idmapping.h | 12 ++++++++----
>  4 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 64b9bf334806..5ca689459bed 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -988,8 +988,8 @@ xfs_create(
>  	/*
>  	 * Make sure that we have allocated dquot(s) on disk.
>  	 */
> -	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
> -			mapped_fsgid(mnt_userns), prid,
> +	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
> +			mapped_fsgid(mnt_userns, &init_user_ns), prid,
>  			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
>  			&udqp, &gdqp, &pdqp);
>  	if (error)
> @@ -1142,8 +1142,8 @@ xfs_create_tmpfile(
>  	/*
>  	 * Make sure that we have allocated dquot(s) on disk.
>  	 */
> -	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
> -			mapped_fsgid(mnt_userns), prid,
> +	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
> +			mapped_fsgid(mnt_userns, &init_user_ns), prid,
>  			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
>  			&udqp, &gdqp, &pdqp);
>  	if (error)
> diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
> index fc2c6a404647..a31d2e5d0321 100644
> --- a/fs/xfs/xfs_symlink.c
> +++ b/fs/xfs/xfs_symlink.c
> @@ -184,8 +184,8 @@ xfs_symlink(
>  	/*
>  	 * Make sure that we have allocated dquot(s) on disk.
>  	 */
> -	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
> -			mapped_fsgid(mnt_userns), prid,
> +	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
> +			mapped_fsgid(mnt_userns, &init_user_ns), prid,
>  			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
>  			&udqp, &gdqp, &pdqp);
>  	if (error)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 25de7f6ecd81..7c0499b63a02 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1664,7 +1664,7 @@ static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
>  static inline void inode_fsuid_set(struct inode *inode,
>  				   struct user_namespace *mnt_userns)
>  {
> -	inode->i_uid = mapped_fsuid(mnt_userns);
> +	inode->i_uid = mapped_fsuid(mnt_userns, &init_user_ns);
>  }
>  
>  /**
> @@ -1678,7 +1678,7 @@ static inline void inode_fsuid_set(struct inode *inode,
>  static inline void inode_fsgid_set(struct inode *inode,
>  				   struct user_namespace *mnt_userns)
>  {
> -	inode->i_gid = mapped_fsgid(mnt_userns);
> +	inode->i_gid = mapped_fsgid(mnt_userns, &init_user_ns);
>  }
>  
>  /**
> @@ -1699,10 +1699,10 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
>  	kuid_t kuid;
>  	kgid_t kgid;
>  
> -	kuid = mapped_fsuid(mnt_userns);
> +	kuid = mapped_fsuid(mnt_userns, &init_user_ns);
>  	if (!uid_valid(kuid))
>  		return false;
> -	kgid = mapped_fsgid(mnt_userns);
> +	kgid = mapped_fsgid(mnt_userns, &init_user_ns);
>  	if (!gid_valid(kgid))
>  		return false;
>  	return kuid_has_mapping(fs_userns, kuid) &&
> diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
> index c4b604a0c256..afd9bde6ba0d 100644
> --- a/include/linux/mnt_idmapping.h
> +++ b/include/linux/mnt_idmapping.h
> @@ -196,6 +196,7 @@ static inline kgid_t mapped_kgid_user(struct user_namespace *mnt_userns,
>  /**
>   * mapped_fsuid - return caller's fsuid mapped up into a mnt_userns
>   * @mnt_userns: the mount's idmapping
> + * @fs_userns: the filesystem's idmapping
>   *
>   * Use this helper to initialize a new vfs or filesystem object based on
>   * the caller's fsuid. A common example is initializing the i_uid field of
> @@ -205,14 +206,16 @@ static inline kgid_t mapped_kgid_user(struct user_namespace *mnt_userns,
>   *
>   * Return: the caller's current fsuid mapped up according to @mnt_userns.
>   */
> -static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns)
> +static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns,
> +				  struct user_namespace *fs_userns)
>  {
> -	return mapped_kuid_user(mnt_userns, &init_user_ns, current_fsuid());
> +	return mapped_kuid_user(mnt_userns, fs_userns, current_fsuid());
>  }
>  
>  /**
>   * mapped_fsgid - return caller's fsgid mapped up into a mnt_userns
>   * @mnt_userns: the mount's idmapping
> + * @fs_userns: the filesystem's idmapping
>   *
>   * Use this helper to initialize a new vfs or filesystem object based on
>   * the caller's fsgid. A common example is initializing the i_gid field of
> @@ -222,9 +225,10 @@ static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns)
>   *
>   * Return: the caller's current fsgid mapped up according to @mnt_userns.
>   */
> -static inline kgid_t mapped_fsgid(struct user_namespace *mnt_userns)
> +static inline kgid_t mapped_fsgid(struct user_namespace *mnt_userns,
> +				  struct user_namespace *fs_userns)
>  {
> -	return mapped_kgid_user(mnt_userns, &init_user_ns, current_fsgid());
> +	return mapped_kgid_user(mnt_userns, fs_userns, current_fsgid());
>  }
>  
>  #endif /* _LINUX_MNT_MAPPING_H */
> -- 
> 2.30.2
> 
