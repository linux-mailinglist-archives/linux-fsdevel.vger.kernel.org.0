Return-Path: <linux-fsdevel+bounces-62014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCCDB81C50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C8F584B3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4400E22D4DE;
	Wed, 17 Sep 2025 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IBy1LxKv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167047E0E8;
	Wed, 17 Sep 2025 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141110; cv=none; b=mpriut6cfWNugmd+Q6y0ActLCFblWkabFLf5U4It5lE3/v7P5kwVFu4iXX8FgIrnr57V47kcC3i0noi9rxQ6fBPJh5QNDvMAsY80VyvGW/uBz6xJemh8fiIkbPl5wSUvoHV/Fb9rmbp5s1WFK+Zdroa/LiAhr1f3VklwLar+4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141110; c=relaxed/simple;
	bh=BGbrjAutGhnIpTCiqQaOJoJH/14pGsxxKOLiT6MtmhQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HU1p/ICAP4ugnl4WIq1kF8UZcTstORArQbySXM3vX/HwxPzVKJE38U69El1NUn8LxsVAu6G38IIoGf5IFL9D+mOmWfNGLc43UwQ1gMogZXzz0jBqm4RO3sAcnimYB4Xzm7ACqPYPFL2oQz3HC/O//A0f7IAoL11f5GLYNnmBOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IBy1LxKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB4AC4CEF7;
	Wed, 17 Sep 2025 20:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758141109;
	bh=BGbrjAutGhnIpTCiqQaOJoJH/14pGsxxKOLiT6MtmhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IBy1LxKv3NeBlEokLMuWU+1Zds8hXmiAfgkBjVxPFJlsjL9B+7TUrQxsOOXLjfvfm
	 O/Rh4dFO+uRRlozeCmDGpHx1cw3dNkwoT49KlLS15jCkgpI82HCQIrx/5ho1ICHP9i
	 QTDJHo2Oz3iB24ucH6FBYqzVvvDIJbCIKF8BIiTI=
Date: Wed, 17 Sep 2025 13:31:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Andreas
 Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams
 <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, David
 Hildenbrand <david@redhat.com>, Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Tony Luck
 <tony.luck@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, Dave
 Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Hugh
 Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Uladzislau Rezki <urezki@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
 ntfs3@lists.linux.dev, kexec@lists.infradead.org,
 kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
 iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 00/14] expand mmap_prepare functionality, port more
 users
Message-Id: <20250917133146.cc7ea49dc2ec8093ab938a57@linux-foundation.org>
In-Reply-To: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 20:11:02 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> callback"), The f_op->mmap hook has been deprecated in favour of
> f_op->mmap_prepare.
> 
> This was introduced in order to make it possible for us to eventually
> eliminate the f_op->mmap hook which is highly problematic as it allows
> drivers and filesystems raw access to a VMA which is not yet correctly
> initialised.
> 
> This hook also introduced complexity for the memory mapping operation, as
> we must correctly unwind what we do should an error arises.
> 
> Overall this interface being so open has caused significant problems for
> us, including security issues, it is important for us to simply eliminate
> this as a source of problems.
> 
> Therefore this series continues what was established by extending the
> functionality further to permit more drivers and filesystems to use
> mmap_prepare.

Thanks, I updated mm.git's mm-new branch to this version.

> v4:
> * Dropped accidentally still-included reference to mmap_abort() in the
>   commit message for the patch in which remap_pfn_range_[prepare,
>   complete]() are introduced as per Jason.
> * Avoided set_vma boolean parameter in remap_pfn_range_internal() as per
>   Jason.
> * Further refactored remap_pfn_range() et al. as per Jason - couldn't make
>   IS_ENABLED() work nicely, as have to declare remap_pfn_range_track()
>   otherwise, so did least-nasty thing.
> * Abstracted I/O remap on PFN calculation as suggested by Jason, however do
>   this more generally across io_remap_pfn_range() as a whole, before
>   introducing prepare/complete variants.
> * Made [io_]remap_pfn_range_[prepare, complete]() internal-only as per
>   Pedro.
> * Renamed [__]compat_vma_prepare to [__]compat_vma as per Jason.
> * Dropped duplicated debug check in mmap_action_complete() as per Jason.
> * Added MMAP_IO_REMAP_PFN action type as per Jason.
> * Various small refactorings as suggested by Jason.
> * Shared code between mmu and nommu mmap_action_complete() as per Jason.
> * Add missing return in kdoc for shmem_zero_setup().
> * Separate out introduction of shmem_zero_setup_desc() into another patch
>   as per Jason.
> * Looked into Jason's request re: using shmem_zero_setup_desc() in vma.c -
>   It isn't really worthwhile for now as we'd have to set VMA fields from
>   the desc after the fields were already set from the map, though once we
>   convert all callers to mmap_prepare we can look at this again.
> * Fixed bug with char mem driver not correctly setting MAP_PRIVATE
>   /dev/zero anonymous (with vma->vm_file still set), use success hook
>   instead.
> * Renamed mmap_prepare_zero to mmap_zero_prepare to be consistent with
>   mmap_mem_prepare.

