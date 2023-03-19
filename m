Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A9C6BFFB4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 08:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCSHJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCSHJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:09:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0218820574;
        Sun, 19 Mar 2023 00:09:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o12so35399557edb.9;
        Sun, 19 Mar 2023 00:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679209785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay2I6E7X+s9rgNiMvSqEAwkwcRQ0HQ/eFKvjtZ5gGaM=;
        b=qg4JfEok2IbeOBbE15vPGb6fxFMwm3osYe4121wl6/wuw3nUKAZTo9eCXEHKEAucps
         Z3g1QJDJngKzPz7zzLGyFr73SQob7YMOhEAq0N69oguhcAsph5uBh3qo1oul4LtpT3ez
         UTUQeDn6ShR1299B7Nc3LXa3OOe4b+t+F7SP5So37OcHxQYUOcpRXbyZZ/R7DQicuK5S
         ze/qeriWyym5iwBvoz9CcNZBjzhaq+dlH9N6msil+nI+DUhYvRQqaW7T2AgmhvFiB5VN
         1mKeCZ3GDWhP3w8nHLrKwQElB259N50qABO2XV4NJqOggvgz47KhxPD0BiopioEU1sTB
         /Uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679209785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay2I6E7X+s9rgNiMvSqEAwkwcRQ0HQ/eFKvjtZ5gGaM=;
        b=OZ56LEts+l9WHqdQYVn5GtU62FuunrtstqbuVyZKrluzbOLnsuNBMINy1Ut1q8Q6Gr
         WVT+pxBkLKvJV3E/5w7ww//9fiUxQT/498cn+cLOhf7yV47WM4GdUXt5wQkFmclEuRIy
         8BVCuAOHc0RcFZrzE+zdhRt6R1zmg9t+WGKL00Gh+GrrEppDwUEu4e1MmH1WAOFfrvWx
         r6JlQ5N3/bdGx74rHEf7jE3bki4t+zTCfxQh/sIyaS9YFdvscyJKbkXW0F5WHyzZhYCF
         URlqCIHiJlQJcf7oTQOT9lny6tx9Xk36IRgv2b/mX1Aju+Ji/prgc0AFEDEBq3wNMLNi
         b9iQ==
X-Gm-Message-State: AO0yUKUvMDNfWakkKwjz4zacqRt57NHsXChL5W2qYD66uV/t+JcKLppx
        UcdPtZQgJmt9YVoGstlyqek=
X-Google-Smtp-Source: AK7set+FByhR3QDaaOdxDdO9lHVIRn8pNe8XzlgLkLTytG+TSg8g/xKLS2t/Br17U/XJKeK5a1dHCg==
X-Received: by 2002:a17:906:69c9:b0:870:b950:18d4 with SMTP id g9-20020a17090669c900b00870b95018d4mr5272766ejs.5.1679209785207;
        Sun, 19 Mar 2023 00:09:45 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23ee:1938:1bcd:c6e1:42ba:ae87:772e])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170906b10800b008c9b44b7851sm2943920ejy.182.2023.03.19.00.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 00:09:44 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 4/4] mm: vmalloc: convert vread() to vread_iter()
Date:   Sun, 19 Mar 2023 07:09:33 +0000
Message-Id: <7f9dad4deade9639cf7af7a8b01143bca882ff02.1679209395.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679209395.git.lstoakes@gmail.com>
References: <cover.1679209395.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Having previously laid the foundation for converting vread() to an iterator
function, pull the trigger and do so.

This patch attempts to provide minimal refactoring and to reflect the
existing logic as best we can, with the exception of aligned_vread_iter()
which drops the use of the deprecated kmap_atomic() in favour of
kmap_local_page().

All existing logic to zero portions of memory not read remain and there
should be no functional difference other than a performance improvement in
/proc/kcore access to vmalloc regions.

