Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9808467555
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 11:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379965AbhLCKqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 05:46:32 -0500
Received: from foss.arm.com ([217.140.110.172]:46968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380014AbhLCKqa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:46:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0233152B;
        Fri,  3 Dec 2021 02:43:06 -0800 (PST)
Received: from a077416.arm.com (unknown [10.163.33.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6DF903F5A1;
        Fri,  3 Dec 2021 02:43:02 -0800 (PST)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kexec <kexec@lists.infradead.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>
Subject: [RFC PATCH 04/14] x86/crash_dump_64: Use the new interface copy_oldmem_page_buf
Date:   Fri,  3 Dec 2021 16:12:21 +0530
Message-Id: <20211203104231.17597-5-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203104231.17597-1-amit.kachhap@arm.com>
References: <20211203104231.17597-1-amit.kachhap@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current interface copy_oldmem_page() passes user pointer without
__user annotation and hence does unnecessary user/kernel pointer
conversions during its implementation.

Implement the interface copy_oldmem_page_buf() to avoid this issue.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86 <x86@kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 arch/x86/kernel/crash_dump_64.c | 44 +++++++++++++++------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 99cd505628fa..7a6fa797260f 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -12,9 +12,9 @@
 #include <linux/io.h>
 #include <linux/cc_platform.h>
 
-static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-				  unsigned long offset, int userbuf,
-				  bool encrypted)
+static ssize_t __copy_oldmem_page(unsigned long pfn, char __user *ubuf,
+				  char *kbuf, size_t csize,
+				  unsigned long offset, bool encrypted)
 {
 	void  *vaddr;
 
@@ -29,13 +29,13 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
+	if (ubuf) {
+		if (copy_to_user(ubuf, vaddr + offset, csize)) {
 			iounmap((void __iomem *)vaddr);
 			return -EFAULT;
 		}
 	} else
-		memcpy(buf, vaddr + offset, csize);
+		memcpy(kbuf, vaddr + offset, csize);
 
 	set_iounmap_nonlazy();
 	iounmap((void __iomem *)vaddr);
@@ -43,39 +43,35 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 }
 
 /**
- * copy_oldmem_page - copy one page of memory
+ * copy_oldmem_page_buf - copy one page of memory
  * @pfn: page frame number to be copied
- * @buf: target memory address for the copy; this can be in kernel address
- *	space or user address space (see @userbuf)
+ * @ubuf: target user memory pointer for the copy; use copy_to_user() if this
+ * pointer is not NULL
+ * @kbuf: target kernel memory pointer for the copy; use memcpy() if this
+ * pointer is not NULL
  * @csize: number of bytes to copy
  * @offset: offset in bytes into the page (based on pfn) to begin the copy
- * @userbuf: if set, @buf is in user address space, use copy_to_user(),
- *	otherwise @buf is in kernel address space, use memcpy().
  *
- * Copy a page from the old kernel's memory. For this page, there is no pte
- * mapped in the current kernel. We stitch up a pte, similar to kmap_atomic.
+ * Copy a page from the old kernel's memory into the buffer pointed either by
+ * @ubuf or @kbuf. For this page, there is no pte mapped in the current kernel.
+ * We stitch up a pte, similar to kmap_atomic.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-			 unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf, char *kbuf,
+			     size_t csize, unsigned long offset)
 {
-	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, false);
+	return __copy_oldmem_page(pfn, ubuf, kbuf, csize, offset, false);
 }
 
 /**
- * copy_oldmem_page_encrypted - same as copy_oldmem_page() above but ioremap the
- * memory with the encryption mask set to accommodate kdump on SME-enabled
+ * copy_oldmem_page_encrypted - same as copy_oldmem_page_buf() above but ioremap
+ * the memory with the encryption mask set to accommodate kdump on SME-enabled
  * machines.
  */
 ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char __user *ubuf,
 				   char *kbuf, size_t csize,
 				   unsigned long offset)
 {
-	if (ubuf)
-		return __copy_oldmem_page(pfn, (__force char *)ubuf, csize,
-					  offset, 1, true);
-	else
-		return __copy_oldmem_page(pfn, kbuf, csize,
-					  offset, 0, true);
+	return __copy_oldmem_page(pfn, ubuf, kbuf, csize, offset, true);
 }
 
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
-- 
2.17.1

