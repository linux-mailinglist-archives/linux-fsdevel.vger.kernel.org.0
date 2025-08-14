Return-Path: <linux-fsdevel+bounces-57850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD6FB25ECD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88AF39E0EC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 08:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06552E973E;
	Thu, 14 Aug 2025 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSWJOQUE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5BE2E7BBB;
	Thu, 14 Aug 2025 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160060; cv=none; b=Tbys6mrQ2lEQxaIquoSWFoK5ldAjtRdUNRC5GIJOUP74AKE51V6HYSqp2M97JtkM+P68dY6k4IUN26SdlKG7BG+YjknJNOHI5b/s2MT1c/v4PnElrWINkT4//pcwyRwLsLSNXY03HaHAIU/buz3Pv6HXjglAKnsjmqB/4+NrVPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160060; c=relaxed/simple;
	bh=+g86Qmw3P3PJ1AG+gPw3MtOk3EbK2uZf8gwDidq2cAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl3zNCVPzCi1+V5j4kBcQ355exCR89qX+qTcRCZ4Hv76Qt6YgqIcdBAefx68msYk+2tLgUF2pKsg4S5VfT3AQjTJCRvX2oB7DOPRMjCMr/yZip9RHpuvj9Onfwv1Kl/dDf9rflfHBcPhldSfQF0zev4KO6f62bmA6taE9NXX4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSWJOQUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5DEC4CEF4;
	Thu, 14 Aug 2025 08:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755160058;
	bh=+g86Qmw3P3PJ1AG+gPw3MtOk3EbK2uZf8gwDidq2cAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSWJOQUEjXVFkQuLaLSb2GZTQV42DBKhjom9hLlp6cgwyLHr/55l7aXyPclUXWGis
	 o8pDfmcFi1wf8KgwgDlQVITxnSQDDZYfEMdMbxusrQFYy8hc0s6uiy7Fj3svNy2Y82
	 f+zPAUPB8R6fGV79yj7qVMB97Ros2mn4exQsTKBlmnIMWT4BdsjGeHaxSZyGCpOqPw
	 kaOtS8C9RyUhdhyYQS26T9XV6N0FXAjwfM0FEOQhrX/otTrMCAv0lGe8/4LW+1C3IN
	 gCfrjjyrRvJsH0MycZRtHf9bqqdwMEDKvgmlMyR1URpxz6ISltaIXA0bnklNrJR7Dc
	 SuK6AFs6EBSow==
Date: Thu, 14 Aug 2025 11:27:15 +0300
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
Subject: Re: [PATCH 02/10] mm: convert core mm to mm_flags_*() accessors
Message-ID: <aJ2d41cF5dFhZ3qs@kernel.org>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>

