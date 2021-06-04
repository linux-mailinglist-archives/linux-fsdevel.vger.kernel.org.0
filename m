Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C57939B433
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 09:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhFDHpV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 03:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhFDHpU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:45:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 854956141B;
        Fri,  4 Jun 2021 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622792614;
        bh=XB8rUSELbW+ph1X1LTQ6qFi6d8hPnJfkEO09pVdxd2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uyTcd2mCH5guTH7G+NZB6ZLpkfa/j+s/C98zz/82s1wRwVTZjXOA0HDhrh8G4+Ftm
         GcTzzMYLi/lGqhjWoKIGEEqDQEpO9Hz6EUZW30MMKpkwfnTeBL2fCG47AsD7iHU8mW
         piBnoKoQo0kiZCd1Jhi/TiVK6UBuFzqzHXXp3aOYdnOXUnV1lePE1vKK5+PxYPOMvU
         20BQg0JdAO5XpfunaEEARRPmDbvjXknImqiHtuiSNPJtCXtH+OamYT7ee4Bfjvkk9a
         ygpDZaeCmhpKjmhdRy+eGPAuGCZLaCIlQ4utLt1uzUQggaNAaOMJeIax8ep/4QTnYT
         F3y+XooqRovaQ==
From:   Ming Lin <mlin@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 2/2] mm: adds NOSIGBUS extension to mmap()
Date:   Fri,  4 Jun 2021 00:43:22 -0700
Message-Id: <1622792602-40459-3-git-send-email-mlin@kernel.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622792602-40459-1-git-send-email-mlin@kernel.org>
References: <1622792602-40459-1-git-send-email-mlin@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds new flag MAP_NOSIGBUS of mmap() to specify the behavior of
"don't SIGBUS on fault". Right now, this flag is only allowed
for private mapping.

For MAP_NOSIGBUS mapping, map in the zero page on read fault
or fill a freshly allocated page with zeroes on write fault.

Signed-off-by: Ming Lin <mlin@kernel.org>
---
 arch/parisc/include/uapi/asm/mman.h          |  1 +
 include/linux/mm.h                           |  2 ++
 include/linux/mman.h                         |  1 +
 include/uapi/asm-generic/mman-common.h       |  1 +
 mm/memory.c                                  | 11 +++++++++++
 mm/mmap.c                                    |  4 ++++
 tools/include/uapi/asm-generic/mman-common.h |  1 +
 7 files changed, 21 insertions(+)

diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index ab78cba..eecf9af 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -25,6 +25,7 @@
 #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
 #define MAP_FIXED_NOREPLACE 0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+#define MAP_NOSIGBUS	0x200000	/* do not SIGBUS on fault */
 #define MAP_UNINITIALIZED 0		/* uninitialized anonymous mmap */
 
 #define MS_SYNC		1		/* synchronous memory sync */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9e86ca1..100d122 100644
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
index 8d5e583..6b5a897 100644
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
index 8bed547..d5c9fb5 100644
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
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index f94f65d..a2a5333 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -29,6 +29,7 @@
 #define MAP_HUGETLB		0x040000	/* create a huge page mapping */
 #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+#define MAP_NOSIGBUS		0x200000	/* do not SIGBUS on fault */
 
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
-- 
1.8.3.1

