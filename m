Return-Path: <linux-fsdevel+bounces-57857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0323B25F24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674C35C01A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 08:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9D72E7F25;
	Thu, 14 Aug 2025 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ5tqXiS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6061204090;
	Thu, 14 Aug 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160822; cv=none; b=fHUvCa4/6Cazr9F82DNwLXuRvBGyR9LbUOj0gkMIq+timmD1O+0JyligeWcRi9KS4KXyrYYUFdOsw1zwPvn4WFWIVbpze6Bc8JOcPr/K7DmIiyn0wC4nrXh1bxSpqMWE5604zR/Dz2q7er7w0qeXSlujSRMTk5k2Isk3cMfIPgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160822; c=relaxed/simple;
	bh=zqmt4Jj8Tl4AG5pUIufRcdzVJq4JYdl8O/zAhI2YC70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuUhJSMwnl3IBTgWFspiPiloXCo2EqLLsFjLy2y4aZze6IUGsFMjcYRMHLxOs9lzirP+S9xrwN0YyZO2bVSYUp5CcZlY/LQLRAY1FZz31PsejDGbsi++/GziZZ3nt/1y63b5o8TxCBA6n1sNOvMBcc6VdBOW8pVPGPVvF6uxDJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ5tqXiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC94C4AF09;
	Thu, 14 Aug 2025 08:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755160821;
	bh=zqmt4Jj8Tl4AG5pUIufRcdzVJq4JYdl8O/zAhI2YC70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZ5tqXiSOEwYFaq79WS5EhkFn8Z5imGYNmIePfhjJTAhyZJEgDA7Bwly8nCqYBrRu
	 d5UBO0ASyeI4lggmFmZP5Ii3320gaokMa2FN+oxetsh12TTGQ+8oWdtIFgLAmFwDa8
	 JmyiIhU5NvRChb93aRk4sfsoi6H8QvZGvsj0WePGnaiA2KQ0/+8V6zFvTPRMYPKrqn
	 1S4BU4qOOBW810STnQ9C/RqF+W8yGtXS38JRPzp9ypmj54uCmkS4f0kA57Jmi573iT
	 nQhBwXuhJUpx99j/CnWWG20Qpb4JWWkPn9hA8ESGXnWKA625fvfdzX3MjXix2LjKhh
	 b4YJ1g7zPit1g==
Date: Thu, 14 Aug 2025 11:39:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 08/10] mm: update fork mm->flags initialisation to use
 bitmap
Message-ID: <aJ2g3VODv5Fp9aQL@kernel.org>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <9fb8954a7a0f0184f012a8e66f8565bcbab014ba.1755012943.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fb8954a7a0f0184f012a8e66f8565bcbab014ba.1755012943.git.lorenzo.stoakes@oracle.com>

On Tue, Aug 12, 2025 at 04:44:17PM +0100, Lorenzo Stoakes wrote:
> We now need to account for flag initialisation on fork. We retain the
> existing logic as much as we can, but dub the existing flag mask legacy.
> 
> These flags are therefore required to fit in the first 32-bits of the flags
> field.
> 
> However, further flag propagation upon fork can be implemented in mm_init()
> on a per-flag basis.
> 
> We ensure we clear the entire bitmap prior to setting it, and use
> __mm_flags_get_word() and __mm_flags_set_word() to manipulate these legacy
> fields efficiently.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/mm_types.h | 13 ++++++++++---
>  kernel/fork.c            |  7 +++++--
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 38b3fa927997..25577ab39094 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1820,16 +1820,23 @@ enum {
>  #define MMF_TOPDOWN		31	/* mm searches top down by default */
>  #define MMF_TOPDOWN_MASK	_BITUL(MMF_TOPDOWN)
>  
> -#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> +#define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
>  				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
>  				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
>  
> -static inline unsigned long mmf_init_flags(unsigned long flags)
> +/* Legacy flags must fit within 32 bits. */
> +static_assert((u64)MMF_INIT_LEGACY_MASK <= (u64)UINT_MAX);
> +
> +/*
> + * Initialise legacy flags according to masks, propagating selected flags on
> + * fork. Further flag manipulation can be performed by the caller.
> + */
> +static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
>  {
>  	if (flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))
>  		flags &= ~((1UL << MMF_HAS_MDWE) |
>  			   (1UL << MMF_HAS_MDWE_NO_INHERIT));
> -	return flags & MMF_INIT_MASK;
> +	return flags & MMF_INIT_LEGACY_MASK;
>  }
>  
>  #endif /* _LINUX_MM_TYPES_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index c4ada32598bd..b311caec6419 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1056,11 +1056,14 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	mm_init_uprobes_state(mm);
>  	hugetlb_count_init(mm);
>  
> +	mm_flags_clear_all(mm);
>  	if (current->mm) {
> -		mm->flags = mmf_init_flags(current->mm->flags);
> +		unsigned long flags = __mm_flags_get_word(current->mm);
> +
> +		__mm_flags_set_word(mm, mmf_init_legacy_flags(flags));
>  		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
>  	} else {
> -		mm->flags = default_dump_filter;
> +		__mm_flags_set_word(mm, default_dump_filter);
>  		mm->def_flags = 0;
>  	}
>  
> -- 
> 2.50.1
> 

-- 
Sincerely yours,
Mike.

