Return-Path: <linux-fsdevel+bounces-43390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEB9A55C79
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 02:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC6F177418
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 01:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC0E13B293;
	Fri,  7 Mar 2025 00:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="JV914lPu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D1136352;
	Fri,  7 Mar 2025 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309118; cv=none; b=sKx7YGV5S6J6vPCs5D8sDEUbd6nNV8+ZNoJQTE40PGYW1hl9drJKxIMAdnvajYRCXOyHdjrzrv9Et0bUQRZZHpGShfBzmRxN5KefdztcGZgiUpvUk4D++hmJx0/kqZKfFZhzg9ZEBPu3hM9Cr9B29ydNyAKmKeurZQ2UqtHTBsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309118; c=relaxed/simple;
	bh=4xU6F7La+ws0aow6wqubP+OtL58zpgwYvT0M8ClIN/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqokWQ1D0kKvp8IVqJUpMNhzUTA5Vkn3NZa0lh+oukhPBycN6BTmh2L1EsAFMYZd+/+I74vlPs8QkrHT0DovXRcMfRym8IjSrAvYdL5m3cKlD+39eWYGPW1wjpsqVWV+seHII0k0a2FPHWGHS0QVa9SC0RuAPe5rzTKiFJDk1OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=JV914lPu; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1741309116; x=1772845116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Us+2oflLvLaA9Q+lohHm25RujTrS6yw5N7o3L4t/IOc=;
  b=JV914lPurH15HUDO55gzolO0gBte5oFHOegiGg3LTfsQr8KwJ4s1wAWM
   Qm2PdzvcPtJk0w/40sOP97w5qQb7/xwxp1Y3drywuFq9u6LChyq6Oq2oG
   YU0JLlA1PSdhi0COG7vTP+XkcSskJHIjSFFZWWAdtKWkX/jwhyys6TBDk
   E=;
X-IronPort-AV: E=Sophos;i="6.14,227,1736812800"; 
   d="scan'208";a="29275899"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 00:58:35 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:32828]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.101:2525] with esmtp (Farcaster)
 id 9eec1440-3b96-4a48-a704-b02f65525c99; Fri, 7 Mar 2025 00:58:34 +0000 (UTC)
