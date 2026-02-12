Return-Path: <linux-fsdevel+bounces-77065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGIsDxFnjmk1CAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:49:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB28A131D20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98E0F304298B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 23:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D97C2ECD14;
	Thu, 12 Feb 2026 23:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/YdLykm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65E1DE4EF;
	Thu, 12 Feb 2026 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770940174; cv=none; b=Irvy6icrS42NGuejTRFaDzo1RdT1kPlSw0xpJcLdOcogrWGtUSwmkbiGCBptRt9pboGE/rGIQ9cczQj/KdS25tz8bSy23ki7aOM6yrmEjrYxqthK4XaPKzeWdRf9NRsTJjt+uHNUD52bMgvZ7iix/IgfFAoNlfjDxM4Pgl2/WJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770940174; c=relaxed/simple;
	bh=BUnKZvCHoKZldYxIZ6f4S7349lRTK9sq5vQGPDLZwVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czufufzvwWByiAPvSEQzhYf+uoV+s9Z3s4wkLQpFKnwvVhCY1kmcuBHbe4gk5OgrDT2rF/QFweGpCGNf2zL1tlzwSmNTwhjwpaPslsd/wq57rQNHeDTK3KRQ1yF2mfqVzyVUBC1M++pPOg0ZttiVByCZQnonuU8EXmaJo/3x3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/YdLykm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8829AC4CEF7;
	Thu, 12 Feb 2026 23:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770940173;
	bh=BUnKZvCHoKZldYxIZ6f4S7349lRTK9sq5vQGPDLZwVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/YdLykmY2ZtXJhal8y2HPLVIlLFlec5+DIp9N7tGLqTcBNVtvo67QGoSvqSVcR9B
	 5DZCNbN0BwGrV49Tu9Re6Sbt6ipN348Xbs6vE0RtHG6lbYoxou4DHUNTEkJRCC28U9
	 AYocDimeGIJr6JwNTVjMoFF9oDmYy7rt+lJbZkxxbQW0Ml8HgSK2D7kIv8Ojk89/Gp
	 5UOB5ZMs7t0Qc2nLOGhr3qREp3yAgOYrTX6uBBx5kiy9XPbDtpp62eqjZ3ytgIj85g
	 txKdeabi/yZl8TAW9q2NlayY+LZXDjGvU0PJCHdv5KxBWMmg3fcf/nsBH1+32kREp/
	 x8zHcSSjIoP3Q==