For those following along at home, here's the overall v3->v4 diff. 
It's quite substantial...


--- a/arch/csky/include/asm/pgtable.h~b
+++ a/arch/csky/include/asm/pgtable.h
@@ -263,12 +263,6 @@ void update_mmu_cache_range(struct vm_fa
 #define update_mmu_cache(vma, addr, ptep) \
 	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
-#define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
-	remap_pfn_range(vma, vaddr, pfn, size, prot)
-
-/* default io_remap_pfn_range_prepare can be used. */
-
-#define io_remap_pfn_range_complete(vma, addr, pfn, size, prot) \
-	remap_pfn_range_complete(vma, addr, pfn, size, prot)
+#define io_remap_pfn_range_pfn(pfn, size) (pfn)
 
 #endif /* __ASM_CSKY_PGTABLE_H */
--- a/arch/mips/alchemy/common/setup.c~b
+++ a/arch/mips/alchemy/common/setup.c
@@ -94,34 +94,13 @@ phys_addr_t fixup_bigphys_addr(phys_addr
 	return phys_addr;
 }
 
-static unsigned long calc_pfn(unsigned long pfn, unsigned long size)
+static inline unsigned long io_remap_pfn_range_pfn(unsigned long pfn,
+		unsigned long size)
 {
 	phys_addr_t phys_addr = fixup_bigphys_addr(pfn << PAGE_SHIFT, size);
 
 	return phys_addr >> PAGE_SHIFT;
 }
-
-int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long vaddr,
-		unsigned long pfn, unsigned long size, pgprot_t prot)
-{
-	return remap_pfn_range(vma, vaddr, calc_pfn(pfn, size), size, prot);
-}
-EXPORT_SYMBOL(io_remap_pfn_range);
-
-void io_remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn,
-			       unsigned long size)
-{
-	remap_pfn_range_prepare(desc, calc_pfn(pfn, size));
-}
-EXPORT_SYMBOL(io_remap_pfn_range_prepare);
-
-int io_remap_pfn_range_complete(struct vm_area_struct *vma,
-		unsigned long addr, unsigned long pfn, unsigned long size,
-		pgprot_t prot)
-{
-	return remap_pfn_range_complete(vma, addr, calc_pfn(pfn, size),
-			size, prot);
-}
-EXPORT_SYMBOL(io_remap_pfn_range_complete);
+EXPORT_SYMBOL(io_remap_pfn_range_pfn);
 
 #endif /* CONFIG_MIPS_FIXUP_BIGPHYS_ADDR */
--- a/arch/mips/include/asm/pgtable.h~b
+++ a/arch/mips/include/asm/pgtable.h
@@ -604,19 +604,8 @@ static inline void update_mmu_cache_pmd(
  */
 #ifdef CONFIG_MIPS_FIXUP_BIGPHYS_ADDR
 phys_addr_t fixup_bigphys_addr(phys_addr_t addr, phys_addr_t size);
-int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long vaddr,
-		unsigned long pfn, unsigned long size, pgprot_t prot);
-#define io_remap_pfn_range io_remap_pfn_range
-
-void io_remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn,
-		unsigned long size);
-#define io_remap_pfn_range_prepare io_remap_pfn_range_prepare
-
-int io_remap_pfn_range_complete(struct vm_area_struct *vma,
-		unsigned long addr, unsigned long pfn, unsigned long size,
-		pgprot_t prot);
-#define io_remap_pfn_range_complete io_remap_pfn_range_complete
-
+unsigned long io_remap_pfn_range_pfn(unsigned long pfn, unsigned long size);
+#define io_remap_pfn_range_pfn io_remap_pfn_range_pfn
 #else
 #define fixup_bigphys_addr(addr, size)	(addr)
 #endif /* CONFIG_MIPS_FIXUP_BIGPHYS_ADDR */
