Return-Path: <linux-fsdevel+bounces-57853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC56FB25EEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED24B5A2351
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 08:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AE52E7BB5;
	Thu, 14 Aug 2025 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYJMiC+A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F2264A76;
	Thu, 14 Aug 2025 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160461; cv=none; b=HwDx64GKDkJ+xcfTp75vcZYl0eAYpS2ItdrcRZLvZz7Bc2+d6U+8enLFrn5qWZUcr6bJC2Dpp53moI8BlJo0GkHg8RbTPYlNHTd0ZcqmRecMOZkraOOxqoIUw0xNtQUr/GTZzGoWLb6zyCDEJxSsXybTlzcEvVyZyUhNunIuqMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160461; c=relaxed/simple;
	bh=JJZTzu+RAz4/lXyoF8hhed0E/+6KW4y3Lc2HDHprM3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8arL3X/cSiR7Z+dtZ4F/9RJ6eycj0WrVvc/4L2Uj9xGKVwFnJDKgurLFlWEJ+NWJ+iTmKZ5MrlaJSmq1N55S0MAbc+Q7WXrWXy83GGudtLjS4CX22lOZfj5TaXvIiU2VbYlcLUxnr6Vse/gx7+sFYngi7hyqE3/VZ+ZQAWcifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYJMiC+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83461C4CEEF;
	Thu, 14 Aug 2025 08:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755160460;
	bh=JJZTzu+RAz4/lXyoF8hhed0E/+6KW4y3Lc2HDHprM3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sYJMiC+A6ZsYL/xcMfF5gXE5Tqd2ONGCHOWgXGdfoS679A/WsvWY4v/yNnAdOGJ+l
	 jTR2ZQjW5ocrjLWjjrbnOIQaPGP72w5wLeWhPEeNMh/kwb4iF3HCdoGM4lS27vlnlE
	 C06vKS2l/dvw+L7KYiTEAmNBniJOG5U2Dg3Z8Oqi41JdMD+dOS2ox8Yt3JVFMK4Ko8
	 yPGdi7p5vKJqhIUOiCUOT01Fp1IeSJzEyef+iKY1gvCG+p8H824C5wj+OzG16e87LX
	 PfIthLVHmXIqBCLYKsRoqDM9o16zhFcmVnIDLFE4O9kfBbO8ZR3C0vmiLs8ODwrqV+
	 DOhyHiLRa8bQA==
Date: Thu, 14 Aug 2025 11:33:59 +0300
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
Subject: Re: [PATCH 05/10] mm: convert uprobes to mm_flags_*() accessors
Message-ID: <aJ2fd3iD6GqZ_LWw@kernel.org>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <1d4fe5963904cc0c707da1f53fbfe6471d3eff10.1755012943.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d4fe5963904cc0c707da1f53fbfe6471d3eff10.1755012943.git.lorenzo.stoakes@oracle.com>

