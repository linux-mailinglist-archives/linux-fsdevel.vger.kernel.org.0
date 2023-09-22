Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D22D7AB0D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 13:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjIVLcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 07:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjIVLb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E3D1B3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695382264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVEbGW4BLJF1l/4uNaMtMi83HInwhhC15AgRCPKnf+k=;
        b=HpBBIk45XkAc+SMAaqXPJI4OOGVEJWkQmU5jXNX0uUZARivoRGaCHLvVhkhB22QXb7HXeh
        IjPYIjXaOsVrgQ/Fv4r8bmRlb1zRt8PrRo/ZWwp8syTVuitJQfaujdsiR445y5CE4IHBjJ
        vqdyw45JKLcj6EGum32iYAMHO0KRpWo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-3grvvCggPbu-u3y6M0hRxA-1; Fri, 22 Sep 2023 07:31:01 -0400
X-MC-Unique: 3grvvCggPbu-u3y6M0hRxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AA49803498;
        Fri, 22 Sep 2023 11:31:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88E1340C2064;
        Fri, 22 Sep 2023 11:30:56 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, loongarch@lists.linux.dev,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 05/10] iov_iter: Create a function to prepare userspace VM for UBUF/IOVEC tests
Date:   Fri, 22 Sep 2023 12:30:33 +0100
Message-ID: <20230922113038.1135236-6-dhowells@redhat.com>
In-Reply-To: <20230922113038.1135236-1-dhowells@redhat.com>
References: <20230922113038.1135236-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create a function to set up a userspace VM for the kunit testing thread and
set up a buffer within it such that ITER_UBUF and ITER_IOVEC tests can be
performed.

Note that this requires current->mm to point to a sufficiently set up
mm_struct.  This is done by partially mirroring what execve does.

The following steps are performed:

 (1) Allocate an mm_struct and pick an arch layout (required to set
     mm->get_unmapped_area).

 (2) Create an empty "stack" VMA so that the VMA maple tree is set up and
     won't cause a crash in the maple tree code later.  We don't actually
     care about the stack as we're not going to actually execute userspace.

 (3) Create an anon file and attach a bunch of folios to it so that the
     requested number of pages are accessible.

 (4) Make the kthread use the mm.  This must be done before mmap is called.

 (5) Shared-mmap the anon file into the allocated mm_struct.

This requires access to otherwise unexported core symbols: mm_alloc(),
vm_area_alloc(), insert_vm_struct() arch_pick_mmap_layout() and
anon_inode_getfile_secure(), which I've exported _GPL.

[?] Would it be better if this were done in core and not in a module?

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <brauner@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Matthew Wilcox <willy@infradead.org>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: Brendan Higgins <brendanhiggins@google.com>
cc: David Gow <davidgow@google.com>
cc: Huacai Chen <chenhuacai@kernel.org>
cc: WANG Xuerui <kernel@xen0n.name>
cc: Heiko Carstens <hca@linux.ibm.com>
cc: Vasily Gorbik <gor@linux.ibm.com>
cc: Alexander Gordeev <agordeev@linux.ibm.com>
cc: Christian Borntraeger <borntraeger@linux.ibm.com>
cc: Sven Schnelle <svens@linux.ibm.com>
cc: linux-mm@kvack.org
cc: loongarch@lists.linux.dev
cc: linux-s390@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kselftest@vger.kernel.org
cc: kunit-dev@googlegroups.com
---
 arch/s390/kernel/vdso.c |   1 +
 fs/anon_inodes.c        |   1 +
 kernel/fork.c           |   2 +
 lib/kunit_iov_iter.c    | 143 ++++++++++++++++++++++++++++++++++++++++
 mm/mmap.c               |   1 +
 mm/util.c               |   3 +
 6 files changed, 151 insertions(+)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index bbaefd84f15e..6849eac59129 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -223,6 +223,7 @@ unsigned long vdso_size(void)
 		size += vdso64_end - vdso64_start;
 	return PAGE_ALIGN(size);
 }
+EXPORT_SYMBOL_GPL(vdso_size);
 
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 24192a7667ed..4190336180ee 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -176,6 +176,7 @@ struct file *anon_inode_getfile_secure(const char *name,
 	return __anon_inode_getfile(name, fops, priv, flags,
 				    context_inode, true);
 }
+EXPORT_SYMBOL_GPL(anon_inode_getfile_secure);
 
 static int __anon_inode_getfd(const char *name,
 			      const struct file_operations *fops,
diff --git a/kernel/fork.c b/kernel/fork.c
index 3b6d20dfb9a8..9ab604574400 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -494,6 +494,7 @@ struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
 
 	return vma;
 }
+EXPORT_SYMBOL_GPL(vm_area_alloc);
 
 struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 {
@@ -1337,6 +1338,7 @@ struct mm_struct *mm_alloc(void)
 	memset(mm, 0, sizeof(*mm));
 	return mm_init(mm, current, current_user_ns());
 }
+EXPORT_SYMBOL_GPL(mm_alloc);
 
 static inline void __mmput(struct mm_struct *mm)
 {
diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index eb86371b67d0..63e4dd1e7c1b 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -10,6 +10,13 @@
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/mman.h>
+#include <linux/file.h>
+#include <linux/kthread.h>
+#include <linux/anon_inodes.h>
+#include <linux/writeback.h>
+#include <linux/personality.h>
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <kunit/test.h>
@@ -68,6 +75,20 @@ static void iov_kunit_unmap(void *data)
 	vunmap(data);
 }
 