--- a/arch/sparc/include/asm/pgtable_32.h~b
+++ a/arch/sparc/include/asm/pgtable_32.h
@@ -395,13 +395,8 @@ __get_iospace (unsigned long addr)
 #define GET_IOSPACE(pfn)		(pfn >> (BITS_PER_LONG - 4))
 #define GET_PFN(pfn)			(pfn & 0x0fffffffUL)
 
-int remap_pfn_range(struct vm_area_struct *, unsigned long, unsigned long,
-		    unsigned long, pgprot_t);
-void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
-int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t pgprot);
-
-static inline unsigned long calc_io_remap_pfn(unsigned long pfn)
+static inline unsigned long io_remap_pfn_range_pfn(unsigned long pfn,
+		unsigned long size)
 {
 	unsigned long long offset, space, phys_base;
 
@@ -411,30 +406,7 @@ static inline unsigned long calc_io_rema
 
 	return phys_base >> PAGE_SHIFT;
 }
-
-static inline int io_remap_pfn_range(struct vm_area_struct *vma,
-				     unsigned long from, unsigned long pfn,
-				     unsigned long size, pgprot_t prot)
-{
-	return remap_pfn_range(vma, from, calc_io_remap_pfn(pfn), size, prot);
-}
-#define io_remap_pfn_range io_remap_pfn_range
-
-static inline void io_remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn,
-		unsigned long size)
-{
-	remap_pfn_range_prepare(desc, calc_io_remap_pfn(pfn));
-}
-#define io_remap_pfn_range_prepare io_remap_pfn_range_prepare
-
-static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma,
-		unsigned long addr, unsigned long pfn, unsigned long size,
-		pgprot_t prot)
-{
-	return remap_pfn_range_complete(vma, addr, calc_io_remap_pfn(pfn),
-			size, prot);
-}
-#define io_remap_pfn_range_complete io_remap_pfn_range_complete
+#define io_remap_pfn_range_pfn io_remap_pfn_range_pfn
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
--- a/arch/sparc/include/asm/pgtable_64.h~b
+++ a/arch/sparc/include/asm/pgtable_64.h
@@ -1048,12 +1048,6 @@ int page_in_phys_avail(unsigned long pad
 #define GET_IOSPACE(pfn)		(pfn >> (BITS_PER_LONG - 4))
 #define GET_PFN(pfn)			(pfn & 0x0fffffffffffffffUL)
 
-int remap_pfn_range(struct vm_area_struct *, unsigned long, unsigned long,
-		    unsigned long, pgprot_t);
-void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
-int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t pgprot);
-
 void adi_restore_tags(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pte_t pte);
 
@@ -1087,7 +1081,8 @@ static inline int arch_unmap_one(struct
 	return 0;
 }
 
-static inline unsigned long calc_io_remap_pfn(unsigned long pfn)
+static inline unsigned long io_remap_pfn_range_pfn(unsigned long pfn,
+		unsigned long size)
 {
 	unsigned long offset = GET_PFN(pfn) << PAGE_SHIFT;
 	int space = GET_IOSPACE(pfn);
@@ -1097,30 +1092,7 @@ static inline unsigned long calc_io_rema
 
 	return phys_base >> PAGE_SHIFT;
 }
