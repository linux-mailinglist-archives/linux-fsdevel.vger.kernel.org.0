Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB73163622
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 23:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgBRWdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 17:33:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgBRWdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CBB3Cw/i5V2iABelskf1wX1jXbxsoxlcQKlQSFKTK6o=; b=mqhbvIHp5KF9cGmqk/SU4lN3yX
        CCu3wFKT0GlBXbEEjBB6ppZYQcTu3OlBa1c449OURCK8+Ik1Y6lQjc0NwUSSaPng7pHUUPDesbtVm
        WJG9YP2dm9luroFRQNo+LzpoxiAeQfnc9tmnLPz8yWL9EsbnVVMVhfDrhGRnqhi9TIdMURRpqBBin
        pw2lyRVxZ0+Gs3A7L8GtMf9n+L/yhp6JE4yxURslzZb4uvVvjwFrl2Mvw3bKS33UEZK5LvqqvFf4K
        JPS1qWieSUDzJb1QbV9tGUkGLqV1FRIoUJ+ijXMD7C1n9U6qqjAUHW0Ou+2409bTtrVPSlAFp42vt
        ZdoVFS2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4BQX-0006AV-Rr; Tue, 18 Feb 2020 22:33:13 +0000
Date:   Tue, 18 Feb 2020 14:33:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-unionfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tycho Andersen <tycho@tycho.ws>,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH v3 2/3] fs: introduce uid/gid shifting bind mount
Message-ID: <20200218223313.GA15846@infradead.org>
References: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
 <20200217205307.32256-3-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217205307.32256-3-James.Bottomley@HansenPartnership.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 12:53:06PM -0800, James Bottomley wrote:
