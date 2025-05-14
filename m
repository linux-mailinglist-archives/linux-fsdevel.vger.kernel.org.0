Return-Path: <linux-fsdevel+bounces-49027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E6AAB798F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4099C1BA2A04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D20022B8CE;
	Wed, 14 May 2025 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cye03Usj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8FA227BA2
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266182; cv=none; b=o/bnipASv0dMB4QdClJDiGTlsesL9CmMDSRSqfp/bgG2y3uvwVKyPpP7i+vmVSQMiQEGEOFDV8Ffp+EimPM1ctCqV12u5AfkaCJzGidZPXJ5eoGU0guDyQJL6rqDlkQ9e0ikdIUJUR5nVOcRmitPtwhX0Rbn3TGyOeNBryeyzqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266182; c=relaxed/simple;
	bh=Z3mPvWkTUo74uZNv1q+N4L5sLrbeGWDIQpX5nFgYkp0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uI5nQiwDCUdP3vFO+01G6AZmIYX6MQ01ETb6DtAZZ5vaHzHoCxqxvSyKK200FXUmcJMkzcYwCO/MnK6l2jcQPhjj56oWvaHdrDS7yvGN23P7uAiWWh2QdlcFPgh0pR1gFbo3WBght9jkn+IU6qvE5nOFzKWrZ0dEB+a7gi2zIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cye03Usj; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-741a845cab2so477282b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266180; x=1747870980; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFE+VAE/0TzxtaL5pFdDBk9KqgEP3a2++vmAovntxU8=;
        b=Cye03UsjdQFqf0FL962CMQGfQ9JsavD6n+zt4YMeR2fDcH90mdwYwvaD2tQ0BL2REu
         0p6cBKSSR6OxoWFT4PPRxB2whD56xlg2l6gfIOAAItX3sTgtqAKhFDnldGLZQpGvIUrX
         CpMkrQE8y5AKbCYC6dSpO7w/hf1AYB+Z4fBQuvFOkIhEZvT6sc1fYGzzjgcsZbeDQWRl
         WnRIIVVLeoeTt3gygA6WRcl6NdIFQHSfOSWF0hEJCziczcDUWbKWvhqYj3pQY3NuetL5
         2W/r5WMJ0SkR+zsIrnW+u1RriGrrDwT4cdrBBFBqd/jJkXnHDFJZF6RlOnhRl9E8phkl
         OLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266180; x=1747870980;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFE+VAE/0TzxtaL5pFdDBk9KqgEP3a2++vmAovntxU8=;
        b=kL3hESQYN+38XLt0nIkTZ+NHxyJsLoVrpFxGVVvysxEPm6mnWpL2Ksy2lPRe9JPpuX
         GsekTqwxPNf3j8pMgcs5NkIayE3pu87KQ6dhujAf1BQ0bij2kj8ApebFDLP5Oywa8y4d
         V3JTqOV6XhfaRNGjjePx4l84rSpvVNHwhND87s9UIy8irlUDvixtGX6fdt3cbix2f3oQ
         q3099tlZSq9aEpwy0qsvUnu9jBV8j3mghBFmjAgl6n81OhiEprAqx6p5Xj364zWWmfnu
         x4mFHULCQWQALAOd9mRN1ZywcXITKWzjsEViyWpEv5XXyvvXlPKckTsOsEv7oqBsD+Hq
         SoRg==
X-Forwarded-Encrypted: i=1; AJvYcCXD77Xu61vlkIo0jZb1T5fO5M0lhVAGIwJk1n1VhCfhd0gRrIS3jQHyWZv4f7Ae8u+eYBzb47xNPSNdZpOQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZqHFLJ0PGHwhdotzt/tF3/7XWGu5xVwFiGs64iHWO560Ntfh
	SSnfD59AS2pyCcRy7FLfzmQuxIsXOuVUXUZ1nql/P/qfoLGj5NLIzOY3tqfp1pAi4w4+6TrCa1E
	YOg8KQBjXUaiW9la/EfEFZA==
