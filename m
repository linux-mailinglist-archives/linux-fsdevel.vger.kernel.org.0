Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A022D0F4F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgLGLfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgLGLfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:44 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27407C0613D0;
        Mon,  7 Dec 2020 03:35:29 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id h7so6860858pjk.1;
        Mon, 07 Dec 2020 03:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nVWSYdYM+m3VgpFdUaNYp2nPK15v+oLFac3l4i+Xkck=;
        b=s62bw1Ds5PE8L4XzidHHxWO7dowi92tTp2jvyxNTtrK0syogpxYuEVLqaYD0RVv631
         owhJ9XHEiEAUC9LLWjMTm9Pe+rm9eGDdeJHWBiBJ6IybF16oZrZVOSyni6mDTkHbJNtj
         lV1WDgxMDJ4vPzpOm/VOel/dhx+0n4F5S7mRxVlZDCS15ym9YM5QeoViAugifkeeSQ6P
         OfHGghB4s0mBvhs1ZJML1PDJYbX13uJtxvR79+agbDqhEkF5cdyciPfPgh9PVVRxkp45
         i3OyRnwn9i+vu3ayrr5iEDIPr3IawOVrT3n6PBt+AqhUVLQRTIcKvdEj11xd5/VzMArO
         ygQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nVWSYdYM+m3VgpFdUaNYp2nPK15v+oLFac3l4i+Xkck=;
        b=MaYTHrXpbwnyGD9+EGn7u+2dPbNGtRjPJR3qQR3OvKaQwBkmV8JiuhMdC+5Kyu8v2W
         QlmV5okehYpdxziN/OCV89Dg0D/Qbm4hKzUvDbDHXeJ+EckPFBWj/ZTzdZx+ZFzmyY8y
         GaesL4X0pOMyy5WcGvLnpkYRE1kzJYVPMYeBnmgF1osQIss/Cz/6rIgF3F4Q0iSFAJ4b
         5p507f8l8wF+c4LhKs01lNjEwSAPfAZJ153E6G2uaKU8tGhc4fOWkZESaRsQAixehkcY
         sGYrppzR8UcDtEB8oo3OlCYcPgLc6u9b1LtsANPGLNww7TTSsu+qbChxE7O93AJ9hVkZ
         QfFg==
X-Gm-Message-State: AOAM530niNai0um2vqyQIXT0UwhwYf/Fnvmp//XIhm3wLrQuj8UYbhoP
        TkyXiD6J519r1xevAc6Gf4A=
X-Google-Smtp-Source: ABdhPJxbhoVS4O5do45wTEXma6Md3j6oREnROj3xA+nTQrYjV+3OjcYJRxFen4GD2PNOYOwIlCI0hQ==
X-Received: by 2002:a17:90a:e005:: with SMTP id u5mr15885574pjy.64.1607340928636;
        Mon, 07 Dec 2020 03:35:28 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.35.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:28 -0800 (PST)
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
        Haiwei Li <lihaiwei@tencent.com>
Subject: [RFC V2 32/37] mm, dmemfs: register and handle the dmem mce
Date:   Mon,  7 Dec 2020 19:31:25 +0800
Message-Id: <2c95c5ed91e84229a234d243b8660e1b9cab8bbd.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

dmemfs register the mce handler, send signal to the procs
whose vma is mapped in mce pfn.

Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/inode.c    | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dmem.h |   7 +++
 include/linux/mm.h   |   2 +
 mm/dmem.c            |  34 +++++++++++++
 mm/memory-failure.c  |  64 ++++++++++++++++-------
 5 files changed, 231 insertions(+), 17 deletions(-)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index f698b9d..4303bcdc 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -36,6 +36,47 @@
 
 static uint __read_mostly max_alloc_try_dpages = 1;
 
