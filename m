Return-Path: <linux-fsdevel+bounces-31680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2889299A10A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77581F22720
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C07D212631;
	Fri, 11 Oct 2024 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QtOwiXhJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2717E210C3B
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641698; cv=none; b=tBairBJIcrnFy0/Y47zTQ7T4ydHBOXUAzkTl49v1lCDlvXaTB/QcTKLYpafC0rmjXwPlWektccUWCu/np1rXFH11myT55G/z+XEUGd0qmmW8NIPFZqUo85yEWBTNjmlEl4SQi0yw1P1VeeT+e/7w6BPRY+P7cqam771lT8UWe0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641698; c=relaxed/simple;
	bh=P+JmoelOr1AkJGdIYRfoUP3WELqAJR/560X2qkbvMk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA9pFVnwqzXc/dmctNK3ichD3+UCEVfRIeAwC56EQW81F1fsP31/DAt0o74fbf1bd5jkaL7p+byOS0CeY0g0YbRBH7MeNUoIjKBLpxWgprBuzXflkBUp/fRXql+qu32QVsWM05G5Pc5yLIrEErAZwhjLMZGkhc2zuPFH5ALw2Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QtOwiXhJ; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XQ2YL3lWSzTg9;
	Fri, 11 Oct 2024 12:14:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728641686;
	bh=BjwI9dQpsG6o7R53gFpOeKLKOfQ6dBdS+lZZuWdZpPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtOwiXhJ+SnzhD1buHK+d7ZqWkorpHMKFPC6ydwhM6HFUWvE4D7141OhgeArqRTci
	 M1xerIVIqA9H15XI0hCKCEdHmT/QWf9mW8fOkOGj3J72sUUVkycNFv24/u8ZqMsLfz
	 PwIyZ5ixr5PqTRv5qJnOY0wt+AxftgUADZJO7fck=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XQ2YK4q3nzFSD;
	Fri, 11 Oct 2024 12:14:45 +0200 (CEST)
Date: Fri, 11 Oct 2024 12:14:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241011.eiPheetu0equ@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <afa2eabf-e13f-4742-b27c-588eadca2600@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afa2eabf-e13f-4742-b27c-588eadca2600@oracle.com>
X-Infomaniak-Routing: alpha

On Thu, Oct 10, 2024 at 02:07:52PM -0400, Anna Schumaker wrote:
> Hi Mickaël,
> 
> On 10/10/24 11:26 AM, Mickaël Salaün wrote:
> > When a filesystem manages its own inode numbers, like NFS's fileid shown
> > to user space with getattr(), other part of the kernel may still expose
> > the private inode->ino through kernel logs and audit.
> > 
> > Another issue is on 32-bit architectures, on which ino_t is 32 bits,
> > whereas the user space's view of an inode number can still be 64 bits.
> > 
> > Add a new inode_get_ino() helper calling the new struct
> > inode_operations' get_ino() when set, to get the user space's view of an
> > inode number.  inode_get_ino() is called by generic_fillattr().
> > 
> > Implement get_ino() for NFS.
> > 
> > Cc: Trond Myklebust <trondmy@kernel.org>
> > Cc: Anna Schumaker <anna@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> > 
> > I'm not sure about nfs_namespace_getattr(), please review carefully.
> > 
> > I guess there are other filesystems exposing inode numbers different
> > than inode->i_ino, and they should be patched too.
> > ---
> >  fs/nfs/inode.c     | 6 ++++--
> >  fs/nfs/internal.h  | 1 +
> >  fs/nfs/namespace.c | 2 ++
> >  fs/stat.c          | 2 +-
> >  include/linux/fs.h | 9 +++++++++
> >  5 files changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index 542c7d97b235..5dfc176b6d92 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -83,18 +83,19 @@ EXPORT_SYMBOL_GPL(nfs_wait_bit_killable);
> >  
> >  /**
> >   * nfs_compat_user_ino64 - returns the user-visible inode number
> > - * @fileid: 64-bit fileid
> > + * @inode: inode pointer
> >   *
> >   * This function returns a 32-bit inode number if the boot parameter
> >   * nfs.enable_ino64 is zero.
> >   */
> > -u64 nfs_compat_user_ino64(u64 fileid)
> > +u64 nfs_compat_user_ino64(const struct *inode)
>                              ^^^^^^^^^^^^^^^^^^^
> This should be "const struct inode *inode"

