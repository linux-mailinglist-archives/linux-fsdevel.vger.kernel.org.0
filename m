Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6701C95E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGQDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 12:03:16 -0400
Received: from namei.org ([65.99.196.166]:57536 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgEGQDP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 12:03:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 047G2fNj024861;
        Thu, 7 May 2020 16:02:41 GMT
Date:   Fri, 8 May 2020 02:02:41 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Daniel Colascione <dancol@google.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        nnk@google.com, Stephen Smalley <sds@tycho.nsa.gov>,
        lokeshgidra@google.com
Subject: Re: [PATCH v5 1/3] Add a new LSM-supporting anonymous inode
 interface
In-Reply-To: <20200401213903.182112-2-dancol@google.com>
Message-ID: <alpine.LRH.2.21.2005080201220.15191@namei.org>
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com> <20200401213903.182112-2-dancol@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 1 Apr 2020, Daniel Colascione wrote:

> This change adds two new functions, anon_inode_getfile_secure and
> anon_inode_getfd_secure, that create anonymous-node files with
> individual non-S_PRIVATE inodes to which security modules can apply
> policy. Existing callers continue using the original singleton-inode
> kind of anonymous-inode file. We can transition anonymous inode users
> to the new kind of anonymous inode in individual patches for the sake
> of bisection and review.
> 
> The new functions accept an optional context_inode parameter that
> callers can use to provide additional contextual information to
> security modules, e.g., indicating that one anonymous struct file is a
> logical child of another, allowing a security model to propagate
> security information from one to the other.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>

Al, Andrew, wondering if you could look at these anon inode changes 
before we merge this?



> ---
>  fs/anon_inodes.c            | 191 ++++++++++++++++++++++++++++--------
>  include/linux/anon_inodes.h |  13 +++
>  include/linux/lsm_hooks.h   |  11 +++
>  include/linux/security.h    |   3 +
>  security/security.c         |   9 ++
>  5 files changed, 186 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 89714308c25b..f87f221167cf 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -55,61 +55,108 @@ static struct file_system_type anon_inode_fs_type = {
>  	.kill_sb	= kill_anon_super,
>  };
>  
> -/**
> - * anon_inode_getfile - creates a new file instance by hooking it up to an
> - *                      anonymous inode, and a dentry that describe the "class"
> - *                      of the file
> - *
> - * @name:    [in]    name of the "class" of the new file
> - * @fops:    [in]    file operations for the new file
> - * @priv:    [in]    private data for the new file (will be file's private_data)
> - * @flags:   [in]    flags
> - *
> - * Creates a new file by hooking it on a single inode. This is useful for files
> - * that do not need to have a full-fledged inode in order to operate correctly.
> - * All the files created with anon_inode_getfile() will share a single inode,
> - * hence saving memory and avoiding code duplication for the file/inode/dentry
> - * setup.  Returns the newly created file* or an error pointer.
> - */
> -struct file *anon_inode_getfile(const char *name,
> -				const struct file_operations *fops,
> -				void *priv, int flags)
> +static struct inode *anon_inode_make_secure_inode(
> +	const char *name,
> +	const struct inode *context_inode)
> +{
> +	struct inode *inode;
> +	const struct qstr qname = QSTR_INIT(name, strlen(name));
> +	int error;
> +
> +	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> +	if (IS_ERR(inode))
> +		return inode;
> +	inode->i_flags &= ~S_PRIVATE;
> +	error =	security_inode_init_security_anon(
> +		inode, &qname, context_inode);
> +	if (error) {
> +		iput(inode);
> +		return ERR_PTR(error);
> +	}
> +	return inode;
> +}
> +
> +struct file *_anon_inode_getfile(const char *name,
> +				 const struct file_operations *fops,
> +				 void *priv, int flags,
> +				 const struct inode *context_inode,
> +				 bool secure)
>  {
> +	struct inode *inode;
>  	struct file *file;
>  
> -	if (IS_ERR(anon_inode_inode))
> -		return ERR_PTR(-ENODEV);
> +	if (secure) {
> +		inode =	anon_inode_make_secure_inode(
> +			name, context_inode);
> +		if (IS_ERR(inode))
> +			return ERR_PTR(PTR_ERR(inode));
> +	} else {
> +		inode =	anon_inode_inode;
> +		if (IS_ERR(inode))
> +			return ERR_PTR(-ENODEV);
> +		/*
> +		 * We know the anon_inode inode count is always
> +		 * greater than zero, so ihold() is safe.
> +		 */
> +		ihold(inode);
> +	}
>  
> -	if (fops->owner && !try_module_get(fops->owner))
> -		return ERR_PTR(-ENOENT);
> +	if (fops->owner && !try_module_get(fops->owner)) {
> +		file = ERR_PTR(-ENOENT);
> +		goto err;
> +	}
>  
> -	/*
> -	 * We know the anon_inode inode count is always greater than zero,
> -	 * so ihold() is safe.
> -	 */
> -	ihold(anon_inode_inode);
> -	file = alloc_file_pseudo(anon_inode_inode, anon_inode_mnt, name,
> +	file = alloc_file_pseudo(inode, anon_inode_mnt, name,
>  				 flags & (O_ACCMODE | O_NONBLOCK), fops);
>  	if (IS_ERR(file))
>  		goto err;
>  
> -	file->f_mapping = anon_inode_inode->i_mapping;
> +	file->f_mapping = inode->i_mapping;
>  
>  	file->private_data = priv;
>  
>  	return file;
>  
>  err:
> -	iput(anon_inode_inode);
> +	iput(inode);
>  	module_put(fops->owner);
>  	return file;
>  }
> -EXPORT_SYMBOL_GPL(anon_inode_getfile);
>  
>  /**
> - * anon_inode_getfd - creates a new file instance by hooking it up to an
> - *                    anonymous inode, and a dentry that describe the "class"
> - *                    of the file
> + * anon_inode_getfile_secure - creates a new file instance by hooking
> + *                             it up to a new anonymous inode and a
> + *                             dentry that describe the "class" of the
> + *                             file.  Make it possible to use security
> + *                             modules to control access to the
> + *                             new file.
> + *
> + * @name:    [in]    name of the "class" of the new file
> + * @fops:    [in]    file operations for the new file
> + * @priv:    [in]    private data for the new file (will be file's private_data)
> + * @flags:   [in]    flags
> + *
> + * Creates a new file by hooking it on an unspecified inode. This is
> + * useful for files that do not need to have a full-fledged filesystem
> + * to operate correctly.  All the files created with
> + * anon_inode_getfile_secure() will have distinct inodes, avoiding
> + * code duplication for the file/inode/dentry setup.  Returns the
> + * newly created file* or an error pointer.
> + */
> +struct file *anon_inode_getfile_secure(const char *name,
> +				       const struct file_operations *fops,
> +				       void *priv, int flags,
> +				       const struct inode *context_inode)
> +{
> +	return _anon_inode_getfile(
> +		name, fops, priv, flags, context_inode, true);
> +}
> +EXPORT_SYMBOL_GPL(anon_inode_getfile_secure);
> +
> +/**
> + * anon_inode_getfile - creates a new file instance by hooking it up to an
> + *                      anonymous inode, and a dentry that describe the "class"
> + *                      of the file
>   *
>   * @name:    [in]    name of the "class" of the new file
>   * @fops:    [in]    file operations for the new file
> @@ -118,12 +165,23 @@ EXPORT_SYMBOL_GPL(anon_inode_getfile);
>   *
>   * Creates a new file by hooking it on a single inode. This is useful for files
>   * that do not need to have a full-fledged inode in order to operate correctly.
> - * All the files created with anon_inode_getfd() will share a single inode,
> + * All the files created with anon_inode_getfile() will share a single inode,
>   * hence saving memory and avoiding code duplication for the file/inode/dentry
> - * setup.  Returns new descriptor or an error code.
> + * setup.  Returns the newly created file* or an error pointer.
>   */
> -int anon_inode_getfd(const char *name, const struct file_operations *fops,
> -		     void *priv, int flags)
> +struct file *anon_inode_getfile(const char *name,
> +				const struct file_operations *fops,
> +				void *priv, int flags)
> +{
> +	return _anon_inode_getfile(name, fops, priv, flags, NULL, false);
> +}
> +EXPORT_SYMBOL_GPL(anon_inode_getfile);
> +
> +static int _anon_inode_getfd(const char *name,
> +			     const struct file_operations *fops,
> +			     void *priv, int flags,
> +			     const struct inode *context_inode,
> +			     bool secure)
>  {
>  	int error, fd;
>  	struct file *file;
> @@ -133,7 +191,8 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
>  		return error;
>  	fd = error;
>  
> -	file = anon_inode_getfile(name, fops, priv, flags);
> +	file = _anon_inode_getfile(name, fops, priv, flags, context_inode,
> +				   secure);
>  	if (IS_ERR(file)) {
>  		error = PTR_ERR(file);
>  		goto err_put_unused_fd;
> @@ -146,6 +205,57 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
>  	put_unused_fd(fd);
>  	return error;
>  }
> +
> +/**
> + * anon_inode_getfd_secure - creates a new file instance by hooking it
> + *                           up to a new anonymous inode and a dentry
> + *                           that describe the "class" of the file.
> + *                           Make it possible to use security modules
> + *                           to control access to the new file.
> + *
> + * @name:    [in]    name of the "class" of the new file
> + * @fops:    [in]    file operations for the new file
> + * @priv:    [in]    private data for the new file (will be file's private_data)
> + * @flags:   [in]    flags
> + *
> + * Creates a new file by hooking it on an unspecified inode. This is
> + * useful for files that do not need to have a full-fledged filesystem
> + * to operate correctly.  All the files created with
> + * anon_inode_getfile_secure() will have distinct inodes, avoiding
> + * code duplication for the file/inode/dentry setup.  Returns a newly
> + * created file descriptor or an error code.
> + */
> +int anon_inode_getfd_secure(const char *name, const struct file_operations *fops,
> +			    void *priv, int flags,
> +			    const struct inode *context_inode)
> +{
> +	return _anon_inode_getfd(name, fops, priv, flags,
> +				 context_inode, true);
> +}
> +EXPORT_SYMBOL_GPL(anon_inode_getfd_secure);
> +
> +/**
> + * anon_inode_getfd - creates a new file instance by hooking it up to
> + *                    an anonymous inode and a dentry that describe
> + *                    the "class" of the file
> + *
> + * @name:    [in]    name of the "class" of the new file
> + * @fops:    [in]    file operations for the new file
> + * @priv:    [in]    private data for the new file (will be file's private_data)
> + * @flags:   [in]    flags
> + *
> + * Creates a new file by hooking it on a single inode. This is
> + * useful for files that do not need to have a full-fledged inode in
> + * order to operate correctly.  All the files created with
> + * anon_inode_getfile() will use the same singleton inode, reducing
> + * memory use and avoiding code duplication for the file/inode/dentry
> + * setup.  Returns a newly created file descriptor or an error code.
> + */
> +int anon_inode_getfd(const char *name, const struct file_operations *fops,
> +		     void *priv, int flags)
> +{
> +	return _anon_inode_getfd(name, fops, priv, flags, NULL, false);
> +}
>  EXPORT_SYMBOL_GPL(anon_inode_getfd);
>  
>  static int __init anon_inode_init(void)
> @@ -162,4 +272,3 @@ static int __init anon_inode_init(void)
>  }
>  
>  fs_initcall(anon_inode_init);
> -
> diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
> index d0d7d96261ad..67bd85d92dca 100644
> --- a/include/linux/anon_inodes.h
> +++ b/include/linux/anon_inodes.h
> @@ -10,12 +10,25 @@
>  #define _LINUX_ANON_INODES_H
>  
>  struct file_operations;
> +struct inode;
> +
> +struct file *anon_inode_getfile_secure(const char *name,
> +				       const struct file_operations *fops,
> +				       void *priv, int flags,
> +				       const struct inode *context_inode);
>  
>  struct file *anon_inode_getfile(const char *name,
>  				const struct file_operations *fops,
>  				void *priv, int flags);
> +
> +int anon_inode_getfd_secure(const char *name,
> +			    const struct file_operations *fops,
> +			    void *priv, int flags,
> +			    const struct inode *context_inode);
> +
>  int anon_inode_getfd(const char *name, const struct file_operations *fops,
>  		     void *priv, int flags);
>  
> +
>  #endif /* _LINUX_ANON_INODES_H */
>  
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 20d8cf194fb7..5434c1d285b2 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -215,6 +215,13 @@
>   *	Returns 0 if @name and @value have been successfully set,
>   *	-EOPNOTSUPP if no security attribute is needed, or
>   *	-ENOMEM on memory allocation failure.
> + * @inode_init_security_anon:
> + *      Set up a secure anonymous inode.
> + *      @inode contains the inode structure
> + *      @name name of the anonymous inode class
> + *      @context_inode optional related inode
> + *	Returns 0 on success. Returns -EPERM if	the security module denies
> + *	the creation of this inode.
>   * @inode_create:
>   *	Check permission to create a regular file.
>   *	@dir contains inode structure of the parent of the new file.
> @@ -1552,6 +1559,9 @@ union security_list_options {
>  					const struct qstr *qstr,
>  					const char **name, void **value,
>  					size_t *len);
> +	int (*inode_init_security_anon)(struct inode *inode,
> +					const struct qstr *name,
> +					const struct inode *context_inode);
>  	int (*inode_create)(struct inode *dir, struct dentry *dentry,
>  				umode_t mode);
>  	int (*inode_link)(struct dentry *old_dentry, struct inode *dir,
> @@ -1884,6 +1894,7 @@ struct security_hook_heads {
>  	struct hlist_head inode_alloc_security;
>  	struct hlist_head inode_free_security;
>  	struct hlist_head inode_init_security;
> +	struct hlist_head inode_init_security_anon;
>  	struct hlist_head inode_create;
>  	struct hlist_head inode_link;
>  	struct hlist_head inode_unlink;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 64b19f050343..2108c3ce0666 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -320,6 +320,9 @@ void security_inode_free(struct inode *inode);
>  int security_inode_init_security(struct inode *inode, struct inode *dir,
>  				 const struct qstr *qstr,
>  				 initxattrs initxattrs, void *fs_data);
> +int security_inode_init_security_anon(struct inode *inode,
> +				      const struct qstr *name,
> +				      const struct inode *context_inode);
>  int security_old_inode_init_security(struct inode *inode, struct inode *dir,
>  				     const struct qstr *qstr, const char **name,
>  				     void **value, size_t *len);
> diff --git a/security/security.c b/security/security.c
> index 565bc9b67276..70bfebada024 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1033,6 +1033,15 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  }
>  EXPORT_SYMBOL(security_inode_init_security);
>  
> +int
> +security_inode_init_security_anon(struct inode *inode,
> +				  const struct qstr *name,
> +				  const struct inode *context_inode)
> +{
> +	return call_int_hook(inode_init_security_anon, 0, inode, name,
> +			     context_inode);
> +}
> +
>  int security_old_inode_init_security(struct inode *inode, struct inode *dir,
>  				     const struct qstr *qstr, const char **name,
>  				     void **value, size_t *len)
> 

-- 
James Morris
<jmorris@namei.org>