-
-static inline int io_remap_pfn_range(struct vm_area_struct *vma,
-				     unsigned long from, unsigned long pfn,
-				     unsigned long size, pgprot_t prot)
-{
-	return remap_pfn_range(vma, from, calc_io_remap_pfn(pfn), size, prot);
-}
-#define io_remap_pfn_range io_remap_pfn_range
-
-static inline void io_remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn,
-	unsigned long size)
-{
-	return remap_pfn_range_prepare(desc, calc_io_remap_pfn(pfn));
-}
-#define io_remap_pfn_range_prepare io_remap_pfn_range_prepare
-
-static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma,
-		unsigned long addr, unsigned long pfn, unsigned long size,
-		pgprot_t prot)
-{
-	return remap_pfn_range_complete(vma, addr, calc_io_remap_pfn(pfn),
-					size, prot);
-}
-#define io_remap_pfn_range_complete io_remap_pfn_range_complete
+#define io_remap_pfn_range_pfn io_remap_pfn_range_pfn
 
 static inline unsigned long __untagged_addr(unsigned long start)
 {
--- a/drivers/char/mem.c~b
+++ a/drivers/char/mem.c
@@ -504,18 +504,26 @@ static ssize_t read_zero(struct file *fi
 	return cleared;
 }
 
-static int mmap_prepare_zero(struct vm_area_desc *desc)
+static int mmap_zero_private_success(const struct vm_area_struct *vma)
+{
+	/*
+	 * This is a highly unique situation where we mark a MAP_PRIVATE mapping
+	 * of /dev/zero anonymous, despite it not being.
+	 */
+	vma_set_anonymous((struct vm_area_struct *)vma);
+
+	return 0;
+}
+
+static int mmap_zero_prepare(struct vm_area_desc *desc)
 {
 #ifndef CONFIG_MMU
 	return -ENOSYS;
 #endif
 	if (desc->vm_flags & VM_SHARED)
 		return shmem_zero_setup_desc(desc);
-	/*
-	 * This is a highly unique situation where we mark a MAP_PRIVATE mapping
-	 * of /dev/zero anonymous, despite it not being.
-	 */
-	desc->vm_ops = NULL;
+
+	desc->action.success_hook = mmap_zero_private_success;
 	return 0;
 }
 
@@ -533,7 +541,7 @@ static unsigned long get_unmapped_area_z
 {
 	if (flags & MAP_SHARED) {
 		/*
-		 * mmap_prepare_zero() will call shmem_zero_setup() to create a
+		 * mmap_zero_prepare() will call shmem_zero_setup() to create a
 		 * file, so use shmem's get_unmapped_area in case it can be
 		 * huge; and pass NULL for file as in mmap.c's
 		 * get_unmapped_area(), so as not to confuse shmem with our
@@ -676,7 +684,7 @@ static const struct file_operations zero
 	.write_iter	= write_iter_zero,
 	.splice_read	= copy_splice_read,
 	.splice_write	= splice_write_zero,
-	.mmap_prepare	= mmap_prepare_zero,
+	.mmap_prepare	= mmap_zero_prepare,
 	.get_unmapped_area = get_unmapped_area_zero,
 #ifndef CONFIG_MMU
 	.mmap_capabilities = zero_mmap_capabilities,
--- a/include/linux/fs.h~b
+++ a/include/linux/fs.h
@@ -2279,14 +2279,14 @@ static inline bool can_mmap_file(struct
 	return true;
 }
 
-int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+int __compat_vma_mmap(const struct file_operations *f_op,
 		struct file *file, struct vm_area_struct *vma);
-int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
+int compat_vma_mmap(struct file *file, struct vm_area_struct *vma);
 
 static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	if (file->f_op->mmap_prepare)
-		return compat_vma_mmap_prepare(file, vma);
+		return compat_vma_mmap(file, vma);
 
 	return file->f_op->mmap(file, vma);
 }
--- a/include/linux/mm.h~b
+++ a/include/linux/mm.h
@@ -3650,7 +3650,7 @@ static inline void mmap_action_ioremap(s
 				       unsigned long size)
 {
 	mmap_action_remap(desc, start, start_pfn, size);
-	desc->action.remap.is_io_remap = true;
+	desc->action.type = MMAP_IO_REMAP_PFN;
 }
 
 /**
@@ -3713,9 +3713,6 @@ struct vm_area_struct *find_extend_vma_l
 		unsigned long addr);
 int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		    unsigned long pfn, unsigned long size, pgprot_t pgprot);
-void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
-int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t pgprot);
 
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
 int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
@@ -3749,32 +3746,34 @@ static inline vm_fault_t vmf_insert_page
 	return VM_FAULT_NOPAGE;
 }
 
-#ifndef io_remap_pfn_range
-static inline int io_remap_pfn_range(struct vm_area_struct *vma,
-				     unsigned long addr, unsigned long pfn,
-				     unsigned long size, pgprot_t prot)
+#ifdef io_remap_pfn_range_pfn
+static inline unsigned long io_remap_pfn_range_prot(pgprot_t prot)
 {
-	return remap_pfn_range(vma, addr, pfn, size, pgprot_decrypted(prot));
+	/* We do not decrypt if arch customises PFN. */
+	return prot;
+}
+#else
+static inline unsigned long io_remap_pfn_range_pfn(unsigned long pfn,
+		unsigned long size)
+{
+	return pfn;
 }
-#endif
 
-#ifndef io_remap_pfn_range_prepare
-static inline void io_remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn,
-	unsigned long size)
+static inline pgprot_t io_remap_pfn_range_prot(pgprot_t prot)
 {
-	return remap_pfn_range_prepare(desc, pfn);
+	return pgprot_decrypted(prot);
 }
 #endif
 
-#ifndef io_remap_pfn_range_complete
-static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma,
-		unsigned long addr, unsigned long pfn, unsigned long size,
-		pgprot_t prot)
+static inline int io_remap_pfn_range(struct vm_area_struct *vma,
+				     unsigned long addr, unsigned long orig_pfn,
+				     unsigned long size, pgprot_t orig_prot)
 {
-	return remap_pfn_range_complete(vma, addr, pfn, size,
-			pgprot_decrypted(prot));
+	const unsigned long pfn = io_remap_pfn_range_pfn(orig_pfn, size);
+	const pgprot_t prot = io_remap_pfn_range_prot(orig_prot);
+
+	return remap_pfn_range(vma, addr, pfn, size, prot);
 }
