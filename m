Return-Path: <linux-fsdevel+bounces-24896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7694C946387
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 21:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A11A1C20DAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6161547D0;
	Fri,  2 Aug 2024 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggp7aY8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A51F44C9E;
	Fri,  2 Aug 2024 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722625349; cv=none; b=p1r0DQURzIa/yIwNM/xYVPXDC05nQQ1o8ipp/ZImUWklZvzgxEtZZg1FOYAOax0Uee5wFv7piFjw3zVlUEaXEpWFDpMaOnFwbVhAEU6Gitg+RI+cY2VKX1n/c2fdQYTJiggcm/ooZlXkZekcxQrQRALa9Xao2lbQuscpGHSwOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722625349; c=relaxed/simple;
	bh=DtXmQRpqkfWh5hqOlB9LaOmznGqd6TYDkyB+QBPI/MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbBbHDMHYtxKvnJMgOiqU2C0fua+E+8Gdxrh3pySxMj3xI1p6KYSX0RK7zNEK9ropSjXoJjDZcu8OITjXay4lhGGZs7NaPhTTD4H9qWhlrGGazxR0v3gpbEPWxZpTDnZ7ziH0UKv4cU+7Jp/0FgtQxP/qGNhCKBscuibyp34Ivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggp7aY8y; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722625347; x=1754161347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DtXmQRpqkfWh5hqOlB9LaOmznGqd6TYDkyB+QBPI/MM=;
  b=ggp7aY8yxQP5OhwyNFeEKhpjXfw6ciT2M9sDJojBMxTF6ZqhFEOq+qwv
   bqp7C4qeCmmsHPghvuGVwRAYklDTkxSVdqiYXEwVFbjbLiSQVAvwtkZwE
   JEs3UBjIY+Dga4a03JKqkuIOut/5EaoTPWbjd33I+tfeDXAa/vceR+0V0
   4aKxhN6PMUMvXQOzPjZqoWMspz7zPwUMxCeiPrIFSBcpBi9VfpkmcK8Ke
   qWHLyPqR63eAATcltZjV9N4nmGO9Ir32mc447PBeoFPufD0egUBCfqzo9
   6KNACxM4gpxFkpndJG3erF2Eqza2KEnyyUeKF8Od53NxJjhNnRKAcZtPh
   w==;
X-CSE-ConnectionGUID: L+kR6ECIS4OO8UdRPela+A==
X-CSE-MsgGUID: KOk5AQ8JRVm5W8o54vqSyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="24448010"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="24448010"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 12:02:25 -0700
X-CSE-ConnectionGUID: yUXC+5NMS9OPAWVlGKXPWg==
X-CSE-MsgGUID: fM9R7SXISw2CB+bmsmzBFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="59844572"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.91.178])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 12:02:23 -0700
Date: Fri, 2 Aug 2024 12:02:21 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Sourav Panda <souravpanda@google.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, mike.kravetz@oracle.com,
	muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
	rdunlap@infradead.org, chenlinxuan@uniontech.com,
	yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
	bhelgaas@google.com, ivan@cloudflare.com, pasha.tatashin@soleen.com,
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
	surenb@google.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, weixugc@google.com,
	David Rientjes <rientjes@google.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, yi.zhang@redhat.com
Subject: Re: [PATCH v13] mm: report per-page metadata information
Message-ID: <Zq0tPd2h6alFz8XF@aschofie-mobl2>
References: <20240605222751.1406125-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605222751.1406125-1-souravpanda@google.com>

++ nvdimm, linux-cxl, Yu Zhang

On Wed, Jun 05, 2024 at 10:27:51PM +0000, Sourav Panda wrote:
> Today, we do not have any observability of per-page metadata
> and how much it takes away from the machine capacity. Thus,
> we want to describe the amount of memory that is going towards
> per-page metadata, which can vary depending on build
> configuration, machine architecture, and system use.
> 
> This patch adds 2 fields to /proc/vmstat that can used as shown
> below:
> 
> Accounting per-page metadata allocated by boot-allocator:
> 	/proc/vmstat:nr_memmap_boot * PAGE_SIZE
> 
> Accounting per-page metadata allocated by buddy-allocator:
> 	/proc/vmstat:nr_memmap * PAGE_SIZE
> 
> Accounting total Perpage metadata allocated on the machine:
> 	(/proc/vmstat:nr_memmap_boot +
> 	 /proc/vmstat:nr_memmap) * PAGE_SIZE
> 
> Utility for userspace:
> 
> Observability: Describe the amount of memory overhead that is
> going to per-page metadata on the system at any given time since
> this overhead is not currently observable.
> 
> Debugging: Tracking the changes or absolute value in struct pages
> can help detect anomalies as they can be correlated with other
> metrics in the machine (e.g., memtotal, number of huge pages,
> etc).
> 
> page_ext overheads: Some kernel features such as page_owner
> page_table_check that use page_ext can be optionally enabled via
> kernel parameters. Having the total per-page metadata information
> helps users precisely measure impact. Furthermore, page-metadata
> metrics will reflect the amount of struct pages reliquished
> (or overhead reduced) when hugetlbfs pages are reserved which
> will vary depending on whether hugetlb vmemmap optimization is
> enabled or not.
> 
> For background and results see:
> lore.kernel.org/all/20240220214558.3377482-1-souravpanda@google.com
> 
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Sourav Panda <souravpanda@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

