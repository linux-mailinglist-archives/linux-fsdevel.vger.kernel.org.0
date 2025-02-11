Return-Path: <linux-fsdevel+bounces-41535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E50F2A314C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 20:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520FE1885169
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 19:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202C8263892;
	Tue, 11 Feb 2025 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NLERuApj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5091262D3B;
	Tue, 11 Feb 2025 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301228; cv=none; b=Jbs3oBTSlHFmGAZlP8dno5IYBqWcKSviemj+nVwfA5VPbDd0vGY5rf0TP0MhS5xAywkmVYPKOcuTqOmMSOqDoM/K02pPgQ6XsP3nvrcxF9U0pzF6XkSuvaH+5NC+GP6kUZgC5lIETDajiwvdBsmHEY1qvVX4uiqnbQtULjk+4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301228; c=relaxed/simple;
	bh=RpGEYLBRU6yCdlVZy5DAzsxAVLWrL6BjzUciYfTI8VQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gbwF+FLvZ1+4oVCYfyxgPfLAfposhkIkPZtHsEfbMOSVV90J8cfmUumYof0y3EBmwT6TRHhN3/6P3l/ip9623wmKB7x4CEr3CvqHAscKnXFsStci2FOxzjjN8EO3j+1GTbKhZQg1GcMmCDBpCSsAfhwgy2DOfhNiW6hL+iqa0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=NLERuApj; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.56.15.103])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51BJ9fZR2697133
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Feb 2025 11:09:42 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51BJ9fZR2697133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025011701; t=1739300987;
	bh=DYbLyjH38YQk1Y17HnGBVIZL+1Ob/ZWNVuOGltbBEKI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=NLERuApjM9AAzB4zebAjRm5wzYVRu2z4LBbFyYlRkgVhDgorVfNoOGF7HvB/5hgfv
	 yaSSv/y6q/6hmZKAH15gtfIl+aSdOUN7MJcbxEunpwb3O7MyNqGUmuHhXQovu9d/zS
	 EvyYwHLgFbrhJ794YVb7NzwfNB/mqgrgkRsv3kyCpSRHBoCJWNxfn8INBhcho9EOcv
	 pjHAGO3rAOGCkdHbTJDd6SYB/8hkM0ijjJHlmz7lOsToVBK5fJ4kXmRZ/6JBMIdWVN
	 3nm1f/+jvQ7GQMH2QG9Qa3fB7Y3GFnIlIuNGyHAV2OVBlff4k0WgHuywP1FaJ+ghYP
	 o6CAThiBNT7oQ==
Date: Tue, 11 Feb 2025 11:09:33 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrey Albershteyn <aalbersh@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.osdn.me>, Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther_Noack?= <gnoack@google.com>,
        Arnd Bergmann <arnd@arndb.de>