+static void iov_kunit_mmdrop(void *data)
+{
+	struct mm_struct *mm = data;
+
+	if (current->mm == mm)
+		kthread_unuse_mm(mm);
+	mmdrop(mm);
+}
+
+static void iov_kunit_fput(void *data)
+{
+	fput(data);
+}
+
 /*
  * Create a buffer out of some pages and return a vmap'd pointer to it.
  */
@@ -151,6 +172,128 @@ static void iov_kunit_check_pattern(struct kunit *test, const u8 *buffer,
 	}
 }
 
+static const struct file_operations iov_kunit_user_file_fops = {
+	.mmap = generic_file_mmap,
+};
+
+static int iov_kunit_user_file_read_folio(struct file *file, struct folio *folio)
+{
+	folio_mark_uptodate(folio);
+	folio_unlock(folio);
+	return 0;
+}
+
+static const struct address_space_operations iov_kunit_user_file_aops = {
+	.read_folio	= iov_kunit_user_file_read_folio,
+	.dirty_folio	= filemap_dirty_folio,
+};
+
+/*
+ * Create an anonymous file and attach a bunch of pages to it.  We can then use
+ * this in mmap() and check the pages against it when doing extraction tests.
+ */
+static struct file *iov_kunit_create_file(struct kunit *test, size_t npages,
+					  struct page ***ppages)
+{
+	struct folio *folio;
+	struct file *file;
+	struct page **pages = NULL;
+	size_t i;
+
+	if (ppages) {
+		pages = kunit_kcalloc(test, npages, sizeof(struct page *), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pages);
+		*ppages = pages;
+	}
+
+	file = anon_inode_getfile_secure("kunit-iov-test",
+					 &iov_kunit_user_file_fops,
+					 NULL, O_RDWR, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, file);
+	kunit_add_action_or_reset(test, iov_kunit_fput, file);
+	file->f_mapping->a_ops = &iov_kunit_user_file_aops;
+
+	i_size_write(file_inode(file), npages * PAGE_SIZE);
+	for (i = 0; i < npages; i++) {
+		folio = filemap_grab_folio(file->f_mapping, i);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, folio);
+		if (pages)
+			*pages++ = folio_page(folio, 0);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+	return file;
+}
+
+/*
+ * Attach a userspace buffer to a kernel thread by adding an mm_struct to it
+ * and mmapping the buffer.  If the caller requires a list of pages for
+ * checking, then an anon_inode file is created, populated with pages and
+ * mmapped otherwise an anonymous mapping is used.
+ */
+static u8 __user *__init iov_kunit_create_user_buf(struct kunit *test,
+						   size_t npages,
+						   struct page ***ppages)
+{
+	struct rlimit rlim_stack = {
+		.rlim_cur = LONG_MAX,
+		.rlim_max = LONG_MAX,
+	};
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+	struct file *file;
+	u8 __user *buffer;
+	int ret;
+
+	KUNIT_ASSERT_NULL(test, current->mm);
+
+	mm = mm_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, mm);
+	kunit_add_action_or_reset(test, iov_kunit_mmdrop, mm);
+	arch_pick_mmap_layout(mm, &rlim_stack);
+
+	vma = vm_area_alloc(mm);
+	KUNIT_ASSERT_NOT_NULL(test, vma);
+	vma_set_anonymous(vma);
+
+	/*
+	 * Place the stack at the largest stack address the architecture
+	 * supports. Later, we'll move this to an appropriate place. We don't
+	 * use STACK_TOP because that can depend on attributes which aren't
+	 * configured yet.
+	 */
+	vma->vm_end = STACK_TOP_MAX;
+	vma->vm_start = vma->vm_end - PAGE_SIZE;
+	vm_flags_init(vma, VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP);
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
+
+	ret = insert_vm_struct(mm, vma);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	mm->stack_vm = mm->total_vm = 1;
+
+	/*
+	 * If we want the pages, attach the pages to a file to prevent swap
+	 * interfering, otherwise use an anonymous mapping.
+	 */
+	if (ppages) {
+		file = iov_kunit_create_file(test, npages, ppages);
+
+		kthread_use_mm(mm);
+		buffer = (u8 __user *)vm_mmap(file, 0, PAGE_SIZE * npages,
+					      PROT_READ | PROT_WRITE,
+					      MAP_SHARED, 0);
+	} else {
+		kthread_use_mm(mm);
+		buffer = (u8 __user *)vm_mmap(NULL, 0, PAGE_SIZE * npages,
+					      PROT_READ | PROT_WRITE,
+					      MAP_PRIVATE | MAP_ANONYMOUS, 0);
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, (void __force *)buffer);
+	return buffer;
+}
+
 static void __init iov_kunit_load_kvec(struct kunit *test,
 				       struct iov_iter *iter, int dir,
 				       struct kvec *kvec, unsigned int kvmax,
diff --git a/mm/mmap.c b/mm/mmap.c
index b56a7f0c9f85..2ea4a98a2cab 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3284,6 +3284,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(insert_vm_struct);
 
 /*
  * Copy the vma structure to a new location in the same mm,
diff --git a/mm/util.c b/mm/util.c
index 8cbbfd3a3d59..09895358f067 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -455,6 +455,9 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	mm->get_unmapped_area = arch_get_unmapped_area;
 }
 #endif
+#ifdef CONFIG_MMU
+EXPORT_SYMBOL_GPL(arch_pick_mmap_layout);
+#endif
 
 /**
  * __account_locked_vm - account locked pages to an mm's locked_vm

