Return-Path: <linux-fsdevel+bounces-45124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA531A7303A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 12:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BEA718957BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 11:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58362213E71;
	Thu, 27 Mar 2025 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GymUN+1D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC06120D514;
	Thu, 27 Mar 2025 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743075584; cv=none; b=Xz6vJWVwRPCclLerA40gRC1IZC//GQ/i8HtOVYG5sYyZXj+R0lDJNBsS0yXEfSEiUBN1o3a6EY2LCG1igzLhLnj87xotUFql1OZV3Jo2gNctxX6afimb3+fTX57/iOFB9VxpK/jpunbp1+ctbUt0+OXeB9TodJhDoKDMikzNDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743075584; c=relaxed/simple;
	bh=HLTBY8S4ZTpJUpA3lXf5BDLlXk9fvudGXjyPq/LNYbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EboAFcSnw3GsVBC5UpkADpFWYBO1bS7dfCtDx9JgEv39J0T0QWEAC5Ju3bkrpD9VlVsUS8HMsl76+XPB4PYUo8HnGC/um6fV2uGaKQTm+ve22oBs+6yMdCiKehSipVhBFJ+VZ8W+mXf93TGgeVbai2f4Lk9ebf1MQ8O/aM3KhPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GymUN+1D; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so1546058a12.2;
        Thu, 27 Mar 2025 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743075581; x=1743680381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5YJ+HIPr7Xtl+bdBaUXFEAtySXgJKTavR2pWedTVNo=;
        b=GymUN+1DDsJvfYJRDpFhJj0OJnFetds2IdVrjcWQtcMLTPrWurKDaQgNH2q+3vnpjh
         ABewIkVTVYlunGabkMNI3EqjCZJ6sJiNplQBetPk7diietp7GKErMnTsXqYzx3R6A9eo
         e5qsMgZN/PdoD+RbfSplV1bK263YK8632advVPlh3ss8O5sRpV22ly64jOfTGT1oKY4Y
         JOWmPDFxALbEQllSj5aGENiu9mGEwXQPdbe6dJPr7jZZ6JK+H4NClpo3FY/RM8e/ICWQ
         yNDdEQQC3dxXs1QXzyKWrGX58l7gB2X7HeiB6KvI9F8rRWXgRQlwar4uwpPWLr2CVDxm
         6sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743075581; x=1743680381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5YJ+HIPr7Xtl+bdBaUXFEAtySXgJKTavR2pWedTVNo=;
        b=MvSIYdYCW7fT2UfYKMvZikDj/IYEYAY3dW7Z0zQSNm4z6Kftl0PNCvTmwiaypCC1XK
         Qfbj2jsGzMIr5keVhoyVUBCg0WxXzIJ6IkehAduW/xEIQCa6hVK9+PycXFjytOr1IG57
         L2kIWNLQe93ZAX82vzB8gGfmvsW2O8Cx+SqrDk2u7EAfn7pCbcKetIopDde1rQ00bQRn
         0otOdzx8NxdDSqXYCIey/t7OPI7Dd/hfhRN7GkDJ7nBfT2el207LC52TSC+HbzjwAXmw
         5bsJLq8RmBKQKPnaiCWTNuhVf4eBv5CleMavGbWq3ywqhTO6xAqs4ehtSRqdSmxBjZde
         pCoA==
