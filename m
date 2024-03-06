Return-Path: <linux-fsdevel+bounces-13761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DA1873817
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 14:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C625286C6A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 13:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D07131746;
	Wed,  6 Mar 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cbKBBwnp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF08130E5C
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732858; cv=none; b=l405O6iJgISSVr3AwSIc2pN7xDoHgRJe8/g+D0yr6O0qiYBAcXLEO8wbnHGzMnfUIYjATEYy9EbDI3rOGRbOObqrMo+bsJpU7Dw9j/0lQ1i6L5yExxHQhkmBTJcas/8nzrOBGk94xVVOB+MNBcxQNLRMIU5jJegAOPxaXF8z8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732858; c=relaxed/simple;
	bh=euG2eayje2LSWjIyg0xW/mCPVcyU6uIGUqDdjzCBxuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeuRmkac1c24WdERpLJ5M9c4AlefGp0cuAcDZee1jVk+WotM9eu0e/YcknGwbFmYNJtenBAcJWt0dtaDnGDB2E+O+RlqRUpMM4S9SJH9a/RhBgdPCNOZJ+EBEL1NSXOMC8Q6brUG5au+MAI2taqFdrR/X8x1to2a8I4TSCRG3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cbKBBwnp; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TqYdq4m8SzMrkvZ;
	Wed,  6 Mar 2024 14:47:27 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TqYdp4zQBz3Z;
	Wed,  6 Mar 2024 14:47:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709732847;
	bh=euG2eayje2LSWjIyg0xW/mCPVcyU6uIGUqDdjzCBxuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cbKBBwnpHunbHQMzZUqvltY7KD2XzA4fo5MJmtbFoylMzWnBffSalvrvjTGrJJFqQ
	 l/NrsZklKi/Mhzh2OeyUkfVUQUac64oAqQp07vXEs7UYz30+ope6GmdR0OMOMjQQ1c
	 U7UEKK8fGgOKanZfpVNLY6S5uBaBrcQlyUsbpotI=
Date: Wed, 6 Mar 2024 14:47:13 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>
Cc: Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Message-ID: <20240306.zoochahX8xai@digikod.net>
References: <20240219.chu4Yeegh3oo@digikod.net>
 <20240219183539.2926165-1-mic@digikod.net>
 <ZedgzRDQaki2B8nU@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZedgzRDQaki2B8nU@google.com>
X-Infomaniak-Routing: alpha