-#endif
 
 static inline vm_fault_t vmf_error(int err)
 {
--- a/include/linux/mm_types.h~b
+++ a/include/linux/mm_types.h
@@ -777,6 +777,7 @@ struct pfnmap_track_ctx {
 enum mmap_action_type {
 	MMAP_NOTHING,		/* Mapping is complete, no further action. */
 	MMAP_REMAP_PFN,		/* Remap PFN range. */
+	MMAP_IO_REMAP_PFN,	/* I/O remap PFN range. */
 };
 
 /*
@@ -791,7 +792,6 @@ struct mmap_action {
 			unsigned long start_pfn;
 			unsigned long size;
 			pgprot_t pgprot;
-			bool is_io_remap;
 		} remap;
 	};
 	enum mmap_action_type type;
--- a/mm/internal.h~b
+++ a/mm/internal.h
@@ -1653,4 +1653,26 @@ static inline bool reclaim_pt_is_enabled
 void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
 int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
 
+void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t pgprot);
+
+static inline void io_remap_pfn_range_prepare(struct vm_area_desc *desc,
+		unsigned long orig_pfn, unsigned long size)
+{
+	const unsigned long pfn = io_remap_pfn_range_pfn(orig_pfn, size);
+
+	return remap_pfn_range_prepare(desc, pfn);
+}
+
+static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long orig_pfn, unsigned long size,
+		pgprot_t orig_prot)
+{
+	const unsigned long pfn = io_remap_pfn_range_pfn(orig_pfn, size);
+	const pgprot_t prot = io_remap_pfn_range_prot(orig_prot);
+
+	return remap_pfn_range_complete(vma, addr, pfn, size, prot);
+}
+
 #endif	/* __MM_INTERNAL_H */
--- a/mm/memory.c~b
+++ a/mm/memory.c
@@ -2919,7 +2919,7 @@ static int get_remap_pgoff(vm_flags_t vm
 }
 
 static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t prot, bool set_vma)
+		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -2930,16 +2930,7 @@ static int remap_pfn_range_internal(stru
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
 		return -EINVAL;
 
-	if (set_vma) {
-		err = get_remap_pgoff(vma->vm_flags, addr, end,
-				      vma->vm_start, vma->vm_end,
-				      pfn, &vma->vm_pgoff);
-		if (err)
-			return err;
-		vm_flags_set(vma, VM_REMAP_FLAGS);
-	} else {
-		VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) != VM_REMAP_FLAGS);
-	}
+	VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) != VM_REMAP_FLAGS);
 
 	BUG_ON(addr >= end);
 	pfn -= addr >> PAGE_SHIFT;
@@ -2961,9 +2952,9 @@ static int remap_pfn_range_internal(stru
  * must have pre-validated the caching bits of the pgprot_t.
  */
 static int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t prot, bool set_vma)
+		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
-	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot, set_vma);
+	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
 	if (!error)
 		return 0;
 
@@ -2976,18 +2967,6 @@ static int remap_pfn_range_notrack(struc
 	return error;
 }
 
-void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn)
-{
-	/*
-	 * We set addr=VMA start, end=VMA end here, so this won't fail, but we
-	 * check it again on complete and will fail there if specified addr is
-	 * invalid.
-	 */
-	get_remap_pgoff(desc->vm_flags, desc->start, desc->end,
-			desc->start, desc->end, pfn, &desc->pgoff);
-	desc->vm_flags |= VM_REMAP_FLAGS;
-}
-
 #ifdef __HAVE_PFNMAP_TRACKING
 static inline struct pfnmap_track_ctx *pfnmap_track_ctx_alloc(unsigned long pfn,
 		unsigned long size, pgprot_t *prot)
