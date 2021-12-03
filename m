Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095F246754E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 11:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351769AbhLCKqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 05:46:16 -0500
Received: from foss.arm.com ([217.140.110.172]:46914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351767AbhLCKqP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:46:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A2021435;
        Fri,  3 Dec 2021 02:42:52 -0800 (PST)
Received: from a077416.arm.com (unknown [10.163.33.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01A703F5A1;
        Fri,  3 Dec 2021 02:42:46 -0800 (PST)
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
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, x86 <x86@kernel.org>
Subject: [RFC PATCH 01/14] fs/proc/vmcore: Update read_from_oldmem() for user pointer
Date:   Fri,  3 Dec 2021 16:12:18 +0530
Message-Id: <20211203104231.17597-2-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203104231.17597-1-amit.kachhap@arm.com>
References: <20211203104231.17597-1-amit.kachhap@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The exported interface read_from_oldmem() passes user pointer
without __user annotation and does unnecessary user/kernel pointer
conversions during the pointer propagation.

Hence it is modified to have a new parameter for user pointer.

Also a helper macro read_from_oldmem_to_kernel is added for clear
readability from callsite when calling read_from_oldmem() for copying
to kernel buffer.

There are several internal functions used here such as read_vmcore(),
__read_vmcore(), copy_to() and vmcoredd_copy_dumps() which are
re-structured to avoid the unnecessary user/kernel pointer conversions.

x86_64 crash dump is also modified to use this new interface.

No functionality change intended.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: x86 <x86@kernel.org>
Cc: kexec <kexec@lists.infradead.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 arch/x86/kernel/crash_dump_64.c |  4 +-
 fs/proc/vmcore.c                | 88 +++++++++++++++++++--------------
 include/linux/crash_dump.h      | 12 +++--
 3 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index a7f617a3981d..6433513ef43a 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -74,6 +74,6 @@ ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
 
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0,
-				cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
+	return read_from_oldmem_to_kernel(buf, count, ppos,
+					  cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
 }
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 509f85148fee..39b4353bd37c 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -70,6 +70,14 @@ static bool vmcore_cb_unstable;
 /* Whether the vmcore has been opened once. */
 static bool vmcore_opened;
 
+#define ptr_add(utarget, ktarget, size)		\
+({						\
+	if (utarget)				\
+		utarget += size;		\
+	else					\
+		ktarget += size;		\
+})
+
 void register_vmcore_cb(struct vmcore_cb *cb)
 {
 	down_write(&vmcore_cb_rwsem);
@@ -132,9 +140,8 @@ static int open_vmcore(struct inode *inode, struct file *file)
 }
 
 /* Reads a page from the oldmem device from given offset. */
-ssize_t read_from_oldmem(char *buf, size_t count,
-			 u64 *ppos, int userbuf,
-			 bool encrypted)
+ssize_t read_from_oldmem(char __user *ubuf, char *kbuf, size_t count,
+			 u64 *ppos, bool encrypted)
 {
 	unsigned long pfn, offset;
 	size_t nr_bytes;
@@ -156,19 +163,27 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 		/* If pfn is not ram, return zeros for sparse dump files */
 		if (!pfn_is_ram(pfn)) {
 			tmp = 0;
-			if (!userbuf)
-				memset(buf, 0, nr_bytes);
-			else if (clear_user(buf, nr_bytes))
+			if (kbuf)
+				memset(kbuf, 0, nr_bytes);
+			else if (clear_user(ubuf, nr_bytes))
 				tmp = -EFAULT;
 		} else {
-			if (encrypted)
-				tmp = copy_oldmem_page_encrypted(pfn, buf,
+			if (encrypted && ubuf)
+				tmp = copy_oldmem_page_encrypted(pfn,
+								 (__force char *)ubuf,
+								 nr_bytes,
+								 offset, 1);
+			else if (encrypted && kbuf)
+				tmp = copy_oldmem_page_encrypted(pfn,
+								 kbuf,
 								 nr_bytes,
-								 offset,
-								 userbuf);
+								 offset, 0);
+			else if (ubuf)
+				tmp = copy_oldmem_page(pfn, (__force char *)ubuf,
+						       nr_bytes, offset, 1);
 			else
-				tmp = copy_oldmem_page(pfn, buf, nr_bytes,
-						       offset, userbuf);
+				tmp = copy_oldmem_page(pfn, kbuf, nr_bytes,
+						       offset, 0);
 		}
 		if (tmp < 0) {
 			up_read(&vmcore_cb_rwsem);
@@ -177,7 +192,7 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 
 		*ppos += nr_bytes;
 		count -= nr_bytes;
-		buf += nr_bytes;
+		ptr_add(ubuf, kbuf, nr_bytes);
 		read += nr_bytes;
 		++pfn;
 		offset = 0;
@@ -206,7 +221,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, false);
+	return read_from_oldmem_to_kernel(buf, count, ppos, false);
 }
 
 /*
@@ -214,7 +229,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, cc_platform_has(CC_ATTR_MEM_ENCRYPT));
+	return read_from_oldmem_to_kernel(buf, count, ppos, cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 }
 
 /*
@@ -239,21 +254,21 @@ copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
 }
 
 /*
- * Copy to either kernel or user space
+ * Copy to either kernel or user space buffer
  */
-static int copy_to(void *target, void *src, size_t size, int userbuf)
+static int copy_to(void __user *utarget, void *ktarget, void *src, size_t size)
 {
-	if (userbuf) {
-		if (copy_to_user((char __user *) target, src, size))
+	if (utarget) {
+		if (copy_to_user(utarget, src, size))
 			return -EFAULT;
 	} else {
-		memcpy(target, src, size);
+		memcpy(ktarget, src, size);
 	}
 	return 0;
 }
 
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
-static int vmcoredd_copy_dumps(void *dst, u64 start, size_t size, int userbuf)
+static int vmcoredd_copy_dumps(void __user *udst, void *kdst, u64 start, size_t size)
 {
 	struct vmcoredd_node *dump;
 	u64 offset = 0;
@@ -266,15 +281,14 @@ static int vmcoredd_copy_dumps(void *dst, u64 start, size_t size, int userbuf)
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
 			buf = dump->buf + start - offset;
-			if (copy_to(dst, buf, tsz, userbuf)) {
+			if (copy_to(udst, kdst, buf, tsz)) {
 				ret = -EFAULT;
 				goto out_unlock;
 			}
 
 			size -= tsz;
 			start += tsz;
-			dst += tsz;
-
+			ptr_add(udst, kdst, tsz);
 			/* Leave now if buffer filled already */
 			if (!size)
 				goto out_unlock;
@@ -329,8 +343,8 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 /* Read from the ELF header and then the crash dump. On error, negative value is
  * returned otherwise number of bytes read are returned.
  */
-static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
-			     int userbuf)
+static ssize_t __read_vmcore(char __user *ubuffer, char *kbuffer, size_t buflen,
+			     loff_t *fpos)
 {
 	ssize_t acc = 0, tmp;
 	size_t tsz;
@@ -347,11 +361,11 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 	/* Read ELF core header */
 	if (*fpos < elfcorebuf_sz) {
 		tsz = min(elfcorebuf_sz - (size_t)*fpos, buflen);
-		if (copy_to(buffer, elfcorebuf + *fpos, tsz, userbuf))
+		if (copy_to(ubuffer, kbuffer, elfcorebuf + *fpos, tsz))
 			return -EFAULT;
 		buflen -= tsz;
 		*fpos += tsz;
-		buffer += tsz;
+		ptr_add(ubuffer, kbuffer, tsz);
 		acc += tsz;
 
 		/* leave now if filled buffer already */
@@ -378,12 +392,12 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 			tsz = min(elfcorebuf_sz + vmcoredd_orig_sz -
 				  (size_t)*fpos, buflen);
 			start = *fpos - elfcorebuf_sz;
-			if (vmcoredd_copy_dumps(buffer, start, tsz, userbuf))
+			if (vmcoredd_copy_dumps(ubuffer, kbuffer, start, tsz))
 				return -EFAULT;
 
 			buflen -= tsz;
 			*fpos += tsz;
-			buffer += tsz;
+			ptr_add(ubuffer, kbuffer, tsz);
 			acc += tsz;
 
 			/* leave now if filled buffer already */
@@ -395,12 +409,12 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 		/* Read remaining elf notes */
 		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, buflen);
 		kaddr = elfnotes_buf + *fpos - elfcorebuf_sz - vmcoredd_orig_sz;
-		if (copy_to(buffer, kaddr, tsz, userbuf))
+		if (copy_to(ubuffer, kbuffer, kaddr, tsz))
 			return -EFAULT;
 
 		buflen -= tsz;
 		*fpos += tsz;
-		buffer += tsz;
+		ptr_add(ubuffer, kbuffer, tsz);
 		acc += tsz;
 
 		/* leave now if filled buffer already */
@@ -414,13 +428,13 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 					    m->offset + m->size - *fpos,
 					    buflen);
 			start = m->paddr + *fpos - m->offset;
-			tmp = read_from_oldmem(buffer, tsz, &start,
-					       userbuf, cc_platform_has(CC_ATTR_MEM_ENCRYPT));
+			tmp = read_from_oldmem(ubuffer, kbuffer, tsz, &start,
+					       cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
 			*fpos += tsz;
-			buffer += tsz;
+			ptr_add(ubuffer, kbuffer, tsz);
 			acc += tsz;
 
 			/* leave now if filled buffer already */
@@ -435,7 +449,7 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 static ssize_t read_vmcore(struct file *file, char __user *buffer,
 			   size_t buflen, loff_t *fpos)
 {
-	return __read_vmcore((__force char *) buffer, buflen, fpos, 1);
+	return __read_vmcore(buffer, NULL, buflen, fpos);
 }
 
 /*
@@ -461,7 +475,7 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 	if (!PageUptodate(page)) {
 		offset = (loff_t) index << PAGE_SHIFT;
 		buf = __va((page_to_pfn(page) << PAGE_SHIFT));
-		rc = __read_vmcore(buf, PAGE_SIZE, &offset, 0);
+		rc = __read_vmcore(NULL, buf, PAGE_SIZE, &offset);
 		if (rc < 0) {
 			unlock_page(page);
 			put_page(page);
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 620821549b23..eb0ed423ccc8 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -135,16 +135,18 @@ static inline int vmcore_add_device_dump(struct vmcoredd_data *data)
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
 #ifdef CONFIG_PROC_VMCORE
-ssize_t read_from_oldmem(char *buf, size_t count,
-			 u64 *ppos, int userbuf,
-			 bool encrypted);
+ssize_t read_from_oldmem(char __user *ubuf, char *kbuf, size_t count,
+			 u64 *ppos, bool encrypted);
 #else
-static inline ssize_t read_from_oldmem(char *buf, size_t count,
-				       u64 *ppos, int userbuf,
+static inline ssize_t read_from_oldmem(char __user *ubuf, char *kbuf,
+				       size_t count, u64 *ppos,
 				       bool encrypted)
 {
 	return -EOPNOTSUPP;
 }
 #endif /* CONFIG_PROC_VMCORE */
 
+#define read_from_oldmem_to_kernel(buf, count, ppos, encrypted)	\
+	read_from_oldmem(NULL, buf, count, ppos, encrypted)
+
 #endif /* LINUX_CRASHDUMP_H */
-- 
2.17.1

