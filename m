Return-Path: <linux-fsdevel+bounces-16020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E7F896E58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 13:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB6E1C26248
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDB01419A2;
	Wed,  3 Apr 2024 11:40:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE76D137C33;
	Wed,  3 Apr 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144404; cv=none; b=oB7LmKdeZhO6HGcHBzYZqJsuwF7I58aOBcwkSi6kmJ8xdHzL7Qogt3NiAX9f7gVfwlOMxC8kNYapj/G1p0oImmeb9gdT6ztbETjxqBaJL4BHvSIjCbVOJf+/0hAmrzkeFPXzjNxoHKK2WQuBC6zFQp/d4uKaGaDJD8FD72tOWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144404; c=relaxed/simple;
	bh=lZBIGVs8XhxS6Q9xorJJZuBaOAPYeUQ2I44RzaUdEYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjVDi1TRa0JoWvCISSlrOAld7JAQIjZRLj1do8YLvNwnop95x/LIZZ9saCXR2ixiTU6rhnIbISY6wsvPZC2dX+oML/1zclHLpLUKQz53aVahg3/PttsdFA7O8EU7HPL92lLSxLpG8Qg/3OkY+5dfHVxj4FF3yBEQZp7rbrmNaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15A5D1007;
	Wed,  3 Apr 2024 04:40:33 -0700 (PDT)
