Return-Path: <linux-fsdevel+bounces-44826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A087FA6CE75
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 09:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09ACE16DDD9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D27202F80;
	Sun, 23 Mar 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq/8QIdn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82647FBAC;
	Sun, 23 Mar 2025 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742720199; cv=none; b=M8yGSBpwh/bw9D7shr242O3VDXOdXANPHvwr4pGaKvBJZfZYmb8fhC1ByPVVAKnwm0zL9vfpABetgIkCKWmp8I+60U+D03Yvtgt69cygOS/8sonjRqbuxqbx8xc5yU3pVc+HC8CkgNPcRHuClrqZEjJF1mFo6O4iKwM0pfiFCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742720199; c=relaxed/simple;
	bh=TJO9f5IdUVWtvEy9bUZKF/BDycaHHCYviXzt1jWheng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZctoo1JzKYOBZv9ASuBI7GuN0MXiCcvVpB91q+7LriynelVMUtfIUINTcC3Dc3CHbCNYUquu4ipz/czKDLjfaY/qKgoB5Lf5gAOq4XZUHs+gU1GCb5i95WjHCQSGOF+HBNnPDy736F1XLaiN/is4loMyN8CoLVRg/OM+1OWEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kq/8QIdn; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5eb5ecf3217so5953454a12.3;
        Sun, 23 Mar 2025 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742720196; x=1743324996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVIItDI8qaPBoFm1BXeIX43KSyqYt1PldCeim8uGiMU=;
        b=Kq/8QIdnTucWdReadGpgzxmwW5iYuVhT1Q5UFVXLosibq9JG7RIZGfT5v42T5sq7IG
         2wxym7qZOzrC++rTRt6EnBaBOCPsqsrghope/cuFxNQRuxRZnpQraDgr1eJ/us6d1NM8
         tjQGfdbKkd3Rtd3MKzjdZXxwkoY8q4FxErdrknfat2lpacPgF2h7WMaLjxrMHz84i5/t
         drfmMTxVIgoxhwz+RCgG9zBnQNFPBCkQ2yas325fSqPasu3Y8lBMl8eUNiZChv3qQ/Sk
         CH37q4VxmFBYJUDEyTi+zMDKTBQdigU+YLR8jrpbOgnFSPSu7k0YEjwr9ZSF0txjx5/j
         sm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742720196; x=1743324996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVIItDI8qaPBoFm1BXeIX43KSyqYt1PldCeim8uGiMU=;
        b=NOMph2AQowieGuuCsRX72j/yaKn8pRm3vctvZ9J3rgHpLQeFbDzgNF9ONDvMf5kLD7
         KJdKaG/saqi2WdKr7i9/Me8SRkh06l0MEvrbcpmph7tkaJJ5C44fx0lC7i1YEjW80wsu
         vamk73ePiATrb296NyT1/BohNr5RD68WrXgI9/dL7f0kw/njqpinziZkCYzKEjJzrcJR
         mhfOkNmsuz6jMeGLEH4Aesy2CG8BFni9Kg1PNRZenJPuXbJQpOxLKl6VDc9ydkzf+nsU
         DSa7n6uxMmVMTvPC0YCWbhe0dzc/i8kiueNciye1f/Bl6AMdFoy487LjayH812TsR8lI
         M33A==
