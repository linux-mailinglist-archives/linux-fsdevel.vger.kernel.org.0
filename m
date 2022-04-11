Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6B04FC45B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 20:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349245AbiDKSvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiDKSvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:51:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8DB1FCDB;
        Mon, 11 Apr 2022 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649702932; x=1681238932;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=b4wiCyyYds1owaETv9OxFFgKgfgqtdWoP+ud52IuXKQ=;
  b=dFu/eLmKzQkjZW7cGj8HWb07fdaJbzeAYFUox7UfRen8Aa6hScFLcC8/
   3MHJJc14PbggnRyw0qS+9ofFhNYas+LVs5ZwowK2QdpAtuecNlUwqBl0K
   dazYKDA63IEe67GspRaPOjrqKt/DJySNQFb0UpsAZQkoxfWBuCa0C7IL7
   7ljjhX7job5D/7bkmWemEATYsMvphB3I4hAHfGkDW94YWA1FxFBcdK+e2
   pLYXw9Vqj4JwMZzs+u5gs4dnsubFgHb/utTCiO6EYG5OartDMW+HehMls
   9yIheAQvZLNafKks2jjvszXh97wDbFQpU/cJvXlnsDvoCE12ONnpexDwr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242776536"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="242776536"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 11:48:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="572338410"
Received: from minhjohn-mobl.amr.corp.intel.com (HELO [10.212.44.201]) ([10.212.44.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 11:48:50 -0700
Message-ID: <86956aa9-36be-b637-8e58-14eb0167b751@intel.com>
Date:   Mon, 11 Apr 2022 11:48:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
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
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <5c96dd165d7ec3da14306b8fd857c7eb95a8c3e6.1649370874.git.khalid.aziz@oracle.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v1 08/14] mm/mshare: Add basic page table sharing using
 mshare
In-Reply-To: <5c96dd165d7ec3da14306b8fd857c7eb95a8c3e6.1649370874.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/11/22 09:05, Khalid Aziz wrote:
> This patch adds basic page table sharing across tasks by making
> mshare syscall. It does this by creating a new mm_struct which
> hosts the shared vmas and page tables. This mm_struct is
> maintained as long as there is at least one task using the mshare'd
> range. It is cleaned up by the last mshare_unlink syscall.

This sounds like a really good idea because it (in theory) totally
separates the lifetime of the *source* of the page tables from the
lifetime of the process that creates the mshare.

> diff --git a/mm/internal.h b/mm/internal.h
> index cf50a471384e..68f82f0f8b66 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -718,6 +718,8 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
>  int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
>  		      unsigned long addr, int page_nid, int *flags);
>  
> +extern vm_fault_t find_shared_vma(struct vm_area_struct **vma,
> +			unsigned long *addrp);
>  static inline bool vma_is_shared(const struct vm_area_struct *vma)
>  {
>  	return vma->vm_flags & VM_SHARED_PT;
> diff --git a/mm/memory.c b/mm/memory.c
> index c125c4969913..c77c0d643ea8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4776,6 +4776,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  			   unsigned int flags, struct pt_regs *regs)
>  {
>  	vm_fault_t ret;
> +	bool shared = false;
>  
>  	__set_current_state(TASK_RUNNING);
>  
> @@ -4785,6 +4786,15 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  	/* do counter updates before entering really critical section. */
>  	check_sync_rss_stat(current);
>  
> +	if (unlikely(vma_is_shared(vma))) {
> +		ret = find_shared_vma(&vma, &address);
> +		if (ret)
> +			return ret;
> +		if (!vma)
> +			return VM_FAULT_SIGSEGV;
> +		shared = true;
> +	}
> +
>  	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
>  					    flags & FAULT_FLAG_INSTRUCTION,
>  					    flags & FAULT_FLAG_REMOTE))
> @@ -4802,6 +4812,31 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  	else
>  		ret = __handle_mm_fault(vma, address, flags);
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
> +			mmap_read_unlock(current->mm);
> +	}

Are we guaranteed that current->mm == the original vma->vm_mm?  Just a
quick scan of handle_mm_fault() users shows a few suspect ones like
hmm_range_fault() or iommu_v2.c::do_fault().

> diff --git a/mm/mshare.c b/mm/mshare.c
> index cd2f7ad24d9d..d1896adcb00f 100644
> --- a/mm/mshare.c
> +++ b/mm/mshare.c
> @@ -17,18 +17,49 @@
>  #include <linux/pseudo_fs.h>
>  #include <linux/fileattr.h>
>  #include <linux/refcount.h>
> +#include <linux/mman.h>
>  #include <linux/sched/mm.h>
>  #include <uapi/linux/magic.h>
>  #include <uapi/linux/limits.h>
>  
>  struct mshare_data {
> -	struct mm_struct *mm;
> +	struct mm_struct *mm, *host_mm;
>  	mode_t mode;
>  	refcount_t refcnt;
>  };
>  
>  static struct super_block *msharefs_sb;
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
> +	host_addr = *addrp - guest->vm_start + host_mm->mmap_base;
> +	pgd = pgd_offset(host_mm, host_addr);
> +	guest_pgd = pgd_offset(current->mm, *addrp);
> +	if (!pgd_same(*guest_pgd, *pgd)) {
> +		set_pgd(guest_pgd, *pgd);
> +		return VM_FAULT_NOPAGE;
> +	}

Is digging around in the other process's page tables OK without holding
any locks?

