Return-Path: <linux-fsdevel+bounces-46979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DC9A96FB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B584D7A8E98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B728828FFF9;
	Tue, 22 Apr 2025 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT+fH8F6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FAD28EA6E;
	Tue, 22 Apr 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333959; cv=none; b=C9RR73dEZS5FaGiCyrS89VQZEDOx4fcRFY6bAgJPRv52X+TZ+2dcLqMNbCHJsa3ecdvL3dAtiJ3alx3Z2w2sIPw0NC9pU/H0vaT+igJKxftCkEL+PQl4wBItrnywDdbXvjah/OA4AWBT/vMc8kdIbMtenRVBTlNWDjJtg0W9SWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333959; c=relaxed/simple;
	bh=5XNFIOfOrJ2suYtdwtTBcJPzrzoFa/9LDQBwUYiUsvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olvg4SWqAXNC2Z1+mK1we2+Rt0oSQoeNiAtfiS1bjjHeGDr/XZW8LK+jpVmJR1jrIU6QIGTuiBmnJ9vtNO573+IY++h+c8fe5dH8zy9hv8mPsHGkeP00XLI6+cUqVsqukLzFbitdZMYobeoWKErPe8MR66yTitmiVedhq4LZmj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT+fH8F6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E6FC4CEE9;
	Tue, 22 Apr 2025 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745333957;
	bh=5XNFIOfOrJ2suYtdwtTBcJPzrzoFa/9LDQBwUYiUsvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BT+fH8F6LDJQPcw8ow7PWBx7NSBDw/N5nW4Cpzi8374b7rCLqjG1Ss/aGXCPJ/EjA
	 Myea/yfx2Mfp+GHGeBqrbq/eFhh5PCVTqtYGazVPdz3w/Iy34JVF276VaRue9BnzMr
	 gibqSgRxJK0KrF2mPf+Y9Mn082SJBzAW/5HR36Imrpqf4O5FNhA9JBnk1NqIg0Tt6V
	 J7eoJ+Wmb15IUfnGpKtyopKPgW9VpAjoewsYr0b69PhbUPb38NEFAMlNwKbDtjI1VF
	 nee4sY+q8nK3hjCsFrSR38mI3/KlZj0RBeKqxyBC/soyekbZXC4a75Sd7De7D9YgGF
	 pJALtqUVc2/tw==
Date: Tue, 22 Apr 2025 16:59:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
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
Message-ID: <20250422-abbekommen-begierde-bcf48dd74a2e@brauner>
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
 <20250321-xattrat-syscall-v4-3-3e82e6fb3264@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321-xattrat-syscall-v4-3-3e82e6fb3264@kernel.org>

