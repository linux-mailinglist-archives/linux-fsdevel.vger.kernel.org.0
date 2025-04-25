Return-Path: <linux-fsdevel+bounces-47406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8EDA9D059
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 20:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72661BA50A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C29D217712;
	Fri, 25 Apr 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoNPDeK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA346214813
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605021; cv=none; b=sMhKKvmON8KRQhhXfsmwScLPlZmB5ptyi17qiPma8es6Xr86oEBtjMjRgRqZnWnKFmiF9NQ8+SyW+06k03mePj7VyC4lA0O3Vb1MGEzsupj5we/SW5gXYHlpVW2RSpTyd87Q1SR0EB+Z8dHWABdbEFhU+i0Iwce6rzSxSGXMfDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605021; c=relaxed/simple;
	bh=xRwS7DIQ9xzKdaaNVSmdVjShk/A0oP6INDbbCT/nzow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnBMRFfXw3bm368gxG7LckvyN1LMJ85dUecZkOzxWdN8HqP/jFKHjA00oa6SmO9K/HtEoQyZ5hDUy2Ymo1wXY6tUnsm/NdIn+/vdWgU28aNTOZo1F3bHNAF0/Wa9vbbjtEF5J/fXklaFUwlxK7aplOdxwFYkWN6h8DKZbDcLFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoNPDeK2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745605016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/H3vr0OCdDcR3s3PDhlvbwdaoTNbpfjoBVpx9IMnBk=;
	b=DoNPDeK2STJBW2lvKOeUNdPR11BBrBQulvbvkJfkCnApgNaDujGCjbYvL+xOVVU1Z/Mxa0
	sN52najFUYYfbwQmNKyNhBgFaH4yXbmxmGAiOJ+lbb+DFCDWNTS2PlOfYzOzXw608y9gD8
	oVmOohrETzH6JM6n/enX+72H/1hX/tk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-yA1nPptKOI6AtddPXrjdVA-1; Fri, 25 Apr 2025 14:16:55 -0400
X-MC-Unique: yA1nPptKOI6AtddPXrjdVA-1
X-Mimecast-MFC-AGG-ID: yA1nPptKOI6AtddPXrjdVA_1745605014
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac3c219371bso208408766b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 11:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745605014; x=1746209814;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/H3vr0OCdDcR3s3PDhlvbwdaoTNbpfjoBVpx9IMnBk=;
        b=qPJm+PsyD6hIu6vnMEAKdFhorXvlwvuANKn8UI0B/xWqR2WNqJrYV/kxezAmO73Wg8
         b3HwbGiV17D9ccd96ozi+ultIeqsAflNpklZqE+baFI1ZrBmA+QBAKYMpCcmYF4Om8An
         vJzGE43ksBIcOfgjFLT4yr0oVoc+Fau0gOxRwP53u+oP+Y8AfKRozmWJyI9d+MBLGnPI
         wNQK7KDL1LY2eFUb8bBlmnrl8kp0+gcQEjQDnHd4tOQ50rbvOyxnUs8DnA7IrR6KuXXZ
         iuf2jFIKvck0vKkh+FbTCKQdoIqVzJ2JtvR/IUM4xYWX9TKYOsaakrkNmayOj6Vh7d00
         u53Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiHwYpyjFidoMzfwwLJHsitcJUI5HGvL6AiwQgjga+2XtfwqngwjomA+wj+zJqBKV2errz/kpwwJntGrpe@vger.kernel.org
X-Gm-Message-State: AOJu0YxoC3U6PfCMkjlY91vvkuXpCWd+Y/k3b84bsfN8Opp5ziBqwBwx
	8Rb5NYpXWMmuh+UHT119JU3YB9YaXqAKymMVyIvGi1JgzLcPvys6IQmCMWc1LfRTRcAob9NpC11
	vbDGcfgmfB+FHigo4MBmjV6egzMMwx/bZODdfa/D4DArKP9M/KNAXpXYeIAPAeA==
X-Gm-Gg: ASbGncugNTvYqzygDbayFCpuF/bFwC2jXLPQw5D9/DGdqohrEfDl7uVbEvjLXEzxEpG
	JcMzSutG60FNe0gvhDCUtHcBYf85nEMYR28UJ3lY1i962EDArC9hiNB/cmB42tzzyKcf+E1gyz4
	nWO1vPudWLUkqULE7KeTPyuqjjw2CMOfIBLVQG1Er1TudtipSAPpKhWrhfLIQoq0Z6uUI2nDhwI
	glyvVPODT7g2Ydj/xEDmOKuZ6Ptpz8YCv5M9UthbQNGnuWzWzH3Zm3hnsNNDBUAo22hN0Smh6RO
	FNBFa3LjIv1INN5kulFmF+X0wZISBX8=
