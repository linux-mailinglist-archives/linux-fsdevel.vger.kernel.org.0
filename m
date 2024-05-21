Return-Path: <linux-fsdevel+bounces-19876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E728CACAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 12:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C331F22C77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E85C74BE0;
	Tue, 21 May 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/t8tJEh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE1481B9
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288770; cv=none; b=lcot4C0ExSBZK4oqMaApSXI7g7THxS57z/rWj9UEhzU99z8x2nKUn1HB6pW1c/L7Zm1fP6FXknnq4AUl9Hp8HJten0foE3hnN8pG719Q71ydvQonQKe5/yMgs3L9E6G/BCMfxrBfRMQ+X4gcvY6H6aURnI2+6OT1Rs0cGzI9udo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288770; c=relaxed/simple;
	bh=e9/Jn1k9vV9epBJrZXg4uSK4RPSRoT+u0KqFE5tpxA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYbVZKjPxGRugEhwqsfxOchfgyc7ff6Nc0fjX4PytLlDy7ey45Gfyv7xsJAxN/mwWEkZEc7QFYOYOM01ettOVLnzsb1So7Trr82ql8fR3HN1XlBLwuzyNMNkPd1DriDtHvQfH2FKN6osmWeJb2NMMOo+s60jbdVMyqMdRvsmyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/t8tJEh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716288767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56nvd/3MP7DtivfrraZ2mnUYGxV4GioUyzj3puEJA5Q=;
	b=d/t8tJEhd1qSdfx0fE+vYgRYteBzzJW1BDrT7Hf7vE1Bnn+5zefoTmcIC/5gJnT11FhZFI
	cmHRDCHeO9mBkpNLB4FPC61hWSTno5Ia9k9bGlCVJ8VSo33uKBdwHAFDpWP1pynRJ/3Zs9
	11J6WublJk1ZvBrXK5Eb8TLbbeSvS3A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-3rHgQ66BM1CCzNX5hWspDg-1; Tue, 21 May 2024 06:52:44 -0400
X-MC-Unique: 3rHgQ66BM1CCzNX5hWspDg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-354c7c04325so1084771f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 03:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716288763; x=1716893563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56nvd/3MP7DtivfrraZ2mnUYGxV4GioUyzj3puEJA5Q=;
        b=MP7nxdO0yDzgaQHsIfETvcKqVLTpSOh3Pw7YocbIOntmuqVKDiW4NAZWbUr5kFqliy
         SQrS+OHHe5BSlyOIxWV63eGawgM4qI/Qe+9hmwwbvNE0clUVr2TYpR2x48vj3V7A7BhJ
         QVwR/TzHs8v020KLzq6u4s5BsvZopaX31U9tRBPVKwXxpHe/znhH+Td/2fcFuzpndqxi
         XPk699u+neDgdVl3+KnQ5hkm0hfcrSCswNHBiFN+4SUvrCkyZhgBfxOcD7NFoZLvlEZN
         F0R3yT3GmsTe7IgX22UvsRHks5Cg7pa2jLe8yAzweUH7eHvc0i9SEq0cLGHlDX7y8bvG
         FgwA==
X-Gm-Message-State: AOJu0YxO9P71z/wWQBCapYzSty1ntiwaGgoXudWqriUGvcUE0f4CXUUm
	8O2Lt7qpA3pbks2FHPk19sIDXxwFEiwlG7w6LctvUMxZvqr//UBcNbtrz5IEcLx2dWlE6Y7Q9Gy
	2hyaeWmwvQsWhdi6p0wbATD46dzdQMIxfodLTQWX00YzCrm7nWrb5bq0Q+DP1ig==
X-Received: by 2002:a05:6000:367:b0:34c:7ed4:55a with SMTP id ffacd0b85a97d-354b9068ef6mr7201737f8f.33.1716288763164;
        Tue, 21 May 2024 03:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8X3T5ls2zvNTQPr42SEqp90ElmOB3G+kJaiypVEcci2UquiYpUqBaQ4MQm5HfBGvyHnDrDw==
X-Received: by 2002:a05:6000:367:b0:34c:7ed4:55a with SMTP id ffacd0b85a97d-354b9068ef6mr7201703f8f.33.1716288762574;
        Tue, 21 May 2024 03:52:42 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfc6sm31803283f8f.72.2024.05.21.03.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 03:52:42 -0700 (PDT)
