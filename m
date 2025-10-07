Return-Path: <linux-fsdevel+bounces-63558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38609BC235A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 19:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5B93AAD82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 17:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD862E8B76;
	Tue,  7 Oct 2025 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVsXKOAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123B13C33;
	Tue,  7 Oct 2025 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856518; cv=none; b=DLn5meBspGvH8xzvNbF4qTyb61KB7xp2cXqHZVc3CiuI9aQMgAY4a/pFbhb97685wb3rvOfBT/2ZqjzsFU+btfdTnc0Zq+cQKnYLiQuwM9ZmytnhRLVKPMfnn1EPxn1rhKjYm0JJBV9443x2QjPA453NsNDYhaZ8i254X19ULo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856518; c=relaxed/simple;
	bh=MR5qWTAOW1zVyTLdPwwD9muosMP83f5qZfp7s+T/8Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1ikM1yooxaCS6SmrlGF9i4qT7lykQWwTdBm4abgAUyeMKtwf/1f421XujnRROkgAjbc54RRiQ8ZMgenwdUXyASB7vtOrogcl4OFmBkfQtanazPOdR6X5ju1hjykLkIi5m4T9+/JZIugixmHY5yNExWaKzukKmrUjMjeMxNVNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVsXKOAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8520DC4CEF1;
	Tue,  7 Oct 2025 17:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759856517;
	bh=MR5qWTAOW1zVyTLdPwwD9muosMP83f5qZfp7s+T/8Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVsXKOAnGQWHMUvRXJC+HD5Ptm4rKk3wxOY0m04k1/vuFPLEHYh1doW38jWqMNOMW
	 L/7qM0gkru7kkBntPfDcFUXYAL1plH+dhqEAgp+KQ6vTxlekXWdDnfOns9KPwLbeXH
	 Elolz6FA56YCumDWpBov0HylXOdE0TORtEJ8uImPWRAVl/pzLNrlxZgxIFye24JnY2
	 J5+nyBymaFOYpMgWzoep6qXlaii0EaJtnDWnfxt+SO/HNj+0bkgOqNlQbtV/G+dOlz
	 GeHfdBkrc7bZc9x2Nx172su4AQjqB0A+lLDzUAZQS0AUQTskSrERr7EU1U5QnEltLP
	 5wtZOGCn+mO5w==
Date: Tue, 7 Oct 2025 10:01:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: acsjakub@amazon.de, akpm@linux-foundation.org, axelrasmussen@google.com,
	chengming.zhou@linux.dev, david@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, peterx@redhat.com, xu.xin16@zte.com.cn,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] mm: use enum for vm_flags
Message-ID: <20251007170156.GQ1587915@frogsfrogsfrogs>
References: <20251002075202.11306-1-acsjakub@amazon.de>
 <20251007162136.1885546-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007162136.1885546-1-aliceryhl@google.com>

