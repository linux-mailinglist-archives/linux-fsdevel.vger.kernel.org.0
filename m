Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546CC463E41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 19:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhK3TAc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 14:00:32 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:52024 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343502AbhK3TAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:00:23 -0500
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 9AC93CCF940;
        Tue, 30 Nov 2021 19:56:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1638298615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYAEZyLHa4hWJbnoCwhKKvkrVXbIuBmfKgbfkG9/nJU=;
        b=N0lnt7/BruDdBrc0WdgdpLSMvNtYDHLLih7g/lCCcYyRgk67/MgfvcyHvT+kSbPljA3vTm
        Djc27Vtve3zSIhCnb5Ear6LvkuFSO4mWhxcUVdEI8Ie7GKOQf60i82n4VKWjf66/sC1HkI
        bxxoNX3sCaOP5efUSWzGUsqu6QTw9fc=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-mm@kvack.org, Alexey Avramov <hakavlad@inbox.lv>
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, kernel@xanmod.org,
        aros@gmx.com, iam@valdikss.org.ru, hakavlad@inbox.lv,
        hakavlad@gmail.com
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working set
Date:   Tue, 30 Nov 2021 19:56:53 +0100
Message-ID: <11873851.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20211130201652.2218636d@mail.inbox.lv>
References: <20211130201652.2218636d@mail.inbox.lv>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello.

On =FAter=FD 30. listopadu 2021 12:16:52 CET Alexey Avramov wrote:
> The kernel does not provide a way to protect the working set under memory
> pressure. A certain amount of anonymous and clean file pages is required =
by
> the userspace for normal operation. First of all, the userspace needs a
> cache of shared libraries and executable binaries. If the amount of the
> clean file pages falls below a certain level, then thrashing and even
> livelock can take place.
>=20
> The patch provides sysctl knobs for protecting the working set (anonymous
> and clean file pages) under memory pressure.
>=20
> The vm.anon_min_kbytes sysctl knob provides *hard* protection of anonymous
> pages. The anonymous pages on the current node won't be reclaimed under a=
ny
> conditions when their amount is below vm.anon_min_kbytes. This knob may be
> used to prevent excessive swap thrashing when anonymous memory is low (for
> example, when memory is going to be overfilled by compressed data of zram
> module). The default value is defined by CONFIG_ANON_MIN_KBYTES (suggested
> 0 in Kconfig).
>=20
> The vm.clean_low_kbytes sysctl knob provides *best-effort* protection of
> clean file pages. The file pages on the current node won't be reclaimed
> under memory pressure when the amount of clean file pages is below
> vm.clean_low_kbytes *unless* we threaten to OOM. Protection of clean file
> pages using this knob may be used when swapping is still possible to
>   - prevent disk I/O thrashing under memory pressure;
>   - improve performance in disk cache-bound tasks under memory pressure.
> The default value is defined by CONFIG_CLEAN_LOW_KBYTES (suggested 0 in
> Kconfig).
>=20
> The vm.clean_min_kbytes sysctl knob provides *hard* protection of clean
> file pages. The file pages on the current node won't be reclaimed under
> memory pressure when the amount of clean file pages is below
> vm.clean_min_kbytes. Hard protection of clean file pages using this knob
> may be used to
>   - prevent disk I/O thrashing under memory pressure even with no free sw=
ap
>     space;
>   - improve performance in disk cache-bound tasks under memory pressure;
>   - avoid high latency and prevent livelock in near-OOM conditions.
> The default value is defined by CONFIG_CLEAN_MIN_KBYTES (suggested 0 in
> Kconfig).

Although this is a definitely system-wide knob, wouldn't it make sense to=20
implement this also on a per-cgroup basis?

Thanks.

