Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5BA2D0F1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgLGLeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgLGLeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:34:22 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE4C0613D4;
        Mon,  7 Dec 2020 03:33:41 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c79so9613551pfc.2;
        Mon, 07 Dec 2020 03:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/44otMrMxzCUiGk0V1t2L81SCVx385WHUCyFll3f9p0=;
        b=EiialdWRB3FHs1vDA+YkzfnQD6VJz6N4qmPV73L07sHuG/P4ErRRe6bm61f9g5hr9H
         +bV+1omLT2lXgkipsrER7t4rQ/QroKwlhp9ASMHS41/YxSwuudP0PtPd/urhOkA/EO9+
         TiWzoGcwtXpte4GC/vTXZi503fNXbWeHFok7IbUc5PmkUX4gvlyg1b9Q+jbOSz3ZunLJ
         gdl947A+Eh0NIoZr03LVyIBhMu8U/PPJJg7YRgXc0swqDOVuRoWZ1LhJGdtkIFQaMPvG
         Dygv6S2XVQrEGFMtvhF+fVgdh1BjHZ9kopYhtI9kkXo7XYMujVSmvjq+i89HNmdDCg1L
         X81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/44otMrMxzCUiGk0V1t2L81SCVx385WHUCyFll3f9p0=;
        b=Vkglmiu6dKagSE4A+La5alVrp6wuSwVV8girSmYUpLGa5Fty8XZZwxdt8kx/bY+Xw/
         NSVJshkZXQrh0FyY19edMxrYw+L+30A5SBZQnAu8aBV0J7ubJmzy32lB8IJZPa4Xwzq+
         /eGyj2okiBEKcONc/ruOOseTLrgOZCT/Srgef3zGAsAf5ojF6XpW2Yb594nQl+Es9Pma
         xlmYmarAvmnCaqOB9xpfRbyFjYUWI/PMhdQ9Pad17A/ffDecOiZ8OJacZcKImQ1We+ld
         bona/H8uEtoBRLx1Qwf3yK6GQ40YwkIt9NPdX0VLoGQZugfvuyeyfh9kd5iY5oitTcCu
         5gXw==
X-Gm-Message-State: AOAM530yJxuJJIfGc5NLhlF51XCgoTyJDpcSl+2imwmzBqIv6/V/WvKG
        6syVMST3M881IB/uAC4Eb0A=
X-Google-Smtp-Source: ABdhPJxsuCuuWYmFuc/z0htdn8lG7NF7yPaaVzD61TY34e7sLxSOK8H64w92t88zlRNSfCJLilKEiQ==
X-Received: by 2002:aa7:8b15:0:b029:196:59ad:ab93 with SMTP id f21-20020aa78b150000b029019659adab93mr15263676pfd.16.1607340821419;
        Mon, 07 Dec 2020 03:33:41 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.33.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:33:40 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [RFC V2 05/37] dmemfs: support mmap for dmemfs
Date:   Mon,  7 Dec 2020 19:30:58 +0800
Message-Id: <556903717e3d0b0fc0b9583b709f4b34be2154cb.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

This patch adds mmap support. Note the file will be extended if
it's beyond mmap's offset, that drops the requirement of write()
operation, however, it has not supported cutting file down yet.

Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/inode.c    | 343 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/dmem.h |  10 ++
 2 files changed, 351 insertions(+), 2 deletions(-)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index 0aa3d3b..7b6e51d 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -26,6 +26,7 @@
 #include <linux/pagevec.h>
 #include <linux/fs_parser.h>
 #include <linux/seq_file.h>
+#include <linux/dmem.h>
 
 MODULE_AUTHOR("Tencent Corporation");
 MODULE_LICENSE("GPL v2");
@@ -102,7 +103,255 @@ static int dmemfs_mkdir(struct inode *dir, struct dentry *dentry,
 	.getattr = simple_getattr,
 };
 