Indeed...

> 
> >  {
> >  #ifdef CONFIG_COMPAT
> >  	compat_ulong_t ino;
> >  #else	
> >  	unsigned long ino;
> >  #endif
> > +	u64 fileid = NFS_FILEID(inode);
> >  
> >  	if (enable_ino64)
> >  		return fileid;
> > @@ -103,6 +104,7 @@ u64 nfs_compat_user_ino64(u64 fileid)
> >  		ino ^= fileid >> (sizeof(fileid)-sizeof(ino)) * 8;
> >  	return ino;
> >  }
> > +EXPORT_SYMBOL_GPL(nfs_compat_user_ino64);
> >  
> >  int nfs_drop_inode(struct inode *inode)
> >  {
> > diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> > index 430733e3eff2..f5555a71a733 100644
> > --- a/fs/nfs/internal.h
> > +++ b/fs/nfs/internal.h
> > @@ -451,6 +451,7 @@ extern void nfs_zap_acl_cache(struct inode *inode);
> >  extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
> >  extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
> >  extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
> > +extern u64 nfs_compat_user_ino64(const struct *inode);
> 
> Why add this here when it's already in include/linux/nfs_fs.h? Can you update that declaration instead?
> 
> Also, there is a caller for nfs_compat_user_ino64() in fs/nfs/dir.c that needs to be updated. Can you double check that you have CONFIG_NFS_FS=m (or 'y') in your kernel .config? These are all issues my compiler caught when I applied your patch.

Oh, I enabled CONFIG_NFSD_V4 and CONFIG_NFS_COMMON but not
CONFIG_NFS_FS, that explains these uncaught errors... Thanks!

About the nfs_do_filldir(), the nfs_compat_user_ino64() call is indeed
not correct with this patch, but I'm wondering why not use ent->ino
instead?

> 
> Thanks,
> Anna
> 
> >  
> >  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> >  /* localio.c */
> > diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> > index e7494cdd957e..d9b1e0606833 100644
> > --- a/fs/nfs/namespace.c
> > +++ b/fs/nfs/namespace.c
> > @@ -232,11 +232,13 @@ nfs_namespace_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> >  const struct inode_operations nfs_mountpoint_inode_operations = {
> >  	.getattr	= nfs_getattr,
> >  	.setattr	= nfs_setattr,
> > +	.get_ino	= nfs_compat_user_ino64,
> >  };
> >  
> >  const struct inode_operations nfs_referral_inode_operations = {
> >  	.getattr	= nfs_namespace_getattr,
> >  	.setattr	= nfs_namespace_setattr,
> > +	.get_ino	= nfs_compat_user_ino64,

Is it correct to use nfs_compat_user_ino64() for both of these inode
operation structs?  With this patch, generic_fileattr() initialize the
stat struct with get_ino(), which might not what we want according to
these nfs_mountpoint and nfs_referral structs.


> >  };
> >  
> >  static void nfs_expire_automounts(struct work_struct *work)
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 41e598376d7e..05636919f94b 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -50,7 +50,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
> >  	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
> >  
> >  	stat->dev = inode->i_sb->s_dev;
> > -	stat->ino = inode->i_ino;
> > +	stat->ino = inode_get_ino(inode);
> >  	stat->mode = inode->i_mode;
> >  	stat->nlink = inode->i_nlink;
> >  	stat->uid = vfsuid_into_kuid(vfsuid);
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index e3c603d01337..0eba09a21cf7 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2165,6 +2165,7 @@ struct inode_operations {
> >  			    struct dentry *dentry, struct fileattr *fa);
> >  	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
> >  	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
> > +	u64 (*get_ino)(const struct inode *inode);
> >  } ____cacheline_aligned;
> >  
> >  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> > @@ -2172,6 +2173,14 @@ static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> >  	return file->f_op->mmap(file, vma);
> >  }
> >  
> > +static inline u64 inode_get_ino(struct inode *inode)
> > +{
> > +	if (unlikely(inode->i_op->get_ino))
> > +		return inode->i_op->get_ino(inode);
> > +
> > +	return inode->i_ino;
> > +}
> > +
> >  extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
> >  extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
> >  extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
> 
> 