On Tue, Aug 12, 2025 at 04:44:14PM +0100, Lorenzo Stoakes wrote:
> As part of the effort to move to mm->flags becoming a bitmap field, convert
> existing users to making use of the mm_flags_*() accessors which will, when
> the conversion is complete, be the only means of accessing mm_struct flags.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/events/uprobes.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 7ca1940607bd..31a12b60055f 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1153,15 +1153,15 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
>  	 * set MMF_HAS_UPROBES in advance for uprobe_pre_sstep_notifier(),
>  	 * the task can hit this breakpoint right after __replace_page().
>  	 */
> -	first_uprobe = !test_bit(MMF_HAS_UPROBES, &mm->flags);
> +	first_uprobe = !mm_flags_test(MMF_HAS_UPROBES, mm);
>  	if (first_uprobe)
> -		set_bit(MMF_HAS_UPROBES, &mm->flags);
> +		mm_flags_set(MMF_HAS_UPROBES, mm);
>  
>  	ret = set_swbp(&uprobe->arch, vma, vaddr);
>  	if (!ret)
> -		clear_bit(MMF_RECALC_UPROBES, &mm->flags);
> +		mm_flags_clear(MMF_RECALC_UPROBES, mm);
>  	else if (first_uprobe)
> -		clear_bit(MMF_HAS_UPROBES, &mm->flags);
> +		mm_flags_clear(MMF_HAS_UPROBES, mm);
>  
>  	return ret;
>  }
> @@ -1171,7 +1171,7 @@ static int remove_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  
> -	set_bit(MMF_RECALC_UPROBES, &mm->flags);
> +	mm_flags_set(MMF_RECALC_UPROBES, mm);
>  	return set_orig_insn(&uprobe->arch, vma, vaddr);
>  }
>  
> @@ -1303,7 +1303,7 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>  			/* consult only the "caller", new consumer. */
>  			if (consumer_filter(new, mm))
>  				err = install_breakpoint(uprobe, vma, info->vaddr);
> -		} else if (test_bit(MMF_HAS_UPROBES, &mm->flags)) {
> +		} else if (mm_flags_test(MMF_HAS_UPROBES, mm)) {
>  			if (!filter_chain(uprobe, mm))
>  				err |= remove_breakpoint(uprobe, vma, info->vaddr);
>  		}
> @@ -1595,7 +1595,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
>  
>  	if (vma->vm_file &&
>  	    (vma->vm_flags & (VM_WRITE|VM_SHARED)) == VM_WRITE &&
> -	    test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags))
> +	    mm_flags_test(MMF_HAS_UPROBES, vma->vm_mm))
>  		delayed_ref_ctr_inc(vma);
>  
>  	if (!valid_vma(vma, true))
> @@ -1655,12 +1655,12 @@ void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned lon
>  	if (!atomic_read(&vma->vm_mm->mm_users)) /* called by mmput() ? */
>  		return;
>  
> -	if (!test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags) ||
> -	     test_bit(MMF_RECALC_UPROBES, &vma->vm_mm->flags))
> +	if (!mm_flags_test(MMF_HAS_UPROBES, vma->vm_mm) ||
> +	     mm_flags_test(MMF_RECALC_UPROBES, vma->vm_mm))
>  		return;
>  
>  	if (vma_has_uprobes(vma, start, end))
> -		set_bit(MMF_RECALC_UPROBES, &vma->vm_mm->flags);
> +		mm_flags_set(MMF_RECALC_UPROBES, vma->vm_mm);
>  }
>  
>  static vm_fault_t xol_fault(const struct vm_special_mapping *sm,
> @@ -1823,10 +1823,10 @@ void uprobe_end_dup_mmap(void)
>  
>  void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
>  {
> -	if (test_bit(MMF_HAS_UPROBES, &oldmm->flags)) {
> -		set_bit(MMF_HAS_UPROBES, &newmm->flags);
> +	if (mm_flags_test(MMF_HAS_UPROBES, oldmm)) {
> +		mm_flags_set(MMF_HAS_UPROBES, newmm);
>  		/* unconditionally, dup_mmap() skips VM_DONTCOPY vmas */
> -		set_bit(MMF_RECALC_UPROBES, &newmm->flags);
> +		mm_flags_set(MMF_RECALC_UPROBES, newmm);
>  	}
>  }
>  
> @@ -2370,7 +2370,7 @@ static void mmf_recalc_uprobes(struct mm_struct *mm)
>  			return;
>  	}
>  
> -	clear_bit(MMF_HAS_UPROBES, &mm->flags);
> +	mm_flags_clear(MMF_HAS_UPROBES, mm);
>  }
>  
>  static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
> @@ -2468,7 +2468,7 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
>  		*is_swbp = -EFAULT;
>  	}
>  
> -	if (!uprobe && test_and_clear_bit(MMF_RECALC_UPROBES, &mm->flags))
> +	if (!uprobe && mm_flags_test_and_clear(MMF_RECALC_UPROBES, mm))
>  		mmf_recalc_uprobes(mm);
>  	mmap_read_unlock(mm);
>  
> @@ -2818,7 +2818,7 @@ int uprobe_pre_sstep_notifier(struct pt_regs *regs)
>  	if (!current->mm)
>  		return 0;
>  
> -	if (!test_bit(MMF_HAS_UPROBES, &current->mm->flags) &&
> +	if (!mm_flags_test(MMF_HAS_UPROBES, current->mm) &&
>  	    (!current->utask || !current->utask->return_instances))
>  		return 0;
>  
> -- 
> 2.50.1
> 

-- 
Sincerely yours,
Mike.

