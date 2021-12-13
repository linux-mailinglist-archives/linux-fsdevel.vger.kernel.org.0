Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6F2472F89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 15:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbhLMOjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 09:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbhLMOjo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:39:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33F9C061748;
        Mon, 13 Dec 2021 06:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YUM5LON2caMb0OuT/r26m990Uxe5ecJdOu4gjGXOy4g=; b=k+ciIuqbsvRdng3hkWm2Cd5i5t
        ZDtUlzBsrmwiXJG2QOLx1kD6mOpwTXWFyC5cScD9Oa52pzL355o6dwn6L10I+/tmdTpRNMPHvobRo
        cwgbKPSGOxSE2zfzaaNpDF2d5Mu0G80nSh50iBMGUIhDZSkAPQsLok+AN02AJedCqD2sSWAGF3L21
        AJmjpuXFDnWC4hspFvRHa/YGdQbkSeYsOU4nvLLQkM8QidCtNL3ptWcrsfkN5eMEnqQHDnRtEz23A
        gkEewiP4SSXODRgVKfAWT66TGtFRDwruIGhucnHZ8sXNvRWOCSwHb04a7NvFLau/UTZuyrJ+MokLp
        qo4QOFvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwmUC-00CsXM-7j; Mon, 13 Dec 2021 14:39:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/3] vmcore: Convert copy_oldmem_page() to take an iov_iter
Date:   Mon, 13 Dec 2021 14:39:25 +0000
Message-Id: <20211213143927.3069508-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213143927.3069508-1-willy@infradead.org>
References: <20211213143927.3069508-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of passing in a 'buf' and 'userbuf' argument, pass in an iov_iter.
s390 needs more work to pass the iov_iter down further, or refactor,
but I'd be more comfortable if someone who can test on s390 did that work.

It's more convenient to convert the whole of read_from_oldmem() to
take an iov_iter at the same time, so rename it to read_from_oldmem_iter()
and add a temporary read_from_oldmem() wrapper that creates an iov_iter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/arm/kernel/crash_dump.c     | 27 +++-------------
 arch/arm64/kernel/crash_dump.c   | 29 +++--------------
 arch/ia64/kernel/crash_dump.c    | 32 +++----------------
 arch/mips/kernel/crash_dump.c    | 27 +++-------------
 arch/powerpc/kernel/crash_dump.c | 35 +++------------------
 arch/riscv/kernel/crash_dump.c   | 26 +++------------
 arch/s390/kernel/crash_dump.c    | 13 +++++---
 arch/sh/kernel/crash_dump.c      | 29 +++--------------
 arch/x86/kernel/crash_dump_32.c  | 29 +++--------------
 arch/x86/kernel/crash_dump_64.c  | 41 +++++++-----------------
 fs/proc/vmcore.c                 | 54 ++++++++++++++++++++------------
 include/linux/crash_dump.h       |  9 +++---
 12 files changed, 91 insertions(+), 260 deletions(-)

diff --git a/arch/arm/kernel/crash_dump.c b/arch/arm/kernel/crash_dump.c
index 53cb92435392..938bd932df9a 100644
--- a/arch/arm/kernel/crash_dump.c
+++ b/arch/arm/kernel/crash_dump.c
@@ -14,22 +14,10 @@
 #include <linux/crash_dump.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/uio.h>
 
-/**
- * copy_oldmem_page() - copy one page from old kernel memory
- * @pfn: page frame number to be copied
- * @buf: buffer where the copied page is placed
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page
- * @userbuf: if set, @buf is int he user address space
- *
- * This function copies one page from old kernel memory into buffer pointed by
- * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
- * copied or negative error in case of failure.
- */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset,
-			 int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+			 size_t csize, unsigned long offset)
 {
 	void *vaddr;
 
@@ -40,14 +28,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user(buf, vaddr + offset, csize)) {
-			iounmap(vaddr);
-			return -EFAULT;
-		}
-	} else {
-		memcpy(buf, vaddr + offset, csize);
-	}
+	csize = copy_to_iter(vaddr + offset, csize, iter);
 
 	iounmap(vaddr);
 	return csize;
diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
index 58303a9ec32c..670e4ce81822 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -9,25 +9,11 @@
 #include <linux/crash_dump.h>
 #include <linux/errno.h>
 #include <linux/io.h>
-#include <linux/memblock.h>
-#include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <asm/memory.h>
 