X-Received: by 2002:a17:907:720d:b0:ac7:eb12:dc69 with SMTP id a640c23a62f3a-ace7110bb7emr344214166b.28.1745605013854;
        Fri, 25 Apr 2025 11:16:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcwZ2uBmoBZxtvmd2g+z9kEiApYvdSEco/tISBfW2KUfnlzh1cUwx+QqrN8Zv6maFk6XK8qg==
X-Received: by 2002:a17:907:720d:b0:ac7:eb12:dc69 with SMTP id a640c23a62f3a-ace7110bb7emr344205866b.28.1745605013200;
        Fri, 25 Apr 2025 11:16:53 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed70606sm168961166b.160.2025.04.25.11.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 11:16:52 -0700 (PDT)
Date: Fri, 25 Apr 2025 20:16:48 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] fs: introduce getfsxattrat and setfsxattrat
 syscalls
Message-ID: <l33napyvz5fwbcdju4otllbu4zr6faaz6mufz652alpxnjjfvl@h7j4hu4uwqwv>
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
 <20250321-xattrat-syscall-v4-3-3e82e6fb3264@kernel.org>
 <CAOQ4uxj2Fqmc_pSD4bqqoQu7QjmgSVp2V15FbmBdTNqQ03aPGQ@mail.gmail.com>
 <faqun3wrpvwrhwukql3niqvvauy5ngrpytx5bxbrv5xkounez3@m7j2znjuzapu>
 <CAOQ4uxjs=Gg-ocwx_fkzc0gxQ_dHx-P9EAgz5ZwbdbrxV0T_EA@mail.gmail.com>
 <20250422-suchen-filmpreis-3573a913457c@brauner>
 <20250422-gefressen-faucht-8ded2c9a5375@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422-gefressen-faucht-8ded2c9a5375@brauner>

