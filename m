Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846F56C3C4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 21:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCUUy7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 16:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCUUyr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:54:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9585955520;
        Tue, 21 Mar 2023 13:54:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m2so15054375wrh.6;
        Tue, 21 Mar 2023 13:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679432084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djyPCeztN5boBqxO3bRuQFLy3bknB1j3IWxmRWH4tok=;
        b=K2T9ISzZGBsjo+H3DC3xNn/GfV+dlSSaWpMyi0v9+VnMQbOp2uQZBGhOvfXUOdKPv7
         OjDNKZpaSqIwTM7/v/Zqqp8+MZu1slgfRyTyNUqzABdsK3pl+jYaTLt39YgsCMvTNrBR
         9KhudgegX2vpuDbkGzlfj2/3RuEkcBs3TSToa/yl0ro7kEuLoREzRnciju7WFD2eE0lO
         Ro+kFQgVS39f27HPCthzBpwQtcegWCYPoiGSU/keSc6JYUY968EBkXpF76ze3Ku7vUY2
         vr3b91LMfviYqyyomTIjHOcHrYgY1r+V3jVybqgjtLWfL1QOovsultE/bkUHKCZzkOWM
         lkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679432084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djyPCeztN5boBqxO3bRuQFLy3bknB1j3IWxmRWH4tok=;
        b=X6WytVbFGn4p0w8WWjwxWDJsxGB9b32YOFRBE1OG9JtPTLBaEaSJCaFlChuPYzvjyA
         0s5WOeL/R0Y2ydSGlbYJsLz3DE+tpi6blE/JoTCaXI80Jc8ABl5XxE25IwCAZ6TR24ym
         mgZ+TTD8XqFRByUwWRrMUxhtkPmwefpGnxKmHHSPfvRb0mZUL+WpQ+f32k4CDBYOFFET
         b6V8Sj46VvuIyS/6BWPBPDpZRXwbofwY8O7fZJsIeRfmeV5nyCCnNpQpNnD7ThRCNH1q
         P68LBR/ARldDQST8HidFujakfetbzS8JPehV0UZuUwB2+u+pQ2krGl9MEkZmmXLbDQE5
         VzRw==
X-Gm-Message-State: AO0yUKVU5BdP1BNglyDfdmva+TXBHBRgvbkcPJsmqQNwSqE+flU6QX50
        567BVq8yQu3DIcp9MM9YcIu3EFEd0vk=
X-Google-Smtp-Source: AK7set+i0F+Gcs9rYPy2oaxQ6DJCUcEdzchALZAnBYz6EMwAc4UbmZe+m094k7gbQKUk5tdBwOglnA==
X-Received: by 2002:adf:f74a:0:b0:2d1:7ade:aac with SMTP id z10-20020adff74a000000b002d17ade0aacmr3308849wrp.0.1679432083775;
        Tue, 21 Mar 2023 13:54:43 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id a8-20020a056000100800b002d8566128e5sm3744575wrx.25.2023.03.21.13.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:54:43 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 4/4] mm: vmalloc: convert vread() to vread_iter()
Date:   Tue, 21 Mar 2023 20:54:33 +0000
Message-Id: <6b3899bbbf1f4bd6b7133c8b6f27b3a8791607b0.1679431886.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679431886.git.lstoakes@gmail.com>
References: <cover.1679431886.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Having previously laid the foundation for converting vread() to an iterator
function, pull the trigger and do so.

This patch attempts to provide minimal refactoring and to reflect the
existing logic as best we can, for example we continue to zero portions of
memory not read, as before.

Overall, there should be no functional difference other than a performance
improvement in /proc/kcore access to vmalloc regions.

Now we have eliminated the need for a bounce buffer in read_kcore_iter(),
we dispense with it. We need to ensure userland pages are faulted in before
proceeding, as we take spin locks.

Additionally, we must account for the fact that at any point a copy may
fail if this happens, we exit indicating fewer bytes retrieved than
expected.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/proc/kcore.c         |  26 ++---
 include/linux/vmalloc.h |   3 +-
 mm/nommu.c              |  10 +-
 mm/vmalloc.c            | 234 +++++++++++++++++++++++++---------------
 4 files changed, 160 insertions(+), 113 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 25e0eeb8d498..221e16f75ba5 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -307,13 +307,9 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
 	*i = ALIGN(*i + descsz, 4);
 }
 
-static ssize_t
-read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
+static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct file *file = iocb->ki_filp;
-	char *buf = file->private_data;
 	loff_t *ppos = &iocb->ki_pos;
