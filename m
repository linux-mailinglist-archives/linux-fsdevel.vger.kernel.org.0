Return-Path: <linux-fsdevel+bounces-49062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F57BAB7A0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA831891DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304A625D1E9;
	Wed, 14 May 2025 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWpVxQE4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B625C702
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266237; cv=none; b=fxtMDTqP27wUiCpHcyUFEYZeRWsokjWh5dwnwbfxjFIiLFAuMhQw78/jRCAu0/zAroqKQP9Xx7iKI69Wfo4Q1ZmFl/xjCOqtVeBOM65f6rJkcVqGHIUfYiN/95WsYzExyuVS/k8wAfz491fGViZ5u1CX2dSoTqzXBBNRWEYdTAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266237; c=relaxed/simple;
	bh=IMiKEMd6OxkBoCNVWLOzENvmPQZSLrc1NWT7HaivxWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JlpCMwUC2M6GKrqHXF441sd6mGWnaB28+ZlVq0M53QQ6lYMukmh4k7z0hMrDCCVDOHFvwtjpz/m1fSO0D/LIR50zfFK7vBHJ3QAwAzaa9DlDabAvOECZqZBeizeNF3JZNL3iMwsuL6pgHRoIYKtBn+EH3wyLjt4MQ00hnJPRI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWpVxQE4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7394792f83cso297119b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266235; x=1747871035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uuq1bEexdRhfFEX1jCABHc+UNgsIInH8N9P0pZ09IXA=;
        b=lWpVxQE4i8lmzDx5Y94IGz4ODljbyX6Edr1/iYC4JCNTqGAzQ6GikucSHNnRdq0k9N
         wODK+Rtr5JQD3u7Q4n1hTrv1wMtqWIsI6jlbUXvyaBIzUK1CVwoWo00ULPQ5LC/wZqiS
         /bz3GW6jBJR7jEyjvg4tIouNzElyQ9t89PXCO6piR8SqKWCbJX3JZRXVQIbVHhmGrzTR
         EXveltb979x2WHXeqroFn69h5lENXc+dbWBkAiJzhre355kM2mZbge3awmsRNQ2huF6w
         A/wQlyKBLnINIQSFc6jVv4srKLs4mHAC1wZXBUH4Ml4webkymYKUtL1aKuFuz6lkdWst
         nnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266235; x=1747871035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuq1bEexdRhfFEX1jCABHc+UNgsIInH8N9P0pZ09IXA=;
        b=I+EBtqMvcHp/KhIQmngeO7/L2dh649UnBPBkLkKuMtBWn8Zv7d8WBMME0XdEBSYGr8
         OX7f9RMDSCEVd7XzmzZgbglM3YI8PFrGsC7WXEoiLHKhqHavGnNjA2A2nKUen1eTFT/E
         C+GWPkvk0OFtIy0+cPZsAhrR+AyFJ2xxrHxIDJlyMiCiapSI1EJipDKPhVslj0Lq0eBh
         WvEtq3q/O4PBfVntNkaDjhKw4c55iPHbs8GzN5wj+IaDQzB8ywIx/A2q0a5eW7JGqUlG
         eR7Y3d5Cd208pvwXUCkZcTDjPWDizFAt8pcImvxdsIGCYpB3bV8iG8TKFoLt5o9yUiQY
         2Smg==
X-Forwarded-Encrypted: i=1; AJvYcCWvdwteQ+q1TBgkCwW36MJj2NFdTYROuz5vBW3F7B+31J6xzK1R/zKRa8W1ZH047Tj9bYVLxn+BPplCAGtu@vger.kernel.org
X-Gm-Message-State: AOJu0YwR75N4GnS+HxAuCq6vHdkkXxnviraiyo97s+8/aMYnRrYqKfnt
	n9r0UyOVNyJ9Esg0/eiWSfC3aHqrT1KxvlgUJJW5Yqv8bToWX5ME8K/dY/hiwJNI26BK26mqx6K
	/RVuN45BB5Pl9RqsvvnuizQ==