Date: Tue, 21 May 2024 12:52:41 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <wetpv5posln2xv5dy26a7ohrsrcr6yi3lr6qrpbtjf3ymiilxy@ohukv2n3do6t>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <20240520175159.GD25518@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520175159.GD25518@frogsfrogsfrogs>

On 2024-05-20 10:51:59, Darrick J. Wong wrote:
> On Mon, May 20, 2024 at 06:46:21PM +0200, Andrey Albershteyn wrote:
> > XFS has project quotas which could be attached to a directory. All
> > new inodes in these directories inherit project ID set on parent
> > directory.
> > 
> > The project is created from userspace by opening and calling
> > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > files such as FIFO, SOCK, BLK etc. as opening them returns a special
> > inode from VFS. Therefore, some inodes are left with empty project
> > ID. Those inodes then are not shown in the quota accounting but
> > still exist in the directory.
> > 
> > This patch adds two new ioctls which allows userspace, such as
> > xfs_quota, to set project ID on special files by using parent
> > directory to open FS inode. This will let xfs_quota set ID on all
> > inodes and also reset it when project is removed. Also, as
> > vfs_fileattr_set() is now will called on special files too, let's
> > forbid any other attributes except projid and nextents (symlink can
> > have one).
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> >  fs/ioctl.c              | 93 +++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/fs.h | 11 +++++
> >  2 files changed, 104 insertions(+)
> > 
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 1d5abfdf0f22..3e3aacb6ea6e 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/mount.h>
> >  #include <linux/fscrypt.h>
> >  #include <linux/fileattr.h>
> > +#include <linux/namei.h>
> >  
> >  #include "internal.h"
> >  
> > @@ -647,6 +648,19 @@ static int fileattr_set_prepare(struct inode *inode,
> >  	if (fa->fsx_cowextsize == 0)
> >  		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> >  
> > +	/*
> > +	 * The only use case for special files is to set project ID, forbid any
> > +	 * other attributes
> > +	 */
> > +	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
> > +		if (fa->fsx_xflags & ~FS_XFLAG_PROJINHERIT)
> 
> When would PROJINHERIT be set on a non-reg/non-dir file?

Oh I thought it's set on all inodes in projects anyway, but looks
like it's dropped for files in xfs_flags2diflags(). The xfs_quota
just set it for each inode so I just haven't checked it. I will drop
this check and change xfs_quota to not set PROJINHERIT for special
files.

> > +			return -EINVAL;
> > +		if (!S_ISLNK(inode->i_mode) && fa->fsx_nextents)
> 
> FS_IOC_FSSETXATTR doesn't enforce anything for fsx_nextents for any
> other type of file, does it?

yes, it doesn't enforce anything, as I described in the comment I
tried to reject any other uses. But symlink has fsx_nextents == 1 so
get + set call will fail.

> 
> > +			return -EINVAL;
> > +		if (fa->fsx_extsize || fa->fsx_cowextsize)
> > +			return -EINVAL;
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > @@ -763,6 +777,79 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
> >  	return err;
> >  }
> >  
> > +static int ioctl_fsgetxattrat(struct file *file, void __user *argp)
> > +{
> > +	struct path filepath;
> > +	struct fsxattrat fsxat;
> > +	struct fileattr fa;
> > +	int error;
> > +
> > +	if (!S_ISDIR(file_inode(file)->i_mode))
> > +		return -EBADF;
> > +
> > +	if (copy_from_user(&fsxat, argp, sizeof(struct fsxattrat)))
> > +		return -EFAULT;
> > +
> > +	error = user_path_at(fsxat.dfd, fsxat.path, 0, &filepath);
> > +	if (error)
> > +		return error;
> > +
> > +	error = vfs_fileattr_get(filepath.dentry, &fa);
> > +	if (error) {
> > +		path_put(&filepath);
> > +		return error;
> > +	}
> > +
> > +	fsxat.fsx.fsx_xflags = fa.fsx_xflags;
> > +	fsxat.fsx.fsx_extsize = fa.fsx_extsize;
> > +	fsxat.fsx.fsx_nextents = fa.fsx_nextents;
> > +	fsxat.fsx.fsx_projid = fa.fsx_projid;
> > +	fsxat.fsx.fsx_cowextsize = fa.fsx_cowextsize;
> > +
> > +	if (copy_to_user(argp, &fsxat, sizeof(struct fsxattrat)))
> > +		error = -EFAULT;
> > +
> > +	path_put(&filepath);
> > +	return error;
> > +}
> > +
> > +static int ioctl_fssetxattrat(struct file *file, void __user *argp)
> > +{
> > +	struct mnt_idmap *idmap = file_mnt_idmap(file);
> > +	struct fsxattrat fsxat;
> > +	struct path filepath;
> > +	struct fileattr fa;
> > +	int error;
> > +
> > +	if (!S_ISDIR(file_inode(file)->i_mode))
> > +		return -EBADF;
> > +
> > +	if (copy_from_user(&fsxat, argp, sizeof(struct fsxattrat)))
> > +		return -EFAULT;
> > +
> > +	error = user_path_at(fsxat.dfd, fsxat.path, 0, &filepath);
> > +	if (error)
> > +		return error;
> > +
> > +	error = mnt_want_write(filepath.mnt);
> > +	if (error) {
> > +		path_put(&filepath);
> > +		return error;
> 
> This could be a goto to the path_put below.
> 
> > +	}
> > +
> > +	fileattr_fill_xflags(&fa, fsxat.fsx.fsx_xflags);
> > +	fa.fsx_extsize = fsxat.fsx.fsx_extsize;
> > +	fa.fsx_nextents = fsxat.fsx.fsx_nextents;
> > +	fa.fsx_projid = fsxat.fsx.fsx_projid;
> > +	fa.fsx_cowextsize = fsxat.fsx.fsx_cowextsize;
> > +	fa.fsx_valid = true;
> > +
> > +	error = vfs_fileattr_set(idmap, filepath.dentry, &fa);
> 
> Why not pass &fsxat.fsx directly to vfs_fileattr_set?

vfs_fileattr_set() takes fileattr and there won't be fsx_valid, no? I
suppose they aren't aligned

> 
> > +	mnt_drop_write(filepath.mnt);
> > +	path_put(&filepath);
> > +	return error;
> > +}
> > +
> >  static int ioctl_getfsuuid(struct file *file, void __user *argp)
> >  {
> >  	struct super_block *sb = file_inode(file)->i_sb;
> > @@ -872,6 +959,12 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
> >  	case FS_IOC_FSSETXATTR:
> >  		return ioctl_fssetxattr(filp, argp);
> >  
> > +	case FS_IOC_FSGETXATTRAT:
> > +		return ioctl_fsgetxattrat(filp, argp);
> > +
> > +	case FS_IOC_FSSETXATTRAT:
> > +		return ioctl_fssetxattrat(filp, argp);
> > +
> >  	case FS_IOC_GETFSUUID:
> >  		return ioctl_getfsuuid(filp, argp);
> >  
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 45e4e64fd664..f8cd8d7bf35d 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -139,6 +139,15 @@ struct fsxattr {
> >  	unsigned char	fsx_pad[8];
> >  };
> >  
> > +/*
> > + * Structure passed to FS_IOC_FSGETXATTRAT/FS_IOC_FSSETXATTRAT
> > + */
> > +struct fsxattrat {
> > +	struct fsxattr	fsx;		/* XATTR to get/set */
> > +	__u32		dfd;		/* parent dir */
> > +	const char	__user *path;
> 
> As I mentioned last time[1], embedding a pointer in an ioctl structure
> creates porting problems because pointer sizes vary between process
> personalities, so the size of struct fsxattrat will vary and lead to
> copy_to/from_user overflows.

Oh right, sorry, totally forgot about that

> 
> 
> [1] https://lore.kernel.org/linux-xfs/20240509232517.GR360919@frogsfrogsfrogs/
> 
> --D
> 
> > +};
> > +
> >  /*
> >   * Flags for the fsx_xflags field
> >   */
> > @@ -231,6 +240,8 @@ struct fsxattr {
> >  #define FS_IOC32_SETVERSION		_IOW('v', 2, int)
> >  #define FS_IOC_FSGETXATTR		_IOR('X', 31, struct fsxattr)
> >  #define FS_IOC_FSSETXATTR		_IOW('X', 32, struct fsxattr)
> > +#define FS_IOC_FSGETXATTRAT		_IOR('X', 33, struct fsxattrat)
> > +#define FS_IOC_FSSETXATTRAT		_IOW('X', 34, struct fsxattrat)
> >  #define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
> >  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
> >  /* Returns the external filesystem UUID, the same one blkid returns */
> > -- 
> > 2.42.0
> > 
> > 
> 

-- 
- Andrey


