Return-Path: <linux-fsdevel+bounces-41982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C890EA3997D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 11:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACE618876FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3A9239567;
	Tue, 18 Feb 2025 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiaG3eyU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5823716F
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875642; cv=none; b=hNMHSx0adGe0FxSiBFgKRF8taegRnCqvkkeuFgb2BLICxIU669Xe3IPvXjJnNneTMXDW5U9+3B4BeXX58ZI2Kv0tsef3WU/6t/sUR6/5dkbB7yoEU3BvUwhDZEV3HdJCoKzZ67FCIPG2UWlaBu8erDRhpf/x+Njb/8FOHNJQBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875642; c=relaxed/simple;
	bh=m6x83XXgK0LWOdngv9dpvmnSrqVpOaFeHWLJ3zbx7ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHjMlpakCwJ5nSefsTgdRsq/bNIZgp1p+1NEoFFARlPmAzMFGNtGWInkDT1/8l6f03omgyfv9PCUpNkfcDHDulD3sxHsUVasz4Tbt7HzDm9aSfEuWOZ8yejcuPX+XsYSlPVTB/Mc5RFngHDBVVkPxfCHVF8B37351uvHKFGKzuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiaG3eyU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739875637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXcsnJi++Pk2cLSeIniLPbmOjSFdWLOhirfJFMOIji8=;
	b=OiaG3eyUSy3xNUJozvEyoz3Z+ekKAhVkg2M7HPpIoC8GnLOJbwSIwnddq6x/9gIecfp7lS
	OyO2mFfn5y5647L4wi+ojtGOD5fKFpPNJ3QUbYVGBgHw7OEB3B7ybXKos7sDWXUMqM3U08
	8SGWtmyin/pNJSzJ1AiXyVtmnZ5cOQ4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-a7dmu-r4NqujcPgKt1QDmQ-1; Tue, 18 Feb 2025 05:47:16 -0500
X-MC-Unique: a7dmu-r4NqujcPgKt1QDmQ-1
X-Mimecast-MFC-AGG-ID: a7dmu-r4NqujcPgKt1QDmQ_1739875635
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abb61c30566so256095466b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 02:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739875635; x=1740480435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXcsnJi++Pk2cLSeIniLPbmOjSFdWLOhirfJFMOIji8=;
        b=pWcP5AdJ5USrLvgdK99L5nuTPILJ/gTsFsGaeXqp74Wp0myFIA7hvgOzG2qvRxLOPm
         2/r0QpLX4WIwpjAEWeY2cX9YfPn0662YzGVXhgNrMn+GZHSlSb40kZObfUL5iHBa4JLR
         MVP8LE/we+TDWVwwT4MBIdKeSvM7qrIfkR3w9yXNfEsKWa7k+UwGSjvF5ZnIexem6Yr7
         42CbpBlmprJCq/lqSvacLopafOBLrvpmjGBI0hNWC78JcuCfryOjmorkpho9qtCaShno
         Q5MMHlA4QL97ecM2Sovg+b2BXMFW+MoqiPp3g9pyD2W5AEOcCwaOOE//bpk42ZrogCOQ
         pgIw==
X-Forwarded-Encrypted: i=1; AJvYcCXlHni4y6XrwyoU2ph3f6bEeErpNx5eeZQHy3ln2koUHr+Zq4KJ+oYfFvr271tdlV91V8MbX+7MTfWrEI0h@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+g7cati9rfFQGmwIkkXXHQnUa/eoxthEAVDj6ZLy/CShYWrzF
	9nBDMRbNOtfHaJL4lyCkgqqFtuO8Z9ynaInVyPwf7RL3AWTAuJljWM4ppyptUOvfsFKYK2LMUe5
	ESHxTCEQoSTjnmumKD86vUrgbtcQGRUNRdEPZE/Dw+1J5dlplnq2DWnknY32ylg==
X-Gm-Gg: ASbGnct/XOmN9V1OlkDISAKIVNGuMxiQIfE6RNdmwTfXdjT+QU1IwQ7S81NHN3lR936
	l2Ur2diyWx549KuKPSaynZsiFH1NqQoMuH0NZozQRaTOJYhSm77v7OJ+hMu6ZI0uIqDoqzHl5OY
	m0JQVGq4f6HWo2oEKf1VS6dkxXS6Ae6sb8vLDmyPjD0gh1kfSUS3zzjx2xR2k4kcJ5xJmm3cr7E
	OQEZ6o19tkUamhkq8owYZFtyXM9J12j7o3XxhvfjvATvdNs/V0VYLSPOp6yMzE65uNvRu4cD7y2
	9fOxSTauE4ROQ0QVUVzjVm9F
X-Received: by 2002:a17:906:3184:b0:ab7:6a57:1778 with SMTP id a640c23a62f3a-abb7053f377mr1167622366b.0.1739875634873;
        Tue, 18 Feb 2025 02:47:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDjqWGIxqhirP2hcY9y7A0p1iwbTQ22rYd9pDxOrA5JKHBlOYhOa+YID2cSPLhQPLwqXpUMA==
X-Received: by 2002:a17:906:3184:b0:ab7:6a57:1778 with SMTP id a640c23a62f3a-abb7053f377mr1167615866b.0.1739875634345;
        Tue, 18 Feb 2025 02:47:14 -0800 (PST)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8915db0dsm506373166b.145.2025.02.18.02.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:47:13 -0800 (PST)
