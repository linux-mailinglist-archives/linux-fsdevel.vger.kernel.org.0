Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59593996A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 02:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhFCAH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 20:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFCAH0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:07:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54D5C613E7;
        Thu,  3 Jun 2021 00:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622678742;
        bh=TtQqRvmnABCXwzNCvY4Sr+kkdewQDVf/VDvbiAiSo5c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CC13/UOgfauAzqtzZ3D4nwEQtKuZVeOcJXovzgSTBFcexfAdU36LUzMtmR2hb0tt6
         /gdjPuVghRRyM8H5zTbkdWuhWOo3jjhtsXHYq0vWLj5qGY36C23+RYdhWcRr9+gCYh
         U4Xtd1zz8MKu629Og/ggRUeJtPy4wL4h18WsEbyEk6iNi+7DjXJGPsqO5Warf2GieR
         wKgdZrf70pquGL4hyQKlbYQAyTBZ1SnFPICb8tvCW6EkfApmqgI4y9xEY5an2X+ZnL
         4h0zvJ8flBbYSXAAti098zF+L/MrJ1iSE4UsZSIlNYvSGmwE5C5MBcQHP8Gb8C7Bw6
         PM4hQMh2PErMg==
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem
 read
To:     Hugh Dickins <hughd@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Simon Ser <contact@emersion.fr>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <1622589753-9206-1-git-send-email-mlin@kernel.org>
 <1622589753-9206-3-git-send-email-mlin@kernel.org>
 <alpine.LSU.2.11.2106011913590.3353@eggly.anvils>
From:   Ming Lin <mlin@kernel.org>
Message-ID: <79a27014-5450-1345-9eea-12fc9ae25777@kernel.org>
Date:   Wed, 2 Jun 2021 17:05:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2106011913590.3353@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/1/2021 8:49 PM, Hugh Dickins wrote:

>> index 096bba4..69cd856 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -1419,6 +1419,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>>   	if (!len)
>>   		return -EINVAL;
>>   
>> +	if ((flags & MAP_NOSIGBUS) && ((prot & PROT_WRITE) || !shmem_file(file)))
>> +		return -EINVAL;
>> +
> 
> No, for several reasons.
> 
> This has nothing to do with shmem really, that's just where this patch
> hacks it in - and where you have a first user in mind.  If this goes
> forward, please modify mm/memory.c not mm/shmem.c, to make
> VM_FAULT_SIGBUS on fault to VM_NOSIGBUS vma do the mapping of zero page.
> 
> (prot & PROT_WRITE) tells you about the mmap() flags, but says nothing
> about what mprotect() could do later on.  Look out for VM_SHARED and
> VM_MAYSHARE and VM_MAYWRITE further down; and beware the else (!file)
> block below them, shared anonymous would need more protection too.
> 
> Constructive comment: I guess much of my objection to this feature
> comes from allowing it in the MAP_SHARED case.  If you restrict it
> to MAP_PRIVATE mapping of file, then it's less objectionable, and
> you won't have to worry (so much?) about write protection.  Copy
> on write is normal there, and it's well established that subsequent
> changes in the file will not be shared; you'd just be extending that
> behaviour from writes to sigbusy reads.
> 
> And by restricting to MAP_PRIVATE, you would allow for adding a
> proper MAP_SHARED implementation later, if it's thought useful
> (that being the implementation which can subsequently unmap a
> zero page to let new page cache be mapped).

This is what I wrote so far.

---
  include/linux/mm.h                     |  2 ++
  include/linux/mman.h                   |  1 +
  include/uapi/asm-generic/mman-common.h |  1 +
  mm/memory.c                            | 12 ++++++++++++
  mm/mmap.c                              |  4 ++++
  5 files changed, 20 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e9d67bc..af9e277 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -373,6 +373,8 @@ int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
  # define VM_UFFD_MINOR		VM_NONE
  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
  
+#define VM_NOSIGBUS		VM_FLAGS_BIT(38)	/* Do not SIGBUS on fault */
+
  /* Bits set in the VMA until the stack is in its final location */
  #define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
  
diff --git a/include/linux/mman.h b/include/linux/mman.h
index b2cbae9..c966b08 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -154,6 +154,7 @@ static inline bool arch_validate_flags(unsigned long flags)
  	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
  	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
  	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
+	       _calc_vm_trans(flags, MAP_NOSIGBUS,   VM_NOSIGBUS  ) |
  	       arch_calc_vm_flag_bits(flags);
  }
  
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index f94f65d..a2a5333 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -29,6 +29,7 @@
  #define MAP_HUGETLB		0x040000	/* create a huge page mapping */
  #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
  #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+#define MAP_NOSIGBUS		0x200000	/* do not SIGBUS on fault */
  
  #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
  					 * uninitialized */
diff --git a/mm/memory.c b/mm/memory.c
index eff2a47..7195dac 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3676,6 +3676,18 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
  	}
  
  	ret = vma->vm_ops->fault(vmf);
+	if (unlikely(ret & VM_FAULT_SIGBUS) && (vma->vm_flags & VM_NOSIGBUS)) {
+		/*
+		 * Get zero page for MAP_NOSIGBUS mapping, which isn't
+		 * coherent wrt shmem contents that are expanded and
+		 * filled in later.
+		 */
+		vma->vm_flags |= VM_MIXEDMAP;
+		if (!vm_insert_page(vma, (unsigned long)vmf->address,
+				ZERO_PAGE(vmf->address)))
+			return VM_FAULT_NOPAGE;
+	}
+
  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
  			    VM_FAULT_DONE_COW)))
  		return ret;
diff --git a/mm/mmap.c b/mm/mmap.c
index 096bba4..74fb49a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1419,6 +1419,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
  	if (!len)
  		return -EINVAL;
  
+	/* Restrict MAP_NOSIGBUS to MAP_PRIVATE mapping */
+	if ((flags & MAP_NOSIGBUS) && !(flags & MAP_PRIVATE))
+		return -EINVAL;
+
  	/*
  	 * Does the application expect PROT_READ to imply PROT_EXEC?
  	 *

> 
>>   	/*
>>   	 * Does the application expect PROT_READ to imply PROT_EXEC?
>>   	 *
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 5d46611..5d15b08 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1812,7 +1812,22 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>>   repeat:
>>   	if (sgp <= SGP_CACHE &&
>>   	    ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode)) {
>> -		return -EINVAL;
>> +		if (!vma || !(vma->vm_flags & VM_NOSIGBUS))
>> +			return -EINVAL;
>> +
>> +		vma->vm_flags |= VM_MIXEDMAP;
> 
> No.  Presumably you hit the BUG_ON(mmap_read_trylock(vma->vm_mm))
> in vm_insert_page(), so decided to modify the vm_flags here: no,
> that BUG is saying you need mmap_write_lock() to write vm_flags.

But the comments above vm_insert_page() told me to set VM_MIXEDMAP on vma

  * Usually this function is called from f_op->mmap() handler
  * under mm->mmap_lock write-lock, so it can change vma->vm_flags.
  * Caller must set VM_MIXEDMAP on vma if it wants to call this
  * function from other places, for example from page-fault handler.

> 
> One other thing while it crosses my mind.  You'll need to decide
> what truncating or hole-punching the file does to the zero pages
> in its userspace mappings.  I may turn out wrong, but I think you'll
> find that truncation removes them, but hole-punch leaves them, and
> ought to be modified to remove them too (it's a matter of how the
> "even_cows" arg to unmap_mapping_range() is treated).

I did a quick test, after inserting zero pages, seems that truncation
also leaves the mappings.

I'm still reading code to learn this part ...
