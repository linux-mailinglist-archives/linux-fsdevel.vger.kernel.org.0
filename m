Return-Path: <linux-fsdevel+bounces-19915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DD38CB242
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66FE1B225EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2FA146D71;
	Tue, 21 May 2024 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFEuo0HD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DC573539
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309277; cv=none; b=dXcfZMiCJymD3my3xce/g6FK7a8sAnvDZ9L6A41Ah3+WAUXGoN5WY50vtqyqlxX2H+ZiIg5oG++sGDQdIevAeRndEzR8ePHDHHBKDHQNvqOWeKuMO+4shUUObVuGxqj80jmBNNNc6UpW1kHm6TixSU65gGtgNwZ+mrvf2J9nKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309277; c=relaxed/simple;
	bh=juSFdfByfPrlbSQpoABkvj/nbibedrl1YknKIP1oZf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1Dcc+IrIwaJeXNxqUMcwsLD7LA0aE0Q5SBMBCY5LpffjBtt8TzyxkGrssFEFtgdYICZXBehmO4vM30vUuq3+O6yV4WFtqe9oASbaaVQ3JXqhvAQ1USeBPJtmBvN1bxxWDg5+yf4D4saGeNxqbicMFogca4TSXgZw28aKMDwcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFEuo0HD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716309274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMWjXlQzrkt+R9p0EdQfQQ8DoBUNqzqS8fhr5tw1zQM=;
	b=TFEuo0HD93CNXjpA+zIrBSm76qHkB3AqoZC/9NLg8qRjigIeuvcYFT319Mj+E6/O8nB5B3
	LoGQrmyh3i6l6etrKlmf//+QRt8xAukCX9idMQ2U9FOhwGy+SLKjZt8Un2DJ2oB8XMj9RF
	bXIDWwbuvG7gtGfu0oOxqhiuqCRDXeA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-GnIjNWekOFSsHGHQjctiUg-1; Tue, 21 May 2024 12:34:32 -0400
X-MC-Unique: GnIjNWekOFSsHGHQjctiUg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41ec8ef128fso71163595e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 09:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716309271; x=1716914071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMWjXlQzrkt+R9p0EdQfQQ8DoBUNqzqS8fhr5tw1zQM=;
        b=xULMGzp0PxBUkuKpQ/mULJVEEIxufSFFAJCDmpKdjd9UNCZZ9ujKcpxaSv9CVvHr26
         TAbLikpspxrk1affIdhTi9ikXc66YIoow4/aCFIG06VHvy14MITQr7Qybcbm0orp5FQS
         8qLRK1Y5t4f/QTbJKPqGmlcqV66AdpUXsd3Ff74jeAByhPeu6j7NohZLKp7U+2zuyTSI
         +Zm4RjkcJro1lqz0iUkD9ggI0yFSIGQA5iheK5wjpWVfO8ey2dpH/4Ts5tFnUeyfjWhC
         qPBb78sTM+nDokk6cxCOIm0PO03cOca4UIlZr2mkI+C3n2m6+ZVipBeSEsR8Ml1Rfw4l
         2IcA==
X-Gm-Message-State: AOJu0YzPQw4jN6Ien6CIpgJB8UpZg04mZgTNudtApdG0ozMsFkvZUOb9
	wYajYqGw+uQGHab1yVC2MbozINNcAAw0ssHR/9B0D+l/qsCtTTzQzcbjBczBD19byu34ecT8Eka
	V3Bo07OlFkkBjMZide9ZWm1URZJb5VR0QkMLNsotqN+EmR0Nthmgmv3iExxrj9A==
X-Received: by 2002:a05:600c:314e:b0:41f:c83d:5ba8 with SMTP id 5b1f17b1804b1-41feac59e95mr236894995e9.32.1716309271304;
        Tue, 21 May 2024 09:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYRbPc/sJrxiwnThiGGQ+172mOuNjepOBj7pUUx1GUQEKJSR3K40eBc0oTA6+HQF5F5MNTFg==
X-Received: by 2002:a05:600c:314e:b0:41f:c83d:5ba8 with SMTP id 5b1f17b1804b1-41feac59e95mr236894675e9.32.1716309270559;
        Tue, 21 May 2024 09:34:30 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce25d5sm472885415e9.14.2024.05.21.09.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 09:34:30 -0700 (PDT)
Date: Tue, 21 May 2024 18:34:29 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <z6ctkxtwhwioc5a5kzisjxffkde6xpchstrr3zlflh4bsz4mpd@5z2s2d7lbje5>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <CAOQ4uxikMjmAkXwGk3d9897622JfkeE8LXaT9PBrtTiR5y3=Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxikMjmAkXwGk3d9897622JfkeE8LXaT9PBrtTiR5y3=Rg@mail.gmail.com>

On 2024-05-20 22:03:43, Amir Goldstein wrote:
> On Mon, May 20, 2024 at 7:46 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
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
> > @@ -647,6 +648,19 @@ static int fileattr_set_prepare(struct inode *inode,
> >         if (fa->fsx_cowextsize == 0)
> >                 fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> >
> > +       /*
> > +        * The only use case for special files is to set project ID, forbid any
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
> > @@ -763,6 +777,79 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
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
> that it is a directory fd - there is no verification that this fd is on the
> same sb as the path to act on.
> 
> Was this the intention? It does not make a lot of sense to me
> and AFAIK there is no precedent to an API like this.

yeah, as we want to set xattrs on that inode the path is pointing
to, so, VFS will call to the FS under that sb.

> 
> There are ioctls that operate on the filesystem using any
> fd on that fs, such as FS_IOC_GETFS{UUID,SYSFSPATH}
> and maybe the closest example to what you are trying to add
> XFS_IOC_BULKSTAT.

Not sure that I get what you mean here, the *at() part is to get
around VFS special inodes and call vfs_fileattr_set/get on FS inodes.

> 
> Trying to think of a saner API for this - perhaps pass an O_PATH
> fd without any filename in struct fsxattrat, saving you also the
> headache of passing a variable length string in an ioctl.
> 
> Then atfile = fdget_raw(fsxat.atfd) and verify that atfile->f_path
> and file->f_path are on the same sb before proceeding to operate
> on atfile->f_path.dentry.

Thanks! Didn't know about O_PATH that seems to be a way to get rid
of the path passing.

> 
> The (maybe more sane) alternative is to add syscalls instead of
> ioctls, but I won't force you to go there...
> 
> What do everyone think?
> 
> Thanks,
> Amir.
> 

-- 
- Andrey


