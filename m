Return-Path: <linux-fsdevel+bounces-28831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF8196EB0A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 08:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116891F2503C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 06:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8063143890;
	Fri,  6 Sep 2024 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFARKhlw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD113D243;
	Fri,  6 Sep 2024 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605643; cv=none; b=C3/DP/iszFKvgwtOlXUOe2IDb9Xkowc6neY3b3ZsB7QhaVfbwKDqKU2EaBPpNNaXLvCV6Jg1fPCfYFRYmMyzm9rlltmIiNjf/D1+cmJWA3wRR2DkVPWPo0nZpVvJRymxBsPSX5drS31CabH7l8jBLiDzyNW8Jw+Fdg83hcTKh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605643; c=relaxed/simple;
	bh=OFTVnJ2JoxDjZadQaJMQWUS5b372mZiqWwUqrmPxOwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZzNjfZd727suBPGA0+uerdNNUCjHYRqRdQ+1ILdbRVowB2oKDI3eF2+fCMNMkTvfjUzBAnhuSxw7YNNCVrprl7fud38ufcXkyXyODLfHc323/KPy7jPx5dxx2jkhZD35TrsB+i4+fC/NPBC039ThNFT2luSAK5Ug08PnV6q1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFARKhlw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725605641; x=1757141641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OFTVnJ2JoxDjZadQaJMQWUS5b372mZiqWwUqrmPxOwg=;
  b=oFARKhlwlbrv8FBiSQHESmqG2RX+KbL2VSsLhWbF6MRscwRq5Y3P/3rk
   xr8cm6G0EZZOvgsOv227BKImNmO98gcr+j/i8MzOdKWSpQn0N+TEuOAYi
   Il7eFHbwG8SnUFyZHNJCX0BCZmenXMucola68062I1fDs3L1Tou3UmDXo
   aVjILX3xo1dkRpoI+JT9Ei8wDIAawIt2HH1/B5hIlsdIzWctpK9vd/GmL
   HBngJSUob8RVAKhAVB4VA7pgCPAtbgbsFAU+yL5a/VL2MFHfsEmqxMS1W
   yf3Z77gy3Us1VowRLKAvtFInKgtjG44dDuWyG+oTuoXRy/49ebf9z049P
   Q==;
X-CSE-ConnectionGUID: YnUN3bsfTBquNqR1F+T/iw==
X-CSE-MsgGUID: WAbweHf/QQuGR7u7Su2y5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24548857"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="24548857"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 23:54:00 -0700
X-CSE-ConnectionGUID: tTBXyxZ9RdyPZlNTeO4HfQ==
X-CSE-MsgGUID: HJWIu7V5TvOxu4FNKfAjOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="66196848"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 23:53:52 -0700
Date: Fri, 6 Sep 2024 14:52:38 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
	david@fromorbit.com, Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, john.g.garry@oracle.com,
	cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
	ryan.roberts@arm.com, David Howells <dhowells@redhat.com>,
	pengfei.xu@intel.com
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
Message-ID: <ZtqmtjZ+mVTDx208@ly-workstation>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
 <20240822135018.1931258-5-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822135018.1931258-5-kernel@pankajraghav.com>

Hi Luis,

Greetings!

I used Syzkaller and found that there is task hang in soft_offline_page in Linux-next tree - next-20240902.

After bisection and the first bad commit is:
"
fd031210c9ce mm: split a folio in minimum folio order chunks
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/f633dcbc3a8e4ca5f52f0110bc75ff17d9885db4/240904_155526_soft_offline_page/bzImage_ecc768a84f0b8e631986f9ade3118fa37852fef0
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/240904_155526_soft_offline_page/ecc768a84f0b8e631986f9ade3118fa37852fef0_dmesg.log

