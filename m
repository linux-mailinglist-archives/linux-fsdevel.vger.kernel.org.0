Return-Path: <linux-fsdevel+bounces-48750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB016AB3911
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 15:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35221460F44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F5C2957B7;
	Mon, 12 May 2025 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWKIH/K3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182592951A4
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056436; cv=none; b=Sbp1nu7LSAT6lM9hjqfxllhB+D5qSaQZ2RXOm+WiyEQY6WxQyayug9aGAPZehkYbvQUsTVmYM5kGd4tJbPLd+beWkLqgLuU3lr32xIfTMmZUHQHeMw+7HlWFfdR8mbZFsgJBIvRVJw+mw7+DLQWVlKOfsiyNBaKf8qZO8uL3f9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056436; c=relaxed/simple;
	bh=BkEoFCauMqjqdF99XOQ04bTcBlErPYvxw1BKLlXKtUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LntSSlD7EoYettO06qtn2nW1lpV9+c9t7QevjkD4pTEZUALKDBYd1+6JZTV49eaKOwcoJl2QDUUH2I1PGb0hMgxZkuYr3J1KdKzrygluSLNb75y2lmM3SSU14FVN+98Z2mUtBzSr9dlixo7e2wshjlrUh6mjEyzHidsagV2xriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWKIH/K3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747056433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xT/FjlwzeW/dIJrII1zg+QW6Nufx9n56t4jpFPeTrX8=;
	b=ZWKIH/K35a3kAT96nZKhY34AWuuAFLXex42PSQfvVuMCfkJy2O8Uwd4jqNj//6HOM9Ptg3
	zxgRkNV0btTDj0z9lJzNgSaQhEvHEZyGZQnNefNrQF+Sw15wBCulIJwTICk2uRID9sjDs+
	8tSeCPARXoOzSYBxenqDIUEhO/7yaEM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-hdczLlxSPAqpFN-NqJebSA-1; Mon, 12 May 2025 09:27:11 -0400
X-MC-Unique: hdczLlxSPAqpFN-NqJebSA-1
X-Mimecast-MFC-AGG-ID: hdczLlxSPAqpFN-NqJebSA_1747056430
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ad239523a14so161557166b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 06:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747056427; x=1747661227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT/FjlwzeW/dIJrII1zg+QW6Nufx9n56t4jpFPeTrX8=;
        b=GzaWueSjtF6tTrscPM3rPMDoaeNwi6XlF4yf3MYYIac19AyATS4dBEkp+hZfW9/kVw
         8DAMUHXZ9FTmFAacfBS2YbkfGe8XTFizYvO5tTMpso+0atO7T9HVCt9Oj6CeK5M7aFGO
         Qi+9C6GgMJckci5vc47PALuVGWZ+++UuTNKGBUV4T8tEBITqr8YzrvVebTCrYsC+Uwpb
         nQiu0OdXAq7k9qjAAeqylOFYFWfivCZnflciZ/59B8DWumWBtN+pa0e1Vksxf/1y1lDn
         JFM2XEykc4VCOxIMKgCpFRhQ0JngNsNQFPCAvQew2AGlk3hXfHdnqFnlHF8usVn1mydd
         mXmA==
X-Forwarded-Encrypted: i=1; AJvYcCVzQjyN3vWWakyTGujvFOjTLEu8sywQAGW+uDZGaDOcEk+QkjJzE6+UNn6tBGpwAHMollQQiwNrFg+SZINt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzynobx5pC0Jbe7ErZg9UkUDrADddLSLc1Ofl4Mk8jemVZZT/En
	EgBoNJfBr1WV4BhYMlRXps/JCKX/zVBAyHxMwFukMTXb65L79HIwbHeGn9NDbae1020JbZmqtyD
	X5quAxfSivSAU7GhQT4/wrNOiLnyTY/Aqp3V2u043tVUgoKo8ItVEg2lEVVkYWw==
X-Gm-Gg: ASbGncta/0y1Y0ygAaO6b/48sgHV6q1n7IML+9ptXtj0+Ay2iKmaeqhEota+etLrcJB
	WnRGTJCTm9g4HP29gpqmL0sTXDqVohkxhLrtRz+Gkp41+jDDA37VFXedYxs0YcG3nVUQJK/8Sh/
	pZj9p1j8HM3fDxogUvkfLTjvw2G52D78HCu1KLutJEsZwgGlgxOvej6dXetoOP9wvKUSjwEVSNn
	lmHvGHfbVaKOqCjeCPKFSaAbmiznKg6pqf/dHL+SQgdxUMg0MKGjgEpF8SWriSFWX1ySp7kiUTh
	RYiMjHzfYSkQe3KaiN1BPKED8uuFwIBC9g26rd3R
