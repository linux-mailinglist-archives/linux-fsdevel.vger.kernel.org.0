Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26C6231F9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 15:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgG2NwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 09:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2NwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:52:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F128BC0619D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2020 06:52:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b25so25125782ljp.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2020 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vZeNQ+iiCwWzXjAeoFQG66schI6SvuftYi0LkEr2cOQ=;
        b=D4ZADIMq/Zf/TiBR5zApy8337AMqaTcA6A7EDGwJbdAPA9icr/Leu5VFwHzs5FS+B6
         DRmIKmxJjO4So6GiWlw2cPAnkZ7pet9jdgXnNk9DS5vFDWZfz/BfDkSmA0SiNQEtRy9D
         1oIN8X4/uEWRQh8GvmWn1gQWaFwSEY1r4a67nTBV3mvb/TAfzdnQmmiDmQF1CIPLYiRh
         8Ycd5cEYYSuUcvKeVtk4yaiPYP6vmMPi/jsetZp8Du2PXTIhMh4jhz3k7AUUUyLZRI67
         sjhy42ARHn25SScPw0GYbhkMi2jrthWsplTM3fZTZXgBwN5/VcV85qAXp/wx895cYjfg
         19kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vZeNQ+iiCwWzXjAeoFQG66schI6SvuftYi0LkEr2cOQ=;
        b=Mak4+gx+ZAXwaZqyDz7LKMG4M6J8APPvlmwBMQk3nXAteU/diXLpReVsXAicubMLtB
         pZT+CEjUsTh+GpQxuJnIgVEAwv7EsWBl4GnGwe6qJ3x7xSlfEo1GXYEzHhgNnH0FvDc7
         H9A1kCEWUZyBSlMT1v1xyy0mXBfS7JkYmcmJZde1C+M8pSg0Let7cEH+WTq9PQICkv9W
         KEQEjR5DbExHFCcqPmISNS9UTTYk9TpyRu7UC7gqRUYkx0dplKnJ3YjCuoj2SLj3lNzM
         p6yRSD2QIwE254maDwi0r85T/GIVENVGoed0pp3gcLZRasy4DmCurxTE2jK99SqQ8Bsu
         PUyg==
X-Gm-Message-State: AOAM530TUIY2/mcKl81GePNYZXBDBp6yL8K6MeqiI70+q7MLX8yAVrTe
        nL/nRcxv9d4MpY1ULpA/F+2tKQ==
X-Google-Smtp-Source: ABdhPJxmLCkdUbuAiTwivH0x2J4IUTNnDZU8ZEzfYr72S6djYoEeZ9QKizudugE2jgVV5k24ko8Y8g==
X-Received: by 2002:a2e:3304:: with SMTP id d4mr13469676ljc.115.1596030728274;
        Wed, 29 Jul 2020 06:52:08 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x205sm467945lfa.96.2020.07.29.06.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 06:52:07 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 899A8102080; Wed, 29 Jul 2020 16:52:11 +0300 (+03)