-/**
- * copy_oldmem_page() - copy one page from old kernel memory
- * @pfn: page frame number to be copied
- * @buf: buffer where the copied page is placed
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page
- * @userbuf: if set, @buf is in a user address space
- *
- * This function copies one page from old kernel memory into buffer pointed by
- * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
- * copied or negative error in case of failure.
- */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset,
-			 int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+			 size_t csize, unsigned long offset)
 {
 	void *vaddr;
 
@@ -38,14 +24,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user((char __user *)buf, vaddr + offset, csize)) {
-			memunmap(vaddr);
-			return -EFAULT;
-		}
-	} else {
-		memcpy(buf, vaddr + offset, csize);
-	}
+	csize = copy_to_iter(vaddr + offset, csize, iter);
 
 	memunmap(vaddr);
 
diff --git a/arch/ia64/kernel/crash_dump.c b/arch/ia64/kernel/crash_dump.c
index 0ed3c3dee4cd..4ef68e2aa757 100644
--- a/arch/ia64/kernel/crash_dump.c
+++ b/arch/ia64/kernel/crash_dump.c
@@ -10,42 +10,18 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/crash_dump.h>
-
+#include <linux/uio.h>
 #include <asm/page.h>
-#include <linux/uaccess.h>
 
-/**
- * copy_oldmem_page - copy one page from "oldmem"
- * @pfn: page frame number to be copied
- * @buf: target memory address for the copy; this can be in kernel address
- *	space or user address space (see @userbuf)
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page (based on pfn) to begin the copy
- * @userbuf: if set, @buf is in user address space, use copy_to_user(),
- *	otherwise @buf is in kernel address space, use memcpy().
- *
- * Copy a page from "oldmem". For this page, there is no pte mapped
- * in the current kernel. We stitch up a pte, similar to kmap_atomic.
- *
- * Calling copy_to_user() in atomic context is not desirable. Hence first
- * copying the data to a pre-allocated kernel page and then copying to user
- * space in non-atomic context.
- */
-ssize_t
-copy_oldmem_page(unsigned long pfn, char *buf,
-		size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+		size_t csize, unsigned long offset)
 {
 	void  *vaddr;
 
 	if (!csize)
 		return 0;
 	vaddr = __va(pfn<<PAGE_SHIFT);
-	if (userbuf) {
-		if (copy_to_user(buf, (vaddr + offset), csize)) {
-			return -EFAULT;
-		}
-	} else
-		memcpy(buf, (vaddr + offset), csize);
+	csize = copy_to_iter(vaddr + offset, csize, iter);
 	return csize;
 }
 
diff --git a/arch/mips/kernel/crash_dump.c b/arch/mips/kernel/crash_dump.c
index 2e50f55185a6..6e50f4902409 100644
--- a/arch/mips/kernel/crash_dump.c
+++ b/arch/mips/kernel/crash_dump.c
@@ -1,22 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/highmem.h>
 #include <linux/crash_dump.h>
+#include <linux/uio.h>
 
-/**
- * copy_oldmem_page - copy one page from "oldmem"
- * @pfn: page frame number to be copied
- * @buf: target memory address for the copy; this can be in kernel address
- *	space or user address space (see @userbuf)
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page (based on pfn) to begin the copy
- * @userbuf: if set, @buf is in user address space, use copy_to_user(),
- *	otherwise @buf is in kernel address space, use memcpy().
- *
- * Copy a page from "oldmem". For this page, there is no pte mapped
- * in the current kernel.
- */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+			 size_t csize, unsigned long offset)
 {
 	void  *vaddr;
 
@@ -24,14 +12,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 		return 0;
 
 	vaddr = kmap_local_pfn(pfn);
-
-	if (!userbuf) {
-		memcpy(buf, vaddr + offset, csize);
-	} else {
-		if (copy_to_user(buf, vaddr + offset, csize))
-			csize = -EFAULT;
-	}
-
+	csize = copy_to_iter(vaddr + offset, csize, iter);
 	kunmap_local(vaddr);
 
 	return csize;
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 5693e1c67c2b..32b4a97f1b79 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -16,7 +16,7 @@
 #include <asm/kdump.h>
 #include <asm/prom.h>
 #include <asm/firmware.h>
-#include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <asm/rtas.h>
 #include <asm/inst.h>
 
@@ -68,33 +68,8 @@ void __init setup_kdump_trampoline(void)
 }
 #endif /* CONFIG_NONSTATIC_KERNEL */
 
