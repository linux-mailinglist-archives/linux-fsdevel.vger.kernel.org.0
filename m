Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1685569E57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 11:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiGGJNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 05:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiGGJNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:13:48 -0400
Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047F72A963;
        Thu,  7 Jul 2022 02:13:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=29;SR=0;TI=SMTPD_---0VIcLc37_1657185215;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VIcLc37_1657185215)
          by smtp.aliyun-inc.com;
          Thu, 07 Jul 2022 17:13:37 +0800
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH v2 8/9] mm/mshare: Add basic page table sharing support
To:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        willy@infradead.org
Cc:     aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <7b768f38ad8a8be3aa35ac1e6316e556b121e866.1656531090.git.khalid.aziz@oracle.com>
From:   Xin Hao <xhao@linux.alibaba.com>
Message-ID: <bc5ac335-a08f-a910-fc59-cdcbd86ea726@linux.alibaba.com>
Date:   Thu, 7 Jul 2022 17:13:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7b768f38ad8a8be3aa35ac1e6316e556b121e866.1656531090.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/30/22 6:53 AM, Khalid Aziz wrote:
> Add support for creating a new set of shared page tables in a new
> mm_struct upon mmap of an mshare region. Add page fault handling in
> this now mshare'd region. Modify exit_mmap path to make sure page
> tables in the mshare'd regions are kept intact when a process using
> mshare'd region exits. Clean up mshare mm_struct when the mshare
> region is deleted. This support is for the process creating mshare
> region only. Subsequent patches will add support for other processes
> to be able to map the mshare region.
>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/mm.h |   2 +
>   mm/internal.h      |   2 +
>   mm/memory.c        | 101 +++++++++++++++++++++++++++++-
>   mm/mshare.c        | 149 ++++++++++++++++++++++++++++++++++++---------
>   4 files changed, 222 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0ddc3057f73b..63887f06b37b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1859,6 +1859,8 @@ void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>   		unsigned long end, unsigned long floor, unsigned long ceiling);
>   int
>   copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
> +int
> +mshare_copy_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
>   int follow_pte(struct mm_struct *mm, unsigned long address,
>   	       pte_t **ptepp, spinlock_t **ptlp);
>   int follow_pfn(struct vm_area_struct *vma, unsigned long address,
> diff --git a/mm/internal.h b/mm/internal.h
> index 3f2790aea918..6ae7063ac10d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -861,6 +861,8 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
>   
>   DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>   
> +extern vm_fault_t find_shared_vma(struct vm_area_struct **vma,
> +					unsigned long *addrp);
>   static inline bool vma_is_shared(const struct vm_area_struct *vma)
>   {
>   	return vma->vm_flags & VM_SHARED_PT;
> diff --git a/mm/memory.c b/mm/memory.c
> index 7a089145cad4..2a8d5b8928f5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -416,15 +416,20 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   		unlink_anon_vmas(vma);
>   		unlink_file_vma(vma);
>   
> +		/*
> +		 * There is no page table to be freed for vmas that
> +		 * are mapped in mshare regions
> +		 */
>   		if (is_vm_hugetlb_page(vma)) {
>   			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
>   				floor, next ? next->vm_start : ceiling);
> -		} else {
> +		} else if (!vma_is_shared(vma)) {
>   			/*
>   			 * Optimization: gather nearby vmas into one call down
>   			 */
>   			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
> -			       && !is_vm_hugetlb_page(next)) {
> +			       && !is_vm_hugetlb_page(next)
> +			       && !vma_is_shared(next)) {
>   				vma = next;
>   				next = vma->vm_next;
>   				unlink_anon_vmas(vma);
> @@ -1260,6 +1265,54 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>   	return false;
>   }
>   
> +/*
> + * Copy PTEs for mshare'd pages.
> + * This code is based upon copy_page_range()
> + */
> +int
> +mshare_copy_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> +{
> +	pgd_t *src_pgd, *dst_pgd;
> +	unsigned long next;
> +	unsigned long addr = src_vma->vm_start;
> +	unsigned long end = src_vma->vm_end;
> +	struct mm_struct *dst_mm = dst_vma->vm_mm;
> +	struct mm_struct *src_mm = src_vma->vm_mm;
> +	struct mmu_notifier_range range;
> +	int ret = 0;
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
> +				0, src_vma, src_mm, addr, end);
> +	mmu_notifier_invalidate_range_start(&range);
> +	/*
> +	 * Disabling preemption is not needed for the write side, as
> +	 * the read side doesn't spin, but goes to the mmap_lock.
> +	 *
> +	 * Use the raw variant of the seqcount_t write API to avoid
> +	 * lockdep complaining about preemptibility.
> +	 */
> +	mmap_assert_write_locked(src_mm);
> +	raw_write_seqcount_begin(&src_mm->write_protect_seq);
> +
> +	dst_pgd = pgd_offset(dst_mm, addr);
> +	src_pgd = pgd_offset(src_mm, addr);
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		if (pgd_none_or_clear_bad(src_pgd))
> +			continue;
> +		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
> +					    addr, next))) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +	} while (dst_pgd++, src_pgd++, addr = next, addr != end);
> +
> +	raw_write_seqcount_end(&src_mm->write_protect_seq);
> +	mmu_notifier_invalidate_range_end(&range);
> +
> +	return ret;
> +}
> +
>   int
>   copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>   {
> @@ -1628,6 +1681,13 @@ void unmap_page_range(struct mmu_gather *tlb,
>   	pgd_t *pgd;
>   	unsigned long next;
>   
> +	/*
> +	 * No need to unmap vmas that share page table through
> +	 * mshare region
> +	 */
> +	if (vma_is_shared(vma))
> +		return;
> +
>   	BUG_ON(addr >= end);
>   	tlb_start_vma(tlb, vma);
>   	pgd = pgd_offset(vma->vm_mm, addr);
> @@ -5113,6 +5173,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>   			   unsigned int flags, struct pt_regs *regs)
>   {
>   	vm_fault_t ret;
> +	bool shared = false;
> +	struct mm_struct *orig_mm;
>   
>   	__set_current_state(TASK_RUNNING);
>   
> @@ -5122,6 +5184,16 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>   	/* do counter updates before entering really critical section. */
>   	check_sync_rss_stat(current);
>   
> +	orig_mm = vma->vm_mm;
> +	if (unlikely(vma_is_shared(vma))) {
> +		ret = find_shared_vma(&vma, &address);
> +		if (ret)
> +			return ret;
> +		if (!vma)
> +			return VM_FAULT_SIGSEGV;
> +		shared = true;
if  shared is true,  so it mean the origin vma are replaced, but the 
code not free the origin vma ?
> +	}
> +
>   	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
>   					    flags & FAULT_FLAG_INSTRUCTION,
>   					    flags & FAULT_FLAG_REMOTE))
> @@ -5139,6 +5211,31 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>   	else
>   		ret = __handle_mm_fault(vma, address, flags);
>   
> +	/*
> +	 * Release the read lock on shared VMA's parent mm unless
> +	 * __handle_mm_fault released the lock already.
> +	 * __handle_mm_fault sets VM_FAULT_RETRY in return value if
> +	 * it released mmap lock. If lock was released, that implies
> +	 * the lock would have been released on task's original mm if
> +	 * this were not a shared PTE vma. To keep lock state consistent,
> +	 * make sure to release the lock on task's original mm
> +	 */
> +	if (shared) {
> +		int release_mmlock = 1;
> +
> +		if (!(ret & VM_FAULT_RETRY)) {
> +			mmap_read_unlock(vma->vm_mm);
> +			release_mmlock = 0;
> +		} else if ((flags & FAULT_FLAG_ALLOW_RETRY) &&
> +			(flags & FAULT_FLAG_RETRY_NOWAIT)) {
> +			mmap_read_unlock(vma->vm_mm);
> +			release_mmlock = 0;
> +		}
> +
> +		if (release_mmlock)
> +			mmap_read_unlock(orig_mm);
> +	}
> +
>   	if (flags & FAULT_FLAG_USER) {
>   		mem_cgroup_exit_user_fault();
>   		/*
> diff --git a/mm/mshare.c b/mm/mshare.c
> index 90ce0564a138..2ec0e56ffd69 100644
> --- a/mm/mshare.c
> +++ b/mm/mshare.c
> @@ -15,7 +15,7 @@
>    */
>   
>   #include <linux/fs.h>
> -#include <linux/mount.h>
> +#include <linux/mm.h>
>   #include <linux/syscalls.h>
>   #include <linux/uaccess.h>
>   #include <linux/pseudo_fs.h>
> @@ -24,6 +24,7 @@
>   #include <uapi/linux/limits.h>
>   #include <uapi/linux/mman.h>
>   #include <linux/sched/mm.h>
> +#include <linux/mmu_context.h>
>   
>   static struct super_block *msharefs_sb;
>   struct mshare_data {
> @@ -33,6 +34,43 @@ struct mshare_data {
>   	struct mshare_info *minfo;
>   };
>   
> +/* Returns holding the host mm's lock for read.  Caller must release. */
> +vm_fault_t
> +find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp)
> +{
> +	struct vm_area_struct *vma, *guest = *vmap;
> +	struct mshare_data *info = guest->vm_private_data;
> +	struct mm_struct *host_mm = info->mm;
> +	unsigned long host_addr;
> +	pgd_t *pgd, *guest_pgd;
> +
> +	mmap_read_lock(host_mm);
> +	host_addr = *addrp - guest->vm_start + host_mm->mmap_base;
> +	pgd = pgd_offset(host_mm, host_addr);
> +	guest_pgd = pgd_offset(guest->vm_mm, *addrp);
> +	if (!pgd_same(*guest_pgd, *pgd)) {
> +		set_pgd(guest_pgd, *pgd);
> +		mmap_read_unlock(host_mm);
> +		return VM_FAULT_NOPAGE;
> +	}
> +
> +	*addrp = host_addr;
> +	vma = find_vma(host_mm, host_addr);
> +
> +	/* XXX: expand stack? */
> +	if (vma && vma->vm_start > host_addr)
> +		vma = NULL;
> +
> +	*vmap = vma;
> +
> +	/*
> +	 * release host mm lock unless a matching vma is found
> +	 */
> +	if (!vma)
> +		mmap_read_unlock(host_mm);
> +	return 0;
> +}
> +
>   static const struct inode_operations msharefs_dir_inode_ops;
>   static const struct inode_operations msharefs_file_inode_ops;
>   
> @@ -64,6 +102,14 @@ msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
>   	return ret;
>   }
>   
> +static void
> +msharefs_delmm(struct mshare_data *info)
> +{
> +	mmput(info->mm);
> +	kfree(info->minfo);
> +	kfree(info);
> +}
> +
>   static void
>   msharefs_close(struct vm_area_struct *vma)
>   {
> @@ -73,9 +119,7 @@ msharefs_close(struct vm_area_struct *vma)
>   		mmap_read_lock(info->mm);
>   		if (info->deleted) {
>   			mmap_read_unlock(info->mm);
> -			mmput(info->mm);
> -			kfree(info->minfo);
> -			kfree(info);
> +			msharefs_delmm(info);
>   		} else {
>   			mmap_read_unlock(info->mm);
>   		}
> @@ -90,31 +134,80 @@ static int
>   msharefs_mmap(struct file *file, struct vm_area_struct *vma)
>   {
>   	struct mshare_data *info = file->private_data;
> -	struct mm_struct *mm = info->mm;
> +	struct mm_struct *new_mm = info->mm;
> +	int err = 0;
>   
> -	mmap_write_lock(mm);
> +	mmap_write_lock(new_mm);
>   	/*
> -	 * If this mshare region has been set up once already, bail out
> +	 * If this mshare region has not been set up, set up the
> +	 * applicable address range for the region and prepare for
> +	 * page table sharing
>   	 */
> -	if (mm->mmap_base != 0)
> +	if (new_mm->mmap_base != 0) {
>   		return -EINVAL;
> +	} else {
> +		struct mm_struct *old_mm;
> +		struct vm_area_struct *new_vma;
> +
> +		if ((vma->vm_start | vma->vm_end) & (PGDIR_SIZE - 1))
> +			return -EINVAL;
> +
> +		old_mm = current->mm;
> +		mmap_assert_write_locked(old_mm);
> +		new_mm->mmap_base = vma->vm_start;
> +		new_mm->task_size = vma->vm_end - vma->vm_start;
> +		if (!new_mm->task_size)
> +			new_mm->task_size--;
> +		info->minfo->start = new_mm->mmap_base;
> +		info->minfo->size = new_mm->task_size;
> +		info->deleted = 0;
> +		refcount_inc(&info->refcnt);
> +
> +		/*
> +		 * Mark current VMA as shared and copy over to mshare
> +		 * mm_struct
> +		 */
> +		vma->vm_private_data = info;
> +		new_vma = vm_area_dup(vma);
> +		if (!new_vma) {
> +			vma->vm_private_data = NULL;
> +			mmap_write_unlock(new_mm);
> +			err = -ENOMEM;
> +			goto err_out;
> +		}
> +		vma->vm_flags |= (VM_SHARED_PT|VM_SHARED);
> +		vma->vm_ops = &msharefs_vm_ops;
> +
> +		/*
> +		 * Newly created mshare mapping is anonymous mapping
> +		 */
> +		new_vma->vm_mm = new_mm;
> +		vma_set_anonymous(new_vma);
> +		new_vma->vm_file = NULL;
> +		new_vma->vm_flags &= ~VM_SHARED;
> +
> +		/*
> +		 * Do not use THP for mshare region
> +		 */
> +		new_vma->vm_flags |= VM_NOHUGEPAGE;
> +		err = insert_vm_struct(new_mm, new_vma);
> +		if (err) {
> +			mmap_write_unlock(new_mm);
> +			err = -ENOMEM;
> +			goto err_out;
> +		}
>   
> -	if ((vma->vm_start | vma->vm_end) & (PGDIR_SIZE - 1))
> -		return -EINVAL;
> +		/*
> +		 * Copy over current PTEs
> +		 */
> +		err = mshare_copy_ptes(new_vma, vma);
> +	}
>   
> -	mm->mmap_base = vma->vm_start;
> -	mm->task_size = vma->vm_end - vma->vm_start;
> -	if (!mm->task_size)
> -		mm->task_size--;
> -	mmap_write_unlock(mm);
> -	info->minfo->start = mm->mmap_base;
> -	info->minfo->size = mm->task_size;
> -	info->deleted = 0;
> -	refcount_inc(&info->refcnt);
> -	vma->vm_flags |= VM_SHARED_PT;
> -	vma->vm_private_data = info;
> -	vma->vm_ops = &msharefs_vm_ops;
> -	return 0;
> +	mmap_write_unlock(new_mm);
> +	return err;
> +
> +err_out:
> +	return err;
>   }
>   
>   static const struct file_operations msharefs_file_operations = {
> @@ -291,14 +384,10 @@ msharefs_unlink(struct inode *dir, struct dentry *dentry)
>   	mmap_write_unlock(info->mm);
>   
>   	/*
> -	 * Is this the last reference? If so, delete mshare region and
> -	 * remove the file
> +	 * Is this the last reference? If so, delete mshare region
>   	 */
> -	if (!refcount_dec_and_test(&info->refcnt)) {
> -		mmput(info->mm);
> -		kfree(info->minfo);
> -		kfree(info);
> -	}
> +	if (refcount_dec_and_test(&info->refcnt))
> +		msharefs_delmm(info);
>   	return 0;
>   }
>   

-- 
Best Regards!
Xin Hao