X-Forwarded-Encrypted: i=1; AJvYcCUEn4+DU3aRS2iwctlVWc+HI97kbBicmV5fSEZJaIoeBBv/mW7BRbl7C11PbZnnjodixaKJtsnjAFxB1RdEDHbItCb/1QF9@vger.kernel.org, AJvYcCUKqSchGNmUHWKSFZ6fBbO+YPX2h6VBoswndf1BRjcPRapXsddlhAb+jsEWK4+dhWjBzEDzpJ/yrE9TXQ==@vger.kernel.org, AJvYcCUaBbPbREmkbhmxWP7LAp4mmheJa+n79KYxchkmin2Oxdknp/XseQ7ag3sQPhbNEY4n0x94INhghFMMhN+x@vger.kernel.org, AJvYcCUdp3C5Q97RaqmtRHzFW8JTWORNVq6bcPoQGtt8e5am15U2pQVN2klhp5w9JuQjONr6zLHFraytxKR6bZfT@vger.kernel.org, AJvYcCV5+PM2leCkf1OTyE9kgJVACzl0hQYTJrflbcRVnPh6JxwMJNCVoIWCgZ/UeVojU0TkHI0Fe+jdK6804A==@vger.kernel.org, AJvYcCVFplNedoYP8ShfaKL86rJHf6g8i5KJQz3uU6TOONIqUOpKusSut4vd9b90M4GdHU4c2sC02LkmFuib@vger.kernel.org, AJvYcCVQQTYk4+swU9Wv0Wj3hwz6JqYYWBRkqE0b6QP/7Wz4Ho8aXxVosmyaStALp9N8CzEvPpv3m9eM8T2CYA==@vger.kernel.org, AJvYcCVpIA/g+pU4DXU8FFBfg0cJxfowGus6Pok/CZ7fhfQu8X0As1ibyqnU5EL0km9SHnwHbrcgQKRke+k=@vger.kernel.org, AJvYcCX/DXRwrxdQYUVnhBwy1CQHGAOkOsr15yHU5UI5vKhpyqQiHb+wzgzfRHUnJIC6wXQ1zN/qjHpWjfaQDQ==@vger.kernel.org, AJvYcCXTKOqO
 WNzYFL/rVYzJoVSfjCXuwVkXfQAo8fpZsG3w/9junMUAO6RYds6kRLhA/25fiGL2VTwRrsuV@vger.kernel.org, AJvYcCXXrB5aWG4JZYJ6VDgY2x2pI9RCHLfByb4G2ku+2usH8R4nlig9jVgIPgqRAYGLr1Jd0T7Ds872RYTCJR1Zmg==@vger.kernel.org, AJvYcCXpHM1uhitCXIudSl3ytB1LHmlfC7j1t6TGnrl60GDzBW9BCzhRSh0/sGL7U/shlCPiQzBIteJD/GeYcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2tH5UMzVYIR8w8s5QI/BOz4W18M5vsegh4tvaWvQOYmgj1JG
	ttZmAKsGTC8fhP70qrji6jnp/8YPoopOmBZrH3uGRkS2qV1/iKk4fDdweSSBxz6lZL/K+EzEWV/
	Sm+ikNoZ+YKXXbH9Bfv+uV0ZcCJ4=
X-Gm-Gg: ASbGncti0A4FctA4zwc8LIfSh3+rm5t/MAeVTPb47GDnyO9WeLPW0RFwreL+nEMSCG7
	//JX22PPCjoMjzkIK7TmTrQqOmHvQfOyr3QiuWP0akyF8hijBwtHxaF9ognabUm/uqjEYyYQn+H
	zpR/lUU1fPRI7lo+opqqV649zi1A==
X-Google-Smtp-Source: AGHT+IGgy/miY5V7+MPkH09VPO41DMi/jMR8Bk4E49dQyif98hlWpMqsre9jbg/TLCs8zzkfhNjlalqvBIB5xRYILRM=
X-Received: by 2002:a05:6402:518d:b0:5e7:b02b:6430 with SMTP id
 4fb4d7f45d1cf-5ed8f3fd122mr2772445a12.23.1743075580404; Thu, 27 Mar 2025
 04:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
 <20250321-xattrat-syscall-v4-3-3e82e6fb3264@kernel.org> <CAOQ4uxj2Fqmc_pSD4bqqoQu7QjmgSVp2V15FbmBdTNqQ03aPGQ@mail.gmail.com>
 <faqun3wrpvwrhwukql3niqvvauy5ngrpytx5bxbrv5xkounez3@m7j2znjuzapu>
In-Reply-To: <faqun3wrpvwrhwukql3niqvvauy5ngrpytx5bxbrv5xkounez3@m7j2znjuzapu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Mar 2025 12:39:28 +0100
X-Gm-Features: AQ5f1JofzJgaxJ0LZuoFvXDiOPJAJ8w60JwbZ8r4It-kQ_jhprqRZDypv8Lufbk
Message-ID: <CAOQ4uxjs=Gg-ocwx_fkzc0gxQ_dHx-P9EAgz5ZwbdbrxV0T_EA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fs: introduce getfsxattrat and setfsxattrat syscalls
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 10:33=E2=80=AFAM Andrey Albershteyn <aalbersh@redha=
t.com> wrote:
>
> On 2025-03-23 09:56:25, Amir Goldstein wrote:
> > On Fri, Mar 21, 2025 at 8:49=E2=80=AFPM Andrey Albershteyn <aalbersh@re=
dhat.com> wrote:
> > >
> > > From: Andrey Albershteyn <aalbersh@redhat.com>
> > >
> > > Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> > > extended attributes/flags. The syscalls take parent directory fd and
> > > path to the child together with struct fsxattr.
> > >
> > > This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> > > that file don't need to be open as we can reference it with a path
> > > instead of fd. By having this we can manipulated inode extended
> > > attributes not only on regular files but also on special ones. This
> > > is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> > > we can not call ioctl() directly on the filesystem inode using fd.
> > >
> > > This patch adds two new syscalls which allows userspace to get/set
> > > extended inode attributes on special files by using parent directory
> > > and a path - *at() like syscall.
> > >
> > > CC: linux-api@vger.kernel.org
> > > CC: linux-fsdevel@vger.kernel.org
> > > CC: linux-xfs@vger.kernel.org
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > ...
> > > +SYSCALL_DEFINE5(setfsxattrat, int, dfd, const char __user *, filenam=
e,
> > > +               struct fsxattr __user *, ufsx, size_t, usize,
> > > +               unsigned int, at_flags)
> > > +{
> > > +       struct fileattr fa;
> > > +       struct path filepath;
> > > +       int error;
> > > +       unsigned int lookup_flags =3D 0;
> > > +       struct filename *name;
> > > +       struct mnt_idmap *idmap;.
> >
> > > +       struct dentry *dentry;
> > > +       struct vfsmount *mnt;
> > > +       struct fsxattr fsx =3D {};
> > > +
> > > +       BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
> > > +       BUILD_BUG_ON(sizeof(struct fsxattr) !=3D FSXATTR_SIZE_LATEST)=
;
> > > +
> > > +       if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) !=3D =
0)
> > > +               return -EINVAL;
> > > +
> > > +       if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> > > +               lookup_flags |=3D LOOKUP_FOLLOW;
> > > +
> > > +       if (at_flags & AT_EMPTY_PATH)
> > > +               lookup_flags |=3D LOOKUP_EMPTY;
> > > +
> > > +       if (usize > PAGE_SIZE)
> > > +               return -E2BIG;
> > > +
> > > +       if (usize < FSXATTR_SIZE_VER0)
> > > +               return -EINVAL;
> > > +
> > > +       error =3D copy_struct_from_user(&fsx, sizeof(struct fsxattr),=
 ufsx, usize);
