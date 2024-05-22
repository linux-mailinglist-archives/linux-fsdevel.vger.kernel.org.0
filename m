Return-Path: <linux-fsdevel+bounces-20006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D5D8CC4E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 18:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226F81C2180E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54201140E4D;
	Wed, 22 May 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvR1IyIG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF6C13D8AA;
	Wed, 22 May 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395334; cv=none; b=H1D0UvltkYg6wBy8Bbnjwq6XyTfcQTxwl375/wyJbOW3ttQc0LXEHXdqQFUEsyzCIn6WDIowWrZasuZV4r+n57gV1EcXUBwdo2ju+5Dn4hXoIQbmxTpdk7QAd0Hb091v/CmfdkuB+gcr08QdlwuHHeg19pl2OduArZmhdPBNjJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395334; c=relaxed/simple;
	bh=QBEABlXzxSsRtovEhpMQ/ynDNOIOsW+aKSVcQYlcOtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiFJPhUAi2QeALt9q8PB+b9c7VHlRr1l045ESfrQRrj8sWhBPQuXoN8/fAotdshx9dBLy+4WsMsmSOCNV0aTSby/yM5YZDMQ0lV4I/6bGrrWc0Q65p3YMy9iWTIk8z4JwOnmTyf7gPZf6kTysuiKte2RNRXRMEgTUokvUKDxncQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvR1IyIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18865C2BBFC;
	Wed, 22 May 2024 16:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716395334;
	bh=QBEABlXzxSsRtovEhpMQ/ynDNOIOsW+aKSVcQYlcOtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvR1IyIGOnrSA6Ho0zK3RnLDModWpXuUfIQOSSMCOmZX9K0+V5GKPLH+ax3Fky33C
	 bJBCjbmyvHMhIBOlefNpbrXRF1wbnq0e5AjX1W+Jv/4ERb5zLbvke0E+TCXTrlIYmw
	 LQzERabIR1Oi/RK2KMyzyi1lC+oUIoym8gKtBkS2LMnKT62VF2x7IDzvvq6d+nU56L
	 qOr4us3+iNxqAGlZlNMWpFfVR2TeZOp6AEaXTzXvKi79F3zgGIQWTpW6aeGbsKRi21
	 lcf+sKn5NlhOD6Oz+7h1WkEu9E13tOYt1klElIHxFvgte79QCYqNLxaUm07eO6WEps
	 2jSX9SM2nQ+KA==
Date: Wed, 22 May 2024 09:28:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <20240522162853.GW25518@frogsfrogsfrogs>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <CAOQ4uxikMjmAkXwGk3d9897622JfkeE8LXaT9PBrtTiR5y3=Rg@mail.gmail.com>
 <z6ctkxtwhwioc5a5kzisjxffkde6xpchstrr3zlflh4bsz4mpd@5z2s2d7lbje5>
 <CAOQ4uxjaLbrmSDk_a_M6YDT5tQoHO=dXTDsHVOSYcMxeQnpP1w@mail.gmail.com>
 <3b7opex4hgm3ed6v24m7k4oagp2gnsjms45yq223u2nnrbvicx@bgoqeylzxelj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b7opex4hgm3ed6v24m7k4oagp2gnsjms45yq223u2nnrbvicx@bgoqeylzxelj>