This patch is leading to Oops in 6.11-rc1 when CONFIG_MEMORY_HOTPLUG
is enabled. Folks hitting it have had success with reverting this patch.
Disabling CONFIG_MEMORY_HOTPLUG is not a long term solution.

Reported here:
https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=CoJkgBGP_+sNu6-6=6v=_L-ZBZY0bVLD3wUWZQg@mail.gmail.com/

A bit of detail below, follow above link for more:
dmesg:
[ 1408.632268] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000005650: 0000 [#1] PREEMPT SMP KASAN
PTI
[ 1408.644006] KASAN: probably user-memory-access in range
[0x000000000002b280-0x000000000002b287]
[ 1408.652699] CPU: 26 UID: 0 PID: 1868 Comm: ndctl Not tainted 6.11.0-rc1 #1
[ 1408.659571] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
2.20.1 09/13/2023
[ 1408.667136] RIP: 0010:mod_node_page_state+0x2a/0x110
[ 1408.672112] Code: 0f 1f 44 00 00 48 b8 00 00 00 00 00 fc ff df 41
54 55 48 89 fd 48 81 c7 80 b2 02 00 53 48 89 f9 89 d3 48 c1 e9 03 48
83 ec 10 <80> 3c 01 00 0f 85 b8 00 00 00 48 8b bd 80 b2 02 00 41 89 f0
83 ee
[ 1408.690856] RSP: 0018:ffffc900246d7388 EFLAGS: 00010286
[ 1408.696088] RAX: dffffc0000000000 RBX: 00000000fffffe00 RCX: 0000000000005650
[ 1408.703222] RDX: fffffffffffffe00 RSI: 000000000000002f RDI: 000000000002b280
[ 1408.710353] RBP: 0000000000000000 R08: ffff88a06ffcb1c8 R09: 1ffffffff218c681
[ 1408.717486] R10: ffffffff93d922bf R11: ffff88855e790f10 R12: 00000000000003ff
[ 1408.724619] R13: 1ffff920048dae7b R14: ffffea0081e00000 R15: ffffffff90c63408
[ 1408.731750] FS:  00007f753c219200(0000) GS:ffff889bf2a00000(0000)
knlGS:0000000000000000
[ 1408.739834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1408.745581] CR2: 0000559f5902a5a8 CR3: 00000001292f0006 CR4: 00000000007706f0
[ 1408.752713] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1408.759843] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1408.766976] PKRU: 55555554
[ 1408.769690] Call Trace:
[ 1408.772143]  <TASK>
[ 1408.774248]  ? die_addr+0x3d/0xa0
[ 1408.777577]  ? exc_general_protection+0x150/0x230
[ 1408.782297]  ? asm_exc_general_protection+0x22/0x30
[ 1408.787182]  ? mod_node_page_state+0x2a/0x110
[ 1408.791548]  section_deactivate+0x519/0x780
[ 1408.795740]  ? __pfx_section_deactivate+0x10/0x10
[ 1408.800449]  __remove_pages+0x6c/0xa0
[ 1408.804119]  arch_remove_memory+0x1a/0x70
[ 1408.808141]  pageunmap_range+0x2ad/0x5e0
[ 1408.812067]  memunmap_pages+0x320/0x5a0
[ 1408.815909]  release_nodes+0xd6/0x170
[ 1408.819581]  ? lockdep_hardirqs_on+0x78/0x100
[ 1408.823941]  devres_release_all+0x106/0x170
[ 1408.828126]  ? __pfx_devres_release_all+0x10/0x10
[ 1408.832834]  device_unbind_cleanup+0x16/0x1a0
[ 1408.837198]  device_release_driver_internal+0x3d5/0x530
[ 1408.842423]  ? klist_put+0xf7/0x170
[ 1408.845916]  bus_remove_device+0x1ed/0x3f0
[ 1408.850017]  device_del+0x33b/0x8c0
[ 1408.853518]  ? __pfx_device_del+0x10/0x10
[ 1408.857532]  unregister_dev_dax+0x112/0x210
[ 1408.861722]  release_nodes+0xd6/0x170
[ 1408.865387]  ? lockdep_hardirqs_on+0x78/0x100
[ 1408.869749]  devres_release_all+0x106/0x170
[ 1408.873933]  ? __pfx_devres_release_all+0x10/0x10
[ 1408.878643]  device_unbind_cleanup+0x16/0x1a0
[ 1408.883007]  device_release_driver_internal+0x3d5/0x530
[ 1408.888235]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 1408.892598]  unbind_store+0xdc/0xf0
[ 1408.896093]  kernfs_fop_write_iter+0x358/0x530
[ 1408.900539]  vfs_write+0x9b2/0xf60
[ 1408.903954]  ? __pfx_vfs_write+0x10/0x10
[ 1408.907891]  ? __fget_light+0x53/0x1e0
[ 1408.911646]  ? __x64_sys_openat+0x11f/0x1e0
[ 1408.915835]  ksys_write+0xf1/0x1d0
[ 1408.919249]  ? __pfx_ksys_write+0x10/0x10
[ 1408.923264]  do_syscall_64+0x8c/0x180
[ 1408.926934]  ? __debug_check_no_obj_freed+0x253/0x520
[ 1408.931997]  ? __pfx___debug_check_no_obj_freed+0x10/0x10
[ 1408.937405]  ? kasan_quarantine_put+0x109/0x220
[ 1408.941944]  ? lockdep_hardirqs_on+0x78/0x100
[ 1408.946304]  ? kmem_cache_free+0x1a6/0x4c0
[ 1408.950408]  ? do_sys_openat2+0x10a/0x160
[ 1408.954424]  ? do_sys_openat2+0x10a/0x160
[ 1408.958434]  ? __pfx_do_sys_openat2+0x10/0x10
[ 1408.962794]  ? lockdep_hardirqs_on+0x78/0x100
[ 1408.967153]  ? __pfx___debug_check_no_obj_freed+0x10/0x10
[ 1408.972554]  ? __x64_sys_openat+0x11f/0x1e0
[ 1408.976737]  ? __pfx___x64_sys_openat+0x10/0x10
[ 1408.981269]  ? rcu_is_watching+0x11/0xb0
[ 1408.985204]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[ 1408.990351]  ? do_syscall_64+0x98/0x180
[ 1408.994191]  ? lockdep_hardirqs_on+0x78/0x100
[ 1408.998549]  ? do_syscall_64+0x98/0x180
[ 1409.002386]  ? do_syscall_64+0x98/0x180
[ 1409.006227]  ? lockdep_hardirqs_on+0x78/0x100
[ 1409.010585]  ? do_syscall_64+0x98/0x180
[ 1409.014425]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[ 1409.019565]  ? do_syscall_64+0x98/0x180
[ 1409.023401]  ? lockdep_hardirqs_on+0x78/0x100
[ 1409.027763]  ? do_syscall_64+0x98/0x180
[ 1409.031600]  ? do_syscall_64+0x98/0x180
[ 1409.035439]  ? do_syscall_64+0x98/0x180
[ 1409.039281]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1409.044331] RIP: 0033:0x7f753c0fda57
[ 1409.047911] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89
74 24
[ 1409.066655] RSP: 002b:00007ffc19323e28 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[ 1409.074220] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f753c0fda57
[ 1409.081352] RDX: 0000000000000007 RSI: 0000559f5901f740 RDI: 0000000000000003
[ 1409.088483] RBP: 0000000000000003 R08: 0000000000000000 R09: 00007ffc19323d20
[ 1409.095616] R10: 0000000000000000 R11: 0000000000000246 R12: 0000559f5901f740
[ 1409.102748] R13: 00007ffc19323e90 R14: 00007f753c219120 R15: 0000559f5901fc30
[ 1409.109887]  </TASK>
[ 1409.112082] Modules linked in: kmem device_dax rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace netfs rfkill sunrpc
dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common skx_edac skx_edac_common
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm mgag200
rapl cdc_ether iTCO_wdt dell_pc i2c_algo_bit iTCO_vendor_support
ipmi_ssif usbnet acpi_power_meter drm_shmem_helper mei_me dell_smbios
platform_profile intel_cstate dcdbas wmi_bmof dell_wmi_descriptor
intel_uncore pcspkr mii drm_kms_helper i2c_i801 mei i2c_smbus
intel_pch_thermal lpc_ich ipmi_si acpi_ipmi dax_pmem ipmi_devintf
ipmi_msghandler drm fuse xfs libcrc32c sd_mod sg nd_pmem nd_btt
crct10dif_pclmul crc32_pclmul crc32c_intel ahci ghash_clmulni_intel
libahci bnxt_en megaraid_sas tg3 libata wmi nfit libnvdimm dm_mirror
dm_region_hash dm_log dm_mod
[ 1409.189120] ---[ end trace 0000000000000000 ]---

-- snip
> 