CC: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
User-Agent: K-9 Mail for Android
In-Reply-To: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
Message-ID: <6AE6F936-1ACF-4951-BD2A-B79E7AB706DF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 11, 2025 9:22:47 AM PST, Andrey Albershteyn <aalbersh@redhat=2E=
com> wrote:
>From: Andrey Albershteyn <aalbersh@redhat=2Ecom>
>
>Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
>extended attributes/flags=2E The syscalls take parent directory fd and
>path to the child together with struct fsxattr=2E
>
>This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
>that file don't need to be open as we can reference it with a path
>instead of fd=2E By having this we can manipulated inode extended
>attributes not only on regular files but also on special ones=2E This
>is not possible with FS_IOC_FSSETXATTR ioctl as with special files
>we can not call ioctl() directly on the filesystem inode using fd=2E
>
>This patch adds two new syscalls which allows userspace to get/set
>extended inode attributes on special files by using parent directory
>and a path - *at() like syscall=2E
>
>Also, as vfs_fileattr_set() is now will be called on special files
>too, let's forbid any other attributes except projid and nextents
>(symlink can have an extent)=2E
>
>CC: linux-api@vger=2Ekernel=2Eorg
>CC: linux-fsdevel@vger=2Ekernel=2Eorg
>CC: linux-xfs@vger=2Ekernel=2Eorg
>Signed-off-by: Andrey Albershteyn <aalbersh@redhat=2Ecom>
>---
>v1:
>https://lore=2Ekernel=2Eorg/linuxppc-dev/20250109174540=2E893098-1-aalber=
sh@kernel=2Eorg/
>
>Previous discussion:
>https://lore=2Ekernel=2Eorg/linux-xfs/20240520164624=2E665269-2-aalbersh@=
redhat=2Ecom/
>
>XFS has project quotas which could be attached to a directory=2E All
>new inodes in these directories inherit project ID set on parent
>directory=2E
>
>The project is created from userspace by opening and calling
>FS_IOC_FSSETXATTR on each inode=2E This is not possible for special
>files such as FIFO, SOCK, BLK etc=2E Therefore, some inodes are left
>with empty project ID=2E Those inodes then are not shown in the quota
>accounting but still exist in the directory=2E Moreover, in the case
>when special files are created in the directory with already
>existing project quota, these inode inherit extended attributes=2E
>This than leaves them with these attributes without the possibility
>to clear them out=2E This, in turn, prevents userspace from
>re-creating quota project on these existing files=2E
>---
>Changes in v3:
>- Remove unnecessary "dfd is dir" check as it checked in user_path_at()
>- Remove unnecessary "same filesystem" check
>- Use CLASS() instead of directly calling fdget/fdput
>- Link to v2: https://lore=2Ekernel=2Eorg/r/20250122-xattrat-syscall-v2-1=
-5b360d4fbcb2@kernel=2Eorg
>---
> arch/alpha/kernel/syscalls/syscall=2Etbl      |  2 +
> arch/arm/tools/syscall=2Etbl                  |  2 +
> arch/arm64/tools/syscall_32=2Etbl             |  2 +
> arch/m68k/kernel/syscalls/syscall=2Etbl       |  2 +
> arch/microblaze/kernel/syscalls/syscall=2Etbl |  2 +
> arch/mips/kernel/syscalls/syscall_n32=2Etbl   |  2 +
> arch/mips/kernel/syscalls/syscall_n64=2Etbl   |  2 +
> arch/mips/kernel/syscalls/syscall_o32=2Etbl   |  2 +
> arch/parisc/kernel/syscalls/syscall=2Etbl     |  2 +
> arch/powerpc/kernel/syscalls/syscall=2Etbl    |  2 +
> arch/s390/kernel/syscalls/syscall=2Etbl       |  2 +
> arch/sh/kernel/syscalls/syscall=2Etbl         |  2 +
> arch/sparc/kernel/syscalls/syscall=2Etbl      |  2 +
> arch/x86/entry/syscalls/syscall_32=2Etbl      |  2 +
> arch/x86/entry/syscalls/syscall_64=2Etbl      |  2 +
> arch/xtensa/kernel/syscalls/syscall=2Etbl     |  2 +
> fs/inode=2Ec                                  | 75 +++++++++++++++++++++=
++++++++
> fs/ioctl=2Ec                                  | 16 +++++-
> include/linux/fileattr=2Eh                    |  1 +
> include/linux/syscalls=2Eh                    |  4 ++
> include/uapi/asm-generic/unistd=2Eh           |  8 ++-
> 21 files changed, 133 insertions(+), 3 deletions(-)
>
>diff --git a/arch/alpha/kernel/syscalls/syscall=2Etbl b/arch/alpha/kernel=
/syscalls/syscall=2Etbl
>index c59d53d6d3f3490f976ca179ddfe02e69265ae4d=2E=2E4b9e687494c16b60c6fd6=
ca1dc4d6564706a7e25 100644
>--- a/arch/alpha/kernel/syscalls/syscall=2Etbl
>+++ b/arch/alpha/kernel/syscalls/syscall=2Etbl
>@@ -506,3 +506,5 @@
> 574	common	getxattrat			sys_getxattrat
> 575	common	listxattrat			sys_listxattrat
> 576	common	removexattrat			sys_removexattrat
>+577	common	getfsxattrat			sys_getfsxattrat
>+578	common	setfsxattrat			sys_setfsxattrat
>diff --git a/arch/arm/tools/syscall=2Etbl b/arch/arm/tools/syscall=2Etbl
>index 49eeb2ad8dbd8e074c6240417693f23fb328afa8=2E=2E66466257f3c2debb3e229=
9f0b608c6740c98cab2 100644
>--- a/arch/arm/tools/syscall=2Etbl
>+++ b/arch/arm/tools/syscall=2Etbl
>@@ -481,3 +481,5 @@
> 464	common	getxattrat			sys_getxattrat
> 465	common	listxattrat			sys_listxattrat
> 466	common	removexattrat			sys_removexattrat
>+467	common	getfsxattrat			sys_getfsxattrat
>+468	common	setfsxattrat			sys_setfsxattrat
>diff --git a/arch/arm64/tools/syscall_32=2Etbl b/arch/arm64/tools/syscall=
_32=2Etbl
>index 69a829912a05eb8a3e21ed701d1030e31c0148bc=2E=2E9c516118b154811d8d11d=
5696f32817430320dbf 100644
>--- a/arch/arm64/tools/syscall_32=2Etbl
>+++ b/arch/arm64/tools/syscall_32=2Etbl
>@@ -478,3 +478,5 @@
> 464	common	getxattrat			sys_getxattrat
> 465	common	listxattrat			sys_listxattrat
> 466	common	removexattrat			sys_removexattrat
>+467	common	getfsxattrat			sys_getfsxattrat
>+468	common	setfsxattrat			sys_setfsxattrat
>diff --git a/arch/m68k/kernel/syscalls/syscall=2Etbl b/arch/m68k/kernel/s=
yscalls/syscall=2Etbl
>index f5ed71f1910d09769c845c2d062d99ee0449437c=2E=2E159476387f394a92ee5e2=
9db89b118c630372db2 100644
>--- a/arch/m68k/kernel/syscalls/syscall=2Etbl
>+++ b/arch/m68k/kernel/syscalls/syscall=2Etbl
>@@ -466,3 +466,5 @@
> 464	common	getxattrat			sys_getxattrat
> 465	common	listxattrat			sys_listxattrat
> 466	common	removexattrat			sys_removexattrat
>+467	common	getfsxattrat			sys_getfsxattrat
>+468	common	setfsxattrat			sys_setfsxattrat
>diff --git a/arch/microblaze/kernel/syscalls/syscall=2Etbl b/arch/microbl=
aze/kernel/syscalls/syscall=2Etbl
>index 680f568b77f2cbefc3eacb2517f276041f229b1e=2E=2Ea6d59ee740b58cacf8237=
02003cf9bad17c0d3b7 100644
>--- a/arch/microblaze/kernel/syscalls/syscall=2Etbl
>+++ b/arch/microblaze/kernel/syscalls/syscall=2Etbl
>@@ -472,3 +472,5 @@
> 464	common	getxattrat			sys_getxattrat
> 465	common	listxattrat			sys_listxattrat
> 466	common	removexattrat			sys_removexattrat
>+467	common	getfsxattrat			sys_getfsxattrat
>+468	common	setfsxattrat			sys_setfsxattrat
>diff --git a/arch/mips/kernel/syscalls/syscall_n32=2Etbl b/arch/mips/kern=
el/syscalls/syscall_n32=2Etbl
>index 0b9b7e25b69ad592642f8533bee9ccfe95ce9626=2E=2Ecfe38fcebe1a0279e1175=
1378d3e71c5ec6b6569 100644
>--- a/arch/mips/kernel/syscalls/syscall_n32=2Etbl
>+++ b/arch/mips/kernel/syscalls/syscall_n32=2Etbl
>@@ -405,3 +405,5 @@
> 464	n32	getxattrat			sys_getxattrat
> 465	n32	listxattrat			sys_listxattrat
> 466	n32	removexattrat			sys_removexattrat
>+467	n32	getfsxattrat			sys_getfsxattrat
>+468	n32	setfsxattrat			sys_setfsxattrat
>diff --git a/arch/mips/kernel/syscalls/syscall_n64=2Etbl b/arch/mips/kern=
el/syscalls/syscall_n64=2Etbl
>index c844cd5cda620b2809a397cdd6f4315ab6a1bfe2=2E=2E29a0c5974d1aa2f01e33e=
dc0252d75fb97abe230 100644
>--- a/arch/mips/kernel/syscalls/syscall_n64=2Etbl
>+++ b/arch/mips/kernel/syscalls/syscall_n64=2Etbl
>@@ -381,3 +381,5 @@
> 464	n64	getxattrat			sys_getxattrat
> 465	n64	listxattrat			sys_listxattrat
> 466	n64	removexattrat			sys_removexattrat
>+467	n64	getfsxattrat			sys_getfsxattrat
>+468	n64	setfsxattrat			sys_setfsxattrat
>diff --git a/arch/mips/kernel/syscalls/syscall_o32=2Etbl b/arch/mips/kern=
el/syscalls/syscall_o32=2Etbl
>index 349b8aad1159f404103bd2057a1e64e9bf309f18=2E=2E6c00436807c57c492ba95=
7fcd59af1202231cf80 100644
>--- a/arch/mips/kernel/syscalls/syscall_o32=2Etbl
>+++ b/arch/mips/kernel/syscalls/syscall_o32=2Etbl
>@@ -454,3 +454,5 @@
> 464	o32	getxattrat			sys_getxattrat
> 465	o32	listxattrat			sys_listxattrat
> 466	o32	removexattrat			sys_removexattrat
>+467	o32	getfsxattrat			sys_getfsxattrat
>+468	o32	setfsxattrat			sys_setfsxattrat
>diff --git a/arch/parisc/kernel/syscalls/syscall=2Etbl b/arch/parisc/kern=
el/syscalls/syscall=2Etbl
>index d9fc94c869657fcfbd7aca1d5f5abc9fae2fb9d8=2E=2Eb3578fac43d6b65167787=
fcc97d2d09f5a9828e7 100644
>--- a/arch/parisc/kernel/syscalls/syscall=2Etbl
>+++ b/arch/parisc/kernel/syscalls/syscall=2Etbl
>@@ -465,3 +465,5 @@
> 464	common	getxattrat			sys_getxattrat
> 465	common	listxattrat			sys_listxattrat
> 466	common	removexattrat			sys_removexattrat
>+467	common	getfsxattrat			sys_getfsxattrat
>+468	common	setfsxattrat			sys_setfsxattrat
>diff --git a/arch/powerpc/kernel/syscalls/syscall=2Etbl b/arch/powerpc/ke=
rnel/syscalls/syscall=2Etbl
>index d8b4ab78bef076bd50d49b87dea5060fd8c1686a=2E=2E808045d82c9465c3bfa96=
b15947546efe5851e9a 100644
>--- a/arch/powerpc/kernel/syscalls/syscall=2Etbl
>+++ b/arch/powerpc/kernel/syscalls/syscall=2Etbl
>@@ -557,3 +557,5 @@
> 464	common	getxattrat			sys_getxattrat
> 465	common	listxattrat			sys_listxattrat
> 466	common	removexattrat			sys_removexattrat
>+467	common	getfsxattrat			sys_getfsxattrat
>+468	common	setfsxattrat			sys_setfsxattrat
>diff --git a/arch/s390/kernel/syscalls/syscall=2Etbl b/arch/s390/kernel/s=
yscalls/syscall=2Etbl
>index e9115b4d8b635b846e5c9ad6ce229605323723a5=2E=2E78dfc2c184d4815baf8a9=
e61c546c9936d58a47c 100644
>--- a/arch/s390/kernel/syscalls/syscall=2Etbl
>+++ b/arch/s390/kernel/syscalls/syscall=2Etbl
>@@ -469,3 +469,5 @@
> 464  common	getxattrat		sys_getxattrat			sys_getxattrat
> 465  common	listxattrat		sys_listxattrat			sys_listxattrat
> 466  common	removexattrat		sys_removexattrat		sys_removexattrat
>+467  common	getfsxattrat		sys_getfsxattrat		sys_getfsxattrat
>+468  common	setfsxattrat		sys_setfsxattrat		sys_setfsxattrat
>diff --git a/arch/sh/kernel/syscalls/syscall=2Etbl b/arch/sh/kernel/sysca=
lls/syscall=2Etbl
>index c8cad33bf250ea110de37bd1407f5a43ec5e38f2=2E=2Ed5a5c8339f0ed25ea07c4=
aba90351d352033c8a0 100644
>--- a/arch/sh/kernel/syscalls/syscall=2Etbl
>+++ b/arch/sh/kernel/syscalls/syscall=2Etbl
>@@ -470,3 +470,5 @@
> 464	common	getxattrat			sys_getxattrat
> 465	common	listxattrat			sys_listxattrat
> 466	common	removexattrat			sys_removexattrat
>+467	common	getfsxattrat			sys_getfsxattrat
>+468	common	setfsxattrat			sys_setfsxattrat
>diff --git a/arch/sparc/kernel/syscalls/syscall=2Etbl b/arch/sparc/kernel=
/syscalls/syscall=2Etbl
>index 727f99d333b304b3db0711953a3d91ece18a28eb=2E=2E817dcd8603bcbffc47f3f=
59aa3b74b16486453d0 100644
>--- a/arch/sparc/kernel/syscalls/syscall=2Etbl
>+++ b/arch/sparc/kernel/syscalls/syscall=2Etbl
>@@ -512,3 +512,5 @@
> 464	common	getxattrat			sys_getxattrat
> 465	common	listxattrat			sys_listxattrat
> 466	common	removexattrat			sys_removexattrat
>+467	common	getfsxattrat			sys_getfsxattrat
>+468	common	setfsxattrat			sys_setfsxattrat
>diff --git a/arch/x86/entry/syscalls/syscall_32=2Etbl b/arch/x86/entry/sy=
scalls/syscall_32=2Etbl
>index 4d0fb2fba7e208ae9455459afe11e277321d9f74=2E=2Eb4842c027c5d00c0236b2=
ba89387c5e2267447bd 100644
>--- a/arch/x86/entry/syscalls/syscall_32=2Etbl
>+++ b/arch/x86/entry/syscalls/syscall_32=2Etbl
>@@ -472,3 +472,5 @@
> 464	i386	getxattrat		sys_getxattrat
> 465	i386	listxattrat		sys_listxattrat
> 466	i386	removexattrat		sys_removexattrat
>+467	i386	getfsxattrat		sys_getfsxattrat
>+468	i386	setfsxattrat		sys_setfsxattrat
>diff --git a/arch/x86/entry/syscalls/syscall_64=2Etbl b/arch/x86/entry/sy=
scalls/syscall_64=2Etbl
>index 5eb708bff1c791debd6cfc5322583b2ae53f6437=2E=2Eb6f0a7236aaee624cf9b4=
84239a1068085a8ffe1 100644
>--- a/arch/x86/entry/syscalls/syscall_64=2Etbl
>+++ b/arch/x86/entry/syscalls/syscall_64=2Etbl
>@@ -390,6 +390,8 @@
> 464	common	getxattrat		sys_getxattrat
> 465	common	listxattrat		sys_listxattrat
> 466	common	removexattrat		sys_removexattrat
>+467	common	getfsxattrat		sys_getfsxattrat
>+468	common	setfsxattrat		sys_setfsxattrat
>=20
> #
> # Due to a historical design error, certain syscalls are numbered differ=
ently
>diff --git a/arch/xtensa/kernel/syscalls/syscall=2Etbl b/arch/xtensa/kern=
el/syscalls/syscall=2Etbl
>index 37effc1b134eea061f2c350c1d68b4436b65a4dd=2E=2E425d56be337d1de22f205=
ac503df61ff86224fee 100644
>--- a/arch/xtensa/kernel/syscalls/syscall=2Etbl
>+++ b/arch/xtensa/kernel/syscalls/syscall=2Etbl
>@@ -437,3 +437,5 @@
> 464	common	getxattrat			sys_getxattrat
> 465	common	listxattrat			sys_listxattrat
> 466	common	removexattrat			sys_removexattrat
>+467	common	getfsxattrat			sys_getfsxattrat
>+468	common	setfsxattrat			sys_setfsxattrat
>diff --git a/fs/inode=2Ec b/fs/inode=2Ec
>index 6b4c77268fc0ecace4ac78a9ca777fbffc277f4a=2E=2Eb2dddd9db4fabaf67a6cb=
f541a86978b290411ec 100644
>--- a/fs/inode=2Ec
>+++ b/fs/inode=2Ec
>@@ -23,6 +23,9 @@
> #include <linux/rw_hint=2Eh>
> #include <linux/seq_file=2Eh>
> #include <linux/debugfs=2Eh>
>+#include <linux/syscalls=2Eh>
>+#include <linux/fileattr=2Eh>
>+#include <linux/namei=2Eh>
> #include <trace/events/writeback=2Eh>
> #define CREATE_TRACE_POINTS
> #include <trace/events/timestamp=2Eh>
>@@ -2953,3 +2956,75 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
> 	return mode & ~S_ISGID;
> }
> EXPORT_SYMBOL(mode_strip_sgid);
>+
>+SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
>+		struct fsxattr __user *, fsx, unsigned int, at_flags)
>+{
>+	CLASS(fd, dir)(dfd);
>+	struct fileattr fa;
>+	struct path filepath;
>+	int error;
>+	unsigned int lookup_flags =3D 0;
>+
>+	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) !=3D 0)
>+		return -EINVAL;
>+
>+	if (at_flags & AT_SYMLINK_FOLLOW)
>+		lookup_flags |=3D LOOKUP_FOLLOW;
>+
>+	if (at_flags & AT_EMPTY_PATH)
>+		lookup_flags |=3D LOOKUP_EMPTY;
>+
>+	if (fd_empty(dir))
>+		return -EBADF;
>+
>+	error =3D user_path_at(dfd, filename, lookup_flags, &filepath);
>+	if (error)
>+		return error;
>+
>+	error =3D vfs_fileattr_get(filepath=2Edentry, &fa);
>+	if (!error)
>+		error =3D copy_fsxattr_to_user(&fa, fsx);
>+
>+	path_put(&filepath);
>+	return error;
>+}
>+
>+SYSCALL_DEFINE4(setfsxattrat, int, dfd, const char __user *, filename,
>+		struct fsxattr __user *, fsx, unsigned int, at_flags)
>+{
>+	CLASS(fd, dir)(dfd);
>+	struct fileattr fa;
>+	struct path filepath;
>+	int error;
>+	unsigned int lookup_flags =3D 0;
>+
>+	if ((at_flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) !=3D 0)
>+		return -EINVAL;
>+
>+	if (at_flags & AT_SYMLINK_FOLLOW)
>+		lookup_flags |=3D LOOKUP_FOLLOW;
>+
>+	if (at_flags & AT_EMPTY_PATH)
>+		lookup_flags |=3D LOOKUP_EMPTY;
>+
>+	if (fd_empty(dir))
>+		return -EBADF;
>+
>+	if (copy_fsxattr_from_user(&fa, fsx))
>+		return -EFAULT;
>+
>+	error =3D user_path_at(dfd, filename, lookup_flags, &filepath);
>+	if (error)
>+		return error;
>+
>+	error =3D mnt_want_write(filepath=2Emnt);
>+	if (!error) {
>+		error =3D vfs_fileattr_set(file_mnt_idmap(fd_file(dir)),
>+					 filepath=2Edentry, &fa);
>+		mnt_drop_write(filepath=2Emnt);
>+	}
>+
>+	path_put(&filepath);
>+	return error;
>+}
>diff --git a/fs/ioctl=2Ec b/fs/ioctl=2Ec
>index 638a36be31c14afc66a7fd6eb237d9545e8ad997=2E=2Edc160c2ef145e4931d625=
f1f93c2a8ae7f87abf3 100644
>--- a/fs/ioctl=2Ec
>+++ b/fs/ioctl=2Ec
>@@ -558,8 +558,7 @@ int copy_fsxattr_to_user(const struct fileattr *fa, s=
truct fsxattr __user *ufa)
> }
> EXPORT_SYMBOL(copy_fsxattr_to_user);
>=20
>-static int copy_fsxattr_from_user(struct fileattr *fa,
>-				  struct fsxattr __user *ufa)
>+int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *u=
fa)
> {
> 	struct fsxattr xfa;
>=20
>@@ -646,6 +645,19 @@ static int fileattr_set_prepare(struct inode *inode,
> 	if (fa->fsx_cowextsize =3D=3D 0)
> 		fa->fsx_xflags &=3D ~FS_XFLAG_COWEXTSIZE;
>=20
>+	/*
>+	 * The only use case for special files is to set project ID, forbid any
>+	 * other attributes
>+	 */
>+	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
>+		if (fa->fsx_xflags & ~FS_XFLAG_PROJINHERIT)
>+			return -EINVAL;
>+		if (!S_ISLNK(inode->i_mode) && fa->fsx_nextents)
>+			return -EINVAL;
>+		if (fa->fsx_extsize || fa->fsx_cowextsize)
>+			return -EINVAL;
>+	}
>+
> 	return 0;
> }
>=20
>diff --git a/include/linux/fileattr=2Eh b/include/linux/fileattr=2Eh
>index 47c05a9851d0600964b644c9c7218faacfd865f8=2E=2E8598e94b530b8b280a269=
7eaf918dd60f573d6ee 100644
>--- a/include/linux/fileattr=2Eh
>+++ b/include/linux/fileattr=2Eh
>@@ -34,6 +34,7 @@ struct fileattr {
> };
>=20
> int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __use=
r *ufa);
>+int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *u=
fa);
>=20
> void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
> void fileattr_fill_flags(struct fileattr *fa, u32 flags);
>diff --git a/include/linux/syscalls=2Eh b/include/linux/syscalls=2Eh
>index c6333204d45130eb022f6db460eea34a1f6e91db=2E=2E3134d463d9af64c6e78ad=
b37bff4b91f77b5305f 100644
>--- a/include/linux/syscalls=2Eh
>+++ b/include/linux/syscalls=2Eh
>@@ -371,6 +371,10 @@ asmlinkage long sys_removexattrat(int dfd, const cha=
r __user *path,
> asmlinkage long sys_lremovexattr(const char __user *path,
> 				 const char __user *name);
> asmlinkage long sys_fremovexattr(int fd, const char __user *name);
>+asmlinkage long sys_getfsxattrat(int dfd, const char __user *filename,
>+				 struct fsxattr *fsx, unsigned int at_flags);
>+asmlinkage long sys_setfsxattrat(int dfd, const char __user *filename,
>+				 struct fsxattr *fsx, unsigned int at_flags);
> asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
> asmlinkage long sys_eventfd2(unsigned int count, int flags);
> asmlinkage long sys_epoll_create1(int flags);
>diff --git a/include/uapi/asm-generic/unistd=2Eh b/include/uapi/asm-gener=
ic/unistd=2Eh
>index 88dc393c2bca38c0fa1b3fae579f7cfe4931223c=2E=2E50be2e1007bc2779120d0=
5c6e9512a689f86779c 100644
>--- a/include/uapi/asm-generic/unistd=2Eh
>+++ b/include/uapi/asm-generic/unistd=2Eh
>@@ -850,8 +850,14 @@ __SYSCALL(__NR_listxattrat, sys_listxattrat)
> #define __NR_removexattrat 466
> __SYSCALL(__NR_removexattrat, sys_removexattrat)
>=20
>+/* fs/inode=2Ec */
>+#define __NR_getfsxattrat 467
>+__SYSCALL(__NR_getfsxattrat, sys_getfsxattrat)
>+#define __NR_setfsxattrat 468
>+__SYSCALL(__NR_setfsxattrat, sys_setfsxattrat)
>+
> #undef __NR_syscalls
>-#define __NR_syscalls 467
>+#define __NR_syscalls 469
>=20
> /*
>  * 32 bit systems traditionally used different
>
>---
>base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
>change-id: 20250114-xattrat-syscall-6a1136d2db59
>
>Best regards,

Could you please give a quick description of the API =E2=80=93 even just t=
he prototype =E2=80=93 and, for the future, include in the cover letter?