On Tue, Oct 07, 2025 at 04:21:36PM +0000, Alice Ryhl wrote:
> The bindgen tool is better able to handle BIT(_) declarations when used
> in an enum.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Hi Jakub,
> 
> what do you think about modifying the patch like this to use an enum? It
> resolves the issues brought up in
> 	https://lore.kernel.org/all/CAH5fLghTu-Zcm9e3Hy07nNtvB_-hRjojAWDoq-hhBYGE7LPEbQ@mail.gmail.com/
> 
> Feel free to squash this patch into your patch.
> 
>  include/linux/mm.h              | 90 +++++++++++++++++----------------
>  rust/bindings/bindings_helper.h |  1 -
>  2 files changed, 46 insertions(+), 45 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7916d527f687..69da7ce13e50 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -273,57 +273,58 @@ extern unsigned int kobjsize(const void *objp);
>   * vm_flags in vm_area_struct, see mm_types.h.
>   * When changing, update also include/trace/events/mmflags.h
>   */
> -#define VM_NONE		0
> +enum {
> +	VM_NONE		= 0,
>  
> -#define VM_READ		BIT(0)		/* currently active flags */
> -#define VM_WRITE	BIT(1)
> -#define VM_EXEC		BIT(2)
> -#define VM_SHARED	BIT(3)
> +	VM_READ		= BIT(0),		/* currently active flags */
> +	VM_WRITE	= BIT(1),
> +	VM_EXEC		= BIT(2),
> +	VM_SHARED	= BIT(3),

mmflags.h contains ... a lot of macros, but I think if you change the
vmflags to an enum, you have to wrap every value of that enum in a
TRACE_DEFINE_ENUM or else __print_flags on an array(?) of {value,
string} pairs stops working.

Concretely, I think show_vma_flags (which uses __def_vmaflag_names) will
stop working here.  I'm no ftrace magician here, but AFAICT the third
argument to __print_flags is stored verbatim in the tracefs format file,
and the userspace ftrace tools use that to convert the raw data into a
user friendly string.  For whatever reason, enumerations aren't
converted to their underlying integer values by default, so the
userspace program can't do the translation.  TRACE_DEFINE_ENUM is a
magic that makes that happen.

<shrug> Don't mind me :)

--D

>  
>  /* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
> -#define VM_MAYREAD	BIT(4)		/* limits for mprotect() etc */
> -#define VM_MAYWRITE	BIT(5)
> -#define VM_MAYEXEC	BIT(6)
> -#define VM_MAYSHARE	BIT(7)
> +	VM_MAYREAD	= BIT(4),		/* limits for mprotect() etc */
> +	VM_MAYWRITE	= BIT(5),
> +	VM_MAYEXEC	= BIT(6),
> +	VM_MAYSHARE	= BIT(7),
>  
> -#define VM_GROWSDOWN	BIT(8)		/* general info on the segment */
> +	VM_GROWSDOWN	= BIT(8),		/* general info on the segment */
>  #ifdef CONFIG_MMU
> -#define VM_UFFD_MISSING	BIT(9)		/* missing pages tracking */
> +	VM_UFFD_MISSING	= BIT(9),		/* missing pages tracking */
>  #else /* CONFIG_MMU */
> -#define VM_MAYOVERLAY	BIT(9)		/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
> +	VM_MAYOVERLAY	= BIT(9),		/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
>  #define VM_UFFD_MISSING	0
>  #endif /* CONFIG_MMU */
> -#define VM_PFNMAP	BIT(10)		/* Page-ranges managed without "struct page", just pure PFN */
> -#define VM_UFFD_WP	BIT(12)		/* wrprotect pages tracking */
> -
> -#define VM_LOCKED	BIT(13)
> -#define VM_IO           BIT(14)		/* Memory mapped I/O or similar */
> -
> -					/* Used by sys_madvise() */
> -#define VM_SEQ_READ	BIT(15)		/* App will access data sequentially */
> -#define VM_RAND_READ	BIT(16)		/* App will not benefit from clustered reads */
> -
> -#define VM_DONTCOPY	BIT(17)		/* Do not copy this vma on fork */
> -#define VM_DONTEXPAND	BIT(18)		/* Cannot expand with mremap() */
> -#define VM_LOCKONFAULT	BIT(19)		/* Lock the pages covered when they are faulted in */
> -#define VM_ACCOUNT	BIT(20)		/* Is a VM accounted object */
> -#define VM_NORESERVE	BIT(21)		/* should the VM suppress accounting */
> -#define VM_HUGETLB	BIT(22)		/* Huge TLB Page VM */
> -#define VM_SYNC		BIT(23)		/* Synchronous page faults */
> -#define VM_ARCH_1	BIT(24)		/* Architecture-specific flag */
> -#define VM_WIPEONFORK	BIT(25)		/* Wipe VMA contents in child. */
> -#define VM_DONTDUMP	BIT(26)		/* Do not include in the core dump */
> +	VM_PFNMAP	= BIT(10),		/* Page-ranges managed without "struct page", just pure PFN */
> +	VM_UFFD_WP	= BIT(12),		/* wrprotect pages tracking */
> +
> +	VM_LOCKED	= BIT(13),
> +	VM_IO           = BIT(14),		/* Memory mapped I/O or similar */
> +
> +						/* Used by sys_madvise() */
> +	VM_SEQ_READ	= BIT(15),		/* App will access data sequentially */
> +	VM_RAND_READ	= BIT(16),		/* App will not benefit from clustered reads */
> +
> +	VM_DONTCOPY	= BIT(17),		/* Do not copy this vma on fork */
> +	VM_DONTEXPAND	= BIT(18),		/* Cannot expand with mremap() */
> +	VM_LOCKONFAULT	= BIT(19),		/* Lock the pages covered when they are faulted in */
> +	VM_ACCOUNT	= BIT(20),		/* Is a VM accounted object */
> +	VM_NORESERVE	= BIT(21),		/* should the VM suppress accounting */
> +	VM_HUGETLB	= BIT(22),		/* Huge TLB Page VM */
> +	VM_SYNC		= BIT(23),		/* Synchronous page faults */
> +	VM_ARCH_1	= BIT(24),		/* Architecture-specific flag */
> +	VM_WIPEONFORK	= BIT(25),		/* Wipe VMA contents in child. */
> +	VM_DONTDUMP	= BIT(26),		/* Do not include in the core dump */
>  
>  #ifdef CONFIG_MEM_SOFT_DIRTY
> -# define VM_SOFTDIRTY	BIT(27)		/* Not soft dirty clean area */
> +	VM_SOFTDIRTY	= BIT(27),		/* Not soft dirty clean area */
>  #else
>  # define VM_SOFTDIRTY	0
>  #endif
>  
> -#define VM_MIXEDMAP	BIT(28)		/* Can contain "struct page" and pure PFN pages */
> -#define VM_HUGEPAGE	BIT(29)		/* MADV_HUGEPAGE marked this vma */
> -#define VM_NOHUGEPAGE	BIT(30)		/* MADV_NOHUGEPAGE marked this vma */
> -#define VM_MERGEABLE	BIT(31)		/* KSM may merge identical pages */
> +	VM_MIXEDMAP	= BIT(28),		/* Can contain "struct page" and pure PFN pages */
> +	VM_HUGEPAGE	= BIT(29),		/* MADV_HUGEPAGE marked this vma */
> +	VM_NOHUGEPAGE	= BIT(30),		/* MADV_NOHUGEPAGE marked this vma */
> +	VM_MERGEABLE	= BIT(31),		/* KSM may merge identical pages */
>  
>  #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
>  #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
> @@ -333,14 +334,15 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_BIT_6	38	/* bit only usable on 64-bit architectures */
> -#define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
> -#define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
> -#define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
> -#define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
> -#define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
> -#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
> -#define VM_HIGH_ARCH_6	BIT(VM_HIGH_ARCH_BIT_6)
> +	VM_HIGH_ARCH_0	= BIT(VM_HIGH_ARCH_BIT_0),
> +	VM_HIGH_ARCH_1	= BIT(VM_HIGH_ARCH_BIT_1),
> +	VM_HIGH_ARCH_2	= BIT(VM_HIGH_ARCH_BIT_2),
> +	VM_HIGH_ARCH_3	= BIT(VM_HIGH_ARCH_BIT_3),
> +	VM_HIGH_ARCH_4	= BIT(VM_HIGH_ARCH_BIT_4),
> +	VM_HIGH_ARCH_5	= BIT(VM_HIGH_ARCH_BIT_5),
> +	VM_HIGH_ARCH_6	= BIT(VM_HIGH_ARCH_BIT_6),
>  #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
> +};
>  
>  #ifdef CONFIG_ARCH_HAS_PKEYS
>  # define VM_PKEY_SHIFT VM_HIGH_ARCH_BIT_0
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 2e43c66635a2..04b75d4d01c3 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -108,7 +108,6 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
>  
>  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
>  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
> -const vm_flags_t RUST_CONST_HELPER_VM_MERGEABLE = VM_MERGEABLE;
>  
>  #if IS_ENABLED(CONFIG_ANDROID_BINDER_IPC_RUST)
>  #include "../../drivers/android/binder/rust_binder.h"
> -- 
> 2.51.0.618.g983fd99d29-goog
> 
> 