-static size_t copy_oldmem_vaddr(void *vaddr, char *buf, size_t csize,
-                               unsigned long offset, int userbuf)
-{
-	if (userbuf) {
-		if (copy_to_user((char __user *)buf, (vaddr + offset), csize))
-			return -EFAULT;
-	} else
-		memcpy(buf, (vaddr + offset), csize);
-
-	return csize;
-}
-
-/**
- * copy_oldmem_page - copy one page from "oldmem"
- * @pfn: page frame number to be copied
- * @buf: target memory address for the copy; this can be in kernel address
- *      space or user address space (see @userbuf)
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page (based on pfn) to begin the copy
- * @userbuf: if set, @buf is in user address space, use copy_to_user(),
- *      otherwise @buf is in kernel address space, use memcpy().
- *
- * Copy a page from "oldmem". For this page, there is no pte mapped
- * in the current kernel. We stitch up a pte, similar to kmap_atomic.
- */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+			size_t csize, unsigned long offset)
 {
 	void  *vaddr;
 	phys_addr_t paddr;
@@ -107,10 +82,10 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 
 	if (memblock_is_region_memory(paddr, csize)) {
 		vaddr = __va(paddr);
-		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
+		csize = copy_to_iter(vaddr + offset, csize, iter);
 	} else {
 		vaddr = ioremap_cache(paddr, PAGE_SIZE);
-		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
+		csize = copy_to_iter(vaddr + offset, csize, iter);
 		iounmap(vaddr);
 	}
 
diff --git a/arch/riscv/kernel/crash_dump.c b/arch/riscv/kernel/crash_dump.c
index 86cc0ada5752..ea2158cee97b 100644
--- a/arch/riscv/kernel/crash_dump.c
+++ b/arch/riscv/kernel/crash_dump.c
@@ -7,22 +7,10 @@
 
 #include <linux/crash_dump.h>
 #include <linux/io.h>
+#include <linux/uio.h>
 
-/**
- * copy_oldmem_page() - copy one page from old kernel memory
- * @pfn: page frame number to be copied
- * @buf: buffer where the copied page is placed
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page
- * @userbuf: if set, @buf is in a user address space
- *
- * This function copies one page from old kernel memory into buffer pointed by
- * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
- * copied or negative error in case of failure.
- */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset,
-			 int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+			 size_t csize, unsigned long offset)
 {
 	void *vaddr;
 
@@ -33,13 +21,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user((char __user *)buf, vaddr + offset, csize)) {
-			memunmap(vaddr);
-			return -EFAULT;
-		}
-	} else
-		memcpy(buf, vaddr + offset, csize);
+	csize = copy_to_iter(vaddr + offset, csize, iter);
 
 	memunmap(vaddr);
 	return csize;
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 785d54c9350c..9ada1dcde406 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/elf.h>
+#include <linux/uio.h>
 #include <asm/asm-offsets.h>
 #include <asm/os_info.h>
 #include <asm/elf.h>
@@ -214,8 +215,8 @@ static int copy_oldmem_user(void __user *dst, void *src, size_t count)
 /*
  * Copy one page from "oldmem"
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-			 unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn, size_t csize,
+			 unsigned long offset)
 {
 	void *src;
 	int rc;
@@ -223,10 +224,12 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 	if (!csize)
 		return 0;
 	src = (void *) (pfn << PAGE_SHIFT) + offset;
-	if (userbuf)
-		rc = copy_oldmem_user((void __force __user *) buf, src, csize);
+
+	/* XXX: pass the iov_iter down to a common function */
+	if (iter_is_iovec(iter))
+		rc = copy_oldmem_user(iter->iov->iov_base, src, csize);
 	else
-		rc = copy_oldmem_kernel((void *) buf, src, csize);
+		rc = copy_oldmem_kernel(iter->kvec->iov_base, src, csize);
 	return rc;
 }
 
diff --git a/arch/sh/kernel/crash_dump.c b/arch/sh/kernel/crash_dump.c
index 5b41b59698c1..277f44d8a298 100644
--- a/arch/sh/kernel/crash_dump.c
+++ b/arch/sh/kernel/crash_dump.c
@@ -8,23 +8,11 @@
 #include <linux/errno.h>
 #include <linux/crash_dump.h>
 #include <linux/io.h>
+#include <linux/uio.h>
 #include <linux/uaccess.h>
 
