Return-Path: <linux-fsdevel+bounces-61789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE28B59DCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695C91C01BC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB59031E8BE;
	Tue, 16 Sep 2025 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tpu8V5eQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4BB31E8AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040415; cv=none; b=ILQJe3+tdiBk52ySXjO/xKfddPP/IyXdu9kYy/HOYvCqqYrS4G02K+Uv5PV9VQi3OsIOFM2qrvX6ws3JiC8bxaM4j7Rs4VT+LrZI1UvVJKSjkTzFTVf5BCUlE4dnN3UzQJlRdxQE2rEA4zcVu3wCaN0X/UU/cmE9S9xZWgh2w7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040415; c=relaxed/simple;
	bh=zwd0XkVppVr/TcQAYbsbt5OW+YqyyFLcAGA7mdHs7UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXluBy0gPpIQipCA6IvM73JqC0qEscBoVZWbNkvQ1CQpme5m9XD5Yza3nJNy4z9CwP4bssCwezEZiBb5au7hrVzog2yZoqWKGPl3tFfcfFPCzImtvxj4PUm1A1WNY4R6sxtfj28QeviwarpJxAXVZOVahMpX4cPBTts8UFf8lxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tpu8V5eQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2637b6e9149so236275ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 09:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758040413; x=1758645213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpJRPqyE+DLgCkViSYT6h8uO5sNq+STFGuKFYPZGf4U=;
        b=Tpu8V5eQXm+mbatqQe5qOXbMav65wnjRSKbmGSAJMopG6edbEELRM3X8gidNDZ6PKd
         GA18wwBS2L5n4IatC70xePCDiyxagY0HDfnkdbAnBUfYUeroMdmsXxB0nU8VaDUwwVcL
         2xgYMhv5fJIkRqV/IdVJ+sYvvszTstETE+bUAnZEgMerpXPYg6XiY/0sF3jhQwTjlOqI
         yFYs+cl9lnV/fyshFX9we6ZryoTWkXm15peLvaoC5wd6TERXlEf/PLIYs/1xjFHjJVu2
         KgkxztwU7dXDawNaX+Z7b/MJndgB90fQwfh79+Lf1JRnqzG2X2KWU4H6K1dYTp29Btjl
         q6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758040413; x=1758645213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpJRPqyE+DLgCkViSYT6h8uO5sNq+STFGuKFYPZGf4U=;
        b=ABNfij/oG1ISNzrCVXisbjBk2DfHo42f0WZSjQTyl2Gnt89e91uQo8/CHsU4g18Dcf
         08NBsHagBZ6LN3eJp818coqrLIGH14SqFZ8C4u/gEj+vxY/YJFjp9dnsQQrbq6SpYXg+
         VaxYsgqoHj90mGBgYi2z+M+t1VMrRaDwEJGuRB0kAHXMb7Uxd9Fv/uYctePSBursGT3A
         nYXVTIxX3oAi8o8xE/pgJZG0yxEcWw5NaznRNLfCmTCWaXhQ9FGxAogMqqDnU5TvLgR+
         S3vjVP6OxuXOk4gwvKpDS6p/K/MdK7NcyWFe93Lto4oobu4wHDjRtUZVw9fNdR2JlI2V
         2cPA==
X-Forwarded-Encrypted: i=1; AJvYcCXSYKEonhqwfeKriNylkgglsee+Z6uK2vGA2fRrxlAEXlR8cUsXJvZqIgVLXorDoVSbU/9Pm8ft5xzhGrvG@vger.kernel.org
X-Gm-Message-State: AOJu0YxCFCRTsld7h4Qqmid82jbPJW0FkObrkcwzjCc1drLTeSXp98uD
	OowcgEKxTPSE3tOmJHkYyBIw7Lje2/0Ryl4Ak8yitQK6Ws1u/4bh8eBE3yGmmLhvyAGj5Jilf/a
	NBZqk2iHmELIsfq9vczss7yG1zq+PZCfkREAS+7Nu
X-Gm-Gg: ASbGncttni/NobHh+6y0F2N9FnWRBqUhVxa5XiFuiXaQ1e5ENVqc1OL/Y89Ootgu5Oj
	4ZhYTGDxN9Urk81CwJ7vjfiuFLYOg7TfNJmDHWtQHx87GlhcEa2h8W/kjtHlwGSQrM2OBn6Cq9F
	fpeljSdBC4pwGGedRz9BEJdyd5u3WU3AUe5hUOJSTQo864+Eum3DXlRZrUzfF88fO8yZu/7WmLG
	aeH+XkyxlTtcVctZUbIc4d61UvXNOq8MbvORCjH4jIiH/JDARE97UIo1wkoSfkMqrS4lrJzY/pG
	gCheYEixgXE=
