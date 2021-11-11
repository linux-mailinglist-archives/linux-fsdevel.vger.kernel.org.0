Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055F644D853
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhKKOfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:35:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233711AbhKKOfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636641160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aw7H8zO61pxcusBQKbpzVlsUX4j1BJy8dcGa6C8abRE=;
        b=E0S7lHAacmUFFRsASsxQI1ybewP6Dd491AUVwgqkyJpoGwmkoolshRshTmMJr6g8x0FWVP
        azrPFoD67gtYSWgYXr2WMLCUi20TTQJ9UxOA4pizB6U9DskXLf24gjZJYPzyU53fbUGk33
        SE0Psi0M4XdI64o2e7d2J8XLck8bJTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-1d76gEt7OSKqIJNT5KNTuQ-1; Thu, 11 Nov 2021 09:32:37 -0500
X-MC-Unique: 1d76gEt7OSKqIJNT5KNTuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E7B51006AA1;
        Thu, 11 Nov 2021 14:32:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84B761002D71;
        Thu, 11 Nov 2021 14:32:22 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 218F7220EED; Thu, 11 Nov 2021 09:32:22 -0500 (EST)
Date:   Thu, 11 Nov 2021 09:32:22 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, virtio-fs@redhat.com,
        chirantan@chromium.org, stephen.smalley.work@gmail.com,
        dwalsh@redhat.com, casey@schaufler-ca.com, omosnace@redhat.com
Subject: Re: [PATCH v3 1/1] fuse: Send security context of inode on file
 creation
Message-ID: <YY0pdhKBCalzPvs6@redhat.com>
References: <20211110225528.48601-1-vgoyal@redhat.com>
 <20211110225528.48601-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110225528.48601-2-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I noticed that this patch is conflicting with some fuse patches
merged in Linus's tree. I will post updated version. 

Vivek