On Fri, Mar 21, 2025 at 08:48:42PM +0100, Andrey Albershteyn wrote:
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
>  fs/inode.c                                  | 130 ++++++++++++++++++++++++++++
>  include/linux/syscalls.h                    |   6 ++
>  include/uapi/asm-generic/unistd.h           |   8 +-
>  include/uapi/linux/fs.h                     |   3 +
>  20 files changed, 178 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index c59d53d6d3f3490f976ca179ddfe02e69265ae4d..4b9e687494c16b60c6fd6ca1dc4d6564706a7e25 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -506,3 +506,5 @@
>  574	common	getxattrat			sys_getxattrat
>  575	common	listxattrat			sys_listxattrat
>  576	common	removexattrat			sys_removexattrat
> +577	common	getfsxattrat			sys_getfsxattrat
> +578	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 49eeb2ad8dbd8e074c6240417693f23fb328afa8..66466257f3c2debb3e2299f0b608c6740c98cab2 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -481,3 +481,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
> index 69a829912a05eb8a3e21ed701d1030e31c0148bc..9c516118b154811d8d11d5696f32817430320dbf 100644
> --- a/arch/arm64/tools/syscall_32.tbl
> +++ b/arch/arm64/tools/syscall_32.tbl
> @@ -478,3 +478,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index f5ed71f1910d09769c845c2d062d99ee0449437c..159476387f394a92ee5e29db89b118c630372db2 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -466,3 +466,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 680f568b77f2cbefc3eacb2517f276041f229b1e..a6d59ee740b58cacf823702003cf9bad17c0d3b7 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -472,3 +472,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index 0b9b7e25b69ad592642f8533bee9ccfe95ce9626..cfe38fcebe1a0279e11751378d3e71c5ec6b6569 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -405,3 +405,5 @@
>  464	n32	getxattrat			sys_getxattrat
>  465	n32	listxattrat			sys_listxattrat
>  466	n32	removexattrat			sys_removexattrat
> +467	n32	getfsxattrat			sys_getfsxattrat
> +468	n32	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index c844cd5cda620b2809a397cdd6f4315ab6a1bfe2..29a0c5974d1aa2f01e33edc0252d75fb97abe230 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -381,3 +381,5 @@
>  464	n64	getxattrat			sys_getxattrat
>  465	n64	listxattrat			sys_listxattrat
>  466	n64	removexattrat			sys_removexattrat
> +467	n64	getfsxattrat			sys_getfsxattrat
> +468	n64	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 349b8aad1159f404103bd2057a1e64e9bf309f18..6c00436807c57c492ba957fcd59af1202231cf80 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -454,3 +454,5 @@
>  464	o32	getxattrat			sys_getxattrat
>  465	o32	listxattrat			sys_listxattrat
>  466	o32	removexattrat			sys_removexattrat
> +467	o32	getfsxattrat			sys_getfsxattrat
> +468	o32	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index d9fc94c869657fcfbd7aca1d5f5abc9fae2fb9d8..b3578fac43d6b65167787fcc97d2d09f5a9828e7 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -465,3 +465,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index d8b4ab78bef076bd50d49b87dea5060fd8c1686a..808045d82c9465c3bfa96b15947546efe5851e9a 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -557,3 +557,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index e9115b4d8b635b846e5c9ad6ce229605323723a5..78dfc2c184d4815baf8a9e61c546c9936d58a47c 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -469,3 +469,5 @@
>  464  common	getxattrat		sys_getxattrat			sys_getxattrat
>  465  common	listxattrat		sys_listxattrat			sys_listxattrat
>  466  common	removexattrat		sys_removexattrat		sys_removexattrat
> +467  common	getfsxattrat		sys_getfsxattrat		sys_getfsxattrat
> +468  common	setfsxattrat		sys_setfsxattrat		sys_setfsxattrat
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index c8cad33bf250ea110de37bd1407f5a43ec5e38f2..d5a5c8339f0ed25ea07c4aba90351d352033c8a0 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -470,3 +470,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 727f99d333b304b3db0711953a3d91ece18a28eb..817dcd8603bcbffc47f3f59aa3b74b16486453d0 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -512,3 +512,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 4d0fb2fba7e208ae9455459afe11e277321d9f74..b4842c027c5d00c0236b2ba89387c5e2267447bd 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -472,3 +472,5 @@
>  464	i386	getxattrat		sys_getxattrat
>  465	i386	listxattrat		sys_listxattrat
>  466	i386	removexattrat		sys_removexattrat
> +467	i386	getfsxattrat		sys_getfsxattrat
> +468	i386	setfsxattrat		sys_setfsxattrat
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 5eb708bff1c791debd6cfc5322583b2ae53f6437..b6f0a7236aaee624cf9b484239a1068085a8ffe1 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -390,6 +390,8 @@
>  464	common	getxattrat		sys_getxattrat
>  465	common	listxattrat		sys_listxattrat
>  466	common	removexattrat		sys_removexattrat
> +467	common	getfsxattrat		sys_getfsxattrat
> +468	common	setfsxattrat		sys_setfsxattrat
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 37effc1b134eea061f2c350c1d68b4436b65a4dd..425d56be337d1de22f205ac503df61ff86224fee 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -437,3 +437,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/fs/inode.c b/fs/inode.c
> index 6b4c77268fc0ecace4ac78a9ca777fbffc277f4a..811debf379ab299f287ed90863277cfda27db30c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c

I really dislike the name fsxattr for a lot of reasons but it definitely
shouldn't go in inode.c. Just add a new fs/file_attr.c file and move all
the relevant helpers from fs/ioctl.c in there and then add the system
calls. Otherwise it's just all very confusing.

