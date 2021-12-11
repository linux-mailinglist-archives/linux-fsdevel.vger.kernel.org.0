Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4E8471138
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 04:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345738AbhLKDhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 22:37:01 -0500
Received: from mail.loongson.cn ([114.242.206.163]:37182 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244514AbhLKDg6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 22:36:58 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax+sj1G7RhlA0GAA--.13327S4;
        Sat, 11 Dec 2021 11:33:10 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v2 2/2] kdump: crashdump: use copy_to_user_or_kernel() to simplify code
Date:   Sat, 11 Dec 2021 11:33:08 +0800
Message-Id: <1639193588-7027-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639193588-7027-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639193588-7027-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Ax+sj1G7RhlA0GAA--.13327S4
X-Coremail-Antispam: 1UD129KBjvJXoW3uryUCF4DKFWkJr43tF1kKrg_yoWDKw1kpr
        1kK39IyF4Sgas8GwnrtwnrWa48Ww1kG3W7t39Ika4rZ3Z2qFnFv3yDAasFg3yUtr90kFyS
        yas5Krn0y3yUZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
        43ZEXa7VUjknY5UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use copy_to_user_or_kernel() to simplify the related code about
copy_oldmem_page() in arch/*/kernel/crash_dump*.c files.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/arm/kernel/crash_dump.c     | 12 +++---------
 arch/arm64/kernel/crash_dump.c   | 12 +++---------
 arch/ia64/kernel/crash_dump.c    | 12 +++++-------
 arch/mips/kernel/crash_dump.c    | 11 +++--------
 arch/powerpc/kernel/crash_dump.c | 11 ++++-------
 arch/riscv/kernel/crash_dump.c   | 11 +++--------
 arch/sh/kernel/crash_dump.c      | 11 +++--------
 arch/x86/kernel/crash_dump_32.c  | 11 +++--------
 arch/x86/kernel/crash_dump_64.c  | 15 +++++----------
 fs/proc/vmcore.c                 |  4 ++--
 include/linux/crash_dump.h       |  8 ++++----
 11 files changed, 38 insertions(+), 80 deletions(-)

diff --git a/arch/arm/kernel/crash_dump.c b/arch/arm/kernel/crash_dump.c
index 53cb924..a27c5df 100644
--- a/arch/arm/kernel/crash_dump.c
+++ b/arch/arm/kernel/crash_dump.c
@@ -29,7 +29,7 @@
  */
 ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 			 size_t csize, unsigned long offset,
-			 int userbuf)
+			 bool userbuf)
 {
 	void *vaddr;
 
@@ -40,14 +40,8 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
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
+	if (copy_to_user_or_kernel(buf, vaddr + offset, csize, userbuf))
+		csize = -EFAULT;
 
 	iounmap(vaddr);
 	return csize;
diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
index 58303a9..d22988f 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -27,7 +27,7 @@
  */
 ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 			 size_t csize, unsigned long offset,
-			 int userbuf)
+			 bool userbuf)
 {
 	void *vaddr;
 
@@ -38,14 +38,8 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
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
+	if (copy_to_user_or_kernel(buf, vaddr + offset, csize, userbuf))
+		csize = -EFAULT;
 
 	memunmap(vaddr);
 
diff --git a/arch/ia64/kernel/crash_dump.c b/arch/ia64/kernel/crash_dump.c
index 0ed3c3d..12128f8 100644
--- a/arch/ia64/kernel/crash_dump.c
+++ b/arch/ia64/kernel/crash_dump.c
@@ -33,19 +33,17 @@
  */
 ssize_t
 copy_oldmem_page(unsigned long pfn, char *buf,
-		size_t csize, unsigned long offset, int userbuf)
+		size_t csize, unsigned long offset, bool userbuf)
 {
 	void  *vaddr;
 
 	if (!csize)
 		return 0;
+
 	vaddr = __va(pfn<<PAGE_SHIFT);
-	if (userbuf) {
-		if (copy_to_user(buf, (vaddr + offset), csize)) {
-			return -EFAULT;
-		}
-	} else
-		memcpy(buf, (vaddr + offset), csize);
+	if (copy_to_user_or_kernel(buf, vaddr + offset, csize, userbuf))
+		return -EFAULT;
+
 	return csize;
 }
 