+struct dmemfs_inode {
+	struct inode *inode;
+	struct list_head link;
+};
+
+static LIST_HEAD(dmemfs_inode_list);
+static DEFINE_SPINLOCK(dmemfs_inode_lock);
+
+static struct dmemfs_inode *
+dmemfs_create_dmemfs_inode(struct inode *inode)
+{
+	struct dmemfs_inode *dmemfs_inode;
+
+	spin_lock(&dmemfs_inode_lock);
+	dmemfs_inode = kmalloc(sizeof(struct dmemfs_inode), GFP_NOIO);
+	if (!dmemfs_inode) {
+		pr_err("DMEMFS: Out of memory while getting dmemfs inode\n");
+		goto out;
+	}
+	dmemfs_inode->inode = inode;
+	list_add_tail(&dmemfs_inode->link, &dmemfs_inode_list);
+out:
+	spin_unlock(&dmemfs_inode_lock);
+	return dmemfs_inode;
+}
+
+static void dmemfs_delete_dmemfs_inode(struct inode *inode)
+{
+	struct dmemfs_inode *i, *next;
+
+	spin_lock(&dmemfs_inode_lock);
+	list_for_each_entry_safe(i, next, &dmemfs_inode_list, link) {
+		if (i->inode == inode) {
+			list_del(&i->link);
+			kfree(i);
+			break;
+		}
+	}
+	spin_unlock(&dmemfs_inode_lock);
+}
+
 struct dmemfs_mount_opts {
 	unsigned long dpage_size;
 };
@@ -218,6 +259,13 @@ static unsigned long dmem_pgoff_to_index(struct inode *inode, pgoff_t pgoff)
 	return pgoff >> (sb->s_blocksize_bits - PAGE_SHIFT);
 }
 
+static pgoff_t dmem_index_to_pgoff(struct inode *inode, unsigned long index)
+{
+	struct super_block *sb = inode->i_sb;
+
+	return index << (sb->s_blocksize_bits - PAGE_SHIFT);
+}
+
 static void *dmem_addr_to_entry(struct inode *inode, phys_addr_t addr)
 {
 	struct super_block *sb = inode->i_sb;
@@ -806,6 +854,23 @@ static void dmemfs_evict_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
+static struct inode *dmemfs_alloc_inode(struct super_block *sb)
+{
+	struct inode *inode;
+
+	inode = alloc_inode_nonrcu();
+	if (inode)
+		dmemfs_create_dmemfs_inode(inode);
+	return inode;
+}
+
+static void dmemfs_destroy_inode(struct inode *inode)
+{
+	if (inode)
+		dmemfs_delete_dmemfs_inode(inode);
+	free_inode_nonrcu(inode);
+}
+
 /*
  * Display the mount options in /proc/mounts.
  */
@@ -819,9 +884,11 @@ static int dmemfs_show_options(struct seq_file *m, struct dentry *root)
 }
 
 static const struct super_operations dmemfs_ops = {
+	.alloc_inode = dmemfs_alloc_inode,
 	.statfs	= dmemfs_statfs,
 	.evict_inode = dmemfs_evict_inode,
 	.drop_inode = generic_delete_inode,
+	.destroy_inode = dmemfs_destroy_inode,
 	.show_options = dmemfs_show_options,
 };
 
@@ -901,17 +968,91 @@ static void dmemfs_kill_sb(struct super_block *sb)
 	.kill_sb	= dmemfs_kill_sb,
 };
 
+static struct inode *
+dmemfs_find_inode_by_addr(phys_addr_t addr, pgoff_t *pgoff)
+{
+	struct dmemfs_inode *di;
+	struct inode *inode;
+	struct address_space *mapping;
+	void *entry, **slot;
+	void *mce_entry;
+
+	list_for_each_entry(di, &dmemfs_inode_list, link) {
+		inode = di->inode;
+		mapping = inode->i_mapping;
+		mce_entry = dmem_addr_to_entry(inode, addr);
+		XA_STATE(xas, &mapping->i_pages, 0);
+		rcu_read_lock();
+
+		xas_for_each(&xas, entry, ULONG_MAX) {
+			if (xas_retry(&xas, entry))
+				continue;
+
+			if (unlikely(entry != xas_reload(&xas)))
+				goto retry;
+
+			if (mce_entry != entry)
+				continue;
+			*pgoff = dmem_index_to_pgoff(inode, xas.xa_index);
+			rcu_read_unlock();
+			return inode;
+retry:
+			xas_reset(&xas);
+		}
+		rcu_read_unlock();
+	}
+	return NULL;
+}
+
+static int dmemfs_mce_handler(struct notifier_block *this, unsigned long pfn,
+			      void *v)
+{
+	struct dmem_mce_notifier_info *info =
+		(struct dmem_mce_notifier_info *)v;
+	int flags = info->flags;
+	struct inode *inode;
+	phys_addr_t mce_addr = __pfn_to_phys(pfn);
+	pgoff_t pgoff;
+
+	spin_lock(&dmemfs_inode_lock);
+	inode = dmemfs_find_inode_by_addr(mce_addr, &pgoff);
+	if (!inode || !atomic_read(&inode->i_count))
+		goto out;
+
+	collect_procs_and_signal_inode(inode, pgoff, pfn, flags);
+out:
+	spin_unlock(&dmemfs_inode_lock);
+	return 0;
+}
+
+static struct notifier_block dmemfs_mce_notifier = {
+	.notifier_call	= dmemfs_mce_handler,
+};
+
 static int __init dmemfs_init(void)
 {
 	int ret;
 
+	pr_info("dmemfs initialized\n");
 	ret = register_filesystem(&dmemfs_fs_type);
+	if (ret)
+		goto reg_fs_fail;
+
+	ret = dmem_register_mce_notifier(&dmemfs_mce_notifier);
+	if (ret)
+		goto reg_notifier_fail;
 
+	return 0;
+
+reg_notifier_fail:
+	unregister_filesystem(&dmemfs_fs_type);
+reg_fs_fail:
 	return ret;
 }
 
 static void __exit dmemfs_uninit(void)
 {
+	dmem_unregister_mce_notifier(&dmemfs_mce_notifier);
 	unregister_filesystem(&dmemfs_fs_type);
 }
 
