Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57ABB471136
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 04:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345712AbhLKDhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 22:37:00 -0500
Received: from mail.loongson.cn ([114.242.206.163]:37174 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239512AbhLKDg4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 22:36:56 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax+sj1G7RhlA0GAA--.13327S3;
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
Subject: [PATCH v2 1/2] kdump: vmcore: remove copy_to() and add copy_to_user_or_kernel()
Date:   Sat, 11 Dec 2021 11:33:07 +0800
Message-Id: <1639193588-7027-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639193588-7027-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639193588-7027-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Ax+sj1G7RhlA0GAA--.13327S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy3Gr1kCrWfGw43Gry7GFg_yoWrtFy8pF
        n8trW3AF4Igr48XF1vkrsxur1Fq3Z7Wa1jg397W3WrZ3sxXrsxZa45JFyYgFW8XFyqkFyf
        GF9YgrZxK3yUXr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
        43ZEXa7VUU0PfPUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In arch/*/kernel/crash_dump*.c, there exist many similar code
about copy_oldmem_page(), remove copy_to() in fs/proc/vmcore.c
and add copy_to_user_or_kernel() in lib/usercopy.c, then we can
use copy_to_user_or_kernel() to simplify the related code.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 fs/proc/vmcore.c        | 28 +++++++---------------------
 include/linux/uaccess.h |  1 +
 lib/usercopy.c          | 15 +++++++++++++++
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 509f851..f67fd77 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -238,22 +238,8 @@ copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
 	return copy_oldmem_page(pfn, buf, csize, offset, userbuf);
 }
 
-/*
- * Copy to either kernel or user space
- */
-static int copy_to(void *target, void *src, size_t size, int userbuf)
-{
-	if (userbuf) {
-		if (copy_to_user((char __user *) target, src, size))
-			return -EFAULT;
-	} else {
-		memcpy(target, src, size);
-	}
-	return 0;
-}
-
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
-static int vmcoredd_copy_dumps(void *dst, u64 start, size_t size, int userbuf)
+static int vmcoredd_copy_dumps(void *dst, u64 start, size_t size, bool userbuf)
 {
 	struct vmcoredd_node *dump;
 	u64 offset = 0;
@@ -266,7 +252,7 @@ static int vmcoredd_copy_dumps(void *dst, u64 start, size_t size, int userbuf)
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
 			buf = dump->buf + start - offset;
-			if (copy_to(dst, buf, tsz, userbuf)) {
+			if (copy_to_user_or_kernel(dst, buf, tsz, userbuf)) {
 				ret = -EFAULT;
 				goto out_unlock;
 			}
@@ -330,7 +316,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
  * returned otherwise number of bytes read are returned.
  */
 static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
-			     int userbuf)
+			     bool userbuf)
 {
 	ssize_t acc = 0, tmp;
 	size_t tsz;
@@ -347,7 +333,7 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 	/* Read ELF core header */
 	if (*fpos < elfcorebuf_sz) {
 		tsz = min(elfcorebuf_sz - (size_t)*fpos, buflen);
-		if (copy_to(buffer, elfcorebuf + *fpos, tsz, userbuf))
+		if (copy_to_user_or_kernel(buffer, elfcorebuf + *fpos, tsz, userbuf))
 			return -EFAULT;
 		buflen -= tsz;
 		*fpos += tsz;
@@ -395,7 +381,7 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 		/* Read remaining elf notes */
 		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, buflen);
 		kaddr = elfnotes_buf + *fpos - elfcorebuf_sz - vmcoredd_orig_sz;
-		if (copy_to(buffer, kaddr, tsz, userbuf))
+		if (copy_to_user_or_kernel(buffer, kaddr, tsz, userbuf))
 			return -EFAULT;
 
 		buflen -= tsz;
@@ -435,7 +421,7 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 static ssize_t read_vmcore(struct file *file, char __user *buffer,
 			   size_t buflen, loff_t *fpos)
 {
-	return __read_vmcore((__force char *) buffer, buflen, fpos, 1);
+	return __read_vmcore((__force char *) buffer, buflen, fpos, true);
 }
 
 /*
@@ -461,7 +447,7 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 	if (!PageUptodate(page)) {
 		offset = (loff_t) index << PAGE_SHIFT;
 		buf = __va((page_to_pfn(page) << PAGE_SHIFT));
-		rc = __read_vmcore(buf, PAGE_SIZE, &offset, 0);
+		rc = __read_vmcore(buf, PAGE_SIZE, &offset, false);
 		if (rc < 0) {
 			unlock_page(page);
 			put_page(page);
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac03940..a25e682e 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -283,6 +283,7 @@ __copy_from_user_inatomic_nocache(void *to, const void __user *from,
 #endif		/* ARCH_HAS_NOCACHE_UACCESS */
 
 extern __must_check int check_zeroed_user(const void __user *from, size_t size);
+extern __must_check int copy_to_user_or_kernel(void *target, void *src, size_t size, bool userbuf);
 
 /**
  * copy_struct_from_user: copy a struct from userspace
diff --git a/lib/usercopy.c b/lib/usercopy.c
index 7413dd3..7431b1b 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -90,3 +90,18 @@ int check_zeroed_user(const void __user *from, size_t size)
 	return -EFAULT;
 }
 EXPORT_SYMBOL(check_zeroed_user);
+
+/*
+ * Copy to either user or kernel space
+ */
+int copy_to_user_or_kernel(void *target, void *src, size_t size, bool userbuf)
+{
+	if (userbuf) {
+		if (copy_to_user((char __user *) target, src, size))
+			return -EFAULT;
+	} else {
+		memcpy(target, src, size);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(copy_to_user_or_kernel);
-- 
2.1.0