diff --git a/arch/mips/kernel/crash_dump.c b/arch/mips/kernel/crash_dump.c
index 2e50f551..7670915 100644
--- a/arch/mips/kernel/crash_dump.c
+++ b/arch/mips/kernel/crash_dump.c
@@ -16,7 +16,7 @@
  * in the current kernel.
  */
 ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset, int userbuf)
+			 size_t csize, unsigned long offset, bool userbuf)
 {
 	void  *vaddr;
 
@@ -24,13 +24,8 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 		return 0;
 
 	vaddr = kmap_local_pfn(pfn);
-
-	if (!userbuf) {
-		memcpy(buf, vaddr + offset, csize);
-	} else {
-		if (copy_to_user(buf, vaddr + offset, csize))
-			csize = -EFAULT;
-	}
+	if (copy_to_user_or_kernel(buf, vaddr + offset, csize, userbuf))
+		csize = -EFAULT;
 
 	kunmap_local(vaddr);
 
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 5693e1c67..e2e9612 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -69,13 +69,10 @@ void __init setup_kdump_trampoline(void)
 #endif /* CONFIG_NONSTATIC_KERNEL */
 
 static size_t copy_oldmem_vaddr(void *vaddr, char *buf, size_t csize,
-                               unsigned long offset, int userbuf)
+				unsigned long offset, bool userbuf)
 {
-	if (userbuf) {
-		if (copy_to_user((char __user *)buf, (vaddr + offset), csize))
-			return -EFAULT;
-	} else
-		memcpy(buf, (vaddr + offset), csize);
+	if (copy_to_user_or_kernel(buf, vaddr + offset, csize, userbuf))
+		return -EFAULT;
 
 	return csize;
 }
@@ -94,7 +91,7 @@ static size_t copy_oldmem_vaddr(void *vaddr, char *buf, size_t csize,
  * in the current kernel. We stitch up a pte, similar to kmap_atomic.
  */
 ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			size_t csize, unsigned long offset, int userbuf)
+			size_t csize, unsigned long offset, bool userbuf)
 {
 	void  *vaddr;
 	phys_addr_t paddr;
diff --git a/arch/riscv/kernel/crash_dump.c b/arch/riscv/kernel/crash_dump.c
index 86cc0ad..4167437 100644
--- a/arch/riscv/kernel/crash_dump.c
+++ b/arch/riscv/kernel/crash_dump.c
@@ -22,7 +22,7 @@
  */
 ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 			 size_t csize, unsigned long offset,
-			 int userbuf)
+			 bool userbuf)
 {
 	void *vaddr;
 
@@ -33,13 +33,8 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user((char __user *)buf, vaddr + offset, csize)) {
-			memunmap(vaddr);
-			return -EFAULT;
-		}
-	} else
-		memcpy(buf, vaddr + offset, csize);
+	if (copy_to_user_or_kernel(buf, vaddr + offset, csize, userbuf))
+		csize = -EFAULT;
 
 	memunmap(vaddr);
 	return csize;
diff --git a/arch/sh/kernel/crash_dump.c b/arch/sh/kernel/crash_dump.c
index 5b41b59..4bc071a 100644
--- a/arch/sh/kernel/crash_dump.c
+++ b/arch/sh/kernel/crash_dump.c
@@ -24,7 +24,7 @@
  * in the current kernel. We stitch up a pte, similar to kmap_atomic.
  */
 ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-                               size_t csize, unsigned long offset, int userbuf)
