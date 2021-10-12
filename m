Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730A842AC0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 20:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhJLSga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 14:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233761AbhJLSg3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634063667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6vMOpVKQBRiV+XjZ1w2rMDnOJtPk0OuM+O74MoelOik=;
        b=EzGkOXBmNXGXeXP6mHNmrBVDdaOwpxBmOg/2hBPVDYRfrwkFEmYU/HCBQmKzJXj7gWF2oG
        Z0Z67rFSwQIwH7Ovc9nwF4qdsDBrtMqrU2aL1Q9Xik5X/A0XilXmwqj4hEOGMRX8m6s29G
        FVhUlaekI/Ow7S16GNck4Bn7bgVlQ6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-MHmHCg74M5uvrlKrpwzSMg-1; Tue, 12 Oct 2021 14:34:24 -0400
X-MC-Unique: MHmHCg74M5uvrlKrpwzSMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 938671926DA0;
        Tue, 12 Oct 2021 18:34:22 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA6114180;
        Tue, 12 Oct 2021 18:34:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 62A9022023A; Tue, 12 Oct 2021 14:34:15 -0400 (EDT)
Date:   Tue, 12 Oct 2021 14:34:15 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, miklos@szeredi.hu,
        virtio-fs@redhat.com, chirantan@chromium.org,
        stephen.smalley.work@gmail.com, dwalsh@redhat.com,
        omosnace@redhat.com
Subject: Re: [PATCH v2 2/2] fuse: Send security context of inode on file
 creation
Message-ID: <YWXVJ1bss4Vwa3la@redhat.com>
References: <20211012180624.447474-1-vgoyal@redhat.com>
 <20211012180624.447474-3-vgoyal@redhat.com>
 <3ee8ffdb-ab64-4b7d-1030-c370a1c0e3a8@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ee8ffdb-ab64-4b7d-1030-c370a1c0e3a8@schaufler-ca.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 11:24:23AM -0700, Casey Schaufler wrote:
> On 10/12/2021 11:06 AM, Vivek Goyal wrote:
> > When a new inode is created, send its security context to server along
> > with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_SYMLINK).
> > This gives server an opportunity to create new file and set security
> > context (possibly atomically). In all the configurations it might not
> > be possible to set context atomically.
> >
> > Like nfs and ceph, use security_dentry_init_security() to dermine security
> > context of inode and send it with create, mkdir, mknod, and symlink requests.
> >
> > Following is the information sent to server.
> >
> > - struct fuse_secctxs.
> >   This contains total number of security contexts being sent.
> >
> > - struct fuse_secctx.
> >   This contains total size of security context which follows this structure.
> >   There is one fuse_secctx instance per security context.
> >
> > - xattr name string.
> >   This string represents name of xattr which should be used while setting
> >   security context. As of now it is hardcoded to "security.selinux".
> 
> Where is the name hardcoded? I looks as if you're getting the attribute
> name along with the value from security_dentry_init_security().

Sorry, I copied pasted this description from V1 where I was hardcoding
the name to "security.selinux". But V2 got rid of that hardcoding and
that's why this patch series is dependent on the other patch which
modifies security_dentry_init_security() signature.

https://lore.kernel.org/linux-fsdevel/YWWMO%2FZDrvDZ5X4c@redhat.com/

Thanks
Vivek

