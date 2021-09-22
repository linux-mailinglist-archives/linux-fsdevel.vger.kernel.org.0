Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53793414FA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 20:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbhIVSOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 14:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbhIVSOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:14:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E102C061574;
        Wed, 22 Sep 2021 11:12:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y28so15306927lfb.0;
        Wed, 22 Sep 2021 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=okAjIGLjrgqxq64pmQoOBCNH489YYnDxMve8Hgv5WkA=;
        b=crHPOrCuizBy5akbvOdzBt9y0DIz1mKFtYHHZtqliBi7SijmyDEdlWEVduxJFgAmud
         3gjsHwjXTxPsEk/1VMDHXeya1qTAxfKL0PLhbb+kf9vZsur0nucFmTn0+4pV/iNOzkpI
         TEK7T5UB8uydOeSV3QRAiiB08tCV3B62CLsUc90VRlla7wTSTTAdBloseobfZRCdIiRS
         IEV7pZ3DyafTmVYuF9PDE7iGrnn92853zGfWgABy9NmeaWQwU/h147kw6ELB522cud8b
         IAfJ5XKIX54O2PIDk7eEcKooMN9KQKPLTtxyTdC/AeI4ZvDaA3B7v+12sgoYPUUu3r8Q
         W7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=okAjIGLjrgqxq64pmQoOBCNH489YYnDxMve8Hgv5WkA=;
        b=3F9NdO6DAC+LfQX0X5leNubyjhL69zXfGRGKXFVhWZIL6Nz4tEPgj/df/APBvg7IzW
         +SnuLDlafeQmF79XHQ0Ec4Vf5n0aRvjirPJrJORue6oYg4bTq2EMwwwoSkr3GtS1DQGL
         uYWwF26jNnjRqz6q6CXiLqJqwKt35mE9UF9o/KlTVAiL4RRGS8symXBd2oOSN9MI8dHM
         BsRmTet419dzK+CINaD8uT5atwWL1Nc7pnhPNmDP5fqkM06Ta7H9C/5HU5enA77JSXwF
         TED9A2GYLx7+gyGSUxmnKg5dQI1pY2O83+zzUQ1IBF8m2SKh5TKEQzg/S9PlCUZnHNpu
         d58A==
X-Gm-Message-State: AOAM531PW0EtMOd4o4yKTNp/maoBboCeUdOK4u39RKn/wvBM+EPVCHum
        AFnrZk0HPxrAIBMlb4LYpgE=
X-Google-Smtp-Source: ABdhPJyYPhjMRfAArfiWxEVEbH5e9MyX7K4drThW40rxD+7J/n8TTqB43BQlbu/mcXiniBg9gMM09g==
X-Received: by 2002:a2e:4c09:: with SMTP id z9mr699303lja.390.1632334366688;
        Wed, 22 Sep 2021 11:12:46 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id b22sm233682lfi.67.2021.09.22.11.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 11:12:46 -0700 (PDT)
Date:   Wed, 22 Sep 2021 21:12:44 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] fs/ntfs3: Move ni_lock_dir and ni_unlock into
 ntfs_create_inode
Message-ID: <20210922181244.tjxij5gi6xft4wwh@kari-VirtualBox>
References: <2771ff62-e612-a8ed-4b93-5534c26aef9e@paragon-software.com>
 <a269be2f-4ab6-b1c6-790c-9d3052bf22cc@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a269be2f-4ab6-b1c6-790c-9d3052bf22cc@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 07:17:13PM +0300, Konstantin Komarov wrote:
> Now ntfs3 locks mutex for smaller time.

Really like this change. It was my todo list also. Thanks. Still some
comments below.

> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/inode.c | 17 ++++++++++++++---
>  fs/ntfs3/namei.c | 20 --------------------
>  2 files changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index d583b71bec50..6fc99eebd1c1 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1198,9 +1198,13 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  	struct REPARSE_DATA_BUFFER *rp = NULL;
>  	bool rp_inserted = false;
>  
> +	ni_lock_dir(dir_ni);
> +
>  	dir_root = indx_get_root(&dir_ni->dir, dir_ni, NULL, NULL);
> -	if (!dir_root)
> -		return ERR_PTR(-EINVAL);
> +	if (!dir_root) {
> +		err = -EINVAL;
> +		goto out1;
> +	}
>  
>  	if (S_ISDIR(mode)) {
>  		/* Use parent's directory attributes. */
> @@ -1549,6 +1553,9 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  	if (err)
>  		goto out6;
>  
> +	/* Unlock parent directory before ntfs_init_acl. */
> +	ni_unlock(dir_ni);

There is err path which can go to err6 (line 1585). Then we get double
unlock situation.

> +
>  	inode->i_generation = le16_to_cpu(rec->seq);
>  
>  	dir->i_mtime = dir->i_ctime = inode->i_atime;
> @@ -1605,8 +1612,10 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  out7:
>  
>  	/* Undo 'indx_insert_entry'. */
> +	ni_lock_dir(dir_ni);
>  	indx_delete_entry(&dir_ni->dir, dir_ni, new_de + 1,
>  			  le16_to_cpu(new_de->key_size), sbi);
> +	/* ni_unlock(dir_ni); will be called later. */
>  out6:
>  	if (rp_inserted)
>  		ntfs_remove_reparse(sbi, IO_REPARSE_TAG_SYMLINK, &new_de->ref);
> @@ -1630,8 +1639,10 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  	kfree(rp);
>  
>  out1:
> -	if (err)
> +	if (err) {
> +		ni_unlock(dir_ni);

This will be double unlock if we exit with err path out6.

  Argillander

>  		return ERR_PTR(err);
> +	}
>  
>  	unlock_new_inode(inode);
>  
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index 1c475da4e19d..bc741213ad84 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -95,16 +95,11 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
>  static int ntfs_create(struct user_namespace *mnt_userns, struct inode *dir,
>  		       struct dentry *dentry, umode_t mode, bool excl)
>  {
> -	struct ntfs_inode *ni = ntfs_i(dir);
>  	struct inode *inode;
>  
> -	ni_lock_dir(ni);
> -
>  	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFREG | mode,
>  				  0, NULL, 0, NULL);
>  
> -	ni_unlock(ni);
> -
>  	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
>  }
>  
> @@ -116,16 +111,11 @@ static int ntfs_create(struct user_namespace *mnt_userns, struct inode *dir,
>  static int ntfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>  		      struct dentry *dentry, umode_t mode, dev_t rdev)
>  {
> -	struct ntfs_inode *ni = ntfs_i(dir);
>  	struct inode *inode;
>  
> -	ni_lock_dir(ni);
> -
>  	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, mode, rdev,
>  				  NULL, 0, NULL);
>  
> -	ni_unlock(ni);
> -
>  	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
>  }
>  
> @@ -196,15 +186,10 @@ static int ntfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>  {
>  	u32 size = strlen(symname);
>  	struct inode *inode;
> -	struct ntfs_inode *ni = ntfs_i(dir);
> -
> -	ni_lock_dir(ni);
>  
>  	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFLNK | 0777,
>  				  0, symname, size, NULL);
>  
> -	ni_unlock(ni);
> -
>  	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
>  }
>  
> @@ -215,15 +200,10 @@ static int ntfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>  		      struct dentry *dentry, umode_t mode)
>  {
>  	struct inode *inode;
> -	struct ntfs_inode *ni = ntfs_i(dir);
> -
> -	ni_lock_dir(ni);
>  
>  	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFDIR | mode,
>  				  0, NULL, 0, NULL);
>  
> -	ni_unlock(ni);
> -
>  	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
>  }
>  
> -- 
> 2.33.0
> 
> 
