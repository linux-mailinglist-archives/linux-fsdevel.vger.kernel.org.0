Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8396C545F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 19:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCVS6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 14:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCVS6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:58:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021396A42B;
        Wed, 22 Mar 2023 11:57:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so13643853wmb.5;
        Wed, 22 Mar 2023 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679511433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtXhyb26BXqwi0wU5zZbZV0leSQLNjOeF2ZQqIJ0HSE=;
        b=YQbBlOcBb7y26YH74UtMP5RSMofXeO46x+LRS+zSFZRaBUbB15jmcUSr4OR1JslUN6
         6f8AXTXkjWefLdGdI4qaD3gwY2qaiGQBcjOdvgGduIdChyPVqmzoaOWQAMVtmSrUI9Qq
         HVB298UcwMP1zJRRRPpV3zMFrP6DbhX6E/Wylk4Q/oDNnZ+V45eCc1/cVphoK3TupgNX
         i4F/UV8ZZaFgrFaLujYfLGEKx/F47p2PzjLt+Clz87CR7S40Pt0/6KmQ5wisx7omEvvr
         pcxgLK46CFPFdBB2Xcy0Waw+5BIKbvWFu5XRcEzZHSEOsZSnegJzrVp7ZGbcba+dbzwZ
         HAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679511433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtXhyb26BXqwi0wU5zZbZV0leSQLNjOeF2ZQqIJ0HSE=;
        b=GxMfP6TZa66XWLNigr9PNc/TkDCJSAB1C1cGgSAK+zI5VWMYRlVxKsyonFrRFOqRGE
         sL1M3HcZyShV9y+ylDAo62h7ojx17Mfqwfk6boy1vinno+rSp4ECvbMFLVfcaDidIcGH
         wFG1FQWgmTmNhLT8fFx3VyCwaqOfkpQJCWH3ZAb2moPJn0N1iMmBoaxnUuPepFwG0xX8
         6B+YYb22SFHM/N1FmybIcXFBU+1mAIg7HVTcXI03dW9IRUtTiCuNEJbWQkvqwp8bU+7G
         B9rlqR7R8K9oY3FbjY19HlH25KwgGuPgqGfIYZsXfCndSmwZ6Y97oFIzlB0GqthXtZ0P
         QEUw==
X-Gm-Message-State: AO0yUKVaobAeeBHqcCiyXaLDZ6w+8+ZL6N0FsTkdePFXFYB9hGo1cFxw
        0teC+za7BhgYDI5GzS4yLCM=
X-Google-Smtp-Source: AK7set/12gRCPhXh3oJNMNIy9LoU/A33JjuA74EPqStBDPSTAhduhVxhGIrV2fCsdASVS+E2NICgpw==
X-Received: by 2002:a7b:c38d:0:b0:3ee:5fa:5294 with SMTP id s13-20020a7bc38d000000b003ee05fa5294mr426151wmj.23.1679511433518;
        Wed, 22 Mar 2023 11:57:13 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id j21-20020a05600c42d500b003ee581f37a9sm3181241wme.10.2023.03.22.11.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 11:57:12 -0700 (PDT)
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
Subject: [PATCH v7 4/4] mm: vmalloc: convert vread() to vread_iter()
Date:   Wed, 22 Mar 2023 18:57:04 +0000
Message-Id: <941f88bc5ab928e6656e1e2593b91bf0f8c81e1b.1679511146.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679511146.git.lstoakes@gmail.com>
References: <cover.1679511146.git.lstoakes@gmail.com>
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
we dispense with it, and try to write to user memory optimistically but
with faults disabled via copy_page_to_iter_nofault(). We already have
preemption disabled by holding a spin lock. We continue faulting in until
the operation is complete.

Additionally, we must account for the fact that at any point a copy may
fail (most likely due to a fault not being able to occur), we exit
indicating fewer bytes retrieved than expected.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/proc/kcore.c         |  44 ++++----
 include/linux/vmalloc.h |   3 +-
 mm/nommu.c              |  10 +-
 mm/vmalloc.c            | 234 +++++++++++++++++++++++++---------------
 4 files changed, 176 insertions(+), 115 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 08b795fd80b4..25b44b303b35 100644
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
 	loff_t *fpos = &iocb->ki_pos;
-
 	size_t phdrs_offset, notes_offset, data_offset;
 	size_t page_offline_frozen = 1;
 	size_t phdrs_len, notes_len;
@@ -507,13 +503,30 @@ read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 		switch (m->type) {
 		case KCORE_VMALLOC:
-			vread(buf, (char *)start, tsz);
-			/* we have to zero-fill user buffer even if no read */
-			if (copy_to_iter(buf, tsz, iter) != tsz) {
-				ret = -EFAULT;
-				goto out;
+		{
+			const char *src = (char *)start;
+			size_t read = 0, left = tsz;
+
+			/*
+			 * vmalloc uses spinlocks, so we optimistically try to
+			 * read memory. If this fails, fault pages in and try
+			 * again until we are done.
+			 */
+			while (true) {
+				read += vread_iter(iter, src, left);
+				if (read == tsz)
+					break;
+
+				src += read;
+				left -= read;
+
+				if (fault_in_iov_iter_writeable(iter, left)) {
+					ret = -EFAULT;
+					goto out;
+				}
 			}
 			break;
+		}
 		case KCORE_USER:
 			/* User page is handled prior to normal kernel page: */
 			if (copy_to_iter((char *)start, tsz, iter) != tsz) {
@@ -582,10 +595,6 @@ static int open_kcore(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
-	filp->private_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!filp->private_data)
-		return -ENOMEM;
-
 	if (kcore_need_update)
 		kcore_update_ram();
 	if (i_size_read(inode) != proc_root_kcore->size) {
@@ -596,16 +605,9 @@ static int open_kcore(struct inode *inode, struct file *filp)
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
index 57ba243c6a37..f670d9979a26 100644
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
+long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
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
index 978194dc2bb8..629cd87bb403 100644
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
@@ -3442,62 +3441,96 @@ void *vmalloc_32_user(unsigned long size)
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
+		copied = copy_page_to_iter_nofault(ZERO_PAGE(0), 0, num, iter);
+		remains -= copied;
+
+		if (copied < num)
+			break;
+	}
 
-static int aligned_vread(char *buf, char *addr, unsigned long count)
+	return count - remains;
+}
+
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
+		 * copy_page_to_iter_nofault() and accept a small overhead in
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
+			copied = copy_page_to_iter_nofault(page, offset,
+							   length, iter);
+		else
+			copied = zero_iter(iter, length);
 
-		addr += length;
-		buf += length;
-		copied += length;
-		count -= length;
+		addr += copied;
+		remains -= copied;
+
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
+
+	remains = count;
 
 	/*
 	 * Area is split into regions and tracked with vmap_block, read out
@@ -3505,50 +3538,64 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
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

