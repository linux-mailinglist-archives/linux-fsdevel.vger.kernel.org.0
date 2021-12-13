Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219DE471EEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 01:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhLMAGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 19:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhLMAGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 19:06:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962CCC061751;
        Sun, 12 Dec 2021 16:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MYs1nYtodji9t4lI89p2MHnykPr6V91u1ky4nymkckg=; b=aT4xJGlh1cXCgnDEJyXQKNFHa9
        C8a9gukUAtyA1Qonfyn5pHi1KfEu0a2qr3FXK1XlBdEIAUDhp2l5M+m4nFhGNWq3FmR2VK/SVDhd4
        lZ74NNTVwNU/RqEpOwfNcb6vPBOpWB1CX7Poz0tiTc3JIN9v0ZeKUrqbIqQRTFzowNUPGrvxIOGbv
        lDS1KWvX5GjzDUvoz+nNZtl4LkPU+nzkzfqd8/ifHnFDLXSfRZ+UD6x2RZ9FePygWegifDkspXIw1
        S3tiC1BL+FgaeT4EKomlPKBF+J4o/07s0aHrZFaqHDEEmADQlmffLvtF+b5Rt0UO1eCSZTiN6f88H
        bKMAjGYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwYrW-00CIuG-4b; Mon, 13 Dec 2021 00:06:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] vmcore: Convert copy_oldmem_page() to take an iov_iter
Date:   Mon, 13 Dec 2021 00:06:34 +0000
Message-Id: <20211213000636.2932569-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213000636.2932569-1-willy@infradead.org>
References: <20211213000636.2932569-1-willy@infradead.org>
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
 arch/arm/kernel/crash_dump.c     | 14 ++-------
 arch/arm64/kernel/crash_dump.c   | 14 ++-------
 arch/ia64/kernel/crash_dump.c    | 12 ++------
 arch/mips/kernel/crash_dump.c    | 13 ++------
 arch/powerpc/kernel/crash_dump.c | 20 +++---------
 arch/riscv/kernel/crash_dump.c   | 13 ++------
 arch/s390/kernel/crash_dump.c    | 12 +++++---
 arch/sh/kernel/crash_dump.c      | 15 +++------
 arch/x86/kernel/crash_dump_32.c  | 13 ++------
 arch/x86/kernel/crash_dump_64.c  | 24 ++++++---------
 fs/proc/vmcore.c                 | 53 ++++++++++++++++++++------------
 include/linux/crash_dump.h       |  9 +++---
 12 files changed, 79 insertions(+), 133 deletions(-)

diff --git a/arch/arm/kernel/crash_dump.c b/arch/arm/kernel/crash_dump.c
index 53cb92435392..15d7db782f24 100644
--- a/arch/arm/kernel/crash_dump.c
+++ b/arch/arm/kernel/crash_dump.c
@@ -27,9 +27,8 @@
  * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
  * copied or negative error in case of failure.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset,
