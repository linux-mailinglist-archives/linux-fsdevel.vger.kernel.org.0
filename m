Return-Path: <linux-fsdevel+bounces-38427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2880AA024AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 12:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF451885E03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 11:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C001DDC0F;
	Mon,  6 Jan 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP4xZKwv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6911DB346;
	Mon,  6 Jan 2025 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164771; cv=none; b=BLcvHxup7g6F+weDKRjd4KMYzSQGW9Pid+llZKNDDnVxQ16wUFDDaixm55nWT6VoSCuZdF5yvsG3kikMtHQuEio7G4b/WM53YVLCa1XlNiyx3tgDMkm9zSHoWumTXoX1x6QLTjSySkp6pME08pYtsCePJFHCR6dYDRuGZN85lNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164771; c=relaxed/simple;
	bh=V3UI3pxRy5iNtJCoL0NaOG5gDruTQVT2IoIJ4kD3Q/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jliHaE3jD4lNnNSJu8AuD8MoRCFs1esfNZv3Mjkttnizm1uZ9IIx4rURCP9tjssbVhFYUotrv5T7gHtPT1X2GpX51FTVAKRqMWXc9uwDrR4Der/eIqfyE8QO+AQ/N8fWsTVP73/o7o2HhYVoO+16usoh1alXghAcrq3JZeaC5Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP4xZKwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F5AC4CED2;
	Mon,  6 Jan 2025 11:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736164770;
	bh=V3UI3pxRy5iNtJCoL0NaOG5gDruTQVT2IoIJ4kD3Q/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CP4xZKwvSKPXpdL6WQezLv7buO14myH/Eg7GLBppcd4uhHRyU1mMf25JQAGreU7pC
	 72P1c9I14dcTxUG8mOh/zkeKchsfITBN8xqL0vPnRDfglHsQB7VpmVelun4FEnHFhB
	 ijta7qDDHZndv7aRnY70jpQowzNTI5Hq5maxG4HdN2dKPthAMSf/5Hc5C48ndnIxpz
	 AhEFvkqePFmebeQC4XnT+gOiQNSyq376QkqleqbJCkM5c6nfU7xirOJpp75RJuhhp7
	 VyXIpvQtJOL7b7gcy4zGToM+KklyqrjYBXljZzOuy9mbniKSrhYLP2PdBSjh0nbtZS
	 Tcoyda4SzZedg==
Date: Mon, 6 Jan 2025 12:59:25 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	kees@kernel.org, j.granados@samsung.com, willy@infradead.org, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, lorenzo.stoakes@oracle.com, trondmy@kernel.org, 
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	jmorris@namei.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, 
	haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com, shikemeng@huaweicloud.com, 
	dchinner@redhat.com, bfoster@redhat.com, souravpanda@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, pasha.tatashin@soleen.com, david@redhat.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, yang@os.amperecomputing.com, 
	zev@bewilderbeest.net, serge@hallyn.com, vegard.nossum@oracle.com, 
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 -next 14/15] sh: vdso: move the sysctl to
 arch/sh/kernel/vsyscall/vsyscall.c
Message-ID: <eiskmyz22ckjfmsxztt7a6m7e4sktp226j4hjktuggyqb4jirc@2rqxvgoq4v55>
References: <20241228145746.2783627-1-yukaixiong@huawei.com>
 <20241228145746.2783627-15-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228145746.2783627-15-yukaixiong@huawei.com>

On Sat, Dec 28, 2024 at 10:57:45PM +0800, Kaixiong Yu wrote:
> When CONFIG_SUPERH and CONFIG_VSYSCALL are defined,
> vdso_enabled belongs to arch/sh/kernel/vsyscall/vsyscall.c.
> So, move it into its own file. After this patch is applied,
> all sysctls of vm_table would be moved. So, delete vm_table.
> 
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---
> v4:
>  - const qualify struct ctl_table vdso_table
> v3:
>  - change the title
> ---
> ---
>  arch/sh/kernel/vsyscall/vsyscall.c | 14 ++++++++++++++
>  kernel/sysctl.c                    | 14 --------------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/sh/kernel/vsyscall/vsyscall.c b/arch/sh/kernel/vsyscall/vsyscall.c
> index add35c51e017..898132f34e6a 100644
> --- a/arch/sh/kernel/vsyscall/vsyscall.c
> +++ b/arch/sh/kernel/vsyscall/vsyscall.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/elf.h>
>  #include <linux/sched.h>
> +#include <linux/sysctl.h>
>  #include <linux/err.h>
>  
>  /*
> @@ -30,6 +31,17 @@ static int __init vdso_setup(char *s)
>  }
>  __setup("vdso=", vdso_setup);
>  
> +static const struct ctl_table vdso_table[] = {
> +	{
> +		.procname	= "vdso_enabled",
> +		.data		= &vdso_enabled,
> +		.maxlen		= sizeof(vdso_enabled),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +		.extra1		= SYSCTL_ZERO,
> +	},
> +};
> +
>  /*
>   * These symbols are defined by vsyscall.o to mark the bounds
>   * of the ELF DSO images included therein.
> @@ -55,6 +67,8 @@ int __init vsyscall_init(void)
>  	       &vsyscall_trapa_start,
>  	       &vsyscall_trapa_end - &vsyscall_trapa_start);
>  
> +	register_sysctl_init("vm", vdso_table);
> +
>  	return 0;
>  }
>  
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 7ff07b7560b4..cebd0ef5d19d 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2012,23 +2012,9 @@ static struct ctl_table kern_table[] = {
>  #endif
>  };
>  
As you mentioned in the commit message, this patch has two objectives.
1. It moves the vdso_enabled table and 2. It removes the vm_table.
Please separate these two in such a way that the second (removal of
vm_table) can be done at the end and is not related to any particular
table under vm_table. I prefer it that way so that the removal of
vm_table does not block the upstreaming of a move that is already
reviewed and ready.


> -static struct ctl_table vm_table[] = {
> -#if defined(CONFIG_SUPERH) && defined(CONFIG_VSYSCALL)
> -	{
> -		.procname	= "vdso_enabled",
> -		.data		= &vdso_enabled,
> -		.maxlen		= sizeof(vdso_enabled),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> -		.extra1		= SYSCTL_ZERO,
> -	},
> -#endif
> -};
> -
>  int __init sysctl_init_bases(void)
>  {
>  	register_sysctl_init("kernel", kern_table);
> -	register_sysctl_init("vm", vm_table);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 

-- 

Joel Granados

