Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DC1287050
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgJHH4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbgJHH4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:56:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB7C0613D4;
        Thu,  8 Oct 2020 00:56:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q123so3341111pfb.0;
        Thu, 08 Oct 2020 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OLe1dASqSvtsHG3v+61p4SLPbRY7HjOgB0mEYZxCxAI=;
        b=g/c1RfyQfTctEsdD5SmnXHkCDGzHjroOi/DbxmEUpnAITeK/LPW9KZUJoO7mkHb/y3
         mZtJq0grl1emEQuk4pcrdm8OLAAwsH/nrsbhZoNTPRh0LlFK7HCzfRZWSVNaI54cEOcE
         M1lfmHdISf1mPEALStYpamvx3k1KXvl8GLSQam2QbhdT0JWmHUHUt9BurHxCLfmkh2wf
         aXO9ZztwfHK4M+0Z07UbjgTyQZPUqSBpDG+0WC1YMz9zNqERcVrbQmoSLNOE7upNCrge
         SgSpy6mRrMu9d7t4PEmb3cmIMipsXP5B8o7EX4cv5vymKl66jE1lFSuDEbGV56wjYt3s
         RU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OLe1dASqSvtsHG3v+61p4SLPbRY7HjOgB0mEYZxCxAI=;
        b=MelqnQvUEfH+86fFQrOTs/5/66ng9LD7YKLkRtbe7F0DFZ9TAPCJymlAQu1esD2J8r
         u2/HWOR5GpSQjj86lTpVD1BrWcKb8eYjIbYKglthaMy86/RFLrjet5uzqBiDbQMTHChw
         ncP7YRBdA5ij2dWCe2j8eSqRjtOtQnwi3glzSS6s4liJFPuHOruX4vf51UWBWnqAavN8
         XSHNg5P/7yhQCcIjNQLpG00tyh1PWC4SAFefnktMCY14YD/CjvN5ERsJiFtz3rDTQVbw
         ZmchfF6Z5TwjDu0cx7YAGMmo0YQOZermgXhScvj7dMXY2pEmwXmG0iCgDcXvCG4n6QnK
         T1rA==
X-Gm-Message-State: AOAM533R8vxt/uuyhyuEMqd8dl7dow16fyllEkUvgdOd2NYY0D6wxjK4
        mPcpC8btDIE0B5dq7dj8s9s=
X-Google-Smtp-Source: ABdhPJzSs0Zw1OPxv0SQRoQiZPP8wljYqksUhWu5P9q85AvyJ4tuA++0Bz7VMPtsz9l1RRQPdhaV3A==
X-Received: by 2002:a17:90a:a88:: with SMTP id 8mr6847557pjw.105.1602143765132;
        Thu, 08 Oct 2020 00:56:05 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:56:04 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Haiwei Li <lihaiwei@tencent.com>
Subject: [PATCH 32/35] mm, dmemfs: register and handle the dmem mce
Date:   Thu,  8 Oct 2020 15:54:22 +0800
Message-Id: <39d94616fd92ab9a1bb989c928783a7060df1fc7.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

dmemfs register the mce handler, send signal to the procs
whose vma is mapped in mce pfn.

Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/inode.c    | 141 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/dmem.h |   7 +++
 include/linux/mm.h   |   2 +
 mm/dmem.c            |  34 +++++++++++
 mm/memory-failure.c  |  63 ++++++++++++++-----
 5 files changed, 231 insertions(+), 16 deletions(-)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index 027428a7f7a0..adfceff98636 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -36,6 +36,47 @@ MODULE_LICENSE("GPL v2");
 
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
@@ -221,6 +262,13 @@ static unsigned long dmem_pgoff_to_index(struct inode *inode, pgoff_t pgoff)
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
@@ -809,6 +857,23 @@ static void dmemfs_evict_inode(struct inode *inode)
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
@@ -822,9 +887,11 @@ static int dmemfs_show_options(struct seq_file *m, struct dentry *root)
 }
 
 static const struct super_operations dmemfs_ops = {
+	.alloc_inode = dmemfs_alloc_inode,
 	.statfs	= dmemfs_statfs,
 	.evict_inode = dmemfs_evict_inode,
 	.drop_inode = generic_delete_inode,
+	.destroy_inode = dmemfs_destroy_inode,
 	.show_options = dmemfs_show_options,
 };
 
@@ -904,17 +971,91 @@ static struct file_system_type dmemfs_fs_type = {
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
index cd17a91a7264..fe0b270ef1e5 100644
--- a/include/linux/dmem.h
+++ b/include/linux/dmem.h
@@ -23,6 +23,13 @@ bool is_dmem_pfn(unsigned long pfn);
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
index 7b1e574d2387..ff0b12320ca1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3006,6 +3006,8 @@ extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
+extern void collect_procs_and_signal_inode(struct inode *inode, pgoff_t pgoff,
+				    unsigned long pfn, int flags);
 extern int get_hwpoison_page(struct page *page);
 #define put_hwpoison_page(page)	put_page(page)
 extern int sysctl_memory_failure_early_kill;
diff --git a/mm/dmem.c b/mm/dmem.c
index 16438dbed3f5..dd81b2483696 100644
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
@@ -121,6 +123,35 @@ static struct dmem_pool dmem_pool = {
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
index c613e1ec5995..cdd3cd77edbc 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -307,8 +307,8 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  */
 static void add_to_kill(struct task_struct *tsk, struct page *p,
-		       struct vm_area_struct *vma,
-		       struct list_head *to_kill)
+		       struct vm_area_struct *vma, unsigned long pfn,
+		       pgoff_t pgoff, struct list_head *to_kill)
 {
 	struct to_kill *tk;
 
@@ -318,12 +318,17 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
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
@@ -336,7 +341,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	 */
 	if (tk->addr == -EFAULT) {
 		pr_info("Memory failure: Unable to find user space address %lx in %s\n",
-			page_to_pfn(p), tsk->comm);
+			pfn, tsk->comm);
 	} else if (tk->size_shift == 0) {
 		kfree(tk);
 		return;
@@ -469,7 +474,8 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, vma, page_to_pfn(page),
+					page_to_pgoff(page), to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -477,19 +483,18 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
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
 
 	i_mmap_lock_read(mapping);
 	read_lock(&tasklist_lock);
 	for_each_process(tsk) {
-		pgoff_t pgoff = page_to_pgoff(page);
 		struct task_struct *t = task_early_kill(tsk, force_early);
 
 		if (!t)
@@ -504,13 +509,39 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * to be informed of all such data corruptions.
 			 */
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, vma, pfn, pgoff, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
 	i_mmap_unlock_read(mapping);
 }
 
+/*
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
 /*
  * Collect the processes who have the corrupted page mapped to kill.
  */
-- 
2.28.0

