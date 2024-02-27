Return-Path: <linux-fsdevel+bounces-12974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79548869BB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E708B1F279E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5CA14830C;
	Tue, 27 Feb 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0MeJ45Tx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AFF1474AD
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050259; cv=none; b=f17iL6GT98/UrLjhilyrhq5cufj3s9YKk57aQqjdFXre4DtJm3thb6VkRIXSRprnu2G+qaDfz/iGRTNHHUL6EPozH89LyjZHZTCpylvdcmfFUY+HTFFBpiYd7o5j7PF4WTzsrg2hVLWzLELKXoQDN/xqvqM39l848NGa5NatbuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050259; c=relaxed/simple;
	bh=nDxGfqMt13C5jtHaHc4vC6L/CJ5CyAlKFCiqHu/Q5AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHbgjL9eZXPNOtdL6vVYuMj46XcE6tsZIjtsoo+1x0xn+OxGmCoWXkKfF5EzunBo3Bne7nMGqDyf/z5tgIUJWyyEYLeqkKYl4m3DGUp8mwWRfVbJ//gj+a+y3rDkwFg3EGNydPn8EPWXLUIYHHAEQSlBYkhtot+81Gauvij8IMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0MeJ45Tx; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so4094097276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709050256; x=1709655056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3997VUdAcSrw6hJXGBCDEHFxh3lqzFAtRC+eH0EMEcI=;
        b=0MeJ45TxvkJ0MVWsxEjyDkxWLXiNjVF26WeLwFNYNBOtgGxIyhcsLzKS5TnhhLEcwU
         JiYijcgJmv82zeOo368b8sXVs4teBembBml1GYON/0lHis18lzZl9dcUQ8frrRQLvgPA
         opbdtJxDUXDakZ8nbyT63op1sUOTPpmzjXJk9u+W70IKUJdsCednB9x4nZPklt5yV16N
         PmFU75Lks+InLPBNLRG+u2lSzn3rqWq1EpcldoETVmpVTP77iMVONauUt6eH4wAUG4LI
         pUJRmFY9N+5QY0tcA/q7rdOK4EgYSXmVoMjkpSjcetAIdORSwoOw5EChfdvZJ28Qtkqz
         dbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709050256; x=1709655056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3997VUdAcSrw6hJXGBCDEHFxh3lqzFAtRC+eH0EMEcI=;
        b=Qw5tusGM6aNlRehOkE4/qzRm3LbgbOImGl5AM2gyLqWT3omloAEc6qe3HlcHA4BQdq
         cOgmCz5+i2VEnKUSJnTkGYGRrN+1xY6av61AzhkWtlu21awVop2jvXFE+qKDlSOG8m6G
         E3PwHyyN1vV5H9JVHmSUtBs6qV+7UTU+RLWDUoZ/kc0GTqMfAzQBAA5hErqSnSzfV1+K
         GI0bGRsuizlcUtYSbDwehYju7WHSpO4U/NgtJL7V3rGHRF4nrFMzPsNhWFvHbOpQugji
         joO91P3i1WBObylHXkUKFx/nR5MhJH6LSOpYrHLv+jJwA2j9mOgiz+1EQrbBmlBim0Hy
         KT6g==
X-Forwarded-Encrypted: i=1; AJvYcCWia2vaBgq45hocPYieEPrbIo2fKIgfxljfEo7lPFE52RltWJpsNIDbRLehdoXrQ8ABT8FNyJe9JNO5ysi6FDHE8qM+pSqucG2Z8pkHYA==
X-Gm-Message-State: AOJu0YzKhCgmsoIuo5xdf9azzFt1ZfPjye+Yob4Fge48oRl4gDJUx2AM
	i6e2Mij7fvYHw+uftZ5XMBfJzQttGkBadwFF0IZO7ooZZn6QLNL/SEjFZhGz8VitE/R7FNhYsKE
	uyz86VMh5X/kVjF/n7uiy4gXuO6JKKrbid1L+
X-Google-Smtp-Source: AGHT+IEHPBI8sanvwTrodqkBZscFpfJ5hxIGD0OGV0J9ftpRl85Uhg0i/fQvfgLElKHDPIfjBMGZnSSbq41lp7tF8gc=
X-Received: by 2002:a25:874c:0:b0:dcb:d8d1:2d52 with SMTP id
 e12-20020a25874c000000b00dcbd8d12d52mr2322309ybn.31.1709050255947; Tue, 27
 Feb 2024 08:10:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <67453a56-d4c2-4dc8-a5db-0a4665e40856@suse.cz>