On Tue, Mar 05, 2024 at 07:13:33PM +0100, Günther Noack wrote:
> Hello!
> 
> More questions than answers in this code review, but maybe this discusison will
> help to get a clearer picture about what we are going for here.
> 
> On Mon, Feb 19, 2024 at 07:35:39PM +0100, Mickaël Salaün wrote:
> > vfs_masks_device_ioctl() and vfs_masks_device_ioctl_compat() are useful
> > to differenciate between device driver IOCTL implementations and
> > filesystem ones.  The goal is to be able to filter well-defined IOCTLs
> > from per-device (i.e. namespaced) IOCTLs and control such access.
> > 
> > Add a new ioctl_compat() helper, similar to vfs_ioctl(), to wrap
> > compat_ioctl() calls and handle error conversions.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Günther Noack <gnoack@google.com>
> > ---
> >  fs/ioctl.c         | 101 +++++++++++++++++++++++++++++++++++++++++----
> >  include/linux/fs.h |  12 ++++++
> >  2 files changed, 105 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 76cf22ac97d7..f72c8da47d21 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -763,6 +763,38 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
> >  	return err;
> >  }
> >  
> > +/*
> > + * Safeguard to maintain a list of valid IOCTLs handled by do_vfs_ioctl()
> > + * instead of def_blk_fops or def_chr_fops (see init_special_inode).
> > + */
> > +__attribute_const__ bool vfs_masked_device_ioctl(const unsigned int cmd)
> > +{
> > +	switch (cmd) {
> > +	case FIOCLEX:
> > +	case FIONCLEX:
> > +	case FIONBIO:
> > +	case FIOASYNC:
> > +	case FIOQSIZE:
> > +	case FIFREEZE:
> > +	case FITHAW:
> > +	case FS_IOC_FIEMAP:
> > +	case FIGETBSZ:
> > +	case FICLONE:
> > +	case FICLONERANGE:
> > +	case FIDEDUPERANGE:
> > +	/* FIONREAD is forwarded to device implementations. */
> > +	case FS_IOC_GETFLAGS:
> > +	case FS_IOC_SETFLAGS:
> > +	case FS_IOC_FSGETXATTR:
> > +	case FS_IOC_FSSETXATTR:
> > +	/* file_ioctl()'s IOCTLs are forwarded to device implementations. */
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +EXPORT_SYMBOL(vfs_masked_device_ioctl);
> 
> [
> Technical implementation notes about this function: the list of IOCTLs here are
> the same ones which do_vfs_ioctl() implements directly.
> 
> There are only two cases in which do_vfs_ioctl() does more complicated handling:
> 
> (1) FIONREAD falls back to the device's ioctl implemenetation.
>     Therefore, we omit FIONREAD in our own list - we do not want to allow that.
> (2) The default case falls back to the file_ioctl() function, but *only* for
>     S_ISREG() files, so it does not matter for the Landlock case.
> ]
> 
> 
> ## What we are actually trying to do (?)
> 
> Let me try to take a step back and paraphrase what I think we are *actually*
> trying to do here -- please correct me if I am wrong about that:
> 
> I think what we *really* are trying to do is to control from the Landlock LSM
> whether the filp->f_op->unlocked_ioctl() or filp->f_op->ioctl_compat()
> operations are getting called for device files.
> 
> So in a world where we cared only about correctness, we could create a new LSM
> hook security_file_vfs_ioctl(), which gets checked just before these two f_op
> operations get called.  With that, we could permit all IOCTLs that are
> implemented in fs/ioctl.c, and we could deny all IOCTL commands that are
> implemented in the device implementation.
> 
> I guess the reasons why we are not using that approach are performance, and that
> it might mess up the LSM hook interface with special cases that only Landlcok
> needs?  But it seems like it would be easier to reason about..?  Or maybe we can
> find a middle ground, where we have the existing hook return a special value
> with the meaning "permit this IOCTL, but do not invoke the f_op hook"?

Your security_file_vfs_ioctl() approach is simpler and better, I like
it!  From a performance point of view it should not change much because
either an LSM would use the current IOCTL hook or this new one.  Using a
flag with the current IOCTL hook would be a missed opportunity for
performance improvements because this hook could be called even if it is
not needed.

I don't think it would be worth it to create a new hook for compat and
non-compat mode because we want to control these IOCTLs the same way for
now, so it would not have a performance impact, but for consistency with
the current IOCTL hooks I guess Paul would prefer two new hooks:
security_file_vfs_ioctl() and security_file_vfs_ioctl_compat()?

Another approach would be to split the IOCTL hook into two: one for the
VFS layer and another for the underlying implementations.  However, it
looks like a difficult and brittle approach according to the current
IOCTL implementations.

Arnd, Christian, Paul, are you OK with this new hook proposal?

> 
> 
> ## What we implemented
> 
> Of course, the existing security_file_ioctl LSM hook works differently, and so
> with that hook, we need to make our blocking decision purely based on the struct
> file*, the IOCTL command number and the IOCTL argument.
> 
> So in order to make that decision correctly based on that information, we end up
> listing all the IOCTLs which are directly(!) implemented in do_vfs_ioctl(),
> because for Landlock, this is the list of IOCTL commands which is safe to permit
> on device files.  And we need to keep that list in sync with fs/ioctl.c, which
> is why it ended up in the same place in this commit.
> 
> 
> (Is it maybe possible to check with a KUnit test whether such lists are in sync?
> It sounds superficially like it should be feasible to create a device file which
> records whether its ioctl implementation was called.  So we could at least check
> that the Landlock command list is a subset of the do_vfs_ioctl() one.)
> 
> 
> > +
> >  /*
> >   * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
> >   * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
> > @@ -858,6 +890,8 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
> >  {
> >  	struct fd f = fdget(fd);
> >  	int error;
> > +	const struct inode *inode;
> > +	bool is_device;
> >  
> >  	if (!f.file)
> >  		return -EBADF;
> > @@ -866,9 +900,18 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
> >  	if (error)
> >  		goto out;
> >  
> > +	inode = file_inode(f.file);
> > +	is_device = S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
> > +	if (is_device && !vfs_masked_device_ioctl(cmd)) {
> > +		error = vfs_ioctl(f.file, cmd, arg);
> > +		goto out;
> > +	}
> > +
> >  	error = do_vfs_ioctl(f.file, fd, cmd, arg);
> > -	if (error == -ENOIOCTLCMD)
> > +	if (error == -ENOIOCTLCMD) {
> > +		WARN_ON_ONCE(is_device);
> >  		error = vfs_ioctl(f.file, cmd, arg);
> > +	}
> 
> It is not obvious at first that adding this list requires a change to the ioctl
> syscall implementations.  If I understand this right, the idea is that you want
> to be 100% sure that we are not calling vfs_ioctl() for the commands in that
> list.

Correct

> And there is a scenario where this could potentially happen:
> 
> do_vfs_ioctl() implements most things like this:
> 
> static int do_vfs_ioctl(...) {
> 	switch (cmd) {
> 	/* many cases like the following: */
> 	case FITHAW:
> 		return ioctl_fsthaw(filp);
> 	/* ... */
> 	}
> 	return -ENOIOCTLCMD;
> }
> 
> So I believe the scenario you want to avoid is the one where ioctl_fsthaw() or
> one of the other functions return -ENOIOCTLCMD by accident, and where that will
> then make the surrounding syscall implementation fall back to vfs_ioctl()
> despite the cmd being listed as safe for Landlock?  Is that right?

Yes

> 
> Looking at do_vfs_ioctl() and its helper functions, I am getting the impression
> that -ENOIOCTLCMD is only supposed to be returned at the very end of it, but not
> by any of the helper functions?  If that were the case, we could maybe just as
> well just solve that problem local to do_vfs_ioctl()?
> 
> A bit inelegant maybe, but just to get the idea across:
> 
> static int sanitize_enoioctlcmd(int res) {
> 	if (res == -ENOIOCTLCMD)
> 		return ENOTTY;
> 	return res;
> }
> 
> static int do_vfs_ioctl(...) {
> 	switch (cmd) {
> 	/* many cases like the following: */
> 	case FITHAW:
> 		return sanitize_enoioctlcmd(ioctl_fsthaw(filp));
> 	/* ... */
> 	}
> 	return -ENOIOCTLCMD;
> }
> 
> Would that be better?

I guess so, but a bit more intrusive. Anyway, the new LSM hook would be
much cleaner and would require less intrusive changes in fs/ioctl.c

The ioctl_compat() helper from this patch could still be useful though.

> 
> —Günther
> 
> 

