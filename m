Return-Path: <linux-fsdevel+bounces-68695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C751C635DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F5EB34A9DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E09324B34;
	Mon, 17 Nov 2025 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXc3AudH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C932D24B7;
	Mon, 17 Nov 2025 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372928; cv=none; b=g8UwuOL9RRaf1gZ7YLkhbRcLrArNHwY7jffSA3KYlNi0T8QA7Njjxex7ch0uWTO7fjO5zCsKAotqE3NDX7IBqkMOfsEA8HM/kADCvF0wCeEUGHcYTj+faZwOBVxn19rkSAC8RJAzAI4WD56d3WTKsfl3bchvQ3LvDOl8KjSGKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372928; c=relaxed/simple;
	bh=lm1w5FuS0DFB8h8yriOEHrATD1xOM/lURkIhKIQpwx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUDlf5qDz+gILLpTna6AFzSlGHzkH01fVeGrL1hejHB/PTj/XXJWGCyKsFsVAUG9Jpd6d+t1yPlTfdCgqmYn8ikai765XijUmZ3xsVDoXvEOmOiavwnf3jQEhqt7O79VO2U36xpkcZlatFKITdgPeAUxXiKdAwsPbSxkDeTCHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXc3AudH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEF7C4CEF5;
	Mon, 17 Nov 2025 09:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372928;
	bh=lm1w5FuS0DFB8h8yriOEHrATD1xOM/lURkIhKIQpwx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SXc3AudH1OcuTxWg9OhFFVFP1nWirXtdO1p8OrOMzac+67OuDLkRz4ILPP6fVSALp
	 /FbXlUfKN2ZqyIZO3SFzOhbbbqmC2Z86SKwLoD9XyFGPsHtZU+1VwzcobeHdGPdC5m
	 54CJLuAlBSE64se+irsZX2F5e70m/vq92kn/oHf3DGlIeWfbhsCCrasmYoDchg7fRR
	 BY4na8GLM3cbXQevPwcrFoOhVgHiO9zWC/7t8Dh0EgtknybsgJlwU8qjyFgFQP+eV3
	 ZlRWl0ggiJpxxK7ALwoCwBJzw5EWBAi4stEaB7qIPc7tc6pfgp491Hjf3BtbERlnOu
	 LCc5gzOIltBsw==
Date: Mon, 17 Nov 2025 11:48:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v6 11/20] mm: shmem: use SHMEM_F_* flags instead of VM_*
 flags
