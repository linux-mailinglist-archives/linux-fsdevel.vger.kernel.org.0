Return-Path: <linux-fsdevel+bounces-40289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E864BA21D74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 14:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4850F16194B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 13:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279D113B29F;
	Wed, 29 Jan 2025 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuqpzITA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FD13FFC
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738155717; cv=none; b=cr+xQFEGMYQ4u/9EnEJQ4d22zaWPGImqZtn+Xvb6MRSSCVZPlpyhoAFKxvVtgU1D6AhU7bT4E2GI4BoiUxV/33q2EKSItHg/D1RqLfReaMSac4xmA80QVtP2SQPmW9OylkXD3WQTER4ceRg25NUTZ7X51Kdbi6m+k/vXX3CgEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738155717; c=relaxed/simple;
	bh=Hpqj+tiaZNhieiN+NPFOm5u/fu5nG5fggGGlvwvoRSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGQe6wmcDgmVvMiRT/No1rwzH3GFbqLCxvThdWlMLL53BK3+N4V/n6nBMVix6Kfkx2AO/xQiL3Kg1HYkVfyjfCNigmeDA/uT9JaNVm5g+QGWZxT8nEC3Tc/OHNO2/C8KjvtX8H/8u+LoJbJ0/yQ7J3iUSLrCKt/kq9xNq2Y2waY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JuqpzITA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738155713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vfbh2r/cPD5FjZs5DsMdwpT77sBouUKcgTjyFcb6I3M=;
	b=JuqpzITAAg8YHgZKzse4fhumHO3cBya5x2ecnFWi8tA/Y8Fr5o0WnmwCMz3wr6pVvF7ITT
	3RhVQyUAsWcY75tH/w5gp70bR1LkVDwLMNi7rq+dJqcvpHPX9lBF2VLJMAhaG/+f/WpdVw
	64jhxXK3z1Yx89OA2ua0gf6Umsgv6eo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-O2RlQMjZOzOYHi5DEmugfg-1; Wed, 29 Jan 2025 08:01:52 -0500
X-MC-Unique: O2RlQMjZOzOYHi5DEmugfg-1
X-Mimecast-MFC-AGG-ID: O2RlQMjZOzOYHi5DEmugfg
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d3d2cccbe4so6209435a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 05:01:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738155711; x=1738760511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfbh2r/cPD5FjZs5DsMdwpT77sBouUKcgTjyFcb6I3M=;
        b=fRmVzgtHo6MpUN8jcrtowrN+UaBABpfXnZTlThRP2FsNOiUqBeOhMvM319erUj76gg
         mb8laPSwXmYtirqkjNPQKRZnlAhp8txoyYay5yOZ7ffNqVoVJkUL/SWhwLDAAMS8X1Lu
         7U75PKOlO79fB1YaI3GddKmF5709+BqVOpPMbkXK3DT9T9QGIW2JsvPHcbOgee9S0PbE
         JHvThLcUTW8mfcExA7f9TkBVT+7zL+kYirZNyupIrgo79O8iF4kNFf1Wf5yKlCzH06m5
         VY8mWKcTBctC+DoSd1NPaBFGxWiu1ctzGJhyPivPFB+XF4+j7qcU4G3mPAaosS6PSm9b
         tm1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5B6xchKs+LIxiYCpMHZUXVfJ1DXJp7KUmp7XC0uvbt2KQ92R6WbQ71zOwhaYgN40T84UhdZ/3P2tRpldF@vger.kernel.org
X-Gm-Message-State: AOJu0YwKMPuXXeu2SPYiL9G2IGghkElXHs8SGLVhwfYipLBXsxyhcQln
	Y7jnuBBD7QKQXCLSWRb3au1+3LefOjuWDTjUL/B22PRlMIvRLgJ01f+uDXHQlNiXkqF9Yagkhe5
	QenQBD7NCd2m2O63LAri3d3kQEq3/P1QOqvwkwd6PyeYIOqj4I3VsXdft9stFtQ==