> 
> >
> > - security context.
> >   This is the actual security context whose size is specified in fuse_secctx
> >   struct.
> >
> > This patch is modified version of patch from
> > Chirantan Ekbote <chirantan@chromium.org>
> >
> > v2:
> > - Added "fuse_secctxs" structure where one can specify how many security
> >   contexts are being sent. This can be useful down the line if we
> >   have more than one security contexts being set.
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/fuse/dir.c             | 115 ++++++++++++++++++++++++++++++++++++--
> >  fs/fuse/fuse_i.h          |   3 +
> >  fs/fuse/inode.c           |   4 +-
> >  include/uapi/linux/fuse.h |  20 +++++++
> >  4 files changed, 136 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index d9b977c0f38d..ce62593a61f9 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -17,6 +17,9 @@
> >  #include <linux/xattr.h>
> >  #include <linux/iversion.h>
> >  #include <linux/posix_acl.h>
> > +#include <linux/security.h>
> > +#include <linux/types.h>
> > +#include <linux/kernel.h>
> >  
> >  static void fuse_advise_use_readdirplus(struct inode *dir)
> >  {
> > @@ -456,6 +459,66 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
> >  	return ERR_PTR(err);
> >  }
> >  
> > +static int get_security_context(struct dentry *entry, umode_t mode,
> > +				void **security_ctx, u32 *security_ctxlen)
> > +{
> > +	struct fuse_secctx *fsecctx;
> > +	struct fuse_secctxs *fsecctxs;
> > +	void *ctx, *full_ctx;
> > +	u32 ctxlen, full_ctxlen;
> > +	int err = 0;
> > +	const char *name;
> > +
> > +	err = security_dentry_init_security(entry, mode, &entry->d_name,
> > +					    &name, &ctx, &ctxlen);
> > +	if (err) {
> > +		if (err != -EOPNOTSUPP)
> > +			goto out_err;
> > +		/* No LSM is supporting this security hook. Ignore error */
> > +		err = 0;
> > +		ctxlen = 0;
> > +	}
> > +
> > +	if (ctxlen > 0) {
> > +		void *ptr;
> > +
> > +		full_ctxlen = sizeof(*fsecctxs) + sizeof(*fsecctx) +
> > +			      strlen(name) + ctxlen + 1;
> > +		full_ctx = kzalloc(full_ctxlen, GFP_KERNEL);
> > +		if (!full_ctx) {
> > +			err = -ENOMEM;
> > +			kfree(ctx);
> > +			goto out_err;
> > +		}
> > +
> > +		ptr = full_ctx;
> > +		fsecctxs = (struct fuse_secctxs*) ptr;
> > +		fsecctxs->nr_secctx = 1;
> > +		ptr += sizeof(*fsecctxs);
> > +
> > +		fsecctx = (struct fuse_secctx*) ptr;
> > +		fsecctx->size = ctxlen;
> > +		ptr += sizeof(*fsecctx);
> > +
> > +		strcpy(ptr, name);
> > +		ptr += strlen(name) + 1;
> > +		memcpy(ptr, ctx, ctxlen);
> > +		kfree(ctx);
> > +	} else {
> > +		full_ctxlen = sizeof(*fsecctxs);
> > +		full_ctx = kzalloc(full_ctxlen, GFP_KERNEL);
> > +		if (!full_ctx) {
> > +			err = -ENOMEM;
> > +			goto out_err;
> > +		}
> > +	}
> > +
> > +	*security_ctxlen = full_ctxlen;
> > +	*security_ctx = full_ctx;
> > +out_err:
> > +	return err;
> > +}
> > +
> >  /*
> >   * Atomic create+open operation
> >   *
> > @@ -476,6 +539,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >  	struct fuse_entry_out outentry;
> >  	struct fuse_inode *fi;
> >  	struct fuse_file *ff;
> > +	void *security_ctx = NULL;
> > +	u32 security_ctxlen;
> >  
> >  	/* Userspace expects S_IFREG in create mode */
> >  	BUG_ON((mode & S_IFMT) != S_IFREG);
> > @@ -517,6 +582,18 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >  	args.out_args[0].value = &outentry;
> >  	args.out_args[1].size = sizeof(outopen);
> >  	args.out_args[1].value = &outopen;
> > +
> > +	if (fm->fc->init_security) {
> > +		err = get_security_context(entry, mode, &security_ctx,
> > +					   &security_ctxlen);
> > +		if (err)
> > +			goto out_put_forget_req;
> > +
> > +		args.in_numargs = 3;
> > +		args.in_args[2].size = security_ctxlen;
> > +		args.in_args[2].value = security_ctx;
> > +	}
> > +
> >  	err = fuse_simple_request(fm, &args);
> >  	if (err)
> >  		goto out_free_ff;
> > @@ -554,6 +631,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >  
> >  out_free_ff:
> >  	fuse_file_free(ff);
> > +	kfree(security_ctx);
> >  out_put_forget_req:
> >  	kfree(forget);
> >  out_err:
> > @@ -613,13 +691,15 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> >   */
> >  static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
> >  			    struct inode *dir, struct dentry *entry,
> > -			    umode_t mode)
> > +			    umode_t mode, bool init_security)
> >  {
> >  	struct fuse_entry_out outarg;
> >  	struct inode *inode;
> >  	struct dentry *d;
> >  	int err;
> >  	struct fuse_forget_link *forget;
> > +	void *security_ctx = NULL;
> > +	u32 security_ctxlen = 0;
> >  
> >  	if (fuse_is_bad(dir))
> >  		return -EIO;
> > @@ -633,7 +713,29 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
> >  	args->out_numargs = 1;
> >  	args->out_args[0].size = sizeof(outarg);
> >  	args->out_args[0].value = &outarg;
> > +
> > +	if (init_security) {
> > +		unsigned short idx = args->in_numargs;
> > +
> > +		if ((size_t)idx >= ARRAY_SIZE(args->in_args)) {
> > +			err = -ENOMEM;
> > +			goto out_put_forget_req;
> > +		}
> > +
> > +		err = get_security_context(entry, mode, &security_ctx,
> > +					   &security_ctxlen);
> > +		if (err)
> > +			goto out_put_forget_req;
> > +
> > +		if (security_ctxlen > 0) {
> > +			args->in_args[idx].size = security_ctxlen;
> > +			args->in_args[idx].value = security_ctx;
> > +			args->in_numargs++;
> > +		}
> > +	}
> > +
> >  	err = fuse_simple_request(fm, args);
> > +	kfree(security_ctx);
> >  	if (err)
> >  		goto out_put_forget_req;
> >  
> > @@ -691,7 +793,7 @@ static int fuse_mknod(struct user_namespace *mnt_userns, struct inode *dir,
> >  	args.in_args[0].value = &inarg;
> >  	args.in_args[1].size = entry->d_name.len + 1;
> >  	args.in_args[1].value = entry->d_name.name;
> > -	return create_new_entry(fm, &args, dir, entry, mode);
> > +	return create_new_entry(fm, &args, dir, entry, mode, fm->fc->init_security);
> >  }
> >  
> >  static int fuse_create(struct user_namespace *mnt_userns, struct inode *dir,
> > @@ -719,7 +821,8 @@ static int fuse_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
> >  	args.in_args[0].value = &inarg;
> >  	args.in_args[1].size = entry->d_name.len + 1;
> >  	args.in_args[1].value = entry->d_name.name;
> > -	return create_new_entry(fm, &args, dir, entry, S_IFDIR);
> > +	return create_new_entry(fm, &args, dir, entry, S_IFDIR,
> > +				fm->fc->init_security);
> >  }
> >  
> >  static int fuse_symlink(struct user_namespace *mnt_userns, struct inode *dir,
> > @@ -735,7 +838,8 @@ static int fuse_symlink(struct user_namespace *mnt_userns, struct inode *dir,
> >  	args.in_args[0].value = entry->d_name.name;
> >  	args.in_args[1].size = len;
> >  	args.in_args[1].value = link;
> > -	return create_new_entry(fm, &args, dir, entry, S_IFLNK);
> > +	return create_new_entry(fm, &args, dir, entry, S_IFLNK,
> > +				fm->fc->init_security);
> >  }
> >  
> >  void fuse_update_ctime(struct inode *inode)
> > @@ -915,7 +1019,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
> >  	args.in_args[0].value = &inarg;
> >  	args.in_args[1].size = newent->d_name.len + 1;
> >  	args.in_args[1].value = newent->d_name.name;
> > -	err = create_new_entry(fm, &args, newdir, newent, inode->i_mode);
> > +	err = create_new_entry(fm, &args, newdir, newent, inode->i_mode,
> > +			       false);
> >  	/* Contrary to "normal" filesystems it can happen that link
> >  	   makes two "logical" inodes point to the same "physical"
> >  	   inode.  We invalidate the attributes of the old one, so it
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 319596df5dc6..885f34f9967f 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -765,6 +765,9 @@ struct fuse_conn {
> >  	/* Propagate syncfs() to server */
> >  	unsigned int sync_fs:1;
> >  
> > +	/* Initialize security xattrs when creating a new inode */
> > +	unsigned int init_security:1;
> > +
> >  	/** The number of requests waiting for completion */
> >  	atomic_t num_waiting;
> >  
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 36cd03114b6d..343bc9cfbd92 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1152,6 +1152,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> >  			}
> >  			if (arg->flags & FUSE_SETXATTR_EXT)
> >  				fc->setxattr_ext = 1;
> > +			if (arg->flags & FUSE_SECURITY_CTX)
> > +				fc->init_security = 1;
> >  		} else {
> >  			ra_pages = fc->max_read / PAGE_SIZE;
> >  			fc->no_lock = 1;
> > @@ -1195,7 +1197,7 @@ void fuse_send_init(struct fuse_mount *fm)
> >  		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
> >  		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
> >  		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
> > -		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT;
> > +		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_SECURITY_CTX;
> >  #ifdef CONFIG_FUSE_DAX
> >  	if (fm->fc->dax)
> >  		ia->in.flags |= FUSE_MAP_ALIGNMENT;
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 2fe54c80051a..b31a0f79fde8 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -986,4 +986,24 @@ struct fuse_syncfs_in {
> >  	uint64_t	padding;
> >  };
> >  
> > +/*
> > + * For each security context, send fuse_secctx with size of security context
> > + * fuse_secctx will be followed by security context name and this in turn
> > + * will be followed by actual context label.
> > + * fuse_secctx, name, context
> > + * */
> > +struct fuse_secctx {
> > +	uint32_t	size;
> > +	uint32_t	padding;
> > +};
> > +
> > +/*
> > + * Contains the information about how many fuse_secctx structures are being
> > + * sent.
> > + */
> > +struct fuse_secctxs {
> > +	uint32_t	nr_secctx;
> > +	uint32_t	padding;
> > +};
> > +
> >  #endif /* _LINUX_FUSE_H */
> 