X-Received: by 2002:a17:907:a08a:b0:ad2:2547:b0ae with SMTP id a640c23a62f3a-ad22547c02amr990455366b.20.1747056426502;
        Mon, 12 May 2025 06:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETa07MPJhXdQUe1GZPoJZWirIoiPraReBRPjm3PreIn0eeyX6QhW4ZzkdEEjDverm1SFgl6A==
X-Received: by 2002:a17:907:a08a:b0:ad2:2547:b0ae with SMTP id a640c23a62f3a-ad22547c02amr990449666b.20.1747056425990;
        Mon, 12 May 2025 06:27:05 -0700 (PDT)
Received: from thinky (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad219746730sm625109766b.94.2025.05.12.06.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:27:05 -0700 (PDT)
Date: Mon, 12 May 2025 15:27:02 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	selinux@vger.kernel.org, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v5 0/7] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <vxjuophuvmvqloczajfyjd5jvvcbvcty2fpvfmcaz5xuh5vyqv@fxiymeww26mf>
References: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>

On 2025-05-12 15:18:53, Andrey Albershteyn wrote:
> This patchset introduced two new syscalls file_getattr() and
> file_setattr(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
> except they use *at() semantics. Therefore, there's no need to open the
> file to get a fd.
> 
> These syscalls allow userspace to set filesystem inode attributes on
> special files. One of the usage examples is XFS quota projects.
> 
> XFS has project quotas which could be attached to a directory. All
> new inodes in these directories inherit project ID set on parent
> directory.
> 
> The project is created from userspace by opening and calling
> FS_IOC_FSSETXATTR on each inode. This is not possible for special
> files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> with empty project ID. Those inodes then are not shown in the quota
> accounting but still exist in the directory. This is not critical but in
> the case when special files are created in the directory with already
> existing project quota, these new inodes inherit extended attributes.
> This creates a mix of special files with and without attributes.
> Moreover, special files with attributes don't have a possibility to
> become clear or change the attributes. This, in turn, prevents userspace
> from re-creating quota project on these existing files.
> 
> NAME
> 
> 	file_getattr/file_setattr - get/set filesystem inode attributes
> 
> SYNOPSIS
> 
> 	#include <sys/syscall.h>    /* Definition of SYS_* constants */
> 	#include <unistd.h>
> 
> 	long syscall(SYS_file_getattr, int dirfd, const char *pathname,
> 		struct fsxattr *fsx, size_t size, unsigned int at_flags);
> 	long syscall(SYS_file_setattr, int dirfd, const char *pathname,
> 		struct fsxattr *fsx, size_t size, unsigned int at_flags);
> 
> 	Note: glibc doesn't provide for file_getattr()/file_setattr(),
> 	use syscall(2) instead.
> 
> DESCRIPTION
> 
> 	The syscalls take fd and path. If path is absolute, fd is not
> 	used. If path is empty, fd can be AT_FDCWD or any valid fd which
> 	will be used to get/set attributes on.
> 
> 	This is an alternative to FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR
> 	ioctl with a difference that file don't need to be open as we
> 	can reference it with a path instead of fd. By having this we
> 	can manipulated filesystem inode attributes not only on regular
> 	files but also on special ones. This is not possible with
> 	FS_IOC_FSSETXATTR ioctl as with special files we can not call
> 	ioctl() directly on the filesystem inode using file descriptor.
> 
> 	at_flags can be set to AT_SYMLINK_NOFOLLOW or AT_EMPTY_PATH.
> 
> RETURN VALUE
> 
> 	On success, 0 is returned.  On error, -1 is returned, and errno
> 	is set to indicate the error.
> 
> ERRORS
> 
> 	EINVAL		Invalid at_flag specified (only
> 			AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH is
> 			supported).
> 
> 	EINVAL		Size was smaller than any known version of
> 			struct fsxattr.
> 
> 	EINVAL		Invalid combination of parameters provided in
> 			fsxattr for this type of file.
> 
> 	E2BIG		Size of input argument **struct fsxattr** is too
> 			big.
> 
> 	EBADF		Invalid file descriptor was provided.
> 
> 	EPERM		No permission to change this file.
> 
> 	EOPNOTSUPP	Filesystem does not support setting attributes
> 			on this type of inode
> 
> HISTORY
> 
> 	Added in Linux 6.15.
> 
> EXAMPLE
> 
> Create directory and file "mkdir ./dir && touch ./dir/foo" and then
> execute the following program:
> 
> 	#include <fcntl.h>
> 	#include <errno.h>
> 	#include <string.h>
> 	#include <linux/fs.h>
> 	#include <stdio.h>
> 	#include <sys/syscall.h>
> 	#include <unistd.h>
> 
> 	int
> 	main(int argc, char **argv) {
> 		int dfd;
> 		int error;
> 		struct fsxattr fsx;
> 
> 		dfd = open("./dir", O_RDONLY);
> 		if (dfd == -1) {
> 			printf("can not open ./dir");
> 			return dfd;
> 		}
> 
> 		error = syscall(467, dfd, "./foo", &fsx, 0);
> 		if (error) {
> 			printf("can not call 467: %s", strerror(errno));
> 			return error;
> 		}
> 
> 		printf("dir/foo flags: %d\n", fsx.fsx_xflags);
> 
> 		fsx.fsx_xflags |= FS_XFLAG_NODUMP;
> 		error = syscall(468, dfd, "./foo", &fsx, 0);
> 		if (error) {
> 			printf("can not call 468: %s", strerror(errno));
> 			return error;
> 		}
> 
> 		printf("dir/foo flags: %d\n", fsx.fsx_xflags);
> 
> 		return error;
> 	}
> 
> SEE ALSO
> 
> 	ioctl(2), ioctl_iflags(2), ioctl_xfs_fsgetxattr(2)
> 
> ---
> Changes in v5:
> - Remove setting of LOOKUP_EMPTY flags which does not have any effect
> - Return -ENOSUPP from vfs_fileattr_set()
> - Add fsxattr masking (by Amir)
> - Fix UAF issue dentry
> - Fix getname_maybe_null() issue with NULL path
> - Implement file_getattr/file_setattr hooks
> - Return LSM return code from file_setattr
> - Rename from getfsxattrat/setfsxattrat to file_getattr/file_setattr
> - Link to v4: https://lore.kernel.org/r/20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org
> 
> Changes in v4:
> - Use getname_maybe_null() for correct handling of dfd + path semantic
> - Remove restriction for special files on which flags are allowed
> - Utilize copy_struct_from_user() for better future compatibility
> - Add draft man page to cover letter
> - Convert -ENOIOCTLCMD to -EOPNOSUPP as more appropriate for syscall
> - Add missing __user to header declaration of syscalls
> - Link to v3: https://lore.kernel.org/r/20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org
> 
> Changes in v3:
> - Remove unnecessary "dfd is dir" check as it checked in user_path_at()
> - Remove unnecessary "same filesystem" check
> - Use CLASS() instead of directly calling fdget/fdput
> - Link to v2: https://lore.kernel.org/r/20250122-xattrat-syscall-v2-1-5b360d4fbcb2@kernel.org
> 
> v1:
> https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@kernel.org/
> 
> Previous discussion:
> https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/
> 
> ---
> Amir Goldstein (1):
>       fs: prepare for extending file_get/setattr()
> 
> Andrey Albershteyn (6):
>       fs: split fileattr related helpers into separate file
>       lsm: introduce new hooks for setting/getting inode fsxattr
>       selinux: implement inode_file_[g|s]etattr hooks
>       fs: split fileattr/fsxattr converters into helpers
>       fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
>       fs: introduce file_getattr and file_setattr syscalls
> 
>  arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
>  arch/arm/tools/syscall.tbl                  |   2 +
>  arch/arm64/tools/syscall_32.tbl             |   2 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |   2 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |   2 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |   2 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
>  arch/s390/kernel/syscalls/syscall.tbl       |   2 +
>  arch/sh/kernel/syscalls/syscall.tbl         |   2 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
>  fs/Makefile                                 |   3 +-
>  fs/ecryptfs/inode.c                         |   8 +-
>  fs/file_attr.c                              | 475 ++++++++++++++++++++++++++++
>  fs/ioctl.c                                  | 309 ------------------
>  fs/overlayfs/inode.c                        |   2 +-
>  include/linux/fileattr.h                    |  26 ++
>  include/linux/lsm_hook_defs.h               |   2 +
>  include/linux/security.h                    |  16 +
>  include/linux/syscalls.h                    |   6 +
>  include/uapi/asm-generic/unistd.h           |   8 +-
>  include/uapi/linux/fs.h                     |   3 +
>  security/security.c                         |  30 ++
>  security/selinux/hooks.c                    |  14 +
>  29 files changed, 621 insertions(+), 313 deletions(-)
> ---
> base-commit: 0d8d44db295ccad20052d6301ef49ff01fb8ae2d
> change-id: 20250114-xattrat-syscall-6a1136d2db59
> 
> Best regards,
> -- 
> Andrey Albershteyn <aalbersh@kernel.org>
> 

Ignore please, somehow b4 crashed with timeout on gmail

-- 
- Andrey