X-Forwarded-Encrypted: i=1; AJvYcCU7WQYpjvwR0KTifdhBF0psS8d/cchYCXnI6vQ/yYNPqMdCFrzfjgAUxzxTPfycI3r5WrI41G/oHebdf6tzPA==@vger.kernel.org, AJvYcCUzHhMT5OUxzMsuBbXofbYnm/xg0SfaXopYSMyXxI1FcJbk0zmI5pp/UTV0cu2F0pDNcIh/YlMDg4X3xQ==@vger.kernel.org, AJvYcCV4edBCJ0R/3rawvtWhbF9X0ha8gqg8pYpwEQ2yJXaQR95ADkF82xL/+WbCK5L4l9hYRXMNldt6AAXBhA==@vger.kernel.org, AJvYcCVHSaUupEiJXm4QbS3IY+oa/+OzZTKERlWNUrkwToN0xgybROTGSIO4SrlJLF+h83RDsZSE2nNkfdT3lprs@vger.kernel.org, AJvYcCVR5aimQYXs2uvZQpjKG6cBvxC5Sw1vxRGLAlfzNx2EAYAQ3EUWievkUf3guCu+Pa74v+REIX6sePYv9A==@vger.kernel.org, AJvYcCWmOe/UrM39u3GYu2QEWjwcnYg83WrXElO8YNPLpWynvg7MvznN1MOX2of8WFX5aurG4YyzUTjKHAEaHd9C@vger.kernel.org, AJvYcCWsHahzWt0/JvmkEfeHdoZmAPNsEvLs2f13ITpu5cLwQ+LUukX5CONJI6KDQftacBoGGUg15cBYGWNx@vger.kernel.org, AJvYcCX4foRLCFZrv9oXSbozr4/x5h0HJdyHSClkdn2m8HYWYM4a51BBQ8JQ+YN8T32JcTVved4VOT6Gc48rvAyan4sX89fKab23@vger.kernel.org, AJvYcCX8UDjFDmTWHO3oxMAhGHInXhXS4Aw0ac/LLHdyvJhOWi/SJR1oyuZLvUibr4Jl7wGKnKLqsUmnvtUoig==@vger.kernel.org, AJvY
 cCXa3kbqR2StcwdlRkrs3JZLOnFdJkfOGC3nya/vrEgpa7nvR32m+Irn9YSxOTvbaF62H5DH4q3ZTXDe@vger.kernel.org, AJvYcCXy4MRbqb/z79TkPdfztHoVkUm8WaWGoiRQAyC1ebfcXwX3AYRobuthBRaSJFAHlfq2W7jcjh6AWBM=@vger.kernel.org, AJvYcCXzlK0Hrf161LsIcqOcRfLQksWlrmM44L7Y819FlWpiSK4eHslLjZrxruywBOL7bkVfZDyL3sB6i8zoSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPzZonrC2sxY2OHbYJGL44D+O3cA4jx67AAiWVwptnOr2gh84
	K35n/Uu3aYnfiX5GD6FFJPIQBc5cFVsaENmXwb/ZXXry1y+tT5uRY8kQ3w6wy9LQPmrImt5q6yt
	P5YsakgDgNiHYzxP5YLvOmZx3l/M=
X-Gm-Gg: ASbGncveNPbZokSTyMvLCCeVh0+lzbknXpGkaptk7Be3SYiiy18/2jEPaL4Foo4xB69
	y/aTx/HkVEjx6b5D3u7BvvgySY2lPoNM/jYfMJz3nVOY5ehzEX3vRgiytzqZJ4Ku53hItepwZpg
	ntu05owt+DxtKz7GgvctknSzi+Ca5iRxl8jKZPdLbACAOb1RGvFM55pTg9cts=
X-Google-Smtp-Source: AGHT+IEBIy49ieatYEuSP1liKg/ID7cKJrCF9akLUZmVZ5wo1f/yMQ0YfYjV0MMVM+aDi+JYvMnWAUZwuWv6wUTqP1A=
X-Received: by 2002:a05:6402:2753:b0:5e7:8501:8c86 with SMTP id
 4fb4d7f45d1cf-5ebcd4f4378mr8004815a12.22.1742720195296; Sun, 23 Mar 2025
 01:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org> <20250321-xattrat-syscall-v4-3-3e82e6fb3264@kernel.org>
In-Reply-To: <20250321-xattrat-syscall-v4-3-3e82e6fb3264@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 23 Mar 2025 09:56:25 +0100
X-Gm-Features: AQ5f1JrOXpIKV6C3iY7Wt_BJVbE3r_yhhr0gjM9ov_K98R8Pcb1AHPHKowO0lbc
Message-ID: <CAOQ4uxj2Fqmc_pSD4bqqoQu7QjmgSVp2V15FbmBdTNqQ03aPGQ@mail.gmail.com>
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

