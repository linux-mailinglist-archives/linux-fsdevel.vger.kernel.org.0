Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844EA34D908
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 22:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhC2U2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 16:28:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:47374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhC2U1z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 16:27:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7B70B083;
        Mon, 29 Mar 2021 20:27:53 +0000 (UTC)
Received: from localhost (orpheus.olymp [local])
        by orpheus.olymp (OpenSMTPD) with ESMTPA id 9c5e6201;
        Mon, 29 Mar 2021 21:27:47 +0100 (WEST)
From:   Luis Henriques <lhenriques@suse.de>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, dgilbert@redhat.com,
        seth.forshee@canonical.com
Subject: Re: [PATCH v2 1/2] fuse: Add support for FUSE_SETXATTR_V2
References: <20210325151823.572089-1-vgoyal@redhat.com>
        <20210325151823.572089-2-vgoyal@redhat.com> <YGHqC7bZuh+ytg+p@suse.de>
        <20210329182408.GE676525@redhat.com>
Date:   Mon, 29 Mar 2021 21:27:47 +0100
In-Reply-To: <20210329182408.GE676525@redhat.com> (Vivek Goyal's message of
        "Mon, 29 Mar 2021 14:24:08 -0400")
Message-ID: <87eefxk8n0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Mon, Mar 29, 2021 at 03:54:03PM +0100, Luis Henriques wrote:
>> On Thu, Mar 25, 2021 at 11:18:22AM -0400, Vivek Goyal wrote:
>> > Fuse client needs to send additional information to file server when
>> > it calls SETXATTR(system.posix_acl_access). Right now there is no extra
>> > space in fuse_setxattr_in. So introduce a v2 of the structure which has
>> > more space in it and can be used to send extra flags.
>> > 
>> > "struct fuse_setxattr_in_v2" is only used if file server opts-in for it using
>> > flag FUSE_SETXATTR_V2 during feature negotiations.
>> > 
>> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>> > ---
>> >  fs/fuse/acl.c             |  2 +-
>> >  fs/fuse/fuse_i.h          |  5 ++++-
>> >  fs/fuse/inode.c           |  4 +++-
>> >  fs/fuse/xattr.c           | 21 +++++++++++++++------
>> >  include/uapi/linux/fuse.h | 10 ++++++++++
>> >  5 files changed, 33 insertions(+), 9 deletions(-)
>> > 
>> > diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
>> > index e9c0f916349d..d31260a139d4 100644
>> > --- a/fs/fuse/acl.c
>> > +++ b/fs/fuse/acl.c
>> > @@ -94,7 +94,7 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>> >  			return ret;
>> >  		}
>> >  
>> > -		ret = fuse_setxattr(inode, name, value, size, 0);
>> > +		ret = fuse_setxattr(inode, name, value, size, 0, 0);
>> >  		kfree(value);
>> >  	} else {
>> >  		ret = fuse_removexattr(inode, name);
>> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> > index 63d97a15ffde..d00bf0b9a38c 100644
>> > --- a/fs/fuse/fuse_i.h
>> > +++ b/fs/fuse/fuse_i.h
>> > @@ -668,6 +668,9 @@ struct fuse_conn {
>> >  	/** Is setxattr not implemented by fs? */
>> >  	unsigned no_setxattr:1;
>> >  
>> > +	/** Does file server support setxattr_v2 */
>> > +	unsigned setxattr_v2:1;
>> > +
>> >  	/** Is getxattr not implemented by fs? */
>> >  	unsigned no_getxattr:1;
>> >  
>> > @@ -1170,7 +1173,7 @@ void fuse_unlock_inode(struct inode *inode, bool locked);
>> >  bool fuse_lock_inode(struct inode *inode);
>> >  
>> >  int fuse_setxattr(struct inode *inode, const char *name, const void *value,
>> > -		  size_t size, int flags);
>> > +		  size_t size, int flags, unsigned extra_flags);
>> >  ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
>> >  		      size_t size);
>> >  ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size);
>> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> > index b0e18b470e91..1c726df13f80 100644
>> > --- a/fs/fuse/inode.c
>> > +++ b/fs/fuse/inode.c
>> > @@ -1052,6 +1052,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>> >  				fc->handle_killpriv_v2 = 1;
>> >  				fm->sb->s_flags |= SB_NOSEC;
>> >  			}
>> > +			if (arg->flags & FUSE_SETXATTR_V2)
>> > +				fc->setxattr_v2 = 1;
>> >  		} else {
>> >  			ra_pages = fc->max_read / PAGE_SIZE;
>> >  			fc->no_lock = 1;
>> > @@ -1095,7 +1097,7 @@ void fuse_send_init(struct fuse_mount *fm)
>> >  		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
>> >  		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
>> >  		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
>> > -		FUSE_HANDLE_KILLPRIV_V2;
>> > +		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_V2;
>> >  #ifdef CONFIG_FUSE_DAX
>> >  	if (fm->fc->dax)
>> >  		ia->in.flags |= FUSE_MAP_ALIGNMENT;
>> > diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
>> > index 1a7d7ace54e1..f2aae72653dc 100644
>> > --- a/fs/fuse/xattr.c
>> > +++ b/fs/fuse/xattr.c
>> > @@ -12,24 +12,33 @@
>> >  #include <linux/posix_acl_xattr.h>
>> >  
>> >  int fuse_setxattr(struct inode *inode, const char *name, const void *value,
>> > -		  size_t size, int flags)
>> > +		  size_t size, int flags, unsigned extra_flags)
>> >  {
>> >  	struct fuse_mount *fm = get_fuse_mount(inode);
>> >  	FUSE_ARGS(args);
>> >  	struct fuse_setxattr_in inarg;
>> > +	struct fuse_setxattr_in_v2 inarg_v2;
>> > +	bool setxattr_v2 = fm->fc->setxattr_v2;
>> >  	int err;
>> >  
>> >  	if (fm->fc->no_setxattr)
>> >  		return -EOPNOTSUPP;
>> >  
>> >  	memset(&inarg, 0, sizeof(inarg));
>> > -	inarg.size = size;
>> > -	inarg.flags = flags;
>> > +	memset(&inarg_v2, 0, sizeof(inarg_v2));
>> > +	if (setxattr_v2) {
>> > +		inarg_v2.size = size;
>> > +		inarg_v2.flags = flags;
>> > +		inarg_v2.setxattr_flags = extra_flags;
>> > +	} else {
>> > +		inarg.size = size;
>> > +		inarg.flags = flags;
>> > +	}
>> >  	args.opcode = FUSE_SETXATTR;
>> >  	args.nodeid = get_node_id(inode);
>> >  	args.in_numargs = 3;
>> > -	args.in_args[0].size = sizeof(inarg);
>> > -	args.in_args[0].value = &inarg;
>> > +	args.in_args[0].size = setxattr_v2 ? sizeof(inarg_v2) : sizeof(inarg);
>> > +	args.in_args[0].value = setxattr_v2 ? &inarg_v2 : (void *)&inarg;
>> 
>> And yet another minor:
>> 
>> It's a bit awkward to have to cast '&inarg' to 'void *' just because
>> you're using the ternary operator.  Why not use an 'if' statement instead
>> for initializing .size and .value?
>
> Yes, I had to use (void *), otherwise compiler was complaining about
> returning different types of pointers. Interesting that compiler
> expects to return same type of pointer.

IIRC, K&R (which I unfortunately don't have at hand right now) says that
the types of both expressions need to match, so probably a different
compiler would show the same warning.

Cheers,
-- 
Luis

> I think I am fine with this as well as adding explicit if statement. I
> guess just a matter of taste. 
>
> Miklos, what do you think? If you also prefer if statement instead,
> I will make changes and post again.
>
> Vivek