On 2025-04-22 17:14:10, Christian Brauner wrote:
> On Tue, Apr 22, 2025 at 04:31:29PM +0200, Christian Brauner wrote:
> > On Thu, Mar 27, 2025 at 12:39:28PM +0100, Amir Goldstein wrote:
> > > On Thu, Mar 27, 2025 at 10:33 AM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> > > >
> > > > On 2025-03-23 09:56:25, Amir Goldstein wrote:
> > > > > On Fri, Mar 21, 2025 at 8:49 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> > > > > >
> > > > > > From: Andrey Albershteyn <aalbersh@redhat.com>
> > > > > >
> > > > > > Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> > > > > > extended attributes/flags. The syscalls take parent directory fd and
> > > > > > path to the child together with struct fsxattr.
> > > > > >
> > > > > > This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> > > > > > that file don't need to be open as we can reference it with a path
> > > > > > instead of fd. By having this we can manipulated inode extended
> > > > > > attributes not only on regular files but also on special ones. This
> > > > > > is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> > > > > > we can not call ioctl() directly on the filesystem inode using fd.
> > > > > >
> > > > > > This patch adds two new syscalls which allows userspace to get/set
> > > > > > extended inode attributes on special files by using parent directory
> > > > > > and a path - *at() like syscall.
> > > > > >
> > > > > > CC: linux-api@vger.kernel.org
> > > > > > CC: linux-fsdevel@vger.kernel.org
> > > > > > CC: linux-xfs@vger.kernel.org
> > > > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > ---
> > > > > ...
> > > > > > +SYSCALL_DEFINE5(setfsxattrat, int, dfd, const char __user *, filename,
> > > > > > +               struct fsxattr __user *, ufsx, size_t, usize,
> > > > > > +               unsigned int, at_flags)
> > > > > > +{
> > > > > > +       struct fileattr fa;
> > > > > > +       struct path filepath;
> > > > > > +       int error;
> > > > > > +       unsigned int lookup_flags = 0;
> > > > > > +       struct filename *name;
> > > > > > +       struct mnt_idmap *idmap;.
> > > > >
> > > > > > +       struct dentry *dentry;
> > > > > > +       struct vfsmount *mnt;
> > > > > > +       struct fsxattr fsx = {};
> > > > > > +
> > > > > > +       BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
> > > > > > +       BUILD_BUG_ON(sizeof(struct fsxattr) != FSXATTR_SIZE_LATEST);
> > > > > > +
> > > > > > +       if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> > > > > > +               return -EINVAL;
> > > > > > +
> > > > > > +       if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> > > > > > +               lookup_flags |= LOOKUP_FOLLOW;
> > > > > > +
> > > > > > +       if (at_flags & AT_EMPTY_PATH)
> > > > > > +               lookup_flags |= LOOKUP_EMPTY;
> > > > > > +
> > > > > > +       if (usize > PAGE_SIZE)
> > > > > > +               return -E2BIG;
> > > > > > +
> > > > > > +       if (usize < FSXATTR_SIZE_VER0)
> > > > > > +               return -EINVAL;
> > > > > > +
> > > > > > +       error = copy_struct_from_user(&fsx, sizeof(struct fsxattr), ufsx, usize);
> > > > > > +       if (error)
> > > > > > +               return error;
> > > > > > +
> > > > > > +       fsxattr_to_fileattr(&fsx, &fa);
> > > > > > +
> > > > > > +       name = getname_maybe_null(filename, at_flags);
> > > > > > +       if (!name) {
> > > > > > +               CLASS(fd, f)(dfd);
> > > > > > +
> > > > > > +               if (fd_empty(f))
> > > > > > +                       return -EBADF;
> > > > > > +
> > > > > > +               idmap = file_mnt_idmap(fd_file(f));
> > > > > > +               dentry = file_dentry(fd_file(f));
> > > > > > +               mnt = fd_file(f)->f_path.mnt;
> > > > > > +       } else {
> > > > > > +               error = filename_lookup(dfd, name, lookup_flags, &filepath,
> > > > > > +                                       NULL);
> > > > > > +               if (error)
> > > > > > +                       return error;
> > > > > > +
> > > > > > +               idmap = mnt_idmap(filepath.mnt);
> > > > > > +               dentry = filepath.dentry;
> > > > > > +               mnt = filepath.mnt;
> > > > > > +       }
> > > > > > +
> > > > > > +       error = mnt_want_write(mnt);
> > > > > > +       if (!error) {
> > > > > > +               error = vfs_fileattr_set(idmap, dentry, &fa);
> > > > > > +               if (error == -ENOIOCTLCMD)
> > > > > > +                       error = -EOPNOTSUPP;
> > > > >
> > > > > This is awkward.
> > > > > vfs_fileattr_set() should return -EOPNOTSUPP.
> > > > > ioctl_setflags() could maybe convert it to -ENOIOCTLCMD,
> > > > > but looking at similar cases ioctl_fiemap(), ioctl_fsfreeze() the
> > > > > ioctl returns -EOPNOTSUPP.
> > > > >
> > > > > I don't think it is necessarily a bad idea to start returning
> > > > >  -EOPNOTSUPP instead of -ENOIOCTLCMD for the ioctl
> > > > > because that really reflects the fact that the ioctl is now implemented
> > > > > in vfs and not in the specific fs.
> > > > >
> > > > > and I think it would not be a bad idea at all to make that change
> > > > > together with the merge of the syscalls as a sort of hint to userspace
> > > > > that uses the ioctl, that the sycalls API exists.
> > > > >
> > > > > Thanks,
> > > > > Amir.
> > > > >
> > > >
> > > > Hmm, not sure what you're suggesting here. I see it as:
> > > > - get/setfsxattrat should return EOPNOTSUPP as it make more sense
> > > >   than ENOIOCTLCMD
> > > > - ioctl_setflags returns ENOIOCTLCMD which also expected
> > > >
> > > > Don't really see a reason to change what vfs_fileattr_set() returns
> > > > and then copying this if() to other places or start returning
> > > > EOPNOTSUPP.
> > > 
> > > ENOIOCTLCMD conceptually means that the ioctl command is unknown
> > > This is not the case since ->fileattr_[gs]et() became a vfs API
> > 
> > vfs_fileattr_{g,s}et() should not return ENOIOCTLCMD. Change the return
> > code to EOPNOTSUPP and then make EOPNOTSUPP be translated to ENOTTY on
> > on overlayfs and to ENOIOCTLCMD in ecryptfs and in fs/ioctl.c. This way
> > we get a clean VFS api while retaining current behavior. Amir can do his
> > cleanup based on that.
> 
> Also this get/set dance is not something new apis should do. It should
> be handled like setattr_prepare() or generic_fillattr() where the
> filesystem calls a VFS helper and that does all of this based on the
> current state of the inode instead of calling into the filesystem twice:
> 
> int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
> 		     struct fileattr *fa)
> {
> <snip>
> 	inode_lock(inode);
> 	err = vfs_fileattr_get(dentry, &old_ma);
> 	if (!err) {
> 		/* initialize missing bits from old_ma */
> 		if (fa->flags_valid) {
> <snip>
> 		err = fileattr_set_prepare(inode, &old_ma, fa);
> 		if (!err && !security_inode_setfsxattr(inode, fa))
> 			err = inode->i_op->fileattr_set(idmap, dentry, fa);
> 

You mean something like this? (not all fs are done)

-- 

From 421445f054ccad3116d55ae22c8995a48bb753fd Mon Sep 17 00:00:00 2001
From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 25 Apr 2025 17:20:42 +0200
Subject: [PATCH] fs: push retrieval of fileattr down to filesystems

Currently, vfs_fileattr_set() calls twice to the file system. Firstly,
to retrieve current state of the inode extended attributes and secondly
to set the new ones.

This patch refactors this in a way that filesystem firstly gets current
inode attribute state and then calls VFS helper to verify them. This way
vfs_fileattr_set() will call filesystem just once.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/ext2/ioctl.c          |  9 ++++++
 fs/ext4/ioctl.c          |  9 ++++++
 fs/f2fs/file.c           | 12 +++++++-
 fs/file_attr.c           | 62 ++++++++++++++++++++++++----------------
 fs/gfs2/file.c           |  9 ++++++
 fs/hfsplus/inode.c       |  9 ++++++
 fs/jfs/ioctl.c           |  9 +++++-
 fs/ntfs3/file.c          | 12 +++++++-
 fs/orangefs/inode.c      |  9 ++++++
 fs/ubifs/ioctl.c         | 12 +++++++-
 fs/xfs/xfs_ioctl.c       |  6 ++++
 include/linux/fileattr.h |  2 ++
 mm/shmem.c               |  8 ++++++
 13 files changed, 140 insertions(+), 28 deletions(-)

diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
index 44e04484e570..3a45ed9c12b7 100644
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -32,6 +32,15 @@ int ext2_fileattr_set(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(dentry);
 	struct ext2_inode_info *ei = EXT2_I(inode);
+	struct fileattr cfa;
+	int err;
+
+	err = ext2_fileattr_get(dentry, &cfa);
+	if (err)
+		return err;
+	err = vfs_fileattr_set_prepare(idmap, dentry, &cfa, fa);
+	if (err)
+		return err;
 
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index d17207386ead..f988ff4d7256 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1002,6 +1002,15 @@ int ext4_fileattr_set(struct mnt_idmap *idmap,
 	struct inode *inode = d_inode(dentry);
 	u32 flags = fa->flags;
 	int err = -EOPNOTSUPP;
+	struct fileattr cfa;
+
+	err = ext4_fileattr_get(dentry, &cfa);
+	if (err)
+		return err;
+
+	err = vfs_fileattr_set_prepare(idmap, dentry, &cfa, fa);
+	if (err)
+		return err;
 
 	if (flags & ~EXT4_FL_USER_VISIBLE)
 		goto out;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index abbcbb5865a3..f196a07f1f17 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3371,14 +3371,24 @@ int f2fs_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
-	u32 fsflags = fa->flags, mask = F2FS_SETTABLE_FS_FL;
+	u32 fsflags, mask = F2FS_SETTABLE_FS_FL;
 	u32 iflags;
+	struct fileattr cfa;
 	int err;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
 	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(inode)))
 		return -ENOSPC;
+
+	err = f2fs_fileattr_get(dentry, &cfa);
+	if (err)
+		return err;
+	err = vfs_fileattr_set_prepare(idmap, dentry, &cfa, fa);
+	if (err)
+		return err;
+	fsflags = fa->flags;
+
 	if (fsflags & ~F2FS_GETTABLE_FS_FL)
 		return -EOPNOTSUPP;
 	fsflags &= F2FS_SETTABLE_FS_FL;
diff --git a/fs/file_attr.c b/fs/file_attr.c
index 5e51c5b851ef..d0a01377bca8 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -7,6 +7,8 @@
 #include <linux/fileattr.h>
 #include <linux/namei.h>
 
+#include "internal.h"
+
 /**
  * fileattr_fill_xflags - initialize fileattr with xflags
  * @fa:		fileattr pointer
@@ -225,6 +227,36 @@ static int fileattr_set_prepare(struct inode *inode,
 	return 0;
 }
 
+/**
+ * vfs_fileattr_set_prepare - merge new filettr state and check for validity
+ * @idmap:	idmap of the mount
+ * @dentry:	the object to change
+ * @cfa:	current fileattr state
+ * @fa:		fileattr pointer with new values
+ *
+ * Return: 0 on success, or a negative error on failure.
+ */
+int vfs_fileattr_set_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
+			     struct fileattr *cfa, struct fileattr *fa)
+{
+	int err;
+
+	/* initialize missing bits from cfa */
+	if (fa->flags_valid) {
+		fa->fsx_xflags |= cfa->fsx_xflags & ~FS_XFLAG_COMMON;
+		fa->fsx_extsize = cfa->fsx_extsize;
+		fa->fsx_nextents = cfa->fsx_nextents;
+		fa->fsx_projid = cfa->fsx_projid;
+		fa->fsx_cowextsize = cfa->fsx_cowextsize;
+	} else {
+		fa->flags |= cfa->flags & ~FS_COMMON_FL;
+	}
+
+	err = fileattr_set_prepare(d_inode(dentry), cfa, fa);
+	return err;
+}
+EXPORT_SYMBOL(vfs_fileattr_set_prepare);
+
 /**
  * vfs_fileattr_set - change miscellaneous file attributes
  * @idmap:	idmap of the mount
@@ -245,7 +277,6 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
-	struct fileattr old_ma = {};
 	int err;
 
 	if (!inode->i_op->fileattr_set)
@@ -255,29 +286,12 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EPERM;
 
 	inode_lock(inode);
-	err = vfs_fileattr_get(dentry, &old_ma);
-	if (!err) {
-		/* initialize missing bits from old_ma */
-		if (fa->flags_valid) {
-			fa->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
-			fa->fsx_extsize = old_ma.fsx_extsize;
-			fa->fsx_nextents = old_ma.fsx_nextents;
-			fa->fsx_projid = old_ma.fsx_projid;
-			fa->fsx_cowextsize = old_ma.fsx_cowextsize;
-		} else {
-			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
-		}
-
-		err = fileattr_set_prepare(inode, &old_ma, fa);
-		if (err)
-			goto out;
-		err = security_inode_file_setattr(dentry, fa);
-		if (err)
-			goto out;
-		err = inode->i_op->fileattr_set(idmap, dentry, fa);
-		if (err)
-			goto out;
-	}
+	err = security_inode_file_setattr(dentry, fa);
+	if (err)
+		goto out;
+	err = inode->i_op->fileattr_set(idmap, dentry, fa);
+	if (err)
+		goto out;
 
 out:
 	inode_unlock(inode);
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index fd1147aa3891..cf796fa73af2 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -282,10 +282,19 @@ int gfs2_fileattr_set(struct mnt_idmap *idmap,
 	u32 fsflags = fa->flags, gfsflags = 0;
 	u32 mask;
 	int i;
+	struct fileattr cfa;
+	int error;
 
 	if (d_is_special(dentry))
 		return -ENOTTY;
 
+	error = gfs2_fileattr_get(dentry, &cfa);
+	if (error)
+		return error;
+	error = vfs_fileattr_set_prepare(idmap, dentry, &cfa, fa);
+	if (error)
+		return error;
+
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index f331e9574217..cdb11d00faea 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -678,6 +678,15 @@ int hfsplus_fileattr_set(struct mnt_idmap *idmap,
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
 	unsigned int new_fl = 0;
+	struct fileattr cfa;
+	int err;
+
+	err = hfsplus_fileattr_get(dentry, &cfa);
+	if (err)
+		return err;
+	err = vfs_fileattr_set_prepare(idmap, dentry, &cfa, fa);
+	if (err)
+		return err;
 
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
index f7bd7e8f5be4..4c62c14d15b0 100644
--- a/fs/jfs/ioctl.c
+++ b/fs/jfs/ioctl.c
@@ -75,11 +75,18 @@ int jfs_fileattr_set(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(dentry);
 	struct jfs_inode_info *jfs_inode = JFS_IP(inode);
-	unsigned int flags;
+	unsigned int flags = jfs_inode->mode2 & JFS_FL_USER_VISIBLE;
+	struct fileattr cfa;
+	int err;
 
 	if (d_is_special(dentry))
 		return -ENOTTY;
 
+	fileattr_fill_flags(&cfa, jfs_map_ext2(flags, 0));
+	err = vfs_fileattr_set_prepare(idmap, dentry, &cfa, fa);
+	if (err)
+		return err;
+
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 9b6a3f8d2e7c..bc7ee7595b70 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -83,12 +83,22 @@ int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct ntfs_inode *ni = ntfs_i(inode);
-	u32 flags = fa->flags;
+	u32 flags;
 	unsigned int new_fl = 0;
+	struct fileattr cfa;
+	int err;
+
+	err = ntfs_fileattr_get(dentry, &cfa);
+	if (err)
+		return err;
+	err = vfs_fileattr_set_prepare(idmap, dentry, &cfa, fa);
+	if (err)
+		return err;
 
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 
+	flags = fa->flags;
 	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_COMPR_FL))
 		return -EOPNOTSUPP;
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 5ac743c6bc2e..aecb61146443 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -910,6 +910,15 @@ static int orangefs_fileattr_set(struct mnt_idmap *idmap,
 				 struct dentry *dentry, struct fileattr *fa)
 {
 	u64 val = 0;
+	struct fileattr cfa;
+	int error = 0;
+
+	error = orangefs_fileattr_get(dentry, &cfa);
+	if (error)
+		return error;
+	error = vfs_fileattr_set_prepare(idmap, dentry, &cfa, fa);
+	if (error)
+		return error;
 
 	gossip_debug(GOSSIP_FILE_DEBUG, "%s: called on %pd\n", __func__,
 		     dentry);
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 2c99349cf537..e71e362c786b 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -148,14 +148,24 @@ int ubifs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
-	int flags = fa->flags;
+	int flags;
+	struct fileattr cfa;
+	int err;
 
 	if (d_is_special(dentry))
 		return -ENOTTY;
 
+	err = ubifs_fileattr_get(dentry, &cfa);
+	if (err)
+		return err;
+	err = vfs_fileattr_set_prepare(idmap, dentry, &cfa, fa);
+	if (err)
+		return err;
+
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 
+	flags = fa->flags;
 	if (flags & ~UBIFS_GETTABLE_IOCTL_FLAGS)
 		return -EOPNOTSUPP;
 
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d250f7f74e3b..c861dc1c3cf0 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -733,12 +733,18 @@ xfs_fileattr_set(
 	struct xfs_dquot	*pdqp = NULL;
 	struct xfs_dquot	*olddquot = NULL;
 	int			error;
+	struct fileattr		cfa;
 
 	trace_xfs_ioctl_setattr(ip);
 
 	if (d_is_special(dentry))
 		return -ENOTTY;
 
+	xfs_fill_fsxattr(ip, XFS_DATA_FORK, &cfa);
+	error = vfs_fileattr_set_prepare(idmap, dentry, &cfa, fa);
+	if (error)
+		return error;
+
 	if (!fa->fsx_valid) {
 		if (fa->flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL |
 				  FS_NOATIME_FL | FS_NODUMP_FL |
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index f62a5143eb2d..aba76d897533 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -75,6 +75,8 @@ static inline bool fileattr_has_fsx(const struct fileattr *fa)
 }
 
 int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int vfs_fileattr_set_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
+			     struct fileattr *cfa, struct fileattr *fa);
 int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct fileattr *fa);
 int ioctl_getflags(struct file *file, unsigned int __user *argp);
diff --git a/mm/shmem.c b/mm/shmem.c
index 99327c30507c..c2a5991f944f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4199,6 +4199,14 @@ static int shmem_fileattr_set(struct mnt_idmap *idmap,
 	struct inode *inode = d_inode(dentry);
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int ret, flags;
+	struct fileattr cfa;
+
+	ret = shmem_fileattr_get(dentry, &cfa);
+	if (ret)
+		return ret;
+	ret = vfs_fileattr_set_prepare(idmap, dentry, &cfa, fa);
+	if (ret)
+		return ret;
 
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
-- 
2.47.2