X-Google-Smtp-Source: AGHT+IEP7NX45yVSRggtsTELkRXbv8SEWvt+7ORsl2x8HhwmdlC6ogf+zGJHadz5Krd2YgHwh61qzF+l2O1bbO5BGw==
X-Received: from pfmv16.prod.google.com ([2002:a62:a510:0:b0:736:3cd5:ba3f])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:181c:b0:740:9d7c:aeb9 with SMTP id d2e1a72fcca58-74289377cb0mr7546070b3a.21.1747266234724;
 Wed, 14 May 2025 16:43:54 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:16 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <a7a0eb4053059731f70c18d4aa4736b6cf1b4e35.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 37/51] filemap: Pass address_space mapping to ->free_folio()
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com, Mike Day <michael.day@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Elliot Berman <quic_eberman@quicinc.com>

The plan is to be able to support multiple allocators for guest_memfd
folios. To allow each allocator to handle release of a folio from a
guest_memfd filemap, ->free_folio() needs to retrieve allocator
information that is stored on the guest_memfd inode.

->free_folio() shouldn't assume that folio->mapping is set/valid, and
the mapping is well-known to callers of .free_folio(). Hence, pass
address_space mapping to ->free_folio() for the callback to retrieve
any necessary information.

Link: https://lore.kernel.org/all/15f665b4-2d33-41ca-ac50-fafe24ade32f@redhat.com/
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Change-Id: I8bac907832a0b2491fa403a6ab72fcef1b4713ee
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Tested-by: Mike Day <michael.day@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/filesystems/locking.rst |  2 +-
 Documentation/filesystems/vfs.rst     | 15 +++++++++------
 fs/nfs/dir.c                          |  9 +++++++--
 fs/orangefs/inode.c                   |  3 ++-
 include/linux/fs.h                    |  2 +-
 mm/filemap.c                          |  9 +++++----
 mm/secretmem.c                        |  3 ++-
 mm/vmscan.c                           |  4 ++--
 virt/kvm/guest_memfd.c                |  3 ++-
 9 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 0ec0bb6eb0fb..c3d7430481ae 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -263,7 +263,7 @@ prototypes::
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
 	bool (*release_folio)(struct folio *, gfp_t);
-	void (*free_folio)(struct folio *);
+	void (*free_folio)(struct address_space *, struct folio *);
 	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	int (*migrate_folio)(struct address_space *, struct folio *dst,
 			struct folio *src, enum migrate_mode);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index ae79c30b6c0c..bba1ac848f96 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -833,7 +833,7 @@ cache in your filesystem.  The following members are defined:
 		sector_t (*bmap)(struct address_space *, sector_t);
 		void (*invalidate_folio) (struct folio *, size_t start, size_t len);
 		bool (*release_folio)(struct folio *, gfp_t);
-		void (*free_folio)(struct folio *);
+		void (*free_folio)(struct address_space *, struct folio *);
 		ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 		int (*migrate_folio)(struct mapping *, struct folio *dst,
 				struct folio *src, enum migrate_mode);
@@ -1011,11 +1011,14 @@ cache in your filesystem.  The following members are defined:
 	clear the uptodate flag if it cannot free private data yet.
 
 ``free_folio``
-	free_folio is called once the folio is no longer visible in the
-	page cache in order to allow the cleanup of any private data.
-	Since it may be called by the memory reclaimer, it should not
-	assume that the original address_space mapping still exists, and
-	it should not block.
+	free_folio is called once the folio is no longer visible in
+	the page cache in order to allow the cleanup of any private
+	data.  Since it may be called by the memory reclaimer, it
+	should not assume that the original address_space mapping
+	still exists at folio->mapping. The mapping the folio used to
+	belong to is instead passed for free_folio to read any
+	information it might need from the mapping. free_folio should
+	not block.
 
 ``direct_IO``
 	called by the generic read/write routines to perform direct_IO -
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index bd23fc736b39..148433f6d9d4 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -55,7 +55,7 @@ static int nfs_closedir(struct inode *, struct file *);
 static int nfs_readdir(struct file *, struct dir_context *);
 static int nfs_fsync_dir(struct file *, loff_t, loff_t, int);
 static loff_t nfs_llseek_dir(struct file *, loff_t, int);
-static void nfs_readdir_clear_array(struct folio *);
+static void nfs_free_folio(struct address_space *, struct folio *);
 static int nfs_do_create(struct inode *dir, struct dentry *dentry,
 			 umode_t mode, int open_flags);
 
@@ -69,7 +69,7 @@ const struct file_operations nfs_dir_operations = {
 };
 
 const struct address_space_operations nfs_dir_aops = {
-	.free_folio = nfs_readdir_clear_array,
+	.free_folio = nfs_free_folio,
 };
 
 #define NFS_INIT_DTSIZE PAGE_SIZE