X-Farcaster-Flow-ID: 9eec1440-3b96-4a48-a704-b02f65525c99
Received: from EX19D020UWA003.ant.amazon.com (10.13.138.254) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D020UWA003.ant.amazon.com (10.13.138.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 00:58:33 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com (Postfix) with ESMTP id 4FF9A401E0;
	Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 0F4D14FF6; Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: <linux-kernel@vger.kernel.org>
CC: Pratyush Yadav <ptyadav@amazon.de>, Jonathan Corbet <corbet@lwn.net>,
	"Eric Biederman" <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Hugh Dickins <hughd@google.com>, Alexander Graf
	<graf@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David
 Woodhouse" <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, "Mike
 Rapoport" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Pasha
 Tatashin" <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, "Wei
 Yang" <richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
Subject: [RFC PATCH 4/5] mm: shmem: allow preserving file over FDBOX + KHO
Date: Fri, 7 Mar 2025 00:57:38 +0000
Message-ID: <20250307005830.65293-5-ptyadav@amazon.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307005830.65293-1-ptyadav@amazon.de>
References: <20250307005830.65293-1-ptyadav@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

For applications with a large amount of memory that takes time to
rebuild, reboots to consume kernel upgrades can be very expensive. FDBox
allows preserving file descriptors over kexec using KHO. Combining that
with memfd gives those applications reboot-persistent memory that they
can use to quickly save and reconstruct that state.

Since memfd is backed either by hugetlbfs or shmem, use shmem as the
first backend for memfd that is FDBOX + KHO capable.

To preserve the file's contents during KHO activation, the file's page
cache must be walked and all entries removed, and their indices stored.
Use the newly introduced shmem_undo_range_ops to achieve this. Walk each
entry and before truncating it, take a refcount on the folio so it does
not get freed, and store its physical address and index in the kho_mem
and indices arrays.

Swap pages, partial folios, and huge folios are not supported yet.
Encountering those results in an error.

On the restore side, an empty file is created and then the mems array
walked to insert the pages into the page cache. The logic in
shmem_alloc_and_add_folio() is roughly followed.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---
 include/linux/shmem_fs.h |   6 +
 mm/shmem.c               | 333 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 339 insertions(+)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 0b273a7b9f01d..263416f357fe1 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -205,6 +205,12 @@ extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 #endif /* CONFIG_SHMEM */
 #endif /* CONFIG_USERFAULTFD */
 
+#if defined(CONFIG_FDBOX) && defined(CONFIG_KEXEC_HANDOVER)
+bool is_node_shmem(const void *fdt, int offset);
+int shmem_fdbox_kho_write(struct fdbox_fd *ffd, void *fdt);
+struct file *shmem_fdbox_kho_recover(const void *fdt, int offset);
+#endif
+
 /*
  * Used space is stored as unsigned 64-bit value in bytes but
  * quota core supports only signed 64-bit values so use that
diff --git a/mm/shmem.c b/mm/shmem.c
index d6d9266b27b75..c2efdb34a1a18 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -41,6 +41,12 @@
 #include <linux/swapfile.h>
 #include <linux/iversion.h>
 #include <linux/unicode.h>
+#include <linux/libfdt.h>
+#include <linux/fdbox.h>
+#include <linux/vmalloc.h>
+#include <linux/kexec.h>
+#include <linux/kexec_handover.h>
+#include <linux/cleanup.h>
 #include "swap.h"
 
 static struct vfsmount *shm_mnt __ro_after_init;
@@ -5283,6 +5289,333 @@ static int shmem_error_remove_folio(struct address_space *mapping,
 	return 0;
 }
 
+#if defined(CONFIG_FDBOX) && defined(CONFIG_KEXEC_HANDOVER)
+static const char fdbox_kho_compatible[] = "fdbox,shmem-v1";
+
+bool is_node_shmem(const void *fdt, int offset)
+{
+	return fdt_node_check_compatible(fdt, offset, fdbox_kho_compatible) == 0;
+}
+
+struct shmem_fdbox_put_arg {
+	struct kho_mem *mems;
+	unsigned long *indices;
+	unsigned long nr_mems;
+	unsigned long idx;
+};
+
+static long shmem_fdbox_undo_swap(struct address_space *mapping, pgoff_t index,
+				  void *old, void *arg)
+{
+	return -EOPNOTSUPP;
+}
+
+static int shmem_fdbox_undo_folio(struct address_space *mapping,
+				  struct folio *folio, void *__arg)
+{
+	struct shmem_fdbox_put_arg *arg = __arg;
+	struct kho_mem *mem;
+
+	if (arg->idx == arg->nr_mems)
+		return -ENOSPC;
+
+	if (folio_nr_pages(folio) != 1)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Grab an extra refcount to the folio so it sticks around after
+	 * truncation.
+	 */
+	folio_get(folio);
+
+	mem = arg->mems + arg->idx;
+
+	mem->addr = PFN_PHYS(folio_pfn(folio));
+	mem->size = PAGE_SIZE;
+	arg->indices[arg->idx] = folio_index(folio);
+	arg->idx++;
+
+	truncate_inode_folio(mapping, folio);
+	return 0;
+}
+
+static int shmem_fdbox_undo_partial_folio(struct folio *folio, pgoff_t lstart,
+					  pgoff_t lend, void *arg)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct shmem_undo_range_ops shmem_fdbox_undo_ops = {
+	.undo_swap = shmem_fdbox_undo_swap,
+	.undo_folio = shmem_fdbox_undo_folio,
+	.undo_partial_folio = shmem_fdbox_undo_partial_folio,
+};
+
+static struct kho_mem *shmem_fdbox_kho_get_mems(struct inode *inode,
+						unsigned long **indicesp,
+						unsigned long *nr)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	unsigned long *indices __free(kvfree) = NULL;
+	struct kho_mem *mems __free(kvfree) = NULL;
+	struct shmem_fdbox_put_arg arg;
+	unsigned long nr_mems;
+	int ret, i;
+
+	scoped_guard(spinlock, &info->lock) {
+		/* TODO: Support swapped pages. Perhaps swap them back in? */
+		if (info->swapped)
+			return ERR_PTR(-EOPNOTSUPP);
+
+		/*
+		 * Estimate the size of the array using the size of the inode,
+		 * assuming there are no contiguous pages.
+		 */
+		nr_mems = info->alloced;
+	}
+
+	mems = kvmalloc_array(nr_mems, sizeof(*mems), GFP_KERNEL);
+	if (!mems)
+		return ERR_PTR(-ENOMEM);
+
+	indices = kvmalloc_array(nr_mems, sizeof(*indices), GFP_KERNEL);
+	if (!indices)
+		return ERR_PTR(-ENOMEM);
+
+	arg.mems = mems;
+	arg.indices = indices;
+	arg.nr_mems = nr_mems;
+	arg.idx = 0;
+
+	ret = shmem_undo_range(inode, 0, -1, false, &shmem_fdbox_undo_ops, &arg);
+	if (ret < 0) {
+		pr_err("shmem: failed to undo fdbox range: %d\n", ret);
+		goto err;
+	}
+
+	*nr = arg.idx;
+	*indicesp = no_free_ptr(indices);
+	return_ptr(mems);
+
+err:
+	/*
+	 * TODO: This kills the whole file on failure to KHO. We should keep the
+	 * contents around for another try later. The problem is, if re-adding
+	 * pages fails, there would be no recovery at that point. Ideally, we
+	 * should first serialize the whole file, and only then remove things
+	 * from page cache so we are sure to never fail.
+	 */
+	for (i = 0; i < arg.idx; i++) {
+		struct folio *folio = page_folio(phys_to_page(mems[i].addr));
+
+		folio_put(folio);
+	}
+
+	/* Undo the rest of the file. This should not fail. */
+	WARN_ON(shmem_undo_range(inode, 0, -1, false, &shmem_default_undo_ops, NULL));
+	return ERR_PTR(ret);
+}
+
+int shmem_fdbox_kho_write(struct fdbox_fd *box_fd, void *fdt)
+{
+	struct inode *inode = box_fd->file->f_inode;
+	unsigned long *indices __free(kvfree) = NULL;
+	struct kho_mem *mems __free(kvfree) = NULL;
+	u64 pos = box_fd->file->f_pos, size = inode->i_size;
+	unsigned long nr_mems, i;
+	int ret = 0;
+
+	/*
+	 * mems can be larger than sizeof(*mems) * nr_mems, but we should only
+	 * look at things in the range of 0 to nr_mems.
+	 */
+	mems = shmem_fdbox_kho_get_mems(inode, &indices, &nr_mems);
+	if (IS_ERR(mems))
+		return PTR_ERR(mems);
+
+	/*
+	 * fdbox should have already started the node. We can start adding
+	 * properties directly.
+	 */
+	ret |= fdt_property(fdt, "compatible", fdbox_kho_compatible,
+			    sizeof(fdbox_kho_compatible));
+	ret |= fdt_property(fdt, "pos", &pos, sizeof(u64));
+	ret |= fdt_property(fdt, "size",  &size, sizeof(u64));
+	ret |= fdt_property(fdt, "mem", mems, sizeof(*mems) * nr_mems);
+	ret |= fdt_property(fdt, "indices", indices, sizeof(*indices) * nr_mems);
+
+	if (ret) {
+		pr_err("shmem: failed to add properties to FDT!\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	/*
+	 * TODO: This kills the whole file on failure to KHO. We should keep the
+	 * contents around for another try later. The problem is, if re-adding
+	 * pages fails, there would be no recovery at that point. Ideally, we
+	 * should first serialize the whole file, and only then remove things
+	 * from page cache so we are sure to never fail.
+	 */
+	for (i = 0; i < nr_mems; i++) {
+		struct folio *folio = page_folio(phys_to_page(mems[i].addr));
+
+		folio_put(folio);
+	}
+	return ret;
+}
+
+struct file *shmem_fdbox_kho_recover(const void *fdt, int offset)
+{
+	struct address_space *mapping;
+	char pathbuf[1024] = "", *path;
+	const unsigned long *indices;
+	const struct kho_mem *mems;
+	unsigned long nr_mems, i = 0;
+	const u64 *pos, *size;
+	struct inode *inode;
+	struct file *file;
+	int len, ret;
+
+	ret = fdt_node_check_compatible(fdt, offset, fdbox_kho_compatible);
+	if (ret) {
+		pr_err("shmem: invalid compatible\n");
+		goto err;
+	}
+
+	mems = fdt_getprop(fdt, offset, "mem", &len);
+	if (!mems || len % sizeof(*mems)) {
+		pr_err("shmem: invalid mems property\n");
+		goto err;
+	}
+	nr_mems = len / sizeof(*mems);
+
+	indices = fdt_getprop(fdt, offset, "indices", &len);
+	if (!indices || len % sizeof(unsigned long)) {
+		pr_err("shmem: invalid indices property\n");
+		goto err_return;
+	}
+	if (len / sizeof(unsigned long) != nr_mems) {
+		pr_err("shmem: number of indices and mems do not match\n");
+		goto err_return;
+	}
+
+	size = fdt_getprop(fdt, offset, "size", &len);
+	if (!size || len != sizeof(u64)) {
+		pr_err("shmem: invalid size property\n");
+		goto err_return;
+	}
+
+	pos = fdt_getprop(fdt, offset, "pos", &len);
+	if (!pos || len != sizeof(u64)) {
+		pr_err("shmem: invalid pos property\n");
+		goto err_return;
+	}
+
+	/*
+	 * TODO: This sets UID/GID, cgroup accounting to root. Should this
+	 * be given to the first user that maps the FD instead?
+	 */
+	file = shmem_file_setup(fdt_get_name(fdt, offset, NULL), 0,
+				VM_NORESERVE);
+	if (IS_ERR(file)) {
+		pr_err("shmem: failed to setup file\n");
+		goto err_return;
+	}
+
+	inode = file->f_inode;
+	mapping = inode->i_mapping;
+	vfs_setpos(file, *pos, MAX_LFS_FILESIZE);
+
+	for (; i < nr_mems; i++) {
+		struct folio *folio;
+		void *va;
+
+		if (mems[i].size != PAGE_SIZE) {
+			pr_err("shmem: unknown kho_mem size %llx. Expected %lx\n",
+			       mems[i].size, PAGE_SIZE);
+			goto err_return;
+		}
+
+		va = kho_claim_mem(&mems[i]);
+		folio = virt_to_folio(va);
+
+		/* Set up the folio for insertion. */
+
+		/*
+		 * TODO: This breaks falloc-ed folios since now they get marked
+		 * uptodate when they might not actually be zeroed out yet. Need
+		 * a way to distinguish falloc-ed folios.
+		 */
+		folio_mark_uptodate(folio);
+		folio_mark_dirty(folio);
+
+		/*
+		 * TODO: Should find a way to unify this and
+		 * shmem_alloc_and_add_folio().
+		 */
+		__folio_set_locked(folio);
+		__folio_set_swapbacked(folio);
+
+		ret = mem_cgroup_charge(folio, NULL, mapping_gfp_mask(mapping));
+		if (ret) {
+			folio_unlock(folio);
+			folio_put(folio);
+			fput(file);
+			pr_err("shmem: failed to charge folio index %lu\n", i);
+			goto err_return_next;
+		}
+
+		ret = shmem_add_to_page_cache(folio, mapping, indices[i], NULL,
+					      mapping_gfp_mask(mapping));
+		if (ret) {
+			folio_unlock(folio);
+			folio_put(folio);
+			fput(file);
+			pr_err("shmem: failed to add to page cache folio index %lu\n", i);
+			goto err_return_next;
+		}
+
+		ret = shmem_inode_acct_blocks(inode, 1);
+		if (ret) {
+			folio_unlock(folio);
+			folio_put(folio);
+			fput(file);
+			pr_err("shmem: failed to account folio index %lu\n", i);
+			goto err_return_next;
+		}
+
+		shmem_recalc_inode(inode, 1, 0);
+		folio_add_lru(folio);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+	inode->i_size = *size;
+
+	return file;
+
+err_return:
+	kho_return_mem(mems + i);
+err_return_next:
+	for (i = i + 1; i < nr_mems; i++)
+		kho_return_mem(mems + i);
+err:
+	ret = fdt_get_path(fdt, offset, pathbuf, sizeof(pathbuf));
+	if (ret)
+		path = "unknown";
+	else
+		path = pathbuf;
+
+	pr_err("shmem: error when recovering KHO node '%s'\n", path);
+	return NULL;
+}
+
+#endif /* CONFIG_FDBOX && CONFIG_KEXEC_HANDOVER */
+
 static const struct address_space_operations shmem_aops = {
 	.writepage	= shmem_writepage,
 	.dirty_folio	= noop_dirty_folio,
-- 
2.47.1


