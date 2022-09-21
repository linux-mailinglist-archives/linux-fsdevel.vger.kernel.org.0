Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BB65BFA08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiIUJDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 05:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiIUJDP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:03:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681CB83F3E
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 02:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 057D8B8228C
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 09:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FDAC433D6;
        Wed, 21 Sep 2022 09:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663750991;
        bh=UtM2X4nCBoqBFKfiGW1lDJiTJ6mojElo2SGe1z2t4OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+wnSl/T1XClwt5+DAkzbLZZyMvxA0tly1ED14uwKR6/RbZ95DWXM4/uzX/jbhdKo
         o3ufu5vbvQ1k9lDAvEg5xZtgGpMn92E02XufO8cwWH99DNqeUiHqBdZt5XL+J2BL75
         Z6AQRLUBTVrbWGFjc6qxts/jUrs0/G+lF2bHMBrQIlD4S8yhefCDTTn9uVdm4uM0XU
         aSzymc0bTxXUm6Am0CdazQ6bcRt4k0qzR6GTHxKmCXuYFixqz22JSJe4psUIcbcCq/
         n6g3VCrsuri6KCMWA6GnmgBEFcYMXXEEP3cTSwlT0Fow5lK2dBMPC0DgXNID0N9HIZ
         ayWAQLMREdTNQ==
Date:   Wed, 21 Sep 2022 11:03:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 7/9] vfs: move open right after ->tmpfile()
Message-ID: <20220921090306.ryhcrowcuzehv7uw@wittgenstein>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-8-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920193632.2215598-8-mszeredi@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:36:30PM +0200, Miklos Szeredi wrote:
> Create a helper finish_open_simple() that opens the file with the original
> dentry.  Handle the error case here as well to simplify callers.
> 
> Call this helper right after ->tmpfile() is called.
> 
> Next patch will change the tmpfile API and move this call into tmpfile
> instances.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/namei.c         | 79 ++++++++++++++++++----------------------------
>  include/linux/fs.h |  9 ++++++
>  2 files changed, 40 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 652d09ae66fb..4faf7e743664 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3583,44 +3583,43 @@ static int do_open(struct nameidata *nd,
>   * On non-idmapped mounts or if permission checking is to be performed on the
>   * raw inode simply passs init_user_ns.
>   */
> -static struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
> -			   struct dentry *dentry, umode_t mode, int open_flag)
> +static int vfs_tmpfile(struct user_namespace *mnt_userns,
> +		       const struct path *parentpath,
> +		       struct file *file, umode_t mode)
>  {
> -	struct dentry *child = NULL;
> -	struct inode *dir = dentry->d_inode;
> +	struct dentry *child;
> +	struct inode *dir = d_inode(parentpath->dentry);
>  	struct inode *inode;
>  	int error;
>  
>  	/* we want directory to be writable */
>  	error = inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
>  	if (error)
> -		goto out_err;
> -	error = -EOPNOTSUPP;
> +		return error;
>  	if (!dir->i_op->tmpfile)
> -		goto out_err;
> -	error = -ENOMEM;
> -	child = d_alloc(dentry, &slash_name);
> +		return -EOPNOTSUPP;
> +	child = d_alloc(parentpath->dentry, &slash_name);
>  	if (unlikely(!child))
> -		goto out_err;
> +		return -ENOMEM;
> +	file->f_path.mnt = parentpath->mnt;
> +	file->f_path.dentry = child;
>  	mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
>  	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
> +	error = finish_open_simple(file, error);
> +	dput(child);
>  	if (error)
> -		goto out_err;
> -	error = -ENOENT;
> +		return error;
> +	error = may_open(mnt_userns, &file->f_path, 0, file->f_flags);
> +	if (error)
> +		return error;
>  	inode = child->d_inode;
> -	if (unlikely(!inode))
> -		goto out_err;
> -	if (!(open_flag & O_EXCL)) {
> +	if (!(file->f_flags & O_EXCL)) {
>  		spin_lock(&inode->i_lock);
>  		inode->i_state |= I_LINKABLE;
>  		spin_unlock(&inode->i_lock);
>  	}
>  	ima_post_create_tmpfile(mnt_userns, inode);
> -	return child;
> -
> -out_err:
> -	dput(child);
> -	return ERR_PTR(error);
> +	return 0;
>  }
>  
>  /**
> @@ -3641,25 +3640,15 @@ struct file *tmpfile_open(struct user_namespace *mnt_userns,
>  {
>  	struct file *file;
>  	int error;
> -	struct path path = { .mnt = parentpath->mnt };
> -
> -	path.dentry = vfs_tmpfile(mnt_userns, parentpath->dentry, mode, open_flag);
> -	if (IS_ERR(path.dentry))
> -		return ERR_CAST(path.dentry);
> -
> -	error = may_open(mnt_userns, &path, 0, open_flag);
> -	file = ERR_PTR(error);
> -	if (error)
> -		goto out_dput;
> -
> -	/*
> -	 * This relies on the "noaccount" property of fake open, otherwise
> -	 * equivalent to dentry_open().
> -	 */
> -	file = open_with_fake_path(&path, open_flag, d_inode(path.dentry), cred);
> -out_dput:
> -	dput(path.dentry);
>  
> +	file = alloc_empty_file_noaccount(open_flag, cred);
> +	if (!IS_ERR(file)) {
> +		error = vfs_tmpfile(mnt_userns, parentpath, file, mode);
> +		if (error) {
> +			fput(file);
> +			file = ERR_PTR(error);
> +		}
> +	}
>  	return file;
>  }
>  EXPORT_SYMBOL(tmpfile_open);
> @@ -3669,26 +3658,20 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
>  		struct file *file)
>  {
>  	struct user_namespace *mnt_userns;
> -	struct dentry *child;
>  	struct path path;
>  	int error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
> +
>  	if (unlikely(error))
>  		return error;
>  	error = mnt_want_write(path.mnt);
>  	if (unlikely(error))
>  		goto out;
>  	mnt_userns = mnt_user_ns(path.mnt);
> -	child = vfs_tmpfile(mnt_userns, path.dentry, op->mode, op->open_flag);
> -	error = PTR_ERR(child);
> -	if (IS_ERR(child))
> +	error = vfs_tmpfile(mnt_userns, &path, file, op->mode);
> +	if (error)
>  		goto out2;
> -	dput(path.dentry);
> -	path.dentry = child;
> -	audit_inode(nd->name, child, 0);
> +	audit_inode(nd->name, file->f_path.dentry, 0);
>  	/* Don't check for other permissions, the inode was just created */
> -	error = may_open(mnt_userns, &path, 0, op->open_flag);
> -	if (!error)
> -		error = vfs_open(&path, file);
>  out2:
>  	mnt_drop_write(path.mnt);
>  out:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a445da4842e0..f0d17eefb966 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2780,6 +2780,15 @@ extern int finish_open(struct file *file, struct dentry *dentry,
>  			int (*open)(struct inode *, struct file *));
>  extern int finish_no_open(struct file *file, struct dentry *dentry);
>  
> +/* Helper for the simple case when original dentry is used */
> +static inline int finish_open_simple(struct file *file, int error)

It would be nice if the new helpers would would be called
vfs_finish_open()/vfs_finish_open_simple() and vfs_tmpfile_open() to
stick with our vfs_* prefix convention.

It is extremely helpful when looking/grepping for helpers and the
consistency we have gained there in recent years is pretty good.
