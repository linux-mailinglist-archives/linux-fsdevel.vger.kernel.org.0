Return-Path: <linux-fsdevel+bounces-19932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61F58CB375
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1498A1C21555
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50648148318;
	Tue, 21 May 2024 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFxNiiyv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C27F7CE;
	Tue, 21 May 2024 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315776; cv=none; b=KKYwcf+wD1qAmDjmHQOZPgW65Huy9ldPCcInb0CgnAtHLc59Pre11kkD4+q6IK2up9ZVwRIABBXz29l5p/2+Q5AQrDHA7oytXKVXUIZz3JaNw4pYskQllidISgg2gvWTWUWlEjZmuiJiUk0oD6vij1ETZ1lGTKnc1sO+4uK4VJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315776; c=relaxed/simple;
	bh=Q1eSSACPrLt9AikA9Wp5pxYtzBBHmnJxep7VNgvdAfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+x5HbXNKoAqbNHuWkngiZRd1bs+CnF1nzZK4NESxyKlxcAqFrPQi3IrRUDjna62RcukoXusjkLzb8Qt98vXWWITCKYy3Y9lF/o/BTDV3M3klcq1N6dFpN+ijIt0xhEASqTBZAmwoaAJvrdhOhnA4/6Q4UH9bGA0AmOpyxR+AVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFxNiiyv; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-69b6c2e9ed9so15232786d6.1;
        Tue, 21 May 2024 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716315774; x=1716920574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2phjhcA1LF6qdjoEbuyC81vJIuXI9sEaOs7PMDVYOQM=;
        b=CFxNiiyvTdeXf0CZhcQPR7ZiGcrBWeTyifZtxISHUcLtYPCL0jHwUD/H+r0ySvHwQk
         zzzaf6sLGTl3+HzxrxXWdqYyAicRx7YyyafuJl6KUQGaee7hvYLYPyDrHjoKMEn4MXPo
         R7/JocTKRcL6Nt4gIr4swuuiiwmM4Qx1dTvDy0VQ+40ndTd488NV/f1P24ZRC75XRHIP
         DH/xG5mIBIhjKR0VPNFrm4arwqQl5unG902/BZCMncUg6tZgxAyArr5++i02gg4bC6Zf
         FsyQgRXWA1wMcTYf7oqZGqIVjpbdSBq4qunMZlrl3qmiQwxtbSrq4rCZm5UShBUdKESj
         uPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716315774; x=1716920574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2phjhcA1LF6qdjoEbuyC81vJIuXI9sEaOs7PMDVYOQM=;
        b=htGG/x4MN1cEY80Lt5obRgZrtzJqV/21lo7x+WhtAkXWG06ymhS5QNLmSz+6IAtQT1
         Ltx1/RKDmaGplBWM02J12Wfqf/TRt5tNhe/lKXuqH5anBchMScijxpD+0WhDy79xTIYm
         E8DTp/CB9gP5qCv4PWPHBXpVWRznjtje1viwBx8HmCPG0HL03yEJlklUvBpEeBz9n8Wh
         iZtWDEoNHlY/CZMcXjsjy1aR7ppKtqGsmPN9qjVZJF5+gAxQz5hjJ/b0A4Fhvf0eqdOz
         eZfG2xxsCXZF0p3VZW70B642+n7/mpQHid1HUzRWVNcpTXxsF7DQYZfSUHEgN13n5x0q
         uAxg==
X-Forwarded-Encrypted: i=1; AJvYcCVY0dvXAlKRa2dPVRkXn2mHQ86ha/vG+5BXsab77paWxsK0DQua+CM39joqraZIWF6Ie2n52j3NTy0qCdee0iEPpPE/On4Gjk7g
X-Gm-Message-State: AOJu0Yxi4Hi2b2EDULzy7y5OOCyPGXVcMoiR6Y3LobJ78Aqf4H70Sz3x
	pfyOxvZdgrNsb2pgjXd1YYbtJxd3aoTXIck2WPuvMYXg569xOobY8c6XLR1XNNSpt6CKjNQT7YP
	BfyR/BmCxg1XhHjMYufCOoNLqamLuaQzo
X-Google-Smtp-Source: AGHT+IEOfvvLVIbJowOBkYP5nuidQjPgdN55js9yNZKVyww9rX9ppgBwK2ZshJMa2xZgmhw28WA7s3cuNV3JHQ7XB4g=
X-Received: by 2002:a05:6214:bd0:b0:6a3:4bbc:9b66 with SMTP id
 6a1803df08f44-6a34bbca59amr172565536d6.10.1716315773844; Tue, 21 May 2024
 11:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520164624.665269-2-aalbersh@redhat.com> <20240520164624.665269-4-aalbersh@redhat.com>
 <CAOQ4uxikMjmAkXwGk3d9897622JfkeE8LXaT9PBrtTiR5y3=Rg@mail.gmail.com> <z6ctkxtwhwioc5a5kzisjxffkde6xpchstrr3zlflh4bsz4mpd@5z2s2d7lbje5>
