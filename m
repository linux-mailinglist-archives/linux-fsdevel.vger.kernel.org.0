Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7487134D6FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 20:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhC2SYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 14:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231512AbhC2SYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617042258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXvvov0kw0xayauIS2PQTOixymfQhx7i5Fb2Ug8Q+fw=;
        b=eo8yytXaYF4tzqi7zmgKgtecyCQ983uzwXa4gEBmv3zcrsJc4x3suV2WDBm33DbkU7AU5a
        PWrptc8iX7/bS1bVYtCPTKCJMmm8ZQ70HHxqr1IX8J8o3kJzTlk9YLjObCXWUaI8O2IqrX
        qEYUD/cWgZD+94Mv09cdfBN3SF2+IVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-FgUav5CIOEaAKk3V7SuVZQ-1; Mon, 29 Mar 2021 14:24:14 -0400
X-MC-Unique: FgUav5CIOEaAKk3V7SuVZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F00AE801814;
        Mon, 29 Mar 2021 18:24:12 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-64.rdu2.redhat.com [10.10.116.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55B4990A0B;
        Mon, 29 Mar 2021 18:24:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E10C3220BCF; Mon, 29 Mar 2021 14:24:08 -0400 (EDT)
Date:   Mon, 29 Mar 2021 14:24:08 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, dgilbert@redhat.com,
        seth.forshee@canonical.com
Subject: Re: [PATCH v2 1/2] fuse: Add support for FUSE_SETXATTR_V2
Message-ID: <20210329182408.GE676525@redhat.com>
References: <20210325151823.572089-1-vgoyal@redhat.com>
 <20210325151823.572089-2-vgoyal@redhat.com>
 <YGHqC7bZuh+ytg+p@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YGHqC7bZuh+ytg+p@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 29, 2021 at 03:54:03PM +0100, Luis Henriques wrote:
> On Thu, Mar 25, 2021 at 11:18:22AM -0400, Vivek Goyal wrote:
> > Fuse client needs to send additional information to file server when
> > it calls SETXATTR(system.posix_acl_access). Right now there is no extra
> > space in fuse_setxattr_in. So introduce a v2 of the structure which has
> > more space in it and can be used to send extra flags.
> > 
> > "struct fuse_setxattr_in_v2" is only used if file server opts-in for it using
> > flag FUSE_SETXATTR_V2 during feature negotiations.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/fuse/acl.c             |  2 +-
> >  fs/fuse/fuse_i.h          |  5 ++++-
> >  fs/fuse/inode.c           |  4 +++-
> >  fs/fuse/xattr.c           | 21 +++++++++++++++------
> >  include/uapi/linux/fuse.h | 10 ++++++++++
> >  5 files changed, 33 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> > index e9c0f916349d..d31260a139d4 100644
> > --- a/fs/fuse/acl.c
> > +++ b/fs/fuse/acl.c
> > @@ -94,7 +94,7 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
> >  			return ret;
> >  		}
> >  
> > -		ret = fuse_setxattr(inode, name, value, size, 0);
> > +		ret = fuse_setxattr(inode, name, value, size, 0, 0);
> >  		kfree(value);
> >  	} else {
> >  		ret = fuse_removexattr(inode, name);
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 63d97a15ffde..d00bf0b9a38c 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -668,6 +668,9 @@ struct fuse_conn {
> >  	/** Is setxattr not implemented by fs? */
> >  	unsigned no_setxattr:1;
> >  
> > +	/** Does file server support setxattr_v2 */
> > +	unsigned setxattr_v2:1;
> > +
> >  	/** Is getxattr not implemented by fs? */
> >  	unsigned no_getxattr:1;
> >  
> > @@ -1170,7 +1173,7 @@ void fuse_unlock_inode(struct inode *inode, bool locked);
> >  bool fuse_lock_inode(struct inode *inode);
> >  
> >  int fuse_setxattr(struct inode *inode, const char *name, const void *value,
> > -		  size_t size, int flags);
> > +		  size_t size, int flags, unsigned extra_flags);
> >  ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
> >  		      size_t size);
> >  ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size);
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index b0e18b470e91..1c726df13f80 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1052,6 +1052,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> >  				fc->handle_killpriv_v2 = 1;
> >  				fm->sb->s_flags |= SB_NOSEC;
> >  			}
> > +			if (arg->flags & FUSE_SETXATTR_V2)
> > +				fc->setxattr_v2 = 1;
> >  		} else {
> >  			ra_pages = fc->max_read / PAGE_SIZE;
> >  			fc->no_lock = 1;
> > @@ -1095,7 +1097,7 @@ void fuse_send_init(struct fuse_mount *fm)
> >  		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
> >  		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
> >  		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
> > -		FUSE_HANDLE_KILLPRIV_V2;
> > +		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_V2;
> >  #ifdef CONFIG_FUSE_DAX
> >  	if (fm->fc->dax)
> >  		ia->in.flags |= FUSE_MAP_ALIGNMENT;
> > diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
> > index 1a7d7ace54e1..f2aae72653dc 100644
> > --- a/fs/fuse/xattr.c
> > +++ b/fs/fuse/xattr.c
> > @@ -12,24 +12,33 @@
> >  #include <linux/posix_acl_xattr.h>
> >  
> >  int fuse_setxattr(struct inode *inode, const char *name, const void *value,
> > -		  size_t size, int flags)
> > +		  size_t size, int flags, unsigned extra_flags)
> >  {
> >  	struct fuse_mount *fm = get_fuse_mount(inode);
> >  	FUSE_ARGS(args);
> >  	struct fuse_setxattr_in inarg;
> > +	struct fuse_setxattr_in_v2 inarg_v2;
> > +	bool setxattr_v2 = fm->fc->setxattr_v2;
> >  	int err;
> >  
> >  	if (fm->fc->no_setxattr)
> >  		return -EOPNOTSUPP;
> >  
> >  	memset(&inarg, 0, sizeof(inarg));
> > -	inarg.size = size;
> > -	inarg.flags = flags;
> > +	memset(&inarg_v2, 0, sizeof(inarg_v2));
> > +	if (setxattr_v2) {
> > +		inarg_v2.size = size;
> > +		inarg_v2.flags = flags;
> > +		inarg_v2.setxattr_flags = extra_flags;
> > +	} else {
> > +		inarg.size = size;
> > +		inarg.flags = flags;
> > +	}
> >  	args.opcode = FUSE_SETXATTR;
> >  	args.nodeid = get_node_id(inode);
> >  	args.in_numargs = 3;
> > -	args.in_args[0].size = sizeof(inarg);
> > -	args.in_args[0].value = &inarg;
> > +	args.in_args[0].size = setxattr_v2 ? sizeof(inarg_v2) : sizeof(inarg);
> > +	args.in_args[0].value = setxattr_v2 ? &inarg_v2 : (void *)&inarg;
> 
> And yet another minor:
> 
> It's a bit awkward to have to cast '&inarg' to 'void *' just because
> you're using the ternary operator.  Why not use an 'if' statement instead
> for initializing .size and .value?

Yes, I had to use (void *), otherwise compiler was complaining about
returning different types of pointers. Interesting that compiler
expects to return same type of pointer.

I think I am fine with this as well as adding explicit if statement. I
guess just a matter of taste. 

Miklos, what do you think? If you also prefer if statement instead,
I will make changes and post again.

Vivek

> 
> Cheers,
> --
> Luís
> 
> >  	args.in_args[1].size = strlen(name) + 1;
> >  	args.in_args[1].value = name;
> >  	args.in_args[2].size = size;
> > @@ -199,7 +208,7 @@ static int fuse_xattr_set(const struct xattr_handler *handler,
> >  	if (!value)
> >  		return fuse_removexattr(inode, name);
> >  
> > -	return fuse_setxattr(inode, name, value, size, flags);
> > +	return fuse_setxattr(inode, name, value, size, flags, 0);
> >  }
> >  
> >  static bool no_xattr_list(struct dentry *dentry)
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 54442612c48b..1bb555c1c117 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -179,6 +179,7 @@
> >   *  7.33
> >   *  - add FUSE_HANDLE_KILLPRIV_V2, FUSE_WRITE_KILL_SUIDGID, FATTR_KILL_SUIDGID
> >   *  - add FUSE_OPEN_KILL_SUIDGID
> > + *  - add FUSE_SETXATTR_V2
> >   */
> >  
> >  #ifndef _LINUX_FUSE_H
> > @@ -330,6 +331,7 @@ struct fuse_file_lock {
> >   *			does not have CAP_FSETID. Additionally upon
> >   *			write/truncate sgid is killed only if file has group
> >   *			execute permission. (Same as Linux VFS behavior).
> > + * FUSE_SETXATTR_V2:	Does file server support V2 of struct fuse_setxattr_in
> >   */
> >  #define FUSE_ASYNC_READ		(1 << 0)
> >  #define FUSE_POSIX_LOCKS	(1 << 1)
> > @@ -360,6 +362,7 @@ struct fuse_file_lock {
> >  #define FUSE_MAP_ALIGNMENT	(1 << 26)
> >  #define FUSE_SUBMOUNTS		(1 << 27)
> >  #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
> > +#define FUSE_SETXATTR_V2	(1 << 29)
> >  
> >  /**
> >   * CUSE INIT request/reply flags
> > @@ -686,6 +689,13 @@ struct fuse_setxattr_in {
> >  	uint32_t	flags;
> >  };
> >  
> > +struct fuse_setxattr_in_v2 {
> > +	uint32_t	size;
> > +	uint32_t	flags;
> > +	uint32_t	setxattr_flags;
> > +	uint32_t	padding;
> > +};
> > +
> >  struct fuse_getxattr_in {
> >  	uint32_t	size;
> >  	uint32_t	padding;
> > -- 
> > 2.25.4
> > 
> 