> @@ -23,6 +23,9 @@
>  #include <linux/rw_hint.h>
>  #include <linux/seq_file.h>
>  #include <linux/debugfs.h>
> +#include <linux/syscalls.h>
> +#include <linux/fileattr.h>
> +#include <linux/namei.h>
>  #include <trace/events/writeback.h>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/timestamp.h>
> @@ -2953,3 +2956,130 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
>  	return mode & ~S_ISGID;
>  }
>  EXPORT_SYMBOL(mode_strip_sgid);
> +
> +SYSCALL_DEFINE5(getfsxattrat, int, dfd, const char __user *, filename,

This is really misnamed. It will end up confusing userspace to no end:

getxattr()
getxattrat()
getfsxattrat()

Please name this file_setattr() and file_getattr(). There's also no need
for the *at() prefix. We've never been consistent with that. We have
plent of system calls that to fd+path without having an *at() prefix.
And here it's especially unneeded because there's no pre-existing system
calls that would even force the use of that prefix.

> +		struct fsxattr __user *, ufsx, size_t, usize,
> +		unsigned int, at_flags)
> +{
> +	struct fileattr fa = {};
> +	struct path filepath;
> +	int error;
> +	unsigned int lookup_flags = 0;
> +	struct filename *name;
> +	struct fsxattr fsx = {};
> +
> +	BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
> +	BUILD_BUG_ON(sizeof(struct fsxattr) != FSXATTR_SIZE_LATEST);
> +
> +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> +		return -EINVAL;
> +
> +	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> +		lookup_flags |= LOOKUP_FOLLOW;
> +
> +	if (at_flags & AT_EMPTY_PATH)
> +		lookup_flags |= LOOKUP_EMPTY;
> +
> +	if (usize > PAGE_SIZE)
> +		return -E2BIG;
> +
> +	if (usize < FSXATTR_SIZE_VER0)
> +		return -EINVAL;
> +
> +	name = getname_maybe_null(filename, at_flags);
> +	if (!name) {

This is broken as it doesn't handle AT_FDCWD correctly. You need:

        name = getname_maybe_null(filename, at_flags);
        if (IS_ERR(name))
                return PTR_ERR(name);

        if (!name && dfd >= 0) {
		CLASS(fd, f)(dfd);


> +		CLASS(fd, f)(dfd);
> +
> +		if (fd_empty(f))
> +			return -EBADF;

I'm pretty sure you can just do a:

                path = fd_file(f_to)->f_path;
                path_get(&path);

and then the vfs_fileattr_get() call and the path_put() call can be
shared between the two branches. Note that you can also use:

struct path path __free(path_put) = NULL;

and then the cleanup infrastructure will handle the path_put() for you.

> +		error = vfs_fileattr_get(file_dentry(fd_file(f)), &fa);
> +	} else {
> +		error = filename_lookup(dfd, name, lookup_flags, &filepath,
> +					NULL);
> +		if (error)
> +			goto out;
> +		error = vfs_fileattr_get(filepath.dentry, &fa);
> +		path_put(&filepath);
> +	}
> +	if (error == -ENOIOCTLCMD)
> +		error = -EOPNOTSUPP;
> +	if (!error) {
> +		fileattr_to_fsxattr(&fa, &fsx);
> +		error = copy_struct_to_user(ufsx, usize, &fsx,
> +					    sizeof(struct fsxattr), NULL);
> +	}
> +out:
> +	putname(name);
> +	return error;
> +}
> +
> +SYSCALL_DEFINE5(setfsxattrat, int, dfd, const char __user *, filename,
> +		struct fsxattr __user *, ufsx, size_t, usize,
> +		unsigned int, at_flags)
> +{
> +	struct fileattr fa;
> +	struct path filepath;
> +	int error;
> +	unsigned int lookup_flags = 0;
> +	struct filename *name;
> +	struct mnt_idmap *idmap;
> +	struct dentry *dentry;
> +	struct vfsmount *mnt;
> +	struct fsxattr fsx = {};
> +
> +	BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
> +	BUILD_BUG_ON(sizeof(struct fsxattr) != FSXATTR_SIZE_LATEST);
> +
> +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> +		return -EINVAL;
> +
> +	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> +		lookup_flags |= LOOKUP_FOLLOW;
> +
> +	if (at_flags & AT_EMPTY_PATH)
> +		lookup_flags |= LOOKUP_EMPTY;
> +
> +	if (usize > PAGE_SIZE)
> +		return -E2BIG;
> +
> +	if (usize < FSXATTR_SIZE_VER0)
> +		return -EINVAL;
> +
> +	error = copy_struct_from_user(&fsx, sizeof(struct fsxattr), ufsx, usize);
> +	if (error)
> +		return error;
> +
> +	fsxattr_to_fileattr(&fsx, &fa);
> +
> +	name = getname_maybe_null(filename, at_flags);
> +	if (!name) {

Same comment as above.

> +		CLASS(fd, f)(dfd);
> +
> +		if (fd_empty(f))
> +			return -EBADF;
> +
> +		idmap = file_mnt_idmap(fd_file(f));
> +		dentry = file_dentry(fd_file(f));
> +		mnt = fd_file(f)->f_path.mnt;

This is a UAF. fd_file(f)->f_path.mnt and file_dentry(fd_file(f)) will
get auto cleaned at the end of the scope. By the time you call
vfs_fileattr_set() nothing pins them anymore...

In general, same comment about unifying the branches as for the get case
via path_get() as above. And just keep the path around don't store mount
and dentry separately.

> +	} else {
> +		error = filename_lookup(dfd, name, lookup_flags, &filepath,
> +					NULL);
> +		if (error)
> +			return error;
> +
> +		idmap = mnt_idmap(filepath.mnt);
> +		dentry = filepath.dentry;
> +		mnt = filepath.mnt;
> +	}
> +
> +	error = mnt_want_write(mnt);
> +	if (!error) {
> +		error = vfs_fileattr_set(idmap, dentry, &fa);
> +		if (error == -ENOIOCTLCMD)
> +			error = -EOPNOTSUPP;
> +		mnt_drop_write(mnt);
> +	}
> +
> +	path_put(&filepath);
> +	return error;
> +}
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index c6333204d45130eb022f6db460eea34a1f6e91db..e242ea39b3e63a8008bc777764b616fd63bd40c4 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -371,6 +371,12 @@ asmlinkage long sys_removexattrat(int dfd, const char __user *path,
>  asmlinkage long sys_lremovexattr(const char __user *path,
>  				 const char __user *name);
>  asmlinkage long sys_fremovexattr(int fd, const char __user *name);
> +asmlinkage long sys_getfsxattrat(int dfd, const char __user *filename,
> +				 struct fsxattr __user *ufsx, size_t usize,
> +				 unsigned int at_flags);
> +asmlinkage long sys_setfsxattrat(int dfd, const char __user *filename,
> +				 struct fsxattr __user *ufsx, size_t usize,
> +				 unsigned int at_flags);
>  asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
>  asmlinkage long sys_eventfd2(unsigned int count, int flags);
>  asmlinkage long sys_epoll_create1(int flags);
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 88dc393c2bca38c0fa1b3fae579f7cfe4931223c..50be2e1007bc2779120d05c6e9512a689f86779c 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -850,8 +850,14 @@ __SYSCALL(__NR_listxattrat, sys_listxattrat)
>  #define __NR_removexattrat 466
>  __SYSCALL(__NR_removexattrat, sys_removexattrat)
>  
> +/* fs/inode.c */
> +#define __NR_getfsxattrat 467
> +__SYSCALL(__NR_getfsxattrat, sys_getfsxattrat)
> +#define __NR_setfsxattrat 468
> +__SYSCALL(__NR_setfsxattrat, sys_setfsxattrat)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 467
> +#define __NR_syscalls 469
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 7539717707337a8cb22396a869baba3bafa08371..aed753e5d50c97da9b895a187fdaecf0477db74b 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -139,6 +139,9 @@ struct fsxattr {
>  	unsigned char	fsx_pad[8];
>  };
>  
> +#define FSXATTR_SIZE_VER0 28
> +#define FSXATTR_SIZE_LATEST FSXATTR_SIZE_VER0
> +
>  /*
>   * Flags for the fsx_xflags field
>   */
> 
> -- 
> 2.47.2
> 