> > > +       if (error)
> > > +               return error;
> > > +
> > > +       fsxattr_to_fileattr(&fsx, &fa);
> > > +
> > > +       name =3D getname_maybe_null(filename, at_flags);
> > > +       if (!name) {
> > > +               CLASS(fd, f)(dfd);
> > > +
> > > +               if (fd_empty(f))
> > > +                       return -EBADF;
> > > +
> > > +               idmap =3D file_mnt_idmap(fd_file(f));
> > > +               dentry =3D file_dentry(fd_file(f));
> > > +               mnt =3D fd_file(f)->f_path.mnt;
> > > +       } else {
> > > +               error =3D filename_lookup(dfd, name, lookup_flags, &f=
ilepath,
> > > +                                       NULL);
> > > +               if (error)
> > > +                       return error;
> > > +
> > > +               idmap =3D mnt_idmap(filepath.mnt);
> > > +               dentry =3D filepath.dentry;
> > > +               mnt =3D filepath.mnt;
> > > +       }
> > > +
> > > +       error =3D mnt_want_write(mnt);
> > > +       if (!error) {
> > > +               error =3D vfs_fileattr_set(idmap, dentry, &fa);
> > > +               if (error =3D=3D -ENOIOCTLCMD)
> > > +                       error =3D -EOPNOTSUPP;
> >
> > This is awkward.
> > vfs_fileattr_set() should return -EOPNOTSUPP.
> > ioctl_setflags() could maybe convert it to -ENOIOCTLCMD,
> > but looking at similar cases ioctl_fiemap(), ioctl_fsfreeze() the
> > ioctl returns -EOPNOTSUPP.
> >
> > I don't think it is necessarily a bad idea to start returning
> >  -EOPNOTSUPP instead of -ENOIOCTLCMD for the ioctl
> > because that really reflects the fact that the ioctl is now implemented
> > in vfs and not in the specific fs.
> >
> > and I think it would not be a bad idea at all to make that change
> > together with the merge of the syscalls as a sort of hint to userspace
> > that uses the ioctl, that the sycalls API exists.
> >
> > Thanks,
> > Amir.
> >
>
> Hmm, not sure what you're suggesting here. I see it as:
> - get/setfsxattrat should return EOPNOTSUPP as it make more sense
>   than ENOIOCTLCMD
> - ioctl_setflags returns ENOIOCTLCMD which also expected
>
> Don't really see a reason to change what vfs_fileattr_set() returns
> and then copying this if() to other places or start returning
> EOPNOTSUPP.

ENOIOCTLCMD conceptually means that the ioctl command is unknown
This is not the case since ->fileattr_[gs]et() became a vfs API
the ioctl command is handled by vfs and it is known, but individual
filesystems may not support it, so conceptually, returning EOPNOTSUPP
from ioctl() is more correct these days, exactly as is done with the ioctls
FS_IOC_FIEMAP and FIFREEZE which were also historically per fs
ioctls and made into a vfs API.

The fact that bcachefs does not implement ->fileattr_[gs]et() and does
implement FS_IOC_FS[GS]ETXATTR is an oversight IMO, since it
was probably merged after the vfs conversion patch.

This mistake means that bcachefs fileattr cannot be copied up by
ovl_copy_fileattr() which uses the vfs API and NOT the ioctl.

However, if you would made the internal vfs API change that I suggested,
it will have broken ovl_real_fileattr_get() and ovl_copy_fileattr(),
so leave it for now - if I care enough I can do it later together with
fixing the overlayfs and fuse code.

Thanks,
Amir.