diff --git a/include/linux/dmem.h b/include/linux/dmem.h
index cd17a91..fe0b270 100644
--- a/include/linux/dmem.h
+++ b/include/linux/dmem.h
@@ -23,6 +23,13 @@
 #define dmem_free_page(addr)	dmem_free_pages(addr, 1)
 
 bool dmem_memory_failure(unsigned long pfn, int flags);
+
+struct dmem_mce_notifier_info {
+	int flags;
+};
+
+int dmem_register_mce_notifier(struct notifier_block *nb);
+int dmem_unregister_mce_notifier(struct notifier_block *nb);
 #else
 static inline int dmem_reserve_init(void)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2f3135fe..fa20f9c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3041,6 +3041,8 @@ enum mf_flags {
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
+extern void collect_procs_and_signal_inode(struct inode *inode, pgoff_t pgoff,
+				    unsigned long pfn, int flags);
 extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
diff --git a/mm/dmem.c b/mm/dmem.c
index 16438db..dd81b24 100644
--- a/mm/dmem.c
+++ b/mm/dmem.c
@@ -70,6 +70,7 @@ struct dmem_node {
 
 struct dmem_pool {
 	struct mutex lock;
+	struct raw_notifier_head mce_notifier_chain;
 
 	unsigned long region_num;
 	unsigned long registered_pages;
@@ -92,6 +93,7 @@ struct dmem_pool {
 
 static struct dmem_pool dmem_pool = {
 	.lock = __MUTEX_INITIALIZER(dmem_pool.lock),
+	.mce_notifier_chain = RAW_NOTIFIER_INIT(dmem_pool.mce_notifier_chain),
 };
 
 #define DMEM_PAGE_SIZE		(1UL << dmem_pool.dpage_shift)
@@ -121,6 +123,35 @@ struct dmem_pool {
 #define for_each_dmem_region(_dnode, _dregion)				\
 	list_for_each_entry(_dregion, &(_dnode)->regions, node)
 
+int dmem_register_mce_notifier(struct notifier_block *nb)
+{
+	int ret;
+
+	mutex_lock(&dmem_pool.lock);
+	ret = raw_notifier_chain_register(&dmem_pool.mce_notifier_chain, nb);
+	mutex_unlock(&dmem_pool.lock);
+	return ret;
+}
+EXPORT_SYMBOL(dmem_register_mce_notifier);
+
+int dmem_unregister_mce_notifier(struct notifier_block *nb)
+{
+	int ret;
+
+	mutex_lock(&dmem_pool.lock);
+	ret = raw_notifier_chain_unregister(&dmem_pool.mce_notifier_chain, nb);
+	mutex_unlock(&dmem_pool.lock);
+	return ret;
+}
+EXPORT_SYMBOL(dmem_unregister_mce_notifier);
+
+static int dmem_mce_notify(unsigned long pfn,
+			   struct dmem_mce_notifier_info *info)
+{
+	return raw_notifier_call_chain(&dmem_pool.mce_notifier_chain,
+				       pfn, info);
+}
+
 static inline int *dmem_nodelist(int nid)
 {
 	return nid_to_dnode(nid)->nodelist;
@@ -1003,6 +1034,7 @@ bool dmem_memory_failure(unsigned long pfn, int flags)
 	u64 pos;
 	phys_addr_t addr = __pfn_to_phys(pfn);
 	bool used = false;
+	struct dmem_mce_notifier_info info;
 
 	dregion = find_dmem_region(addr, &pdnode);
 	if (!dregion)
@@ -1022,6 +1054,8 @@ bool dmem_memory_failure(unsigned long pfn, int flags)
 	pos = phys_to_dpage(addr) - dregion->dpage_start_pfn;
 	if (__test_and_set_bit(pos, dregion->bitmap)) {
 		used = true;
+		info.flags = flags;
+		dmem_mce_notify(pfn, &info);
 	} else {
 		pr_info("MCE: free dpage, mark %#lx disabled in dmem\n", pfn);
 		dnode_count_free_dpages(pdnode, -1);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index dda45d2..3aa7fe7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -334,8 +334,8 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  */
 static void add_to_kill(struct task_struct *tsk, struct page *p,
-		       struct vm_area_struct *vma,
-		       struct list_head *to_kill)
+		       struct vm_area_struct *vma, unsigned long pfn,
+		       pgoff_t pgoff, struct list_head *to_kill)
 {
 	struct to_kill *tk;
 
@@ -345,12 +345,17 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 		return;
 	}
 
-	tk->addr = page_address_in_vma(p, vma);
-	if (is_zone_device_page(p))
-		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
-	else
-		tk->size_shift = page_shift(compound_head(p));
-
+	if (p) {
+		tk->addr = page_address_in_vma(p, vma);
+		if (is_zone_device_page(p))
+			tk->size_shift = dev_pagemap_mapping_shift(p, vma);
+		else
+			tk->size_shift = page_shift(compound_head(p));
+	} else {
+		tk->size_shift = PAGE_SHIFT;
+		tk->addr = vma->vm_start +
+			((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	}
 	/*
 	 * Send SIGKILL if "tk->addr == -EFAULT". Also, as
 	 * "tk->size_shift" is always non-zero for !is_zone_device_page(),
@@ -363,7 +368,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	 */
 	if (tk->addr == -EFAULT) {
 		pr_info("Memory failure: Unable to find user space address %lx in %s\n",
-			page_to_pfn(p), tsk->comm);
+			pfn, tsk->comm);
 	} else if (tk->size_shift == 0) {
 		kfree(tk);
 		return;
@@ -496,7 +501,8 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, vma, page_to_pfn(page),
+					page_to_pgoff(page), to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -504,19 +510,17 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 }
 
 /*
- * Collect processes when the error hit a file mapped page.
+ * Collect processes when the error hit a file mapped memory.
  */
-static void collect_procs_file(struct page *page, struct list_head *to_kill,
-				int force_early)
+static void __collect_procs_file(struct address_space *mapping, pgoff_t pgoff,
+				struct page *page, unsigned long pfn,
+				struct list_head *to_kill, int force_early)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
-	struct address_space *mapping = page->mapping;
-	pgoff_t pgoff;
 
 	i_mmap_lock_read(mapping);
 	read_lock(&tasklist_lock);
-	pgoff = page_to_pgoff(page);
 	for_each_process(tsk) {
 		struct task_struct *t = task_early_kill(tsk, force_early);
 
@@ -532,7 +536,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * to be informed of all such data corruptions.
 			 */
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, vma, pfn, pgoff, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -540,6 +544,32 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 }
 
 /*
+ * Collect processes when the error hit a file mapped page.
+ */
+static void collect_procs_file(struct page *page, struct list_head *to_kill,
+				int force_early)
+{
+	struct address_space *mapping = page->mapping;
+
+	__collect_procs_file(mapping, page_to_pgoff(page), page,
+			     page_to_pfn(page), to_kill, force_early);
+}
+
+void collect_procs_and_signal_inode(struct inode *inode, pgoff_t pgoff,
+					unsigned long pfn, int flags)
+{
+	int forcekill;
+	struct address_space *mapping = &inode->i_data;
+	LIST_HEAD(tokill);
+
+	__collect_procs_file(mapping, pgoff, NULL, pfn, &tokill,
+			     flags & MF_ACTION_REQUIRED);
+	forcekill = flags & MF_MUST_KILL;
+	kill_procs(&tokill, forcekill, false, pfn, flags);
+}
+EXPORT_SYMBOL(collect_procs_and_signal_inode);
+
+/*
  * Collect the processes who have the corrupted page mapped to kill.
  */
 static void collect_procs(struct page *page, struct list_head *tokill,
-- 
1.8.3.1