On Fri, Mar 21, 2025 at 8:49=E2=80=AFPM Andrey Albershteyn <aalbersh@redhat=
.com> wrote:
>
> From: Andrey Albershteyn <aalbersh@redhat.com>
>
> Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> extended attributes/flags. The syscalls take parent directory fd and
> path to the child together with struct fsxattr.
>
> This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> that file don't need to be open as we can reference it with a path
> instead of fd. By having this we can manipulated inode extended
> attributes not only on regular files but also on special ones. This
> is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> we can not call ioctl() directly on the filesystem inode using fd.
>
> This patch adds two new syscalls which allows userspace to get/set
> extended inode attributes on special files by using parent directory
> and a path - *at() like syscall.
>
> CC: linux-api@vger.kernel.org
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-xfs@vger.kernel.org
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
...
> +SYSCALL_DEFINE5(setfsxattrat, int, dfd, const char __user *, filename,
> +               struct fsxattr __user *, ufsx, size_t, usize,
> +               unsigned int, at_flags)
> +{
> +       struct fileattr fa;
> +       struct path filepath;
> +       int error;
> +       unsigned int lookup_flags =3D 0;
> +       struct filename *name;
> +       struct mnt_idmap *idmap;.

> +       struct dentry *dentry;
> +       struct vfsmount *mnt;
> +       struct fsxattr fsx =3D {};
> +
> +       BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
> +       BUILD_BUG_ON(sizeof(struct fsxattr) !=3D FSXATTR_SIZE_LATEST);
> +
> +       if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) !=3D 0)
> +               return -EINVAL;
> +
> +       if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> +               lookup_flags |=3D LOOKUP_FOLLOW;
> +
> +       if (at_flags & AT_EMPTY_PATH)
> +               lookup_flags |=3D LOOKUP_EMPTY;
> +
> +       if (usize > PAGE_SIZE)
> +               return -E2BIG;
> +
> +       if (usize < FSXATTR_SIZE_VER0)
> +               return -EINVAL;
> +
> +       error =3D copy_struct_from_user(&fsx, sizeof(struct fsxattr), ufs=
x, usize);
> +       if (error)
> +               return error;
> +
> +       fsxattr_to_fileattr(&fsx, &fa);
> +
> +       name =3D getname_maybe_null(filename, at_flags);
> +       if (!name) {
> +               CLASS(fd, f)(dfd);
> +
> +               if (fd_empty(f))
> +                       return -EBADF;
> +
> +               idmap =3D file_mnt_idmap(fd_file(f));
> +               dentry =3D file_dentry(fd_file(f));
> +               mnt =3D fd_file(f)->f_path.mnt;
> +       } else {
> +               error =3D filename_lookup(dfd, name, lookup_flags, &filep=
ath,
> +                                       NULL);
> +               if (error)
> +                       return error;
> +
> +               idmap =3D mnt_idmap(filepath.mnt);
> +               dentry =3D filepath.dentry;
> +               mnt =3D filepath.mnt;
> +       }
> +
> +       error =3D mnt_want_write(mnt);
> +       if (!error) {
> +               error =3D vfs_fileattr_set(idmap, dentry, &fa);
> +               if (error =3D=3D -ENOIOCTLCMD)
> +                       error =3D -EOPNOTSUPP;

This is awkward.
vfs_fileattr_set() should return -EOPNOTSUPP.
ioctl_setflags() could maybe convert it to -ENOIOCTLCMD,
but looking at similar cases ioctl_fiemap(), ioctl_fsfreeze() the
ioctl returns -EOPNOTSUPP.

I don't think it is necessarily a bad idea to start returning
 -EOPNOTSUPP instead of -ENOIOCTLCMD for the ioctl
because that really reflects the fact that the ioctl is now implemented
in vfs and not in the specific fs.

and I think it would not be a bad idea at all to make that change
together with the merge of the syscalls as a sort of hint to userspace
that uses the ioctl, that the sycalls API exists.

Thanks,
Amir.

