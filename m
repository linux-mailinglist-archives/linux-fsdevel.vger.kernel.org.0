Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3110858E51F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 05:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiHJDGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 23:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHJDGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:06:18 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF844B4BA;
        Tue,  9 Aug 2022 20:06:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660100772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=poXfwcF0BrvCKSPuMgzRYQ+R/ggHdZys0JOO62ypZUE=;
        b=HAEhHMGt0RlVh9X1rxBMt6JNhwraY3Pmfc0x5nYCXBN5m53DsvmL2AuYr1PnzVHE6ZKv88
        Nhg0YVQm3ne/8Nvgr445z5Of+EyzzhwXVGoaG+35w9LnCaSmdHRhWb1FC5kol4+CsA7qi8
        EslGoVQzrApl/VIbg+pAdft59oeVqpE=
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/2] Enable balloon drivers to report inflated memory
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
Date:   Wed, 10 Aug 2022 11:05:40 +0800
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        David Hildenbrand <david@redhat.com>,
        Wei Liu <wei.liu@kernel.org>, Nadav Amit <namit@vmware.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5EFFFB23-9F73-4F07-B6FF-3BD05976D427@linux.dev>
References: <7bfac48d-2e50-641b-6523-662ea4df0240@virtuozzo.com>
 <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 9, 2022, at 17:49, Alexander Atanasov =
<alexander.atanasov@virtuozzo.com> wrote:
>=20
> Display reported in /proc/meminfo as:

Hi,

I am not sure if this is a right place (meminfo) to put this statistic =
in since
it is the accounting from a specific driver. IIUC, this driver is only =
installed
in a VM, then this accounting will always be zero if this driver is not =
installed.
Is this possible to put it in a driver-specific sysfs file (maybe it is =
better)?
Just some thoughts from me.

Muchun,
Thanks.

>=20
> Inflated(total) or Inflated(free)
>=20
> depending on the driver.
>=20
> Drivers use the sign bit to indicate where they do account
> the inflated memory.
>=20
> Amount of inflated memory can be used by:
> - as a hint for the oom a killer
> - user space software that monitors memory pressure
>=20
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Nadav Amit <namit@vmware.com>
>=20
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
> Documentation/filesystems/proc.rst |  5 +++++
> fs/proc/meminfo.c                  | 11 +++++++++++
> include/linux/mm.h                 |  4 ++++
> mm/page_alloc.c                    |  4 ++++
> 4 files changed, 24 insertions(+)
>=20
> diff --git a/Documentation/filesystems/proc.rst =
b/Documentation/filesystems/proc.rst
> index 1bc91fb8c321..064b5b3d5bd8 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -986,6 +986,7 @@ Example output. You may not have all of these =
fields.
>     VmallocUsed:       40444 kB
>     VmallocChunk:          0 kB
>     Percpu:            29312 kB
> +    Inflated(total):  2097152 kB
>     HardwareCorrupted:     0 kB
>     AnonHugePages:   4149248 kB
>     ShmemHugePages:        0 kB
> @@ -1133,6 +1134,10 @@ VmallocChunk
> Percpu
>               Memory allocated to the percpu allocator used to back =
percpu
>               allocations. This stat excludes the cost of metadata.
> +Inflated(total) or Inflated(free)
> +               Amount of memory that is inflated by the balloon =
driver.
> +               Due to differences among balloon drivers inflated =
memory
> +               is either subtracted from TotalRam or from MemFree.
> HardwareCorrupted
>               The amount of RAM/memory in KB, the kernel identifies as
>               corrupted.
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6e89f0e2fd20..ebbe52ccbb93 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -38,6 +38,9 @@ static int meminfo_proc_show(struct seq_file *m, =
void *v)
> 	unsigned long pages[NR_LRU_LISTS];
> 	unsigned long sreclaimable, sunreclaim;
> 	int lru;
> +#ifdef CONFIG_MEMORY_BALLOON
> +	long inflated_kb;
> +#endif
>=20
> 	si_meminfo(&i);
> 	si_swapinfo(&i);
> @@ -153,6 +156,14 @@ static int meminfo_proc_show(struct seq_file *m, =
void *v)
> 		    global_zone_page_state(NR_FREE_CMA_PAGES));
> #endif
>=20
> +#ifdef CONFIG_MEMORY_BALLOON
> +	inflated_kb =3D atomic_long_read(&mem_balloon_inflated_kb);
> +	if (inflated_kb >=3D 0)
> +		seq_printf(m,  "Inflated(total): %8ld kB\n", =
inflated_kb);
> +	else
> +		seq_printf(m,  "Inflated(free): %8ld kB\n", =
-inflated_kb);
> +#endif
> +
> 	hugetlb_report_meminfo(m);
>=20
> 	arch_report_meminfo(m);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7898e29bcfb5..b190811dc16e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2582,6 +2582,10 @@ extern int watermark_boost_factor;
> extern int watermark_scale_factor;
> extern bool arch_has_descending_max_zone_pfns(void);
>=20
> +#ifdef CONFIG_MEMORY_BALLOON
> +extern atomic_long_t mem_balloon_inflated_kb;
> +#endif
> +
> /* nommu.c */
> extern atomic_long_t mmap_pages_allocated;
> extern int nommu_shrink_inode_mappings(struct inode *, size_t, =
size_t);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b0bcab50f0a3..12359179a3a2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -194,6 +194,10 @@ EXPORT_SYMBOL(init_on_alloc);
> DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
> EXPORT_SYMBOL(init_on_free);
>=20
> +#ifdef CONFIG_MEMORY_BALLOON
> +atomic_long_t mem_balloon_inflated_kb =3D ATOMIC_LONG_INIT(0);
> +#endif
> +
> static bool _init_on_alloc_enabled_early __read_mostly
> 				=3D =
IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
> static int __init early_init_on_alloc(char *buf)
> --=20
> 2.31.1
>=20
>=20