@@ -3018,7 +2997,7 @@ void pfnmap_track_ctx_release(struct kre
 }
 
 static int remap_pfn_range_track(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t prot, bool set_vma)
+		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	struct pfnmap_track_ctx *ctx = NULL;
 	int err;
@@ -3044,7 +3023,7 @@ static int remap_pfn_range_track(struct
 		return -EINVAL;
 	}
 
-	err = remap_pfn_range_notrack(vma, addr, pfn, size, prot, set_vma);
+	err = remap_pfn_range_notrack(vma, addr, pfn, size, prot);
 	if (ctx) {
 		if (err)
 			kref_put(&ctx->kref, pfnmap_track_ctx_release);
@@ -3054,6 +3033,47 @@ static int remap_pfn_range_track(struct
 	return err;
 }
 
+static int do_remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	return remap_pfn_range_track(vma, addr, pfn, size, prot);
+}
+#else
+static int do_remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	return remap_pfn_range_notrack(vma, addr, pfn, size, prot);
+}
+#endif
+
+void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn)
+{
+	/*
+	 * We set addr=VMA start, end=VMA end here, so this won't fail, but we
+	 * check it again on complete and will fail there if specified addr is
+	 * invalid.
+	 */
+	get_remap_pgoff(desc->vm_flags, desc->start, desc->end,
+			desc->start, desc->end, pfn, &desc->pgoff);
+	desc->vm_flags |= VM_REMAP_FLAGS;
+}
+
+static int remap_pfn_range_prepare_vma(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size)
+{
+	unsigned long end = addr + PAGE_ALIGN(size);
+	int err;
+
+	err = get_remap_pgoff(vma->vm_flags, addr, end,
+			      vma->vm_start, vma->vm_end,
+			      pfn, &vma->vm_pgoff);
+	if (err)
+		return err;
+
+	vm_flags_set(vma, VM_REMAP_FLAGS);
+	return 0;
+}
+
 /**
  * remap_pfn_range - remap kernel memory to userspace
  * @vma: user vma to map to
@@ -3069,32 +3089,21 @@ static int remap_pfn_range_track(struct
 int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		    unsigned long pfn, unsigned long size, pgprot_t prot)
 {
-	return remap_pfn_range_track(vma, addr, pfn, size, prot,
-				     /* set_vma = */true);
-}
+	int err;
 
-int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t prot)
-{
-	/* With set_vma = false, the VMA will not be modified. */
-	return remap_pfn_range_track(vma, addr, pfn, size, prot,
-				     /* set_vma = */false);
-}
-#else
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
-		    unsigned long pfn, unsigned long size, pgprot_t prot)
-{
-	return remap_pfn_range_notrack(vma, addr, pfn, size, prot, /* set_vma = */true);
+	err = remap_pfn_range_prepare_vma(vma, addr, pfn, size);
+	if (err)
+		return err;
+
+	return do_remap_pfn_range(vma, addr, pfn, size, prot);
 }
+EXPORT_SYMBOL(remap_pfn_range);
 
 int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
-			     unsigned long pfn, unsigned long size, pgprot_t prot)
+		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
-	return remap_pfn_range_notrack(vma, addr, pfn, size, prot,
-				       /* set_vma = */false);
+	return do_remap_pfn_range(vma, addr, pfn, size, prot);
 }