On Wed, Nov 10, 2021 at 05:55:28PM -0500, Vivek Goyal wrote:
> When a new inode is created, send its security context to server along
> with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_SYMLINK).
> This gives server an opportunity to create new file and set security
> context (possibly atomically). In all the configurations it might not
> be possible to set context atomically.
> 
> Like nfs and ceph, use security_dentry_init_security() to dermine security
> context of inode and send it with create, mkdir, mknod, and symlink requests.
> 
> Following is the information sent to server.
> 
> fuse_sectx_header, fuse_secctx, xattr_name, security_context
> 
> - struct fuse_secctx_header
>   This contains total number of security contexts being sent and total
>   size of all the security contexts (including size of fuse_secctx_header).
> 
> - struct fuse_secctx.
>   This contains size of security context which follows this structure.
>   There is one fuse_secctx instance per security context.
> 
> - xattr name string.
>   This string represents name of xattr which should be used while setting
>   security context.
> 
> - security context.
>   This is the actual security context whose size is specified in fuse_secctx
>   struct.
> 
> Also add the FUSE_SECURITY_CTX flag for the `flags` field of the
> fuse_init_out struct.  When this flag is set the kernel will append the
> security context for a newly created inode to the request (create,
> mkdir, mknod, and symlink).  The server is responsible for ensuring that
> the inode appears atomically (preferrably) with the requested security
> context.
> 
> For example, If the server is using SELinux and backed by a "real" linux
> file system that supports extended attributes it can write the security
> context value to /proc/thread-self/attr/fscreate before making the syscall
> to create the inode.
> 
> This patch is based on patch from Chirantan Ekbote <chirantan@chromium.org>.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/dir.c             | 103 ++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h          |   3 ++
>  fs/fuse/inode.c           |   4 +-
>  include/uapi/linux/fuse.h |  31 +++++++++++-
>  4 files changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index d9b977c0f38d..69398eb7b325 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -17,6 +17,9 @@
>  #include <linux/xattr.h>
>  #include <linux/iversion.h>
>  #include <linux/posix_acl.h>
> +#include <linux/security.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
>  
>  static void fuse_advise_use_readdirplus(struct inode *dir)
>  {
> @@ -456,6 +459,69 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
>  	return ERR_PTR(err);
>  }
>  
> +static int get_security_context(struct dentry *entry, umode_t mode,
> +				void **security_ctx, u32 *security_ctxlen)
> +{
> +	struct fuse_secctx *fsecctx;
> +	struct fuse_secctx_header *fsecctx_header;
> +	void *ctx, *full_ctx;
> +	u32 ctxlen, full_ctxlen;
> +	int err = 0;
> +	const char *name;
> +
> +	err = security_dentry_init_security(entry, mode, &entry->d_name,
> +					    &name, &ctx, &ctxlen);
> +	if (err) {
> +		if (err != -EOPNOTSUPP)
> +			goto out_err;
> +		/* No LSM is supporting this security hook. Ignore error */
> +		err = 0;
> +		ctxlen = 0;
> +	}
> +
> +	if (ctxlen > 0) {
> +		void *ptr;
> +
> +		full_ctxlen = sizeof(*fsecctx_header) + sizeof(*fsecctx) +
> +			      strlen(name) + ctxlen + 1;
> +		full_ctx = kzalloc(full_ctxlen, GFP_KERNEL);
> +		if (!full_ctx) {
> +			err = -ENOMEM;
> +			kfree(ctx);
> +			goto out_err;
> +		}
> +
> +		ptr = full_ctx;
> +		fsecctx_header = (struct fuse_secctx_header*) ptr;
> +		fsecctx_header->nr_secctx = 1;
> +		fsecctx_header->size = full_ctxlen;
> +		ptr += sizeof(*fsecctx_header);
> +
> +		fsecctx = (struct fuse_secctx*) ptr;
> +		fsecctx->size = ctxlen;
> +		ptr += sizeof(*fsecctx);
> +
> +		strcpy(ptr, name);
> +		ptr += strlen(name) + 1;
> +		memcpy(ptr, ctx, ctxlen);
> +		kfree(ctx);
> +	} else {
> +		full_ctxlen = sizeof(*fsecctx_header);
> +		full_ctx = kzalloc(full_ctxlen, GFP_KERNEL);
> +		if (!full_ctx) {
> +			err = -ENOMEM;
> +			goto out_err;
> +		}
> +		fsecctx_header = full_ctx;
> +		fsecctx_header->size = full_ctxlen;
> +	}
> +
> +	*security_ctxlen = full_ctxlen;
> +	*security_ctx = full_ctx;
> +out_err:
> +	return err;
> +}
> +
>  /*
>   * Atomic create+open operation
>   *
> @@ -476,6 +542,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  	struct fuse_entry_out outentry;
>  	struct fuse_inode *fi;
>  	struct fuse_file *ff;
> +	void *security_ctx = NULL;
> +	u32 security_ctxlen;
>  
>  	/* Userspace expects S_IFREG in create mode */
>  	BUG_ON((mode & S_IFMT) != S_IFREG);
> @@ -517,6 +585,18 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  	args.out_args[0].value = &outentry;
>  	args.out_args[1].size = sizeof(outopen);
>  	args.out_args[1].value = &outopen;
> +
> +	if (fm->fc->init_security) {
> +		err = get_security_context(entry, mode, &security_ctx,
> +					   &security_ctxlen);
> +		if (err)
> +			goto out_put_forget_req;
> +
> +		args.in_numargs = 3;
> +		args.in_args[2].size = security_ctxlen;
> +		args.in_args[2].value = security_ctx;
> +	}
> +
>  	err = fuse_simple_request(fm, &args);
>  	if (err)
>  		goto out_free_ff;
> @@ -554,6 +634,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  
>  out_free_ff:
>  	fuse_file_free(ff);
> +	kfree(security_ctx);
>  out_put_forget_req:
>  	kfree(forget);
>  out_err:
> @@ -620,6 +701,8 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
>  	struct dentry *d;
>  	int err;
>  	struct fuse_forget_link *forget;
> +	void *security_ctx = NULL;
> +	u32 security_ctxlen = 0;
>  
>  	if (fuse_is_bad(dir))
>  		return -EIO;
> @@ -633,7 +716,27 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
>  	args->out_numargs = 1;
>  	args->out_args[0].size = sizeof(outarg);
>  	args->out_args[0].value = &outarg;
> +
> +	if (fm->fc->init_security && args->opcode != FUSE_LINK) {
> +		unsigned short idx = args->in_numargs;
> +
> +		if ((size_t)idx >= ARRAY_SIZE(args->in_args)) {
> +			err = -ENOMEM;
> +			goto out_put_forget_req;
> +		}
> +
> +		err = get_security_context(entry, mode, &security_ctx,
> +					   &security_ctxlen);
> +		if (err)
> +			goto out_put_forget_req;
> +
> +		args->in_args[idx].size = security_ctxlen;
> +		args->in_args[idx].value = security_ctx;
> +		args->in_numargs++;
> +	}
> +
>  	err = fuse_simple_request(fm, args);
> +	kfree(security_ctx);
>  	if (err)
>  		goto out_put_forget_req;
>  
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f55f9f94b1a4..0d257c4eeb70 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -765,6 +765,9 @@ struct fuse_conn {
>  	/* Propagate syncfs() to server */
>  	unsigned int sync_fs:1;
>  
> +	/* Initialize security xattrs when creating a new inode */
> +	unsigned int init_security:1;
> +
>  	/** The number of requests waiting for completion */
>  	atomic_t num_waiting;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 12d49a1914e8..40c5533243c0 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1143,6 +1143,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  			}
>  			if (arg->flags & FUSE_SETXATTR_EXT)
>  				fc->setxattr_ext = 1;
> +			if (arg->flags & FUSE_SECURITY_CTX)
> +				fc->init_security = 1;
>  		} else {
>  			ra_pages = fc->max_read / PAGE_SIZE;
>  			fc->no_lock = 1;
> @@ -1186,7 +1188,7 @@ void fuse_send_init(struct fuse_mount *fm)
>  		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
>  		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
>  		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
> -		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT;
> +		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_SECURITY_CTX;
>  #ifdef CONFIG_FUSE_DAX
>  	if (fm->fc->dax)
>  		ia->in.flags |= FUSE_MAP_ALIGNMENT;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 36ed092227fa..710cdf20608d 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -184,6 +184,10 @@
>   *
>   *  7.34
>   *  - add FUSE_SYNCFS
> + *
> + *  7.35
> + *  - add FUSE_SECURITY_CTX flag for fuse_init_out
> + *  - add security context to create, mkdir, symlink, and mknod requests
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -219,7 +223,7 @@
>  #define FUSE_KERNEL_VERSION 7
>  
>  /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 34
> +#define FUSE_KERNEL_MINOR_VERSION 35
>  
>  /** The node ID of the root inode */
>  #define FUSE_ROOT_ID 1
> @@ -336,6 +340,8 @@ struct fuse_file_lock {
>   *			write/truncate sgid is killed only if file has group
>   *			execute permission. (Same as Linux VFS behavior).
>   * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
> + * FUSE_SECURITY_CTX:	add security context to create, mkdir, symlink, and
> + * 			mknod
>   */
>  #define FUSE_ASYNC_READ		(1 << 0)
>  #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -367,6 +373,7 @@ struct fuse_file_lock {
>  #define FUSE_SUBMOUNTS		(1 << 27)
>  #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
>  #define FUSE_SETXATTR_EXT	(1 << 29)
> +#define FUSE_SECURITY_CTX	(1 << 30)
>  
>  /**
>   * CUSE INIT request/reply flags
> @@ -979,4 +986,26 @@ struct fuse_syncfs_in {
>  	uint64_t	padding;
>  };
>  
> +/*
> + * For each security context, send fuse_secctx with size of security context
> + * fuse_secctx will be followed by security context name and this in turn
> + * will be followed by actual context label.
> + * fuse_secctx, name, context
> + * */
> +struct fuse_secctx {
> +	uint32_t	size;
> +	uint32_t	padding;
> +};
> +
> +/*
> + * Contains the information about how many fuse_secctx structures are being
> + * sent and what's the total size of all security contexts (including
> + * size of fuse_secctx_header).
> + *
> + */
> +struct fuse_secctx_header {
> +	uint32_t	size;
> +	uint32_t	nr_secctx;
> +};
> +
>  #endif /* _LINUX_FUSE_H */
> -- 
> 2.31.1
> 