> +	*addrp = host_addr;
> +	mmap_read_lock(host_mm);
> +	vma = find_vma(host_mm, host_addr);
> +
> +	/* XXX: expand stack? */
> +	if (vma && vma->vm_start > host_addr)
> +		vma = NULL;
> +
> +	*vmap = vma;
> +	return 0;
> +}
> +
>  static void
>  msharefs_evict_inode(struct inode *inode)
>  {
> @@ -169,11 +200,13 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>  		unsigned long, len, int, oflag, mode_t, mode)
>  {
>  	struct mshare_data *info;
> -	struct mm_struct *mm;
>  	struct filename *fname = getname(name);
>  	struct dentry *dentry;
>  	struct inode *inode;
>  	struct qstr namestr;
> +	struct vm_area_struct *vma, *next, *new_vma;
> +	struct mm_struct *new_mm;
> +	unsigned long end;
>  	int err = PTR_ERR(fname);
>  
>  	/*
> @@ -193,6 +226,8 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>  	if (IS_ERR(fname))
>  		goto err_out;
>  
> +	end = addr + len;
> +
>  	/*
>  	 * Does this mshare entry exist already? If it does, calling
>  	 * mshare with O_EXCL|O_CREAT is an error
> @@ -205,49 +240,165 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>  	inode_lock(d_inode(msharefs_sb->s_root));
>  	dentry = d_lookup(msharefs_sb->s_root, &namestr);
>  	if (dentry && (oflag & (O_EXCL|O_CREAT))) {
> +		inode = d_inode(dentry);
>  		err = -EEXIST;
>  		dput(dentry);
>  		goto err_unlock_inode;
>  	}
>  
>  	if (dentry) {
> +		unsigned long mapaddr, prot = PROT_NONE;
> +
>  		inode = d_inode(dentry);
>  		if (inode == NULL) {
> +			mmap_write_unlock(current->mm);
>  			err = -EINVAL;
>  			goto err_out;
>  		}
>  		info = inode->i_private;
> -		refcount_inc(&info->refcnt);
>  		dput(dentry);
> +
> +		/*
> +		 * Map in the address range as anonymous mappings
> +		 */
> +		oflag &= (O_RDONLY | O_WRONLY | O_RDWR);
> +		if (oflag & O_RDONLY)
> +			prot |= PROT_READ;
> +		else if (oflag & O_WRONLY)
> +			prot |= PROT_WRITE;
> +		else if (oflag & O_RDWR)
> +			prot |= (PROT_READ | PROT_WRITE);
> +		mapaddr = vm_mmap(NULL, addr, len, prot,
> +				MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, 0);
> +		if (IS_ERR((void *)mapaddr)) {
> +			err = -EINVAL;
> +			goto err_out;
> +		}
> +
> +		refcount_inc(&info->refcnt);
> +
> +		/*
> +		 * Now that we have mmap'd the mshare'd range, update vma
> +		 * flags and vm_mm pointer for this mshare'd range.
> +		 */
> +		mmap_write_lock(current->mm);
> +		vma = find_vma(current->mm, addr);
> +		if (vma && vma->vm_start < addr) {
> +			mmap_write_unlock(current->mm);
> +			err = -EINVAL;
> +			goto err_out;
> +		}

How do you know that this is the same anonymous VMA that you set up
above?  Couldn't it have been unmapped and remapped to be something
random before the mmap_write_lock() is reacquired?

> +		while (vma && vma->vm_start < (addr + len)) {
> +			vma->vm_private_data = info;
> +			vma->vm_mm = info->mm;
> +			vma->vm_flags |= VM_SHARED_PT;
> +			next = vma->vm_next;
> +			vma = next;
> +		}

This vma is still in the mm->mm_rb tree, right?  I'm kinda surprised
that it's OK to have a VMA in mm->vm_rb have vma->vm_mm!=mm.

>  	} else {
> -		mm = mm_alloc();
> -		if (!mm)
> +		unsigned long myaddr;
> +		struct mm_struct *old_mm;
> +
> +		old_mm = current->mm;
> +		new_mm = mm_alloc();
> +		if (!new_mm)
>  			return -ENOMEM;
>  		info = kzalloc(sizeof(*info), GFP_KERNEL);
>  		if (!info) {
>  			err = -ENOMEM;
>  			goto err_relmm;
>  		}
> -		mm->mmap_base = addr;
> -		mm->task_size = addr + len;
> -		if (!mm->task_size)
> -			mm->task_size--;
> -		info->mm = mm;
> +		new_mm->mmap_base = addr;
> +		new_mm->task_size = addr + len;
> +		if (!new_mm->task_size)
> +			new_mm->task_size--;
> +		info->mm = new_mm;
> +		info->host_mm = old_mm;
>  		info->mode = mode;
>  		refcount_set(&info->refcnt, 1);
> +
> +		/*
> +		 * VMAs for this address range may or may not exist.
> +		 * If VMAs exist, they should be marked as shared at
> +		 * this point and page table info should be copied
> +		 * over to newly created mm_struct. TODO: If VMAs do not
> +		 * exist, create them and mark them as shared.
> +		 */

At this point, there are just too many TODO's in this series to look at
it seriously.  I think what you have here is an entertaining
proof-of-concept, but it's looking to me to be obviously still RFC
quality.  Do you seriously think anyone could even *think* about
applying this series at this point?

