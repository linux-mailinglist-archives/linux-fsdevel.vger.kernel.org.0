Return-Path: <linux-fsdevel+bounces-31830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BA499BDE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 04:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BCB1C2155A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 02:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5A7481D1;
	Mon, 14 Oct 2024 02:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awb31FIF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A9EF9D9;
	Mon, 14 Oct 2024 02:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728874288; cv=none; b=e7Mp6mjpaD8eu5dQlPVuACQU9oyEuacv+LiAQgoeDuXs5TJprzka2PbHLAduAgLdcvHhRdG+b36N4xDZp/QwQs2o+F03emgMc8VmXGJxr0Uqg8kXb1PLgkJOjZfEib/acUYA1AkKAulLGNMzx9DsxoA+FtXBNtMRzoYnAhfoFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728874288; c=relaxed/simple;
	bh=rdWpmeggTEds4k6pc7A9JyRdoTk6yM9FAMLeczrgUoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsB19IPD/KtGMOkpPiRUM9MBAFY7NT8w0p0BtihRh5e6O/1rwAK2xI8pBvBRCfOwAQ8Vj0QV6Hh+GAqZV/Fx3dESMoMJkuCPxg3OxthspYrlmTjmN48u+fi5PehDQnfb/RPXkBYAODVsDMoEll5KaqcPgErhkwtR/HyVcy5vXAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awb31FIF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728874286; x=1760410286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rdWpmeggTEds4k6pc7A9JyRdoTk6yM9FAMLeczrgUoI=;
  b=awb31FIFQKO4KBH/2cD+0QCqhASuoetPyQl0f/u6/iEUI/5utuTBwOoB
   s6d0pLQqDwl2F5w5MgLFwBLuz6YU6g4Rj3V66lJmOfIpjQbcYl7tcPHtk
   /8/A0cWbywA/Rmo2gxt9t5rYJ4MwD7a/31T6Rh+OWuJLvdLseigLsql/o
   rYbIfEjFJ7wsYVAmrAN8Wuy7kJAdjQcSjaU8LYokJ+josOZ7QkSEocVV6
   QN+rUJZ+7jiZDoeIquWigcVG5a8pIMwSysIynyX058VSq9LhtHzMbAbE1
   Lts6RhDe9DuyplcJAeV1Na3WG+xASYNhSBuOy5BOG/h6VznABAONjwdIb
   Q==;
X-CSE-ConnectionGUID: c6H+w3uJSbCoGvkFPiunhg==
X-CSE-MsgGUID: bsjasZVzSC2/6VSF0yDQWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="15835455"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="15835455"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 19:51:26 -0700
X-CSE-ConnectionGUID: mwGZb6JBSda2K6qjY5b5qA==
X-CSE-MsgGUID: +wbbgYhMQlC2OiOjt8f+Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="81430847"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 19:51:22 -0700
Date: Mon, 14 Oct 2024 10:50:25 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org,
	jannh@google.com, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, Eduard Zingerman <eddyz87@gmail.com>,
	yi1.lai@intel.com
Subject: Re: [PATCH v7 bpf-next 05/10] lib/buildid: rename build_id_parse()
 into build_id_parse_nofault()
Message-ID: <ZwyG8Uro/SyTXAni@ly-workstation>
References: <20240829174232.3133883-1-andrii@kernel.org>
 <20240829174232.3133883-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829174232.3133883-6-andrii@kernel.org>

Hi Andrii Nakryiko,

Greetings!

I used Syzkaller and found that there is BUG: unable to handle kernel paging request in build_id_parse_nofault

After bisection and the first bad commit is:
"
45b8fc309654 lib/buildid: rename build_id_parse() into build_id_parse_nofault()
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/241012_225717_build_id_parse_nofault
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/241012_225717_build_id_parse_nofault/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/241012_225717_build_id_parse_nofault/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/241012_225717_build_id_parse_nofault/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/241012_225717_build_id_parse_nofault/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/241012_225717_build_id_parse_nofault/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241012_225717_build_id_parse_nofault/bzImage_8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/241012_225717_build_id_parse_nofault/8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b_dmesg.log