X-Gm-Gg: ASbGnct3Z0aJwW9G812bzyB4bUH5wbjqt4M6p/N3cTfn+fUgcB1UeM1HpeM08o5L19/
	nbQHuoHtKKvp5gqOA4AF5RA812VeLGe9dQWGBsh1lFgel38FJPjKOYMQZsNBQ91+AAM/FwRghch
	0tsJbeQJDfybBT49e6lxEqEtCWzYww0xwpwMA19TB/4CWrjn4I0jmvzW32jdUsz7JPG2gmH/Lfk
	b9qKqCYRX/wFWpFOmHCfa7Tz+YhpP/snpwOcbNFcu3yRUgzZNAXc1afeis/Y2h9YZM1fMayXdeN
	c1ZXpx5+A0jy0Q4WNWICYjvT
X-Received: by 2002:a05:6402:3589:b0:5dc:5c18:6cc with SMTP id 4fb4d7f45d1cf-5dc5efa8af0mr2530231a12.3.1738155709868;
        Wed, 29 Jan 2025 05:01:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkxnbukc9+vBSLw+rDTPidkbzGMqecvIHx9dDbMuuhulEyKWoNCc+fuPl24L45iYrF/DKa8A==
X-Received: by 2002:a05:6402:3589:b0:5dc:5c18:6cc with SMTP id 4fb4d7f45d1cf-5dc5efa8af0mr2530037a12.3.1738155708585;
        Wed, 29 Jan 2025 05:01:48 -0800 (PST)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc18628a7bsm8906552a12.29.2025.01.29.05.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 05:01:47 -0800 (PST)
Date: Wed, 29 Jan 2025 14:01:45 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, tglx@linutronix.de, 
	jcmvbkbc@gmail.com, linux-security-module@vger.kernel.org, arnd@arndb.de, 
	linux-fsdevel@vger.kernel.org, chris@zankel.net, npiggin@gmail.com, 
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, luto@kernel.org, jack@suse.cz, 
	monstr@monstr.eu, linux-arch@vger.kernel.org, mingo@redhat.com, 
	linux-alpha@vger.kernel.org, christophe.leroy@csgroup.eu, linux-sh@vger.kernel.org, 
	linux-parisc@vger.kernel.org, naveen@kernel.org, bp@alien8.de, hpa@zytor.com, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	maddy@linux.ibm.com, dave.hansen@linux.intel.com, viro@zeniv.linux.org.uk, 
	linux-s390@vger.kernel.org, linux-api@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <73elivxmcppq7vqk6vxjsgg3ffnkzcbpojqyz254f375f3p3fd@iysnhhatddq2>
References: <20250122-xattrat-syscall-v2-1-5b360d4fbcb2@kernel.org>
 <20250124-wasser-kopfsache-3dc12cb7f7ab@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124-wasser-kopfsache-3dc12cb7f7ab@brauner>

On 2025-01-24 10:33:54, Christian Brauner wrote:
> On Wed, Jan 22, 2025 at 03:18:34PM +0100, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> > extended attributes/flags. The syscalls take parent directory FD and
> > path to the child together with struct fsxattr.
> > 
> > This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> > that file don't need to be open. By having this we can manipulated
> 
> By that you mean that you can use absolute or relative paths instead of
> file descriptors?

yes

