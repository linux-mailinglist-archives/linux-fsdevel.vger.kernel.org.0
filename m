Return-Path: <linux-fsdevel+bounces-58569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2291DB2ECC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 06:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D355E1D3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 04:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A4B29BD88;
	Thu, 21 Aug 2025 04:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="juwRfV9v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591B2505AF;
	Thu, 21 Aug 2025 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750494; cv=none; b=XPPl+uEkRzipIFqm+4AFC/8lJF7dZU2qanCEhShAgnEFrDkRTk3A3QOU9vQe0qgxTCCJloWMkh4FHEI2FpUCBIynd5l6B7S9c5Ci43Fj6al170zEUQNzDEPAmC9bH73UP+O59adzQIhx5aYFtQTzm5k8aXt3syxT+w78n2ZhgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750494; c=relaxed/simple;
	bh=RDfnmzzPX++z+63Ey3kzotU4RgnwxVs4lGGAkN3elMs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cjj21EMUeHARGz/n7skLvKtT7AZWWGWu7xwISKAyWo2o+DmvonWtOrZUFtJeyManfF/2t4g1+6+gqAD/TfROLzpMln/xvlrz4+amLgE/oenymehJxmoz2+IOkwKtUFYO9yPG3zWGPwAKaDX3eeXsDB/pF3x4+WkJVaomILUQ80A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=juwRfV9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E897C4CEF4;
	Thu, 21 Aug 2025 04:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755750494;
	bh=RDfnmzzPX++z+63Ey3kzotU4RgnwxVs4lGGAkN3elMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=juwRfV9vhHWViddcXw05roJDr5pxqizoarclX2HveNTDlj5zJRIFaMBeYpokItVYZ
	 25/2bbWNHVNbZ84ghT1IqO4qD/nEErsZq50cFcfji0BdW4lCaLkCk5hHk7FSuJZZPH
	 f8rRpa+A4MVo9EgkTQ7DtE5WztLz3CFueToY+9YA=
Date: Wed, 20 Aug 2025 21:28:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: wangzijie <wangzijie1@honor.com>
Cc: <viro@zeniv.linux.org.uk>, <adobriyan@gmail.com>,
 <rick.p.edgecombe@intel.com>, <ast@kernel.org>, <k.shutemov@gmail.com>,
 <jirislaby@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <polynomial-c@gmx.de>, <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: [PATCH RESEND v2] proc: fix missing pde_set_flags() for net
 proc files
Message-Id: <20250820212812.566490412bc5e342bd373c4c@linux-foundation.org>
In-Reply-To: <20250818123102.959595-1-wangzijie1@honor.com>
References: <20250818123102.959595-1-wangzijie1@honor.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 20:31:02 +0800 wangzijie <wangzijie1@honor.com> wrote:

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

Could someone(s) please review this?

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

