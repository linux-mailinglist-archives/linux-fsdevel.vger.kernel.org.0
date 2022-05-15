Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D08152773A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 May 2022 13:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbiEOLJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 May 2022 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiEOLJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 May 2022 07:09:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D632B1A7;
        Sun, 15 May 2022 04:09:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A002B80BFA;
        Sun, 15 May 2022 11:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8C2C34119;
        Sun, 15 May 2022 11:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652612949;
        bh=kw6RNfpNF5scL/cTqv6JZxYei1eGdtqSlr+HmTvU4Eg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=IMdgrRpcAhbWCAh1t4nbum/HpPHbYNovUcgwN4PKgTcDZZms38A7jzBEq2ZjKdll7
         l5oOc9ljBeXZGJEnsfnAiKXLPMoGFHvoDqPbD27BF+PGnqr+YNZKx+xuXnh5yM0iGJ
         L0iqUh83XM8itB2qrKEj9OrNuL3JWBehMTs8vaP7bsyKf5G4maLR6U0/r7zrajAhpW
         pSQynv3dIsqgcLErxbNqSkfWFdaOHu3JgQfVG+i7tfmt4158+zqrKnP/h0oDc4ZpSS
         CwtKGa9sN4D5doMUtmY7dq+DXDZsK6uJe7/oi8pjFuwQakmx2JygZ/ViY7GFPFTVw8
         Zq+n2aUW863rw==
Received: by mail-wm1-f45.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso6611768wmq.1;
        Sun, 15 May 2022 04:09:09 -0700 (PDT)
X-Gm-Message-State: AOAM531SZA1oieoLvU6BTw85/tJBU2j4i0S5wl20eJJ98GKuHPHWyo44
        BK4Jb8xZFNSrbd51ZoZBGqwH8tT/DvjJKSs+oKo=
X-Google-Smtp-Source: ABdhPJz8El5Z0X6jN4MCRfxXtPMK/Gslny6x9B+GbZluBnTAXIZUwpd7+JL1xP4xj3hxQXdfe9yum5uzJFzW4QSyxfs=
X-Received: by 2002:a05:600c:3512:b0:394:7c3b:53c0 with SMTP id
 h18-20020a05600c351200b003947c3b53c0mr12153419wmq.170.1652612947661; Sun, 15
 May 2022 04:09:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f344:0:0:0:0:0 with HTTP; Sun, 15 May 2022 04:09:06
 -0700 (PDT)
In-Reply-To: <20220427023245.7327-3-linkinjeon@kernel.org>
References: <20220427023245.7327-1-linkinjeon@kernel.org> <20220427023245.7327-3-linkinjeon@kernel.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 15 May 2022 20:09:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8kxmKUaJp0wcN6yBbpYS2wNWgw7krZnkk5_L9pMYa9Bg@mail.gmail.com>
Message-ID: <CAKYAXd8kxmKUaJp0wcN6yBbpYS2wNWgw7krZnkk5_L9pMYa9Bg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ksmbd: fix racy issue from using ->d_parent and ->d_name
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-04-27 11:32 GMT+09:00, Namjae Jeon <linkinjeon@kernel.org>:
Hi Al,

Could you please review this patch-set ?