-/**
- * copy_oldmem_page - copy one page from "oldmem"
- * @pfn: page frame number to be copied
- * @buf: target memory address for the copy; this can be in kernel address
- *	space or user address space (see @userbuf)
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page (based on pfn) to begin the copy
- * @userbuf: if set, @buf is in user address space, use copy_to_user(),
- *	otherwise @buf is in kernel address space, use memcpy().
- *
- * Copy a page from "oldmem". For this page, there is no pte mapped
- * in the current kernel. We stitch up a pte, similar to kmap_atomic.
- */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-                               size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+                               size_t csize, unsigned long offset)
 {
 	void  __iomem *vaddr;
 
@@ -32,15 +20,8 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 		return 0;
 
 	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
-
-	if (userbuf) {
-		if (copy_to_user((void __user *)buf, (vaddr + offset), csize)) {
-			iounmap(vaddr);
-			return -EFAULT;
-		}
-	} else
-	memcpy(buf, (vaddr + offset), csize);
-
+	csize = copy_to_iter(vaddr + offset, csize, iter);
 	iounmap(vaddr);
+
 	return csize;
 }
diff --git a/arch/x86/kernel/crash_dump_32.c b/arch/x86/kernel/crash_dump_32.c
index 5fcac46aaf6b..5f4ae5476e19 100644
--- a/arch/x86/kernel/crash_dump_32.c
+++ b/arch/x86/kernel/crash_dump_32.c
@@ -10,8 +10,7 @@
 #include <linux/errno.h>
 #include <linux/highmem.h>
 #include <linux/crash_dump.h>
-
-#include <linux/uaccess.h>
+#include <linux/uio.h>
 
 static inline bool is_crashed_pfn_valid(unsigned long pfn)
 {
@@ -29,21 +28,8 @@ static inline bool is_crashed_pfn_valid(unsigned long pfn)
 #endif
 }
 
-/**
- * copy_oldmem_page - copy one page from "oldmem"
- * @pfn: page frame number to be copied
- * @buf: target memory address for the copy; this can be in kernel address
- *	space or user address space (see @userbuf)
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page (based on pfn) to begin the copy
- * @userbuf: if set, @buf is in user address space, use copy_to_user(),
- *	otherwise @buf is in kernel address space, use memcpy().
- *
- * Copy a page from "oldmem". For this page, there might be no pte mapped
- * in the current kernel.
- */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-			 unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn, size_t csize,
+			 unsigned long offset)
 {
 	void  *vaddr;
 
@@ -54,14 +40,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 		return -EFAULT;
 
 	vaddr = kmap_local_pfn(pfn);
-
-	if (!userbuf) {
-		memcpy(buf, vaddr + offset, csize);
-	} else {
-		if (copy_to_user(buf, vaddr + offset, csize))
-			csize = -EFAULT;
-	}
-
+	csize = copy_to_iter(vaddr + offset, csize, iter);
 	kunmap_local(vaddr);
 
 	return csize;
diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index a7f617a3981d..f922d51c9d1f 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -8,12 +8,12 @@
 
 #include <linux/errno.h>
 #include <linux/crash_dump.h>
-#include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <linux/io.h>
 #include <linux/cc_platform.h>
 
-static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-				  unsigned long offset, int userbuf,
+static ssize_t __copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+				  size_t csize, unsigned long offset,
 				  bool encrypted)
 {
 	void  *vaddr;
@@ -29,47 +29,28 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
-			iounmap((void __iomem *)vaddr);
-			return -EFAULT;
-		}
-	} else
-		memcpy(buf, vaddr + offset, csize);
+	csize = copy_to_iter(vaddr + offset, csize, iter);
 
 	set_iounmap_nonlazy();
 	iounmap((void __iomem *)vaddr);
 	return csize;
 }
 
-/**
- * copy_oldmem_page - copy one page of memory
- * @pfn: page frame number to be copied
- * @buf: target memory address for the copy; this can be in kernel address
- *	space or user address space (see @userbuf)
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page (based on pfn) to begin the copy
- * @userbuf: if set, @buf is in user address space, use copy_to_user(),
- *	otherwise @buf is in kernel address space, use memcpy().
- *
- * Copy a page from the old kernel's memory. For this page, there is no pte
- * mapped in the current kernel. We stitch up a pte, similar to kmap_atomic.
- */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-			 unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn, size_t csize,
+			 unsigned long offset)
 {
-	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, false);
+	return __copy_oldmem_page(iter, pfn, csize, offset, false);
 }
 
