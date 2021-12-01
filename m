Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D34465699
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 20:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352698AbhLATlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 14:41:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34420 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245594AbhLATlS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:41:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 088DFB8211B;
        Wed,  1 Dec 2021 19:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EDEC53FAD;
        Wed,  1 Dec 2021 19:37:52 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] Avoid live-lock in fault-in+uaccess loops with sub-page faults
Date:   Wed,  1 Dec 2021 19:37:46 +0000
Message-Id: <20211201193750.2097885-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Following the discussions on the first series,

https://lore.kernel.org/r/20211124192024.2408218-1-catalin.marinas@arm.com

this new patchset aims to generalise the sub-page probing and introduce
a minimum size to the fault_in_*() functions. I called this 'v2' but I
can rebase it on top of v1 and keep v1 as a btrfs live-lock
back-portable fix. The fault_in_*() API improvements would be a new
series. Anyway, I'd first like to know whether this is heading in the
right direction and whether it's worth adding min_size to all
fault_in_*() (more below).

v2 adds a 'min_size' argument to all fault_in_*() functions with current
callers passing 0 (or we could make it 1). A probe_subpage_*() call is
made for the min_size range, though with all 0 this wouldn't have any
effect. The only difference is btrfs search_ioctl() in the last patch
which passes a non-zero min_size to avoid the live-lock (functionally
that's the same as the v1 series).

In terms of sub-page probing, I don't think with the current kernel
anything other than search_ioctl() matters. The buffered file I/O can
already cope with current fault_in_*() + copy_*_user() loops (the
uaccess makes progress). Direct I/O either goes via GUP + kernel mapping
access (and memcpy() can't fault) or, if the user buffer is not PAGE
aligned, it may fall back to buffered I/O. So we really only care about
fault_in_writeable(), as in v1.

Linus suggested that we could use the min_size to request a minimum
guaranteed probed size (in most cases this would be 1) and put a cap on
the faulted-in size, say two pages. All the fault_in_iov_iter_*()
callers will need to check the actual quantity returned by fault_in_*()
rather than bail out on non-zero but Andreas has a patch already (though
I think there are a few cases in btrfs etc.):

https://lore.kernel.org/r/20211123151812.361624-1-agruenba@redhat.com

With these callers fixed, we could add something like the diff below.
But, again, min_size doesn't actually have any current use in the kernel
other than fault_in_writeable() and search_ioctl().

Thanks for having a look. Suggestions welcomed.

------------------8<-------------------------------
diff --git a/mm/gup.c b/mm/gup.c
index 7fa69b0fb859..3aa88aa8ce9d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1658,6 +1658,8 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 }
 #endif /* !CONFIG_MMU */
 
+#define MAX_FAULT_IN_SIZE	(2 * PAGE_SIZE)
+
 /**
  * fault_in_writeable - fault in userspace address range for writing
  * @uaddr: start of address range
@@ -1671,6 +1673,7 @@ size_t fault_in_writeable(char __user *uaddr, size_t size, size_t min_size)
 {
 	char __user *start = uaddr, *end;
 	size_t faulted_in = size;
+	size_t max_size = max_t(size_t, MAX_FAULT_IN_SIZE, min_size);
 
 	if (unlikely(size == 0))
 		return 0;
@@ -1679,7 +1682,7 @@ size_t fault_in_writeable(char __user *uaddr, size_t size, size_t min_size)
 			return size;
 		uaddr = (char __user *)PAGE_ALIGN((unsigned long)uaddr);
 	}
-	end = (char __user *)PAGE_ALIGN((unsigned long)start + size);
+	end = (char __user *)PAGE_ALIGN((unsigned long)start + max_size);
 	if (unlikely(end < start))
 		end = NULL;
 	while (uaddr != end) {
@@ -1726,9 +1729,10 @@ size_t fault_in_safe_writeable(const char __user *uaddr, size_t size,
 	struct vm_area_struct *vma = NULL;
 	int locked = 0;
 	size_t faulted_in = size;
+	size_t max_size = max_t(size_t, MAX_FAULT_IN_SIZE, min_size);
 
 	nstart = start & PAGE_MASK;
-	end = PAGE_ALIGN(start + size);
+	end = PAGE_ALIGN(start + max_size);
 	if (end < nstart)
 		end = 0;
 	for (; nstart != end; nstart = nend) {
@@ -1759,7 +1763,7 @@ size_t fault_in_safe_writeable(const char __user *uaddr, size_t size,
 	if (locked)
 		mmap_read_unlock(mm);
 	if (nstart != end)
-		faulted_in = min_t(size_t, nstart - start, size);
+		faulted_in = min_t(size_t, nstart - start, max_size);
 	if (faulted_in < min_size ||
 	    (min_size && probe_subpage_safe_writeable(uaddr, min_size)))
 		return size;
@@ -1782,6 +1786,7 @@ size_t fault_in_readable(const char __user *uaddr, size_t size,
 	const char __user *start = uaddr, *end;
 	volatile char c;
 	size_t faulted_in = size;
+	size_t max_size = max_t(size_t, MAX_FAULT_IN_SIZE, min_size);
 
 	if (unlikely(size == 0))
 		return 0;
@@ -1790,7 +1795,7 @@ size_t fault_in_readable(const char __user *uaddr, size_t size,
 			return size;
 		uaddr = (const char __user *)PAGE_ALIGN((unsigned long)uaddr);
 	}
-	end = (const char __user *)PAGE_ALIGN((unsigned long)start + size);
+	end = (const char __user *)PAGE_ALIGN((unsigned long)start + max_size);
 	if (unlikely(end < start))
 		end = NULL;
 	while (uaddr != end) {
------------------8<-------------------------------

Catalin Marinas (4):
  mm: Introduce a 'min_size' argument to fault_in_*()
  mm: Probe for sub-page faults in fault_in_*()
  arm64: Add support for user sub-page fault probing
  btrfs: Avoid live-lock in search_ioctl() on hardware with sub-page
    faults

 arch/Kconfig                        |  7 ++++
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/uaccess.h    | 59 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/kvm.c           |  2 +-
 arch/powerpc/kernel/signal_32.c     |  4 +-
 arch/powerpc/kernel/signal_64.c     |  2 +-
 arch/x86/kernel/fpu/signal.c        |  2 +-
 drivers/gpu/drm/armada/armada_gem.c |  2 +-
 fs/btrfs/file.c                     |  6 +--
 fs/btrfs/ioctl.c                    |  7 +++-
 fs/f2fs/file.c                      |  2 +-
 fs/fuse/file.c                      |  2 +-
 fs/gfs2/file.c                      |  8 ++--
 fs/iomap/buffered-io.c              |  2 +-
 fs/ntfs/file.c                      |  2 +-
 fs/ntfs3/file.c                     |  2 +-
 include/linux/pagemap.h             |  8 ++--
 include/linux/uaccess.h             | 53 ++++++++++++++++++++++++++
 include/linux/uio.h                 |  6 ++-
 lib/iov_iter.c                      | 28 +++++++++++---
 mm/filemap.c                        |  2 +-
 mm/gup.c                            | 37 +++++++++++++-----
 22 files changed, 203 insertions(+), 41 deletions(-)