X-Google-Smtp-Source: AGHT+IH2SLSnX8hsNiO9/wgN08juESR9wv9AYUbEDhzJBJHGfElIKJ6uImvash75kjiAopzOkjbf2Pzlkbo1QoRW6g==
X-Received: from pfx11.prod.google.com ([2002:a05:6a00:a44b:b0:741:e763:be68])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1941:b0:740:9e87:9625 with SMTP id d2e1a72fcca58-742984c1549mr854404b3a.4.1747266180097;
 Wed, 14 May 2025 16:43:00 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:41 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use shareability
 to guard faulting
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
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Track guest_memfd memory's shareability status within the inode as
opposed to the file, since it is property of the guest_memfd's memory
contents.

Shareability is a property of the memory and is indexed using the
page's index in the inode. Because shareability is the memory's
property, it is stored within guest_memfd instead of within KVM, like
in kvm->mem_attr_array.

KVM_MEMORY_ATTRIBUTE_PRIVATE in kvm->mem_attr_array must still be
retained to allow VMs to only use guest_memfd for private memory and
some other memory for shared memory.

Not all use cases require guest_memfd() to be shared with the host
when first created. Add a new flag, GUEST_MEMFD_FLAG_INIT_PRIVATE,
which when set on KVM_CREATE_GUEST_MEMFD, initializes the memory as
private to the guest, and therefore not mappable by the
host. Otherwise, memory is shared until explicitly converted to
private.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Co-developed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Change-Id: If03609cbab3ad1564685c85bdba6dcbb6b240c0f
---
 Documentation/virt/kvm/api.rst |   5 ++
 include/uapi/linux/kvm.h       |   2 +
 virt/kvm/guest_memfd.c         | 124 ++++++++++++++++++++++++++++++++-
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 86f74ce7f12a..f609337ae1c2 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6408,6 +6408,11 @@ belonging to the slot via its userspace_addr.
 The use of GUEST_MEMFD_FLAG_SUPPORT_SHARED will not be allowed for CoCo VMs.
 This is validated when the guest_memfd instance is bound to the VM.
 
+If the capability KVM_CAP_GMEM_CONVERSIONS is supported, then the 'flags' field
+supports GUEST_MEMFD_FLAG_INIT_PRIVATE.  Setting GUEST_MEMFD_FLAG_INIT_PRIVATE
+will initialize the memory for the guest_memfd as guest-only and not faultable
+by the host.
+
 See KVM_SET_USER_MEMORY_REGION2 for additional details.
 
 4.143 KVM_PRE_FAULT_MEMORY
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4cc824a3a7c9..d7df312479aa 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1567,7 +1567,9 @@ struct kvm_memory_attributes {
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
+
 #define GUEST_MEMFD_FLAG_SUPPORT_SHARED	(1UL << 0)
+#define GUEST_MEMFD_FLAG_INIT_PRIVATE	(1UL << 1)
 
 struct kvm_create_guest_memfd {
 	__u64 size;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 239d0f13dcc1..590932499eba 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,7 @@
 #include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/kvm_host.h>
+#include <linux/maple_tree.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
 
@@ -17,6 +18,24 @@ struct kvm_gmem {
 	struct list_head entry;
 };
 
+struct kvm_gmem_inode_private {
+#ifdef CONFIG_KVM_GMEM_SHARED_MEM
+	struct maple_tree shareability;
+#endif
+};
+
+enum shareability {
+	SHAREABILITY_GUEST = 1,	/* Only the guest can map (fault) folios in this range. */
+	SHAREABILITY_ALL = 2,	/* Both guest and host can fault folios in this range. */
+};
+
+static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index);
+
+static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode *inode)
+{
+	return inode->i_mapping->i_private_data;
+}
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -29,6 +48,58 @@ static inline kvm_pfn_t folio_file_pfn(struct folio *folio, pgoff_t index)
 	return folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1));
 }
 
