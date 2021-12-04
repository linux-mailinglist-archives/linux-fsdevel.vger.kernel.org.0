Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9BA4685FD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Dec 2021 16:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345300AbhLDPoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 10:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbhLDPoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 10:44:54 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FF1C061751
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Dec 2021 07:41:29 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id o4so12183727oia.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Dec 2021 07:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rC0ygvAatponGaL8kp4xbT9x3v1llqW+loJodtHk5jo=;
        b=b6bLvg+aQuM1kgMbkLDIcqSeTVN+TUTLUt/NoTcgNlShAa3b2NHyrCHv3rbC/LxS/D
         dIXupv/shEqRE3iJZpridQRQ7SfnsSmsrytC5GU3UzUR7aRXyZ4LilhB9ykfu1t7DdQu
         xuPQ/hZ892pqjFG8zwiUz2iMCBziaozxVo8U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rC0ygvAatponGaL8kp4xbT9x3v1llqW+loJodtHk5jo=;
        b=lKWA76alC5Vce+Z5vOzN+UiDEKmLaNtZw4ENcVD5aQgwCQ9P9IENCQ6ke/+TAQRKyQ
         2KGKR1H3ytuSBHukhSIKbT7dpo9erRUUpdwN0VUTbFjZG4A9YcM9q/awgQhgIf7lbbyf
         NfUbBhh6pgqv0QGnTxEBJReDkWjKXyAgIaCxtLi7myrXSNJfZ6LeeO9bTPT9O6aDuPw8
         9kQmD9LVCbTIQrjVaLrC9pBAcmHtvmG3BQY1ce1UkXMu69tnTYKvnQxmkvqjugmQUllh
         WHBqjlalSTVJRKqCaOr2PWdYHO45tPXzPwQmETAU4t70neoIdf/PXTcK4ATeQGedhb0p
         hRLA==
X-Gm-Message-State: AOAM533CPSMdYYtkB8zsxe7GkMQDQlECOZVQX/10J0alAJNka41iG8YG
        BrMlAaO/HTU0zFMfNbewqEXWyTbwdXyfeA==
X-Google-Smtp-Source: ABdhPJw8L0ioyJCdraHpZYix0a835m4QRJom7VRBvujbR7oMwdn053Juc/QGNd9/P2yyRqdJUBk0vA==
X-Received: by 2002:a05:6808:170e:: with SMTP id bc14mr15652244oib.86.1638632488480;
        Sat, 04 Dec 2021 07:41:28 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:127:31fa:d097:c6c8])
        by smtp.gmail.com with ESMTPSA id c41sm1271937otu.7.2021.12.04.07.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 07:41:28 -0800 (PST)
Date:   Sat, 4 Dec 2021 09:41:27 -0600
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 10/10] fs: support mapped mounts of mapped filesystems
Message-ID: <YauMJ/CMkBirafs2@do-x1extreme>
References: <20211203111707.3901969-1-brauner@kernel.org>
 <20211203111707.3901969-11-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203111707.3901969-11-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 03, 2021 at 12:17:07PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> In previous patches we added new and modified existing helpers to handle
> idmapped mounts of filesystems mounted with an idmapping. In this final
> patch we convert all relevant places in the vfs to actually pass the
> filesystem's idmapping into these helpers.
> 
> With this the vfs is in shape to handle idmapped mounts of filesystems
> mounted with an idmapping. Note that this is just the generic
> infrastructure. Actually adding support for idmapped mounts to a
> filesystem mountable with an idmapping is follow-up work.
> 
> In this patch we extend the definition of an idmapped mount from a mount
> that that has the initial idmapping attached to it to a mount that has
> an idmapping attached to it which is not the same as the idmapping the
> filesystem was mounted with.
> 
> As before we do not allow the initial idmapping to be attached to a
> mount. In addition this patch prevents that the idmapping the filesystem
> was mounted with can be attached to a mount created based on this
> filesystem.
> 
> This has multiple reasons and advantages. First, attaching the initial
> idmapping or the filesystem's idmapping doesn't make much sense as in
> both cases the values of the i_{g,u}id and other places where k{g,u}ids
> are used do not change. Second, a user that really wants to do this for
> whatever reason can just create a separate dedicated identical idmapping
> to attach to the mount. Third, we can continue to use the initial
> idmapping as an indicator that a mount is not idmapped allowing us to
> continue to keep passing the initial idmapping into the mapping helpers
> to tell them that something isn't an idmapped mount even if the
> filesystem is mounted with an idmapping.
> 
> Link: https://lore.kernel.org/r/20211123114227.3124056-11-brauner@kernel.org (v1)
> Link: https://lore.kernel.org/r/20211130121032.3753852-11-brauner@kernel.org (v2)
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Seth Forshee <sforshee@digitalocean.com>