"
[  447.976688]  ? __pfx_soft_offline_page.part.0+0x10/0x10
[  447.977255]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  447.977858]  soft_offline_page+0x97/0xc0
[  447.978281]  do_madvise.part.0+0x1a45/0x2a30
[  447.978742]  ? __pfx___lock_acquire+0x10/0x10
[  447.979227]  ? __pfx_do_madvise.part.0+0x10/0x10
[  447.979716]  ? __this_cpu_preempt_check+0x21/0x30
[  447.980225]  ? __this_cpu_preempt_check+0x21/0x30
[  447.980729]  ? lock_release+0x441/0x870
[  447.981160]  ? __this_cpu_preempt_check+0x21/0x30
[  447.981656]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[  447.982321]  ? lockdep_hardirqs_on+0x89/0x110
[  447.982771]  ? trace_hardirqs_on+0x51/0x60
[  447.983191]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[  447.983819]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[  447.984282]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
[  447.984673]  __x64_sys_madvise+0x139/0x180
[  447.984997]  x64_sys_call+0x19a5/0x2140
[  447.985307]  do_syscall_64+0x6d/0x140
[  447.985600]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  447.986011] RIP: 0033:0x7f782623ee5d
[  447.986248] RSP: 002b:00007fff9ddaffb8 EFLAGS: 00000217 ORIG_RAX: 000000000000001c
[  447.986709] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f782623ee5d
[  447.987147] RDX: 0000000000000065 RSI: 0000000000003000 RDI: 0000000020d51000
[  447.987584] RBP: 00007fff9ddaffc0 R08: 00007fff9ddafff0 R09: 00007fff9ddafff0
[  447.988022] R10: 00007fff9ddafff0 R11: 0000000000000217 R12: 00007fff9ddb0118
[  447.988428] R13: 0000000000401716 R14: 0000000000403e08 R15: 00007f782645d000
[  447.988799]  </TASK>
[  447.988921]
[  447.988921] Showing all locks held in the system:
[  447.989237] 1 lock held by khungtaskd/33:
[  447.989447]  #0: ffffffff8705c500 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x73/0x3c0
[  447.989947] 1 lock held by repro/628:
[  447.990144]  #0: ffffffff87258a28 (mf_mutex){+.+.}-{3:3}, at: soft_offline_page.part.0+0xda/0xf40
[  447.990611]
[  447.990701] =============================================

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

