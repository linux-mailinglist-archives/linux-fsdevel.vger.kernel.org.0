Return-Path: <linux-fsdevel+bounces-57856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D76B25F2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2501C82C04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2502E8885;
	Thu, 14 Aug 2025 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzwSedKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6182DE6E3;
	Thu, 14 Aug 2025 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160759; cv=none; b=mEEYO2ZchR+JOudMjDykGe/oIrM1qlKJNjxa2gQIJ/VleOeYxe58ZqxcHx2ar5iQtuyox+O3o92CvtobOdQ9YI7FNTh1aD91UXSHP+Q0UaoLjjTqWcaxeSBDjgIoPEPO2Nrg/qWEkui/X0G+XFtRTrCNTWp/EH5ZRzGAgN9b2Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160759; c=relaxed/simple;
	bh=wfqWmiFu+hf5riWH1oiwtGbPEfN6D8DeAmej1du6BhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMXcVxJCfNreOc4qPRMjxH9mc4ekPWjdgPFNvmfmb37KFp7ekrYmse3aDY9dVD1zpSRMCSU0D+za6eKgU9t06ZUSMQ1ustSRqrR3XoL9DPO55l6VJiGJFcMWFXb/aN6JA4hikm+9ujq1X5gOQbQt3dmcVAI29OsvovUS5qpTNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzwSedKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7188CC4CEF4;
	Thu, 14 Aug 2025 08:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755160756;
	bh=wfqWmiFu+hf5riWH1oiwtGbPEfN6D8DeAmej1du6BhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JzwSedKiUIueXjAwiEvvgu9Pg7k0kNpnO8Uu4NT96uQ5AFJeZLFlxMhMYmmqQKgf9
	 vkRr6fLBH/J6KQaFSI5SL4BICjVxdtsmUGvpcNsQgVqh8n+TDsLp/ZSzZGKwJy6Vu/
	 P26Vc0ScJ0V1qyZCwGuo5A9RurBj/wQK5MgjLtYcBOlURHX9zRDDmhud/nvuI+G1Kp
	 7AR6ipV+2txrE2N62GVE5xzXojsCfMmVJMeTlKseveRHMqgGHGJeEa8Tt0gzNwMRjO
	 9krcCidK65DrhHDCRoNCXT2dOKsRCBYhgtjRqtbs1HvHnV8ajX5CJxMw/Oe6FjlzvD
	 kjMlCCcya+wJA==
Date: Thu, 14 Aug 2025 11:38:53 +0300
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
Subject: Re: [PATCH 07/10] mm: correct sign-extension issue in MMF_* flag
 masks
Message-ID: <aJ2gnTpRW3QLTcn6@kernel.org>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <f92194bee8c92a04fd4c9b2c14c7e65229639300.1755012943.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92194bee8c92a04fd4c9b2c14c7e65229639300.1755012943.git.lorenzo.stoakes@oracle.com>

On Tue, Aug 12, 2025 at 04:44:16PM +0100, Lorenzo Stoakes wrote:
> There is an issue with the mask declarations in linux/mm_types.h, which
> naively do (1 << bit) operations. Unfortunately this results in the 1 being
> defaulted as a signed (32-bit) integer.
> 
> When the compiler expands the MMF_INIT_MASK bitmask it comes up with:
> 
> (((1 << 2) - 1) | (((1 << 9) - 1) << 2) | (1 << 24) | (1 << 28) | (1 << 30)
> | (1 << 31))
> 
> Which overflows the signed integer to -788,527,105. Implicitly casting this
> to an unsigned integer results in sign-expansion, and thus this value
> becomes 0xffffffffd10007ff, rather than the intended 0xd10007ff.
> 
> While we're limited to a maximum of 32 bits in mm->flags, this isn't an
> issue as the remaining bits being masked will always be zero.
> 
> However, now we are moving towards having more bits in this flag, this
> becomes an issue.
> 
> Simply resolve this by using the _BITUL() helper to cast the shifted value
> to an unsigned long.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/mm_types.h | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 46d3fb8935c7..38b3fa927997 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1756,7 +1756,7 @@ enum {
>   * the modes are SUID_DUMP_* defined in linux/sched/coredump.h
>   */
>  #define MMF_DUMPABLE_BITS 2
> -#define MMF_DUMPABLE_MASK ((1 << MMF_DUMPABLE_BITS) - 1)
> +#define MMF_DUMPABLE_MASK (_BITUL(MMF_DUMPABLE_BITS) - 1)
>  /* coredump filter bits */
>  #define MMF_DUMP_ANON_PRIVATE	2
>  #define MMF_DUMP_ANON_SHARED	3
> @@ -1771,13 +1771,13 @@ enum {
>  #define MMF_DUMP_FILTER_SHIFT	MMF_DUMPABLE_BITS
>  #define MMF_DUMP_FILTER_BITS	9
>  #define MMF_DUMP_FILTER_MASK \
> -	(((1 << MMF_DUMP_FILTER_BITS) - 1) << MMF_DUMP_FILTER_SHIFT)
> +	((_BITUL(MMF_DUMP_FILTER_BITS) - 1) << MMF_DUMP_FILTER_SHIFT)
>  #define MMF_DUMP_FILTER_DEFAULT \
> -	((1 << MMF_DUMP_ANON_PRIVATE) |	(1 << MMF_DUMP_ANON_SHARED) |\
> -	 (1 << MMF_DUMP_HUGETLB_PRIVATE) | MMF_DUMP_MASK_DEFAULT_ELF)
> +	(_BITUL(MMF_DUMP_ANON_PRIVATE) | _BITUL(MMF_DUMP_ANON_SHARED) | \
> +	 _BITUL(MMF_DUMP_HUGETLB_PRIVATE) | MMF_DUMP_MASK_DEFAULT_ELF)
>  
>  #ifdef CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS
> -# define MMF_DUMP_MASK_DEFAULT_ELF	(1 << MMF_DUMP_ELF_HEADERS)
> +# define MMF_DUMP_MASK_DEFAULT_ELF	_BITUL(MMF_DUMP_ELF_HEADERS)
>  #else
>  # define MMF_DUMP_MASK_DEFAULT_ELF	0
>  #endif
> @@ -1797,7 +1797,7 @@ enum {
>  #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
>  #define MMF_HUGE_ZERO_FOLIO	23      /* mm has ever used the global huge zero folio */
>  #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
> -#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
> +#define MMF_DISABLE_THP_MASK	_BITUL(MMF_DISABLE_THP)
>  #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
>  #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
>  /*
> @@ -1810,16 +1810,15 @@ enum {
>  #define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */
>  
>  #define MMF_HAS_MDWE		28
> -#define MMF_HAS_MDWE_MASK	(1 << MMF_HAS_MDWE)
> -
> +#define MMF_HAS_MDWE_MASK	_BITUL(MMF_HAS_MDWE)
>  
>  #define MMF_HAS_MDWE_NO_INHERIT	29
>  
>  #define MMF_VM_MERGE_ANY	30
> -#define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
> +#define MMF_VM_MERGE_ANY_MASK	_BITUL(MMF_VM_MERGE_ANY)
>  
>  #define MMF_TOPDOWN		31	/* mm searches top down by default */
> -#define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)
> +#define MMF_TOPDOWN_MASK	_BITUL(MMF_TOPDOWN)
>  
>  #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
>  				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
> -- 
> 2.50.1
> 

-- 
Sincerely yours,
Mike.