>=20
> Signed-off-by: Alexey Avramov <hakavlad@inbox.lv>
> Reported-by: Artem S. Tashkinov <aros@gmx.com>
> ---
>  Repo:
>  https://github.com/hakavlad/le9-patch
>=20
>  Documentation/admin-guide/sysctl/vm.rst | 66 ++++++++++++++++++++++++
>  include/linux/mm.h                      |  4 ++
>  kernel/sysctl.c                         | 21 ++++++++
>  mm/Kconfig                              | 63 +++++++++++++++++++++++
>  mm/vmscan.c                             | 91
> +++++++++++++++++++++++++++++++++ 5 files changed, 245 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/sysctl/vm.rst
> b/Documentation/admin-guide/sysctl/vm.rst index 5e7952021..2f606e23b 1006=
44
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -25,6 +25,9 @@ files can be found in mm/swap.c.
>  Currently, these files are in /proc/sys/vm:
>=20
>  - admin_reserve_kbytes
> +- anon_min_kbytes
> +- clean_low_kbytes
> +- clean_min_kbytes
>  - compact_memory
>  - compaction_proactiveness
>  - compact_unevictable_allowed
> @@ -105,6 +108,61 @@ On x86_64 this is about 128MB.
>  Changing this takes effect whenever an application requests memory.
>=20
>=20
> +anon_min_kbytes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This knob provides *hard* protection of anonymous pages. The anonymous
> pages +on the current node won't be reclaimed under any conditions when
> their amount +is below vm.anon_min_kbytes.
> +
> +This knob may be used to prevent excessive swap thrashing when anonymous
> +memory is low (for example, when memory is going to be overfilled by
> +compressed data of zram module).
> +
> +Setting this value too high (close to MemTotal) can result in inability =
to
> +swap and can lead to early OOM under memory pressure.
> +
> +The default value is defined by CONFIG_ANON_MIN_KBYTES.
> +
> +
> +clean_low_kbytes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This knob provides *best-effort* protection of clean file pages. The file
> pages +on the current node won't be reclaimed under memory pressure when
> the amount of +clean file pages is below vm.clean_low_kbytes *unless* we
> threaten to OOM. +
> +Protection of clean file pages using this knob may be used when swapping=
 is
> +still possible to
> +  - prevent disk I/O thrashing under memory pressure;
> +  - improve performance in disk cache-bound tasks under memory pressure.
> +
> +Setting it to a high value may result in a early eviction of anonymous
> pages +into the swap space by attempting to hold the protected amount of
> clean file +pages in memory.
> +
> +The default value is defined by CONFIG_CLEAN_LOW_KBYTES.
> +
> +
> +clean_min_kbytes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This knob provides *hard* protection of clean file pages. The file pages=
 on