Message-ID: <aRrvaHh-cP8jygAF@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-12-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-12-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:33:57PM -0500, Pasha Tatashin wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> 
> shmem_inode_info::flags can have the VM flags VM_NORESERVE and
> VM_LOCKED. These are used to suppress pre-accounting or to lock the
> pages in the inode respectively. Using the VM flags directly makes it
> difficult to add shmem-specific flags that are unrelated to VM behavior
> since one would need to find a VM flag not used by shmem and re-purpose
> it.
> 
> Introduce SHMEM_F_NORESERVE and SHMEM_F_LOCKED which represent the same
> information, but their bits are independent of the VM flags. Callers can
> still pass VM_NORESERVE to shmem_get_inode(), but it gets transformed to
> the shmem-specific flag internally.
> 
> No functional changes intended.
> 
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/shmem_fs.h |  6 ++++++
>  mm/shmem.c               | 28 +++++++++++++++-------------
>  2 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 0e47465ef0fd..650874b400b5 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -10,6 +10,7 @@
>  #include <linux/xattr.h>
>  #include <linux/fs_parser.h>
>  #include <linux/userfaultfd_k.h>
> +#include <linux/bits.h>
>  
>  struct swap_iocb;
>  
> @@ -19,6 +20,11 @@ struct swap_iocb;
>  #define SHMEM_MAXQUOTAS 2
>  #endif
>  
> +/* Suppress pre-accounting of the entire object size. */
> +#define SHMEM_F_NORESERVE	BIT(0)
> +/* Disallow swapping. */
> +#define SHMEM_F_LOCKED		BIT(1)
> +
>  struct shmem_inode_info {
>  	spinlock_t		lock;
>  	unsigned int		seals;		/* shmem seals */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 58701d14dd96..1d5036dec08a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -175,20 +175,20 @@ static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
>   */
>  static inline int shmem_acct_size(unsigned long flags, loff_t size)
>  {
> -	return (flags & VM_NORESERVE) ?
> +	return (flags & SHMEM_F_NORESERVE) ?
>  		0 : security_vm_enough_memory_mm(current->mm, VM_ACCT(size));
>  }
>  
>  static inline void shmem_unacct_size(unsigned long flags, loff_t size)
>  {
> -	if (!(flags & VM_NORESERVE))
> +	if (!(flags & SHMEM_F_NORESERVE))
>  		vm_unacct_memory(VM_ACCT(size));
>  }
>  
>  static inline int shmem_reacct_size(unsigned long flags,
>  		loff_t oldsize, loff_t newsize)
>  {
> -	if (!(flags & VM_NORESERVE)) {
> +	if (!(flags & SHMEM_F_NORESERVE)) {
>  		if (VM_ACCT(newsize) > VM_ACCT(oldsize))
>  			return security_vm_enough_memory_mm(current->mm,
>  					VM_ACCT(newsize) - VM_ACCT(oldsize));
> @@ -206,7 +206,7 @@ static inline int shmem_reacct_size(unsigned long flags,
>   */
>  static inline int shmem_acct_blocks(unsigned long flags, long pages)
>  {
> -	if (!(flags & VM_NORESERVE))
> +	if (!(flags & SHMEM_F_NORESERVE))
>  		return 0;
>  
>  	return security_vm_enough_memory_mm(current->mm,
> @@ -215,7 +215,7 @@ static inline int shmem_acct_blocks(unsigned long flags, long pages)
>  
>  static inline void shmem_unacct_blocks(unsigned long flags, long pages)
>  {
> -	if (flags & VM_NORESERVE)
> +	if (flags & SHMEM_F_NORESERVE)
>  		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
>  }
>  
> @@ -1551,7 +1551,7 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
>  	int nr_pages;
>  	bool split = false;
>  
> -	if ((info->flags & VM_LOCKED) || sbinfo->noswap)
> +	if ((info->flags & SHMEM_F_LOCKED) || sbinfo->noswap)
>  		goto redirty;
>  
>  	if (!total_swap_pages)
> @@ -2910,15 +2910,15 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
>  	 * ipc_lock_object() when called from shmctl_do_lock(),
>  	 * no serialization needed when called from shm_destroy().
>  	 */
> -	if (lock && !(info->flags & VM_LOCKED)) {
> +	if (lock && !(info->flags & SHMEM_F_LOCKED)) {
>  		if (!user_shm_lock(inode->i_size, ucounts))
>  			goto out_nomem;
> -		info->flags |= VM_LOCKED;
> +		info->flags |= SHMEM_F_LOCKED;
>  		mapping_set_unevictable(file->f_mapping);
>  	}
> -	if (!lock && (info->flags & VM_LOCKED) && ucounts) {
> +	if (!lock && (info->flags & SHMEM_F_LOCKED) && ucounts) {
>  		user_shm_unlock(inode->i_size, ucounts);
> -		info->flags &= ~VM_LOCKED;
> +		info->flags &= ~SHMEM_F_LOCKED;
>  		mapping_clear_unevictable(file->f_mapping);
>  	}
>  	retval = 0;
> @@ -3062,7 +3062,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>  	spin_lock_init(&info->lock);
>  	atomic_set(&info->stop_eviction, 0);
>  	info->seals = F_SEAL_SEAL;
> -	info->flags = flags & VM_NORESERVE;
> +	info->flags = (flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
>  	info->i_crtime = inode_get_mtime(inode);
>  	info->fsflags = (dir == NULL) ? 0 :
>  		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
> @@ -5804,8 +5804,10 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  /* common code */
>  
>  static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
> -			loff_t size, unsigned long flags, unsigned int i_flags)
> +				       loff_t size, unsigned long vm_flags,
> +				       unsigned int i_flags)
>  {
> +	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
>  	struct inode *inode;
>  	struct file *res;
>  
> @@ -5822,7 +5824,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
>  		return ERR_PTR(-ENOMEM);
>  
>  	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
> -				S_IFREG | S_IRWXUGO, 0, flags);
> +				S_IFREG | S_IRWXUGO, 0, vm_flags);
>  	if (IS_ERR(inode)) {
>  		shmem_unacct_size(flags, size);
>  		return ERR_CAST(inode);
> -- 
> 2.52.0.rc1.455.g30608eb744-goog
> 

-- 
Sincerely yours,
Mike.

