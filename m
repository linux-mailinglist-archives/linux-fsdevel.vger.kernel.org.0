Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DA3396A95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 03:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhFABZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 21:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231714AbhFABZ1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 21:25:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EC0E610A1;
        Tue,  1 Jun 2021 01:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622510625;
        bh=tJI6iUgH4WbJL1Ain1qtmC88ZJN93TFAElZ2sjKd3y4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zhgp/24FPdRQOadk7iDa1k61dyyZzMYu6led2E3+OeDYEdb1tJrXVQZEwu+W68Y0h
         QMDV3gDpsHnpZpDT0GNEq3uwuC+Nby97gttsTRJmot2hF5urRncGUuHvfjxYOpQSDz
         hE8i2JpfiKyHzHm1BD8GlngnqIU/um/VQVpDaC0o=
Date:   Mon, 31 May 2021 18:23:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng zhou <zhoufeng.zf@bytedance.com>
Cc:     adobriyan@gmail.com, rppt@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, chenying.kernel@bytedance.com,
        zhengqi.arch@bytedance.com
Subject: Re: [PATCH] fs/proc/kcore.c: add mmap interface
Message-Id: <20210531182344.e9692132981a5bf9bf6d4583@linux-foundation.org>
In-Reply-To: <20210526075142.9740-1-zhoufeng.zf@bytedance.com>
References: <20210526075142.9740-1-zhoufeng.zf@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 26 May 2021 15:51:42 +0800 Feng zhou <zhoufeng.zf@bytedance.com> wrote:

> From: ZHOUFENG <zhoufeng.zf@bytedance.com>
> 
> When we do the kernel monitor, use the DRGN
> (https://github.com/osandov/drgn) access to kernel data structures,
> found that the system calls a lot. DRGN is implemented by reading
> /proc/kcore. After looking at the kcore code, it is found that kcore
> does not implement mmap, resulting in frequent context switching
> triggered by read. Therefore, we want to add mmap interface to optimize
> performance. Since vmalloc and module areas will change with allocation
> and release, consistency cannot be guaranteed, so mmap interface only
> maps KCORE_TEXT and KCORE_RAM.
> 
> ...
>
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -573,11 +573,81 @@ static int release_kcore(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +static vm_fault_t mmap_kcore_fault(struct vm_fault *vmf)
> +{
> +	return VM_FAULT_SIGBUS;
> +}
> +
> +static const struct vm_operations_struct kcore_mmap_ops = {
> +	.fault = mmap_kcore_fault,
> +};
> +
> +static int mmap_kcore(struct file *file, struct vm_area_struct *vma)
> +{
> +	size_t size = vma->vm_end - vma->vm_start;
> +	u64 start, pfn;
> +	int nphdr;
> +	size_t data_offset;
> +	size_t phdrs_len, notes_len;
> +	struct kcore_list *m = NULL;
> +	int ret = 0;
> +
> +	down_read(&kclist_lock);
> +
> +	get_kcore_size(&nphdr, &phdrs_len, &notes_len, &data_offset);
> +
> +	start = kc_offset_to_vaddr(((u64)vma->vm_pgoff << PAGE_SHIFT) -
> +		((data_offset >> PAGE_SHIFT) << PAGE_SHIFT));
> +
> +	list_for_each_entry(m, &kclist_head, list) {
> +		if (start >= m->addr && size <= m->size)
> +			break;
> +	}
> +
> +	if (&m->list == &kclist_head) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (vma->vm_flags & (VM_WRITE | VM_EXEC)) {
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	vma->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
> +	vma->vm_flags |= VM_MIXEDMAP;
> +	vma->vm_ops = &kcore_mmap_ops;
> +
> +	if (kern_addr_valid(start)) {
> +		if (m->type == KCORE_RAM || m->type == KCORE_REMAP)
> +			pfn = __pa(start) >> PAGE_SHIFT;
> +		else if (m->type == KCORE_TEXT)
> +			pfn = __pa_symbol(start) >> PAGE_SHIFT;
> +		else {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		if (remap_pfn_range(vma, vma->vm_start, pfn, size,
> +				vma->vm_page_prot)) {
> +			ret = -EAGAIN;

EAGAIN seems a strange errno for this case.   The mmap manpage says

       EAGAIN The file has been locked, or too much  memory  has  been  locked
              (see setrlimit(2)).


remap_pfn_range() already returns an errno - why not return whatever
that code was?

> +			goto out;
> +		}
> +	} else {
> +		ret = -EFAULT;
> +	}
> +
> +out:
> +	up_read(&kclist_lock);
> +	return ret;
> +}
> +
>  static const struct proc_ops kcore_proc_ops = {
>  	.proc_read	= read_kcore,
>  	.proc_open	= open_kcore,
>  	.proc_release	= release_kcore,
>  	.proc_lseek	= default_llseek,
> +	.proc_mmap	= mmap_kcore,
>  };
>  
>  /* just remember that we have to update kcore */

Otherwise looks OK to me.  Please update the changelog to reflect the
discussion thus far and send a v2?  