> the +current node won't be reclaimed under memory pressure when the amount
> of clean +file pages is below vm.clean_min_kbytes.
> +
> +Hard protection of clean file pages using this knob may be used to
> +  - prevent disk I/O thrashing under memory pressure even with no free s=
wap
> space; +  - improve performance in disk cache-bound tasks under memory
> pressure; +  - avoid high latency and prevent livelock in near-OOM
> conditions. +
> +Setting it to a high value may result in a early out-of-memory condition
> due to +the inability to reclaim the protected amount of clean file pages
> when other +types of pages cannot be reclaimed.
> +
> +The default value is defined by CONFIG_CLEAN_MIN_KBYTES.
> +
> +
>  compact_memory
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> @@ -864,6 +922,14 @@ be 133 (x + 2x =3D 200, 2x =3D 133.33).
>  At 0, the kernel will not initiate swap until the amount of free and
>  file-backed pages is less than the high watermark in a zone.
>=20
> +This knob has no effect if the amount of clean file pages on the current
> +node is below vm.clean_low_kbytes or vm.clean_min_kbytes. In this case,
> +only anonymous pages can be reclaimed.
> +
> +If the number of anonymous pages on the current node is below
> +vm.anon_min_kbytes, then only file pages can be reclaimed with
> +any vm.swappiness value.
> +
>=20
>  unprivileged_userfaultfd
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a7e4a9e7d..bee9807d5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -200,6 +200,10 @@ static inline void __mm_zero_struct_page(struct page
> *page)
>=20
>  extern int sysctl_max_map_count;
>=20
> +extern unsigned long sysctl_anon_min_kbytes;
> +extern unsigned long sysctl_clean_low_kbytes;
> +extern unsigned long sysctl_clean_min_kbytes;
> +
>  extern unsigned long sysctl_user_reserve_kbytes;
>  extern unsigned long sysctl_admin_reserve_kbytes;
>=20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 083be6af2..65fc38756 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -3132,6 +3132,27 @@ static struct ctl_table vm_table[] =3D {
>  	},
>  #endif
>  	{
> +		.procname	=3D "anon_min_kbytes",
> +		.data		=3D &sysctl_anon_min_kbytes,
> +		.maxlen		=3D sizeof(unsigned long),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_doulongvec_minmax,
> +	},
> +	{
> +		.procname	=3D "clean_low_kbytes",
> +		.data		=3D &sysctl_clean_low_kbytes,
> +		.maxlen		=3D sizeof(unsigned long),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_doulongvec_minmax,
> +	},
> +	{
> +		.procname	=3D "clean_min_kbytes",
> +		.data		=3D &sysctl_clean_min_kbytes,
> +		.maxlen		=3D sizeof(unsigned long),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_doulongvec_minmax,
> +	},
> +	{
>  		.procname	=3D "user_reserve_kbytes",
>  		.data		=3D &sysctl_user_reserve_kbytes,
>  		.maxlen		=3D sizeof(sysctl_user_reserve_kbytes),
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 28edafc82..dea0806d7 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -89,6 +89,69 @@ config SPARSEMEM_VMEMMAP
>  	  pfn_to_page and page_to_pfn operations.  This is the most
>  	  efficient option when sufficient kernel resources are available.
>=20
> +config ANON_MIN_KBYTES
> +	int "Default value for vm.anon_min_kbytes"
> +	depends on SYSCTL
> +	range 0 4294967295
> +	default 0
> +	help
> +	  This option sets the default value for vm.anon_min_kbytes sysctl=20
knob.
> +
> +	  The vm.anon_min_kbytes sysctl knob provides *hard* protection of
> +	  anonymous pages. The anonymous pages on the current node won't be
> +	  reclaimed under any conditions when their amount is below
> +	  vm.anon_min_kbytes. This knob may be used to prevent excessive swap
> +	  thrashing when anonymous memory is low (for example, when memory is
> +	  going to be overfilled by compressed data of zram module).
> +
> +	  Setting this value too high (close to MemTotal) can result in
> +	  inability to swap and can lead to early OOM under memory pressure.
> +
> +config CLEAN_LOW_KBYTES
> +	int "Default value for vm.clean_low_kbytes"
> +	depends on SYSCTL
> +	range 0 4294967295
> +	default 0
> +	help
> +	  This option sets the default value for vm.clean_low_kbytes sysctl=20
knob.
> +
> +	  The vm.clean_low_kbytes sysctl knob provides *best-effort*
> +	  protection of clean file pages. The file pages on the current node
> +	  won't be reclaimed under memory pressure when the amount of clean file
> +	  pages is below vm.clean_low_kbytes *unless* we threaten to OOM.
> +	  Protection of clean file pages using this knob may be used when
> +	  swapping is still possible to
> +	    - prevent disk I/O thrashing under memory pressure;
> +	    - improve performance in disk cache-bound tasks under memory
> +	      pressure.
> +
> +	  Setting it to a high value may result in a early eviction of=20
anonymous
> +	  pages into the swap space by attempting to hold the protected amount
> +	  of clean file pages in memory.
> +
> +config CLEAN_MIN_KBYTES
> +	int "Default value for vm.clean_min_kbytes"
> +	depends on SYSCTL
> +	range 0 4294967295
> +	default 0
> +	help
> +	  This option sets the default value for vm.clean_min_kbytes sysctl=20
knob.
> +
> +	  The vm.clean_min_kbytes sysctl knob provides *hard* protection of
> +	  clean file pages. The file pages on the current node won't be
> +	  reclaimed under memory pressure when the amount of clean file pages is
> +	  below vm.clean_min_kbytes. Hard protection of clean file pages using
> +	  this knob may be used to
> +	    - prevent disk I/O thrashing under memory pressure even with no=20
free
> +	      swap space;
> +	    - improve performance in disk cache-bound tasks under memory
> +	      pressure;
> +	    - avoid high latency and prevent livelock in near-OOM conditions.
> +
> +	  Setting it to a high value may result in a early out-of-memory=20
condition
> +	  due to the inability to reclaim the protected amount of clean file
> pages +	  when other types of pages cannot be reclaimed.
> +
>  config HAVE_MEMBLOCK_PHYS_MAP
>  	bool
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fb9584641..928f3371d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -122,6 +122,15 @@ struct scan_control {
>  	/* The file pages on the current node are dangerously low */
>  	unsigned int file_is_tiny:1;
>=20
> +	/* The anonymous pages on the current node are below vm.anon_min_kbytes=
=20
*/
> +	unsigned int anon_below_min:1;
> +
> +	/* The clean file pages on the current node are below=20
vm.clean_low_kbytes
> */ +	unsigned int clean_below_low:1;
> +
> +	/* The clean file pages on the current node are below=20
vm.clean_min_kbytes
> */ +	unsigned int clean_below_min:1;
> +
>  	/* Always discard instead of demoting to lower tier memory */
>  	unsigned int no_demotion:1;
>=20
> @@ -171,6 +180,10 @@ struct scan_control {
>  #define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
>  #endif
>=20
> +unsigned long sysctl_anon_min_kbytes __read_mostly =3D
> CONFIG_ANON_MIN_KBYTES; +unsigned long sysctl_clean_low_kbytes
> __read_mostly =3D CONFIG_CLEAN_LOW_KBYTES; +unsigned long
> sysctl_clean_min_kbytes __read_mostly =3D CONFIG_CLEAN_MIN_KBYTES; +
>  /*
>   * From 0 .. 200.  Higher means more swappy.
>   */
> @@ -2734,6 +2747,15 @@ static void get_scan_count(struct lruvec *lruvec,
> struct scan_control *sc, }
>=20
>  	/*
> +	 * Force-scan anon if clean file pages is under vm.clean_low_kbytes
> +	 * or vm.clean_min_kbytes.
> +	 */
> +	if (sc->clean_below_low || sc->clean_below_min) {
> +		scan_balance =3D SCAN_ANON;
> +		goto out;
> +	}
> +
> +	/*
>  	 * If there is enough inactive page cache, we do not reclaim
>  	 * anything from the anonymous working right now.
>  	 */
> @@ -2877,6 +2899,25 @@ static void get_scan_count(struct lruvec *lruvec,
> struct scan_control *sc, BUG();
>  		}
>=20
> +		/*
> +		 * Hard protection of the working set.
> +		 */
> +		if (file) {
> +			/*
> +			 * Don't reclaim file pages when the amount of
> +			 * clean file pages is below vm.clean_min_kbytes.
> +			 */
> +			if (sc->clean_below_min)
> +				scan =3D 0;
> +		} else {
> +			/*
> +			 * Don't reclaim anonymous pages when their
> +			 * amount is below vm.anon_min_kbytes.
> +			 */
> +			if (sc->anon_below_min)
> +				scan =3D 0;
> +		}
> +
>  		nr[lru] =3D scan;
>  	}
>  }
> @@ -3082,6 +3123,54 @@ static inline bool should_continue_reclaim(struct
> pglist_data *pgdat, return inactive_lru_pages > pages_for_compaction;
>  }
>=20
> +static void prepare_workingset_protection(pg_data_t *pgdat, struct
> scan_control *sc) +{
> +	/*
> +	 * Check the number of anonymous pages to protect them from
> +	 * reclaiming if their amount is below the specified.
> +	 */
> +	if (sysctl_anon_min_kbytes) {
> +		unsigned long reclaimable_anon;
> +
> +		reclaimable_anon =3D
> +			node_page_state(pgdat, NR_ACTIVE_ANON) +
> +			node_page_state(pgdat, NR_INACTIVE_ANON) +
> +			node_page_state(pgdat, NR_ISOLATED_ANON);
> +		reclaimable_anon <<=3D (PAGE_SHIFT - 10);
> +
> +		sc->anon_below_min =3D reclaimable_anon < sysctl_anon_min_kbytes;
> +	} else
> +		sc->anon_below_min =3D 0;
> +
> +	/*
> +	 * Check the number of clean file pages to protect them from
> +	 * reclaiming if their amount is below the specified.
> +	 */
> +	if (sysctl_clean_low_kbytes || sysctl_clean_min_kbytes) {
> +		unsigned long reclaimable_file, dirty, clean;
> +
> +		reclaimable_file =3D
> +			node_page_state(pgdat, NR_ACTIVE_FILE) +
> +			node_page_state(pgdat, NR_INACTIVE_FILE) +
> +			node_page_state(pgdat, NR_ISOLATED_FILE);
> +		dirty =3D node_page_state(pgdat, NR_FILE_DIRTY);
> +		/*
> +		 * node_page_state() sum can go out of sync since
> +		 * all the values are not read at once.
> +		 */
> +		if (likely(reclaimable_file > dirty))
> +			clean =3D (reclaimable_file - dirty) << (PAGE_SHIFT - 10);
> +		else
> +			clean =3D 0;
> +
> +		sc->clean_below_low =3D clean < sysctl_clean_low_kbytes;
> +		sc->clean_below_min =3D clean < sysctl_clean_min_kbytes;
> +	} else {
> +		sc->clean_below_low =3D 0;
> +		sc->clean_below_min =3D 0;
> +	}
> +}
> +
>  static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  {
>  	struct mem_cgroup *target_memcg =3D sc->target_mem_cgroup;
> @@ -3249,6 +3338,8 @@ static void shrink_node(pg_data_t *pgdat, struct
> scan_control *sc) anon >> sc->priority;
>  	}
>=20
> +	prepare_workingset_protection(pgdat, sc);
> +
>  	shrink_node_memcgs(pgdat, sc);
>=20
>  	if (reclaim_state) {
>=20
> base-commit: d58071a8a76d779eedab38033ae4c821c30295a5
> --
> 2.11.0


=2D-=20
Oleksandr Natalenko (post-factum)