On Thu, Aug 22, 2024 at 03:50:12PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> split_folio() and split_folio_to_list() assume order 0, to support
> minorder for non-anonymous folios, we must expand these to check the
> folio mapping order and use that.
> 
> Set new_order to be at least minimum folio order if it is set in
> split_huge_page_to_list() so that we can maintain minimum folio order
> requirement in the page cache.
> 
> Update the debugfs write files used for testing to ensure the order
> is respected as well. We simply enforce the min order when a file
> mapping is used.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Tested-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/huge_mm.h | 14 +++++++---
>  mm/huge_memory.c        | 60 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 66 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 4c32058cacfec..70424d55da088 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -96,6 +96,8 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
>  #define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
>  	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
>  
> +#define split_folio(f) split_folio_to_list(f, NULL)
> +
>  #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
>  #define HPAGE_PMD_SHIFT PMD_SHIFT
>  #define HPAGE_PUD_SHIFT PUD_SHIFT
> @@ -317,9 +319,10 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
>  bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>  int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		unsigned int new_order);
> +int split_folio_to_list(struct folio *folio, struct list_head *list);
>  static inline int split_huge_page(struct page *page)
>  {
> -	return split_huge_page_to_list_to_order(page, NULL, 0);
> +	return split_folio(page_folio(page));
>  }
>  void deferred_split_folio(struct folio *folio);
>  
> @@ -495,6 +498,12 @@ static inline int split_huge_page(struct page *page)
>  {
>  	return 0;
>  }
> +
> +static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
> +{
> +	return 0;
> +}
> +
>  static inline void deferred_split_folio(struct folio *folio) {}
>  #define split_huge_pmd(__vma, __pmd, __address)	\
>  	do { } while (0)
> @@ -622,7 +631,4 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
>  	return split_folio_to_list_to_order(folio, NULL, new_order);
>  }
>  
> -#define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
> -#define split_folio(f) split_folio_to_order(f, 0)
> -
>  #endif /* _LINUX_HUGE_MM_H */
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index cf8e34f62976f..06384b85a3a20 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3303,6 +3303,9 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
>   * released, or if some unexpected race happened (e.g., anon VMA disappeared,
>   * truncation).
>   *
> + * Callers should ensure that the order respects the address space mapping
> + * min-order if one is set for non-anonymous folios.
> + *
>   * Returns -EINVAL when trying to split to an order that is incompatible
>   * with the folio. Splitting to order 0 is compatible with all folios.
>   */
> @@ -3384,6 +3387,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		mapping = NULL;
>  		anon_vma_lock_write(anon_vma);
>  	} else {
> +		unsigned int min_order;
>  		gfp_t gfp;
>  
>  		mapping = folio->mapping;
> @@ -3394,6 +3398,14 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  			goto out;
>  		}
>  
> +		min_order = mapping_min_folio_order(folio->mapping);
> +		if (new_order < min_order) {
> +			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
> +				     min_order);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
>  		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
>  							GFP_RECLAIM_MASK);
>  
> @@ -3506,6 +3518,25 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  	return ret;
>  }
>  
> +int split_folio_to_list(struct folio *folio, struct list_head *list)
> +{
> +	unsigned int min_order = 0;
> +
> +	if (folio_test_anon(folio))
> +		goto out;
> +
> +	if (!folio->mapping) {
> +		if (folio_test_pmd_mappable(folio))
> +			count_vm_event(THP_SPLIT_PAGE_FAILED);
> +		return -EBUSY;
> +	}
> +
> +	min_order = mapping_min_folio_order(folio->mapping);
> +out:
> +	return split_huge_page_to_list_to_order(&folio->page, list,
> +							min_order);
> +}
> +
>  void __folio_undo_large_rmappable(struct folio *folio)
>  {
>  	struct deferred_split *ds_queue;
> @@ -3736,6 +3767,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  		struct vm_area_struct *vma = vma_lookup(mm, addr);
>  		struct folio_walk fw;
>  		struct folio *folio;
> +		struct address_space *mapping;
> +		unsigned int target_order = new_order;
>  
>  		if (!vma)
>  			break;
> @@ -3753,7 +3786,13 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  		if (!is_transparent_hugepage(folio))
>  			goto next;
>  
> -		if (new_order >= folio_order(folio))
> +		if (!folio_test_anon(folio)) {
> +			mapping = folio->mapping;
> +			target_order = max(new_order,
> +					   mapping_min_folio_order(mapping));
> +		}
> +
> +		if (target_order >= folio_order(folio))
>  			goto next;
>  
>  		total++;
> @@ -3771,9 +3810,14 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  		folio_get(folio);
>  		folio_walk_end(&fw, vma);
>  
> -		if (!split_folio_to_order(folio, new_order))
> +		if (!folio_test_anon(folio) && folio->mapping != mapping)
> +			goto unlock;
> +
> +		if (!split_folio_to_order(folio, target_order))
>  			split++;
>  
> +unlock:
> +
>  		folio_unlock(folio);
>  		folio_put(folio);
>  
> @@ -3802,6 +3846,8 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
>  	pgoff_t index;
>  	int nr_pages = 1;
>  	unsigned long total = 0, split = 0;
> +	unsigned int min_order;
> +	unsigned int target_order;
>  
>  	file = getname_kernel(file_path);
>  	if (IS_ERR(file))
> @@ -3815,6 +3861,8 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
>  		 file_path, off_start, off_end);
>  
>  	mapping = candidate->f_mapping;
> +	min_order = mapping_min_folio_order(mapping);
> +	target_order = max(new_order, min_order);
>  
>  	for (index = off_start; index < off_end; index += nr_pages) {
>  		struct folio *folio = filemap_get_folio(mapping, index);
> @@ -3829,15 +3877,19 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
>  		total++;
>  		nr_pages = folio_nr_pages(folio);
>  
> -		if (new_order >= folio_order(folio))
> +		if (target_order >= folio_order(folio))
>  			goto next;
>  
>  		if (!folio_trylock(folio))
>  			goto next;
>  
> -		if (!split_folio_to_order(folio, new_order))
> +		if (folio->mapping != mapping)
> +			goto unlock;
> +
> +		if (!split_folio_to_order(folio, target_order))
>  			split++;
>  
> +unlock:
>  		folio_unlock(folio);
>  next:
>  		folio_put(folio);
> -- 
> 2.44.1
> 

