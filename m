Return-Path: <linux-fsdevel+bounces-19828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6357C8CA295
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 21:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2AD1B22EA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 19:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8A41386BD;
	Mon, 20 May 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjvqaWdk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D451C137C27;
	Mon, 20 May 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231943; cv=none; b=sIEHSJbuVHoUToodyQo70Z+Kbi212XOmHnzYL5FoG7pPBA98oStKrWkRLKYmd+P5yYdHJYj5yz6k1jHKaLslSwllU8xdKL05ftqHKIqmeUpvnODT6cvAcwQEfFwElJwJVxVnqVWDRedl+GnS9QZI84u3D0NfVmCbhdLyXOgyGCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231943; c=relaxed/simple;
	bh=IOTABft6uCqIAjGwmNMN8eSk+vkMHhKVmT9rNesEJHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INiANBEQiaBcvIgvqwKfAwxYnr94t4jDUqrJqSWeAfHOGIKA8JC9u8XGzxaZ4lLnlOv3qwiqb+g1DK3H6tbVM7gEPoje0q4MUhWo/KU7g+N8RF8fdZMkDJebPS7SvZMbgxN0q6fF5tMXAKoI7EhUaeBA9tvsH4/M9TRbqXGqrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjvqaWdk; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c9cf863a58so1644072b6e.2;
        Mon, 20 May 2024 12:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716231941; x=1716836741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/RLfGXDPDmr0DjvkXrU8jYRvw7REbfFJ8W1spbxVW0=;
        b=AjvqaWdk6tjX2EcMun+Xm/BQuSMsswnde8go/IvzbQnAkv8Xa9KgCSxxpdSAlWLrDL
         HeyW1jrRJkSkk6x+ASyxcW1e+tLXdLWZGyxQ9kn5bwAGZK7AVrZmUvPcJysnwflJSnCY
         qJpt8cf22UiRljjSB2E9WZTgHMiPk3kxNdvRHzibM/4ureKTfv2sfk15WQNWBM3OMm2S
         zZG37vGICPhYbS58878vKRAj+8Z/1O6j7J53/sz/ucHz3SUp7ABvMqtVfoLrRahPh6fn
         UUjclEb6juOmCjPWrTkZJ9XaJIRr6WcORW9eBiVAdkwL5MQ111a2rrMkPYQcLVOmVeRF
         T+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716231941; x=1716836741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/RLfGXDPDmr0DjvkXrU8jYRvw7REbfFJ8W1spbxVW0=;
        b=Nfhr++mD9yeRvxRzn+E0LIUwVxjLEH7vLFBu4bVTohhZPLdIdjXq5mNtT06V7eiYjU
         yZvO15Bl1ddEfyYZ2v5Yc0zz9G6RTUAYus4otbKTNrt+jeEIalrMcBWii1hzEfhG6UbK
         hVI3MfF3RcsvY8+N+gw14LlrdnVKq3n3e8mRkQfYdElqXJXJc+8tj1gJFi1PwhQMdzdh
         X5PwNRjbj2D73R950p+ioAlcbH/8LjWu69rqkno4VjW5mJ2YG3f7WrCFhgP3I2sWwjwT
         t8R4ZsuZTs2GFlCvRnoeJ365ZQOh3fY6M+KVAOVxhpfqcgDkcxo3ZKEcdGgyknb5pRU7
         j5xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL1Qb0vRh2gQBO4Oi8L94k7x/9Ta0dB3wp9H30U6RIAuLIpYneJoB3ykckpap07yqY+cO8+xSoYrK9pslaRgVrMcnKIG6TjuXbNVdvAg==
X-Gm-Message-State: AOJu0YzbKBCoB59tAXtaI7yBwjKYzfn+OIl3s1oAqKfufS+pegTrydFg
	8JmjNqw5hbCjNRn9odId0GS8r81iMcf3GkLjMBldjJ0aWg/9V0hVCyZ8d2xTzE5+IMd/bbES0q7
	F4tQFgGLohH6f2XcaeGXDheigyac=
