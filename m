Return-Path: <linux-fsdevel+bounces-32899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A079B07B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E791F27CAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C9D18660A;
	Fri, 25 Oct 2024 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xwoo6wgl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB0185939
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869173; cv=none; b=nED6G2+KqmKqfl86dJF+3Q5Bhd65FHZfh5GSUpAYfgnmoCzfaTY5CzKYTf2t/TbDSYdW7gtGdGrBA+Ahy2SSg1MSQ8lKmQkYdj1ed0wmaDryNGSq5Bc5nY46ly2iomStGzMt1PbC9E1CIW6EaO/MExazeAgSHJP2NCNwj9BUHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869173; c=relaxed/simple;
	bh=m2ZIKnqe2ELYMThIR4Bxvtg8dbrJ+q1dEdqLEYQoRTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVqatq0lQJvtmHXdLKZyUqa+VFoGPl+mckI4bhMKbdop/UaktfaHr9KjsoMYYXsrnM2lo7X7ozzfl1vXrJGWLH802+qwQajL59V3+myNuT4c59KxghZ02zZNUJkrXwwPHRulyeYvFxmJHdo0ZWGgOHgRkSiZxSgtvVTAnCqFy3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xwoo6wgl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729869170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hl9c5Yb2sx5GRvpqgpVj1LJUfxGGqj6HUI+5nw39Sc=;
	b=Xwoo6wgl0R73yt3hv1zPufI5dTf4aKvnO+YCOgEI+pSqSfBv0mCn7sCrMLZ+3PsJQQQNP2
	IySbyzRzzFkQFaX9yyGODVlhXxiwH+v8V7U+z1u1feYrF0wggo46JY5lUmIKYs80N6vAcr
	KUEgO2bvIVbWN/zKOjcE3b4mDBEm+zg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-4fSCEJXAOeah5Ecoqje4TQ-1; Fri,
 25 Oct 2024 11:12:47 -0400
X-MC-Unique: 4fSCEJXAOeah5Ecoqje4TQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3839D1955F54;
	Fri, 25 Oct 2024 15:12:45 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B62C30001A9;
	Fri, 25 Oct 2024 15:12:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 07/11] fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM ranges in 2nd kernel
Date: Fri, 25 Oct 2024 17:11:29 +0200
Message-ID: <20241025151134.1275575-8-david@redhat.com>
In-Reply-To: <20241025151134.1275575-1-david@redhat.com>
References: <20241025151134.1275575-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

s390 allocates+prepares the elfcore hdr in the dump (2nd) kernel, not in
the crashed kernel.

RAM provided by memory devices such as virtio-mem can only be detected
using the device driver; when vmcore_init() is called, these device
drivers are usually not loaded yet, or the devices did not get probed
yet. Consequently, on s390 these RAM ranges will not be included in
the crash dump, which makes the dump partially corrupt and is
unfortunate.

Instead of deferring the vmcore_init() call, to an (unclear?) later point,
let's reuse the vmcore_cb infrastructure to obtain device RAM ranges as
the device drivers probe the device and get access to this information.

Then, we'll add these ranges to the vmcore, adding more PT_LOAD
entries and updating the offsets+vmcore size.

Use Kconfig tricks to include this code automatically only if (a) there is
a device driver compiled that implements the callback
(PROVIDE_PROC_VMCORE_DEVICE_RAM) and; (b) the architecture actually needs
this information (NEED_PROC_VMCORE_DEVICE_RAM).

The current target use case is s390, which only creates an elf64
elfcore, so focusing on elf64 is sufficient.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/Kconfig            |  25 ++++++
 fs/proc/vmcore.c           | 156 +++++++++++++++++++++++++++++++++++++
 include/linux/crash_dump.h |   9 +++
 3 files changed, 190 insertions(+)

diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index d80a1431ef7b..1e11de5f9380 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -61,6 +61,31 @@ config PROC_VMCORE_DEVICE_DUMP
 	  as ELF notes to /proc/vmcore. You can still disable device
 	  dump using the kernel command line option 'novmcoredd'.
 