-			 int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+			 size_t csize, unsigned long offset)
 {
 	void *vaddr;
 
@@ -40,14 +39,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
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
index 58303a9ec32c..991d30aac439 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -25,9 +25,8 @@
  * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
  * copied or negative error in case of failure.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset,
-			 int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+			 size_t csize, unsigned long offset)
 {
 	void *vaddr;
 
@@ -38,14 +37,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
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
index 0ed3c3dee4cd..bc331272bbd6 100644
--- a/arch/ia64/kernel/crash_dump.c
+++ b/arch/ia64/kernel/crash_dump.c
@@ -31,21 +31,15 @@
  * copying the data to a pre-allocated kernel page and then copying to user
  * space in non-atomic context.
  */
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
index 2e50f55185a6..926665c798b6 100644
--- a/arch/mips/kernel/crash_dump.c
+++ b/arch/mips/kernel/crash_dump.c
@@ -15,8 +15,8 @@
  * Copy a page from "oldmem". For this page, there is no pte mapped
  * in the current kernel.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+			 size_t csize, unsigned long offset)
 {
 	void  *vaddr;
 
@@ -24,14 +24,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
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
index 5693e1c67c2b..541bcc01490c 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -68,18 +68,6 @@ void __init setup_kdump_trampoline(void)
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
 /**
  * copy_oldmem_page - copy one page from "oldmem"
  * @pfn: page frame number to be copied
@@ -93,8 +81,8 @@ static size_t copy_oldmem_vaddr(void *vaddr, char *buf, size_t csize,
  * Copy a page from "oldmem". For this page, there is no pte mapped
  * in the current kernel. We stitch up a pte, similar to kmap_atomic.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+			size_t csize, unsigned long offset)
 {
 	void  *vaddr;
 	phys_addr_t paddr;
@@ -107,10 +95,10 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 
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
index 86cc0ada5752..f4dffb8c7eb7 100644
--- a/arch/riscv/kernel/crash_dump.c
+++ b/arch/riscv/kernel/crash_dump.c
@@ -20,9 +20,8 @@
  * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
  * copied or negative error in case of failure.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset,
-			 int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+			 size_t csize, unsigned long offset)
 {
 	void *vaddr;
 
@@ -33,13 +32,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
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
index 785d54c9350c..09bf559f2c5b 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -214,8 +214,8 @@ static int copy_oldmem_user(void __user *dst, void *src, size_t count)
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
@@ -223,10 +223,12 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
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
index 5b41b59698c1..26081861cb62 100644
--- a/arch/sh/kernel/crash_dump.c
+++ b/arch/sh/kernel/crash_dump.c
@@ -23,8 +23,8 @@
  * Copy a page from "oldmem". For this page, there is no pte mapped
  * in the current kernel. We stitch up a pte, similar to kmap_atomic.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-                               size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+                               size_t csize, unsigned long offset)
 {
 	void  __iomem *vaddr;
 
@@ -32,15 +32,8 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
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
index 5fcac46aaf6b..23d38ecf5de2 100644
--- a/arch/x86/kernel/crash_dump_32.c
+++ b/arch/x86/kernel/crash_dump_32.c
@@ -42,8 +42,8 @@ static inline bool is_crashed_pfn_valid(unsigned long pfn)
  * Copy a page from "oldmem". For this page, there might be no pte mapped
  * in the current kernel.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-			 unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn, size_t csize,
+			 unsigned long offset)
 {
 	void  *vaddr;
 
@@ -54,14 +54,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
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
index a7f617a3981d..8d91e5f2e14d 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -12,8 +12,8 @@
 #include <linux/io.h>
 #include <linux/cc_platform.h>
 
-static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-				  unsigned long offset, int userbuf,
+static ssize_t __copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+				  size_t csize, unsigned long offset, 
 				  bool encrypted)
 {
 	void  *vaddr;
@@ -29,13 +29,7 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
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
@@ -55,10 +49,10 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
  * Copy a page from the old kernel's memory. For this page, there is no pte
  * mapped in the current kernel. We stitch up a pte, similar to kmap_atomic.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-			 unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn, size_t csize,
+			 unsigned long offset)
 {
-	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, false);
+	return __copy_oldmem_page(iter, pfn, csize, offset, false);
 }
 
 /**
@@ -66,10 +60,10 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
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
index 509f85148fee..049bafe9c007 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -132,9 +132,8 @@ static int open_vmcore(struct inode *inode, struct file *file)
 }
 
 /* Reads a page from the oldmem device from given offset. */
-ssize_t read_from_oldmem(char *buf, size_t count,
-			 u64 *ppos, int userbuf,
-			 bool encrypted)
+ssize_t read_from_oldmem_iter(struct iov_iter *iter, size_t count,
+			 u64 *ppos, bool encrypted)
 {
 	unsigned long pfn, offset;
 	size_t nr_bytes;
@@ -155,29 +154,23 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 
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
@@ -187,6 +180,27 @@ ssize_t read_from_oldmem(char *buf, size_t count,
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
@@ -231,11 +245,10 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
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