On Wed, May 22, 2024 at 04:58:31PM +0200, Andrey Albershteyn wrote:
> On 2024-05-21 21:22:41, Amir Goldstein wrote:
> > On Tue, May 21, 2024 at 7:34 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> > >
> > > On 2024-05-20 22:03:43, Amir Goldstein wrote:
> > > > On Mon, May 20, 2024 at 7:46 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> > > > >
> > > > > XFS has project quotas which could be attached to a directory. All
> > > > > new inodes in these directories inherit project ID set on parent
> > > > > directory.
> > > > >
> > > > > The project is created from userspace by opening and calling
> > > > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > > > files such as FIFO, SOCK, BLK etc. as opening them returns a special
> > > > > inode from VFS. Therefore, some inodes are left with empty project
> > > > > ID. Those inodes then are not shown in the quota accounting but
> > > > > still exist in the directory.
> > > > >
> > > > > This patch adds two new ioctls which allows userspace, such as
> > > > > xfs_quota, to set project ID on special files by using parent
> > > > > directory to open FS inode. This will let xfs_quota set ID on all
> > > > > inodes and also reset it when project is removed. Also, as
> > > > > vfs_fileattr_set() is now will called on special files too, let's
> > > > > forbid any other attributes except projid and nextents (symlink can
> > > > > have one).
> > > > >
> > > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > > ---
> > > > >  fs/ioctl.c              | 93 +++++++++++++++++++++++++++++++++++++++++
> > > > >  include/uapi/linux/fs.h | 11 +++++
> > > > >  2 files changed, 104 insertions(+)
> > > > >
> > > > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > > > index 1d5abfdf0f22..3e3aacb6ea6e 100644
> > > > > --- a/fs/ioctl.c
> > > > > +++ b/fs/ioctl.c
> > > > > @@ -22,6 +22,7 @@
> > > > >  #include <linux/mount.h>
> > > > >  #include <linux/fscrypt.h>
> > > > >  #include <linux/fileattr.h>
> > > > > +#include <linux/namei.h>
> > > > >
> > > > >  #include "internal.h"
> > > > >
> > > > > @@ -647,6 +648,19 @@ static int fileattr_set_prepare(struct inode *inode,
> > > > >         if (fa->fsx_cowextsize == 0)
> > > > >                 fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> > > > >
> > > > > +       /*
> > > > > +        * The only use case for special files is to set project ID, forbid any
> > > > > +        * other attributes
> > > > > +        */
> > > > > +       if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
> > > > > +               if (fa->fsx_xflags & ~FS_XFLAG_PROJINHERIT)
> > > > > +                       return -EINVAL;
> > > > > +               if (!S_ISLNK(inode->i_mode) && fa->fsx_nextents)
> > > > > +                       return -EINVAL;
> > > > > +               if (fa->fsx_extsize || fa->fsx_cowextsize)
> > > > > +                       return -EINVAL;
> > > > > +       }
> > > > > +
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > @@ -763,6 +777,79 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
> > > > >         return err;
> > > > >  }
> > > > >
> > > > > +static int ioctl_fsgetxattrat(struct file *file, void __user *argp)
> > > > > +{
> > > > > +       struct path filepath;
> > > > > +       struct fsxattrat fsxat;
> > > > > +       struct fileattr fa;
> > > > > +       int error;
> > > > > +
> > > > > +       if (!S_ISDIR(file_inode(file)->i_mode))
> > > > > +               return -EBADF;
> > > >
> > > > So the *only* thing that is done with the fd of the ioctl is to verify
> > > > that it is a directory fd - there is no verification that this fd is on the
> > > > same sb as the path to act on.
> > > >
> > > > Was this the intention? It does not make a lot of sense to me
> > > > and AFAIK there is no precedent to an API like this.
> > >
> > > yeah, as we want to set xattrs on that inode the path is pointing
> > > to, so, VFS will call to the FS under that sb.
> > >
> > > >
> > > > There are ioctls that operate on the filesystem using any
> > > > fd on that fs, such as FS_IOC_GETFS{UUID,SYSFSPATH}
> > > > and maybe the closest example to what you are trying to add
> > > > XFS_IOC_BULKSTAT.
> > >
> > > Not sure that I get what you mean here, the *at() part is to get
> > > around VFS special inodes and call vfs_fileattr_set/get on FS inodes.
> > >
> > 
> > My point was that with your proposed API the fd argument to
> > ioctl() can be a directory from a completely arbitrary filesystem
> > with nothing to do with the filesystem where fsxat.dfd is from
> > and that makes very little sense from API POV.
> 
> I see, yeah, I can add a check for this, for xfs_quota usecase it's
> fine as it doesn't follow cross mounts.

Do the other *at() syscalls prohibit dfd + path pointing to a different
filesystem?  It seems odd to have this restriction that the rest don't,
but perhaps documenting this in the ioctl_xfs_fsgetxattrat manpage is ok.

--D

> > 
> > > >
> > > > Trying to think of a saner API for this - perhaps pass an O_PATH
> > > > fd without any filename in struct fsxattrat, saving you also the
> > > > headache of passing a variable length string in an ioctl.
> > > >
> > > > Then atfile = fdget_raw(fsxat.atfd) and verify that atfile->f_path
> > > > and file->f_path are on the same sb before proceeding to operate
> > > > on atfile->f_path.dentry.
> > >
> > > Thanks! Didn't know about O_PATH that seems to be a way to get rid
> > > of the path passing.
> > >
> > 
> > I found one precedent of this pattern with XFS_IOC_FD_TO_HANDLE,
> > but keep in mind that this is quite an old legacy XFS API.
> > 
> > This ioctl is performed on an "fshandle", which is an open fd to any
> > object in the filesystem, but typically the mount root dir.
> > The ioctl gets a structure xfs_fsop_handlereq_t which contains an
> > fd member pointing to another object within an XFS filesystem.
> > 
> > Actually, AFAICS, this code does not verify that the object and fshandle
> > are on the same XFS filesystem, but only that both are on XFS filesystems:
> > 
> >         /*
> >          * We can only generate handles for inodes residing on a XFS filesystem,
> >          * and only for regular files, directories or symbolic links.
> >          */
> >         error = -EINVAL;
> >         if (inode->i_sb->s_magic != XFS_SB_MAGIC)
> >                 goto out_put;
> > 
> > I don't know what's the best thing to do is, but I think that verifying
> > that the ioctl fd and the O_PATH fd are on the same sb is the least
> > controversial option for the first version - if needed that could be
> > relaxed later on.
> > 
> > Another alternative which is simpler from API POV would be to allow
> > selective ioctl() commands on an O_PATH fd, but I think that is going
> > to be more controversial.
> > 
> > Something along those lines (completely untested):
> > 
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 45e4e64fd664..562f8bff91d2 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -241,6 +241,13 @@ struct fsxattr {
> >   */
> >  #define FS_IOC_GETFSSYSFSPATH          _IOR(0x15, 1, struct fs_sysfs_path)
> > 
> > +#define _IOC_AT                                (0x100)
> > +#define FS_IOC_AT(nr)                  (_IOC_TYPE(nr) == _IOC_AT)
> > +
> > +/* The following ioctls can be operated on an O_PATH fd */
> > +#define FS_IOC_FSGETXATTRAT            _IOR(_IOC_AT, 31, struct fsxattr)
> > +#define FS_IOC_FSSETXATTRAT            _IOW(_IOC_AT, 32, struct fsxattr)
> > +
> >  /*
> >   * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
> >   *
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 1d5abfdf0f22..f720500c705b 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -867,9 +867,11 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
> >                 return ioctl_setflags(filp, argp);
> > 
> >         case FS_IOC_FSGETXATTR:
> > +       case FS_IOC_FSGETXATTRAT:
> >                 return ioctl_fsgetxattr(filp, argp);
> > 
> >         case FS_IOC_FSSETXATTR:
> > +       case FS_IOC_FSSETXATTRAT:
> >                 return ioctl_fssetxattr(filp, argp);
> > 
> >         case FS_IOC_GETFSUUID:
> > @@ -879,7 +881,7 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
> >                 return ioctl_get_fs_sysfs_path(filp, argp);
> > 
> >         default:
> > -               if (S_ISREG(inode->i_mode))
> > +               if (!FS_IOC_AT(cmd) && S_ISREG(inode->i_mode))
> >                         return file_ioctl(filp, cmd, argp);
> >                 break;
> >         }
> > @@ -889,7 +891,8 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
> > 
> >  SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
> >  {
> > -       struct fd f = fdget(fd);
> > +       bool ioc_at = FS_IOC_AT(cmd);
> > +       struct fd f = ioc_at ? fdget_raw(fd) : fdget(fd);
> >         int error;
> > 
> >         if (!f.file)
> > @@ -900,7 +903,7 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned
> > int, cmd, unsigned long, arg)
> >                 goto out;
> > 
> >         error = do_vfs_ioctl(f.file, fd, cmd, arg);
> > -       if (error == -ENOIOCTLCMD)
> > +       if (!ioc_at && error == -ENOIOCTLCMD)
> >                 error = vfs_ioctl(f.file, cmd, arg);
> > 
> > ---
> > 
> > Thanks,
> > Amir.
> > 
> 
> -- 
> - Andrey
> 
> 

