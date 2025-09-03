Return-Path: <linux-fsdevel+bounces-60124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ECCB415B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 08:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900041B62821
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FDE2D94AB;
	Wed,  3 Sep 2025 06:58:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162F32D5934;
	Wed,  3 Sep 2025 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882693; cv=none; b=BN9Zx0BjjoxtfBpnqXySPpmaHlPmW5InA67RHeCzAB7gRSX7jxCn/5c2g3rXcb+B1TDVSq1mAfEwCcYvrtJEyOIQp3x8nJHkuDAPXffmtJYBmRp60cetQDoPNUTGNisZfMDWntOQnrCd/WLfvd4joY3MyoY0n4kv4YEBxtD4AHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882693; c=relaxed/simple;
	bh=2BZhoOUZheHr4Wb/vRNV2zyISKB/M04ADASgZrBV3iU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jV0yE3ml6b7ABbnYOpNHQKFmg/4mwM87leKW4IwIwQTmMxHBiIj68tGi0nmDwCEvwAsnqySFNwjH/akBWAE0wtzGOihD18gdcApEPvyMXDodRTAzov2gAz5xayJcH+beaUVaq6lcUDivSM12U8Vj1gZU9vGsCdFDcoSW+H3g1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cGthw6cNMzYnVPM;
	Wed,  3 Sep 2025 14:57:36 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Sep
 2025 14:57:58 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Sep
 2025 14:57:58 +0800
From: wangzijie <wangzijie1@honor.com>
To: <wangzijie1@honor.com>
CC: <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <ast@kernel.org>,
	<brauner@kernel.org>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<k.shutemov@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<polynomial-c@gmx.de>, <regressions@lists.linux.dev>,
	<rick.p.edgecombe@intel.com>, <stable@vger.kernel.org>,
	<viro@zeniv.linux.org.uk>, <spender@grsecurity.net>
Subject: Re: [PATCH v3] proc: fix missing pde_set_flags() for net proc files
Date: Wed, 3 Sep 2025 14:57:58 +0800
Message-ID: <20250903065758.3678537-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821105806.1453833-1-wangzijie1@honor.com>
References: <20250821105806.1453833-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a011.hihonor.com
 (10.68.31.243)

> To avoid potential UAF issues during module removal races, we use pde_set_flags()
> to save proc_ops flags in PDE itself before proc_register(), and then use
> pde_has_proc_*() helpers instead of directly dereferencing pde->proc_ops->*.
> 
> However, the pde_set_flags() call was missing when creating net related proc files.
> This omission caused incorrect behavior which FMODE_LSEEK was being cleared
> inappropriately in proc_reg_open() for net proc files. Lars reported it in this link[1].
> 
> Fix this by ensuring pde_set_flags() is called when register proc entry, and add
> NULL check for proc_ops in pde_set_flags().
> 
> [1]: https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/
> 
> Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al")
> Cc: stable@vger.kernel.org
> Reported-by: Lars Wendler <polynomial-c@gmx.de>
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
> v3:
> - followed by Christian's suggestion to stash pde->proc_ops in a local const variable
> v2:
> - followed by Jiri's suggestion to refractor code and reformat commit message
> ---
>  fs/proc/generic.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 76e800e38..bd0c099cf 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -367,6 +367,25 @@ static const struct inode_operations proc_dir_inode_operations = {
>  	.setattr	= proc_notify_change,
>  };
>  
> +static void pde_set_flags(struct proc_dir_entry *pde)
> +{
> +	const struct proc_ops *proc_ops = pde->proc_ops;
> +
> +	if (!proc_ops)
> +		return;
> +
> +	if (proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
> +		pde->flags |= PROC_ENTRY_PERMANENT;
> +	if (proc_ops->proc_read_iter)
> +		pde->flags |= PROC_ENTRY_proc_read_iter;
> +#ifdef CONFIG_COMPAT
> +	if (proc_ops->proc_compat_ioctl)
> +		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
> +#endif
> +	if (proc_ops->proc_lseek)
> +		pde->flags |= PROC_ENTRY_proc_lseek;
> +}
> +
>  /* returns the registered entry, or frees dp and returns NULL on failure */
>  struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>  		struct proc_dir_entry *dp)
> @@ -374,6 +393,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>  	if (proc_alloc_inum(&dp->low_ino))
>  		goto out_free_entry;
>  
> +	pde_set_flags(dp);
> +
>  	write_lock(&proc_subdir_lock);
>  	dp->parent = dir;
>  	if (pde_subdir_insert(dir, dp) == false) {
> @@ -561,20 +582,6 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
>  	return p;
>  }
>  
> -static void pde_set_flags(struct proc_dir_entry *pde)
> -{
> -	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
> -		pde->flags |= PROC_ENTRY_PERMANENT;
> -	if (pde->proc_ops->proc_read_iter)
> -		pde->flags |= PROC_ENTRY_proc_read_iter;
> -#ifdef CONFIG_COMPAT
> -	if (pde->proc_ops->proc_compat_ioctl)
> -		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
> -#endif
> -	if (pde->proc_ops->proc_lseek)
> -		pde->flags |= PROC_ENTRY_proc_lseek;
> -}
> -
>  struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
>  		struct proc_dir_entry *parent,
>  		const struct proc_ops *proc_ops, void *data)
> @@ -585,7 +592,6 @@ struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
>  	if (!p)
>  		return NULL;
>  	p->proc_ops = proc_ops;
> -	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL(proc_create_data);
> @@ -636,7 +642,6 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
>  	p->proc_ops = &proc_seq_ops;
>  	p->seq_ops = ops;
>  	p->state_size = state_size;
> -	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL(proc_create_seq_private);
> @@ -667,7 +672,6 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
>  		return NULL;
>  	p->proc_ops = &proc_single_ops;
>  	p->single_show = show;
> -	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL(proc_create_single_data);
> -- 
> 2.25.1

Hi all,

Sorry for disturbing, Brad reported type confusion introduced by this patch
to me, we missed a part in the definition of proc_dir_entry:
        union {
                const struct proc_ops *proc_ops;
                const struct file_operations *proc_dir_ops;
        };

Quoting the email he sent to me:
"
any dereference of ->proc_ops assuming it is a proc_ops structure results in type confusion,
it probably won't be (easily) noticed without CONFIG_RANDSTRUCT because of the way in which
proc_flags overlaps with the module owner pointer in the file_operations structure(and the
alignment of the struct module pointed to).

With RANDSTRUCT enabled, users are likely to observe warnings on proc dir removal like:
[ 19.093369] removing permanent /proc entry '12/i8042'
[ 19.093396] WARNING: CPU: 0 PID: 1 at fs/proc/generic.c:886
remove_proc_subtree+0xcc/0x218
"

I examined where proc_register() is called, we can do !S_ISDIR(dp->mode) test before calling
pde_set_flags() to fix it(Brad also suggested to do this), or we can drop this patch and
apply the initial version[1]. I think the former is better.

Dose anyone have any suggestions?

[1] https://lore.kernel.org/all/20250818040535.564611-1-wangzijie1@honor.com/.


