Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE741EC1BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 20:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgFBSXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 14:23:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59903 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgFBSXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591122214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lOvpp8HavyMvDKXBw4DtcY4YYwTEawy7nOUgn2Fj8ro=;
        b=MOYDJfHLuinnPbFPUzvqxIB+6Z6CTDUx1aGp/FPlryqU5ooLxKnSShyRYu80HOKT4KoUUl
        grUVm/+NomapF6aqxp8/xUI5woRxKmKKVnpJF+x/FDkfAv5kg7zKsIjOL1rnUKIy40XyJD
        NZb+0XBXeOxPqlhkpWBpZDb4GxTV0Gc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-njNCVsfyOYGAQZNfw0UZtg-1; Tue, 02 Jun 2020 14:23:29 -0400
X-MC-Unique: njNCVsfyOYGAQZNfw0UZtg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC710107B7C3;
        Tue,  2 Jun 2020 18:23:27 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-130.rdu2.redhat.com [10.10.116.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F5F15D9D3;
        Tue,  2 Jun 2020 18:23:22 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 89DDB22063B; Tue,  2 Jun 2020 14:23:21 -0400 (EDT)
Date:   Tue, 2 Jun 2020 14:23:21 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] RFC: fuse: virtiofs: Call security hooks on new inodes
Message-ID: <20200602182321.GA21237@redhat.com>
References: <20200601053214.201723-1-chirantan@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601053214.201723-1-chirantan@chromium.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 01, 2020 at 02:32:14PM +0900, Chirantan Ekbote wrote:
> Add a new `init_security` field to `fuse_conn` that controls whether we
> initialize security when a new inode is created.  Set this to true for
> virtiofs but false for regular fuse file systems.
> 
> Calling security hooks is needed for `setfscreatecon` to work since it
> is applied as part of the selinux security hook.
> 
> Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> ---
>  fs/fuse/dir.c       | 74 ++++++++++++++++++++++++++++++++++++++++++---
>  fs/fuse/fuse_i.h    |  4 +++
>  fs/fuse/inode.c     |  1 +
>  fs/fuse/virtio_fs.c |  1 +
>  4 files changed, 75 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index de1e2fde60bd4..b18c92a8a4c11 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -16,6 +16,9 @@
>  #include <linux/xattr.h>
>  #include <linux/iversion.h>
>  #include <linux/posix_acl.h>
> +#include <linux/security.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
>  
>  static void fuse_advise_use_readdirplus(struct inode *dir)
>  {
> @@ -135,6 +138,50 @@ static void fuse_dir_changed(struct inode *dir)
>  	inode_maybe_inc_iversion(dir, false);
>  }
>  
> +static int fuse_initxattrs(struct inode *inode, const struct xattr *xattrs,
> +			   void *fs_info)
> +{
> +	const struct xattr *xattr;
> +	int err = 0;
> +	int len;
> +	char *name;
> +
> +	for (xattr = xattrs; xattr->name != NULL; ++xattr) {
> +		len = XATTR_SECURITY_PREFIX_LEN + strlen(xattr->name) + 1;
> +		name = kmalloc(len, GFP_KERNEL);
> +		if (!name) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +
> +		scnprintf(name, len, XATTR_SECURITY_PREFIX "%s", xattr->name);
> +		err = fuse_setxattr(inode, name, xattr->value, xattr->value_len,
> +				    0);
> +		kfree(name);
> +		if (err < 0)
> +			break;
> +	}
> +
> +	return err;
> +}
> +
> +/*
> + * Initialize security on newly created inodes if supported by the filesystem.
> + */
> +static int fuse_init_security(struct inode *inode, struct inode *dir,
> +			      const struct qstr *qstr)
> +{
> +	struct fuse_conn *conn = get_fuse_conn(dir);
> +	int err = 0;
> +
> +	if (conn->init_security) {
> +		err = security_inode_init_security(inode, dir, qstr,
> +						   fuse_initxattrs, NULL);
> +	}
> +
> +	return err;
> +}
> +
>  /**
>   * Mark the attributes as stale due to an atime change.  Avoid the invalidate if
>   * atime is not used.
> @@ -498,7 +545,17 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  		err = -ENOMEM;
>  		goto out_err;
>  	}
> +
> +	err = fuse_init_security(inode, dir, &entry->d_name);
> +	if (err) {
> +		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
> +		fi = get_fuse_inode(inode);
> +		fuse_sync_release(fi, ff, flags);
> +		fuse_queue_forget(fc, forget, outentry.nodeid, 1);
> +		goto out_err;
> +	}
>  	kfree(forget);
> +

[ cc lsm and selinux list ]

So this sets xattr after file creation. But this is not atomic w.r.t
file creation. I think keeping file creation and selinux context setting 
to be atomic was one of the requirements.

Can we first retrieve the label which will be created for inode
(using dentry perhaps) and then pass that label as part of CREATE/MKNOD
request and then server can set fscreate (per thread) before file
creation. I hope /proc/[pid]/attr/fscreate work for per thread too.

Stephen had mentioned dentry_init_security() for this. Overlayfs uses
a variant of the same hook dentry_create_files_as().

>  	d_instantiate(entry, inode);
>  	fuse_change_entry_timeout(entry, &outentry);
>  	fuse_dir_changed(dir);
> @@ -569,7 +626,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>   */
>  static int create_new_entry(struct fuse_conn *fc, struct fuse_args *args,
>  			    struct inode *dir, struct dentry *entry,
> -			    umode_t mode)
> +			    umode_t mode, bool init_security)
>  {
>  	struct fuse_entry_out outarg;
>  	struct inode *inode;
> @@ -603,6 +660,13 @@ static int create_new_entry(struct fuse_conn *fc, struct fuse_args *args,
>  		fuse_queue_forget(fc, forget, outarg.nodeid, 1);
>  		return -ENOMEM;
>  	}
> +	if (init_security) {
> +		err = fuse_init_security(inode, dir, &entry->d_name);
> +		if (err) {
> +			fuse_queue_forget(fc, forget, outarg.nodeid, 1);
> +			return err;
> +		}
> +	}
>  	kfree(forget);
>  
>  	d_drop(entry);
> @@ -644,7 +708,7 @@ static int fuse_mknod(struct inode *dir, struct dentry *entry, umode_t mode,
>  	args.in_args[0].value = &inarg;
>  	args.in_args[1].size = entry->d_name.len + 1;
>  	args.in_args[1].value = entry->d_name.name;
> -	return create_new_entry(fc, &args, dir, entry, mode);
> +	return create_new_entry(fc, &args, dir, entry, mode, true);
>  }
>  
>  static int fuse_create(struct inode *dir, struct dentry *entry, umode_t mode,
> @@ -671,7 +735,7 @@ static int fuse_mkdir(struct inode *dir, struct dentry *entry, umode_t mode)
>  	args.in_args[0].value = &inarg;
>  	args.in_args[1].size = entry->d_name.len + 1;
>  	args.in_args[1].value = entry->d_name.name;
> -	return create_new_entry(fc, &args, dir, entry, S_IFDIR);
> +	return create_new_entry(fc, &args, dir, entry, S_IFDIR, true);
>  }
>  
>  static int fuse_symlink(struct inode *dir, struct dentry *entry,
> @@ -687,7 +751,7 @@ static int fuse_symlink(struct inode *dir, struct dentry *entry,
>  	args.in_args[0].value = entry->d_name.name;
>  	args.in_args[1].size = len;
>  	args.in_args[1].value = link;
> -	return create_new_entry(fc, &args, dir, entry, S_IFLNK);
> +	return create_new_entry(fc, &args, dir, entry, S_IFLNK, true);
>  }
>  
>  void fuse_update_ctime(struct inode *inode)
> @@ -858,7 +922,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
>  	args.in_args[0].value = &inarg;
>  	args.in_args[1].size = newent->d_name.len + 1;
>  	args.in_args[1].value = newent->d_name.name;
> -	err = create_new_entry(fc, &args, newdir, newent, inode->i_mode);
> +	err = create_new_entry(fc, &args, newdir, newent, inode->i_mode, false);
>  	/* Contrary to "normal" filesystems it can happen that link
>  	   makes two "logical" inodes point to the same "physical"
>  	   inode.  We invalidate the attributes of the old one, so it
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index ca344bf714045..ed871742db584 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -482,6 +482,7 @@ struct fuse_fs_context {
>  	bool no_control:1;
>  	bool no_force_umount:1;
>  	bool no_mount_options:1;
> +	bool init_security:1;
>  	unsigned int max_read;
>  	unsigned int blksize;
>  	const char *subtype;
> @@ -719,6 +720,9 @@ struct fuse_conn {
>  	/* Do not show mount options */
>  	unsigned int no_mount_options:1;
>  
> +	/* Initialize security xattrs when creating a new inode */
> +	unsigned int init_security : 1;
> +
>  	/** The number of requests waiting for completion */
>  	atomic_t num_waiting;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 95d712d44ca13..ab47e73566864 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1179,6 +1179,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	fc->no_control = ctx->no_control;
>  	fc->no_force_umount = ctx->no_force_umount;
>  	fc->no_mount_options = ctx->no_mount_options;
> +	fc->init_security = ctx->init_security;
>  
>  	err = -ENOMEM;
>  	root = fuse_get_root_inode(sb, ctx->rootmode);
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index bade747689033..ee22e9a8309df 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1051,6 +1051,7 @@ static int virtio_fs_fill_super(struct super_block *sb)
>  		.no_control = true,
>  		.no_force_umount = true,
>  		.no_mount_options = true,
> +		.init_security = true,
>  	};

Should this is enabled from server instead (and not client). IIUC, one
of the deadlock examples stephen smalley gave was that client was waiting
for mount to finish and another getxattr() call went out. This will
succeed only if server is multi threaded and can handle both requests
in parallel. If that's the case should it be server which tells client
whether it can handle multiple parallel requests or not. If it can,
then client enables it.

Thanks
Vivek

