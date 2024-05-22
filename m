Return-Path: <linux-fsdevel+bounces-20003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6818CC3A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 16:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0973E1C213C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6720DF4;
	Wed, 22 May 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvE/NVZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A247A1E4AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389920; cv=none; b=Cs4TEYO4c+6QnDKkzFfdxejQzB4THt3snyXIjjnWXaB5s8Qr/tZgclPbSbJk6Ntwk6MuWXAhSVt/42ba9GAe0n8tJHr29gYLcKeGI2XcxnHy2NeL3AOZb+uM2KxXJuGiru9VTYvrQqy5dVrtvQ01YRx9lkPBTbCt7qZCGn/YsKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389920; c=relaxed/simple;
	bh=ftpqoK7on871MqKfL87kMTnQDGEccrvbdsvCH3DYM1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQB/hpv2UWWx255QpJyJM7yWpIzWqTEihxGbJDeLNUlHu6OctLUgKZQS0d+ejIA3tbbFjK0stZfCDiwMerVgGxsEHWLuZYdoKjvvq4MA4VoycZK308mKuQVGcj6D3DnxQedAx1ugjALTlO40efdB/LgSl6bB+AX/fyAhvO2bOu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvE/NVZY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716389917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GO5vgjE1NuIxL7sHov64TT+pxpGpi/7IXaLGihculUw=;
	b=GvE/NVZY95fB67gNWYqC1cOXFwk0P6Y32V6R8u+BCuCmjg9tYdBEtteTq+uYn0CHlHEUwT
	Hg8PhEQfft0PO7zxoRzCRKcKtOeB8dZFb0U1VPCeu0cOeL/fnsGUSd8Y3MLTcqlzXdbA2w
	5VSAWE+6SzVSMJgI1eHLK9F/r15+9gI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-UA7stsqBOF6xfkxYYuVe2A-1; Wed, 22 May 2024 10:58:36 -0400
X-MC-Unique: UA7stsqBOF6xfkxYYuVe2A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41fd5cad55cso69484775e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 07:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716389915; x=1716994715;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GO5vgjE1NuIxL7sHov64TT+pxpGpi/7IXaLGihculUw=;
        b=k7RESMucPsm6AtWHBV7K/hMNWzKuUBBFOwYL8J5I4cldRrKC9kdBUkLEBwPDgHrEiz
         Un5HoNcm5Jg6VJrZS4L7qpQvQFTVL/HcnYbzp3XAVC2y62zEJ297X03/S/cBt7/myU0P
         peD89IZsO05uFtFbONC2H4WVuJIeyORi4Q6Hu2qQ9Ybkg50+u/ax8QopxjQW9Bv50asO
         kaUT/t7fI8MPUN2I0qQ/ju2MXmtwZ8yZNhr8OBccgMr7tPFR5aXqpx92COcMWoQqs3zf
         L3hNDpYhC+Rjq5ZaOWE0nGv067JKrO7j+gAhvbVlRES4dGIzLSGredNINDritcajvV4q
         D2/w==
X-Gm-Message-State: AOJu0YwmG3ZabkW0gOwc/KDh+AUJBJSRjB3Szfqim6rmIWNlWHUEvPwp
	N9VPKshCUl/DqDvoDLXVUgqCE8z04pdm0HJDebO5O4MgkNgURBvSFL4v9td0N/urK0xzL9HM/M+
	IbvbwdJ2Wu8FHVIV5ajXQcR9ARVgfJrOk228zwI5V2wJIxz7OGUz5vxdJgp6BFA==
X-Received: by 2002:a7b:cc07:0:b0:41f:eba9:ced4 with SMTP id 5b1f17b1804b1-420fd30e4a5mr18733505e9.16.1716389914533;
        Wed, 22 May 2024 07:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRW737x5bUSpR2/iAJ4m2mfhNhbzICWIz8wJlA5eTb9nvGp64XmY5unIJ+oI5UIkKGTycO1g==
X-Received: by 2002:a7b:cc07:0:b0:41f:eba9:ced4 with SMTP id 5b1f17b1804b1-420fd30e4a5mr18733185e9.16.1716389913890;
        Wed, 22 May 2024 07:58:33 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce1912sm504595835e9.11.2024.05.22.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 07:58:33 -0700 (PDT)