In-Reply-To: <z6ctkxtwhwioc5a5kzisjxffkde6xpchstrr3zlflh4bsz4mpd@5z2s2d7lbje5>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 May 2024 21:22:41 +0300
Message-ID: <CAOQ4uxjaLbrmSDk_a_M6YDT5tQoHO=dXTDsHVOSYcMxeQnpP1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and FS_IOC_FSGETXATTRAT
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 7:34=E2=80=AFPM Andrey Albershteyn <aalbersh@redhat=
.com> wrote:
>
> On 2024-05-20 22:03:43, Amir Goldstein wrote:
> > On Mon, May 20, 2024 at 7:46=E2=80=AFPM Andrey Albershteyn <aalbersh@re=
dhat.com> wrote:
> > >
> > > XFS has project quotas which could be attached to a directory. All
> > > new inodes in these directories inherit project ID set on parent
> > > directory.
> > >
> > > The project is created from userspace by opening and calling
> > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > files such as FIFO, SOCK, BLK etc. as opening them returns a special
> > > inode from VFS. Therefore, some inodes are left with empty project
> > > ID. Those inodes then are not shown in the quota accounting but
> > > still exist in the directory.
> > >
> > > This patch adds two new ioctls which allows userspace, such as
> > > xfs_quota, to set project ID on special files by using parent
> > > directory to open FS inode. This will let xfs_quota set ID on all
> > > inodes and also reset it when project is removed. Also, as
> > > vfs_fileattr_set() is now will called on special files too, let's
> > > forbid any other attributes except projid and nextents (symlink can
> > > have one).
> > >
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > ---
> > >  fs/ioctl.c              | 93 +++++++++++++++++++++++++++++++++++++++=
++
> > >  include/uapi/linux/fs.h | 11 +++++
> > >  2 files changed, 104 insertions(+)
> > >
> > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > index 1d5abfdf0f22..3e3aacb6ea6e 100644
> > > --- a/fs/ioctl.c
> > > +++ b/fs/ioctl.c
> > > @@ -22,6 +22,7 @@
> > >  #include <linux/mount.h>
> > >  #include <linux/fscrypt.h>
> > >  #include <linux/fileattr.h>
> > > +#include <linux/namei.h>
> > >
> > >  #include "internal.h"
> > >
> > > @@ -647,6 +648,19 @@ static int fileattr_set_prepare(struct inode *in=
ode,
> > >         if (fa->fsx_cowextsize =3D=3D 0)
> > >                 fa->fsx_xflags &=3D ~FS_XFLAG_COWEXTSIZE;
> > >
> > > +       /*
> > > +        * The only use case for special files is to set project ID, =
forbid any
> > > +        * other attributes
> > > +        */
> > > +       if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
> > > +               if (fa->fsx_xflags & ~FS_XFLAG_PROJINHERIT)
> > > +                       return -EINVAL;
> > > +               if (!S_ISLNK(inode->i_mode) && fa->fsx_nextents)
> > > +                       return -EINVAL;
> > > +               if (fa->fsx_extsize || fa->fsx_cowextsize)
> > > +                       return -EINVAL;
> > > +       }
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -763,6 +777,79 @@ static int ioctl_fssetxattr(struct file *file, v=
oid __user *argp)
> > >         return err;
> > >  }
> > >
> > > +static int ioctl_fsgetxattrat(struct file *file, void __user *argp)
> > > +{
> > > +       struct path filepath;
> > > +       struct fsxattrat fsxat;
> > > +       struct fileattr fa;
> > > +       int error;
> > > +
> > > +       if (!S_ISDIR(file_inode(file)->i_mode))
> > > +               return -EBADF;
> >
> > So the *only* thing that is done with the fd of the ioctl is to verify
> > that it is a directory fd - there is no verification that this fd is on=
 the
> > same sb as the path to act on.
> >
> > Was this the intention? It does not make a lot of sense to me
> > and AFAIK there is no precedent to an API like this.
>
> yeah, as we want to set xattrs on that inode the path is pointing
> to, so, VFS will call to the FS under that sb.
>
> >
> > There are ioctls that operate on the filesystem using any
> > fd on that fs, such as FS_IOC_GETFS{UUID,SYSFSPATH}
> > and maybe the closest example to what you are trying to add
> > XFS_IOC_BULKSTAT.
>
> Not sure that I get what you mean here, the *at() part is to get
> around VFS special inodes and call vfs_fileattr_set/get on FS inodes.
>

My point was that with your proposed API the fd argument to
ioctl() can be a directory from a completely arbitrary filesystem
with nothing to do with the filesystem where fsxat.dfd is from
and that makes very little sense from API POV.

> >
> > Trying to think of a saner API for this - perhaps pass an O_PATH
> > fd without any filename in struct fsxattrat, saving you also the
> > headache of passing a variable length string in an ioctl.
> >
> > Then atfile =3D fdget_raw(fsxat.atfd) and verify that atfile->f_path
> > and file->f_path are on the same sb before proceeding to operate
> > on atfile->f_path.dentry.
>
> Thanks! Didn't know about O_PATH that seems to be a way to get rid
> of the path passing.
>

I found one precedent of this pattern with XFS_IOC_FD_TO_HANDLE,
but keep in mind that this is quite an old legacy XFS API.

This ioctl is performed on an "fshandle", which is an open fd to any
object in the filesystem, but typically the mount root dir.
The ioctl gets a structure xfs_fsop_handlereq_t which contains an
fd member pointing to another object within an XFS filesystem.

Actually, AFAICS, this code does not verify that the object and fshandle
are on the same XFS filesystem, but only that both are on XFS filesystems:

        /*
         * We can only generate handles for inodes residing on a XFS filesy=
stem,
         * and only for regular files, directories or symbolic links.
         */
        error =3D -EINVAL;
        if (inode->i_sb->s_magic !=3D XFS_SB_MAGIC)
                goto out_put;

I don't know what's the best thing to do is, but I think that verifying
that the ioctl fd and the O_PATH fd are on the same sb is the least
controversial option for the first version - if needed that could be
relaxed later on.

Another alternative which is simpler from API POV would be to allow
selective ioctl() commands on an O_PATH fd, but I think that is going
to be more controversial.

Something along those lines (completely untested):

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 45e4e64fd664..562f8bff91d2 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -241,6 +241,13 @@ struct fsxattr {
  */
 #define FS_IOC_GETFSSYSFSPATH          _IOR(0x15, 1, struct fs_sysfs_path)

+#define _IOC_AT                                (0x100)
+#define FS_IOC_AT(nr)                  (_IOC_TYPE(nr) =3D=3D _IOC_AT)
+
+/* The following ioctls can be operated on an O_PATH fd */
+#define FS_IOC_FSGETXATTRAT            _IOR(_IOC_AT, 31, struct fsxattr)
+#define FS_IOC_FSSETXATTRAT            _IOW(_IOC_AT, 32, struct fsxattr)
+
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
  *
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1d5abfdf0f22..f720500c705b 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -867,9 +867,11 @@ static int do_vfs_ioctl(struct file *filp, unsigned in=
t fd,
                return ioctl_setflags(filp, argp);

        case FS_IOC_FSGETXATTR:
+       case FS_IOC_FSGETXATTRAT:
                return ioctl_fsgetxattr(filp, argp);

        case FS_IOC_FSSETXATTR:
+       case FS_IOC_FSSETXATTRAT:
                return ioctl_fssetxattr(filp, argp);

        case FS_IOC_GETFSUUID:
@@ -879,7 +881,7 @@ static int do_vfs_ioctl(struct file *filp, unsigned int=
 fd,
                return ioctl_get_fs_sysfs_path(filp, argp);

        default:
-               if (S_ISREG(inode->i_mode))
+               if (!FS_IOC_AT(cmd) && S_ISREG(inode->i_mode))
                        return file_ioctl(filp, cmd, argp);
                break;
        }
@@ -889,7 +891,8 @@ static int do_vfs_ioctl(struct file *filp, unsigned int=
 fd,

 SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long,=
 arg)
 {
-       struct fd f =3D fdget(fd);
+       bool ioc_at =3D FS_IOC_AT(cmd);
+       struct fd f =3D ioc_at ? fdget_raw(fd) : fdget(fd);
        int error;

        if (!f.file)
@@ -900,7 +903,7 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned
int, cmd, unsigned long, arg)
                goto out;

        error =3D do_vfs_ioctl(f.file, fd, cmd, arg);
-       if (error =3D=3D -ENOIOCTLCMD)
+       if (!ioc_at && error =3D=3D -ENOIOCTLCMD)
                error =3D vfs_ioctl(f.file, cmd, arg);

---

Thanks,
Amir.

