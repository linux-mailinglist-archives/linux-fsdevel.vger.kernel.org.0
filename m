Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03D239AB26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 21:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFCT6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 15:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCT6u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:58:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AA1E6139A;
        Thu,  3 Jun 2021 19:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622750224;
        bh=81DqeO774s33h+YAwWrBAiXQa7KeTEOqSdKa8sghF9M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cnjbZym8K9qCgQHxspSMzsHaHSF/RlTIzutUDrU8l5AVE+Y6KL0kum7iau+vYj1Gz
         x3w9EZwjJdgqclXYwgm8KFsMTLm7iF8wzcgXwYL42JH6Fz7bv1gcAuSMCH89GbDSSv
         c+xc9tdT04HVkKeKhM+xP2VT1W81C5nlPjmeb1xbGYHJ8L1OCnkrHYYfFgtfHbKZd3
         2jBdLE/5WSQan772gkgaQDQaW1qMdngdBZZbzGPoP6mLs08iDhj8wTf7ndC4oJqodB
         RLJaTrvJz4aCaj82E/lqKjkS4tiw1kHRqDqNNUtgj3RcDpFBaJ2gy8/6sCy9KdkA64
         nBRfjO3Mmhb0w==
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
 <79a27014-5450-1345-9eea-12fc9ae25777@kernel.org>
 <alpine.LSU.2.11.2106021719500.8333@eggly.anvils>
From:   Ming Lin <mlin@kernel.org>
Message-ID: <e46d1453-b1ff-e665-7312-1b97f2f44f4f@kernel.org>
Date:   Thu, 3 Jun 2021 12:57:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2106021719500.8333@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/2/2021 5:46 PM, Hugh Dickins wrote
> 
> It's do_anonymous_page()'s business to map in the zero page on
> read fault (see "my_zero_pfn(vmf->address)" in there), or fill
> a freshly allocated page with zeroes on write fault - and now
> you're sticking to MAP_PRIVATE, write faults in VM_WRITE areas
> are okay for VM_NOSIGBUS.
> 
> Ideally you can simply call do_anonymous_page() from __do_fault()
> in the VM_FAULT_SIGBUS on VM_NOSIGBUS case.  That's what to start
> from anyway: but look to see if there's state to be adjusted to
> achieve that; and it won't be surprising if somewhere down in
> do_anonymous_page() or something it calls, there's a BUG on it
> being called when vma->vm_file is set, or something like that.
> May need some tweaking.

do_anonymous_page() works nicely for read fault and write fault.
I didn't see any BUG() thing in my test.

But I'm still struggling with how to do "punch hole should remove the mapping of zero page".
Here is the hack I have now.

diff --git a/mm/memory.c b/mm/memory.c
index 46ecda5..6b5a897 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1241,7 +1241,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
                         struct page *page;
  
                         page = vm_normal_page(vma, addr, ptent);
-                       if (unlikely(details) && page) {
+                       if (unlikely(details) && page && !(vma->vm_flags & VM_NOSIGBUS)) {
                                 /*
                                  * unmap_shared_mapping_pages() wants to
                                  * invalidate cache without truncating:


And other parts of the patch is following,

----

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
index eff2a47..46ecda5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3676,6 +3676,17 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
  	}
  
  	ret = vma->vm_ops->fault(vmf);
+	if (unlikely(ret & VM_FAULT_SIGBUS) && (vma->vm_flags & VM_NOSIGBUS)) {
+		/*
+		 * For MAP_NOSIGBUS mapping, map in the zero page on read fault
+		 * or fill a freshly allocated page with zeroes on write fault
+		 */
+		ret = do_anonymous_page(vmf);
+		if (!ret)
+			ret = VM_FAULT_NOPAGE;
+		return ret;
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