> 
> > inode extended attributes not only on normal files but also on
> > special ones. This is not possible with FS_IOC_FSSETXATTR ioctl as
> > opening special files returns VFS special inode instead of
> > underlying filesystem one.
> 
> I'm not following this argument currently. In what sense does opening
> special files return a VFS special inode and how does that prevent
> FS_IOC_FSSEETXATTR from working? The inode in
> 
> static int ioctl_fssetxattr(struct file *file, void __user *argp)
> {
>         struct mnt_idmap *idmap = file_mnt_idmap(file);
>         struct dentry *dentry = file->f_path.dentry;
> 
> 	d_inode(dentry)
> 
> 
> and your:
> 
> error = user_path_at(dfd, filename, lookup_flags, &filepath);
> if (error)
> 	goto out;
> 
> d_inode(filepath.dentry)
> 
> is the same.

This is probably not a good description. With these special files,
like pipe, we can not just open them to call FS_IOC_FSSETXATTR, as
with regular ones. As you asked above, with filepath it can be done
without opening files in userspace. I don't see how we can open()
special files and then call ioctl() on them and with paths we can do
it pretty easily.

> 
> > 
> > This patch adds two new syscalls which allows userspace to set
> > extended inode attributes on special files by using parent directory
> > to open FS inode.
> > 
> > Also, as vfs_fileattr_set() is now will be called on special files
> > too, let's forbid any other attributes except projid and nextents
> > (symlink can have an extent).
> > 
> > CC: linux-api@vger.kernel.org
> > CC: linux-fsdevel@vger.kernel.org
> > CC: linux-xfs@vger.kernel.org
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> > v1:
> > https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@kernel.org/
> > 
> > Previous discussion:
> > https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/
> > 
> > XFS has project quotas which could be attached to a directory. All
> > new inodes in these directories inherit project ID set on parent
> > directory.
> > 
> > The project is created from userspace by opening and calling
> > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> > with empty project ID. Those inodes then are not shown in the quota
> > accounting but still exist in the directory. Moreover, in the case
> > when special files are created in the directory with already
> > existing project quota, these inode inherit extended attributes.
> > This than leaves them with these attributes without the possibility
> > to clear them out. This, in turn, prevents userspace from
> > re-creating quota project on these existing files.
> > ---
> >  arch/alpha/kernel/syscalls/syscall.tbl      |  2 +
> >  arch/arm/tools/syscall.tbl                  |  2 +
> >  arch/arm64/tools/syscall_32.tbl             |  2 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       |  2 +
> >  arch/microblaze/kernel/syscalls/syscall.tbl |  2 +
> >  arch/mips/kernel/syscalls/syscall_n32.tbl   |  2 +
> >  arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 +
> >  arch/mips/kernel/syscalls/syscall_o32.tbl   |  2 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     |  2 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    |  2 +
> >  arch/s390/kernel/syscalls/syscall.tbl       |  2 +
> >  arch/sh/kernel/syscalls/syscall.tbl         |  2 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      |  2 +
> >  arch/x86/entry/syscalls/syscall_32.tbl      |  2 +
> >  arch/x86/entry/syscalls/syscall_64.tbl      |  2 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     |  2 +
> >  fs/inode.c                                  | 99 +++++++++++++++++++++++++++++
> >  fs/ioctl.c                                  | 16 ++++-
> >  include/linux/fileattr.h                    |  1 +
> >  include/linux/syscalls.h                    |  4 ++
> >  include/uapi/asm-generic/unistd.h           |  8 ++-
> >  21 files changed, 157 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> > index c59d53d6d3f3490f976ca179ddfe02e69265ae4d..4b9e687494c16b60c6fd6ca1dc4d6564706a7e25 100644
> > --- a/arch/alpha/kernel/syscalls/syscall.tbl
> > +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> > @@ -506,3 +506,5 @@
> >  574	common	getxattrat			sys_getxattrat
> >  575	common	listxattrat			sys_listxattrat
> >  576	common	removexattrat			sys_removexattrat
> > +577	common	getfsxattrat			sys_getfsxattrat
> > +578	common	setfsxattrat			sys_setfsxattrat
> > diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> > index 49eeb2ad8dbd8e074c6240417693f23fb328afa8..66466257f3c2debb3e2299f0b608c6740c98cab2 100644
> > --- a/arch/arm/tools/syscall.tbl
> > +++ b/arch/arm/tools/syscall.tbl
> > @@ -481,3 +481,5 @@
> >  464	common	getxattrat			sys_getxattrat
> >  465	common	listxattrat			sys_listxattrat
> >  466	common	removexattrat			sys_removexattrat
> > +467	common	getfsxattrat			sys_getfsxattrat
> > +468	common	setfsxattrat			sys_setfsxattrat
> > diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
> > index 69a829912a05eb8a3e21ed701d1030e31c0148bc..9c516118b154811d8d11d5696f32817430320dbf 100644
> > --- a/arch/arm64/tools/syscall_32.tbl
> > +++ b/arch/arm64/tools/syscall_32.tbl
> > @@ -478,3 +478,5 @@
> >  464	common	getxattrat			sys_getxattrat
> >  465	common	listxattrat			sys_listxattrat
> >  466	common	removexattrat			sys_removexattrat
> > +467	common	getfsxattrat			sys_getfsxattrat
> > +468	common	setfsxattrat			sys_setfsxattrat
> > diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> > index f5ed71f1910d09769c845c2d062d99ee0449437c..159476387f394a92ee5e29db89b118c630372db2 100644
> > --- a/arch/m68k/kernel/syscalls/syscall.tbl
> > +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> > @@ -466,3 +466,5 @@
> >  464	common	getxattrat			sys_getxattrat
> >  465	common	listxattrat			sys_listxattrat
> >  466	common	removexattrat			sys_removexattrat
> > +467	common	getfsxattrat			sys_getfsxattrat
> > +468	common	setfsxattrat			sys_setfsxattrat
> > diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> > index 680f568b77f2cbefc3eacb2517f276041f229b1e..a6d59ee740b58cacf823702003cf9bad17c0d3b7 100644
> > --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> > +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> > @@ -472,3 +472,5 @@
> >  464	common	getxattrat			sys_getxattrat
> >  465	common	listxattrat			sys_listxattrat
> >  466	common	removexattrat			sys_removexattrat
> > +467	common	getfsxattrat			sys_getfsxattrat
> > +468	common	setfsxattrat			sys_setfsxattrat
> > diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> > index 0b9b7e25b69ad592642f8533bee9ccfe95ce9626..cfe38fcebe1a0279e11751378d3e71c5ec6b6569 100644
> > --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> > +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> > @@ -405,3 +405,5 @@
> >  464	n32	getxattrat			sys_getxattrat
> >  465	n32	listxattrat			sys_listxattrat
> >  466	n32	removexattrat			sys_removexattrat
> > +467	n32	getfsxattrat			sys_getfsxattrat
> > +468	n32	setfsxattrat			sys_setfsxattrat
> > diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> > index c844cd5cda620b2809a397cdd6f4315ab6a1bfe2..29a0c5974d1aa2f01e33edc0252d75fb97abe230 100644
> > --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> > +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> > @@ -381,3 +381,5 @@
> >  464	n64	getxattrat			sys_getxattrat
> >  465	n64	listxattrat			sys_listxattrat
> >  466	n64	removexattrat			sys_removexattrat
> > +467	n64	getfsxattrat			sys_getfsxattrat
> > +468	n64	setfsxattrat			sys_setfsxattrat
> > diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> > index 349b8aad1159f404103bd2057a1e64e9bf309f18..6c00436807c57c492ba957fcd59af1202231cf80 100644
> > --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> > +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> > @@ -454,3 +454,5 @@
> >  464	o32	getxattrat			sys_getxattrat
> >  465	o32	listxattrat			sys_listxattrat
> >  466	o32	removexattrat			sys_removexattrat
> > +467	o32	getfsxattrat			sys_getfsxattrat
> > +468	o32	setfsxattrat			sys_setfsxattrat
> > diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> > index d9fc94c869657fcfbd7aca1d5f5abc9fae2fb9d8..b3578fac43d6b65167787fcc97d2d09f5a9828e7 100644
> > --- a/arch/parisc/kernel/syscalls/syscall.tbl
> > +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> > @@ -465,3 +465,5 @@
> >  464	common	getxattrat			sys_getxattrat
> >  465	common	listxattrat			sys_listxattrat
> >  466	common	removexattrat			sys_removexattrat
> > +467	common	getfsxattrat			sys_getfsxattrat
> > +468	common	setfsxattrat			sys_setfsxattrat
> > diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> > index d8b4ab78bef076bd50d49b87dea5060fd8c1686a..808045d82c9465c3bfa96b15947546efe5851e9a 100644
> > --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> > +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> > @@ -557,3 +557,5 @@
> >  464	common	getxattrat			sys_getxattrat
> >  465	common	listxattrat			sys_listxattrat
> >  466	common	removexattrat			sys_removexattrat
> > +467	common	getfsxattrat			sys_getfsxattrat
> > +468	common	setfsxattrat			sys_setfsxattrat
> > diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> > index e9115b4d8b635b846e5c9ad6ce229605323723a5..78dfc2c184d4815baf8a9e61c546c9936d58a47c 100644
> > --- a/arch/s390/kernel/syscalls/syscall.tbl
> > +++ b/arch/s390/kernel/syscalls/syscall.tbl
> > @@ -469,3 +469,5 @@
> >  464  common	getxattrat		sys_getxattrat			sys_getxattrat
> >  465  common	listxattrat		sys_listxattrat			sys_listxattrat
> >  466  common	removexattrat		sys_removexattrat		sys_removexattrat
> > +467  common	getfsxattrat		sys_getfsxattrat		sys_getfsxattrat
> > +468  common	setfsxattrat		sys_setfsxattrat		sys_setfsxattrat
> > diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> > index c8cad33bf250ea110de37bd1407f5a43ec5e38f2..d5a5c8339f0ed25ea07c4aba90351d352033c8a0 100644
> > --- a/arch/sh/kernel/syscalls/syscall.tbl
> > +++ b/arch/sh/kernel/syscalls/syscall.tbl
> > @@ -470,3 +470,5 @@
> >  464	common	getxattrat			sys_getxattrat
> >  465	common	listxattrat			sys_listxattrat
> >  466	common	removexattrat			sys_removexattrat
> > +467	common	getfsxattrat			sys_getfsxattrat
> > +468	common	setfsxattrat			sys_setfsxattrat
> > diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> > index 727f99d333b304b3db0711953a3d91ece18a28eb..817dcd8603bcbffc47f3f59aa3b74b16486453d0 100644
> > --- a/arch/sparc/kernel/syscalls/syscall.tbl
> > +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> > @@ -512,3 +512,5 @@
> >  464	common	getxattrat			sys_getxattrat
> >  465	common	listxattrat			sys_listxattrat
> >  466	common	removexattrat			sys_removexattrat
> > +467	common	getfsxattrat			sys_getfsxattrat
> > +468	common	setfsxattrat			sys_setfsxattrat
> > diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> > index 4d0fb2fba7e208ae9455459afe11e277321d9f74..b4842c027c5d00c0236b2ba89387c5e2267447bd 100644
> > --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > @@ -472,3 +472,5 @@
> >  464	i386	getxattrat		sys_getxattrat
> >  465	i386	listxattrat		sys_listxattrat
> >  466	i386	removexattrat		sys_removexattrat
> > +467	i386	getfsxattrat		sys_getfsxattrat
> > +468	i386	setfsxattrat		sys_setfsxattrat
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index 5eb708bff1c791debd6cfc5322583b2ae53f6437..b6f0a7236aaee624cf9b484239a1068085a8ffe1 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -390,6 +390,8 @@
> >  464	common	getxattrat		sys_getxattrat
> >  465	common	listxattrat		sys_listxattrat
> >  466	common	removexattrat		sys_removexattrat
> > +467	common	getfsxattrat		sys_getfsxattrat
> > +468	common	setfsxattrat		sys_setfsxattrat
> >  
> >  #
> >  # Due to a historical design error, certain syscalls are numbered differently
> > diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> > index 37effc1b134eea061f2c350c1d68b4436b65a4dd..425d56be337d1de22f205ac503df61ff86224fee 100644
> > --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> > +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> > @@ -437,3 +437,5 @@
> >  464	common	getxattrat			sys_getxattrat
> >  465	common	listxattrat			sys_listxattrat
> >  466	common	removexattrat			sys_removexattrat
> > +467	common	getfsxattrat			sys_getfsxattrat
> > +468	common	setfsxattrat			sys_setfsxattrat
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 6b4c77268fc0ecace4ac78a9ca777fbffc277f4a..cdecb793b2ab5ab01e2333da4382919b94c7f65f 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -23,6 +23,9 @@
> >  #include <linux/rw_hint.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/syscalls.h>
> > +#include <linux/fileattr.h>
> > +#include <linux/namei.h>
> >  #include <trace/events/writeback.h>
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/timestamp.h>
> > @@ -2953,3 +2956,99 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
> >  	return mode & ~S_ISGID;
> >  }
> >  EXPORT_SYMBOL(mode_strip_sgid);
> > +
> > +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
> > +		struct fsxattr __user *, fsx, unsigned int, at_flags)
> > +{
> > +	struct fd dir;
> > +	struct fileattr fa;
> > +	struct path filepath;
> > +	int error;
> > +	unsigned int lookup_flags = 0;
> > +
> > +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> > +		return -EINVAL;
> > +
> > +	if (at_flags & AT_SYMLINK_FOLLOW)
> > +		lookup_flags |= LOOKUP_FOLLOW;
> > +
> > +	if (at_flags & AT_EMPTY_PATH)
> > +		lookup_flags |= LOOKUP_EMPTY;
> > +
> > +	dir = fdget(dfd);
> > +	if (!fd_file(dir))
> > +		return -EBADF;
> 
> Please rely on scope-based cleanup:
> 
> CLASS(fd, f)(dfd);
> if (fd_empty(f))
> 	return -EBADF;

aha, thanks, didn't know about this

> 
> > +
> > +	if (!S_ISDIR(file_inode(fd_file(dir))->i_mode)) {
> 
> This isn't needed as user_path_at() will return ENOTDIR.
> Your path as is wuld also preclude AT_EMPTY_PATH with directory file
> descriptors and afaict there's various filesystems that seem to support
> this on directory inodes.

I see, thanks, I will remove that
> 
> > +		error = -EBADF;
> > +		goto out;
> > +	}
> > +
> > +	error = user_path_at(dfd, filename, lookup_flags, &filepath);
> > +	if (error)
> > +		goto out;
> 
> I'm confused. You're using fdget() above but then you don't use the
> resulting file and call user_path_at() instead? Don't bother with
> fdget() at all and just call into user_path_at() directly.

sure, doesn't needed anymore with your suggestions above

> 
> > +
> > +	error = vfs_fileattr_get(filepath.dentry, &fa);
> > +	if (error)
> > +		goto out_path;
> > +
> > +	if (copy_fsxattr_to_user(&fa, fsx))
> > +		error = -EFAULT;
> > +
> > +out_path:
> > +	path_put(&filepath);
> > +out:
> > +	fdput(dir);
> > +	return error;
> > +}
> > +
> > +SYSCALL_DEFINE4(setfsxattrat, int, dfd, const char __user *, filename,
> > +		struct fsxattr __user *, fsx, unsigned int, at_flags)
> > +{
> > +	struct fd dir;
> > +	struct fileattr fa;
> > +	struct path filepath;
> > +	int error;
> > +	unsigned int lookup_flags = 0;
> > +
> > +	if ((at_flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
> > +		return -EINVAL;
> > +
> > +	if (at_flags & AT_SYMLINK_FOLLOW)
> > +		lookup_flags |= LOOKUP_FOLLOW;
> > +
> > +	if (at_flags & AT_EMPTY_PATH)
> > +		lookup_flags |= LOOKUP_EMPTY;
> > +
> > +	dir = fdget(dfd);
> > +	if (!fd_file(dir))
> > +		return -EBADF;
> > +
> > +	if (!S_ISDIR(file_inode(fd_file(dir))->i_mode)) {
> > +		error = -EBADF;
> > +		goto out;
> > +	}
> > +
> > +	if (copy_fsxattr_from_user(&fa, fsx)) {
> > +		error = -EFAULT;
> > +		goto out;
> > +	}
> > +
> > +	error = user_path_at(dfd, filename, lookup_flags, &filepath);
> > +	if (error)
> > +		goto out;
> 
> Same problem as above. fdget() stuff isn't needed if you're calling
> user_path_at() anyway.
> 
> > +
> > +	error = mnt_want_write(filepath.mnt);
> > +	if (error)
> > +		goto out_path;
> > +
> > +	error = vfs_fileattr_set(file_mnt_idmap(fd_file(dir)), filepath.dentry,
> > +				 &fa);
> > +	mnt_drop_write(filepath.mnt);
> 
> Just use the pattern:
> 
> error = user_path_at(dfd, filename, lookup_flags, &filepath);
> if (error)
> 	return error; /* once you've removed the fdget() direct return works fine */
> 
> 
> error = mnt_want_write(filepath.mnt);
> if (!error) {
> 	error = vfs_fileattr_set(file_mnt_idmap(fd_file(dir)), filepath.dentry, &fa);
> 	mnt_drop_write(filepath.mnt);
> }
> 
> return error;

sure, I will changed it as suggested

-- 
- Andrey
> 
> > +
> > +out_path:
> > +	path_put(&filepath);
> > +out:
> > +	fdput(dir);
> > +	return error;
> > +}
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 638a36be31c14afc66a7fd6eb237d9545e8ad997..dc160c2ef145e4931d625f1f93c2a8ae7f87abf3 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -558,8 +558,7 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
> >  }
> >  EXPORT_SYMBOL(copy_fsxattr_to_user);
> >  
> > -static int copy_fsxattr_from_user(struct fileattr *fa,
> > -				  struct fsxattr __user *ufa)
> > +int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *ufa)
> >  {
> >  	struct fsxattr xfa;
> >  
> > @@ -646,6 +645,19 @@ static int fileattr_set_prepare(struct inode *inode,
> >  	if (fa->fsx_cowextsize == 0)
> >  		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> >  
> > +	/*
> > +	 * The only use case for special files is to set project ID, forbid any
> > +	 * other attributes
> > +	 */
> > +	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
> > +		if (fa->fsx_xflags & ~FS_XFLAG_PROJINHERIT)
> > +			return -EINVAL;
> > +		if (!S_ISLNK(inode->i_mode) && fa->fsx_nextents)
> > +			return -EINVAL;
> > +		if (fa->fsx_extsize || fa->fsx_cowextsize)
> > +			return -EINVAL;
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> > index 47c05a9851d0600964b644c9c7218faacfd865f8..8598e94b530b8b280a2697eaf918dd60f573d6ee 100644
> > --- a/include/linux/fileattr.h
> > +++ b/include/linux/fileattr.h
> > @@ -34,6 +34,7 @@ struct fileattr {
> >  };
> >  
> >  int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
> > +int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *ufa);
> >  
> >  void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
> >  void fileattr_fill_flags(struct fileattr *fa, u32 flags);
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index c6333204d45130eb022f6db460eea34a1f6e91db..3134d463d9af64c6e78adb37bff4b91f77b5305f 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -371,6 +371,10 @@ asmlinkage long sys_removexattrat(int dfd, const char __user *path,
> >  asmlinkage long sys_lremovexattr(const char __user *path,
> >  				 const char __user *name);
> >  asmlinkage long sys_fremovexattr(int fd, const char __user *name);
> > +asmlinkage long sys_getfsxattrat(int dfd, const char __user *filename,
> > +				 struct fsxattr *fsx, unsigned int at_flags);
> > +asmlinkage long sys_setfsxattrat(int dfd, const char __user *filename,
> > +				 struct fsxattr *fsx, unsigned int at_flags);
> >  asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
> >  asmlinkage long sys_eventfd2(unsigned int count, int flags);
> >  asmlinkage long sys_epoll_create1(int flags);
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index 88dc393c2bca38c0fa1b3fae579f7cfe4931223c..50be2e1007bc2779120d05c6e9512a689f86779c 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -850,8 +850,14 @@ __SYSCALL(__NR_listxattrat, sys_listxattrat)
> >  #define __NR_removexattrat 466
> >  __SYSCALL(__NR_removexattrat, sys_removexattrat)
> >  
> > +/* fs/inode.c */
> > +#define __NR_getfsxattrat 467
> > +__SYSCALL(__NR_getfsxattrat, sys_getfsxattrat)
> > +#define __NR_setfsxattrat 468
> > +__SYSCALL(__NR_setfsxattrat, sys_setfsxattrat)
> > +
> >  #undef __NR_syscalls
> > -#define __NR_syscalls 467
> > +#define __NR_syscalls 469
> >  
> >  /*
> >   * 32 bit systems traditionally used different
> > 
> > ---
> > base-commit: 4c538044ee2d11299cc57ac1e92d343e1e83b847
> > change-id: 20250114-xattrat-syscall-6a1136d2db59
> > 
> > Best regards,
> > -- 
> > Andrey Albershteyn <aalbersh@kernel.org>
> > 
> 