+			 size_t csize, unsigned long offset, bool userbuf)
 {
 	void  __iomem *vaddr;
 
@@ -33,13 +33,8 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 
 	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
 
-	if (userbuf) {
-		if (copy_to_user((void __user *)buf, (vaddr + offset), csize)) {
-			iounmap(vaddr);
-			return -EFAULT;
-		}
-	} else
-	memcpy(buf, (vaddr + offset), csize);
+	if (copy_to_user_or_kernel(buf, vaddr + offset, csize, userbuf))
+		csize = -EFAULT;
 
 	iounmap(vaddr);
 	return csize;
diff --git a/arch/x86/kernel/crash_dump_32.c b/arch/x86/kernel/crash_dump_32.c
index 5fcac46..3eff124 100644
--- a/arch/x86/kernel/crash_dump_32.c
+++ b/arch/x86/kernel/crash_dump_32.c
@@ -43,7 +43,7 @@ static inline bool is_crashed_pfn_valid(unsigned long pfn)
  * in the current kernel.
  */
 ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-			 unsigned long offset, int userbuf)
+			 unsigned long offset, bool userbuf)
 {
 	void  *vaddr;
 
@@ -54,13 +54,8 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 		return -EFAULT;
 
 	vaddr = kmap_local_pfn(pfn);
-
-	if (!userbuf) {
-		memcpy(buf, vaddr + offset, csize);
-	} else {
-		if (copy_to_user(buf, vaddr + offset, csize))
-			csize = -EFAULT;
-	}
+	if (copy_to_user_or_kernel(buf, vaddr + offset, csize, userbuf))
+		csize = -EFAULT;
 
 	kunmap_local(vaddr);
 
diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index a7f617a..e8fffdf 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -13,7 +13,7 @@
 #include <linux/cc_platform.h>
 
 static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-				  unsigned long offset, int userbuf,
+				  unsigned long offset, bool userbuf,
 				  bool encrypted)
 {
 	void  *vaddr;
@@ -29,13 +29,8 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
-			iounmap((void __iomem *)vaddr);
-			return -EFAULT;
-		}
-	} else
-		memcpy(buf, vaddr + offset, csize);
+	if (copy_to_user_or_kernel(buf, vaddr + offset, csize, userbuf))
+		csize = -EFAULT;
 
 	set_iounmap_nonlazy();
 	iounmap((void __iomem *)vaddr);
@@ -56,7 +51,7 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
  * mapped in the current kernel. We stitch up a pte, similar to kmap_atomic.
  */
 ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-			 unsigned long offset, int userbuf)
+			 unsigned long offset, bool userbuf)
 {
 	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, false);
 }
@@ -67,7 +62,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
  * machines.
  */
 ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
-				   unsigned long offset, int userbuf)
+				   unsigned long offset, bool userbuf)
 {
 	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, true);
 }
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index f67fd77..bba52aa 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -133,7 +133,7 @@ static int open_vmcore(struct inode *inode, struct file *file)
 
 /* Reads a page from the oldmem device from given offset. */
 ssize_t read_from_oldmem(char *buf, size_t count,
-			 u64 *ppos, int userbuf,
+			 u64 *ppos, bool userbuf,
 			 bool encrypted)
 {
 	unsigned long pfn, offset;
@@ -233,7 +233,7 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
  */
 ssize_t __weak
 copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
-			   unsigned long offset, int userbuf)
+			   unsigned long offset, bool userbuf)
 {
 	return copy_oldmem_page(pfn, buf, csize, offset, userbuf);
 }
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 6208215..033448b 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -25,10 +25,10 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long size, pgprot_t prot);
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
-						unsigned long, int);
+						unsigned long, bool);
 extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
 					  size_t csize, unsigned long offset,
-					  int userbuf);
+					  bool userbuf);
 
 void vmcore_cleanup(void);
 
@@ -136,11 +136,11 @@ static inline int vmcore_add_device_dump(struct vmcoredd_data *data)
 
 #ifdef CONFIG_PROC_VMCORE
 ssize_t read_from_oldmem(char *buf, size_t count,
-			 u64 *ppos, int userbuf,
+			 u64 *ppos, bool userbuf,
 			 bool encrypted);
 #else
 static inline ssize_t read_from_oldmem(char *buf, size_t count,
-				       u64 *ppos, int userbuf,
+				       u64 *ppos, bool userbuf,
 				       bool encrypted)
 {
 	return -EOPNOTSUPP;
-- 
2.1.0