+config PROVIDE_PROC_VMCORE_DEVICE_RAM
+	def_bool n
+
+config NEED_PROC_VMCORE_DEVICE_RAM
+	def_bool n
+
+config PROC_VMCORE_DEVICE_RAM
+	def_bool y
+	depends on PROC_VMCORE
+	depends on NEED_PROC_VMCORE_DEVICE_RAM
+	depends on PROVIDE_PROC_VMCORE_DEVICE_RAM
+	help
+	  If the elfcore hdr is allocated and prepared by the dump kernel
+	  ("2nd kernel") instead of the crashed kernel, RAM provided by memory
+	  devices such as virtio-mem will not be included in the dump
+	  image, because only the device driver can properly detect them.
+
+	  With this config enabled, these RAM ranges will be queried from the
+	  device drivers once the device gets probed, so they can be included
+	  in the crash dump.
+
+	  Relevant architectures should select NEED_PROC_VMCORE_DEVICE_RAM
+	  and relevant device drivers should select
+	  PROVIDE_PROC_VMCORE_DEVICE_RAM.
+
 config PROC_SYSCTL
 	bool "Sysctl support (/proc/sys)" if EXPERT
 	depends on PROC_FS
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 3e90416ee54e..c332a9a4920b 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -69,6 +69,8 @@ static LIST_HEAD(vmcore_cb_list);
 /* Whether the vmcore has been opened once. */
 static bool vmcore_opened;
 
+static void vmcore_process_device_ram(struct vmcore_cb *cb);
+
 void register_vmcore_cb(struct vmcore_cb *cb)
 {
 	INIT_LIST_HEAD(&cb->next);
@@ -80,6 +82,8 @@ void register_vmcore_cb(struct vmcore_cb *cb)
 	 */
 	if (vmcore_opened)
 		pr_warn_once("Unexpected vmcore callback registration\n");
+	else if (cb->get_device_ram)
+		vmcore_process_device_ram(cb);
 	mutex_unlock(&vmcore_mutex);
 }
 EXPORT_SYMBOL_GPL(register_vmcore_cb);
@@ -1511,6 +1515,158 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 EXPORT_SYMBOL(vmcore_add_device_dump);
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
+#ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
+static int vmcore_realloc_elfcore_buffer_elf64(size_t new_size)
+{
+	char *elfcorebuf_new;
+
+	if (WARN_ON_ONCE(new_size < elfcorebuf_sz))
+		return -EINVAL;
+	if (get_order(elfcorebuf_sz_orig) == get_order(new_size)) {
+		elfcorebuf_sz_orig = new_size;
+		return 0;
+	}
+
+	elfcorebuf_new = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						  get_order(new_size));
+	if (!elfcorebuf_new)
+		return -ENOMEM;
+	memcpy(elfcorebuf_new, elfcorebuf, elfcorebuf_sz);
+	free_pages((unsigned long)elfcorebuf, get_order(elfcorebuf_sz_orig));
+	elfcorebuf = elfcorebuf_new;
+	elfcorebuf_sz_orig = new_size;
+	return 0;
+}
+
+static void vmcore_reset_offsets_elf64(void)
+{
+	Elf64_Phdr *phdr_start = (Elf64_Phdr *)(elfcorebuf + sizeof(Elf64_Ehdr));
+	loff_t vmcore_off = elfcorebuf_sz + elfnotes_sz;
+	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)elfcorebuf;
+	Elf64_Phdr *phdr;
+	int i;
+
+	for (i = 0, phdr = phdr_start; i < ehdr->e_phnum; i++, phdr++) {
+		u64 start, end;
+
+		/*
+		 * After merge_note_headers_elf64() we should only have a single
+		 * PT_NOTE entry that starts immediately after elfcorebuf_sz.
+		 */
+		if (phdr->p_type == PT_NOTE) {
+			phdr->p_offset = elfcorebuf_sz;
+			continue;
+		}
+
+		start = rounddown(phdr->p_offset, PAGE_SIZE);
+		end = roundup(phdr->p_offset + phdr->p_memsz, PAGE_SIZE);
+		phdr->p_offset = vmcore_off + (phdr->p_offset - start);
+		vmcore_off = vmcore_off + end - start;
+	}
+	set_vmcore_list_offsets(elfcorebuf_sz, elfnotes_sz, &vmcore_list);
+}
+
+static int vmcore_add_device_ram_elf64(struct list_head *list, size_t count)
+{
+	Elf64_Phdr *phdr_start = (Elf64_Phdr *)(elfcorebuf + sizeof(Elf64_Ehdr));
+	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)elfcorebuf;
+	struct vmcore_mem_node *cur;
+	Elf64_Phdr *phdr;
+	size_t new_size;
+	int rc;
+
+	if ((Elf32_Half)(ehdr->e_phnum + count) != ehdr->e_phnum + count) {
+		pr_err("Kdump: too many device ram ranges\n");
+		return -ENOSPC;
+	}
+
+	/* elfcorebuf_sz must always cover full pages. */
+	new_size = sizeof(Elf64_Ehdr) +
+		   (ehdr->e_phnum + count) * sizeof(Elf64_Phdr);
+	new_size = roundup(new_size, PAGE_SIZE);
+
+	/*
+	 * Make sure we have sufficient space to include the new PT_LOAD
+	 * entries.
+	 */
+	rc = vmcore_realloc_elfcore_buffer_elf64(new_size);
+	if (rc) {
+		pr_err("Kdump: resizing elfcore failed\n");
+		return rc;
+	}
+
+	/* Modify our used elfcore buffer size to cover the new entries. */
+	elfcorebuf_sz = new_size;
+
+	/* Fill the added PT_LOAD entries. */
+	phdr = phdr_start + ehdr->e_phnum;
+	list_for_each_entry(cur, list, list) {
+		WARN_ON_ONCE(!IS_ALIGNED(cur->paddr | cur->size, PAGE_SIZE));
+		elfcorehdr_fill_device_ram_ptload_elf64(phdr, cur->paddr, cur->size);
+
+		/* p_offset will be adjusted later. */
+		phdr++;
+		ehdr->e_phnum++;
+	}
+	list_splice_tail(list, &vmcore_list);
+
+	/* We changed elfcorebuf_sz and added new entries; reset all offsets. */
+	vmcore_reset_offsets_elf64();
+
+	/* Finally, recalculated the total vmcore size. */
+	vmcore_size = get_vmcore_size(elfcorebuf_sz, elfnotes_sz,
+				      &vmcore_list);
+	proc_vmcore->size = vmcore_size;
+	return 0;
+}
+
+static void vmcore_process_device_ram(struct vmcore_cb *cb)
+{
+	unsigned char *e_ident = (unsigned char *)elfcorebuf;
+	struct vmcore_mem_node *first, *m;
+	LIST_HEAD(list);
+	int count;
+
+	if (cb->get_device_ram(cb, &list)) {
+		pr_err("Kdump: obtaining device ram ranges failed\n");
+		return;
+	}
+	count = list_count_nodes(&list);
+	if (!count)
+		return;
+
+	/* We only support Elf64 dumps for now. */
+	if (WARN_ON_ONCE(e_ident[EI_CLASS] != ELFCLASS64)) {
+		pr_err("Kdump: device ram ranges only support Elf64\n");
+		goto out_free;
+	}
+
+	/*
+	 * For some reason these ranges are already know? Might happen
+	 * with unusual register->unregister->register sequences; we'll simply
+	 * sanity check using the first range.
+	 */
+	first = list_first_entry(&list, struct vmcore_mem_node, list);
+	list_for_each_entry(m, &vmcore_list, list) {
+		unsigned long long m_end = m->paddr + m->size;
+		unsigned long long first_end = first->paddr + first->size;
+
+		if (first->paddr < m_end && m->paddr < first_end)
+			goto out_free;
+	}
+
+	/* If adding the mem nodes succeeds, they must not be freed. */
+	if (!vmcore_add_device_ram_elf64(&list, count))
+		return;
+out_free:
+	vmcore_free_mem_nodes(&list);
+}
+#else /* !CONFIG_PROC_VMCORE_DEVICE_RAM */
+static void vmcore_process_device_ram(struct vmcore_cb *cb)
+{
+}
+#endif /* CONFIG_PROC_VMCORE_DEVICE_RAM */
+
 /* Free all dumps in vmcore device dump list */
 static void vmcore_free_device_dumps(void)
 {
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 722dbcff7371..8e581a053d7f 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -20,6 +20,8 @@ extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
 extern void elfcorehdr_free(unsigned long long addr);
 extern ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos);
 extern ssize_t elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos);