+static unsigned long dmem_pgoff_to_index(struct inode *inode, pgoff_t pgoff)
+{
+	struct super_block *sb = inode->i_sb;
+
+	return pgoff >> (sb->s_blocksize_bits - PAGE_SHIFT);
+}
+
+static void *dmem_addr_to_entry(struct inode *inode, phys_addr_t addr)
+{
+	struct super_block *sb = inode->i_sb;
+
+	addr >>= sb->s_blocksize_bits;
+	return xa_mk_value(addr);
+}
+
+static phys_addr_t dmem_entry_to_addr(struct inode *inode, void *entry)
+{
+	struct super_block *sb = inode->i_sb;
+
+	WARN_ON(!xa_is_value(entry));
+	return xa_to_value(entry) << sb->s_blocksize_bits;
+}
+
+static unsigned long
+dmem_addr_to_pfn(struct inode *inode, phys_addr_t addr, pgoff_t pgoff,
+		 unsigned int fault_shift)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned long pfn = addr >> PAGE_SHIFT;
+	unsigned long mask;
+
+	mask = (1UL << ((unsigned int)sb->s_blocksize_bits - fault_shift)) - 1;
+	mask <<= fault_shift - PAGE_SHIFT;
+
+	return pfn + (pgoff & mask);
+}
+
+static inline unsigned long dmem_page_size(struct inode *inode)
+{
+	return inode->i_sb->s_blocksize;
+}
+
+static int check_inode_size(struct inode *inode, loff_t offset)
+{
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	if (offset >= i_size_read(inode))
+		return -EINVAL;
+
+	return 0;
+}
+
+static unsigned
+dmemfs_find_get_entries(struct address_space *mapping, unsigned long start,
+			unsigned int nr_entries, void **entries,
+			unsigned long *indices)
+{
+	XA_STATE(xas, &mapping->i_pages, start);
+
+	void *entry;
+	unsigned int ret = 0;
+
+	if (!nr_entries)
+		return 0;
+
+	rcu_read_lock();
+
+	xas_for_each(&xas, entry, ULONG_MAX) {
+		if (xas_retry(&xas, entry))
+			continue;
+
+		if (xa_is_value(entry))
+			goto export;
+
+		if (unlikely(entry != xas_reload(&xas)))
+			goto retry;
+
+export:
+		indices[ret] = xas.xa_index;
+		entries[ret] = entry;
+		if (++ret == nr_entries)
+			break;
+		continue;
+retry:
+		xas_reset(&xas);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static void *find_radix_entry_or_next(struct address_space *mapping,
+				      unsigned long start,
+				      unsigned long *eindex)
+{
+	void *entry = NULL;
+
+	dmemfs_find_get_entries(mapping, start, 1, &entry, eindex);
+	return entry;
+}
+
+/*
+ * find the entry in radix tree based on @index, create it if
+ * it does not exist
+ *
+ * return the entry with rcu locked, otherwise ERR_PTR()
+ * is returned
+ */
+static void *
+radix_get_create_entry(struct vm_area_struct *vma, unsigned long fault_addr,
+		       struct inode *inode, pgoff_t pgoff)
+{
+	struct address_space *mapping = inode->i_mapping;
+	unsigned long eindex, index;
+	loff_t offset;
+	phys_addr_t addr;
+	gfp_t gfp_masks = mapping_gfp_mask(mapping) & ~__GFP_HIGHMEM;
+	void *entry;
+	unsigned int try_dpages, dpages;
+	int ret;
+
+retry:
+	offset = ((loff_t)pgoff << PAGE_SHIFT);
+	index = dmem_pgoff_to_index(inode, pgoff);
+	rcu_read_lock();
+	ret = check_inode_size(inode, offset);
+	if (ret) {
+		rcu_read_unlock();
+		return ERR_PTR(ret);
+	}
+
+	try_dpages = dmem_pgoff_to_index(inode, (i_size_read(inode) - offset)
+				     >> PAGE_SHIFT);
+	entry = find_radix_entry_or_next(mapping, index, &eindex);
+	if (entry) {
+		WARN_ON(!xa_is_value(entry));
+		if (eindex == index)
+			return entry;
+
+		WARN_ON(eindex <= index);
+		try_dpages = eindex - index;
+	}
+	rcu_read_unlock();
+
+	/* entry does not exist, create it */
+	addr = dmem_alloc_pages_vma(vma, fault_addr, try_dpages, &dpages);
+	if (!addr) {
+		/*
+		 * do not return -ENOMEM as that will trigger OOM,
+		 * it is useless for reclaiming dmem page
+		 */
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	try_dpages = dpages;
+	while (dpages) {
+		rcu_read_lock();
+		ret = check_inode_size(inode, offset);
+		if (ret)
+			goto unlock_rcu;
+
+		entry = dmem_addr_to_entry(inode, addr);
+		entry = xa_store(&mapping->i_pages, index, entry, gfp_masks);
+		if (!xa_is_err(entry)) {
+			addr += inode->i_sb->s_blocksize;
+			offset += inode->i_sb->s_blocksize;
+			dpages--;
+			mapping->nrexceptional++;
+			index++;
+		}
+
+unlock_rcu:
+		rcu_read_unlock();
+		if (ret)
+			break;
+	}
+
+	if (dpages)
+		dmem_free_pages(addr, dpages);
+
+	/* we have created some entries, let's retry it */
+	if (ret == -EEXIST || try_dpages != dpages)
+		goto retry;
+exit:
+	return ERR_PTR(ret);
+}
+
+static void radix_put_entry(void)
+{
+	rcu_read_unlock();
+}
+
+static vm_fault_t dmemfs_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct inode *inode = file_inode(vma->vm_file);
+	phys_addr_t addr;
+	void *entry;
+	int ret;
+
+	if (vmf->pgoff > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
+		return VM_FAULT_SIGBUS;
+
+	entry = radix_get_create_entry(vma, (unsigned long)vmf->address,
+				       inode, vmf->pgoff);
+	if (IS_ERR(entry)) {
+		ret = PTR_ERR(entry);
+		goto exit;
+	}
+
+	addr = dmem_entry_to_addr(inode, entry);
+	ret = vmf_insert_pfn(vma, (unsigned long)vmf->address,
+			    dmem_addr_to_pfn(inode, addr, vmf->pgoff,
+					     PAGE_SHIFT));
+	radix_put_entry();
+
+exit:
+	return ret;
+}
+
+static unsigned long dmemfs_pagesize(struct vm_area_struct *vma)
+{
+	return dmem_page_size(file_inode(vma->vm_file));
+}
+
+static const struct vm_operations_struct dmemfs_vm_ops = {
+	.fault = dmemfs_fault,
+	.pagesize = dmemfs_pagesize,
+};
+
+int dmemfs_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *inode = file_inode(file);
+
+	if (vma->vm_pgoff & ((dmem_page_size(inode) - 1) >> PAGE_SHIFT))
+		return -EINVAL;
+
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	vma->vm_flags |= VM_PFNMAP;
+
+	file_accessed(file);
+	vma->vm_ops = &dmemfs_vm_ops;
+	return 0;
+}
+
 static const struct file_operations dmemfs_file_operations = {
+	.mmap = dmemfs_file_mmap,
 };
 
 static int dmemfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
@@ -180,9 +429,86 @@ static int dmemfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
+/*
+ * should make sure the dmem page in the dropped region is not
+ * being mapped by any process
+ */
+static void inode_drop_dpages(struct inode *inode, loff_t start, loff_t end)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct pagevec pvec;
+	unsigned long istart, iend, indices[PAGEVEC_SIZE];
+	int i;
+
+	/* we never use normap page */
+	WARN_ON(mapping->nrpages);
+
+	/* if no dpage is allocated for the inode */
+	if (!mapping->nrexceptional)
+		return;
+
+	istart = dmem_pgoff_to_index(inode, start >> PAGE_SHIFT);
+	iend = dmem_pgoff_to_index(inode, end >> PAGE_SHIFT);
+	pagevec_init(&pvec);
+	while (istart < iend) {
+		pvec.nr = dmemfs_find_get_entries(mapping, istart,
+				min(iend - istart,
+				(unsigned long)PAGEVEC_SIZE),
+				(void **)pvec.pages,
+				indices);
+		if (!pvec.nr)
+			break;
+
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			phys_addr_t addr;
+
+			istart = indices[i];
+			if (istart >= iend)
+				break;
+
+			xa_erase(&mapping->i_pages, istart);
+			mapping->nrexceptional--;
+
+			addr = dmem_entry_to_addr(inode, pvec.pages[i]);
+			dmem_free_page(addr);
+		}
+
+		/*
+		 * only exception entries in pagevec, it's safe to
+		 * reinit it
+		 */
+		pagevec_reinit(&pvec);
+		cond_resched();
+		istart++;
+	}
+}
+
+static void dmemfs_evict_inode(struct inode *inode)
+{
+	/* no VMA works on it */
+	WARN_ON(!RB_EMPTY_ROOT(&inode->i_data.i_mmap.rb_root));
+
+	inode_drop_dpages(inode, 0, LLONG_MAX);
+	clear_inode(inode);
+}
+
+/*
+ * Display the mount options in /proc/mounts.
+ */
+static int dmemfs_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct dmemfs_fs_info *fsi = root->d_sb->s_fs_info;
+
+	if (check_dpage_size(fsi->mount_opts.dpage_size))
+		seq_printf(m, ",pagesize=%lx", fsi->mount_opts.dpage_size);
+	return 0;
+}
+
 static const struct super_operations dmemfs_ops = {
 	.statfs	= dmemfs_statfs,
+	.evict_inode = dmemfs_evict_inode,
 	.drop_inode = generic_delete_inode,
+	.show_options = dmemfs_show_options,
 };
 
 static int