Date: Tue, 18 Feb 2025 11:47:12 +0100
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
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <65zr3fsrgum6gutsengfxz7sm3re4scyc7hqzbf63gmiz4oud2@czuvkmks3c2j>
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>

Got more comments below with private mail:

On 2025-02-11 18:22:47, Andrey Albershteyn wrote:
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
> Also, as vfs_fileattr_set() is now will be called on special files
> too, let's forbid any other attributes except projid and nextents
> (symlink can have an extent).
> 
> CC: linux-api@vger.kernel.org
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-xfs@vger.kernel.org
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
> v1:
> https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@kernel.org/
> 
> Previous discussion:
> https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/
> 
> XFS has project quotas which could be attached to a directory. All
> new inodes in these directories inherit project ID set on parent
> directory.
> 
> The project is created from userspace by opening and calling
> FS_IOC_FSSETXATTR on each inode. This is not possible for special
> files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> with empty project ID. Those inodes then are not shown in the quota
> accounting but still exist in the directory. Moreover, in the case
> when special files are created in the directory with already
> existing project quota, these inode inherit extended attributes.
> This than leaves them with these attributes without the possibility
> to clear them out. This, in turn, prevents userspace from
> re-creating quota project on these existing files.
> ---
> Changes in v3:
> - Remove unnecessary "dfd is dir" check as it checked in user_path_at()
> - Remove unnecessary "same filesystem" check
> - Use CLASS() instead of directly calling fdget/fdput
> - Link to v2: https://lore.kernel.org/r/20250122-xattrat-syscall-v2-1-5b360d4fbcb2@kernel.org
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      |  2 +
>  arch/arm/tools/syscall.tbl                  |  2 +
>  arch/arm64/tools/syscall_32.tbl             |  2 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |  2 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |  2 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |  2 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |  2 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |  2 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |  2 +
>  arch/s390/kernel/syscalls/syscall.tbl       |  2 +
>  arch/sh/kernel/syscalls/syscall.tbl         |  2 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |  2 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |  2 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |  2 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |  2 +
>  fs/inode.c                                  | 75 +++++++++++++++++++++++++++++
>  fs/ioctl.c                                  | 16 +++++-
>  include/linux/fileattr.h                    |  1 +
>  include/linux/syscalls.h                    |  4 ++
>  include/uapi/asm-generic/unistd.h           |  8 ++-
>  21 files changed, 133 insertions(+), 3 deletions(-)
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
> index 6b4c77268fc0ecace4ac78a9ca777fbffc277f4a..b2dddd9db4fabaf67a6cbf541a86978b290411ec 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
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
> @@ -2953,3 +2956,75 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
>  	return mode & ~S_ISGID;
>  }
>  EXPORT_SYMBOL(mode_strip_sgid);
> +
> +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
> +		struct fsxattr __user *, fsx, unsigned int, at_flags)
> +{
> +	CLASS(fd, dir)(dfd);
> +	struct fileattr fa;
> +	struct path filepath;
> +	int error;
> +	unsigned int lookup_flags = 0;
> +
> +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> +		return -EINVAL;
> +
> +	if (at_flags & AT_SYMLINK_FOLLOW)
> +		lookup_flags |= LOOKUP_FOLLOW;
> +
> +	if (at_flags & AT_EMPTY_PATH)
> +		lookup_flags |= LOOKUP_EMPTY;
> +
> +	if (fd_empty(dir))
> +		return -EBADF;
> +
> +	error = user_path_at(dfd, filename, lookup_flags, &filepath);
> +	if (error)
> +		return error;
> +
> +	error = vfs_fileattr_get(filepath.dentry, &fa);

vfs_fileattr_get() returns ENOIOCTLCMD, where EOPNOTSUPP is more
appropriate

> +	if (!error)
> +		error = copy_fsxattr_to_user(&fa, fsx);
> +
> +	path_put(&filepath);
> +	return error;
> +}
> +
> +SYSCALL_DEFINE4(setfsxattrat, int, dfd, const char __user *, filename,
> +		struct fsxattr __user *, fsx, unsigned int, at_flags)
		^ can be const
> +{
> +	CLASS(fd, dir)(dfd);
> +	struct fileattr fa;
> +	struct path filepath;
> +	int error;
> +	unsigned int lookup_flags = 0;
> +
> +	if ((at_flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
> +		return -EINVAL;
> +
> +	if (at_flags & AT_SYMLINK_FOLLOW)
> +		lookup_flags |= LOOKUP_FOLLOW;
> +
> +	if (at_flags & AT_EMPTY_PATH)
> +		lookup_flags |= LOOKUP_EMPTY;
> +
> +	if (fd_empty(dir))
> +		return -EBADF;
> +
> +	if (copy_fsxattr_from_user(&fa, fsx))
> +		return -EFAULT;
> +
> +	error = user_path_at(dfd, filename, lookup_flags, &filepath);
> +	if (error)
> +		return error;
> +
> +	error = mnt_want_write(filepath.mnt);
> +	if (!error) {
> +		error = vfs_fileattr_set(file_mnt_idmap(fd_file(dir)),
> +					 filepath.dentry, &fa);

same here with returned error

-- 
- Andrey


