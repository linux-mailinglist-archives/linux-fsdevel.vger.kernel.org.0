Return-Path: <linux-fsdevel+bounces-57858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EF0B25F5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5675188C3F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 08:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578152F1FE2;
	Thu, 14 Aug 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9V8L5Lv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EE62E92BE;
	Thu, 14 Aug 2025 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160957; cv=none; b=PMJB5akE0QyqLxfLWhs74KbRJYt/5WgIYxNORvSwefAQF9JhKwmrI+S1RuDXm+Hn29pEigp+MD71ky8jBydAzNAPIRhZwrzBiITFhb4nYzLH5PdA+WWI09nvgg1jmhI3LdcPT/24aNa8jDWqo+alPxNcb7Zo5yt5zAkYDcN2SAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160957; c=relaxed/simple;
	bh=SUBXHVjiIpc5FK6CF6DFvCj6KZQzp4Joo5u+EpVZoMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgQDKa79IPla6gFj71L2pduheNcuU3NPVz0GDx93mI6EYo7TwAf5E60P0jKuQNnk7syjgkYfKi/DsbNlCvXd8VO2k1ME4I5cWw2uyhYmhzuMyVdtNhGhTF4p8MYpY1jycJqZ/z1cdL/6Tbl7lIGWFTOeYiOoPK9hdC7uuMtqEP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9V8L5Lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210FEC4CEEF;
	Thu, 14 Aug 2025 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755160955;
	bh=SUBXHVjiIpc5FK6CF6DFvCj6KZQzp4Joo5u+EpVZoMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9V8L5LvpCRYDZdnvjdkWNnyF5ilnojdxYc4xR+1jf6USGswyy05H/dqneQYcqivI
	 gtp73vcs9LYpcfm1CcyfJiZoQwm/beqGU14bCsUmSe5pgghsvWXe6VbDZUcWw9XAo5
	 kY+367T2oc3xqTdlDUBzZlXFMP8exkL3rJ9lRlOAliHsBVllf3aHksUgE0xZHDFda2
	 +vQ+rGSh9gS4COKgE6dNKbUjbLkD95PYty5iSv5A4gWzKrMERDRP062Hw+ci/yY92H
	 0IzfPbHGuYVoXyIfOq89jBHH2U88/SHWfZwfukmOCq0i8qM9O5eCNW3peh3aZeoPBu
	 3W1AMRWMsh3Gw==
Date: Thu, 14 Aug 2025 11:42:10 +0300
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
Subject: Re: [PATCH 09/10] mm: convert remaining users to mm_flags_*()
 accessors
Message-ID: <aJ2hYlUGnAPxPFox@kernel.org>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <cc67a56f9a8746a8ec7d9791853dc892c1c33e0b.1755012943.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc67a56f9a8746a8ec7d9791853dc892c1c33e0b.1755012943.git.lorenzo.stoakes@oracle.com>

On Tue, Aug 12, 2025 at 04:44:18PM +0100, Lorenzo Stoakes wrote:
> As part of the effort to move to mm->flags becoming a bitmap field, convert
> existing users to making use of the mm_flags_*() accessors which will, when
> the conversion is complete, be the only means of accessing mm_struct flags.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  fs/proc/array.c    | 2 +-
>  fs/proc/base.c     | 4 ++--
>  fs/proc/task_mmu.c | 2 +-
>  kernel/fork.c      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index d6a0369caa93..c286dc12325e 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -422,7 +422,7 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
>  	bool thp_enabled = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE);
>  
>  	if (thp_enabled)
> -		thp_enabled = !test_bit(MMF_DISABLE_THP, &mm->flags);
> +		thp_enabled = !mm_flags_test(MMF_DISABLE_THP, mm);
>  	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
>  }
>  
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index f0c093c58aaf..b997ceef9135 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1163,7 +1163,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  		struct task_struct *p = find_lock_task_mm(task);
>  
>  		if (p) {
> -			if (test_bit(MMF_MULTIPROCESS, &p->mm->flags)) {
> +			if (mm_flags_test(MMF_MULTIPROCESS, p->mm)) {
>  				mm = p->mm;
>  				mmgrab(mm);
>  			}
> @@ -3276,7 +3276,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>  		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>  		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
>  		seq_printf(m, "ksm_merge_any: %s\n",
> -				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
> +				mm_flags_test(MMF_VM_MERGE_ANY, mm) ? "yes" : "no");
>  		ret = mmap_read_lock_killable(mm);
>  		if (ret) {
>  			mmput(mm);
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e64cf40ce9c4..e8e7bef34531 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1592,7 +1592,7 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
>  		return false;
>  	if (!is_cow_mapping(vma->vm_flags))
>  		return false;
> -	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
> +	if (likely(!mm_flags_test(MMF_HAS_PINNED, vma->vm_mm)))
>  		return false;
>  	folio = vm_normal_folio(vma, addr, pte);
>  	if (!folio)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b311caec6419..68c81539193d 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1887,7 +1887,7 @@ static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
>  
>  	/* We need to synchronize with __set_oom_adj */
>  	mutex_lock(&oom_adj_mutex);
> -	set_bit(MMF_MULTIPROCESS, &tsk->mm->flags);
> +	mm_flags_set(MMF_MULTIPROCESS, tsk->mm);
>  	/* Update the values in case they were changed after copy_signal */
>  	tsk->signal->oom_score_adj = current->signal->oom_score_adj;
>  	tsk->signal->oom_score_adj_min = current->signal->oom_score_adj_min;
> -- 
> 2.50.1
> 

-- 
Sincerely yours,
Mike.