In-Reply-To: <67453a56-d4c2-4dc8-a5db-0a4665e40856@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Feb 2024 08:10:43 -0800
Message-ID: <CAJuCfpHLEzCzATZ2ZP74--9mfYh-g-2csZ9A9oyaWWEQGNuGpg@mail.gmail.com>
Subject: Re: [PATCH v4 00/36] Memory allocation profiling
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > Overview:
> > Low overhead [1] per-callsite memory allocation profiling. Not just for
> > debug kernels, overhead low enough to be deployed in production.
> >
> > Example output:
> >   root@moria-kvm:~# sort -rn /proc/allocinfo
> >    127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
> >     56373248     4737 mm/slub.c:2259 func:alloc_slab_page
> >     14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded
> >     14417920     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
> >     13377536      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
> >     11718656     2861 mm/filemap.c:1919 func:__filemap_get_folio
> >      9192960     2800 kernel/fork.c:307 func:alloc_thread_stack_node
> >      4206592        4 net/netfilter/nf_conntrack_core.c:2567 func:nf_ct=
_alloc_hashtable
> >      4136960     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod] fu=
nc:ctagmod_start
> >      3940352      962 mm/memory.c:4214 func:alloc_anon_folio
> >      2894464    22613 fs/kernfs/dir.c:615 func:__kernfs_new_node
> >      ...
> >
> > Since v3:
> >  - Dropped patch changing string_get_size() [2] as not needed
> >  - Dropped patch modifying xfs allocators [3] as non needed,
> >    per Dave Chinner
> >  - Added Reviewed-by, per Kees Cook
> >  - Moved prepare_slab_obj_exts_hook() and alloc_slab_obj_exts() where t=
hey
> >    are used, per Vlastimil Babka
> >  - Fixed SLAB_NO_OBJ_EXT definition to use unused bit, per Vlastimil Ba=
bka
> >  - Refactored patch [4] into other patches, per Vlastimil Babka
> >  - Replaced snprintf() with seq_buf_printf(), per Kees Cook
> >  - Changed output to report bytes, per Andrew Morton and Pasha Tatashin
> >  - Changed output to report [module] only for loadable modules,
> >    per Vlastimil Babka
> >  - Moved mem_alloc_profiling_enabled() check earlier, per Vlastimil Bab=
ka
> >  - Changed the code to handle page splitting to be more understandable,
> >    per Vlastimil Babka
> >  - Moved alloc_tagging_slab_free_hook(), mark_objexts_empty(),
> >    mark_failed_objexts_alloc() and handle_failed_objexts_alloc(),
> >    per Vlastimil Babka
> >  - Fixed loss of __alloc_size(1, 2) in kvmalloc functions,
> >    per Vlastimil Babka
> >  - Refactored the code in show_mem() to avoid memory allocations,
> >    per Michal Hocko
> >  - Changed to trylock in show_mem() to avoid blocking in atomic context=
,
> >    per Tetsuo Handa
> >  - Added mm mailing list into MAINTAINERS, per Kees Cook
> >  - Added base commit SHA, per Andy Shevchenko
> >  - Added a patch with documentation, per Jani Nikula
> >  - Fixed 0day bugs
> >  - Added benchmark results [5], per Steven Rostedt
> >  - Rebased over Linux 6.8-rc5
> >
> > Items not yet addressed:
> >  - An early_boot option to prevent pageext overhead. We are looking int=
o
> >    ways for using the same sysctr instead of adding additional early bo=
ot
> >    parameter.
>
> I have reviewed the parts that integrate the tracking with page and slab
> allocators, and besides some details to improve it seems ok to me. The
> early boot option seems coming so that might eventually be suitable for
> build-time enablement in a distro kernel.

Thanks for reviewing Vlastimil!

>
> The macros (and their potential spread to upper layers to keep the
> information useful enough) are of course ugly, but guess it can't be
> currently helped and I'm unable to decide whether it's worth it or not.
> That's up to those providing their success stories I guess. If there's
> at least a path ahead to replace that part with compiler support in the
> future, great. So I'm not against merging this. BTW, do we know Linus's
> opinion on the macros approach?

We haven't run it by Linus specifically but hopefully we will see a
comment from him on the mailing list at some point.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