+void elfcorehdr_fill_device_ram_ptload_elf64(Elf64_Phdr *phdr,
+		unsigned long long paddr, unsigned long long size);
 extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long from, unsigned long pfn,
 				  unsigned long size, pgprot_t prot);
@@ -99,6 +101,12 @@ static inline void vmcore_unusable(void)
  *              indicated in the vmcore instead. For example, a ballooned page
  *              contains no data and reading from such a page will cause high
  *              load in the hypervisor.
+ * @get_device_ram: query RAM ranges that can only be detected by device
+ *   drivers, such as the virtio-mem driver, so they can be included in
+ *   the crash dump on architectures that allocate the elfcore hdr in the dump
+ *   ("2nd") kernel. Indicated RAM ranges may contain holes to reduce the
+ *   total number of ranges; such holes can be detected using the pfn_is_ram
+ *   callback just like for other RAM.
  * @next: List head to manage registered callbacks internally; initialized by
  *        register_vmcore_cb().
  *
@@ -109,6 +117,7 @@ static inline void vmcore_unusable(void)
  */
 struct vmcore_cb {
 	bool (*pfn_is_ram)(struct vmcore_cb *cb, unsigned long pfn);
+	int (*get_device_ram)(struct vmcore_cb *cb, struct list_head *list);
 	struct list_head next;
 };
 extern void register_vmcore_cb(struct vmcore_cb *cb);
-- 
2.46.1