-
 	size_t phdrs_offset, notes_offset, data_offset;
 	size_t page_offline_frozen = 1;
 	size_t phdrs_len, notes_len;
@@ -507,9 +503,12 @@ read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 		switch (m->type) {
 		case KCORE_VMALLOC:
-			vread(buf, (char *)start, tsz);
-			/* we have to zero-fill user buffer even if no read */
-			if (copy_to_iter(buf, tsz, iter) != tsz) {
+			/*
+			 * Make sure user pages are faulted in as we acquire
+			 * spinlocks in vread_iter().
+			 */
+			if (fault_in_iov_iter_writeable(iter, tsz) ||
+			    vread_iter(iter, (char *)start, tsz) != tsz) {
 				ret = -EFAULT;
 				goto out;
 			}
@@ -582,10 +581,6 @@ static int open_kcore(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
-	filp->private_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!filp->private_data)
-		return -ENOMEM;
-
 	if (kcore_need_update)
 		kcore_update_ram();
 	if (i_size_read(inode) != proc_root_kcore->size) {
@@ -596,16 +591,9 @@ static int open_kcore(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int release_kcore(struct inode *inode, struct file *file)
-{
-	kfree(file->private_data);
-	return 0;
-}
-
 static const struct proc_ops kcore_proc_ops = {
 	.proc_read_iter	= read_kcore_iter,
 	.proc_open	= open_kcore,
-	.proc_release	= release_kcore,
 	.proc_lseek	= default_llseek,
 };
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 69250efa03d1..461aa5637f65 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -9,6 +9,7 @@
 #include <asm/page.h>		/* pgprot_t */
 #include <linux/rbtree.h>
 #include <linux/overflow.h>
+#include <linux/uio.h>
 
 #include <asm/vmalloc.h>
 
@@ -251,7 +252,7 @@ static inline void set_vm_flush_reset_perms(void *addr)
 #endif
 
 /* for /proc/kcore */
-extern long vread(char *buf, char *addr, unsigned long count);
+extern long vread_iter(struct iov_iter *iter, const char *addr, size_t count);
 
 /*
  *	Internals.  Don't use..
diff --git a/mm/nommu.c b/mm/nommu.c
index 57ba243c6a37..e0fcd948096e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -36,6 +36,7 @@
 #include <linux/printk.h>
 
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -198,14 +199,13 @@ unsigned long vmalloc_to_pfn(const void *addr)
 }
 EXPORT_SYMBOL(vmalloc_to_pfn);
 
-long vread(char *buf, char *addr, unsigned long count)
+long vread_iter(struct iov_iter *iter, char *addr, size_t count)
 {
 	/* Don't allow overflow */
-	if ((unsigned long) buf + count < count)
-		count = -(unsigned long) buf;
+	if ((unsigned long) addr + count < count)
+		count = -(unsigned long) addr;
 
-	memcpy(buf, addr, count);
-	return count;
+	return copy_to_iter(addr, count, iter);
 }
 
 /*
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 978194dc2bb8..ebfa1e9fe6f9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -37,7 +37,6 @@
 #include <linux/rbtree_augmented.h>
 #include <linux/overflow.h>
 #include <linux/pgtable.h>
-#include <linux/uaccess.h>
 #include <linux/hugetlb.h>
 #include <linux/sched/mm.h>
 #include <asm/tlbflush.h>
@@ -3442,62 +3441,95 @@ void *vmalloc_32_user(unsigned long size)
 EXPORT_SYMBOL(vmalloc_32_user);
 
 /*
- * small helper routine , copy contents to buf from addr.
- * If the page is not present, fill zero.
+ * Atomically zero bytes in the iterator.
+ *
+ * Returns the number of zeroed bytes.
  */
+size_t zero_iter(struct iov_iter *iter, size_t count)
+{
+	size_t remains = count;
+
+	while (remains > 0) {
+		size_t num, copied;
+
+		num = remains < PAGE_SIZE ? remains : PAGE_SIZE;
+		copied = copy_page_to_iter_atomic(ZERO_PAGE(0), 0, num, iter);
+		remains -= copied;
+
+		if (copied < num)
+			break;
+	}
+
+	return count - remains;
+}
 
-static int aligned_vread(char *buf, char *addr, unsigned long count)
+/*
+ * small helper routine, copy contents to iter from addr.
+ * If the page is not present, fill zero.
+ *
+ * Returns the number of copied bytes.
+ */
+static size_t aligned_vread_iter(struct iov_iter *iter,
+				 const char *addr, size_t count)
 {
-	struct page *p;
-	int copied = 0;
+	size_t remains = count;
+	struct page *page;
 
-	while (count) {
+	while (remains > 0) {
 		unsigned long offset, length;
+		size_t copied = 0;
 
 		offset = offset_in_page(addr);
 		length = PAGE_SIZE - offset;
-		if (length > count)
-			length = count;
-		p = vmalloc_to_page(addr);
+		if (length > remains)
+			length = remains;
+		page = vmalloc_to_page(addr);
 		/*
-		 * To do safe access to this _mapped_ area, we need
-		 * lock. But adding lock here means that we need to add
-		 * overhead of vmalloc()/vfree() calls for this _debug_
-		 * interface, rarely used. Instead of that, we'll use
-		 * kmap() and get small overhead in this access function.
+		 * To do safe access to this _mapped_ area, we need lock. But
+		 * adding lock here means that we need to add overhead of
+		 * vmalloc()/vfree() calls for this _debug_ interface, rarely
+		 * used. Instead of that, we'll use an local mapping via
+		 * copy_page_to_iter_atomic() and accept a small overhead in
+		 * this access function.
 		 */
-		if (p) {
-			/* We can expect USER0 is not used -- see vread() */
-			void *map = kmap_atomic(p);
-			memcpy(buf, map + offset, length);
-			kunmap_atomic(map);
-		} else
-			memset(buf, 0, length);
+		if (page)
+			copied = copy_page_to_iter_atomic(page, offset, length,
+							  iter);
+
+		/* Zero anything we were unable to copy. */
+		copied += zero_iter(iter, length - copied);
+
+		addr += copied;
+		remains -= copied;
 
-		addr += length;
-		buf += length;
-		copied += length;
-		count -= length;
+		if (copied != length)
+			break;
 	}
-	return copied;
+
+	return count - remains;
 }
 
-static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags)
+/*
+ * Read from a vm_map_ram region of memory.
+ *
+ * Returns the number of copied bytes.
+ */
+static size_t vmap_ram_vread_iter(struct iov_iter *iter, const char *addr,
+				  size_t count, unsigned long flags)
 {
 	char *start;
 	struct vmap_block *vb;
 	unsigned long offset;
-	unsigned int rs, re, n;
+	unsigned int rs, re;
+	size_t remains, n;
 
 	/*
 	 * If it's area created by vm_map_ram() interface directly, but
 	 * not further subdividing and delegating management to vmap_block,
 	 * handle it here.
 	 */
-	if (!(flags & VMAP_BLOCK)) {
-		aligned_vread(buf, addr, count);
-		return;
-	}
+	if (!(flags & VMAP_BLOCK))
+		return aligned_vread_iter(iter, addr, count);
 
 	/*
 	 * Area is split into regions and tracked with vmap_block, read out
@@ -3505,50 +3537,65 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 	 */
 	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
 	if (!vb)
-		goto finished;
+		goto finished_zero;
 
 	spin_lock(&vb->lock);
 	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
 		spin_unlock(&vb->lock);
-		goto finished;
+		goto finished_zero;
 	}
+
+	remains = count;
 	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
-		if (!count)
-			break;
+		size_t copied;
+
+		if (remains == 0)
+			goto finished;
+
 		start = vmap_block_vaddr(vb->va->va_start, rs);
-		while (addr < start) {
-			if (count == 0)
-				goto unlock;
-			*buf = '\0';
-			buf++;
-			addr++;
-			count--;
+
+		if (addr < start) {
+			size_t to_zero = min_t(size_t, start - addr, remains);
+			size_t zeroed = zero_iter(iter, to_zero);
+
+			addr += zeroed;
+			remains -= zeroed;
+
+			if (remains == 0 || zeroed != to_zero)
+				goto finished;
 		}
+
 		/*it could start reading from the middle of used region*/
 		offset = offset_in_page(addr);
 		n = ((re - rs + 1) << PAGE_SHIFT) - offset;
-		if (n > count)
-			n = count;
-		aligned_vread(buf, start+offset, n);
+		if (n > remains)
+			n = remains;
+
+		copied = aligned_vread_iter(iter, start + offset, n);
 
-		buf += n;
-		addr += n;
-		count -= n;
+		addr += copied;
+		remains -= copied;
+
+		if (copied != n)
+			goto finished;
 	}
-unlock:
+
 	spin_unlock(&vb->lock);
 
-finished:
+finished_zero:
 	/* zero-fill the left dirty or free regions */
-	if (count)
-		memset(buf, 0, count);
+	return count - remains + zero_iter(iter, remains);
+finished:
+	/* We couldn't copy/zero everything */
+	spin_unlock(&vb->lock);
+	return count - remains;
 }
 
 /**
- * vread() - read vmalloc area in a safe way.
- * @buf:     buffer for reading data
- * @addr:    vm address.
- * @count:   number of bytes to be read.
+ * vread_iter() - read vmalloc area in a safe way to an iterator.
+ * @iter:         the iterator to which data should be written.
+ * @addr:         vm address.
+ * @count:        number of bytes to be read.
  *
  * This function checks that addr is a valid vmalloc'ed area, and
  * copy data from that area to a given buffer. If the given memory range
@@ -3568,13 +3615,12 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
  * (same number as @count) or %0 if [addr...addr+count) doesn't
  * include any intersection with valid vmalloc area
  */
-long vread(char *buf, char *addr, unsigned long count)
+long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 {
 	struct vmap_area *va;
 	struct vm_struct *vm;
-	char *vaddr, *buf_start = buf;
-	unsigned long buflen = count;
-	unsigned long n, size, flags;
+	char *vaddr;
+	size_t n, size, flags, remains;
 
 	addr = kasan_reset_tag(addr);
 
@@ -3582,18 +3628,22 @@ long vread(char *buf, char *addr, unsigned long count)
 	if ((unsigned long) addr + count < count)
 		count = -(unsigned long) addr;
 
+	remains = count;
+
 	spin_lock(&vmap_area_lock);
 	va = find_vmap_area_exceed_addr((unsigned long)addr);
 	if (!va)
-		goto finished;
+		goto finished_zero;
 
 	/* no intersects with alive vmap_area */
-	if ((unsigned long)addr + count <= va->va_start)
-		goto finished;
+	if ((unsigned long)addr + remains <= va->va_start)
+		goto finished_zero;
 
 	list_for_each_entry_from(va, &vmap_area_list, list) {
-		if (!count)
-			break;
+		size_t copied;
+
+		if (remains == 0)
+			goto finished;
 
 		vm = va->vm;
 		flags = va->flags & VMAP_FLAGS_MASK;
@@ -3608,6 +3658,7 @@ long vread(char *buf, char *addr, unsigned long count)
 
 		if (vm && (vm->flags & VM_UNINITIALIZED))
 			continue;
+
 		/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
 		smp_rmb();
 
@@ -3616,38 +3667,45 @@ long vread(char *buf, char *addr, unsigned long count)
 
 		if (addr >= vaddr + size)
 			continue;
-		while (addr < vaddr) {
-			if (count == 0)
+
+		if (addr < vaddr) {
+			size_t to_zero = min_t(size_t, vaddr - addr, remains);
+			size_t zeroed = zero_iter(iter, to_zero);
+
+			addr += zeroed;
+			remains -= zeroed;
+
+			if (remains == 0 || zeroed != to_zero)
 				goto finished;
-			*buf = '\0';
-			buf++;
-			addr++;
-			count--;
 		}
+
 		n = vaddr + size - addr;
-		if (n > count)
-			n = count;
+		if (n > remains)
+			n = remains;
 
 		if (flags & VMAP_RAM)
-			vmap_ram_vread(buf, addr, n, flags);
+			copied = vmap_ram_vread_iter(iter, addr, n, flags);
 		else if (!(vm->flags & VM_IOREMAP))
-			aligned_vread(buf, addr, n);
+			copied = aligned_vread_iter(iter, addr, n);
 		else /* IOREMAP area is treated as memory hole */
-			memset(buf, 0, n);
-		buf += n;
-		addr += n;
-		count -= n;
+			copied = zero_iter(iter, n);
+
+		addr += copied;
+		remains -= copied;
+
+		if (copied != n)
+			goto finished;
 	}
-finished:
-	spin_unlock(&vmap_area_lock);
 
-	if (buf == buf_start)
-		return 0;
+finished_zero:
+	spin_unlock(&vmap_area_lock);
 	/* zero-fill memory holes */
-	if (buf != buf_start + buflen)
-		memset(buf, 0, buflen - (buf - buf_start));
+	return count - remains + zero_iter(iter, remains);
+finished:
+	/* Nothing remains, or We couldn't copy/zero everything. */
+	spin_unlock(&vmap_area_lock);
 
-	return buflen;
+	return count - remains;
 }
 
 /**
-- 
2.39.2