On Tue, Aug 12, 2025 at 04:44:11PM +0100, Lorenzo Stoakes wrote:
> As part of the effort to move to mm->flags becoming a bitmap field, convert
> existing users to making use of the mm_flags_*() accessors which will, when
> the conversion is complete, be the only means of accessing mm_struct flags.
> 
> This will result in the debug output being that of a bitmap output, which
> will result in a minor change here, but since this is for debug only, this
> should have no bearing.
> 
> Otherwise, no functional changes intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/huge_mm.h    |  2 +-
>  include/linux/khugepaged.h |  6 ++++--
>  include/linux/ksm.h        |  6 +++---
>  include/linux/mm.h         |  2 +-
>  include/linux/mman.h       |  2 +-
>  include/linux/oom.h        |  2 +-
>  mm/debug.c                 |  4 ++--
>  mm/gup.c                   | 10 +++++-----
>  mm/huge_memory.c           |  8 ++++----
>  mm/khugepaged.c            | 10 +++++-----
>  mm/ksm.c                   | 32 ++++++++++++++++----------------
>  mm/mmap.c                  |  8 ++++----
>  mm/oom_kill.c              | 26 +++++++++++++-------------
>  mm/util.c                  |  6 +++---
>  14 files changed, 63 insertions(+), 61 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 14d424830fa8..84b7eebe0d68 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -327,7 +327,7 @@ static inline bool vma_thp_disabled(struct vm_area_struct *vma,
>  	 * example, s390 kvm.
>  	 */
>  	return (vm_flags & VM_NOHUGEPAGE) ||
> -	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
> +	       mm_flags_test(MMF_DISABLE_THP, vma->vm_mm);
>  }
>  
>  static inline bool thp_disabled_by_hw(void)
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index ff6120463745..eb1946a70cff 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_KHUGEPAGED_H
>  #define _LINUX_KHUGEPAGED_H
>  
> +#include <linux/mm.h>
> +
>  extern unsigned int khugepaged_max_ptes_none __read_mostly;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  extern struct attribute_group khugepaged_attr_group;
> @@ -20,13 +22,13 @@ extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>  
>  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
> -	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
> +	if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
>  		__khugepaged_enter(mm);
>  }
>  
>  static inline void khugepaged_exit(struct mm_struct *mm)
>  {
> -	if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
> +	if (mm_flags_test(MMF_VM_HUGEPAGE, mm))
>  		__khugepaged_exit(mm);
>  }
>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index c17b955e7b0b..22e67ca7cba3 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -56,13 +56,13 @@ static inline long mm_ksm_zero_pages(struct mm_struct *mm)
>  static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
>  	/* Adding mm to ksm is best effort on fork. */
> -	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
> +	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm))
>  		__ksm_enter(mm);
>  }
>  
>  static inline int ksm_execve(struct mm_struct *mm)
>  {
> -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> +	if (mm_flags_test(MMF_VM_MERGE_ANY, mm))
>  		return __ksm_enter(mm);
>  
>  	return 0;
> @@ -70,7 +70,7 @@ static inline int ksm_execve(struct mm_struct *mm)
>  
>  static inline void ksm_exit(struct mm_struct *mm)
>  {
> -	if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
> +	if (mm_flags_test(MMF_VM_MERGEABLE, mm))
>  		__ksm_exit(mm);
>  }
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4ed4a0b9dad6..34311ebe62cc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1949,7 +1949,7 @@ static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
>  {
>  	VM_BUG_ON(!(raw_read_seqcount(&vma->vm_mm->write_protect_seq) & 1));
>  
> -	if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
> +	if (!mm_flags_test(MMF_HAS_PINNED, vma->vm_mm))
>  		return false;
>  
>  	return folio_maybe_dma_pinned(folio);
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index de9e8e6229a4..0ba8a7e8b90a 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -201,7 +201,7 @@ static inline bool arch_memory_deny_write_exec_supported(void)
>  static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
>  {
>  	/* If MDWE is disabled, we have nothing to deny. */
> -	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
> +	if (!mm_flags_test(MMF_HAS_MDWE, current->mm))
>  		return false;
>  
>  	/* If the new VMA is not executable, we have nothing to deny. */
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 1e0fc6931ce9..7b02bc1d0a7e 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -91,7 +91,7 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
>   */
>  static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
>  {
> -	if (unlikely(test_bit(MMF_UNSTABLE, &mm->flags)))
> +	if (unlikely(mm_flags_test(MMF_UNSTABLE, mm)))
>  		return VM_FAULT_SIGBUS;
>  	return 0;
>  }
> diff --git a/mm/debug.c b/mm/debug.c
> index b4388f4dcd4d..64ddb0c4b4be 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -182,7 +182,7 @@ void dump_mm(const struct mm_struct *mm)
>  		"start_code %lx end_code %lx start_data %lx end_data %lx\n"
>  		"start_brk %lx brk %lx start_stack %lx\n"
>  		"arg_start %lx arg_end %lx env_start %lx env_end %lx\n"
> -		"binfmt %px flags %lx\n"
> +		"binfmt %px flags %*pb\n"
>  #ifdef CONFIG_AIO
>  		"ioctx_table %px\n"
>  #endif
> @@ -211,7 +211,7 @@ void dump_mm(const struct mm_struct *mm)
>  		mm->start_code, mm->end_code, mm->start_data, mm->end_data,
>  		mm->start_brk, mm->brk, mm->start_stack,
>  		mm->arg_start, mm->arg_end, mm->env_start, mm->env_end,
> -		mm->binfmt, mm->flags,
> +		mm->binfmt, NUM_MM_FLAG_BITS, __mm_flags_get_bitmap(mm),
>  #ifdef CONFIG_AIO
>  		mm->ioctx_table,
>  #endif
> diff --git a/mm/gup.c b/mm/gup.c
> index adffe663594d..331d22bf7b2d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -475,10 +475,10 @@ EXPORT_SYMBOL_GPL(unpin_folios);
>   * lifecycle.  Avoid setting the bit unless necessary, or it might cause write
>   * cache bouncing on large SMP machines for concurrent pinned gups.
>   */
> -static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
> +static inline void mm_set_has_pinned_flag(struct mm_struct *mm)
>  {
> -	if (!test_bit(MMF_HAS_PINNED, mm_flags))
> -		set_bit(MMF_HAS_PINNED, mm_flags);
> +	if (!mm_flags_test(MMF_HAS_PINNED, mm))
> +		mm_flags_set(MMF_HAS_PINNED, mm);
>  }
>  
>  #ifdef CONFIG_MMU
> @@ -1693,7 +1693,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>  		mmap_assert_locked(mm);
>  
>  	if (flags & FOLL_PIN)
> -		mm_set_has_pinned_flag(&mm->flags);
> +		mm_set_has_pinned_flag(mm);
>  
>  	/*
>  	 * FOLL_PIN and FOLL_GET are mutually exclusive. Traditional behavior
> @@ -3210,7 +3210,7 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
>  		return -EINVAL;
>  
>  	if (gup_flags & FOLL_PIN)
> -		mm_set_has_pinned_flag(&current->mm->flags);
> +		mm_set_has_pinned_flag(current->mm);
>  
>  	if (!(gup_flags & FOLL_FAST_ONLY))
>  		might_lock_read(&current->mm->mmap_lock);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b8bb078a1a34..a2f476e7419a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -251,13 +251,13 @@ struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
>  	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
>  		return huge_zero_folio;
>  
> -	if (test_bit(MMF_HUGE_ZERO_FOLIO, &mm->flags))
> +	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
>  		return READ_ONCE(huge_zero_folio);
>  
>  	if (!get_huge_zero_folio())
>  		return NULL;
>  
> -	if (test_and_set_bit(MMF_HUGE_ZERO_FOLIO, &mm->flags))
> +	if (mm_flags_test_and_set(MMF_HUGE_ZERO_FOLIO, mm))
>  		put_huge_zero_folio();
>  
>  	return READ_ONCE(huge_zero_folio);
> @@ -268,7 +268,7 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
>  	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
>  		return;
>  
> -	if (test_bit(MMF_HUGE_ZERO_FOLIO, &mm->flags))
> +	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
>  		put_huge_zero_folio();
>  }
>  
> @@ -1145,7 +1145,7 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
>  
>  	off_sub = (off - ret) & (size - 1);
>  
> -	if (test_bit(MMF_TOPDOWN, &current->mm->flags) && !off_sub)
> +	if (mm_flags_test(MMF_TOPDOWN, current->mm) && !off_sub)
>  		return ret + size;
>  
>  	ret += off_sub;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6b40bdfd224c..6470e7e26c8d 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -410,7 +410,7 @@ static inline int hpage_collapse_test_exit(struct mm_struct *mm)
>  static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
>  {
>  	return hpage_collapse_test_exit(mm) ||
> -	       test_bit(MMF_DISABLE_THP, &mm->flags);
> +		mm_flags_test(MMF_DISABLE_THP, mm);
>  }
>  
>  static bool hugepage_pmd_enabled(void)
> @@ -445,7 +445,7 @@ void __khugepaged_enter(struct mm_struct *mm)
>  
>  	/* __khugepaged_exit() must not run from under us */
>  	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
> -	if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags)))
> +	if (unlikely(mm_flags_test_and_set(MMF_VM_HUGEPAGE, mm)))
>  		return;
>  
>  	mm_slot = mm_slot_alloc(mm_slot_cache);
> @@ -472,7 +472,7 @@ void __khugepaged_enter(struct mm_struct *mm)
>  void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  vm_flags_t vm_flags)
>  {
> -	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> +	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
>  	    hugepage_pmd_enabled()) {
>  		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
>  					    PMD_ORDER))
> @@ -497,7 +497,7 @@ void __khugepaged_exit(struct mm_struct *mm)
>  	spin_unlock(&khugepaged_mm_lock);
>  
>  	if (free) {
> -		clear_bit(MMF_VM_HUGEPAGE, &mm->flags);
> +		mm_flags_clear(MMF_VM_HUGEPAGE, mm);
>  		mm_slot_free(mm_slot_cache, mm_slot);
>  		mmdrop(mm);
>  	} else if (mm_slot) {
> @@ -1459,7 +1459,7 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
>  		/*
>  		 * Not strictly needed because the mm exited already.
>  		 *
> -		 * clear_bit(MMF_VM_HUGEPAGE, &mm->flags);
> +		 * mm_clear(mm, MMF_VM_HUGEPAGE);
>  		 */
>  
>  		/* khugepaged_mm_lock actually not necessary for the below */
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 160787bb121c..2ef29802a49b 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1217,8 +1217,8 @@ static int unmerge_and_remove_all_rmap_items(void)
>  			spin_unlock(&ksm_mmlist_lock);
>  
>  			mm_slot_free(mm_slot_cache, mm_slot);
> -			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
> -			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
> +			mm_flags_clear(MMF_VM_MERGEABLE, mm);
> +			mm_flags_clear(MMF_VM_MERGE_ANY, mm);
>  			mmdrop(mm);
>  		} else
>  			spin_unlock(&ksm_mmlist_lock);
> @@ -2620,8 +2620,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>  		spin_unlock(&ksm_mmlist_lock);
>  
>  		mm_slot_free(mm_slot_cache, mm_slot);
> -		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
> -		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
> +		mm_flags_clear(MMF_VM_MERGEABLE, mm);
> +		mm_flags_clear(MMF_VM_MERGE_ANY, mm);
>  		mmap_read_unlock(mm);
>  		mmdrop(mm);
>  	} else {
> @@ -2742,7 +2742,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
>  vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
>  			 vm_flags_t vm_flags)
>  {
> -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags) &&
> +	if (mm_flags_test(MMF_VM_MERGE_ANY, mm) &&
>  	    __ksm_should_add_vma(file, vm_flags))
>  		vm_flags |= VM_MERGEABLE;
>  
> @@ -2784,16 +2784,16 @@ int ksm_enable_merge_any(struct mm_struct *mm)
>  {
>  	int err;
>  
> -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> +	if (mm_flags_test(MMF_VM_MERGE_ANY, mm))
>  		return 0;
>  
> -	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
> +	if (!mm_flags_test(MMF_VM_MERGEABLE, mm)) {
>  		err = __ksm_enter(mm);
>  		if (err)
>  			return err;
>  	}
>  
> -	set_bit(MMF_VM_MERGE_ANY, &mm->flags);
> +	mm_flags_set(MMF_VM_MERGE_ANY, mm);
>  	ksm_add_vmas(mm);
>  
>  	return 0;
> @@ -2815,7 +2815,7 @@ int ksm_disable_merge_any(struct mm_struct *mm)
>  {
>  	int err;
>  
> -	if (!test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> +	if (!mm_flags_test(MMF_VM_MERGE_ANY, mm))
>  		return 0;
>  
>  	err = ksm_del_vmas(mm);
> @@ -2824,7 +2824,7 @@ int ksm_disable_merge_any(struct mm_struct *mm)
>  		return err;
>  	}
>  
> -	clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
> +	mm_flags_clear(MMF_VM_MERGE_ANY, mm);
>  	return 0;
>  }
>  
> @@ -2832,9 +2832,9 @@ int ksm_disable(struct mm_struct *mm)
>  {
>  	mmap_assert_write_locked(mm);
>  
> -	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
> +	if (!mm_flags_test(MMF_VM_MERGEABLE, mm))
>  		return 0;
> -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> +	if (mm_flags_test(MMF_VM_MERGE_ANY, mm))
>  		return ksm_disable_merge_any(mm);
>  	return ksm_del_vmas(mm);
>  }
> @@ -2852,7 +2852,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>  		if (!vma_ksm_compatible(vma))
>  			return 0;
>  
> -		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
> +		if (!mm_flags_test(MMF_VM_MERGEABLE, mm)) {
>  			err = __ksm_enter(mm);
>  			if (err)
>  				return err;
> @@ -2912,7 +2912,7 @@ int __ksm_enter(struct mm_struct *mm)
>  		list_add_tail(&slot->mm_node, &ksm_scan.mm_slot->slot.mm_node);
>  	spin_unlock(&ksm_mmlist_lock);
>  
> -	set_bit(MMF_VM_MERGEABLE, &mm->flags);
> +	mm_flags_set(MMF_VM_MERGEABLE, mm);
>  	mmgrab(mm);
>  
>  	if (needs_wakeup)
> @@ -2954,8 +2954,8 @@ void __ksm_exit(struct mm_struct *mm)
>  
>  	if (easy_to_free) {
>  		mm_slot_free(mm_slot_cache, mm_slot);
> -		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
> -		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
> +		mm_flags_clear(MMF_VM_MERGE_ANY, mm);
> +		mm_flags_clear(MMF_VM_MERGEABLE, mm);
>  		mmdrop(mm);
>  	} else if (mm_slot) {
>  		mmap_write_lock(mm);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7306253cc3b5..7a057e0e8da9 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -802,7 +802,7 @@ unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm, struct file *fi
>  					   unsigned long pgoff, unsigned long flags,
>  					   vm_flags_t vm_flags)
>  {
> -	if (test_bit(MMF_TOPDOWN, &mm->flags))
> +	if (mm_flags_test(MMF_TOPDOWN, mm))
>  		return arch_get_unmapped_area_topdown(filp, addr, len, pgoff,
>  						      flags, vm_flags);
>  	return arch_get_unmapped_area(filp, addr, len, pgoff, flags, vm_flags);
> @@ -1284,7 +1284,7 @@ void exit_mmap(struct mm_struct *mm)
>  	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
>  	 * because the memory has been already freed.
>  	 */
> -	set_bit(MMF_OOM_SKIP, &mm->flags);
> +	mm_flags_set(MMF_OOM_SKIP, mm);
>  	mmap_write_lock(mm);
>  	mt_clear_in_rcu(&mm->mm_mt);
>  	vma_iter_set(&vmi, vma->vm_end);
> @@ -1859,14 +1859,14 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
>  			mas_store(&vmi.mas, XA_ZERO_ENTRY);
>  			/* Avoid OOM iterating a broken tree */
> -			set_bit(MMF_OOM_SKIP, &mm->flags);
> +			mm_flags_set(MMF_OOM_SKIP, mm);
>  		}
>  		/*
>  		 * The mm_struct is going to exit, but the locks will be dropped
>  		 * first.  Set the mm_struct as unstable is advisable as it is
>  		 * not fully initialised.
>  		 */
> -		set_bit(MMF_UNSTABLE, &mm->flags);
> +		mm_flags_set(MMF_UNSTABLE, mm);
>  	}
>  out:
>  	mmap_write_unlock(mm);
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..17650f0b516e 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   *  linux/mm/oom_kill.c
> - * 
> + *
>   *  Copyright (C)  1998,2000  Rik van Riel
>   *	Thanks go out to Claus Fischer for some serious inspiration and
>   *	for goading me into coding this file...
> @@ -218,7 +218,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
>  	 */
>  	adj = (long)p->signal->oom_score_adj;
>  	if (adj == OOM_SCORE_ADJ_MIN ||
> -			test_bit(MMF_OOM_SKIP, &p->mm->flags) ||
> +			mm_flags_test(MMF_OOM_SKIP, p->mm) ||
>  			in_vfork(p)) {
>  		task_unlock(p);
>  		return LONG_MIN;
> @@ -325,7 +325,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>  	 * any memory is quite low.
>  	 */
>  	if (!is_sysrq_oom(oc) && tsk_is_oom_victim(task)) {
> -		if (test_bit(MMF_OOM_SKIP, &task->signal->oom_mm->flags))
> +		if (mm_flags_test(MMF_OOM_SKIP, task->signal->oom_mm))
>  			goto next;
>  		goto abort;
>  	}
> @@ -524,7 +524,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  	 * should imply barriers already and the reader would hit a page fault
>  	 * if it stumbled over a reaped memory.
>  	 */
> -	set_bit(MMF_UNSTABLE, &mm->flags);
> +	mm_flags_set(MMF_UNSTABLE, mm);
>  
>  	for_each_vma(vmi, vma) {
>  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
> @@ -583,7 +583,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>  	 * under mmap_lock for reading because it serializes against the
>  	 * mmap_write_lock();mmap_write_unlock() cycle in exit_mmap().
>  	 */
> -	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
> +	if (mm_flags_test(MMF_OOM_SKIP, mm)) {
>  		trace_skip_task_reaping(tsk->pid);
>  		goto out_unlock;
>  	}
> @@ -619,7 +619,7 @@ static void oom_reap_task(struct task_struct *tsk)
>  		schedule_timeout_idle(HZ/10);
>  
>  	if (attempts <= MAX_OOM_REAP_RETRIES ||
> -	    test_bit(MMF_OOM_SKIP, &mm->flags))
> +	    mm_flags_test(MMF_OOM_SKIP, mm))
>  		goto done;
>  
>  	pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
> @@ -634,7 +634,7 @@ static void oom_reap_task(struct task_struct *tsk)
>  	 * Hide this mm from OOM killer because it has been either reaped or
>  	 * somebody can't call mmap_write_unlock(mm).
>  	 */
> -	set_bit(MMF_OOM_SKIP, &mm->flags);
> +	mm_flags_set(MMF_OOM_SKIP, mm);
>  
>  	/* Drop a reference taken by queue_oom_reaper */
>  	put_task_struct(tsk);
> @@ -670,7 +670,7 @@ static void wake_oom_reaper(struct timer_list *timer)
>  	unsigned long flags;
>  
>  	/* The victim managed to terminate on its own - see exit_mmap */
> -	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
> +	if (mm_flags_test(MMF_OOM_SKIP, mm)) {
>  		put_task_struct(tsk);
>  		return;
>  	}
> @@ -695,7 +695,7 @@ static void wake_oom_reaper(struct timer_list *timer)
>  static void queue_oom_reaper(struct task_struct *tsk)
>  {
>  	/* mm is already queued? */
> -	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
> +	if (mm_flags_test_and_set(MMF_OOM_REAP_QUEUED, tsk->signal->oom_mm))
>  		return;
>  
>  	get_task_struct(tsk);
> @@ -892,7 +892,7 @@ static bool task_will_free_mem(struct task_struct *task)
>  	 * This task has already been drained by the oom reaper so there are
>  	 * only small chances it will free some more
>  	 */
> -	if (test_bit(MMF_OOM_SKIP, &mm->flags))
> +	if (mm_flags_test(MMF_OOM_SKIP, mm))
>  		return false;
>  
>  	if (atomic_read(&mm->mm_users) <= 1)
> @@ -977,7 +977,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  			continue;
>  		if (is_global_init(p)) {
>  			can_oom_reap = false;
> -			set_bit(MMF_OOM_SKIP, &mm->flags);
> +			mm_flags_set(MMF_OOM_SKIP, mm);
>  			pr_info("oom killer %d (%s) has mm pinned by %d (%s)\n",
>  					task_pid_nr(victim), victim->comm,
>  					task_pid_nr(p), p->comm);
> @@ -1235,7 +1235,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  		reap = true;
>  	else {
>  		/* Error only if the work has not been done already */
> -		if (!test_bit(MMF_OOM_SKIP, &mm->flags))
> +		if (!mm_flags_test(MMF_OOM_SKIP, mm))
>  			ret = -EINVAL;
>  	}
>  	task_unlock(p);
> @@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
>  	 * possible change in exit_mmap is seen
>  	 */
> -	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
> +	if (mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm))
>  		ret = -EAGAIN;
>  	mmap_read_unlock(mm);
>  
> diff --git a/mm/util.c b/mm/util.c
> index f814e6a59ab1..d235b74f7aff 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -471,17 +471,17 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>  
>  	if (mmap_is_legacy(rlim_stack)) {
>  		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> -		clear_bit(MMF_TOPDOWN, &mm->flags);
> +		mm_flags_clear(MMF_TOPDOWN, mm);
>  	} else {
>  		mm->mmap_base = mmap_base(random_factor, rlim_stack);
> -		set_bit(MMF_TOPDOWN, &mm->flags);
> +		mm_flags_set(MMF_TOPDOWN, mm);
>  	}
>  }
>  #elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
>  void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>  {
>  	mm->mmap_base = TASK_UNMAPPED_BASE;
> -	clear_bit(MMF_TOPDOWN, &mm->flags);
> +	mm_flags_clear(MMF_TOPDOWN, mm);
>  }
>  #endif
>  #ifdef CONFIG_MMU
> -- 
> 2.50.1
> 

-- 
Sincerely yours,
Mike.