@@ -190,6 +516,7 @@ static int dmemfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct inode *inode;
 	struct dmemfs_fs_info *fsi = sb->s_fs_info;
+	int ret;
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_blocksize = fsi->mount_opts.dpage_size;
@@ -198,11 +525,17 @@ static int dmemfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	sb->s_op = &dmemfs_ops;
 	sb->s_time_gran = 1;
 
+	ret = dmem_alloc_init(sb->s_blocksize_bits);
+	if (ret)
+		return ret;
+
 	inode = dmemfs_get_inode(sb, NULL, S_IFDIR);
 	sb->s_root = d_make_root(inode);
-	if (!sb->s_root)
-		return -ENOMEM;
 
+	if (!sb->s_root) {
+		dmem_alloc_uinit();
+		return -ENOMEM;
+	}
 	return 0;
 }
 
@@ -238,7 +571,13 @@ int dmemfs_init_fs_context(struct fs_context *fc)
 
 static void dmemfs_kill_sb(struct super_block *sb)
 {
+	bool has_inode = !!sb->s_root;
+
 	kill_litter_super(sb);
+
+	/* do not uninit dmem allocator if mount failed */
+	if (has_inode)
+		dmem_alloc_uinit();
 }
 
 static struct file_system_type dmemfs_fs_type = {
diff --git a/include/linux/dmem.h b/include/linux/dmem.h
index 476a82e..8682d63 100644
--- a/include/linux/dmem.h
+++ b/include/linux/dmem.h
@@ -10,6 +10,16 @@
 int dmem_alloc_init(unsigned long dpage_shift);
 void dmem_alloc_uinit(void);
 
+phys_addr_t
+dmem_alloc_pages_nodemask(int nid, nodemask_t *nodemask, unsigned int try_max,
+			  unsigned int *result_nr);
+
+phys_addr_t
+dmem_alloc_pages_vma(struct vm_area_struct *vma, unsigned long addr,
+		     unsigned int try_max, unsigned int *result_nr);
+
+void dmem_free_pages(phys_addr_t addr, unsigned int dpages_nr);
+#define dmem_free_page(addr)	dmem_free_pages(addr, 1)
 #else
 static inline int dmem_reserve_init(void)
 {
-- 
1.8.3.1