> 
> v3: added a bind mount base shift at the request of Serge Hallyn
> ---
>  fs/attr.c             | 127 +++++++++++++++++++++++++++++++++++++++++---------
>  fs/exec.c             |   3 +-
>  fs/inode.c            |  10 ++--
>  fs/internal.h         |   2 +
>  fs/mount.h            |   1 +
>  fs/namei.c            | 112 +++++++++++++++++++++++++++++++++++++-------
>  fs/namespace.c        |   5 ++
>  fs/open.c             |  25 +++++++++-
>  fs/posix_acl.c        |   4 +-
>  fs/stat.c             |  32 +++++++++++--
>  include/linux/cred.h  |  12 +++++
>  include/linux/mount.h |   4 +-
>  include/linux/sched.h |   5 ++
>  kernel/capability.c   |   9 +++-
>  kernel/cred.c         |  20 ++++++++
>  15 files changed, 317 insertions(+), 54 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index 11201ab7e3b1..d7c5883a4b4c 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -18,14 +18,26 @@
>  #include <linux/evm.h>
>  #include <linux/ima.h>
>  
> +#include "internal.h"
> +#include "mount.h"
> +
>  static bool chown_ok(const struct inode *inode, kuid_t uid)
>  {
> +	kuid_t i_uid = inode->i_uid;
> +
> +	if (cred_is_shifted()) {
> +		struct mount *m = real_mount(current->mnt);
> +
> +		i_uid = KUIDT_INIT(from_kuid(m->mnt_userns, i_uid));
> +		i_uid = make_kuid(current_user_ns(), __kuid_val(i_uid));
> +	}
> +
>  	if (uid_eq(current_fsuid(), inode->i_uid) &&
> -	    uid_eq(uid, inode->i_uid))
> +	    uid_eq(uid, i_uid))
>  		return true;
>  	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
>  		return true;
> -	if (uid_eq(inode->i_uid, INVALID_UID) &&
> +	if (uid_eq(i_uid, INVALID_UID) &&
>  	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
>  		return true;
>  	return false;
> @@ -33,17 +45,40 @@ static bool chown_ok(const struct inode *inode, kuid_t uid)
>  
>  static bool chgrp_ok(const struct inode *inode, kgid_t gid)
>  {
> +	kgid_t i_gid = inode->i_gid;
> +	kuid_t i_uid = inode->i_uid;
> +
> +	if (cred_is_shifted()) {
> +		struct mount *m = real_mount(current->mnt);
> +		struct user_namespace *ns = current_user_ns();
> +
> +		i_uid = KUIDT_INIT(from_kuid(m->mnt_userns, i_uid));
> +		i_uid = make_kuid(ns, __kuid_val(i_uid));
> +		i_gid = KGIDT_INIT(from_kgid(m->mnt_userns, i_gid));
> +		i_gid = make_kgid(ns, __kgid_val(i_gid));
> +	}
>  	if (uid_eq(current_fsuid(), inode->i_uid) &&
> -	    (in_group_p(gid) || gid_eq(gid, inode->i_gid)))
> +	    (in_group_p(gid) || gid_eq(gid, i_gid)))
>  		return true;
>  	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
>  		return true;
> -	if (gid_eq(inode->i_gid, INVALID_GID) &&
> +	if (gid_eq(i_gid, INVALID_GID) &&
>  	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
>  		return true;
>  	return false;
>  }
>  
> +int in_group_p_shifted(kgid_t grp)
> +{
> +	if (cred_is_shifted()) {
> +		struct mount *m = real_mount(current->mnt);
> +
> +		grp = KGIDT_INIT(from_kgid(m->mnt_userns, grp));
> +		grp = make_kgid(current_user_ns(), __kgid_val(grp));
> +	}
> +	return in_group_p(grp);
> +}
> +
>  /**
>   * setattr_prepare - check if attribute changes to a dentry are allowed
>   * @dentry:	dentry to check
> @@ -89,9 +124,10 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
>  	if (ia_valid & ATTR_MODE) {
>  		if (!inode_owner_or_capable(inode))
>  			return -EPERM;
> +
>  		/* Also check the setgid bit! */
> -		if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
> -				inode->i_gid) &&
> +		if (!in_group_p_shifted((ia_valid & ATTR_GID) ? attr->ia_gid :
> +					inode->i_gid) &&
>  		    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
>  			attr->ia_mode &= ~S_ISGID;
>  	}
> @@ -192,7 +228,7 @@ void setattr_copy(struct inode *inode, const struct iattr *attr)
>  	if (ia_valid & ATTR_MODE) {
>  		umode_t mode = attr->ia_mode;
>  
> -		if (!in_group_p(inode->i_gid) &&
> +		if (!in_group_p_shifted(inode->i_gid) &&
>  		    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
>  			mode &= ~S_ISGID;
>  		inode->i_mode = mode;
> @@ -200,6 +236,23 @@ void setattr_copy(struct inode *inode, const struct iattr *attr)
>  }
>  EXPORT_SYMBOL(setattr_copy);
>  
> +void cred_shift(kuid_t *uid, kgid_t *gid)
> +{
> +	if (cred_is_shifted()) {
> +		struct user_namespace *ns = current_user_ns();
> +		struct mount *m = real_mount(current->mnt);
> +
> +		if (uid) {
> +			*uid = KUIDT_INIT(from_kuid(m->mnt_userns, *uid));
> +			*uid = make_kuid(ns, __kuid_val(*uid));
> +		}
> +		if (gid) {
> +			*gid = KGIDT_INIT(from_kgid(m->mnt_userns, *gid));
> +			*gid = make_kgid(ns, __kgid_val(*gid));
> +		}
> +	}
> +}
> +
>  /**
>   * notify_change - modify attributes of a filesytem object
>   * @dentry:	object affected
> @@ -229,6 +282,9 @@ int notify_change(const struct path *path, struct iattr * attr,
>  	int error;
>  	struct timespec64 now;
>  	unsigned int ia_valid = attr->ia_valid;
> +	const struct cred *cred;
> +	kuid_t i_uid = inode->i_uid;
> +	kgid_t i_gid = inode->i_gid;
>  
>  	WARN_ON_ONCE(!inode_is_locked(inode));
>  
> @@ -237,18 +293,30 @@ int notify_change(const struct path *path, struct iattr * attr,
>  			return -EPERM;
>  	}
>  
> +	cred = change_userns_creds(path);
> +	if (cred) {
> +		struct mount *m = real_mount(path->mnt);
> +
> +		attr->ia_uid = KUIDT_INIT(from_kuid(m->mnt_ns->user_ns, attr->ia_uid));
> +		attr->ia_uid = make_kuid(m->mnt_userns, __kuid_val(attr->ia_uid));
> +		attr->ia_gid = KGIDT_INIT(from_kgid(m->mnt_ns->user_ns, attr->ia_gid));
> +		attr->ia_gid = make_kgid(m->mnt_userns, __kgid_val(attr->ia_gid));
> +	}
> +
>  	/*
>  	 * If utimes(2) and friends are called with times == NULL (or both
>  	 * times are UTIME_NOW), then we need to check for write permission
>  	 */
>  	if (ia_valid & ATTR_TOUCH) {
> -		if (IS_IMMUTABLE(inode))
> -			return -EPERM;
> +		if (IS_IMMUTABLE(inode)) {
> +			error = -EPERM;
> +			goto err;
> +		}
>  
>  		if (!inode_owner_or_capable(inode)) {
>  			error = inode_permission(inode, MAY_WRITE);
>  			if (error)
> -				return error;
> +				goto err;
>  		}
>  	}
>  
> @@ -274,7 +342,7 @@ int notify_change(const struct path *path, struct iattr * attr,
>  	if (ia_valid & ATTR_KILL_PRIV) {
>  		error = security_inode_need_killpriv(dentry);
>  		if (error < 0)
> -			return error;
> +			goto err;
>  		if (error == 0)
>  			ia_valid = attr->ia_valid &= ~ATTR_KILL_PRIV;
>  	}
> @@ -305,34 +373,49 @@ int notify_change(const struct path *path, struct iattr * attr,
>  			attr->ia_mode &= ~S_ISGID;
>  		}
>  	}
> -	if (!(attr->ia_valid & ~(ATTR_KILL_SUID | ATTR_KILL_SGID)))
> -		return 0;
> +	if (!(attr->ia_valid & ~(ATTR_KILL_SUID | ATTR_KILL_SGID))) {
> +		error = 0;
> +		goto err;
> +	}
>  
>  	/*
>  	 * Verify that uid/gid changes are valid in the target
>  	 * namespace of the superblock.
>  	 */
> +	error = -EOVERFLOW;
>  	if (ia_valid & ATTR_UID &&
>  	    !kuid_has_mapping(inode->i_sb->s_user_ns, attr->ia_uid))
> -		return -EOVERFLOW;
> +		goto err;
> +
>  	if (ia_valid & ATTR_GID &&
>  	    !kgid_has_mapping(inode->i_sb->s_user_ns, attr->ia_gid))
> -		return -EOVERFLOW;
> +		goto err;
>  
>  	/* Don't allow modifications of files with invalid uids or
>  	 * gids unless those uids & gids are being made valid.
>  	 */
> -	if (!(ia_valid & ATTR_UID) && !uid_valid(inode->i_uid))
> -		return -EOVERFLOW;
> -	if (!(ia_valid & ATTR_GID) && !gid_valid(inode->i_gid))
> -		return -EOVERFLOW;
> +	if (cred_is_shifted()) {
> +		struct user_namespace *ns = current_user_ns();
> +		struct mount *m = real_mount(current->mnt);
> +
> +		i_uid = KUIDT_INIT(from_kuid(m->mnt_userns, i_uid));
> +		i_uid = make_kuid(ns, __kuid_val(i_uid));
> +		i_gid = KGIDT_INIT(from_kgid(m->mnt_userns, i_gid));
> +		i_gid = make_kgid(ns, __kgid_val(i_gid));
> +	}
> +
> +	if (!(ia_valid & ATTR_UID) && !uid_valid(i_uid))
> +		goto err;
> +
> +	if (!(ia_valid & ATTR_GID) && !gid_valid(i_gid))
> +		goto err;
>  
>  	error = security_inode_setattr(dentry, attr);
>  	if (error)
> -		return error;
> +		goto err;
>  	error = try_break_deleg(inode, delegated_inode);
>  	if (error)
> -		return error;
> +		goto err;
>  
>  	if (inode->i_op->setattr)
>  		error = inode->i_op->setattr(dentry, attr);
> @@ -345,6 +428,8 @@ int notify_change(const struct path *path, struct iattr * attr,
>  		evm_inode_post_setattr(dentry, ia_valid);
>  	}
>  
> + err:
> +	revert_userns_creds(cred);
>  	return error;
>  }
>  EXPORT_SYMBOL(notify_change);
> diff --git a/fs/exec.c b/fs/exec.c
> index db17be51b112..926bab39ed45 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1543,13 +1543,14 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
>  
>  	/* Be careful if suid/sgid is set */
>  	inode_lock(inode);
> -
>  	/* reload atomically mode/uid/gid now that lock held */
>  	mode = inode->i_mode;
>  	uid = inode->i_uid;
>  	gid = inode->i_gid;
>  	inode_unlock(inode);
>  
> +	cred_shift(&uid, &gid);
> +
>  	/* We ignore suid/sgid if there are no mappings for them in the ns */
>  	if (!kuid_has_mapping(bprm->cred->user_ns, uid) ||
>  		 !kgid_has_mapping(bprm->cred->user_ns, gid))
> diff --git a/fs/inode.c b/fs/inode.c
> index be14d3fcbee1..ae75b6396786 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2064,7 +2064,7 @@ void inode_init_owner(struct inode *inode, const struct inode *dir,
>  		if (S_ISDIR(mode))
>  			mode |= S_ISGID;
>  		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
> -			 !in_group_p(inode->i_gid) &&
> +			 !in_group_p_shifted(inode->i_gid) &&
>  			 !capable_wrt_inode_uidgid(dir, CAP_FSETID))
>  			mode &= ~S_ISGID;
>  	} else
> @@ -2083,12 +2083,16 @@ EXPORT_SYMBOL(inode_init_owner);
>  bool inode_owner_or_capable(const struct inode *inode)
>  {
>  	struct user_namespace *ns;
> +	kuid_t uid = inode->i_uid;
>  
> -	if (uid_eq(current_fsuid(), inode->i_uid))
> +	if (uid_eq(current_fsuid(), uid))
>  		return true;
>  
>  	ns = current_user_ns();
> -	if (kuid_has_mapping(ns, inode->i_uid) && ns_capable(ns, CAP_FOWNER))
> +
> +	cred_shift(&uid, NULL);
> +
> +	if (kuid_has_mapping(ns, uid) && ns_capable(ns, CAP_FOWNER))
>  		return true;
>  	return false;
>  }
> diff --git a/fs/internal.h b/fs/internal.h
> index 80d89ddb9b28..d2adcdb3eb2e 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -73,6 +73,8 @@ long do_symlinkat(const char __user *oldname, int newdfd,
>  		  const char __user *newname);
>  int do_linkat(int olddfd, const char __user *oldname, int newdfd,
>  	      const char __user *newname, int flags);
> +const struct cred *change_userns_creds(const struct path *p);
> +void revert_userns_creds(const struct cred *cred);
>  
>  /*
>   * namespace.c
> diff --git a/fs/mount.h b/fs/mount.h
> index 711a4093e475..c3bfc6ced4c7 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -72,6 +72,7 @@ struct mount {
>  	int mnt_expiry_mark;		/* true if marked for expiry */
>  	struct hlist_head mnt_pins;
>  	struct hlist_head mnt_stuck_children;
> +	struct user_namespace *mnt_userns; /* mapping for underlying mount uid/gid */
>  } __randomize_layout;
>  
>  #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
> diff --git a/fs/namei.c b/fs/namei.c
> index 531ac55c7e67..369bd18c7330 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -124,6 +124,42 @@
>  
>  #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
>  
> +const struct cred *change_userns_creds(const struct path *p)
> +{
> +	struct mount *m = real_mount(p->mnt);
> +
> +	if ((p->mnt->mnt_flags & MNT_SHIFT) == 0)
> +		return NULL;
> +
> +	if (current->nsproxy->mnt_ns->user_ns != m->mnt_ns->user_ns)
> +		return NULL;
> +
> +	if (current->mnt != p->mnt) {
> +		struct cred *cred;
> +		struct user_namespace *user_ns = m->mnt_ns->user_ns;
> +		kuid_t fsuid = current->cred->fsuid;
> +		kgid_t fsgid = current->cred->fsgid;
> +
> +		if (current->mnt_cred)
> +			put_cred(current->mnt_cred);
> +		cred = prepare_creds();
> +		fsuid = KUIDT_INIT(from_kuid(user_ns, fsuid));
> +		fsgid = KGIDT_INIT(from_kgid(user_ns, fsgid));
> +		cred->fsuid = make_kuid(m->mnt_userns, __kuid_val(fsuid));
> +		cred->fsgid = make_kgid(m->mnt_userns, __kgid_val(fsgid));
> +		current->mnt = p->mnt; /* no reference needed */
> +		current->mnt_cred = cred;
> +	}
> +	return override_creds(current->mnt_cred);
> +}
> +
> +void revert_userns_creds(const struct cred *cred)
> +{
> +	if (!cred)
> +		return;
> +	revert_creds(cred);
> +}
> +
>  struct filename *
>  getname_flags(const char __user *filename, int flags, int *empty)
>  {
> @@ -303,7 +339,7 @@ static int acl_permission_check(struct inode *inode, int mask)
>  				return error;
>  		}
>  
> -		if (in_group_p(inode->i_gid))
> +		if (in_group_p_shifted(inode->i_gid))
>  			mode >>= 3;
>  	}
>  
> @@ -366,7 +402,6 @@ int generic_permission(struct inode *inode, int mask)
>  	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
>  		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
>  			return 0;
> -
>  	return -EACCES;
>  }
>  EXPORT_SYMBOL(generic_permission);
> @@ -1897,6 +1932,7 @@ static int walk_component(struct nameidata *nd, int flags)
>  	struct inode *inode;
>  	unsigned seq;
>  	int err;
> +	const struct cred *cred;
>  	/*
>  	 * "." and ".." are special - ".." especially so because it has
>  	 * to be able to know about the current root directory and
> @@ -1908,25 +1944,31 @@ static int walk_component(struct nameidata *nd, int flags)
>  			put_link(nd);
>  		return err;
>  	}
> +	cred = change_userns_creds(&nd->path);
>  	err = lookup_fast(nd, &path, &inode, &seq);
>  	if (unlikely(err <= 0)) {
>  		if (err < 0)
> -			return err;
> +			goto out;
>  		path.dentry = lookup_slow(&nd->last, nd->path.dentry,
>  					  nd->flags);
> -		if (IS_ERR(path.dentry))
> -			return PTR_ERR(path.dentry);
> +		if (IS_ERR(path.dentry)) {
> +			err = PTR_ERR(path.dentry);
> +			goto out;
> +		}
>  
>  		path.mnt = nd->path.mnt;
>  		err = follow_managed(&path, nd);
>  		if (unlikely(err < 0))
> -			return err;
> +			goto out;
>  
>  		seq = 0;	/* we are already out of RCU mode */
>  		inode = d_backing_inode(path.dentry);
>  	}
>  
> -	return step_into(nd, &path, flags, inode, seq);
> +	err = step_into(nd, &path, flags, inode, seq);
> + out:
> +	revert_userns_creds(cred);
> +	return err;
>  }
>  
>  /*
> @@ -2180,8 +2222,10 @@ static int link_path_walk(const char *name, struct nameidata *nd)
>  	for(;;) {
>  		u64 hash_len;
>  		int type;
> +		const struct cred *cred = change_userns_creds(&nd->path);
>  
>  		err = may_lookup(nd);
> +		revert_userns_creds(cred);
>  		if (err)
>  			return err;
>  
> @@ -2373,12 +2417,17 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
>  static const char *trailing_symlink(struct nameidata *nd)
>  {
>  	const char *s;
> +	const struct cred *cred = change_userns_creds(&nd->path);
>  	int error = may_follow_link(nd);
> -	if (unlikely(error))
> -		return ERR_PTR(error);
> +	if (unlikely(error)) {
> +		s = ERR_PTR(error);
> +		goto out;
> +	}
>  	nd->flags |= LOOKUP_PARENT;
>  	nd->stack[0].name = NULL;
>  	s = get_link(nd);
> + out:
> +	revert_userns_creds(cred);
>  	return s ? s : "";
>  }
>  
> @@ -3343,6 +3392,7 @@ static int do_last(struct nameidata *nd,
>  	struct inode *inode;
>  	struct path path;
>  	int error;
> +	const struct cred *cred = change_userns_creds(&nd->path);
>  
>  	nd->flags &= ~LOOKUP_PARENT;
>  	nd->flags |= op->intent;
> @@ -3350,7 +3400,7 @@ static int do_last(struct nameidata *nd,
>  	if (nd->last_type != LAST_NORM) {
>  		error = handle_dots(nd, nd->last_type);
>  		if (unlikely(error))
> -			return error;
> +			goto err;
>  		goto finish_open;
>  	}
>  
> @@ -3363,7 +3413,7 @@ static int do_last(struct nameidata *nd,
>  			goto finish_lookup;
>  
>  		if (error < 0)
> -			return error;
> +			goto err;
>  
>  		BUG_ON(nd->inode != dir->d_inode);
>  		BUG_ON(nd->flags & LOOKUP_RCU);
> @@ -3376,12 +3426,14 @@ static int do_last(struct nameidata *nd,
>  		 */
>  		error = complete_walk(nd);
>  		if (error)
> -			return error;
> +			goto err;
>  
>  		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
>  		/* trailing slashes? */
> -		if (unlikely(nd->last.name[nd->last.len]))
> -			return -EISDIR;
> +		if (unlikely(nd->last.name[nd->last.len])) {
> +			error = -EISDIR;
> +			goto err;
> +		}
>  	}
>  
>  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> @@ -3437,7 +3489,7 @@ static int do_last(struct nameidata *nd,
>  
>  	error = follow_managed(&path, nd);
>  	if (unlikely(error < 0))
> -		return error;
> +		goto err;
>  
>  	/*
>  	 * create/update audit record if it already exists.
> @@ -3446,7 +3498,8 @@ static int do_last(struct nameidata *nd,
>  
>  	if (unlikely((open_flag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT))) {
>  		path_to_nameidata(&path, nd);
> -		return -EEXIST;
> +		error = -EEXIST;
> +		goto err;
>  	}
>  
>  	seq = 0;	/* out of RCU mode, so the value doesn't matter */
> @@ -3454,12 +3507,12 @@ static int do_last(struct nameidata *nd,
>  finish_lookup:
>  	error = step_into(nd, &path, 0, inode, seq);
>  	if (unlikely(error))
> -		return error;
> +		goto err;
>  finish_open:
>  	/* Why this, you ask?  _Now_ we might have grown LOOKUP_JUMPED... */
>  	error = complete_walk(nd);
>  	if (error)
> -		return error;
> +		goto err;
>  	audit_inode(nd->name, nd->path.dentry, 0);
>  	if (open_flag & O_CREAT) {
>  		error = -EISDIR;
> @@ -3501,6 +3554,8 @@ static int do_last(struct nameidata *nd,
>  	}
>  	if (got_write)
>  		mnt_drop_write(nd->path.mnt);
> + err:
> +	revert_userns_creds(cred);
>  	return error;
>  }
>  
> @@ -3819,6 +3874,7 @@ long do_mknodat(int dfd, const char __user *filename, umode_t mode,
>  	struct path path;
>  	int error;
>  	unsigned int lookup_flags = 0;
> +	const struct cred *cred;
>  
>  	error = may_mknod(mode);
>  	if (error)
> @@ -3828,6 +3884,7 @@ long do_mknodat(int dfd, const char __user *filename, umode_t mode,
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> +	cred = change_userns_creds(&path);
>  	if (!IS_POSIXACL(path.dentry->d_inode))
>  		mode &= ~current_umask();
>  	error = security_path_mknod(&path, dentry, mode, dev);
> @@ -3849,6 +3906,7 @@ long do_mknodat(int dfd, const char __user *filename, umode_t mode,
>  	}
>  out:
>  	done_path_create(&path, dentry);
> +	revert_userns_creds(cred);
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;
>  		goto retry;
> @@ -3899,18 +3957,21 @@ long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
>  	struct path path;
>  	int error;
>  	unsigned int lookup_flags = LOOKUP_DIRECTORY;
> +	const struct cred *cred;
>  
>  retry:
>  	dentry = user_path_create(dfd, pathname, &path, lookup_flags);
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> +	cred = change_userns_creds(&path);
>  	if (!IS_POSIXACL(path.dentry->d_inode))
>  		mode &= ~current_umask();
>  	error = security_path_mkdir(&path, dentry, mode);
>  	if (!error)
>  		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);
>  	done_path_create(&path, dentry);
> +	revert_userns_creds(cred);
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;
>  		goto retry;
> @@ -3977,12 +4038,14 @@ long do_rmdir(int dfd, const char __user *pathname)
>  	struct qstr last;
>  	int type;
>  	unsigned int lookup_flags = 0;
> +	const struct cred *cred;
>  retry:
>  	name = filename_parentat(dfd, getname(pathname), lookup_flags,
>  				&path, &last, &type);
>  	if (IS_ERR(name))
>  		return PTR_ERR(name);
>  
> +	cred = change_userns_creds(&path);
>  	switch (type) {
>  	case LAST_DOTDOT:
>  		error = -ENOTEMPTY;
> @@ -4018,6 +4081,7 @@ long do_rmdir(int dfd, const char __user *pathname)
>  	inode_unlock(path.dentry->d_inode);
>  	mnt_drop_write(path.mnt);
>  exit1:
> +	revert_userns_creds(cred);
>  	path_put(&path);
>  	putname(name);
>  	if (retry_estale(error, lookup_flags)) {
> @@ -4107,11 +4171,13 @@ long do_unlinkat(int dfd, struct filename *name)
>  	struct inode *inode = NULL;
>  	struct inode *delegated_inode = NULL;
>  	unsigned int lookup_flags = 0;
> +	const struct cred *cred;
>  retry:
>  	name = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
>  	if (IS_ERR(name))
>  		return PTR_ERR(name);
>  
> +	cred = change_userns_creds(&path);
>  	error = -EISDIR;
>  	if (type != LAST_NORM)
>  		goto exit1;
> @@ -4149,6 +4215,7 @@ long do_unlinkat(int dfd, struct filename *name)
>  	}
>  	mnt_drop_write(path.mnt);
>  exit1:
> +	revert_userns_creds(cred);
>  	path_put(&path);
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;
> @@ -4213,6 +4280,7 @@ long do_symlinkat(const char __user *oldname, int newdfd,
>  	struct dentry *dentry;
>  	struct path path;
>  	unsigned int lookup_flags = 0;
> +	const struct cred *cred;
>  
>  	from = getname(oldname);
>  	if (IS_ERR(from))
> @@ -4223,6 +4291,7 @@ long do_symlinkat(const char __user *oldname, int newdfd,
>  	if (IS_ERR(dentry))
>  		goto out_putname;
>  
> +	cred = change_userns_creds(&path);
>  	error = security_path_symlink(&path, dentry, from->name);
>  	if (!error)
>  		error = vfs_symlink(path.dentry->d_inode, dentry, from->name);
> @@ -4231,6 +4300,7 @@ long do_symlinkat(const char __user *oldname, int newdfd,
>  		lookup_flags |= LOOKUP_REVAL;
>  		goto retry;
>  	}
> +	revert_userns_creds(cred);
>  out_putname:
>  	putname(from);
>  	return error;
> @@ -4344,6 +4414,7 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
>  	struct inode *delegated_inode = NULL;
>  	int how = 0;
>  	int error;
> +	const struct cred *cred;
>  
>  	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
>  		return -EINVAL;
> @@ -4371,6 +4442,7 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
>  	if (IS_ERR(new_dentry))
>  		goto out;
>  
> +	cred = change_userns_creds(&new_path);
>  	error = -EXDEV;
>  	if (old_path.mnt != new_path.mnt)
>  		goto out_dput;
> @@ -4382,6 +4454,7 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
>  		goto out_dput;
>  	error = vfs_link(old_path.dentry, new_path.dentry->d_inode, new_dentry, &delegated_inode);
>  out_dput:
> +	revert_userns_creds(cred);
>  	done_path_create(&new_path, new_dentry);
>  	if (delegated_inode) {
>  		error = break_deleg_wait(&delegated_inode);
> @@ -4601,6 +4674,7 @@ static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
>  	unsigned int lookup_flags = 0, target_flags = LOOKUP_RENAME_TARGET;
>  	bool should_retry = false;
>  	int error;
> +	const struct cred *cred;
>  
>  	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
>  		return -EINVAL;
> @@ -4630,6 +4704,7 @@ static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
>  		goto exit1;
>  	}
>  
> +	cred = change_userns_creds(&new_path);
>  	error = -EXDEV;
>  	if (old_path.mnt != new_path.mnt)
>  		goto exit2;
> @@ -4714,6 +4789,7 @@ static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
>  	}
>  	mnt_drop_write(old_path.mnt);
>  exit2:
> +	revert_userns_creds(cred);
>  	if (retry_estale(error, lookup_flags))
>  		should_retry = true;
>  	path_put(&new_path);
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 69fb23ae3d8f..4720647588ab 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -200,6 +200,8 @@ static struct mount *alloc_vfsmnt(const char *name)
>  		mnt->mnt_writers = 0;
>  #endif
>  
> +		mnt->mnt_userns = get_user_ns(&init_user_ns);
> +
>  		INIT_HLIST_NODE(&mnt->mnt_hash);
>  		INIT_LIST_HEAD(&mnt->mnt_child);
>  		INIT_LIST_HEAD(&mnt->mnt_mounts);
> @@ -1044,6 +1046,8 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
>  	mnt->mnt.mnt_root = dget(root);
>  	mnt->mnt_mountpoint = mnt->mnt.mnt_root;
>  	mnt->mnt_parent = mnt;
> +	put_user_ns(mnt->mnt_userns);
> +	mnt->mnt_userns = get_user_ns(old->mnt_userns);
>  	lock_mount_hash();
>  	list_add_tail(&mnt->mnt_instance, &sb->s_mounts);
>  	unlock_mount_hash();
> @@ -1102,6 +1106,7 @@ static void cleanup_mnt(struct mount *mnt)
>  	dput(mnt->mnt.mnt_root);
>  	deactivate_super(mnt->mnt.mnt_sb);
>  	mnt_free_id(mnt);
> +	put_user_ns(mnt->mnt_userns);
>  	call_rcu(&mnt->mnt_rcu, delayed_free_vfsmnt);
>  }
>  
> diff --git a/fs/open.c b/fs/open.c
> index db6758b9636a..d27b90dce64d 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -456,11 +456,13 @@ int ksys_chdir(const char __user *filename)
>  	struct path path;
>  	int error;
>  	unsigned int lookup_flags = LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> +	const struct cred *cred;
>  retry:
>  	error = user_path_at(AT_FDCWD, filename, lookup_flags, &path);
>  	if (error)
>  		goto out;
>  
> +	cred = change_userns_creds(&path);
>  	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
>  	if (error)
>  		goto dput_and_out;
> @@ -468,6 +470,7 @@ int ksys_chdir(const char __user *filename)
>  	set_fs_pwd(current->fs, &path);
>  
>  dput_and_out:
> +	revert_userns_creds(cred);
>  	path_put(&path);
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;
> @@ -486,11 +489,13 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
>  {
>  	struct fd f = fdget_raw(fd);
>  	int error;
> +	const struct cred *cred;
>  
>  	error = -EBADF;
>  	if (!f.file)
>  		goto out;
>  
> +	cred = change_userns_creds(&f.file->f_path);
>  	error = -ENOTDIR;
>  	if (!d_can_lookup(f.file->f_path.dentry))
>  		goto out_putf;
> @@ -499,6 +504,7 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
>  	if (!error)
>  		set_fs_pwd(current->fs, &f.file->f_path);
>  out_putf:
> +	revert_userns_creds(cred);
>  	fdput(f);
>  out:
>  	return error;
> @@ -547,11 +553,13 @@ static int chmod_common(const struct path *path, umode_t mode)
>  	struct inode *inode = path->dentry->d_inode;
>  	struct inode *delegated_inode = NULL;
>  	struct iattr newattrs;
> +	const struct cred *cred;
>  	int error;
>  
> +	cred = change_userns_creds(path);
>  	error = mnt_want_write(path->mnt);
>  	if (error)
> -		return error;
> +		goto out;
>  retry_deleg:
>  	inode_lock(inode);
>  	error = security_path_chmod(path, mode);
> @@ -568,6 +576,8 @@ static int chmod_common(const struct path *path, umode_t mode)
>  			goto retry_deleg;
>  	}
>  	mnt_drop_write(path->mnt);
> + out:
> +	revert_userns_creds(cred);
>  	return error;
>  }
>  
> @@ -666,6 +676,7 @@ int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
>  	struct path path;
>  	int error = -EINVAL;
>  	int lookup_flags;
> +	const struct cred *cred;
>  
>  	if ((flag & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
>  		goto out;
> @@ -677,12 +688,14 @@ int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
>  	error = user_path_at(dfd, filename, lookup_flags, &path);
>  	if (error)
>  		goto out;
> +	cred = change_userns_creds(&path);
>  	error = mnt_want_write(path.mnt);
>  	if (error)
>  		goto out_release;
>  	error = chown_common(&path, user, group);
>  	mnt_drop_write(path.mnt);
>  out_release:
> +	revert_userns_creds(cred);
>  	path_put(&path);
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;
> @@ -713,10 +726,12 @@ int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
>  {
>  	struct fd f = fdget(fd);
>  	int error = -EBADF;
> +	const struct cred *cred;
>  
>  	if (!f.file)
>  		goto out;
>  
> +	cred = change_userns_creds(&f.file->f_path);
>  	error = mnt_want_write_file(f.file);
>  	if (error)
>  		goto out_fput;
> @@ -724,6 +739,7 @@ int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
>  	error = chown_common(&f.file->f_path, user, group);
>  	mnt_drop_write_file(f.file);
>  out_fput:
> +	revert_userns_creds(cred);
>  	fdput(f);
>  out:
>  	return error;
> @@ -911,8 +927,13 @@ EXPORT_SYMBOL(file_path);
>   */
>  int vfs_open(const struct path *path, struct file *file)
>  {
> +	int ret;
> +	const struct cred *cred = change_userns_creds(path);
> +
>  	file->f_path = *path;
> -	return do_dentry_open(file, d_backing_inode(path->dentry), NULL);
> +	ret = do_dentry_open(file, d_backing_inode(path->dentry), NULL);
> +	revert_userns_creds(cred);
> +	return ret;
>  }
>  
>  struct file *dentry_open(const struct path *path, int flags,
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 249672bf54fe..ff777110f3da 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -364,7 +364,7 @@ posix_acl_permission(struct inode *inode, const struct posix_acl *acl, int want)
>                                          goto mask;
>  				break;
>                          case ACL_GROUP_OBJ:
> -                                if (in_group_p(inode->i_gid)) {
> +				if (in_group_p_shifted(inode->i_gid)) {
>  					found = 1;
>  					if ((pa->e_perm & want) == want)
>  						goto mask;
> @@ -655,7 +655,7 @@ int posix_acl_update_mode(struct inode *inode, umode_t *mode_p,
>  		return error;
>  	if (error == 0)
>  		*acl = NULL;
> -	if (!in_group_p(inode->i_gid) &&
> +	if (!in_group_p_shifted(inode->i_gid) &&
>  	    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
>  		mode &= ~S_ISGID;
>  	*mode_p = mode;
> diff --git a/fs/stat.c b/fs/stat.c
> index 030008796479..634b8d13ed51 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -22,6 +22,7 @@
>  #include <asm/unistd.h>
>  
>  #include "internal.h"
> +#include "mount.h"
>  
>  /**
>   * generic_fillattr - Fill in the basic attributes from the inode struct
> @@ -50,6 +51,23 @@ void generic_fillattr(struct inode *inode, struct kstat *stat)
>  }
>  EXPORT_SYMBOL(generic_fillattr);
>  
> +static void shift_check(struct vfsmount *mnt, struct kstat *stat)
> +{
> +	struct mount *m = real_mount(mnt);
> +	struct user_namespace *user_ns = m->mnt_ns->user_ns;
> +
> +	if ((mnt->mnt_flags & MNT_SHIFT) == 0)
> +		return;
> +
> +	if (current->nsproxy->mnt_ns->user_ns != m->mnt_ns->user_ns)
> +		return;
> +
> +	stat->uid = KUIDT_INIT(from_kuid(m->mnt_userns, stat->uid));
> +	stat->uid = make_kuid(user_ns, __kuid_val(stat->uid));
> +	stat->gid = KGIDT_INIT(from_kgid(m->mnt_userns, stat->gid));
> +	stat->gid = make_kgid(user_ns, __kgid_val(stat->gid));
> +}
> +
>  /**
>   * vfs_getattr_nosec - getattr without security checks
>   * @path: file to get attributes from
> @@ -67,6 +85,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  		      u32 request_mask, unsigned int query_flags)
>  {
>  	struct inode *inode = d_backing_inode(path->dentry);
> +	int ret;
>  
>  	memset(stat, 0, sizeof(*stat));
>  	stat->result_mask |= STATX_BASIC_STATS;
> @@ -79,12 +98,17 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  	if (IS_AUTOMOUNT(inode))
>  		stat->attributes |= STATX_ATTR_AUTOMOUNT;
>  
> +	ret = 0;
>  	if (inode->i_op->getattr)
> -		return inode->i_op->getattr(path, stat, request_mask,
> -					    query_flags);
> +		ret = inode->i_op->getattr(path, stat, request_mask,
> +					   query_flags);
> +	else
> +		generic_fillattr(inode, stat);
>  
> -	generic_fillattr(inode, stat);
> -	return 0;
> +	if (!ret)
> +		shift_check(path->mnt, stat);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(vfs_getattr_nosec);
>  
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 18639c069263..d29638617844 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -59,6 +59,7 @@ extern struct group_info *groups_alloc(int);
>  extern void groups_free(struct group_info *);
>  
>  extern int in_group_p(kgid_t);
> +extern int in_group_p_shifted(kgid_t);

How do I know when to use in_group_p_shifted vs in_group_p?
What about the various other fs callers?