-/**
+/*
  * copy_oldmem_page_encrypted - same as copy_oldmem_page() above but ioremap the
  * memory with the encryption mask set to accommodate kdump on SME-enabled
  * machines.
  */
-ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
-				   unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page_encrypted(struct iov_iter *iter, unsigned long pfn,
+				   size_t csize, unsigned long offset)
 {
-	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, true);
+	return __copy_oldmem_page(iter, pfn, csize, offset, true);
 }
 
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 509f85148fee..958cad6476e6 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -26,6 +26,7 @@
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <linux/cc_platform.h>
 #include <asm/io.h>
 #include "internal.h"
@@ -132,9 +133,8 @@ static int open_vmcore(struct inode *inode, struct file *file)
 }
 
 /* Reads a page from the oldmem device from given offset. */
-ssize_t read_from_oldmem(char *buf, size_t count,
-			 u64 *ppos, int userbuf,
-			 bool encrypted)
+static ssize_t read_from_oldmem_iter(struct iov_iter *iter, size_t count,
+			 u64 *ppos, bool encrypted)
 {
 	unsigned long pfn, offset;
 	size_t nr_bytes;
@@ -155,29 +155,23 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 
 		/* If pfn is not ram, return zeros for sparse dump files */
 		if (!pfn_is_ram(pfn)) {
-			tmp = 0;
-			if (!userbuf)
-				memset(buf, 0, nr_bytes);
-			else if (clear_user(buf, nr_bytes))
-				tmp = -EFAULT;
+			tmp = iov_iter_zero(nr_bytes, iter);
 		} else {
 			if (encrypted)
-				tmp = copy_oldmem_page_encrypted(pfn, buf,
+				tmp = copy_oldmem_page_encrypted(iter, pfn,
 								 nr_bytes,
-								 offset,
-								 userbuf);
+								 offset);
 			else
-				tmp = copy_oldmem_page(pfn, buf, nr_bytes,
-						       offset, userbuf);
+				tmp = copy_oldmem_page(iter, pfn, nr_bytes,
+						       offset);
 		}
-		if (tmp < 0) {
+		if (tmp < nr_bytes) {
 			up_read(&vmcore_cb_rwsem);
-			return tmp;
+			return -EFAULT;
 		}
 
 		*ppos += nr_bytes;
 		count -= nr_bytes;
-		buf += nr_bytes;
 		read += nr_bytes;
 		++pfn;
 		offset = 0;
@@ -187,6 +181,27 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 	return read;
 }
 
+ssize_t read_from_oldmem(char *buf, size_t count,
+			 u64 *ppos, int userbuf,
+			 bool encrypted)
+{
+	struct iov_iter iter;
+	struct iovec iov;
+	struct kvec kvec;
+
+	if (userbuf) {
+		iov.iov_base = (__force void __user *)buf;
+		iov.iov_len = count;
+		iov_iter_init(&iter, READ, &iov, 1, count);
+	} else {
+		kvec.iov_base = buf;
+		kvec.iov_len = count;
+		iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	}
+
+	return read_from_oldmem_iter(&iter, count, ppos, encrypted);
+}
+
 /*
  * Architectures may override this function to allocate ELF header in 2nd kernel
  */
@@ -231,11 +246,10 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
 /*
  * Architectures which support memory encryption override this.
  */
-ssize_t __weak
-copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
-			   unsigned long offset, int userbuf)
+ssize_t __weak copy_oldmem_page_encrypted(struct iov_iter *iter,
+		unsigned long pfn, size_t csize, unsigned long offset)
 {
-	return copy_oldmem_page(pfn, buf, csize, offset, userbuf);
+	return copy_oldmem_page(iter, pfn, csize, offset);
 }
 
 /*
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 620821549b23..a1cf7d5c03c7 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -24,11 +24,10 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long from, unsigned long pfn,
 				  unsigned long size, pgprot_t prot);
 
-extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
-						unsigned long, int);
-extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
-					  size_t csize, unsigned long offset,
-					  int userbuf);
+ssize_t copy_oldmem_page(struct iov_iter *i, unsigned long pfn, size_t csize,
+		unsigned long offset);
+ssize_t copy_oldmem_page_encrypted(struct iov_iter *iter, unsigned long pfn,
+				   size_t csize, unsigned long offset);
 
 void vmcore_cleanup(void);
 
-- 
2.33.0