Now we have discarded with the need for a bounce buffer at all in
read_kcore_iter(), we dispense with the one allocated there altogether.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/proc/kcore.c         |  21 +--------
 include/linux/vmalloc.h |   3 +-
 mm/nommu.c              |  10 ++--
 mm/vmalloc.c            | 101 +++++++++++++++++++++-------------------
 4 files changed, 62 insertions(+), 73 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 25e0eeb8d498..a0ed3ca35cce 100644
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
@@ -507,9 +503,7 @@ read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 		switch (m->type) {
 		case KCORE_VMALLOC:
-			vread(buf, (char *)start, tsz);
-			/* we have to zero-fill user buffer even if no read */
-			if (copy_to_iter(buf, tsz, iter) != tsz) {
+			if (vread_iter(iter, (char *)start, tsz) != tsz) {
 				ret = -EFAULT;
 				goto out;
 			}
@@ -582,10 +576,6 @@ static int open_kcore(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
-	filp->private_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!filp->private_data)
-		return -ENOMEM;
-
 	if (kcore_need_update)
 		kcore_update_ram();
 	if (i_size_read(inode) != proc_root_kcore->size) {
@@ -596,16 +586,9 @@ static int open_kcore(struct inode *inode, struct file *filp)
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
index 69250efa03d1..6beb2ace6a7a 100644
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
+extern long vread_iter(struct iov_iter *iter, char *addr, size_t count);
 
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
index c24b27664a97..f19509a6eef4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -37,7 +37,6 @@
 #include <linux/rbtree_augmented.h>
 #include <linux/overflow.h>
 #include <linux/pgtable.h>
-#include <linux/uaccess.h>
 #include <linux/hugetlb.h>
 #include <linux/sched/mm.h>
 #include <linux/rwsem.h>
@@ -3446,20 +3445,20 @@ EXPORT_SYMBOL(vmalloc_32_user);
  * small helper routine , copy contents to buf from addr.
  * If the page is not present, fill zero.
  */
-
-static int aligned_vread(char *buf, char *addr, unsigned long count)
+static void aligned_vread_iter(struct iov_iter *iter,
+			       char *addr, size_t count)
 {
-	struct page *p;
-	int copied = 0;
+	struct page *page;
 
-	while (count) {
+	while (count > 0) {
 		unsigned long offset, length;
+		size_t copied = 0;
 
 		offset = offset_in_page(addr);
 		length = PAGE_SIZE - offset;
 		if (length > count)
 			length = count;
-		p = vmalloc_to_page(addr);
+		page = vmalloc_to_page(addr);
 		/*
 		 * To do safe access to this _mapped_ area, we need
 		 * lock. But adding lock here means that we need to add
@@ -3467,23 +3466,24 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
 		 * interface, rarely used. Instead of that, we'll use
 		 * kmap() and get small overhead in this access function.
 		 */
-		if (p) {
+		if (page) {
 			/* We can expect USER0 is not used -- see vread() */
-			void *map = kmap_atomic(p);
-			memcpy(buf, map + offset, length);
-			kunmap_atomic(map);
-		} else
-			memset(buf, 0, length);
+			void *map = kmap_local_page(page);
+
+			copied = copy_to_iter(map + offset, length, iter);
+			kunmap_local(map);
+		}
+
+		if (copied < length)
+			iov_iter_zero(length - copied, iter);
 
 		addr += length;
-		buf += length;
-		copied += length;
 		count -= length;
 	}
-	return copied;
 }
 
-static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags)
+static void vmap_ram_vread_iter(struct iov_iter *iter, char *addr, int count,
+				unsigned long flags)
 {
 	char *start;
 	struct vmap_block *vb;
@@ -3496,7 +3496,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 	 * handle it here.
 	 */
 	if (!(flags & VMAP_BLOCK)) {
-		aligned_vread(buf, addr, count);
+		aligned_vread_iter(iter, addr, count);
 		return;
 	}
 
@@ -3517,22 +3517,24 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 		if (!count)
 			break;
 		start = vmap_block_vaddr(vb->va->va_start, rs);
-		while (addr < start) {
+
+		if (addr < start) {
+			size_t to_zero = min_t(size_t, start - addr, count);
+
+			iov_iter_zero(to_zero, iter);
+			addr += to_zero;
+			count -= (int)to_zero;
 			if (count == 0)
 				goto unlock;
-			*buf = '\0';
-			buf++;
-			addr++;
-			count--;
 		}
+
 		/*it could start reading from the middle of used region*/
 		offset = offset_in_page(addr);
 		n = ((re - rs + 1) << PAGE_SHIFT) - offset;
 		if (n > count)
 			n = count;
-		aligned_vread(buf, start+offset, n);
+		aligned_vread_iter(iter, start + offset, n);
 
-		buf += n;
 		addr += n;
 		count -= n;
 	}
@@ -3541,15 +3543,15 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 
 finished:
 	/* zero-fill the left dirty or free regions */
-	if (count)
-		memset(buf, 0, count);
+	if (count > 0)
+		iov_iter_zero(count, iter);
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
@@ -3569,13 +3571,13 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
  * (same number as @count) or %0 if [addr...addr+count) doesn't
  * include any intersection with valid vmalloc area
  */
-long vread(char *buf, char *addr, unsigned long count)
+long vread_iter(struct iov_iter *iter, char *addr, size_t count)
 {
 	struct vmap_area *va;
 	struct vm_struct *vm;
-	char *vaddr, *buf_start = buf;
-	unsigned long buflen = count;
-	unsigned long n, size, flags;
+	char *vaddr;
+	size_t buflen = count;
+	size_t n, size, flags;
 
 	might_sleep();
 
@@ -3595,7 +3597,7 @@ long vread(char *buf, char *addr, unsigned long count)
 		goto finished;
 
 	list_for_each_entry_from(va, &vmap_area_list, list) {
-		if (!count)
+		if (count == 0)
 			break;
 
 		vm = va->vm;
@@ -3619,36 +3621,39 @@ long vread(char *buf, char *addr, unsigned long count)
 
 		if (addr >= vaddr + size)
 			continue;
-		while (addr < vaddr) {
+
+		if (addr < vaddr) {
+			size_t to_zero = min_t(size_t, vaddr - addr, count);
+
+			iov_iter_zero(to_zero, iter);
+			addr += to_zero;
+			count -= to_zero;
 			if (count == 0)
 				goto finished;
-			*buf = '\0';
-			buf++;
-			addr++;
-			count--;
 		}
+
 		n = vaddr + size - addr;
 		if (n > count)
 			n = count;
 
 		if (flags & VMAP_RAM)
-			vmap_ram_vread(buf, addr, n, flags);
+			vmap_ram_vread_iter(iter, addr, n, flags);
 		else if (!(vm->flags & VM_IOREMAP))
-			aligned_vread(buf, addr, n);
+			aligned_vread_iter(iter, addr, n);
 		else /* IOREMAP area is treated as memory hole */
-			memset(buf, 0, n);
-		buf += n;
+			iov_iter_zero(n, iter);
+
 		addr += n;
 		count -= n;
 	}
 finished:
 	up_read(&vmap_area_lock);
 
-	if (buf == buf_start)
+	if (count == buflen)
 		return 0;
 	/* zero-fill memory holes */
-	if (buf != buf_start + buflen)
-		memset(buf, 0, buflen - (buf - buf_start));
+	if (count > 0)
+		iov_iter_zero(count, iter);
 
 	return buflen;
 }
-- 
2.39.2

