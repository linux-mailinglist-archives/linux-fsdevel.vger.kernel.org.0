Return-Path: <linux-fsdevel+bounces-58873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D111EB3264C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 03:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D0164E2249
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 01:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592B41EB5C2;
	Sat, 23 Aug 2025 01:54:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6AC191F7E;
	Sat, 23 Aug 2025 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755914046; cv=none; b=XUtYXgMtdBmkpvTsDQiPH/OlP34Mi0E7a+3Ut6xsvOfW5kzieXhNSPbHpOLT0ygCOsQo1ENcXfaXrdNXUnuvhkWgK3D52IqsaVi0iE2gHpM8NLJGWCXUTuiosW9Tfvy3WqqqWvzyAgM/1Ixvw+7/bcUfEViN3UyzYnbLxiWFYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755914046; c=relaxed/simple;
	bh=lb7ETmThEA98Kjs2wgXrXw1GpQW5I8d/r66x6z+1ol0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2b0KIUTfcKcc1u9CJ+H57TvkjlapZf3TK+2kxWZk94RRyK3O4UTTfR8LS4jB/NolSFR4+ISvktTtYuW/FNjbI1zXKvthiHw3MdTckQ4VXmZI1Xkty6T8EJkzscoJLqx5uRw1eY8rJvaziQbEweoPR4taUXO9V0Zl34QFS3RxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4c80TD2sQXzYnXLf;
	Sat, 23 Aug 2025 09:53:36 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 23 Aug
 2025 09:53:50 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 23 Aug
 2025 09:53:50 +0800
From: wangzijie <wangzijie1@honor.com>
To: <sbrivio@redhat.com>
CC: <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <ast@kernel.org>,
	<brauner@kernel.org>, <kirill.shutemov@linux.intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<passt-dev@passt.top>, <rick.p.edgecombe@intel.com>,
	<viro@zeniv.linux.org.uk>, <wangzijie1@honor.com>, <jirislaby@kernel.org>
Subject: Re: [PATCH] proc: Bring back lseek() operations for /proc/net entries
Date: Sat, 23 Aug 2025 09:53:49 +0800
Message-ID: <20250823015349.1650855-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822172335.3187858-1-sbrivio@redhat.com>
References: <20250822172335.3187858-1-sbrivio@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w001.hihonor.com (10.68.25.235) To a011.hihonor.com
 (10.68.31.243)

> Commit ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek
> as ones for proc_read_iter et.al") breaks lseek() for all /proc/net
> entries, as shown for instance by pasta(1), a user-mode network
> implementation using those entries to scan for bound ports:
> 
>   $ strace -e openat,lseek -e s=none pasta -- true
>   [...]
>   openat(AT_FDCWD, "/proc/net/tcp", O_RDONLY|O_CLOEXEC) = 12
>   openat(AT_FDCWD, "/proc/net/tcp6", O_RDONLY|O_CLOEXEC) = 13
>   lseek(12, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
>   lseek() failed on /proc/net file: Illegal seek
>   lseek(13, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
>   lseek() failed on /proc/net file: Illegal seek
>   openat(AT_FDCWD, "/proc/net/udp", O_RDONLY|O_CLOEXEC) = 14
>   openat(AT_FDCWD, "/proc/net/udp6", O_RDONLY|O_CLOEXEC) = 15
>   lseek(14, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
>   lseek() failed on /proc/net file: Illegal seek
>   lseek(15, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
>   lseek() failed on /proc/net file: Illegal seek
>   [...]
> 
> That's because PROC_ENTRY_proc_lseek isn't set for /proc/net entries,
> and it's now mandatory for lseek(). In fact, flags aren't set at all
> for those entries because pde_set_flags() isn't called for them.
> 
> As commit d919b33dafb3 ("proc: faster open/read/close with "permanent"
> files") introduced flags for procfs directory entries, along with the
> pde_set_flags() helper, they weren't relevant for /proc/net entries,
> so the lack of pde_set_flags() calls in proc_create_net_*() functions
> was harmless.
> 
> Now that the calls are strictly needed for lseek() functionality,
> add them.
> 
> Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al")
> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> ---
>  fs/proc/generic.c  | 2 +-
>  fs/proc/internal.h | 1 +
>  fs/proc/proc_net.c | 4 ++++
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 76e800e38c8f..57ec5e385d1b 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -561,7 +561,7 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
>  	return p;
>  }
>  
> -static void pde_set_flags(struct proc_dir_entry *pde)
> +void pde_set_flags(struct proc_dir_entry *pde)
>  {
>  	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
>  		pde->flags |= PROC_ENTRY_PERMANENT;
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index e737401d7383..a358974f14d2 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -284,6 +284,7 @@ extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int)
>  struct dentry *proc_lookup_de(struct inode *, struct dentry *, struct proc_dir_entry *);
>  extern int proc_readdir(struct file *, struct dir_context *);
>  int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *);
> +void pde_set_flags(struct proc_dir_entry *pde);
>  
>  static inline void pde_get(struct proc_dir_entry *pde)
>  {
> diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> index 52f0b75cbce2..20bc7481b02c 100644
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -124,6 +124,7 @@ struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
>  	p->proc_ops = &proc_net_seq_ops;
>  	p->seq_ops = ops;
>  	p->state_size = state_size;
> +	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL_GPL(proc_create_net_data);
> @@ -170,6 +171,7 @@ struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode
>  	p->seq_ops = ops;
>  	p->state_size = state_size;
>  	p->write = write;
> +	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL_GPL(proc_create_net_data_write);
> @@ -217,6 +219,7 @@ struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
>  	pde_force_lookup(p);
>  	p->proc_ops = &proc_net_single_ops;
>  	p->single_show = show;
> +	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL_GPL(proc_create_net_single);
> @@ -261,6 +264,7 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
>  	p->proc_ops = &proc_net_single_ops;
>  	p->single_show = show;
>  	p->write = write;
> +	pde_set_flags(p);
>  	return proc_register(parent, p);
>  }
>  EXPORT_SYMBOL_GPL(proc_create_net_single_write);
> -- 
> 2.43.0

Hi Stefano,
Thanks for your patch, Lars reported this bug last week:
https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/

Jiri suggested to make pde_set_flags() part of proc_register(). I think it can help
to avoid lack of pde_set_flags() calls in the future and make code clean.

I have submitted a patch:
https://lore.kernel.org/all/20250821105806.1453833-1-wangzijie1@honor.com