Thanks!
> Al pointed out that ksmbd has racy issue from using ->d_parent and ->d_name
> in ksmbd_vfs_unlink and smb2_vfs_rename(). and use new lock_rename_child()
> to lock stable parent while underlying rename racy.
> Introduce vfs_path_parent_lookup helper to avoid out of share access and
> export vfs functions like the following ones to use
> vfs_path_parent_lookup().
>  - export __lookup_hash().
>  - export getname_kernel() and putname().
>
> vfs_path_parent_lookup() is used for parent lookup of destination file
> using absolute pathname given from FILE_RENAME_INFORMATION request.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/ksmbd/smb2pdu.c    | 105 ++-------------
>  fs/ksmbd/vfs.c        | 302 ++++++++++++++++--------------------------
>  fs/ksmbd/vfs.h        |  10 +-
>  fs/ksmbd/vfs_cache.c  |   5 +-
>  fs/namei.c            |  41 +++++-
>  include/linux/namei.h |   5 +
>  6 files changed, 172 insertions(+), 296 deletions(-)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 16c803a9d996..d3e29f60fa2e 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -5362,44 +5362,19 @@ int smb2_echo(struct ksmbd_work *work)
>
>  static int smb2_rename(struct ksmbd_work *work,
>  		       struct ksmbd_file *fp,
> -		       struct user_namespace *user_ns,
>  		       struct smb2_file_rename_info *file_info,
>  		       struct nls_table *local_nls)
>  {
>  	struct ksmbd_share_config *share = fp->tcon->share_conf;
> -	char *new_name = NULL, *abs_oldname = NULL, *old_name = NULL;
> -	char *pathname = NULL;
> -	struct path path;
> -	bool file_present = true;
> -	int rc;
> +	char *new_name = NULL;
> +	int rc, flags = 0;
>
>  	ksmbd_debug(SMB, "setting FILE_RENAME_INFO\n");
> -	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
> -	if (!pathname)
> -		return -ENOMEM;
> -
> -	abs_oldname = d_path(&fp->filp->f_path, pathname, PATH_MAX);
> -	if (IS_ERR(abs_oldname)) {
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -	old_name = strrchr(abs_oldname, '/');
> -	if (old_name && old_name[1] != '\0') {
> -		old_name++;
> -	} else {
> -		ksmbd_debug(SMB, "can't get last component in path %s\n",
> -			    abs_oldname);
> -		rc = -ENOENT;
> -		goto out;
> -	}
> -
>  	new_name = smb2_get_name(file_info->FileName,
>  				 le32_to_cpu(file_info->FileNameLength),
>  				 local_nls);
> -	if (IS_ERR(new_name)) {
> -		rc = PTR_ERR(new_name);
> -		goto out;
> -	}
> +	if (IS_ERR(new_name))
> +		return PTR_ERR(new_name);
>
>  	if (strchr(new_name, ':')) {
>  		int s_type;
> @@ -5425,7 +5400,7 @@ static int smb2_rename(struct ksmbd_work *work,
>  		if (rc)
>  			goto out;
>
> -		rc = ksmbd_vfs_setxattr(user_ns,
> +		rc = ksmbd_vfs_setxattr(file_mnt_user_ns(fp->filp),
>  					fp->filp->f_path.dentry,
>  					xattr_stream_name,
>  					NULL, 0, 0);
> @@ -5440,47 +5415,18 @@ static int smb2_rename(struct ksmbd_work *work,
>  	}
>
>  	ksmbd_debug(SMB, "new name %s\n", new_name);
> -	rc = ksmbd_vfs_kern_path(work, new_name, LOOKUP_NO_SYMLINKS, &path, 1);
> -	if (rc) {
> -		if (rc != -ENOENT)
> -			goto out;
> -		file_present = false;
> -	} else {
> -		path_put(&path);
> -	}
> -
>  	if (ksmbd_share_veto_filename(share, new_name)) {
>  		rc = -ENOENT;
>  		ksmbd_debug(SMB, "Can't rename vetoed file: %s\n", new_name);
>  		goto out;
>  	}
>
> -	if (file_info->ReplaceIfExists) {
> -		if (file_present) {
> -			rc = ksmbd_vfs_remove_file(work, new_name);
> -			if (rc) {
> -				if (rc != -ENOTEMPTY)
> -					rc = -EINVAL;
> -				ksmbd_debug(SMB, "cannot delete %s, rc %d\n",
> -					    new_name, rc);
> -				goto out;
> -			}
> -		}
> -	} else {
> -		if (file_present &&
> -		    strncmp(old_name, path.dentry->d_name.name, strlen(old_name))) {
> -			rc = -EEXIST;
> -			ksmbd_debug(SMB,
> -				    "cannot rename already existing file\n");
> -			goto out;
> -		}
> -	}
> +	if (!file_info->ReplaceIfExists)
> +		flags = RENAME_NOREPLACE;
>
> -	rc = ksmbd_vfs_fp_rename(work, fp, new_name);
> +	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
>  out:
> -	kfree(pathname);
> -	if (!IS_ERR(new_name))
> -		kfree(new_name);
> +	kfree(new_name);
>  	return rc;
>  }
>
> @@ -5728,12 +5674,6 @@ static int set_rename_info(struct ksmbd_work *work,
> struct ksmbd_file *fp,
>  			   struct smb2_file_rename_info *rename_info,
>  			   unsigned int buf_len)
>  {
> -	struct user_namespace *user_ns;
> -	struct ksmbd_file *parent_fp;
> -	struct dentry *parent;
> -	struct dentry *dentry = fp->filp->f_path.dentry;
> -	int ret;
> -
>  	if (!(fp->daccess & FILE_DELETE_LE)) {
>  		pr_err("no right to delete : 0x%x\n", fp->daccess);
>  		return -EACCES;
> @@ -5743,32 +5683,7 @@ static int set_rename_info(struct ksmbd_work *work,
> struct ksmbd_file *fp,
>  			le32_to_cpu(rename_info->FileNameLength))
>  		return -EINVAL;
>
> -	user_ns = file_mnt_user_ns(fp->filp);
> -	if (ksmbd_stream_fd(fp))
> -		goto next;
> -
> -	parent = dget_parent(dentry);
> -	ret = ksmbd_vfs_lock_parent(user_ns, parent, dentry);
> -	if (ret) {
> -		dput(parent);
> -		return ret;
> -	}
> -
> -	parent_fp = ksmbd_lookup_fd_inode(d_inode(parent));
> -	inode_unlock(d_inode(parent));
> -	dput(parent);
> -
> -	if (parent_fp) {
> -		if (parent_fp->daccess & FILE_DELETE_LE) {
> -			pr_err("parent dir is opened with delete access\n");
> -			ksmbd_fd_put(work, parent_fp);
> -			return -ESHARE;
> -		}
> -		ksmbd_fd_put(work, parent_fp);
> -	}
> -next:
> -	return smb2_rename(work, fp, user_ns, rename_info,
> -			   work->sess->conn->local_nls);
> +	return smb2_rename(work, fp, rename_info, work->sess->conn->local_nls);
>  }
>
>  static int set_file_disposition_info(struct ksmbd_file *fp,
> diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
> index f79dfcebe480..93d3625bf6d1 100644
> --- a/fs/ksmbd/vfs.c
> +++ b/fs/ksmbd/vfs.c
> @@ -17,6 +17,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/sched/xacct.h>
>  #include <linux/crc32c.h>
> +#include <linux/namei.h>
>
>  #include "glob.h"
>  #include "oplock.h"
> @@ -34,19 +35,6 @@
>  #include "mgmt/user_session.h"
>  #include "mgmt/user_config.h"
>
> -static char *extract_last_component(char *path)
> -{
> -	char *p = strrchr(path, '/');
> -
> -	if (p && p[1] != '\0') {
> -		*p = '\0';
> -		p++;
> -	} else {
> -		p = NULL;
> -	}
> -	return p;
> -}
> -
>  static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
>  				    struct inode *parent_inode,
>  				    struct inode *inode)
> @@ -60,38 +48,20 @@ static void ksmbd_vfs_inherit_owner(struct ksmbd_work
> *work,
>
>  /**
>   * ksmbd_vfs_lock_parent() - lock parent dentry if it is stable
> - *
> - * the parent dentry got by dget_parent or @parent could be
> - * unstable, we try to lock a parent inode and lookup the
> - * child dentry again.
> - *
> - * the reference count of @parent isn't incremented.
>   */
> -int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry
> *parent,
> -			  struct dentry *child)
> +struct dentry *ksmbd_vfs_lock_parent(struct dentry *child)
>  {
> -	struct dentry *dentry;
> -	int ret = 0;
> +	struct dentry *parent;
>
> +	parent = dget(child->d_parent);
>  	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> -	dentry = lookup_one(user_ns, child->d_name.name, parent,
> -			    child->d_name.len);
> -	if (IS_ERR(dentry)) {
> -		ret = PTR_ERR(dentry);
> -		goto out_err;
> -	}
> -
> -	if (dentry != child) {
> -		ret = -ESTALE;
> -		dput(dentry);
> -		goto out_err;
> +	if (child->d_parent != parent) {
> +		dput(parent);
> +		inode_unlock(d_inode(parent));
> +		return ERR_PTR(-EINVAL);
>  	}
>
> -	dput(dentry);
> -	return 0;
> -out_err:
> -	inode_unlock(d_inode(parent));
> -	return ret;
> +	return parent;
>  }
>
>  int ksmbd_vfs_may_delete(struct user_namespace *user_ns,
> @@ -100,12 +70,9 @@ int ksmbd_vfs_may_delete(struct user_namespace
> *user_ns,
>  	struct dentry *parent;
>  	int ret;
>
> -	parent = dget_parent(dentry);
> -	ret = ksmbd_vfs_lock_parent(user_ns, parent, dentry);
> -	if (ret) {
> -		dput(parent);
> -		return ret;
> -	}
> +	parent = ksmbd_vfs_lock_parent(dentry);
> +	if (IS_ERR(parent))
> +		return PTR_ERR(parent);
>
>  	ret = inode_permission(user_ns, d_inode(parent),
>  			       MAY_EXEC | MAY_WRITE);
> @@ -135,12 +102,9 @@ int ksmbd_vfs_query_maximal_access(struct
> user_namespace *user_ns,
>  	if (!inode_permission(user_ns, d_inode(dentry), MAY_OPEN | MAY_EXEC))
>  		*daccess |= FILE_EXECUTE_LE;
>
> -	parent = dget_parent(dentry);
> -	ret = ksmbd_vfs_lock_parent(user_ns, parent, dentry);
> -	if (ret) {
> -		dput(parent);
> -		return ret;
> -	}
> +	parent = ksmbd_vfs_lock_parent(dentry);
> +	if (IS_ERR(parent))
> +		return PTR_ERR(parent);
>
>  	if (!inode_permission(user_ns, d_inode(parent), MAY_EXEC | MAY_WRITE))
>  		*daccess |= FILE_DELETE_LE;
> @@ -599,14 +563,11 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work,
> char *name)
>  		return err;
>  	}
>
> -	user_ns = mnt_user_ns(path.mnt);
> -	parent = dget_parent(path.dentry);
> -	err = ksmbd_vfs_lock_parent(user_ns, parent, path.dentry);
> -	if (err) {
> -		dput(parent);
> +	parent = ksmbd_vfs_lock_parent(path.dentry);
> +	if (IS_ERR(parent)) {
>  		path_put(&path);
>  		ksmbd_revert_fsids(work);
> -		return err;
> +		return PTR_ERR(parent);
>  	}
>
>  	if (!d_inode(path.dentry)->i_nlink) {
> @@ -614,6 +575,7 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, char
> *name)
>  		goto out_err;
>  	}
>
> +	user_ns = mnt_user_ns(path.mnt);
>  	if (S_ISDIR(d_inode(path.dentry)->i_mode)) {
>  		err = vfs_rmdir(user_ns, d_inode(parent), path.dentry);
>  		if (err && err != -ENOTEMPTY)
> @@ -688,149 +650,114 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const
> char *oldname,
>  	return err;
>  }
>
> -static int ksmbd_validate_entry_in_use(struct dentry *src_dent)
> +int ksmbd_vfs_rename(struct ksmbd_work *work, struct path *old_path,
> +		     char *newname, int flags)
>  {
> -	struct dentry *dst_dent;
> -
> -	spin_lock(&src_dent->d_lock);
> -	list_for_each_entry(dst_dent, &src_dent->d_subdirs, d_child) {
> -		struct ksmbd_file *child_fp;
> +	struct dentry *old_parent, *new_dentry, *trap;
> +	struct dentry *old_child = old_path->dentry;
> +	struct path new_path;
> +	struct qstr new_last;
> +	struct renamedata rd;
> +	struct filename *to;
> +	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
> +	struct ksmbd_file *parent_fp;
> +	int new_type;
> +	int err, lookup_flags = LOOKUP_NO_SYMLINKS;
>
> -		if (d_really_is_negative(dst_dent))
> -			continue;
> +	if (ksmbd_override_fsids(work))
> +		return -ENOMEM;
>
> -		child_fp = ksmbd_lookup_fd_inode(d_inode(dst_dent));
> -		if (child_fp) {
> -			spin_unlock(&src_dent->d_lock);
> -			ksmbd_debug(VFS, "Forbid rename, sub file/dir is in use\n");
> -			return -EACCES;
> -		}
> +	to = getname_kernel(newname);
> +	if (IS_ERR(to)) {
> +		err = PTR_ERR(to);
> +		goto revert_fsids;
>  	}
> -	spin_unlock(&src_dent->d_lock);
>
> -	return 0;
> -}
> +retry:
> +	err = vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
> +				     &new_path, &new_last, &new_type,
> +				     &share_conf->vfs_path);
> +	if (err)
> +		goto out1;
>
> -static int __ksmbd_vfs_rename(struct ksmbd_work *work,
> -			      struct user_namespace *src_user_ns,
> -			      struct dentry *src_dent_parent,
> -			      struct dentry *src_dent,
> -			      struct user_namespace *dst_user_ns,
> -			      struct dentry *dst_dent_parent,
> -			      struct dentry *trap_dent,
> -			      char *dst_name)
> -{
> -	struct dentry *dst_dent;
> -	int err;
> +	if (old_path->mnt != new_path.mnt) {
> +		err = -EXDEV;
> +		goto out2;
> +	}
>
> -	if (!work->tcon->posix_extensions) {
> -		err = ksmbd_validate_entry_in_use(src_dent);
> -		if (err)
> -			return err;
> +	trap = lock_rename_child(old_child, new_path.dentry);
> +
> +	old_parent = dget(old_child->d_parent);
> +	if (d_unhashed(old_child)) {
> +		err = -EINVAL;
> +		goto out3;
>  	}
>
> -	if (d_really_is_negative(src_dent_parent))
> -		return -ENOENT;
> -	if (d_really_is_negative(dst_dent_parent))
> -		return -ENOENT;
> -	if (d_really_is_negative(src_dent))
> -		return -ENOENT;
> -	if (src_dent == trap_dent)
> -		return -EINVAL;
> +	parent_fp = ksmbd_lookup_fd_inode(d_inode(old_child->d_parent));
> +	if (parent_fp) {
> +		if (parent_fp->daccess & FILE_DELETE_LE) {
> +			pr_err("parent dir is opened with delete access\n");
> +			err = -ESHARE;
> +			ksmbd_fd_put(work, parent_fp);
> +			goto out3;
> +		}
> +		ksmbd_fd_put(work, parent_fp);
> +	}
>
> -	if (ksmbd_override_fsids(work))
> -		return -ENOMEM;
> +	new_dentry = __lookup_hash(&new_last, new_path.dentry,
> +				   lookup_flags | LOOKUP_RENAME_TARGET);
> +	if (IS_ERR(new_dentry)) {
> +		err = PTR_ERR(new_dentry);
> +		goto out3;
> +	}
>
> -	dst_dent = lookup_one(dst_user_ns, dst_name, dst_dent_parent,
> -			      strlen(dst_name));
> -	err = PTR_ERR(dst_dent);
> -	if (IS_ERR(dst_dent)) {
> -		pr_err("lookup failed %s [%d]\n", dst_name, err);
> -		goto out;
> +	if (d_is_symlink(new_dentry)) {
> +		err = -EACCES;
> +		goto out4;
>  	}
>
> -	err = -ENOTEMPTY;
> -	if (dst_dent != trap_dent && !d_really_is_positive(dst_dent)) {
> -		struct renamedata rd = {
> -			.old_mnt_userns	= src_user_ns,
> -			.old_dir	= d_inode(src_dent_parent),
> -			.old_dentry	= src_dent,
> -			.new_mnt_userns	= dst_user_ns,
> -			.new_dir	= d_inode(dst_dent_parent),
> -			.new_dentry	= dst_dent,
> -		};
> -		err = vfs_rename(&rd);
> +	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry)) {
> +		err = -EEXIST;
> +		goto out4;
>  	}
> -	if (err)
> -		pr_err("vfs_rename failed err %d\n", err);
> -	if (dst_dent)
> -		dput(dst_dent);
> -out:
> -	ksmbd_revert_fsids(work);
> -	return err;
> -}
>
> -int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
> -			char *newname)
> -{
> -	struct user_namespace *user_ns;
> -	struct path dst_path;
> -	struct dentry *src_dent_parent, *dst_dent_parent;
> -	struct dentry *src_dent, *trap_dent, *src_child;
> -	char *dst_name;
> -	int err;
> +	if (old_child == trap) {
> +		err = -EINVAL;
> +		goto out4;
> +	}
>
> -	dst_name = extract_last_component(newname);
> -	if (!dst_name) {
> -		dst_name = newname;
> -		newname = "";
> +	if (new_dentry == trap) {
> +		err = -ENOTEMPTY;
> +		goto out4;
>  	}
>
> -	src_dent_parent = dget_parent(fp->filp->f_path.dentry);
> -	src_dent = fp->filp->f_path.dentry;
> +	rd.old_mnt_userns	= mnt_user_ns(old_path->mnt),
> +	rd.old_dir		= d_inode(old_parent),
> +	rd.old_dentry		= old_child,
> +	rd.new_mnt_userns	= mnt_user_ns(new_path.mnt),
> +	rd.new_dir		= new_path.dentry->d_inode,
> +	rd.new_dentry		= new_dentry,
> +	rd.flags		= flags,
> +	err = vfs_rename(&rd);
> +	if (err)
> +		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
>
> -	err = ksmbd_vfs_kern_path(work, newname,
> -				  LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
> -				  &dst_path, false);
> -	if (err) {
> -		ksmbd_debug(VFS, "Cannot get path for %s [%d]\n", newname, err);
> -		goto out;
> +out4:
> +	dput(new_dentry);
> +out3:
> +	dput(old_parent);
> +	unlock_rename(old_parent, new_path.dentry);
> +out2:
> +	path_put(&new_path);
> +
> +	if (retry_estale(err, lookup_flags)) {
> +		lookup_flags |= LOOKUP_REVAL;
> +		goto retry;
>  	}
> -	dst_dent_parent = dst_path.dentry;
> -
> -	trap_dent = lock_rename(src_dent_parent, dst_dent_parent);
> -	dget(src_dent);
> -	dget(dst_dent_parent);
> -	user_ns = file_mnt_user_ns(fp->filp);
> -	src_child = lookup_one(user_ns, src_dent->d_name.name, src_dent_parent,
> -			       src_dent->d_name.len);
> -	if (IS_ERR(src_child)) {
> -		err = PTR_ERR(src_child);
> -		goto out_lock;
> -	}
> -
> -	if (src_child != src_dent) {
> -		err = -ESTALE;
> -		dput(src_child);
> -		goto out_lock;
> -	}
> -	dput(src_child);
> -
> -	err = __ksmbd_vfs_rename(work,
> -				 user_ns,
> -				 src_dent_parent,
> -				 src_dent,
> -				 mnt_user_ns(dst_path.mnt),
> -				 dst_dent_parent,
> -				 trap_dent,
> -				 dst_name);
> -out_lock:
> -	dput(src_dent);
> -	dput(dst_dent_parent);
> -	unlock_rename(src_dent_parent, dst_dent_parent);
> -	path_put(&dst_path);
> -out:
> -	dput(src_dent_parent);
> +out1:
> +	putname(to);
> +revert_fsids:
> +	ksmbd_revert_fsids(work);
>  	return err;
>  }
>
> @@ -1079,14 +1006,17 @@ int ksmbd_vfs_remove_xattr(struct user_namespace
> *user_ns,
>  	return vfs_removexattr(user_ns, dentry, attr_name);
>  }
>
> -int ksmbd_vfs_unlink(struct user_namespace *user_ns,
> -		     struct dentry *dir, struct dentry *dentry)
> +int ksmbd_vfs_unlink(struct file *filp)
>  {
>  	int err = 0;
> +	struct dentry *dir, *dentry = filp->f_path.dentry;
> +	struct user_namespace *user_ns = file_mnt_user_ns(filp);
>
> -	err = ksmbd_vfs_lock_parent(user_ns, dir, dentry);
> -	if (err)
> -		return err;
> +	dir = ksmbd_vfs_lock_parent(dentry);
> +	if (IS_ERR(dir)) {
> +		err = PTR_ERR(dir);
> +		goto out;
> +	}
>  	dget(dentry);
>
>  	if (S_ISDIR(d_inode(dentry)->i_mode))
> @@ -1098,6 +1028,8 @@ int ksmbd_vfs_unlink(struct user_namespace *user_ns,
>  	inode_unlock(d_inode(dir));
>  	if (err)
>  		ksmbd_debug(VFS, "failed to delete, err %d\n", err);
> +out:
> +	dput(dir);
>
>  	return err;
>  }
> diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
> index 8c37aaf936ab..f79e73b6f01b 100644
> --- a/fs/ksmbd/vfs.h
> +++ b/fs/ksmbd/vfs.h
> @@ -69,8 +69,7 @@ struct ksmbd_kstat {
>  	__le32			file_attributes;
>  };
>
> -int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry
> *parent,
> -			  struct dentry *child);
> +struct dentry *ksmbd_vfs_lock_parent(struct dentry *child);
>  int ksmbd_vfs_may_delete(struct user_namespace *user_ns, struct dentry
> *dentry);
>  int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
>  				   struct dentry *dentry, __le32 *daccess);
> @@ -86,8 +85,8 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, char
> *name);
>  int ksmbd_vfs_link(struct ksmbd_work *work,
>  		   const char *oldname, const char *newname);
>  int ksmbd_vfs_getattr(struct path *path, struct kstat *stat);
> -int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
> -			char *newname);
> +int ksmbd_vfs_rename(struct ksmbd_work *work, struct path *old_path,
> +		     char *newname, int flags);
>  int ksmbd_vfs_truncate(struct ksmbd_work *work,
>  		       struct ksmbd_file *fp, loff_t size);
>  struct srv_copychunk;
> @@ -129,8 +128,7 @@ struct file_allocated_range_buffer;
>  int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t
> length,
>  			 struct file_allocated_range_buffer *ranges,
>  			 unsigned int in_count, unsigned int *out_count);
> -int ksmbd_vfs_unlink(struct user_namespace *user_ns,
> -		     struct dentry *dir, struct dentry *dentry);
> +int ksmbd_vfs_unlink(struct file *filp);
>  void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat);
>  int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
>  				struct user_namespace *user_ns,
> diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
> index c4d59d2735f0..df600eb04552 100644
> --- a/fs/ksmbd/vfs_cache.c
> +++ b/fs/ksmbd/vfs_cache.c
> @@ -243,7 +243,6 @@ void ksmbd_release_inode_hash(void)
>
>  static void __ksmbd_inode_close(struct ksmbd_file *fp)
>  {
> -	struct dentry *dir, *dentry;
>  	struct ksmbd_inode *ci = fp->f_ci;
>  	int err;
>  	struct file *filp;
> @@ -262,11 +261,9 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
>  	if (atomic_dec_and_test(&ci->m_count)) {
>  		write_lock(&ci->m_lock);
>  		if (ci->m_flags & (S_DEL_ON_CLS | S_DEL_PENDING)) {
> -			dentry = filp->f_path.dentry;
> -			dir = dentry->d_parent;
>  			ci->m_flags &= ~(S_DEL_ON_CLS | S_DEL_PENDING);
>  			write_unlock(&ci->m_lock);
> -			ksmbd_vfs_unlink(file_mnt_user_ns(filp), dir, dentry);
> +			ksmbd_vfs_unlink(filp);
>  			write_lock(&ci->m_lock);
>  		}
>  		write_unlock(&ci->m_lock);
> diff --git a/fs/namei.c b/fs/namei.c
> index 516b8d147744..1c0de16f9cb9 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -252,6 +252,7 @@ getname_kernel(const char * filename)
>
>  	return result;
>  }
> +EXPORT_SYMBOL(getname_kernel);
>
>  void putname(struct filename *name)
>  {
> @@ -269,6 +270,7 @@ void putname(struct filename *name)
>  	} else
>  		__putname(name);
>  }
> +EXPORT_SYMBOL(putname);
>
>  /**
>   * check_acl - perform ACL permission checking
> @@ -1587,8 +1589,8 @@ static struct dentry *lookup_dcache(const struct qstr
> *name,
>   * when directory is guaranteed to have no in-lookup children
>   * at all.
>   */
> -static struct dentry *__lookup_hash(const struct qstr *name,
> -		struct dentry *base, unsigned int flags)
> +struct dentry *__lookup_hash(const struct qstr *name, struct dentry *base,
> +			     unsigned int flags)
>  {
>  	struct dentry *dentry = lookup_dcache(name, base, flags);
>  	struct dentry *old;
> @@ -1612,6 +1614,7 @@ static struct dentry *__lookup_hash(const struct qstr
> *name,
>  	}
>  	return dentry;
>  }
> +EXPORT_SYMBOL(__lookup_hash);
>
>  static struct dentry *lookup_fast(struct nameidata *nd,
>  				  struct inode **inode,
> @@ -2556,16 +2559,17 @@ static int path_parentat(struct nameidata *nd,
> unsigned flags,
>  }
>
>  /* Note: this does not consume "name" */
> -static int filename_parentat(int dfd, struct filename *name,
> -			     unsigned int flags, struct path *parent,
> -			     struct qstr *last, int *type)
> +static int __filename_parentat(int dfd, struct filename *name,
> +			       unsigned int flags, struct path *parent,
> +			       struct qstr *last, int *type,
> +			       const struct path *root)
>  {
>  	int retval;
>  	struct nameidata nd;
>
>  	if (IS_ERR(name))
>  		return PTR_ERR(name);
> -	set_nameidata(&nd, dfd, name, NULL);
> +	set_nameidata(&nd, dfd, name, root);
>  	retval = path_parentat(&nd, flags | LOOKUP_RCU, parent);
>  	if (unlikely(retval == -ECHILD))
>  		retval = path_parentat(&nd, flags, parent);
> @@ -2580,6 +2584,13 @@ static int filename_parentat(int dfd, struct filename
> *name,
>  	return retval;
>  }
>
> +static int filename_parentat(int dfd, struct filename *name,
> +			     unsigned int flags, struct path *parent,
> +			     struct qstr *last, int *type)
> +{
> +	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
> +}
> +
>  /* does lookup, returns the object with parent locked */
>  static struct dentry *__kern_path_locked(struct filename *name, struct path
> *path)
>  {
> @@ -2623,6 +2634,24 @@ int kern_path(const char *name, unsigned int flags,
> struct path *path)
>  }
>  EXPORT_SYMBOL(kern_path);
>
> +/**
> + * vfs_path_parent_lookup - lookup a parent path relative to a
> dentry-vfsmount pair
> + * @filename: filename structure
> + * @flags: lookup flags
> + * @parent: pointer to struct path to fill
> + * @last: last component
> + * @type: type of the last component
> + * @root: pointer to struct path of the base directory
> + */
> +int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
> +			   struct path *parent, struct qstr *last, int *type,
> +			   const struct path *root)
> +{
> +	return  __filename_parentat(AT_FDCWD, filename, flags, parent, last,
> +				    type, root);
> +}
> +EXPORT_SYMBOL(vfs_path_parent_lookup);
> +
>  /**
>   * vfs_path_lookup - lookup a file path relative to a dentry-vfsmount pair
>   * @dentry:  pointer to dentry of the base directory
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index e6949d4ba188..f9be815f12b0 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -57,12 +57,17 @@ static inline int user_path_at(int dfd, const char
> __user *name, unsigned flags,
>  	return user_path_at_empty(dfd, name, flags, path, NULL);
>  }
>
> +struct dentry *__lookup_hash(const struct qstr *name, struct dentry *base,
> +			     unsigned int flags);
>  extern int kern_path(const char *, unsigned, struct path *);
>
>  extern struct dentry *kern_path_create(int, const char *, struct path *,
> unsigned int);
>  extern struct dentry *user_path_create(int, const char __user *, struct
> path *, unsigned int);
>  extern void done_path_create(struct path *, struct dentry *);
>  extern struct dentry *kern_path_locked(const char *, struct path *);
> +int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
> +			   struct path *parent, struct qstr *last, int *type,
> +			   const struct path *root);
>  int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
>  		    unsigned int, struct path *);
>
> --
> 2.25.1
>
>