Date: Thu, 12 Feb 2026 15:49:33 -0800
From: Kees Cook <kees@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, criu@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Koutny <mkoutny@suse.com>
Subject: Re: [PATCH 2/4] exec: inherit HWCAPs from the parent process
Message-ID: <202602121537.8F87466@keescook>
References: <20260209190605.1564597-1-avagin@google.com>
 <20260209190605.1564597-3-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209190605.1564597-3-avagin@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77065-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.org,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB28A131D20
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 07:06:03PM +0000, Andrei Vagin wrote:
> Introduces a mechanism to inherit hardware capabilities (AT_HWCAP,
> AT_HWCAP2, etc.) from a parent process when they have been modified via
> prctl.
> 
> To support C/R operations (snapshots, live migration) in heterogeneous
> clusters, we must ensure that processes utilize CPU features available
> on all potential target nodes. To solve this, we need to advertise a
> common feature set across the cluster.
> 
> This patch adds a new mm flag MMF_USER_HWCAP, which is set when the
> auxiliary vector is modified via prctl(PR_SET_MM, PR_SET_MM_AUXV).  When
> execve() is called, if the current process has MMF_USER_HWCAP set, the
> HWCAP values are extracted from the current auxiliary vector and stored
> in the linux_binprm structure. These values are then used to populate
> the auxiliary vector of the new process, effectively inheriting the
> hardware capabilities.
> 
> The inherited HWCAPs are masked with the hardware capabilities supported
> by the current kernel to ensure that we don't report more features than
> actually supported. This is important to avoid unexpected behavior,
> especially for processes with additional privileges.
> 
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  fs/binfmt_elf.c          |  8 +++---
>  fs/binfmt_elf_fdpic.c    |  8 +++---
>  fs/exec.c                | 61 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/binfmts.h  | 11 ++++++++
>  include/linux/mm_types.h |  2 ++
>  kernel/fork.c            |  3 ++
>  kernel/sys.c             |  5 +++-
>  7 files changed, 89 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 3eb734c192e9..aec129e33f0b 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -246,7 +246,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	 */
>  	ARCH_DLINFO;
>  #endif
> -	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
> +	NEW_AUX_ENT(AT_HWCAP, bprm->hwcap);
>  	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
>  	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
>  	NEW_AUX_ENT(AT_PHDR, phdr_addr);
> @@ -264,13 +264,13 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	NEW_AUX_ENT(AT_SECURE, bprm->secureexec);
>  	NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
>  #ifdef ELF_HWCAP2
> -	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
> +	NEW_AUX_ENT(AT_HWCAP2, bprm->hwcap2);
>  #endif
>  #ifdef ELF_HWCAP3
> -	NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3);
> +	NEW_AUX_ENT(AT_HWCAP3, bprm->hwcap3);
>  #endif
>  #ifdef ELF_HWCAP4
> -	NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4);
> +	NEW_AUX_ENT(AT_HWCAP4, bprm->hwcap4);
>  #endif
>  	NEW_AUX_ENT(AT_EXECFN, bprm->exec);
>  	if (k_platform) {
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index a3d4e6973b29..55b482f03c82 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -629,15 +629,15 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>  	 */
>  	ARCH_DLINFO;
>  #endif
> -	NEW_AUX_ENT(AT_HWCAP,	ELF_HWCAP);
> +	NEW_AUX_ENT(AT_HWCAP,	bprm->hwcap);
>  #ifdef ELF_HWCAP2
> -	NEW_AUX_ENT(AT_HWCAP2,	ELF_HWCAP2);
> +	NEW_AUX_ENT(AT_HWCAP2,	bprm->hwcap2);
>  #endif
>  #ifdef ELF_HWCAP3
> -	NEW_AUX_ENT(AT_HWCAP3,	ELF_HWCAP3);
> +	NEW_AUX_ENT(AT_HWCAP3,	bprm->hwcap3);
>  #endif
>  #ifdef ELF_HWCAP4
> -	NEW_AUX_ENT(AT_HWCAP4,	ELF_HWCAP4);
> +	NEW_AUX_ENT(AT_HWCAP4,	bprm->hwcap4);
>  #endif
>  	NEW_AUX_ENT(AT_PAGESZ,	PAGE_SIZE);
>  	NEW_AUX_ENT(AT_CLKTCK,	CLOCKS_PER_SEC);
> diff --git a/fs/exec.c b/fs/exec.c
> index 9d5ebc9d15b0..7401efbe4ba0 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1462,6 +1462,17 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
>  	 */
>  	bprm->is_check = !!(flags & AT_EXECVE_CHECK);
>  
> +	bprm->hwcap = ELF_HWCAP;
> +#ifdef ELF_HWCAP2
> +	bprm->hwcap2 = ELF_HWCAP2;
> +#endif
> +#ifdef ELF_HWCAP3
> +	bprm->hwcap3 = ELF_HWCAP3;
> +#endif
> +#ifdef ELF_HWCAP4
> +	bprm->hwcap4 = ELF_HWCAP4;
> +#endif
> +
>  	retval = bprm_mm_init(bprm);
>  	if (!retval)
>  		return bprm;
> @@ -1780,6 +1791,53 @@ static int bprm_execve(struct linux_binprm *bprm)
>  	return retval;
>  }
>  
> +static void inherit_hwcap(struct linux_binprm *bprm)
> +{
> +	int i, n;
> +
> +#ifdef ELF_HWCAP4
> +	n = 4;
> +#elif defined(ELF_HWCAP3)
> +	n = 3;
> +#elif defined(ELF_HWCAP2)
> +	n = 2;
> +#else
> +	n = 1;
> +#endif
> +
> +	for (i = 0; n && i < AT_VECTOR_SIZE; i += 2) {
> +		long val = current->mm->saved_auxv[i + 1];

Nit: saved_auxv[] are unsigned long, as are all the bprm->hwcap* vars.

> +
> +		switch (current->mm->saved_auxv[i]) {
> +		case AT_NULL:
> +			goto done;
> +		case AT_HWCAP:
> +			bprm->hwcap = val & ELF_HWCAP;
> +			break;
> +#ifdef ELF_HWCAP2
> +		case AT_HWCAP2:
> +			bprm->hwcap2 = val & ELF_HWCAP2;
> +			break;
> +#endif
> +#ifdef ELF_HWCAP3
> +		case AT_HWCAP3:
> +			bprm->hwcap3 = val & ELF_HWCAP3;
> +			break;
> +#endif
> +#ifdef ELF_HWCAP4
> +		case AT_HWCAP4:
> +			bprm->hwcap4 = val & ELF_HWCAP4;
> +			break;
> +#endif
> +		default:
> +			continue;
> +		}
> +		n--;
> +	}
> +done:
> +	mm_flags_set(MMF_USER_HWCAP, bprm->mm);
> +}
> +
>  static int do_execveat_common(int fd, struct filename *filename,
>  			      struct user_arg_ptr argv,
>  			      struct user_arg_ptr envp,
> @@ -1856,6 +1914,9 @@ static int do_execveat_common(int fd, struct filename *filename,
>  			     current->comm, bprm->filename);
>  	}
>  
> +	if (mm_flags_test(MMF_USER_HWCAP, current->mm))
> +		inherit_hwcap(bprm);
> +
>  	retval = bprm_execve(bprm);
>  out_free:
>  	free_bprm(bprm);
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 65abd5ab8836..94a3dcf9b1d2 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_BINFMTS_H
>  #define _LINUX_BINFMTS_H
>  
> +#include <linux/elf.h>
>  #include <linux/sched.h>
>  #include <linux/unistd.h>
>  #include <asm/exec.h>
> @@ -67,6 +68,16 @@ struct linux_binprm {
>  	unsigned long exec;
>  
>  	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
> +	unsigned long hwcap;
> +#ifdef ELF_HWCAP2
> +	unsigned long hwcap2;
> +#endif
> +#ifdef ELF_HWCAP3
> +	unsigned long hwcap3;
> +#endif
> +#ifdef ELF_HWCAP4
> +	unsigned long hwcap4;
> +#endif
>  
>  	char buf[BINPRM_BUF_SIZE];
>  } __randomize_layout;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 78950eb8926d..68c9131dceee 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1871,6 +1871,8 @@ enum {
>  #define MMF_TOPDOWN		31	/* mm searches top down by default */
>  #define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)
>  
> +#define MMF_USER_HWCAP		32	/* user-defined HWCAPs */

NUM_MM_FLAG_BITS is already 64, but this seems to be the first user of
the next u32 in the bitmap. It _should_ be safe, but we'll need to look
for unexpected weird bugs. :)

