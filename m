Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9D314472
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 01:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhBIACi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 19:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229707AbhBIACe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612828865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xcZ+yeCeKdV2jRak92LuD28RYXAN2xMEiGah/lbPE24=;
        b=Su/Iw47QLopSA3OU6AdpjBT++Es2aVkxDX8tg9sEwjVd8XL7LtXDbwCVlrbwyvT4yUOsIZ
        elTcLp3kh0Jg3GSbrDHthvBIwyHt9NSYnnRRtrF00WTOQzyoTwzO3D7ni79PpYepToQbpy
        s+1UcG0QbLarsdZFRdEC8w5n2YmMPPA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-ZMX2gdjUORKz89HZ71S1pA-1; Mon, 08 Feb 2021 19:01:02 -0500
X-MC-Unique: ZMX2gdjUORKz89HZ71S1pA-1
Received: by mail-qk1-f200.google.com with SMTP id r15so5080361qke.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 16:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xcZ+yeCeKdV2jRak92LuD28RYXAN2xMEiGah/lbPE24=;
        b=mEx1NHujTN9srSkhf/m+NdutxRhjTmJvuUyDL0By2w72vtxtZeZ4v+1sEDKDAU3v8I
         E8K6ksVAg4HBfhmdCK5KctrUXKmezTH3s0uxsYOVerieCRsqrIsS84zdD9/Is/J51cgR
         89u3j5xJuT9VQMWlaGrxXJNmZ0SIPAOmeRwekH+U5hpxqlyOPg2T4xa/y1fEiwFUw7W+
         JG+QqVlHZ5Af5ZXJ8kablSoiBOO4pzxvEzrbPstrQY6DcqsXJb3agIa+AyKFdI8VBYZV
         oY5+LZZaZWlzce9DEJrGpxuhKvdm7l7B7lsuPhK3JdPa6QrGepzsjSTG9EgJ5xT0j4l7
         dTmQ==
X-Gm-Message-State: AOAM533d+h8SOXiJ9CgUopcMT7amafd07OuSf4+z6P0udcDQ/GYUWSfN
        ib1i08/6N3+NiTP2bqa3IUuQudWlj6JZFvsq2+pxzxgXa3bTqp3gcsxo3exX1nQJIJz90J1XXtw
        u+VGFSkSoSSYvEeeqYbys98QQEg==
X-Received: by 2002:a0c:8365:: with SMTP id j92mr18642868qva.19.1612828861682;
        Mon, 08 Feb 2021 16:01:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwdJLdWaHbVrmWjJHQTdvfqr10RsoH69jk6l+AH5Y/5B1w0vnsBBKgJ9zss03AZxS1edcY2w==
X-Received: by 2002:a0c:8365:: with SMTP id j92mr18642830qva.19.1612828861397;
        Mon, 08 Feb 2021 16:01:01 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id j46sm5936461qtk.1.2021.02.08.16.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 16:01:00 -0800 (PST)
Date:   Mon, 8 Feb 2021 19:00:58 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 05/10] userfaultfd: add minor fault registration mode
Message-ID: <20210209000058.GA78818@xz-x1>
References: <20210204183433.1431202-1-axelrasmussen@google.com>
 <20210204183433.1431202-6-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204183433.1431202-6-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:34:28AM -0800, Axel Rasmussen wrote:
> This feature allows userspace to intercept "minor" faults. By "minor"
> faults, I mean the following situation:
> 
> Let there exist two mappings (i.e., VMAs) to the same page(s). One of
> the mappings is registered with userfaultfd (in minor mode), and the
> other is not. Via the non-UFFD mapping, the underlying pages have
> already been allocated & filled with some contents. The UFFD mapping
> has not yet been faulted in; when it is touched for the first time,
> this results in what I'm calling a "minor" fault. As a concrete
> example, when working with hugetlbfs, we have huge_pte_none(), but
> find_lock_page() finds an existing page.
> 
> This commit adds the new registration mode, and sets the relevant flag
> on the VMAs being registered. In the hugetlb fault path, if we find
> that we have huge_pte_none(), but find_lock_page() does indeed find an
> existing page, then we have a "minor" fault, and if the VMA has the
> userfaultfd registration flag, we call into userfaultfd to handle it.
> 
> Why add a new registration mode, as opposed to adding a feature to
> MISSING registration, like UFFD_FEATURE_SIGBUS?
> 
> - The semantics are significantly different. UFFDIO_COPY or
>   UFFDIO_ZEROPAGE do not make sense for these minor faults; userspace
>   would instead just memset() or memcpy() or whatever via the non-UFFD
>   mapping. Unlike MISSING registration, MINOR registration only makes
>   sense for hugetlbfs (or, in the future, shmem), as this is the only
>   way to get two VMAs to a single set of underlying pages.
> 
> - Doing so would make handle_userfault()'s "reason" argument confusing.
>   We'd pass in "MISSING" even if the pages weren't really missing.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  fs/proc/task_mmu.c               |  1 +
>  fs/userfaultfd.c                 | 81 ++++++++++++++++++++------------
>  include/linux/mm.h               |  1 +
>  include/linux/userfaultfd_k.h    | 15 +++++-
>  include/trace/events/mmflags.h   |  1 +
>  include/uapi/linux/userfaultfd.h | 15 +++++-
>  mm/hugetlb.c                     | 32 +++++++++++++
>  7 files changed, 112 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 602e3a52884d..94e951ea3e03 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -651,6 +651,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_MTE)]		= "mt",
>  		[ilog2(VM_MTE_ALLOWED)]	= "",
>  #endif
> +		[ilog2(VM_UFFD_MINOR)]	= "ui",
>  #ifdef CONFIG_ARCH_HAS_PKEYS
>  		/* These come out via ProtectionKey: */
>  		[ilog2(VM_PKEY_BIT0)]	= "",
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index a0f66e12026b..c643cf13d957 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -197,24 +197,21 @@ static inline struct uffd_msg userfault_msg(unsigned long address,
>  	msg_init(&msg);
>  	msg.event = UFFD_EVENT_PAGEFAULT;
>  	msg.arg.pagefault.address = address;
> +	/*
> +	 * These flags indicate why the userfault occurred:
> +	 * - UFFD_PAGEFAULT_FLAG_WP indicates a write protect fault.
> +	 * - UFFD_PAGEFAULT_FLAG_MINOR indicates a minor fault.
> +	 * - Neither of these flags being set indicates a MISSING fault.
> +	 *
> +	 * Separately, UFFD_PAGEFAULT_FLAG_WRITE indicates it was a write
> +	 * fault. Otherwise, it was a read fault.
> +	 */
>  	if (flags & FAULT_FLAG_WRITE)
> -		/*
> -		 * If UFFD_FEATURE_PAGEFAULT_FLAG_WP was set in the
> -		 * uffdio_api.features and UFFD_PAGEFAULT_FLAG_WRITE
> -		 * was not set in a UFFD_EVENT_PAGEFAULT, it means it
> -		 * was a read fault, otherwise if set it means it's
> -		 * a write fault.
> -		 */
>  		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_WRITE;
>  	if (reason & VM_UFFD_WP)
> -		/*
> -		 * If UFFD_FEATURE_PAGEFAULT_FLAG_WP was set in the
> -		 * uffdio_api.features and UFFD_PAGEFAULT_FLAG_WP was
> -		 * not set in a UFFD_EVENT_PAGEFAULT, it means it was
> -		 * a missing fault, otherwise if set it means it's a
> -		 * write protect fault.
> -		 */
>  		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_WP;
> +	if (reason & VM_UFFD_MINOR)
> +		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_MINOR;
>  	if (features & UFFD_FEATURE_THREAD_ID)
>  		msg.arg.pagefault.feat.ptid = task_pid_vnr(current);
>  	return msg;
> @@ -401,8 +398,10 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  
>  	BUG_ON(ctx->mm != mm);
>  
> -	VM_BUG_ON(reason & ~(VM_UFFD_MISSING|VM_UFFD_WP));
> -	VM_BUG_ON(!(reason & VM_UFFD_MISSING) ^ !!(reason & VM_UFFD_WP));
> +	/* Any unrecognized flag is a bug. */
> +	VM_BUG_ON(reason & ~__VM_UFFD_FLAGS);
> +	/* 0 or > 1 flags set is a bug; we expect exactly 1. */
> +	VM_BUG_ON(!reason || !!(reason & (reason - 1)));
>  
>  	if (ctx->features & UFFD_FEATURE_SIGBUS)
>  		goto out;
> @@ -612,7 +611,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
>  		for (vma = mm->mmap; vma; vma = vma->vm_next)
>  			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
>  				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> -				vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
> +				vma->vm_flags &= ~__VM_UFFD_FLAGS;
>  			}
>  		mmap_write_unlock(mm);
>  
> @@ -644,7 +643,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
>  	octx = vma->vm_userfaultfd_ctx.ctx;
>  	if (!octx || !(octx->features & UFFD_FEATURE_EVENT_FORK)) {
>  		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> -		vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
> +		vma->vm_flags &= ~__VM_UFFD_FLAGS;
>  		return 0;
>  	}
>  
> @@ -726,7 +725,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
>  	} else {
>  		/* Drop uffd context if remap feature not enabled */
>  		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> -		vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
> +		vma->vm_flags &= ~__VM_UFFD_FLAGS;
>  	}
>  }
>  
> @@ -867,12 +866,12 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
>  	for (vma = mm->mmap; vma; vma = vma->vm_next) {
>  		cond_resched();
>  		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
> -		       !!(vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP)));
> +		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
>  		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
>  			prev = vma;
>  			continue;
>  		}
> -		new_flags = vma->vm_flags & ~(VM_UFFD_MISSING | VM_UFFD_WP);
> +		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
>  		prev = vma_merge(mm, prev, vma->vm_start, vma->vm_end,
>  				 new_flags, vma->anon_vma,
>  				 vma->vm_file, vma->vm_pgoff,
> @@ -1305,9 +1304,29 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
>  				     unsigned long vm_flags)
>  {
>  	/* FIXME: add WP support to hugetlbfs and shmem */
> -	return vma_is_anonymous(vma) ||
> -		((is_vm_hugetlb_page(vma) || vma_is_shmem(vma)) &&
> -		 !(vm_flags & VM_UFFD_WP));
> +	if (vm_flags & VM_UFFD_WP) {
> +		if (is_vm_hugetlb_page(vma) || vma_is_shmem(vma))
> +			return false;
> +	}
> +
> +	if (vm_flags & VM_UFFD_MINOR) {
> +		/*
> +		 * The use case for minor registration (intercepting minor
> +		 * faults) is to handle the case where a page is present, but
> +		 * needs to be modified before it can be used. This only makes
> +		 * sense when you have two mappings to the same underlying
> +		 * pages (one UFFD registered, one not), but the memory doesn't
> +		 * have to be shared (consider one process mapping a hugetlbfs
> +		 * file with MAP_SHARED, and then a second process doing
> +		 * MAP_PRIVATE).

No strong opinion, but I'd drop the whole chunk of comment here..

  - "what is minor fault" should be covered in the documentation file already.

  - "two mappings" seems slightly superfluous too, since we can still use minor
    fault with TRUNCATE+UFFDIO_COPY.. if we want?  maybe?

  - "memory doesn't have to be shared" would be a bit odd too if saying that
    without any code checking against "shared" at all, I'd say. :)

The FIXME below it is fine.

If you agree with above, feel free to add my r-b after dropping the chunk:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

