Return-Path: <linux-fsdevel+bounces-52162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9B7AE001B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 883BE7AEC3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E602726561D;
	Thu, 19 Jun 2025 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SErdEUma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AF264638;
	Thu, 19 Jun 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322550; cv=none; b=ePqdSfPbKxbkbfnbHyqPHNmsWOWDfNcdFhg0Jni8YphW7G/dAc9beyC22bzOtB9WMgNBINLUpPig5UDetY8SDq6cjHr5uvaMcUAG8WHGgOPVs5cNwBiWx+oV//ryl60MCWgAv+APSAfqVaFF5rlkooUQb1lih+U+5Ik+ZX3T9Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322550; c=relaxed/simple;
	bh=3VFuG2FOQta3qfo/tXfeyceWpM2CtNcoqXoxG/UtwWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYDCydWsCcZHM6bs4ztQXS+x2V51A3WCpfWBlYG0V10ELhXoTBg+0wIxRIPdcpHJbuWvxrqU6yJaTHIZlmxlElm9x5LncCt8fmy/Uv2IX6kEHPcUgpr8HvAsJHkJp1eS4FKJdWaLYcrajTgCf7UUZC+4wzUoE6AtnMhcs7HcXmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SErdEUma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FBBC4CEEA;
	Thu, 19 Jun 2025 08:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750322549;
	bh=3VFuG2FOQta3qfo/tXfeyceWpM2CtNcoqXoxG/UtwWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SErdEUmaRiXUtAdabhdTNYYV8q5kEViKHeMvbdP07i8SdJqnyGDweje7/hf5ob2r1
	 Y7GakfurOZd/kO55Uuejfbjb1S87B2AsLMEOZS16N3PqMiLkRzq0uK6SYLU7qgvTU/
	 SVw+UbeIJFOnBUY3xSh5j8mzLsb/i9WbBp9W6Nyzn5AswOiCpHExDyjKEa4xghVxhq
	 qVMVSR8Ah8c9+Gp0UD1wpCI2KA3aEvgMXWU2aB9vqWItkHQLyOH3Ng4vCX7N4MSO38
	 GNkOCm/RoBAbDnsH25JuklGSA+93rTqS16MvDDHIq0NGhvg1unBUyT6Up6WtuKaRQA
	 0XljRO/7NmUxw==
Date: Thu, 19 Jun 2025 10:42:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: change vm_get_page_prot() to accept vm_flags_t
 argument
Message-ID: <20250619-unwiederholbar-addition-6875c99fe08d@brauner>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>

On Wed, Jun 18, 2025 at 08:42:52PM +0100, Lorenzo Stoakes wrote:
> We abstract the type of the VMA flags to vm_flags_t, however in may places
> it is simply assumed this is unsigned long, which is simply incorrect.
> 
> At the moment this is simply an incongruity, however in future we plan to
> change this type and therefore this change is a critical requirement for
> doing so.
> 
> Overall, this patch does not introduce any functional change.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  arch/arm64/mm/mmap.c                       | 2 +-
>  arch/powerpc/include/asm/book3s/64/pkeys.h | 3 ++-
>  arch/sparc/mm/init_64.c                    | 2 +-
>  arch/x86/mm/pgprot.c                       | 2 +-
>  include/linux/mm.h                         | 4 ++--
>  include/linux/pgtable.h                    | 2 +-
>  tools/testing/vma/vma_internal.h           | 2 +-
>  7 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index c86c348857c4..08ee177432c2 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -81,7 +81,7 @@ static int __init adjust_protection_map(void)
>  }
>  arch_initcall(adjust_protection_map);
>  
> -pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
>  {
>  	ptdesc_t prot;
>  
> diff --git a/arch/powerpc/include/asm/book3s/64/pkeys.h b/arch/powerpc/include/asm/book3s/64/pkeys.h
> index 5b178139f3c0..6f2075636591 100644
> --- a/arch/powerpc/include/asm/book3s/64/pkeys.h
> +++ b/arch/powerpc/include/asm/book3s/64/pkeys.h
> @@ -4,8 +4,9 @@
>  #define _ASM_POWERPC_BOOK3S_64_PKEYS_H
>  
>  #include <asm/book3s/64/hash-pkey.h>
> +#include <linux/mm_types.h>
>  
> -static inline u64 vmflag_to_pte_pkey_bits(u64 vm_flags)
> +static inline u64 vmflag_to_pte_pkey_bits(vm_flags_t vm_flags)

If you change vm_flags_t to u64 you probably want to compile with some
of these integer truncation options when you're doing the conversion.
Because otherwise you risk silently truncating the upper 32bits when
assigning to a 32bit variable. We've had had a patch series that almost
introduced a very subtle bug when it tried to add the first flag outside
the 32bit range in the lookup code a while ago. That series never made
it but it just popped back into my head when I read your series.

Acked-by: Christian Brauner <brauner@kernel.org>