"
[   26.168603]  ? __pfx___build_id_parse.isra.0+0x10/0x10
[   26.169447]  ? __pfx_d_path+0x10/0x10
[   26.170068]  ? __kasan_kmalloc+0x88/0xa0
[   26.170743]  build_id_parse_nofault+0x4d/0x60
[   26.171473]  perf_event_mmap+0xb44/0xd90
[   26.172134]  ? __pfx_perf_event_mmap+0x10/0x10
[   26.172895]  mmap_region+0x4e7/0x29d0
[   26.173526]  ? __pfx_mmap_region+0x10/0x10
[   26.174210]  ? lockdep_hardirqs_on+0x89/0x110
[   26.174956]  ? __kasan_check_read+0x15/0x20
[   26.175655]  ? mark_lock.part.0+0xf3/0x17b0
[   26.176369]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   26.177277]  ? arch_get_unmapped_area_topdown+0x3d6/0x710
[   26.178195]  ? rcu_read_unlock+0x3b/0xc0
[   26.178879]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   26.179808]  ? __sanitizer_cov_trace_cmp8+0x1c/0x30
[   26.180634]  ? cap_mmap_addr+0x60/0x330
[   26.181300]  ? security_mmap_addr+0x63/0x1b0
[   26.182029]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   26.182930]  ? __get_unmapped_area+0x1a9/0x3b0
[   26.183705]  do_mmap+0xd9b/0x11f0
[   26.184291]  ? __pfx_do_mmap+0x10/0x10
[   26.184938]  ? __pfx_down_write_killable+0x10/0x10
[   26.185758]  vm_mmap_pgoff+0x1ea/0x390
[   26.186413]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[   26.187129]  ? __fget_files+0x23c/0x4b0
[   26.187803]  ksys_mmap_pgoff+0x3dc/0x520
[   26.188490]  __x64_sys_mmap+0x139/0x1d0
[   26.189143]  x64_sys_call+0x18c6/0x20d0
[   26.189805]  do_syscall_64+0x6d/0x140
[   26.190425]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   26.191238] RIP: 0033:0x7fb10be3ee5d
[   26.191837] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   26.194753] RSP: 002b:00007ffe95b14e28 EFLAGS: 00000212 ORIG_RAX: 0000000000000009
[   26.195976] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb10be3ee5d
[   26.197126] RDX: 0000000000000001 RSI: 0000000000002000 RDI: 0000000020000000
[   26.198282] RBP: 00007ffe95b14f50 R08: 0000000000000004 R09: 0000000000000000
[   26.199471] R10: 0000000000000011 R11: 0000000000000212 R12: 00007ffe95b150a8
[   26.200606] R13: 0000000000402eb7 R14: 0000000000404e08 R15: 00007fb10c078000
[   26.201757]  </TASK>
[   26.202132] Modules linked in:
[   26.202663] CR2: ffff888010a44000
[   26.203219] ---[ end trace 0000000000000000 ]---
[   26.204002] RIP: 0010:memcmp+0x32/0x50
[   26.204685] Code: 06 48 39 07 75 17 48 83 c7 08 48 83 c6 08 48 83 ea 08 48 83 fa 07 77 e6 48 85 d2 74 20 31 c9 eb 09 48 83 c1 01 48 39 ca 74 0e <0f> b6 04 0f 44 0f b6 04 0e 44 29 c0 74 e9 c3 cc cc cc cc 31 c0 c3
[   26.207669] RSP: 0018:ffff88801fa675f0 EFLAGS: 00010246
[   26.208529] RAX: 0000000000000000 RBX: ffff88801fa67728 RCX: 0000000000000000
[   26.209655] RDX: 0000000000000004 RSI: ffffffff86583240 RDI: ffff888010a44000
[   26.210801] RBP: ffff88801fa67750 R08: 0000000000000000 R09: fffff94000085220
[   26.211929] R10: 0000000000000012 R11: 0000000000000001 R12: ffff888010a17c00
[   26.213053] R13: ffff888010a44000 R14: dffffc0000000000 R15: 0000000000000000
[   26.214186] FS:  00007fb10c02d800(0000) GS:ffff88806c500000(0000) knlGS:0000000000000000
[   26.215467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.216393] CR2: ffff888010a44000 CR3: 00000000124e8000 CR4: 0000000000750ef0
[   26.217533] PKRU: 55555554
[   26.217989] note: repro[728] exited with irqs disabled
"