+#ifdef CONFIG_KVM_GMEM_SHARED_MEM
+
+static int kvm_gmem_shareability_setup(struct kvm_gmem_inode_private *private,
+				      loff_t size, u64 flags)
+{
+	enum shareability m;
+	pgoff_t last;
+
+	last = (size >> PAGE_SHIFT) - 1;
+	m = flags & GUEST_MEMFD_FLAG_INIT_PRIVATE ? SHAREABILITY_GUEST :
+						    SHAREABILITY_ALL;
+	return mtree_store_range(&private->shareability, 0, last, xa_mk_value(m),
+				 GFP_KERNEL);
+}
+
+static enum shareability kvm_gmem_shareability_get(struct inode *inode,
+						 pgoff_t index)
+{
+	struct maple_tree *mt;
+	void *entry;
+
+	mt = &kvm_gmem_private(inode)->shareability;
+	entry = mtree_load(mt, index);
+	WARN(!entry,
+	     "Shareability should always be defined for all indices in inode.");
+
+	return xa_to_value(entry);
+}
+
+static struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
+{
+	if (kvm_gmem_shareability_get(inode, index) != SHAREABILITY_ALL)
+		return ERR_PTR(-EACCES);
+
+	return kvm_gmem_get_folio(inode, index);
+}
+
+#else
+
+static int kvm_gmem_shareability_setup(struct maple_tree *mt, loff_t size, u64 flags)
+{
+	return 0;
+}
+
+static inline struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
+{
+	WARN_ONCE("Unexpected call to get shared folio.")
+	return NULL;
+}
+
+#endif /* CONFIG_KVM_GMEM_SHARED_MEM */
+
 static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 				    pgoff_t index, struct folio *folio)
 {
@@ -333,7 +404,7 @@ static vm_fault_t kvm_gmem_fault_shared(struct vm_fault *vmf)
 
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
-	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
+	folio = kvm_gmem_get_shared_folio(inode, vmf->pgoff);
 	if (IS_ERR(folio)) {
 		int err = PTR_ERR(folio);
 
@@ -420,8 +491,33 @@ static struct file_operations kvm_gmem_fops = {
 	.fallocate	= kvm_gmem_fallocate,
 };
 
+static void kvm_gmem_free_inode(struct inode *inode)
+{
+	struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
+
+	kfree(private);
+
+	free_inode_nonrcu(inode);
+}
+
+static void kvm_gmem_destroy_inode(struct inode *inode)
+{
+	struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
+
+#ifdef CONFIG_KVM_GMEM_SHARED_MEM
+	/*
+	 * mtree_destroy() can't be used within rcu callback, hence can't be
+	 * done in ->free_inode().
+	 */
+	if (private)
+		mtree_destroy(&private->shareability);
+#endif
+}
+
 static const struct super_operations kvm_gmem_super_operations = {
 	.statfs		= simple_statfs,
+	.destroy_inode	= kvm_gmem_destroy_inode,
+	.free_inode	= kvm_gmem_free_inode,
 };
 
 static int kvm_gmem_init_fs_context(struct fs_context *fc)
@@ -549,12 +645,26 @@ static const struct inode_operations kvm_gmem_iops = {
 static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
 						      loff_t size, u64 flags)
 {
+	struct kvm_gmem_inode_private *private;
 	struct inode *inode;
+	int err;
 
 	inode = alloc_anon_secure_inode(kvm_gmem_mnt->mnt_sb, name);
 	if (IS_ERR(inode))
 		return inode;
 
+	err = -ENOMEM;
+	private = kzalloc(sizeof(*private), GFP_KERNEL);
+	if (!private)
+		goto out;
+
+	mt_init(&private->shareability);
+	inode->i_mapping->i_private_data = private;
+
+	err = kvm_gmem_shareability_setup(private, size, flags);
+	if (err)
+		goto out;
+
 	inode->i_private = (void *)(unsigned long)flags;
 	inode->i_op = &kvm_gmem_iops;
 	inode->i_mapping->a_ops = &kvm_gmem_aops;
@@ -566,6 +676,11 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
 	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
 
 	return inode;
+
+out:
+	iput(inode);
+
+	return ERR_PTR(err);
 }
 
 static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
@@ -654,6 +769,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	if (kvm_arch_vm_supports_gmem_shared_mem(kvm))
 		valid_flags |= GUEST_MEMFD_FLAG_SUPPORT_SHARED;
 
+	if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED)
+		valid_flags |= GUEST_MEMFD_FLAG_INIT_PRIVATE;
+
 	if (flags & ~valid_flags)
 		return -EINVAL;
 
@@ -842,6 +960,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (!file)
 		return -EFAULT;
 
+	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
+
 	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared, max_order);
 	if (IS_ERR(folio)) {
 		r = PTR_ERR(folio);
@@ -857,8 +977,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		*page = folio_file_page(folio, index);
 	else
 		folio_put(folio);
-
 out:
+	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
 	fput(file);
 	return r;
 }
-- 
2.49.0.1045.g170613ef41-goog