Date:   Wed, 29 Jul 2020 16:52:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        gerg@linux-m68k.org, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
Subject: Re: [RFC PATCH 3/5] mm: introduce VM_EXEC_KEEP
Message-ID: <20200729135211.zodforvnv2xvdchm@box>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <1595869887-23307-4-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595869887-23307-4-git-send-email-anthony.yznaga@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:11:25AM -0700, Anthony Yznaga wrote:
> A vma with the VM_EXEC_KEEP flag is preserved across exec.  For anonymous
> vmas only.  For safety, overlap with fixed address VMAs created in the new
> mm during exec (e.g. the stack and elf load segments) is not permitted and
> will cause the exec to fail.
> (We are studying how to guarantee there are no conflicts. Comments welcome.)
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  arch/x86/Kconfig   |  1 +
>  fs/exec.c          | 20 ++++++++++++++++++++
>  include/linux/mm.h |  5 +++++
>  kernel/fork.c      |  2 +-
>  mm/mmap.c          | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 883da0abf779..fc36eb2f45c0 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -30,6 +30,7 @@ config X86_64
>  	select MODULES_USE_ELF_RELA
>  	select NEED_DMA_MAP_STATE
>  	select SWIOTLB
> +	select ARCH_USES_HIGH_VMA_FLAGS
>  
>  config FORCE_DYNAMIC_FTRACE
>  	def_bool y
> diff --git a/fs/exec.c b/fs/exec.c
> index 262112e5f9f8..1de09c4eef00 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1069,6 +1069,20 @@ ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
>  EXPORT_SYMBOL(read_code);
>  #endif
>  
> +static int vma_dup_some(struct mm_struct *old_mm, struct mm_struct *new_mm)
> +{
> +	struct vm_area_struct *vma;
> +	int ret;
> +
> +	for (vma = old_mm->mmap; vma; vma = vma->vm_next)
> +		if (vma->vm_flags & VM_EXEC_KEEP) {
> +			ret = vma_dup(vma, new_mm);
> +			if (ret)
> +				return ret;
> +		}
> +	return 0;
> +}
> +
>  /*
>   * Maps the mm_struct mm into the current task struct.
>   * On success, this function returns with the mutex
> @@ -1104,6 +1118,12 @@ static int exec_mmap(struct mm_struct *mm)
>  			mutex_unlock(&tsk->signal->exec_update_mutex);
>  			return -EINTR;
>  		}
> +		ret = vma_dup_some(old_mm, mm);
> +		if (ret) {
> +			mmap_read_unlock(old_mm);
> +			mutex_unlock(&tsk->signal->exec_update_mutex);
> +			return ret;
> +		}
>  	}
>  
>  	task_lock(tsk);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dc7b87310c10..1c538ba77f33 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -295,11 +295,15 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
>  #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
> +#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
>  #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
>  #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
>  #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
>  #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
> +#define VM_EXEC_KEEP	BIT(VM_HIGH_ARCH_BIT_5)	/* preserve VMA across exec */
> +#else
> +#define VM_EXEC_KEEP	VM_NONE
>  #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
>  
>  #ifdef CONFIG_ARCH_HAS_PKEYS
> @@ -2534,6 +2538,7 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
>  	unsigned long addr, unsigned long len, pgoff_t pgoff,
>  	bool *need_rmap_locks);
>  extern void exit_mmap(struct mm_struct *);
> +extern int vma_dup(struct vm_area_struct *vma, struct mm_struct *mm);
>  
>  static inline int check_data_rlimit(unsigned long rlim,
>  				    unsigned long new,
> diff --git a/kernel/fork.c b/kernel/fork.c
> index efc5493203ae..15ead613714f 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -564,7 +564,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  			tmp->anon_vma = NULL;
>  		} else if (anon_vma_fork(tmp, mpnt))
>  			goto fail_nomem_anon_vma_fork;
> -		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
> +		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT | VM_EXEC_KEEP);
>  		file = tmp->vm_file;
>  		if (file) {
>  			struct inode *inode = file_inode(file);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 59a4682ebf3f..be2ff53743c3 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3279,6 +3279,53 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  	return NULL;
>  }
>  
> +int vma_dup(struct vm_area_struct *old_vma, struct mm_struct *mm)
> +{
> +	unsigned long npages;
> +	struct mm_struct *old_mm = old_vma->vm_mm;
> +	struct vm_area_struct *vma;
> +	int ret = -ENOMEM;
> +
> +	if (WARN_ON(old_vma->vm_file || old_vma->vm_ops))
> +		return -EINVAL;
> +
> +	vma = find_vma(mm, old_vma->vm_start);
> +	if (vma && vma->vm_start < old_vma->vm_end)
> +		return -EEXIST;
> +
> +	npages = vma_pages(old_vma);
> +	mm->total_vm += npages;

Why only total_vm? Where's exec_vm/stack_vm/data_vm?

> +
> +	vma = vm_area_dup(old_vma);
> +	if (!vma)
> +		goto fail_nomem;
> +
> +	ret = vma_dup_policy(old_vma, vma);
> +	if (ret)
> +		goto fail_nomem_policy;
> +
> +	vma->vm_mm = mm;
> +	ret = anon_vma_fork(vma, old_vma);
> +	if (ret)
> +		goto fail_nomem_anon_vma_fork;

Looks like a duplication of code form dup_mmap().
Any chance to get in one place?

> +	vma->vm_flags &= ~(VM_LOCKED|VM_UFFD_MISSING|VM_UFFD_WP|VM_EXEC_KEEP);
> +	vma->vm_next = vma->vm_prev = NULL;

No need. vm_area_dup() takes care of it.

> +	vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;

Semantics of VM_EXEC_KEEP vs userfaultfd() deserves a detailed explanation.
I feel these flags has to be mutually exclusive.

> +	if (is_vm_hugetlb_page(vma))
> +		reset_vma_resv_huge_pages(vma);
> +	__insert_vm_struct(mm, vma);
> +	ret = copy_page_range(mm, old_mm, old_vma);
> +	return ret;
> +
> +fail_nomem_anon_vma_fork:
> +	mpol_put(vma_policy(vma));
> +fail_nomem_policy:
> +	vm_area_free(vma);
> +fail_nomem:
> +	return -ENOMEM;
> +}
> +
>  /*
>   * Return true if the calling process may expand its vm space by the passed
>   * number of pages
> -- 
> 1.8.3.1
> 
> 

-- 
 Kirill A. Shutemov