> +
>  #define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
>  				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
>  				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b1f3915d5f8e..0091315643de 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1103,6 +1103,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  
>  		__mm_flags_overwrite_word(mm, mmf_init_legacy_flags(flags));
>  		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
> +
> +		if (mm_flags_test(MMF_USER_HWCAP, current->mm))
> +			mm_flags_set(MMF_USER_HWCAP, mm);
>  	} else {
>  		__mm_flags_overwrite_word(mm, default_dump_filter);
>  		mm->def_flags = 0;
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 8d199cf457ae..6fbd7be21a5f 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2157,8 +2157,10 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>  	 * not introduce additional locks here making the kernel
>  	 * more complex.
>  	 */
> -	if (prctl_map.auxv_size)
> +	if (prctl_map.auxv_size) {
>  		memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
> +		mm_flags_set(MMF_USER_HWCAP, current->mm);
> +	}
>  
>  	mmap_read_unlock(mm);
>  	return 0;
> @@ -2190,6 +2192,7 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
>  
>  	task_lock(current);
>  	memcpy(mm->saved_auxv, user_auxv, len);
> +	mm_flags_set(MMF_USER_HWCAP, current->mm);
>  	task_unlock(current);
>  
>  	return 0;
> -- 
> 2.53.0.239.g8d8fc8a987-goog
> 

-- 
Kees Cook

