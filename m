Return-Path: <linux-fsdevel+bounces-58575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6239B2EFDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 09:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E012E3AD616
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07E296BA6;
	Thu, 21 Aug 2025 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw86EYFG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88062135AD;
	Thu, 21 Aug 2025 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761757; cv=none; b=b997F6RQVD+seNGBVNpMYvvjR02UmLPb8mbHsbmGi5qGx/cuSR/v+rKFqyY0yO2iMjmvaGPB56xHX+c1MjSTVJPD7R7ExtV/jebb2S46YN7KUAaYI8fo41xdKhGarLt3iuVCOLdmeLsPcvcnIjJIn130H3HPGONSibVKHvRKbNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761757; c=relaxed/simple;
	bh=XjakIgVMScc39Ggf2ZqZHSX4qON8F54/Tai9PDv/FqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEyJ4+HQD1HfPTHhrnmPgPWrSnBzArNf7GtvLHTDK9qkvQUT7Fsg/aTSs7HRHOspC9MLeSYvOJlqs/JX/pkebQmwtXqL1KwPDzo510hi/UVHCyOK8NwKS0loW1oqAT74kPJ4dbCd2psyNfgg6ZGURDIN0PZuYG2P7eedSJ4sc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw86EYFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE07C4CEED;
	Thu, 21 Aug 2025 07:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755761756;
	bh=XjakIgVMScc39Ggf2ZqZHSX4qON8F54/Tai9PDv/FqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nw86EYFGhEJULwiaGcI2Jo6ijR0iI8PIODVk0ydQNM0Ecp3GGMb/HIg9BUZohgN0z
	 GBcRbMtnz+aODLC2iREJkg92InPS06BXDGgtGSlxY+B75k2rgiXTliTnXyVXXgw8L1
	 DVzX7ThqZhA0gCm6dfS1c77obyIKysDEh+tZ3bXDoV6JAyhk8d4+wSrife0MzAJ4lg
	 /uciIFjKJEhHf4gtso8jrVa0YwNHwGFgSPbyAKNil9QYIQr8y0iBD7ZHLB/dHn4lJx
	 MHSGACjwkGvKlHDiA87YxIcL8BxlVv2+vrZtBN14sQcezcBT/JwDuWmyX5N5Y7vDao
	 qQMMRlNbjLKSQ==
Date: Thu, 21 Aug 2025 09:35:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: wangzijie <wangzijie1@honor.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	adobriyan@gmail.com, rick.p.edgecombe@intel.com, ast@kernel.org, k.shutemov@gmail.com, 
	jirislaby@kernel.org, linux-fsdevel@vger.kernel.org, polynomial-c@gmx.de, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH RESEND v2] proc: fix missing pde_set_flags() for net proc
 files
Message-ID: <20250821-wagemut-serpentinen-e5f4b6f505f6@brauner>
References: <20250818123102.959595-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818123102.959595-1-wangzijie1@honor.com>

On Mon, Aug 18, 2025 at 08:31:02PM +0800, wangzijie wrote:
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
> Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al)
> Cc: stable@vger.kernel.org
> Reported-by: Lars Wendler <polynomial-c@gmx.de>
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
> v2:
> - followed by Jiri's suggestion to refractor code and reformat commit message
> ---
>  fs/proc/generic.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 76e800e38..003031839 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -367,6 +367,23 @@ static const struct inode_operations proc_dir_inode_operations = {
>  	.setattr	= proc_notify_change,
>  };
>  
> +static void pde_set_flags(struct proc_dir_entry *pde)
> +{

Stash pde->proc_ops in a local const variable instead of chasing the
pointer multiple times. Aside from that also makes it easier to read.
Otherwise seems fine.

> +	if (!pde->proc_ops)
> +		return;
> +
> +	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
> +		pde->flags |= PROC_ENTRY_PERMANENT;
> +	if (pde->proc_ops->proc_read_iter)
> +		pde->flags |= PROC_ENTRY_proc_read_iter;
> +#ifdef CONFIG_COMPAT
> +	if (pde->proc_ops->proc_compat_ioctl)
> +		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
> +#endif
> +	if (pde->proc_ops->proc_lseek)
> +		pde->flags |= PROC_ENTRY_proc_lseek;
> +}
> +
>  /* returns the registered entry, or frees dp and returns NULL on failure */
>  struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>  		struct proc_dir_entry *dp)
> @@ -374,6 +391,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>  	if (proc_alloc_inum(&dp->low_ino))
>  		goto out_free_entry;
>  
> +	pde_set_flags(dp);
> +
>  	write_lock(&proc_subdir_lock);
>  	dp->parent = dir;
>  	if (pde_subdir_insert(dir, dp) == false) {
> @@ -561,20 +580,6 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
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
> @@ -585,7 +590,6 @@ struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
>  	if (!p)
>  		return NULL;
>  	p->proc_ops = proc_ops;
> -	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL(proc_create_data);
> @@ -636,7 +640,6 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
>  	p->proc_ops = &proc_seq_ops;
>  	p->seq_ops = ops;
>  	p->state_size = state_size;
> -	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL(proc_create_seq_private);
> @@ -667,7 +670,6 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
>  		return NULL;
>  	p->proc_ops = &proc_single_ops;
>  	p->single_show = show;
> -	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL(proc_create_single_data);
> -- 
> 2.25.1
> 

