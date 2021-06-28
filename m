Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB7F3B60CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 16:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhF1Oas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 10:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234503AbhF1OaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624890454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LH8UNtD4dgcFZ2cOzBHPmeit1WiRYTLTlJgZddc4rZA=;
        b=DJJ6R3stJjInET9oyjBJBMQGZNsfsBwukwqIoEzPzDduoeHyEm99kxzcfcM1kTIgHwvMPm
        d32uYh53822BKExud2zUF6R/lSHr2zAZH4REtdTZCffl+buXcnPAGgbQ6DjOH/vPQpA3ho
        jXqYb961oq2QjExreBhn0hRuHC3y6VU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-vhDeOqsgOliBweVHyX5tHA-1; Mon, 28 Jun 2021 10:27:30 -0400
X-MC-Unique: vhDeOqsgOliBweVHyX5tHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63DCC800D55;
        Mon, 28 Jun 2021 14:27:28 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-225.rdu2.redhat.com [10.10.115.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6162F5D9DC;
        Mon, 28 Jun 2021 14:27:23 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3427B22054F; Mon, 28 Jun 2021 10:27:23 -0400 (EDT)
Date:   Mon, 28 Jun 2021 10:27:23 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Ming Lin <mlin@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, virtio-fs-list <virtio-fs@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 2/2] mm: adds NOSIGBUS extension to mmap()
Message-ID: <20210628142723.GB1803896@redhat.com>
References: <1622792602-40459-1-git-send-email-mlin@kernel.org>
 <1622792602-40459-3-git-send-email-mlin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622792602-40459-3-git-send-email-mlin@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 04, 2021 at 12:43:22AM -0700, Ming Lin wrote:
> Adds new flag MAP_NOSIGBUS of mmap() to specify the behavior of
> "don't SIGBUS on fault". Right now, this flag is only allowed
> for private mapping.
> 
> For MAP_NOSIGBUS mapping, map in the zero page on read fault
> or fill a freshly allocated page with zeroes on write fault.

I am wondering if this could be of limited use for me if MAP_NOSIGBUS
were to be supported for shared mappings as well.

When virtiofs is run with dax enabled, then it is possible that if
a file is shared between two guests, then one guest truncates the
file and second guest tries to do load/store operation. Given current
kvm architecture, there is no mechanism to propagate SIGBUS to guest
process, instead KVM retries page fault infinitely and guest cpu/process
hangs.

Ideally we want this error to propagate all the way back into the
guest and to the guest process but that solution is not in place yet.

https://lore.kernel.org/kvm/20200406190951.GA19259@redhat.com/

In the absense of a proper solution, one could think of mapping
shared file on host with MAP_NOSIGBUS, and hopefully that means
kvm will be able to resolve fault to a zero filled page and guest
will not hang. But this means that data sharing between two processes
is now broken. Writes by process A will not be visible to process B
in another once this situation happens, IIUC.

So if we were to MAP_NOSIGBUS, guest will not hang but failures resulting
from ftruncate will be silent and will be noticed sometime later. I guess
not exactly a very pleasant scenario...

Thanks
Vivek



> 
> Signed-off-by: Ming Lin <mlin@kernel.org>
> ---
>  arch/parisc/include/uapi/asm/mman.h          |  1 +
>  include/linux/mm.h                           |  2 ++
>  include/linux/mman.h                         |  1 +
>  include/uapi/asm-generic/mman-common.h       |  1 +
>  mm/memory.c                                  | 11 +++++++++++
>  mm/mmap.c                                    |  4 ++++
>  tools/include/uapi/asm-generic/mman-common.h |  1 +
>  7 files changed, 21 insertions(+)
> 
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
> index ab78cba..eecf9af 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -25,6 +25,7 @@
>  #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
>  #define MAP_FIXED_NOREPLACE 0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> +#define MAP_NOSIGBUS	0x200000	/* do not SIGBUS on fault */
>  #define MAP_UNINITIALIZED 0		/* uninitialized anonymous mmap */
>  
>  #define MS_SYNC		1		/* synchronous memory sync */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9e86ca1..100d122 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -373,6 +373,8 @@ int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
>  # define VM_UFFD_MINOR		VM_NONE
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>  
> +#define VM_NOSIGBUS		VM_FLAGS_BIT(38)	/* Do not SIGBUS on fault */
> +
>  /* Bits set in the VMA until the stack is in its final location */
>  #define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
>  
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index b2cbae9..c966b08 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -154,6 +154,7 @@ static inline bool arch_validate_flags(unsigned long flags)
>  	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
>  	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>  	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
> +	       _calc_vm_trans(flags, MAP_NOSIGBUS,   VM_NOSIGBUS  ) |
>  	       arch_calc_vm_flag_bits(flags);
>  }
>  
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index f94f65d..a2a5333 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -29,6 +29,7 @@
>  #define MAP_HUGETLB		0x040000	/* create a huge page mapping */
>  #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
>  #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> +#define MAP_NOSIGBUS		0x200000	/* do not SIGBUS on fault */
>  
>  #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
>  					 * uninitialized */
> diff --git a/mm/memory.c b/mm/memory.c
> index 8d5e583..6b5a897 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3676,6 +3676,17 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>  	}
>  
>  	ret = vma->vm_ops->fault(vmf);
> +	if (unlikely(ret & VM_FAULT_SIGBUS) && (vma->vm_flags & VM_NOSIGBUS)) {
> +		/*
> +		 * For MAP_NOSIGBUS mapping, map in the zero page on read fault
> +		 * or fill a freshly allocated page with zeroes on write fault
> +		 */
> +		ret = do_anonymous_page(vmf);
> +		if (!ret)
> +			ret = VM_FAULT_NOPAGE;
> +		return ret;
> +	}
> +
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
>  			    VM_FAULT_DONE_COW)))
>  		return ret;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 8bed547..d5c9fb5 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1419,6 +1419,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  	if (!len)
>  		return -EINVAL;
>  
> +	/* Restrict MAP_NOSIGBUS to MAP_PRIVATE mapping */
> +	if ((flags & MAP_NOSIGBUS) && !(flags & MAP_PRIVATE))
> +		return -EINVAL;
> +
>  	/*
>  	 * Does the application expect PROT_READ to imply PROT_EXEC?
>  	 *
> diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
> index f94f65d..a2a5333 100644
> --- a/tools/include/uapi/asm-generic/mman-common.h
> +++ b/tools/include/uapi/asm-generic/mman-common.h
> @@ -29,6 +29,7 @@
>  #define MAP_HUGETLB		0x040000	/* create a huge page mapping */
>  #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
>  #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> +#define MAP_NOSIGBUS		0x200000	/* do not SIGBUS on fault */
>  
>  #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
>  					 * uninitialized */
> -- 
> 1.8.3.1
> 

