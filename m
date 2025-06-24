Return-Path: <linux-fsdevel+bounces-52740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C224EAE61FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F165A18818F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ACE283144;
	Tue, 24 Jun 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVqn/Vdj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40549281509;
	Tue, 24 Jun 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760152; cv=none; b=M8akEEiVuWKodBfjcTxb4nj5/HHWuYa8H2X90cCMJJfuaotBCZ+zARD6giYoe7btkk8nHfrH6H2wR/g9Dc0jHJ4D3TKzk+GmiiFlLfNP15D0MgGzqsFRzFO5CbMbCom61YaQGFzUx+cPpfFwJURSCcFOMj03JJtQ2mgb82MAStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760152; c=relaxed/simple;
	bh=Bhimb+z8ZQRQlBvtJ7sZ+h5UwKqToF281KuGbFT3hVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWI05vd2Ro00EI+T3cDch4VQ2GHfBD/2lMkt/EkAJKQPZyTVSdm89kiu7QmbfiUNbpHj8CFgV0vYRMBVA5/q2Ve70orw1pTn3+3ms60ZwIFLQ0ngV1Q+APHF8lZ/NMcP9C21LhTE4JBdWu3JcWWTgM9H7aJSkBeM6XZ7X8y01DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVqn/Vdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ACCC4CEE3;
	Tue, 24 Jun 2025 10:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750760152;
	bh=Bhimb+z8ZQRQlBvtJ7sZ+h5UwKqToF281KuGbFT3hVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iVqn/Vdj7ASkl6oqHCFVy3JJc6Ef7Xc8JFmaFG5VYOkc18PjMwcFvV9Q57m+3Qi+0
	 xoqI2qUAZlFBoAkXZy+UCfIdVpdb5Caj6LuN50Skva/hQvshlVV3g+qft6JIVox/6k
	 cC5U7IloRHRshwMMiOFysfbjtY8g3rBbocTUOglOk9vwjVCK7AkC7dTWRyicnR96Ig
	 t7F81xC+KmqHwtBc8S9q/gjXctr8s02hVyo9S8yKLh0DI0i65z4XyL5VtGhd8SttqX
	 wpxrxmsZt+WI0VaS8y3wC4ATFDZNC6B5dGpPLMSmRbC53dg/xtT4bQUhJquh7+ryyQ
	 kHYmaNz4GE8Lg==
Date: Tue, 24 Jun 2025 12:15:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 10/11] fhandle, pidfs: support open_by_handle_at()
 purely based on file handle
Message-ID: <20250624-weltoffen-anteil-2863e47ffb66@brauner>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org>
 <ng6fvyydyem4qh3rtkvaeyyxm3suixjoef5nepyhwgc4k26chp@n2tlycbek4vl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ng6fvyydyem4qh3rtkvaeyyxm3suixjoef5nepyhwgc4k26chp@n2tlycbek4vl>

On Tue, Jun 24, 2025 at 11:30:42AM +0200, Jan Kara wrote:
> On Tue 24-06-25 10:29:13, Christian Brauner wrote:
> > Various filesystems such as pidfs (and likely drm in the future) have a
> > use-case to support opening files purely based on the handle without
> > having to require a file descriptor to another object. That's especially
> > the case for filesystems that don't do any lookup whatsoever and there's
> > zero relationship between the objects. Such filesystems are also
> > singletons that stay around for the lifetime of the system meaning that
> > they can be uniquely identified and accessed purely based on the file
> > handle type. Enable that so that userspace doesn't have to allocate an
> > object needlessly especially if they can't do that for whatever reason.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/fhandle.c | 22 ++++++++++++++++++++--
> >  fs/pidfs.c   |  5 ++++-
> >  2 files changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index ab4891925b52..54081e19f594 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -173,7 +173,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
> >  	return err;
> >  }
> >  
> > -static int get_path_anchor(int fd, struct path *root)
> > +static int get_path_anchor(int fd, struct path *root, int handle_type)
> >  {
> >  	if (fd >= 0) {
> >  		CLASS(fd, f)(fd);
> > @@ -193,6 +193,24 @@ static int get_path_anchor(int fd, struct path *root)
> >  		return 0;
> >  	}
> >  
> > +	/*
> > +	 * Only autonomous handles can be decoded without a file
> > +	 * descriptor.
> > +	 */
> > +	if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > +		return -EOPNOTSUPP;
> 
> This somewhat ties to my comment to patch 5 that if someone passed invalid
> fd < 0 before, we'd be returning -EBADF and now we'd be returning -EINVAL
> or -EOPNOTSUPP based on FILEID_IS_AUTONOMOUS setting. I don't care that
> much about it so feel free to ignore me but I think the following might be
> more sensible error codes:
> 
> 	if (!(handle_type & FILEID_IS_AUTONOMOUS)) {
> 		if (fd == FD_INVALID)
> 			return -EOPNOTSUPP;
> 		return -EBADF;
> 	}

Yes, that makes sense. I'll take the suggestion.

> 
> 	if (fd != FD_INVALID)
> 		return -EBADF; (or -EINVAL no strong preference here)
> 
> Since I don't care that much feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
> > +
> > +	if (fd != FD_INVALID)
> > +		return -EINVAL;
> > +
> > +	switch (handle_type & ~FILEID_USER_FLAGS_MASK) {
> > +	case FILEID_PIDFS:
> > +		pidfs_get_root(root);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > @@ -347,7 +365,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
> >  	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS)
> >  		return -EINVAL;
> >  
> > -	retval = get_path_anchor(mountdirfd, &ctx.root);
> > +	retval = get_path_anchor(mountdirfd, &ctx.root, f_handle.handle_type);
> >  	if (retval)
> >  		return retval;
> >  
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index 69b0541042b5..2ab9b47fbfae 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -747,7 +747,7 @@ static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> >  
> >  	*max_len = 2;
> >  	*(u64 *)fh = pid->ino;
> > -	return FILEID_KERNFS;
> > +	return FILEID_PIDFS;
> >  }
> >  
> >  static int pidfs_ino_find(const void *key, const struct rb_node *node)
> > @@ -802,6 +802,8 @@ static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
> >  		return NULL;
> >  
> >  	switch (fh_type) {
> > +	case FILEID_PIDFS:
> > +		fallthrough;
> >  	case FILEID_KERNFS:
> >  		pid_ino = *(u64 *)fid;
> >  		break;
> > @@ -860,6 +862,7 @@ static const struct export_operations pidfs_export_operations = {
> >  	.fh_to_dentry	= pidfs_fh_to_dentry,
> >  	.open		= pidfs_export_open,
> >  	.permission	= pidfs_export_permission,
> > +	.flags		= EXPORT_OP_AUTONOMOUS_HANDLES,
> >  };
> >  
> >  static int pidfs_init_inode(struct inode *inode, void *data)
> > 
> > -- 
> > 2.47.2
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