@@ -230,6 +230,11 @@ static void nfs_readdir_clear_array(struct folio *folio)
 	kunmap_local(array);
 }
 
+static void nfs_free_folio(struct address_space *mapping, struct folio *folio)
+{
+	nfs_readdir_clear_array(folio);
+}
+
 static void nfs_readdir_folio_reinit_array(struct folio *folio, u64 last_cookie,
 					   u64 change_attr)
 {
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 5ac743c6bc2e..884cc5295f3e 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -449,7 +449,8 @@ static bool orangefs_release_folio(struct folio *folio, gfp_t foo)
 	return !folio_test_private(folio);
 }
 
-static void orangefs_free_folio(struct folio *folio)
+static void orangefs_free_folio(struct address_space *mapping,
+				struct folio *folio)
 {
 	kfree(folio_detach_private(folio));
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0fded2e3c661..9862ea92a2af 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -455,7 +455,7 @@ struct address_space_operations {
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
 	bool (*release_folio)(struct folio *, gfp_t);
-	void (*free_folio)(struct folio *folio);
+	void (*free_folio)(struct address_space *mapping, struct folio *folio);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	/*
 	 * migrate the contents of a folio to the specified target. If
diff --git a/mm/filemap.c b/mm/filemap.c
index bed7160db214..a02c3d8e00e8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -226,11 +226,11 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 
 void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 {
-	void (*free_folio)(struct folio *);
+	void (*free_folio)(struct address_space*, struct folio *);
 
 	free_folio = mapping->a_ops->free_folio;
 	if (free_folio)
-		free_folio(folio);
+		free_folio(mapping, folio);
 
 	folio_put_refs(folio, folio_nr_pages(folio));
 }
@@ -820,7 +820,8 @@ EXPORT_SYMBOL(file_write_and_wait_range);
 void replace_page_cache_folio(struct folio *old, struct folio *new)
 {
 	struct address_space *mapping = old->mapping;
-	void (*free_folio)(struct folio *) = mapping->a_ops->free_folio;
+	void (*free_folio)(struct address_space *, struct folio *) =
+		mapping->a_ops->free_folio;
 	pgoff_t offset = old->index;
 	XA_STATE(xas, &mapping->i_pages, offset);
 
@@ -849,7 +850,7 @@ void replace_page_cache_folio(struct folio *old, struct folio *new)
 		__lruvec_stat_add_folio(new, NR_SHMEM);
 	xas_unlock_irq(&xas);
 	if (free_folio)
-		free_folio(old);
+		free_folio(mapping, old);
 	folio_put(old);
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_folio);
diff --git a/mm/secretmem.c b/mm/secretmem.c
index c0e459e58cb6..178507c1b900 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -152,7 +152,8 @@ static int secretmem_migrate_folio(struct address_space *mapping,
 	return -EBUSY;
 }
 
-static void secretmem_free_folio(struct folio *folio)
+static void secretmem_free_folio(struct address_space *mapping,
+				 struct folio *folio)
 {
 	set_direct_map_default_noflush(&folio->page);
 	folio_zero_segment(folio, 0, folio_size(folio));
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3783e45bfc92..b8add4d0cf18 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -788,7 +788,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 		xa_unlock_irq(&mapping->i_pages);
 		put_swap_folio(folio, swap);
 	} else {
-		void (*free_folio)(struct folio *);
+		void (*free_folio)(struct address_space *, struct folio *);
 
 		free_folio = mapping->a_ops->free_folio;
 		/*
@@ -817,7 +817,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 		spin_unlock(&mapping->host->i_lock);
 
 		if (free_folio)
-			free_folio(folio);
+			free_folio(mapping, folio);
 	}
 
 	return 1;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 24d270b9b725..c578d0ebe314 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1319,7 +1319,8 @@ static void kvm_gmem_invalidate(struct folio *folio)
 static inline void kvm_gmem_invalidate(struct folio *folio) {}
 #endif
 
-static void kvm_gmem_free_folio(struct folio *folio)
+static void kvm_gmem_free_folio(struct address_space *mapping,
+				struct folio *folio)
 {
 	folio_clear_unevictable(folio);
 
-- 
2.49.0.1045.g170613ef41-goog


