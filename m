Return-Path: <linux-fsdevel+bounces-11830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7DC85783C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 09:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E90D288C8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900F1BF5D;
	Fri, 16 Feb 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xqZAC8Nf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DNo3cJgt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o6dFJHJY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aZITzFqx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112F1BF20;
	Fri, 16 Feb 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073835; cv=none; b=fCJAYmZQfALBbGtaeQG6hhRZzaxYYjLA0h7LvtO4AjW66ifM62SICJ9q7mzFAonNEfwn0F+yYRVv5qv6PAnH1BWcbgql3NrbwEN5an19vaZTl1IBM/tlU2yG5vx6sm4nDGvliAc2hDVc/V4U/inNyHYv4t/gKusspyPvh/fIRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073835; c=relaxed/simple;
	bh=PZN4NUDhlSPRqQ+5OSGmNZJaVH5TCFAyxJEt+khL/ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NT84X6UweABbA3o/E6qCgvtNhUQV/EnMSpqBy3+JynKQx9jnn9vKmfj1SXuuKzSyntRckJX1C81ZRhDVruQafEux05tyf6ucNjJ1Q5q/G2nQtso2fSBdV2iexreMBjxdchrR67Nk/4/uBxAbf8uZturD0X0fxuqib3GtEn9oipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xqZAC8Nf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DNo3cJgt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o6dFJHJY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aZITzFqx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C06D422230;
	Fri, 16 Feb 2024 08:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708073831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6frag4EZ1jOwLxH7IawG8bVTXT73kvKmKsBZp1SHOo0=;
	b=xqZAC8NfI4VPwOmiN56g60Raff5Lxhe17+xsX3vNH0QOzt6ShH89ZxADUdhLUmfzqa/yo3
	TabAy019LUdCeaduHWP4hOkoOZikSueMUfLfFSxX3nthI3Q5FCXBIh5gkIPnuSEzUUHNC8
	aoYjNlz6r1ytNmjUW0gbjA0CboAyvwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708073831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6frag4EZ1jOwLxH7IawG8bVTXT73kvKmKsBZp1SHOo0=;
	b=DNo3cJgtVq0BnRTQlqXu+WykI9JOTEPvpS44g5kWEcGyImxRgdwT11KmfN81I/tNOI2VSh
	2qzAv6tbxotS0DBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708073830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6frag4EZ1jOwLxH7IawG8bVTXT73kvKmKsBZp1SHOo0=;
	b=o6dFJHJYflEIhmu8oJUS9nBoJdP7QX+krsnSyjAwSUNaPBESiTUd+tjTVJio1OYYVYDu8j
	RJQ2ECJWmXvAR40mvWwwCTnb0VwMxSzGAwbFN7ZbKS4nInD0v8SqrIY6ixqlIVwvXyJkLa
	BmrtOuKfG6D2kWVEeFboNt4w/oWeZcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708073830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6frag4EZ1jOwLxH7IawG8bVTXT73kvKmKsBZp1SHOo0=;
	b=aZITzFqxUxBBasuAdIqf/L/wncDfXgMKlk4TZrjJz7f6VSl6Ep4mywzmGsuZ9cplv0PiuQ
	xX5khlTEjs1YAwAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 309BB13A67;
	Fri, 16 Feb 2024 08:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hBNOC2Yjz2U1ZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Feb 2024 08:57:10 +0000
Message-ID: <f92ad1e3-2dde-4db2-9b76-96c6bbc6a208@suse.cz>
Date: Fri, 16 Feb 2024 09:57:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
 void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-14-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240212213922.783301-14-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_GT_50(0.00)[73];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/12/24 22:38, Suren Baghdasaryan wrote:
> Introduce CONFIG_MEM_ALLOC_PROFILING which provides definitions to easily
> instrument memory allocators. It registers an "alloc_tags" codetag type
> with /proc/allocinfo interface to output allocation tag information when
> the feature is enabled.
> CONFIG_MEM_ALLOC_PROFILING_DEBUG is provided for debugging the memory
> allocation profiling instrumentation.
> Memory allocation profiling can be enabled or disabled at runtime using
> /proc/sys/vm/mem_profiling sysctl when CONFIG_MEM_ALLOC_PROFILING_DEBUG=n.
> CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT enables memory allocation
> profiling by default.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  Documentation/admin-guide/sysctl/vm.rst |  16 +++
>  Documentation/filesystems/proc.rst      |  28 +++++
>  include/asm-generic/codetag.lds.h       |  14 +++
>  include/asm-generic/vmlinux.lds.h       |   3 +
>  include/linux/alloc_tag.h               | 133 ++++++++++++++++++++
>  include/linux/sched.h                   |  24 ++++
>  lib/Kconfig.debug                       |  25 ++++
>  lib/Makefile                            |   2 +
>  lib/alloc_tag.c                         | 158 ++++++++++++++++++++++++
>  scripts/module.lds.S                    |   7 ++
>  10 files changed, 410 insertions(+)
>  create mode 100644 include/asm-generic/codetag.lds.h
>  create mode 100644 include/linux/alloc_tag.h
>  create mode 100644 lib/alloc_tag.c
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index c59889de122b..a214719492ea 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -43,6 +43,7 @@ Currently, these files are in /proc/sys/vm:
>  - legacy_va_layout
>  - lowmem_reserve_ratio
>  - max_map_count
> +- mem_profiling         (only if CONFIG_MEM_ALLOC_PROFILING=y)
>  - memory_failure_early_kill
>  - memory_failure_recovery
>  - min_free_kbytes
> @@ -425,6 +426,21 @@ e.g., up to one or two maps per allocation.
>  The default value is 65530.
>  
>  
> +mem_profiling
> +==============
> +
> +Enable memory profiling (when CONFIG_MEM_ALLOC_PROFILING=y)
> +
> +1: Enable memory profiling.
> +
> +0: Disabld memory profiling.

      Disable

...

> +allocinfo
> +~~~~~~~
> +
> +Provides information about memory allocations at all locations in the code
> +base. Each allocation in the code is identified by its source file, line
> +number, module and the function calling the allocation. The number of bytes
> +allocated at each location is reported.

See, it even says "number of bytes" :)

> +
> +Example output.
> +
> +::
> +
> +    > cat /proc/allocinfo
> +
> +      153MiB     mm/slub.c:1826 module:slub func:alloc_slab_page

Is "module" meant in the usual kernel module sense? In that case IIRC is
more common to annotate things e.g. [xfs] in case it's really a module, and
nothing if it's built it, such as slub. Is that "slub" simply derived from
"mm/slub.c"? Then it's just redundant?

> +     6.08MiB     mm/slab_common.c:950 module:slab_common func:_kmalloc_order
> +     5.09MiB     mm/memcontrol.c:2814 module:memcontrol func:alloc_slab_obj_exts
> +     4.54MiB     mm/page_alloc.c:5777 module:page_alloc func:alloc_pages_exact
> +     1.32MiB     include/asm-generic/pgalloc.h:63 module:pgtable func:__pte_alloc_one
> +     1.16MiB     fs/xfs/xfs_log_priv.h:700 module:xfs func:xlog_kvmalloc
> +     1.00MiB     mm/swap_cgroup.c:48 module:swap_cgroup func:swap_cgroup_prepare
> +      734KiB     fs/xfs/kmem.c:20 module:xfs func:kmem_alloc
> +      640KiB     kernel/rcu/tree.c:3184 module:tree func:fill_page_cache_func
> +      640KiB     drivers/char/virtio_console.c:452 module:virtio_console func:alloc_buf
> +      ...
> +
> +
>  meminfo

...

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 0be2d00c3696..78d258ca508f 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -972,6 +972,31 @@ config CODE_TAGGING
>  	bool
>  	select KALLSYMS
>  
> +config MEM_ALLOC_PROFILING
> +	bool "Enable memory allocation profiling"
> +	default n
> +	depends on PROC_FS
> +	depends on !DEBUG_FORCE_WEAK_PER_CPU
> +	select CODE_TAGGING
> +	help
> +	  Track allocation source code and record total allocation size
> +	  initiated at that code location. The mechanism can be used to track
> +	  memory leaks with a low performance and memory impact.
> +
> +config MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> +	bool "Enable memory allocation profiling by default"
> +	default y

I'd go with default n as that I'd select for a general distro.

> +	depends on MEM_ALLOC_PROFILING
> +
> +config MEM_ALLOC_PROFILING_DEBUG
> +	bool "Memory allocation profiler debugging"
> +	default n
> +	depends on MEM_ALLOC_PROFILING
> +	select MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> +	help
> +	  Adds warnings with helpful error messages for memory allocation
> +	  profiling.
> +