Received: from [10.1.29.139] (R90XJLFY.arm.com [10.1.29.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB6153F64C;
	Wed,  3 Apr 2024 04:39:58 -0700 (PDT)
Message-ID: <30df7730-1b37-420d-b661-e5316679246f@arm.com>
Date: Wed, 3 Apr 2024 12:39:56 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm, slab: move memcg charging to post-alloc hook
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Shakeel Butt <shakeel.butt@linux.dev>, Mark Brown <broonie@kernel.org>
References: <20240325-slab-memcg-v2-0-900a458233a6@suse.cz>
 <20240325-slab-memcg-v2-1-900a458233a6@suse.cz>
From: Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <20240325-slab-memcg-v2-1-900a458233a6@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/03/2024 08:20, Vlastimil Babka wrote:
> The MEMCG_KMEM integration with slab currently relies on two hooks
> during allocation. memcg_slab_pre_alloc_hook() determines the objcg and
> charges it, and memcg_slab_post_alloc_hook() assigns the objcg pointer
> to the allocated object(s).
> 
> As Linus pointed out, this is unnecessarily complex. Failing to charge
> due to memcg limits should be rare, so we can optimistically allocate
> the object(s) and do the charging together with assigning the objcg
> pointer in a single post_alloc hook. In the rare case the charging
> fails, we can free the object(s) back.
> 
> This simplifies the code (no need to pass around the objcg pointer) and
> potentially allows to separate charging from allocation in cases where
> it's common that the allocation would be immediately freed, and the
> memcg handling overhead could be saved.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/all/CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com/
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 180 +++++++++++++++++++++++++++-----------------------------------
>  1 file changed, 77 insertions(+), 103 deletions(-)

Hi Vlastimil,

When running the LTP test "memcg_limit_in_bytes" against next-master
(next-20240402) kernel with Arm64 on JUNO, oops is observed in our CI. I
can send the full logs if required. It is observed to work fine on
softiron-overdrive-3000.

A bisect identified 11bb2d9d91627935c63ea3e6a031fd238c846e1 as the first
bad commit. Bisected it on the tag "next-20240402" at repo
"https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".

This works fine on  Linux version v6.9-rc2

Log from failure against run on JUNO:
------------------------------------
<1>[ 6150.134750] Unable to handle kernel paging request at virtual
address ffffffffc2435ec8
            <1>[ 6150.143030] Mem abort info:
            <1>[ 6150.146137]   ESR = 0x0000000096000006
            <1>[ 6150.150186]   EC = 0x25: DABT (current EL), IL = 32 bits
            <1>[ 6150.155805]   SET = 0, FnV = 0
            <1>[ 6150.159161]   EA = 0, S1PTW = 0
            <1>[ 6150.162593]   FSC = 0x06: level 2 translation fault
            <1>[ 6150.167769] Data abort info:
            <1>[ 6150.170944]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
            <1>[ 6150.176729]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
            <1>[ 6150.182078]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
            <1>[ 6150.187688] swapper pgtable: 4k pages, 48-bit VAs,
pgdp=0000000081dca000
            <1>[ 6150.194707] [ffffffffc2435ec8] pgd=0000000000000000,
p4d=0000000082c52003, pud=0000000082c53003, pmd=0000000000000000
            <0>[ 6150.205688] Internal error: Oops: 0000000096000006
[#1] PREEMPT SMP
            <4>[ 6150.212245] Modules linked in: overlay binfmt_misc
btrfs blake2b_generic libcrc32c xor xor_neon raid6_pq zstd_compress fuse
ip_tables x_tables ipv6 crct10dif_ce onboard_usb_dev tda998x cec hdlcd
drm_dma_helper drm_kms_helper drm coresight_stm backlight coresight_tpiu
coresight_replicator stm_core coresight_tmc coresight_cpu_debug
coresight_cti coresight_funnel coresight smsc [last unloaded: binfmt_misc]
            <4>[ 6150.248579] CPU: 1 PID: 341531 Comm: memcg_process Not
tainted 6.9.0-rc2-next-20240402 #1
            <4>[ 6150.257056] Hardware name: ARM Juno development board
(r0) (DT)
            <4>[ 6150.258592] thermal thermal_zone0: failed to read out
thermal zone (-121)
            <4>[ 6150.263259] pstate: 40000005 (nZcv daif -PAN -UAO -TCO
-DIT -SSBS BTYPE=--)
            <4>[ 6150.263281] pc : memcg_alloc_abort_single+0x4c/0x140
            <4>[ 6150.263317] lr : kmem_cache_alloc_noprof+0x200/0x210
            <4>[ 6150.263335] sp : ffff800090d7bb10
            <4>[ 6150.263345] x29: ffff800090d7bb10 x28:
ffff000826cc0e40 x27: ffff000800db2280
            <4>[ 6150.263382] x26: 0000ffffa404c000 x25:
ffff000800fdf0a8 x24: 00000000000000a8
            <4>[ 6150.306574] x23: ffff80008009068c x22:
ffff80008029b16c x21: ffff800090d7bb90
            <4>[ 6150.314026] x20: ffff000800054400 x19:
ffffffffc2435ec0 x18: 0000000000000000
            <4>[ 6150.321470] x17: 2020202020203635 x16:
3220202020202030 x15: 0000b5da96570c3c
            <4>[ 6150.328914] x14: 00000000000001d8 x13:
0000000000000000 x12: 0000000000000000
            <4>[ 6150.336358] x11: 0000000000000000 x10:
0000000000000620 x9 : 0000000000000003
            <4>[ 6150.343803] x8 : ffff000800db2d80 x7 :
0000000000000003 x6 : ffff00082201f000
            <4>[ 6150.351247] x5 : ffffffffffffffff x4 :
0000000000000000 x3 : ffffffffffffffff
            <4>[ 6150.358690] x2 : ffff8008fd0a9000 x1 :
00000000f0000000 x0 : ffffc1ffc0000000
            <4>[ 6150.366135] Call trace:
            <4>[ 6150.368853]  memcg_alloc_abort_single+0x4c/0x140
            <4>[ 6150.373766]  kmem_cache_alloc_noprof+0x200/0x210
            <4>[ 6150.378668]  vm_area_alloc+0x2c/0xd4
            <4>[ 6150.382531]  mmap_region+0x178/0x980
            <4>[ 6150.386389]  do_mmap+0x3cc/0x528
            <4>[ 6150.389895]  vm_mmap_pgoff+0xec/0x134
            <4>[ 6150.393840]  ksys_mmap_pgoff+0x4c/0x204
            <4>[ 6150.397955]  __arm64_sys_mmap+0x30/0x44
            <4>[ 6150.402082]  invoke_syscall+0x48/0x114
            <4>[ 6150.406119]  el0_svc_common.constprop.0+0x40/0xe0
            <4>[ 6150.411114]  do_el0_svc+0x1c/0x28
            <4>[ 6150.414716]  el0_svc+0x34/0xdc
            <4>[ 6150.418061]  el0t_64_sync_handler+0xc0/0xc4
            <4>[ 6150.422532]  el0t_64_sync+0x190/0x194
            <0>[ 6150.426483] Code: aa1603fe d50320ff 8b131813 aa1e03f6
(f9400660)


Bisect log:
----------
git bisect start
# good: [39cd87c4eb2b893354f3b850f916353f2658ae6f] Linux 6.9-rc2
git bisect good 39cd87c4eb2b893354f3b850f916353f2658ae6f
# bad: [c0b832517f627ead3388c6f0c74e8ac10ad5774b] Add linux-next
specific files for 20240402
git bisect bad c0b832517f627ead3388c6f0c74e8ac10ad5774b
# bad: [784b758e641c4b36be7ef8ab585bea834099b030] Merge branch
'for-linux-next' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect bad 784b758e641c4b36be7ef8ab585bea834099b030
# bad: [631746aaa0999cbba47b1efc10421d8330a78de5] Merge branch
'xtensa-for-next' of git://github.com/jcmvbkbc/linux-xtensa.git
git bisect bad 631746aaa0999cbba47b1efc10421d8330a78de5
# bad: [d4c0a0316990688c0b77de2d3f7dfc91582c46ad] Merge branch
'mm-everything' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad d4c0a0316990688c0b77de2d3f7dfc91582c46ad
# bad: [ef4e56ae052ae57550fd24cdac78c99a36c8a20b] mm: take placement
mappings gap into account
git bisect bad ef4e56ae052ae57550fd24cdac78c99a36c8a20b
# good: [ac3c1a2ea65b2cbefdc1f7fe3085d633ebb174c8]
mm-page_isolation-prepare-for-hygienic-freelists-fix
git bisect good ac3c1a2ea65b2cbefdc1f7fe3085d633ebb174c8
# bad: [f11bb2d9d91627935c63ea3e6a031fd238c846e1] mm, slab: move memcg
charging to post-alloc hook
git bisect bad f11bb2d9d91627935c63ea3e6a031fd238c846e1
# good: [f307051520f6860a1f21cad32b4109b201196ae9] x86: remove unneeded
memblock_find_dma_reserve()
git bisect good f307051520f6860a1f21cad32b4109b201196ae9
# good: [dbde2cb09dc4eaf92c80d43c9326d7dca43575f4]
mm-move-follow_phys-to-arch-x86-mm-pat-memtypec-fix-2
git bisect good dbde2cb09dc4eaf92c80d43c9326d7dca43575f4
# good: [d8f80fe57b2992199744e9b2616f1a2702317c4b] mm: make
folio_test_idle and folio_test_young take a const argument
git bisect good d8f80fe57b2992199744e9b2616f1a2702317c4b
# good: [1165b638f42a982be42792ded4f8c6f94b13f0fe]
mm-convert-arch_clear_hugepage_flags-to-take-a-folio-fix
git bisect good 1165b638f42a982be42792ded4f8c6f94b13f0fe
# good: [f9bc35de30a88a146989601b1b2268946739f0e0] remove references to
page->flags in documentation
git bisect good f9bc35de30a88a146989601b1b2268946739f0e0
# good: [ea1be2228bb6d6c09b59a1f58b4b7582016825e5] proc: rewrite
stable_page_flags()
git bisect good ea1be2228bb6d6c09b59a1f58b4b7582016825e5
# first bad commit: [f11bb2d9d91627935c63ea3e6a031fd238c846e1] mm, slab:
move memcg charging to post-alloc hook

Thanks,
Aishwarya