Date: Wed, 22 May 2024 16:58:31 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <3b7opex4hgm3ed6v24m7k4oagp2gnsjms45yq223u2nnrbvicx@bgoqeylzxelj>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <CAOQ4uxikMjmAkXwGk3d9897622JfkeE8LXaT9PBrtTiR5y3=Rg@mail.gmail.com>
 <z6ctkxtwhwioc5a5kzisjxffkde6xpchstrr3zlflh4bsz4mpd@5z2s2d7lbje5>
 <CAOQ4uxjaLbrmSDk_a_M6YDT5tQoHO=dXTDsHVOSYcMxeQnpP1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjaLbrmSDk_a_M6YDT5tQoHO=dXTDsHVOSYcMxeQnpP1w@mail.gmail.com>

On 2024-05-21 21:22:41, Amir Goldstein wrote:
> On Tue, May 21, 2024 at 7:34 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> >
> > On 2024-05-20 22:03:43, Amir Goldstein wrote:
> > > On Mon, May 20, 2024 at 7:46 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> > > >
> > > > XFS has project quotas which could be attached to a directory. All
> > > > new inodes in these directories inherit project ID set on parent
> > > > directory.
> > > >
> > > > The project is created from userspace by opening and calling
> > > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > > files such as FIFO, SOCK, BLK etc. as opening them returns a special
> > > > inode from VFS. Therefore, some inodes are left with empty project
> > > > ID. Those inodes then are not shown in the quota accounting but
> > > > still exist in the directory.
> > > >
> > > > This patch adds two new ioctls which allows userspace, such as
> > > > xfs_quota, to set project ID on special files by using parent
> > > > directory to open FS inode. This will let xfs_quota set ID on all
> > > > inodes and also reset it when project is removed. Also, as
> > > > vfs_fileattr_set() is now will called on special files too, let's
> > > > forbid any other attributes except projid and nextents (symlink can
> > > > have one).
> > > >
> > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > ---
> > > >  fs/ioctl.c              | 93 +++++++++++++++++++++++++++++++++++++++++
> > > >  include/uapi/linux/fs.h | 11 +++++
> > > >  2 files changed, 104 insertions(+)
> > > >
> > > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > > index 1d5abfdf0f22..3e3aacb6ea6e 100644
> > > > --- a/fs/ioctl.c
> > > > +++ b/fs/ioctl.c
> > > > @@ -22,6 +22,7 @@
> > > >  #include <linux/mount.h>
> > > >  #include <linux/fscrypt.h>
> > > >  #include <linux/fileattr.h>
> > > > +#include <linux/namei.h>
> > > >
> > > >  #include "internal.h"
> > > >
> > > > @@ -647,6 +648,19 @@ static int fileattr_set_prepare(struct inode *inode,
> > > >         if (fa->fsx_cowextsize == 0)
> > > >                 fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> > > >
> > > > +       /*
> > > > +        * The only use case for special files is to set project ID, forbid any
> > > > +        * other attributes
> > > > +        */
> > > > +       if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
> > > > +               if (fa->fsx_xflags & ~FS_XFLAG_PROJINHERIT)
> > > > +                       return -EINVAL;
> > > > +               if (!S_ISLNK(inode->i_mode) && fa->fsx_nextents)
> > > > +                       return -EINVAL;
> > > > +               if (fa->fsx_extsize || fa->fsx_cowextsize)
> > > > +                       return -EINVAL;
> > > > +       }
> > > > +
> > > >         return 0;
> > > >  }
> > > >
> > > > @@ -763,6 +777,79 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
> > > >         return err;
> > > >  }
> > > >
> > > > +static int ioctl_fsgetxattrat(struct file *file, void __user *argp)
> > > > +{
> > > > +       struct path filepath;
> > > > +       struct fsxattrat fsxat;
> > > > +       struct fileattr fa;
> > > > +       int error;
> > > > +
> > > > +       if (!S_ISDIR(file_inode(file)->i_mode))
> > > > +               return -EBADF;
> > >
> > > So the *only* thing that is done with the fd of the ioctl is to verify
> > > that it is a directory fd - there is no verification that this fd is on the
> > > same sb as the path to act on.
> > >
> > > Was this the intention? It does not make a lot of sense to me
> > > and AFAIK there is no precedent to an API like this.
> >
> > yeah, as we want to set xattrs on that inode the path is pointing
> > to, so, VFS will call to the FS under that sb.
> >
> > >
> > > There are ioctls that operate on the filesystem using any
> > > fd on that fs, such as FS_IOC_GETFS{UUID,SYSFSPATH}
> > > and maybe the closest example to what you are trying to add
> > > XFS_IOC_BULKSTAT.
> >
> > Not sure that I get what you mean here, the *at() part is to get
> > around VFS special inodes and call vfs_fileattr_set/get on FS inodes.
> >
> 
> My point was that with your proposed API the fd argument to
> ioctl() can be a directory from a completely arbitrary filesystem
> with nothing to do with the filesystem where fsxat.dfd is from
> and that makes very little sense from API POV.

I see, yeah, I can add a check for this, for xfs_quota usecase it's
fine as it doesn't follow cross mounts.

> 
> > >
> > > Trying to think of a saner API for this - perhaps pass an O_PATH
> > > fd without any filename in struct fsxattrat, saving you also the
> > > headache of passing a variable length string in an ioctl.
> > >
> > > Then atfile = fdget_raw(fsxat.atfd) and verify that atfile->f_path
> > > and file->f_path are on the same sb before proceeding to operate
> > > on atfile->f_path.dentry.
> >
> > Thanks! Didn't know about O_PATH that seems to be a way to get rid
> > of the path passing.
> >
> 
> I found one precedent of this pattern with XFS_IOC_FD_TO_HANDLE,
> but keep in mind that this is quite an old legacy XFS API.
> 
> This ioctl is performed on an "fshandle", which is an open fd to any
> object in the filesystem, but typically the mount root dir.
> The ioctl gets a structure xfs_fsop_handlereq_t which contains an
> fd member pointing to another object within an XFS filesystem.
> 
> Actually, AFAICS, this code does not verify that the object and fshandle
> are on the same XFS filesystem, but only that both are on XFS filesystems:
> 
>         /*
>          * We can only generate handles for inodes residing on a XFS filesystem,
>          * and only for regular files, directories or symbolic links.
>          */
>         error = -EINVAL;
>         if (inode->i_sb->s_magic != XFS_SB_MAGIC)
>                 goto out_put;
> 
> I don't know what's the best thing to do is, but I think that verifying
> that the ioctl fd and the O_PATH fd are on the same sb is the least
> controversial option for the first version - if needed that could be
> relaxed later on.
> 
> Another alternative which is simpler from API POV would be to allow
> selective ioctl() commands on an O_PATH fd, but I think that is going
> to be more controversial.
> 
> Something along those lines (completely untested):
> 
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 45e4e64fd664..562f8bff91d2 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -241,6 +241,13 @@ struct fsxattr {
>   */
>  #define FS_IOC_GETFSSYSFSPATH          _IOR(0x15, 1, struct fs_sysfs_path)
> 
> +#define _IOC_AT                                (0x100)
> +#define FS_IOC_AT(nr)                  (_IOC_TYPE(nr) == _IOC_AT)
> +
> +/* The following ioctls can be operated on an O_PATH fd */
> +#define FS_IOC_FSGETXATTRAT            _IOR(_IOC_AT, 31, struct fsxattr)
> +#define FS_IOC_FSSETXATTRAT            _IOW(_IOC_AT, 32, struct fsxattr)
> +
>  /*
>   * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
>   *
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1d5abfdf0f22..f720500c705b 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -867,9 +867,11 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
>                 return ioctl_setflags(filp, argp);
> 
>         case FS_IOC_FSGETXATTR:
> +       case FS_IOC_FSGETXATTRAT:
>                 return ioctl_fsgetxattr(filp, argp);
> 
>         case FS_IOC_FSSETXATTR:
> +       case FS_IOC_FSSETXATTRAT:
>                 return ioctl_fssetxattr(filp, argp);
> 
>         case FS_IOC_GETFSUUID:
> @@ -879,7 +881,7 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
>                 return ioctl_get_fs_sysfs_path(filp, argp);
> 
>         default:
> -               if (S_ISREG(inode->i_mode))
> +               if (!FS_IOC_AT(cmd) && S_ISREG(inode->i_mode))
>                         return file_ioctl(filp, cmd, argp);
>                 break;
>         }
> @@ -889,7 +891,8 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
> 
>  SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
>  {
> -       struct fd f = fdget(fd);
> +       bool ioc_at = FS_IOC_AT(cmd);
> +       struct fd f = ioc_at ? fdget_raw(fd) : fdget(fd);
>         int error;
> 
>         if (!f.file)
> @@ -900,7 +903,7 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned
> int, cmd, unsigned long, arg)
>                 goto out;
> 
>         error = do_vfs_ioctl(f.file, fd, cmd, arg);
> -       if (error == -ENOIOCTLCMD)
> +       if (!ioc_at && error == -ENOIOCTLCMD)
>                 error = vfs_ioctl(f.file, cmd, arg);
> 
> ---
> 
> Thanks,
> Amir.
> 

-- 
- Andrey


