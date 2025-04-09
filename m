Return-Path: <linux-fsdevel+bounces-46134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C7CA83378
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 23:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8162017D8F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 21:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43882218EBE;
	Wed,  9 Apr 2025 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K0btyEOy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAC82144BF;
	Wed,  9 Apr 2025 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744234547; cv=none; b=oYrxYqZxdCqD5ElsGsAuPH1lO2dS6V+zFmCLaerE+E1cRMjwPnUFPH54eKlgQw76gj9pljB5jkIu+7Exp7oOK/6VX7GtwNe8ekHdJjbU+F0D53qiO7LS+BqasDXxmpPtNs6b6YjphSgTqH9kpN4fIfo3yP1b6BRl2z31K6pZjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744234547; c=relaxed/simple;
	bh=CNtIxw1sWZ0O+WCWD41wUtYvmC43g+N6VydPHRSLjlI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s5al6Ml4jeEgVrwDB26N0bAX0urAuOWxjTmrF/3rhJU5JbvV0qDZsBxCfvJUSkH+yGG3QAlA2X5St7Xs8OobTdcnjjkFszst+kZj0RsL0vaTZZZ+Y9UIZ6TVmQdBGQe0VQ9VYsMtHrfg+s7/+4IUOnPRYP6cAH1h43m1W4PFYJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K0btyEOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E908EC4CEE2;
	Wed,  9 Apr 2025 21:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744234547;
	bh=CNtIxw1sWZ0O+WCWD41wUtYvmC43g+N6VydPHRSLjlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K0btyEOyNmQQPVIJPI0eK1hzfTwOzdfINfivA93jRqc5AN/y+zaT7xRxTp03MyYgI
	 iiJ3hCf52BWpKHIuM2gAD+tsPF1PSUYedTXot6IjPbsULSo7Z78mK/T1y98WybZkQf
	 +ygZXNXxKsf3OupHWYuQ2343Ewot2RyRz52SZvg4=
Date: Wed, 9 Apr 2025 14:35:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: brauner@kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: allow to mark /proc files permanent outside of
 fs/proc/
Message-Id: <20250409143546.b3fecd04485b104657b8af25@linux-foundation.org>
In-Reply-To: <c58291cd-0775-4c90-8443-ba71897b5cbb@p183>
References: <c58291cd-0775-4c90-8443-ba71897b5cbb@p183>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 22:20:13 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> >From 06e2ff406942fef65b9c397a7f44478dd4b61451 Mon Sep 17 00:00:00 2001
> From: Alexey Dobriyan <adobriyan@gmail.com>
> Date: Sat, 5 Apr 2025 14:50:10 +0300
> Subject: [PATCH 1/1] proc: allow to mark /proc files permanent outside of
>  fs/proc/
> 
> From: Mateusz Guzik <mjguzik@gmail.com>
> 
> Add proc_make_permanent() function to mark PDE as permanent to speed up
> open/read/close (one alloc/free and lock/unlock less).

When proposing a speedup it is preferable to provide some benchmarking
results to help others understand the magnitude of that speedup.

> ...
>
> index 58b9067b2391..81dcd0ddadb6 100644
> --- a/fs/filesystems.c
> +++ b/fs/filesystems.c
> @@ -252,7 +252,9 @@ static int filesystems_proc_show(struct seq_file *m, void *v)
>  
>  static int __init proc_filesystems_init(void)
>  {
> -	proc_create_single("filesystems", 0, NULL, filesystems_proc_show);
> +	struct proc_dir_entry *pde =
> +		proc_create_single("filesystems", 0, NULL, filesystems_proc_show);

To avoid the 80-column nasties, this is more pleasing:

	struct proc_dir_entry *pde;

	pde = proc_create_single("filesystems", 0, NULL, filesystems_proc_show);


> +	proc_make_permanent(pde);
>  	return 0;
>  }
>  module_init(proc_filesystems_init);
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index a3e22803cddf..0342600c0172 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -826,3 +826,15 @@ ssize_t proc_simple_write(struct file *f, const char __user *ubuf, size_t size,
>  	kfree(buf);
>  	return ret == 0 ? size : ret;
>  }
> +
> +/*
> + * Not exported to modules:
> + * modules' /proc files aren't permanent because modules aren't permanent.
> + */
> +void impl_proc_make_permanent(struct proc_dir_entry *pde);

This declaration is unneeded, isn't it?

> +void impl_proc_make_permanent(struct proc_dir_entry *pde)
> +{
> +	if (pde) {
> +		pde_make_permanent(pde);
> +	}

Please let's be running checkpatch more often?

> +}
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 96122e91c645..885b1cd38020 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -80,8 +80,11 @@ static inline bool pde_is_permanent(const struct proc_dir_entry *pde)
>  	return pde->flags & PROC_ENTRY_PERMANENT;
>  }
>  
> +/* This is for builtin code, not even for modules which are compiled in. */
>  static inline void pde_make_permanent(struct proc_dir_entry *pde)
>  {
> +	/* Ensure magic flag does something. */
> +	static_assert(PROC_ENTRY_PERMANENT != 0);

Looks odd.  What is this doing?  The comment does a poor job of
explaining this!

>  	pde->flags |= PROC_ENTRY_PERMANENT;
>  }
>  
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index ea62201c74c4..2d59f29b49eb 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -247,4 +247,14 @@ static inline struct pid_namespace *proc_pid_ns(struct super_block *sb)
>  
>  bool proc_ns_file(const struct file *file);
>  
> +static inline void proc_make_permanent(struct proc_dir_entry *pde)
> +{
> +	/* Don't give matches to modules. */

This comment is also mysterious (to me).  Please expand upon it.

> +#if defined CONFIG_PROC_FS && !defined MODULE
> +	/* This mess is created by defining "struct proc_dir_entry" elsewhere. */

Also mysterious.

> +	void impl_proc_make_permanent(struct proc_dir_entry *pde);

Forward-declaring a function within a function in this manner is quite
unusual.  Let's be conventional, please.

> +	impl_proc_make_permanent(pde);
> +#endif
> +}
> +
>  #endif /* _LINUX_PROC_FS_H */
> -- 
> 2.47.0