X-Google-Smtp-Source: AGHT+IFFSuxQDIGK26cBNopE6ihFylWaHnQXfI30038/vho851jV2cKODani0txiGQCvkjE0JvMEdZqqZ5hvLuWIzPI=
X-Received: by 2002:a05:6808:1709:b0:3c9:6dc9:a532 with SMTP id
 5614622812f47-3c997023d67mr37823847b6e.10.1716231940756; Mon, 20 May 2024
 12:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520164624.665269-2-aalbersh@redhat.com> <20240520164624.665269-4-aalbersh@redhat.com>
 <CAOQ4uxikMjmAkXwGk3d9897622JfkeE8LXaT9PBrtTiR5y3=Rg@mail.gmail.com>
In-Reply-To: <CAOQ4uxikMjmAkXwGk3d9897622JfkeE8LXaT9PBrtTiR5y3=Rg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 May 2024 22:05:29 +0300
Message-ID: <CAOQ4uxiHfr33KQFOykbP2oAURTDNCLDnN75Rdk7M4G8HS+kQBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and FS_IOC_FSGETXATTRAT
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[fix fsdevel address]

On Mon, May 20, 2024 at 10:03=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Mon, May 20, 2024 at 7:46=E2=80=AFPM Andrey Albershteyn <aalbersh@redh=
at.com> wrote:
> >
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
> > @@ -647,6 +648,19 @@ static int fileattr_set_prepare(struct inode *inod=
e,
> >         if (fa->fsx_cowextsize =3D=3D 0)
> >                 fa->fsx_xflags &=3D ~FS_XFLAG_COWEXTSIZE;
> >
> > +       /*
> > +        * The only use case for special files is to set project ID, fo=
rbid any
> > +        * other attributes
> > +        */
> > +       if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
> > +               if (fa->fsx_xflags & ~FS_XFLAG_PROJINHERIT)
> > +                       return -EINVAL;
> > +               if (!S_ISLNK(inode->i_mode) && fa->fsx_nextents)
> > +                       return -EINVAL;
> > +               if (fa->fsx_extsize || fa->fsx_cowextsize)
> > +                       return -EINVAL;
> > +       }
> > +
> >         return 0;
> >  }
> >
> > @@ -763,6 +777,79 @@ static int ioctl_fssetxattr(struct file *file, voi=
d __user *argp)
> >         return err;
> >  }
> >
> > +static int ioctl_fsgetxattrat(struct file *file, void __user *argp)
> > +{
> > +       struct path filepath;
> > +       struct fsxattrat fsxat;
> > +       struct fileattr fa;
> > +       int error;
> > +
> > +       if (!S_ISDIR(file_inode(file)->i_mode))
> > +               return -EBADF;
>
> So the *only* thing that is done with the fd of the ioctl is to verify
> that it is a directory fd - there is no verification that this fd is on t=
he
> same sb as the path to act on.
>
> Was this the intention? It does not make a lot of sense to me
> and AFAIK there is no precedent to an API like this.
>
> There are ioctls that operate on the filesystem using any
> fd on that fs, such as FS_IOC_GETFS{UUID,SYSFSPATH}
> and maybe the closest example to what you are trying to add
> XFS_IOC_BULKSTAT.
>
> Trying to think of a saner API for this - perhaps pass an O_PATH
> fd without any filename in struct fsxattrat, saving you also the
> headache of passing a variable length string in an ioctl.
>
> Then atfile =3D fdget_raw(fsxat.atfd) and verify that atfile->f_path
> and file->f_path are on the same sb before proceeding to operate
> on atfile->f_path.dentry.
>
> The (maybe more sane) alternative is to add syscalls instead of
> ioctls, but I won't force you to go there...
>
> What do everyone think?
>
> Thanks,
> Amir.