-#endif
-EXPORT_SYMBOL(remap_pfn_range);
 
 /**
  * vm_iomap_memory - remap memory to userspace
--- a/mm/shmem.c~b
+++ a/mm/shmem.c
@@ -5908,6 +5908,7 @@ static struct file *__shmem_zero_setup(u
 /**
  * shmem_zero_setup - setup a shared anonymous mapping
  * @vma: the vma to be mmapped is prepared by do_mmap
+ * Returns: 0 on success, or error
  */
 int shmem_zero_setup(struct vm_area_struct *vma)
 {
--- a/mm/util.c~b
+++ a/mm/util.c
@@ -1134,7 +1134,7 @@ EXPORT_SYMBOL(flush_dcache_folio);
 #endif
 
 /**
- * __compat_vma_mmap_prepare() - See description for compat_vma_mmap_prepare()
+ * __compat_vma_mmap() - See description for compat_vma_mmap()
  * for details. This is the same operation, only with a specific file operations
  * struct which may or may not be the same as vma->vm_file->f_op.
  * @f_op: The file operations whose .mmap_prepare() hook is specified.
@@ -1142,7 +1142,7 @@ EXPORT_SYMBOL(flush_dcache_folio);
  * @vma: The VMA to apply the .mmap_prepare() hook to.
  * Returns: 0 on success or error.
  */
-int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+int __compat_vma_mmap(const struct file_operations *f_op,
 		struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc = {
@@ -1168,11 +1168,11 @@ int __compat_vma_mmap_prepare(const stru
 	set_vma_from_desc(vma, &desc);
 	return mmap_action_complete(&desc.action, vma);
 }
-EXPORT_SYMBOL(__compat_vma_mmap_prepare);
+EXPORT_SYMBOL(__compat_vma_mmap);
 
 /**
- * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
- * existing VMA.
+ * compat_vma_mmap() - Apply the file's .mmap_prepare() hook to an
+ * existing VMA and execute any requested actions.
  * @file: The file which possesss an f_op->mmap_prepare() hook.
  * @vma: The VMA to apply the .mmap_prepare() hook to.
  *
@@ -1187,7 +1187,7 @@ EXPORT_SYMBOL(__compat_vma_mmap_prepare)
  * .mmap_prepare() hook, as we are in a different context when we invoke the
  * .mmap() hook, already having a VMA to deal with.
  *
- * compat_vma_mmap_prepare() is a compatibility function that takes VMA state,
+ * compat_vma_mmap() is a compatibility function that takes VMA state,
  * establishes a struct vm_area_desc descriptor, passes to the underlying
  * .mmap_prepare() hook and applies any changes performed by it.
  *
@@ -1196,11 +1196,11 @@ EXPORT_SYMBOL(__compat_vma_mmap_prepare)
  *
  * Returns: 0 on success or error.
  */
-int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
+int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	return __compat_vma_mmap_prepare(file->f_op, file, vma);
+	return __compat_vma_mmap(file->f_op, file, vma);
 }
-EXPORT_SYMBOL(compat_vma_mmap_prepare);
+EXPORT_SYMBOL(compat_vma_mmap);
 
 static void set_ps_flags(struct page_snapshot *ps, const struct folio *folio,
 			 const struct page *page)
@@ -1282,6 +1282,35 @@ again:
 	}
 }
 
+static int mmap_action_finish(struct mmap_action *action,
+		const struct vm_area_struct *vma, int err)
+{
+	/*
+	 * If an error occurs, unmap the VMA altogether and return an error. We
+	 * only clear the newly allocated VMA, since this function is only
+	 * invoked if we do NOT merge, so we only clean up the VMA we created.
+	 */
+	if (err) {
+		const size_t len = vma_pages(vma) << PAGE_SHIFT;
+
+		do_munmap(current->mm, vma->vm_start, len, NULL);
+
+		if (action->error_hook) {
+			/* We may want to filter the error. */
+			err = action->error_hook(err);
+
+			/* The caller should not clear the error. */
+			VM_WARN_ON_ONCE(!err);
+		}
+		return err;
+	}
+
+	if (action->success_hook)
+		return action->success_hook(vma);
+
+	return 0;
+}
+
 #ifdef CONFIG_MMU
 /**
  * mmap_action_prepare - Perform preparatory setup for an VMA descriptor
@@ -1296,11 +1325,11 @@ void mmap_action_prepare(struct mmap_act
 	case MMAP_NOTHING:
 		break;
 	case MMAP_REMAP_PFN:
-		if (action->remap.is_io_remap)
-			io_remap_pfn_range_prepare(desc, action->remap.start_pfn,
-				action->remap.size);
-		else
-			remap_pfn_range_prepare(desc, action->remap.start_pfn);
+		remap_pfn_range_prepare(desc, action->remap.start_pfn);
+		break;
+	case MMAP_IO_REMAP_PFN:
+		io_remap_pfn_range_prepare(desc, action->remap.start_pfn,
+					   action->remap.size);
 		break;
 	}
 }
@@ -1324,44 +1353,18 @@ int mmap_action_complete(struct mmap_act
 	case MMAP_NOTHING:
 		break;
 	case MMAP_REMAP_PFN:
-		VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) !=
-				VM_REMAP_FLAGS);
-
-		if (action->remap.is_io_remap)
-			err = io_remap_pfn_range_complete(vma, action->remap.start,
+		err = remap_pfn_range_complete(vma, action->remap.start,
 				action->remap.start_pfn, action->remap.size,
 				action->remap.pgprot);
-		else
-			err = remap_pfn_range_complete(vma, action->remap.start,
+		break;
+	case MMAP_IO_REMAP_PFN:
+		err = io_remap_pfn_range_complete(vma, action->remap.start,
 				action->remap.start_pfn, action->remap.size,
 				action->remap.pgprot);
 		break;
 	}
 
-	/*
-	 * If an error occurs, unmap the VMA altogether and return an error. We
-	 * only clear the newly allocated VMA, since this function is only
-	 * invoked if we do NOT merge, so we only clean up the VMA we created.
-	 */
-	if (err) {
-		const size_t len = vma_pages(vma) << PAGE_SHIFT;
-
-		do_munmap(current->mm, vma->vm_start, len, NULL);
-
-		if (action->error_hook) {
-			/* We may want to filter the error. */
-			err = action->error_hook(err);
-
-			/* The caller should not clear the error. */
-			VM_WARN_ON_ONCE(!err);
-		}
-		return err;
-	}
-
-	if (action->success_hook)
-		err = action->success_hook(vma);
-
-	return err;
+	return mmap_action_finish(action, vma, err);
 }
 EXPORT_SYMBOL(mmap_action_complete);
 #else