X-Google-Smtp-Source: AGHT+IEmopqHrLlKAg9oy907o3DJI6+vH3JcnFDx1aG/LSz9zqj3HF4XGnr65ldjfgJRaRNtO5J5uw5CFf4k7w6uZSw=
X-Received: by 2002:a17:902:c94c:b0:267:e853:69e6 with SMTP id
 d9443c01a7336-267e8536dcbmr2381375ad.10.1758040412493; Tue, 16 Sep 2025
 09:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916072226.220426-1-liulei.rjpt@vivo.com>
In-Reply-To: <20250916072226.220426-1-liulei.rjpt@vivo.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Tue, 16 Sep 2025 11:33:15 -0500
X-Gm-Features: AS18NWDSakZyj0YpuhHGRbZt0lSAiKvJ-Ui1fUjnfRR1XkwTcSWp7BRZ--IPK2c
Message-ID: <CAJj2-QHy3rTSPpE5uyu4gW9dWe1E5Q28P_N-VX2Uo+xBFauxdw@mail.gmail.com>
Subject: Re: [RFC PATCH v0] mm/vmscan: Add readahead LRU to improve readahead
 file page reclamation efficiency
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Wei Xu <weixugc@google.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Nico Pache <npache@redhat.com>, Harry Yoo <harry.yoo@oracle.com>, Yu Zhao <yuzhao@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Usama Arif <usamaarif642@gmail.com>, 
	Chen Yu <yu.c.chen@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Nhat Pham <nphamcs@gmail.com>, Hao Jia <jiahao1@lixiang.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>, Barry Song <baohua@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>, 
	Jaewon Kim <jaewon31.kim@samsung.com>, 
	"open list:PROC FILESYSTEM" <linux-kernel@vger.kernel.org>, 
	"open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>, 
	"open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)" <linux-mm@kvack.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:22=E2=80=AFAM Lei Liu <liulei.rjpt@vivo.com> wrot=
e:
> ...
>
> 2. Solution Proposal
> Introduce a Readahead LRU to track pages brought in via readahead. During
> memory reclamation, prioritize scanning this LRU to reclaim pages that
> have not been accessed recently. For pages in the Readahead LRU that are
> accessed, move them back to the inactive_file LRU to await subsequent
> reclamation.
I'm unsure this is the right solution though, given all users would
have this readahead LRU on and we don't have performance numbers
besides application startup here.
My impression is that readahead behavior is highly dependent on the
hardware, the workload, and the desired behavior, so making the
readahead{-adjacent} behavior more amenable to tuning seems like the
right direction.

Maybe relevant discussions: https://lwn.net/Articles/897786/

I only skimmed the code but noticed a few things:

> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index a458f1e112fd..4f3f031134fd 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -71,6 +71,7 @@ static int meminfo_proc_show(struct seq_file *m, void *=
v)
>         show_val_kb(m, "Inactive(anon): ", pages[LRU_INACTIVE_ANON]);
>         show_val_kb(m, "Active(file):   ", pages[LRU_ACTIVE_FILE]);
>         show_val_kb(m, "Inactive(file): ", pages[LRU_INACTIVE_FILE]);
> +       show_val_kb(m, "ReadAhead(file):",
I notice both readahead and read ahead in this patch. Stick to the
conventional one (readahead).

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 8d3fa3a91ce4..57dac828aa4f 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -127,6 +127,7 @@ enum pageflags {
>  #ifdef CONFIG_ARCH_USES_PG_ARCH_3
>         PG_arch_3,
>  #endif
> +       PG_readahead_lru,
More pageflags...

b/include/trace/events/mmflags.h
> index aa441f593e9a..2dbc1701e838 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -159,7 +159,8 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
>         DEF_PAGEFLAG_NAME(reclaim),                                     \
>         DEF_PAGEFLAG_NAME(swapbacked),                                  \
>         DEF_PAGEFLAG_NAME(unevictable),                                 \
> -       DEF_PAGEFLAG_NAME(dropbehind)                                   \
> +       DEF_PAGEFLAG_NAME(dropbehind),                                  \
> +       DEF_PAGEFLAG_NAME(readahead_lru)                                \
>  IF_HAVE_PG_MLOCK(mlocked)                                              \
>  IF_HAVE_PG_HWPOISON(hwpoison)                                          \
>  IF_HAVE_PG_IDLE(idle)                                                  \
> @@ -309,6 +310,7 @@ IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,  "droppable"     )=
               \
>                 EM (LRU_ACTIVE_ANON, "active_anon") \
>                 EM (LRU_INACTIVE_FILE, "inactive_file") \
>                 EM (LRU_ACTIVE_FILE, "active_file") \
> +               EM(LRU_READ_AHEAD_FILE, "readahead_file") \
Likewise, inconsistent naming.

> diff --git a/mm/migrate.c b/mm/migrate.c
> index 9e5ef39ce73a..0feab4d89d47 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -760,6 +760,8 @@ void folio_migrate_flags(struct folio *newfolio, stru=
ct folio *folio)
>                 folio_set_workingset(newfolio);
>         if (folio_test_checked(folio))
>                 folio_set_checked(newfolio);
> +       if (folio_test_readahead_lru(folio))
> +               folio_set_readahead_lru(folio);
newfolio

>  /*
> @@ -5800,6 +5837,87 @@ static void lru_gen_shrink_node(struct pglist_data=
 *pgdat, struct scan_control *
>
>  #endif /* CONFIG_LRU_GEN */
>
> +static unsigned long shrink_read_ahead_list(unsigned long nr_to_scan,
> +                                           unsigned long nr_to_reclaim,
> +                                           struct lruvec *lruvec,
> +                                           struct scan_control *sc)
> +{
> +       LIST_HEAD(l_hold);
> +       LIST_HEAD(l_reclaim);
> +       LIST_HEAD(l_inactive);
> +       unsigned long nr_scanned =3D 0;
> +       unsigned long nr_taken =3D 0;
> +       unsigned long nr_reclaimed =3D 0;
> +       unsigned long vm_flags;
> +       enum vm_event_item item;
> +       struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
> +       struct reclaim_stat stat =3D { 0 };
> +
> +       lru_add_drain();
> +
> +       spin_lock_irq(&lruvec->lru_lock);
> +       nr_taken =3D isolate_lru_folios(nr_to_scan, lruvec, &l_hold, &nr_=
scanned,
> +                                     sc, LRU_READ_AHEAD_FILE);
> +
> +       __count_vm_events(PGSCAN_READAHEAD_FILE, nr_scanned);
> +       __mod_node_page_state(pgdat, NR_ISOLATED_FILE, nr_taken);
> +       item =3D PGSCAN_KSWAPD + reclaimer_offset(sc);
> +       if (!cgroup_reclaim(sc))
> +               __count_vm_events(item, nr_scanned);
> +       count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
> +       __count_vm_events(PGSCAN_FILE, nr_scanned);
> +       spin_unlock_irq(&lruvec->lru_lock);
> +
> +       if (nr_taken =3D=3D 0)
> +               return 0;
> +
> +       while (!list_empty(&l_hold)) {
> +               struct folio *folio;
> +
> +               cond_resched();
> +               folio =3D lru_to_folio(&l_hold);
> +               list_del(&folio->lru);
> +               folio_clear_readahead_lru(folio);
> +
> +               if (folio_referenced(folio, 0, sc->target_mem_cgroup, &vm=
_flags)) {
> +                       list_add(&folio->lru, &l_inactive);
> +                       continue;
> +               }
> +               folio_clear_active(folio);
> +               list_add(&folio->lru, &l_reclaim);
> +       }
> +
> +       nr_reclaimed =3D shrink_folio_list(&l_reclaim, pgdat, sc, &stat, =
true,
> +                                        lruvec_memcg(lruvec));
> +
> +       list_splice(&l_reclaim, &l_inactive);
> +
> +       spin_lock_irq(&lruvec->lru_lock);
> +       move_folios_to_lru(lruvec, &l_inactive);
> +       __mod_node_page_state(pgdat, NR_ISOLATED_FILE, -nr_taken);
> +
> +       __count_vm_events(PGSTEAL_READAHEAD_FILE, nr_reclaimed);
> +       item =3D PGSTEAL_KSWAPD + reclaimer_offset(sc);
> +       if (!cgroup_reclaim(sc))
> +               __count_vm_events(item, nr_reclaimed);
> +       count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
> +       __count_vm_events(PGSTEAL_FILE, nr_reclaimed);
> +       spin_unlock_irq(&lruvec->lru_lock);
I see the idea is that readahead pages should be scanned before the
rest of inactive file. I wonder if this is achievable without adding
another LRU.


Thanks,
Yuanchu

