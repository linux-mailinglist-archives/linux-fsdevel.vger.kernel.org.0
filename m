Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0B23C15E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 23:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgHDVWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 17:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgHDVWR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:22:17 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B44DA20842;
        Tue,  4 Aug 2020 21:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596576136;
        bh=bXcYVMsqD12uE+wXFthj7t7M5Ojuh+fTCQwOUDFBvhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPiethCbtW54zrmu3zGud3anlS7devW5CjHR4qSEItdX6X2UJ3ZHPPIOE3b4xH3Rr
         PUA6OoR6PraR1KgKO8Ampk/wE2u22QefvQwxHKRCIaDXeVIqI65l5e8OuwHaPe+EL1
         ic2jByeLghPClWbbvvIA1NE33L9i8PvduKTEqDME=
Date:   Tue, 4 Aug 2020 14:22:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com,
        jmorris@namei.org
Subject: Re: [PATCH v5 1/3] Add a new LSM-supporting anonymous inode interface
Message-ID: <20200804212214.GD1992048@gmail.com>
References: <20200326200634.222009-1-dancol@google.com>
 <20200401213903.182112-1-dancol@google.com>
 <20200401213903.182112-2-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401213903.182112-2-dancol@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 01, 2020 at 02:39:01PM -0700, Daniel Colascione wrote:
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

Unnecessarily global function.

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

Use ERR_CAST(), not ERR_PTR(PTR_ERR()).

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

Why copy-and-paste this long comment if it's not even updated to document the
new argument?

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

Shouldn't it be EACCES?