@@ -1372,6 +1375,7 @@ void mmap_action_prepare(struct mmap_act
 	case MMAP_NOTHING:
 		break;
 	case MMAP_REMAP_PFN:
+	case MMAP_IO_REMAP_PFN:
 		WARN_ON_ONCE(1); /* nommu cannot handle these. */
 		break;
 	}
@@ -1381,41 +1385,17 @@ EXPORT_SYMBOL(mmap_action_prepare);
 int mmap_action_complete(struct mmap_action *action,
 			struct vm_area_struct *vma)
 {
-	int err = 0;
-
 	switch (action->type) {
 	case MMAP_NOTHING:
 		break;
 	case MMAP_REMAP_PFN:
+	case MMAP_IO_REMAP_PFN:
 		WARN_ON_ONCE(1); /* nommu cannot handle this. */
 
 		break;
 	}
 
-	/*
-	 * If an error occurs, unmap the VMA altogether and return an error. We
-	 * only clear the newly allocated VMA, since this function is only
-	 * invoked if we do NOT merge, so we only clean up the VMA we created.
-	 */
-	if (err) {
-		const size_t len = vma_pages(vma) << PAGE_SHIFT;
-
-		do_munmap(current->mm, vma->vm_start, len, NULL);
-
-		if (action->error_hook) {
-			/* We may want to filter the error. */
-			err = action->error_hook(err);
-
-			/* The caller should not clear the error. */
-			VM_WARN_ON_ONCE(!err);
-		}
-		return err;
-	}
-
-	if (action->success_hook)
-		err = action->success_hook(vma);
-
-	return 0;
+	return mmap_action_finish(action, vma, /* err = */0);
 }
 EXPORT_SYMBOL(mmap_action_complete);
 #endif
--- a/tools/testing/vma/vma_internal.h~b
+++ a/tools/testing/vma/vma_internal.h
@@ -293,7 +293,6 @@ struct mmap_action {
 			unsigned long start_pfn;
 			unsigned long size;
 			pgprot_t pgprot;
-			bool is_io_remap;
 		} remap;
 	};
 	enum mmap_action_type type;
@@ -1524,7 +1523,7 @@ static inline int mmap_action_complete(s
 	return 0;
 }
 
-static inline int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+static inline int __compat_vma_mmap(const struct file_operations *f_op,
 		struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc = {
@@ -1551,10 +1550,10 @@ static inline int __compat_vma_mmap_prep
 	return mmap_action_complete(&desc.action, vma);
 }
 
-static inline int compat_vma_mmap_prepare(struct file *file,
+static inline int compat_vma_mmap(struct file *file,
 		struct vm_area_struct *vma)
 {
-	return __compat_vma_mmap_prepare(file->f_op, file, vma);
+	return __compat_vma_mmap(file->f_op, file, vma);
 }
 
 /* Did the driver provide valid mmap hook configuration? */
@@ -1575,7 +1574,7 @@ static inline bool can_mmap_file(struct
 static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	if (file->f_op->mmap_prepare)
-		return compat_vma_mmap_prepare(file, vma);
+		return compat_vma_mmap(file, vma);
 
 	return file->f_op->mmap(file, vma);
 }
_