I hope you find it useful.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

On Thu, Aug 29, 2024 at 10:42:27AM -0700, Andrii Nakryiko wrote:
> Make it clear that build_id_parse() assumes that it can take no page
> fault by renaming it and current few users to build_id_parse_nofault().
> 
> Also add build_id_parse() stub which for now falls back to non-sleepable
> implementation, but will be changed in subsequent patches to take
> advantage of sleepable context. PROCMAP_QUERY ioctl() on
> /proc/<pid>/maps file is using build_id_parse() and will automatically
> take advantage of more reliable sleepable context implementation.
> 
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/buildid.h |  4 ++--
>  kernel/bpf/stackmap.c   |  2 +-
>  kernel/events/core.c    |  2 +-
>  lib/buildid.c           | 25 ++++++++++++++++++++++---
>  4 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index 20aa3c2d89f7..014a88c41073 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -7,8 +7,8 @@
>  #define BUILD_ID_SIZE_MAX 20
>  
>  struct vm_area_struct;
> -int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> -		   __u32 *size);
> +int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size);
> +int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size);
>  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
>  
>  #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_VMCORE_INFO)
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index c99f8e5234ac..770ae8e88016 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -156,7 +156,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  			goto build_id_valid;
>  		}
>  		vma = find_vma(current->mm, ips[i]);
> -		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
> +		if (!vma || build_id_parse_nofault(vma, id_offs[i].build_id, NULL)) {
>  			/* per entry fall back to ips */
>  			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>  			id_offs[i].ip = ips[i];
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c973e3c11e03..c78a77f9dce4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8851,7 +8851,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
>  	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
>  
>  	if (atomic_read(&nr_build_id_events))
> -		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
> +		build_id_parse_nofault(vma, mmap_event->build_id, &mmap_event->build_id_size);
>  
>  	perf_iterate_sb(perf_event_mmap_output,
>  		       mmap_event,
> diff --git a/lib/buildid.c b/lib/buildid.c
> index e8fc4aeb01f2..c1cbd34f3685 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -293,10 +293,12 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
>   * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
>   * @size:     returns actual build id size in case of success
>   *
> - * Return: 0 on success, -EINVAL otherwise
> + * Assumes no page fault can be taken, so if relevant portions of ELF file are
> + * not already paged in, fetching of build ID fails.
> + *
> + * Return: 0 on success; negative error, otherwise
>   */
> -int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> -		   __u32 *size)
> +int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
>  {
>  	const Elf32_Ehdr *ehdr;
>  	struct freader r;
> @@ -335,6 +337,23 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>  	return ret;
>  }
>  
> +/*
> + * Parse build ID of ELF file mapped to VMA
> + * @vma:      vma object
> + * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
> + * @size:     returns actual build id size in case of success
> + *
> + * Assumes faultable context and can cause page faults to bring in file data
> + * into page cache.
> + *
> + * Return: 0 on success; negative error, otherwise
> + */
> +int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
> +{
> +	/* fallback to non-faultable version for now */
> +	return build_id_parse_nofault(vma, build_id, size);
> +}
> +
>  /**
>   * build_id_parse_buf - Get build ID from a buffer
>   * @buf:      ELF note section(s) to parse
> -- 
> 2.43.5
> 