> ---
> /* v2 */
> - Amir Goldstein <amir73il@gmail.com>:
>   - Continue passing down the initial idmapping to xfs. Since xfs cannot
>     and is not planned to support idmapped superblocks don't mislead
>     readers in the code by passing down the filesystem idmapping. It
>     will be the initial idmapping always anyway.
>   - Include mnt_idmapping.h header into fs/namespace.c
> 
> /* v3 */
> - Seth Forshee <sforshee@digitalocean.com>:
>   - Add missing put to do_idmap_mount() when switching idmappings.
> ---
>  fs/namespace.c       | 51 +++++++++++++++++++++++++++++++++-----------
>  fs/open.c            |  7 +++---
>  fs/posix_acl.c       |  8 +++----
>  include/linux/fs.h   | 17 ++++++++-------
>  security/commoncap.c |  9 ++++----
>  5 files changed, 59 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 4994b816a74c..c050e16b71cb 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -31,6 +31,7 @@
>  #include <uapi/linux/mount.h>
>  #include <linux/fs_context.h>
>  #include <linux/shmem_fs.h>
> +#include <linux/mnt_idmapping.h>
>  
>  #include "pnode.h"
>  #include "internal.h"
> @@ -561,7 +562,7 @@ static void free_vfsmnt(struct mount *mnt)
>  	struct user_namespace *mnt_userns;
>  
>  	mnt_userns = mnt_user_ns(&mnt->mnt);
> -	if (mnt_userns != &init_user_ns)
> +	if (!initial_mapping(mnt_userns))
>  		put_user_ns(mnt_userns);
>  	kfree_const(mnt->mnt_devname);
>  #ifdef CONFIG_SMP
> @@ -965,6 +966,7 @@ static struct mount *skip_mnt_tree(struct mount *p)
>  struct vfsmount *vfs_create_mount(struct fs_context *fc)
>  {
>  	struct mount *mnt;
> +	struct user_namespace *fs_userns;
>  
>  	if (!fc->root)
>  		return ERR_PTR(-EINVAL);
> @@ -982,6 +984,10 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
>  	mnt->mnt_mountpoint	= mnt->mnt.mnt_root;
>  	mnt->mnt_parent		= mnt;
>  
> +	fs_userns = mnt->mnt.mnt_sb->s_user_ns;
> +	if (!initial_mapping(fs_userns))
> +		mnt->mnt.mnt_userns = get_user_ns(fs_userns);
> +
>  	lock_mount_hash();
>  	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
>  	unlock_mount_hash();
> @@ -1072,7 +1078,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
>  
>  	atomic_inc(&sb->s_active);
>  	mnt->mnt.mnt_userns = mnt_user_ns(&old->mnt);
> -	if (mnt->mnt.mnt_userns != &init_user_ns)
> +	if (!initial_mapping(mnt->mnt.mnt_userns))
>  		mnt->mnt.mnt_userns = get_user_ns(mnt->mnt.mnt_userns);
>  	mnt->mnt.mnt_sb = sb;
>  	mnt->mnt.mnt_root = dget(root);
> @@ -3927,10 +3933,18 @@ static unsigned int recalc_flags(struct mount_kattr *kattr, struct mount *mnt)
>  static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
>  {
>  	struct vfsmount *m = &mnt->mnt;
> +	struct user_namespace *fs_userns = m->mnt_sb->s_user_ns;
>  
>  	if (!kattr->mnt_userns)
>  		return 0;
>  
> +	/*
> +	 * Creating an idmapped mount with the filesystem wide idmapping
> +	 * doesn't make sense so block that. We don't allow mushy semantics.
> +	 */
> +	if (kattr->mnt_userns == fs_userns)
> +		return -EINVAL;
> +
>  	/*
>  	 * Once a mount has been idmapped we don't allow it to change its
>  	 * mapping. It makes things simpler and callers can just create
> @@ -3943,12 +3957,8 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
>  	if (!(m->mnt_sb->s_type->fs_flags & FS_ALLOW_IDMAP))
>  		return -EINVAL;
>  
> -	/* Don't yet support filesystem mountable in user namespaces. */
> -	if (m->mnt_sb->s_user_ns != &init_user_ns)
> -		return -EINVAL;
> -
>  	/* We're not controlling the superblock. */
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!ns_capable(fs_userns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
>  	/* Mount has already been visible in the filesystem hierarchy. */
> @@ -4002,14 +4012,27 @@ static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
>  
>  static void do_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
>  {
> -	struct user_namespace *mnt_userns;
> +	struct user_namespace *mnt_userns, *old_mnt_userns;
>  
>  	if (!kattr->mnt_userns)
>  		return;
>  
> +	/*
> +         * We're the only ones able to change the mount's idmapping. So
> +         * mnt->mnt.mnt_userns is stable and we can retrieve it directly.
> +         */
> +	old_mnt_userns = mnt->mnt.mnt_userns;
> +
>  	mnt_userns = get_user_ns(kattr->mnt_userns);
>  	/* Pairs with smp_load_acquire() in mnt_user_ns(). */
>  	smp_store_release(&mnt->mnt.mnt_userns, mnt_userns);
> +
> +	/*
> +         * If this is an idmapped filesystem drop the reference we've taken
> +         * in vfs_create_mount() before.
> +         */
> +	if (!initial_mapping(old_mnt_userns))
> +		put_user_ns(old_mnt_userns);
>  }
>  
>  static void mount_setattr_commit(struct mount_kattr *kattr,
> @@ -4133,13 +4156,15 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
>  	}
>  
>  	/*
> -	 * The init_user_ns is used to indicate that a vfsmount is not idmapped.
> -	 * This is simpler than just having to treat NULL as unmapped. Users
> -	 * wanting to idmap a mount to init_user_ns can just use a namespace
> -	 * with an identity mapping.
> +	 * The initial idmapping cannot be used to create an idmapped
> +	 * mount. We use the initial idmapping as an indicator of a mount
> +	 * that is not idmapped. It can simply be passed into helpers that
> +	 * are aware of idmapped mounts as a convenient shortcut. A user
> +	 * can just create a dedicated identity mapping to achieve the same
> +	 * result.
>  	 */
>  	mnt_userns = container_of(ns, struct user_namespace, ns);
> -	if (mnt_userns == &init_user_ns) {
> +	if (initial_mapping(mnt_userns)) {
>  		err = -EPERM;
>  		goto out_fput;
>  	}
> diff --git a/fs/open.c b/fs/open.c
> index 40a00e71865b..9ff2f621b760 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -641,7 +641,7 @@ SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
>  
>  int chown_common(const struct path *path, uid_t user, gid_t group)
>  {
> -	struct user_namespace *mnt_userns;
> +	struct user_namespace *mnt_userns, *fs_userns;
>  	struct inode *inode = path->dentry->d_inode;
>  	struct inode *delegated_inode = NULL;
>  	int error;
> @@ -653,8 +653,9 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
>  	gid = make_kgid(current_user_ns(), group);
>  
>  	mnt_userns = mnt_user_ns(path->mnt);
> -	uid = mapped_kuid_user(mnt_userns, &init_user_ns, uid);
> -	gid = mapped_kgid_user(mnt_userns, &init_user_ns, gid);
> +	fs_userns = i_user_ns(inode);
> +	uid = mapped_kuid_user(mnt_userns, fs_userns, uid);
> +	gid = mapped_kgid_user(mnt_userns, fs_userns, gid);
>  
>  retry_deleg:
>  	newattrs.ia_valid =  ATTR_CTIME;
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 4b5fb9a9b90f..80acb6885cf9 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -376,8 +376,8 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
>                                  break;
>                          case ACL_USER:
>  				uid = mapped_kuid_fs(mnt_userns,
> -						      &init_user_ns,
> -						      pa->e_uid);
> +						     i_user_ns(inode),
> +						     pa->e_uid);
>  				if (uid_eq(uid, current_fsuid()))
>                                          goto mask;
>  				break;
> @@ -391,8 +391,8 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
>  				break;
>                          case ACL_GROUP:
>  				gid = mapped_kgid_fs(mnt_userns,
> -						      &init_user_ns,
> -						      pa->e_gid);
> +						     i_user_ns(inode),
> +						     pa->e_gid);
>  				if (in_group_p(gid)) {
>  					found = 1;
>  					if ((pa->e_perm & want) == want)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3d6d514943ab..493b87e3616b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1641,7 +1641,7 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
>  static inline kuid_t i_uid_into_mnt(struct user_namespace *mnt_userns,
>  				    const struct inode *inode)
>  {
> -	return mapped_kuid_fs(mnt_userns, &init_user_ns, inode->i_uid);
> +	return mapped_kuid_fs(mnt_userns, i_user_ns(inode), inode->i_uid);
>  }
>  
>  /**
> @@ -1655,7 +1655,7 @@ static inline kuid_t i_uid_into_mnt(struct user_namespace *mnt_userns,
>  static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
>  				    const struct inode *inode)
>  {
> -	return mapped_kgid_fs(mnt_userns, &init_user_ns, inode->i_gid);
> +	return mapped_kgid_fs(mnt_userns, i_user_ns(inode), inode->i_gid);
>  }
>  
>  /**
> @@ -1669,7 +1669,7 @@ static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
>  static inline void inode_fsuid_set(struct inode *inode,
>  				   struct user_namespace *mnt_userns)
>  {
> -	inode->i_uid = mapped_fsuid(mnt_userns, &init_user_ns);
> +	inode->i_uid = mapped_fsuid(mnt_userns, i_user_ns(inode));
>  }
>  
>  /**
> @@ -1683,7 +1683,7 @@ static inline void inode_fsuid_set(struct inode *inode,
>  static inline void inode_fsgid_set(struct inode *inode,
>  				   struct user_namespace *mnt_userns)
>  {
> -	inode->i_gid = mapped_fsgid(mnt_userns, &init_user_ns);
> +	inode->i_gid = mapped_fsgid(mnt_userns, i_user_ns(inode));
>  }
>  
>  /**
> @@ -1704,10 +1704,10 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
>  	kuid_t kuid;
>  	kgid_t kgid;
>  
> -	kuid = mapped_fsuid(mnt_userns, &init_user_ns);
> +	kuid = mapped_fsuid(mnt_userns, fs_userns);
>  	if (!uid_valid(kuid))
>  		return false;
> -	kgid = mapped_fsgid(mnt_userns, &init_user_ns);
> +	kgid = mapped_fsgid(mnt_userns, fs_userns);
>  	if (!gid_valid(kgid))
>  		return false;
>  	return kuid_has_mapping(fs_userns, kuid) &&
> @@ -2653,13 +2653,14 @@ static inline struct user_namespace *file_mnt_user_ns(struct file *file)
>   * is_idmapped_mnt - check whether a mount is mapped
>   * @mnt: the mount to check
>   *
> - * If @mnt has an idmapping attached to it @mnt is mapped.
> + * If @mnt has an idmapping attached different from the
> + * filesystem's idmapping then @mnt is mapped.
>   *
>   * Return: true if mount is mapped, false if not.
>   */
>  static inline bool is_idmapped_mnt(const struct vfsmount *mnt)
>  {
> -	return mnt_user_ns(mnt) != &init_user_ns;
> +	return mnt_user_ns(mnt) != mnt->mnt_sb->s_user_ns;
>  }
>  
>  extern long vfs_truncate(const struct path *, loff_t);
> diff --git a/security/commoncap.c b/security/commoncap.c
> index d288a62e2999..5fc8986c3c77 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -419,7 +419,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
>  	kroot = make_kuid(fs_ns, root);
>  
>  	/* If this is an idmapped mount shift the kuid. */
> -	kroot = mapped_kuid_fs(mnt_userns, &init_user_ns, kroot);
> +	kroot = mapped_kuid_fs(mnt_userns, fs_ns, kroot);
>  
>  	/* If the root kuid maps to a valid uid in current ns, then return
>  	 * this as a nscap. */
> @@ -556,13 +556,12 @@ int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
>  		return -EINVAL;
>  	if (!capable_wrt_inode_uidgid(mnt_userns, inode, CAP_SETFCAP))
>  		return -EPERM;
> -	if (size == XATTR_CAPS_SZ_2 && (mnt_userns == &init_user_ns))
> +	if (size == XATTR_CAPS_SZ_2 && (mnt_userns == fs_ns))
>  		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
>  			/* user is privileged, just write the v2 */
>  			return size;
>  
> -	rootid = rootid_from_xattr(*ivalue, size, task_ns, mnt_userns,
> -				   &init_user_ns);
> +	rootid = rootid_from_xattr(*ivalue, size, task_ns, mnt_userns, fs_ns);
>  	if (!uid_valid(rootid))
>  		return -EINVAL;
>  
> @@ -703,7 +702,7 @@ int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
>  	/* Limit the caps to the mounter of the filesystem
>  	 * or the more limited uid specified in the xattr.
>  	 */
> -	rootkuid = mapped_kuid_fs(mnt_userns, &init_user_ns, rootkuid);
> +	rootkuid = mapped_kuid_fs(mnt_userns, fs_ns, rootkuid);
>  	if (!rootid_owns_currentns(rootkuid))
>  		return -ENODATA;
>  
> -- 
> 2.30.2
> 
