Return-Path: <linux-fsdevel+bounces-64522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B00BBEB7FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D62E34A9E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E88236997A;
	Fri, 17 Oct 2025 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/TteNsH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C0133C50C
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731968; cv=none; b=swqHRCXUMr3OpJBBW2t60m1NOPIoi/XWyl5O0BqTGQshm5UQc9AEu5byBHptt2H2dQOUYqgHQCHf4CAer2Tn1BmANzcjHbAvEHk3HTswyRZvWAEDY9xSkCEiO4i0O/eVMBr6kzZK/YypvsJ/pXB5dOh/9/IpfBKwagzJk1GGIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731968; c=relaxed/simple;
	bh=Wdn2T0GwIysuclot1XJcLisQPX9jG00BSFSvltI6vWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W9masWPWiSdlIh4mxdA1u6JXMjk2Idk/ka3pMs4daCrKl7dKW4VDtFJ+KHuLlFC/SgneBcq24SUkcy3vHvsvrFzSkPOC5VSvAYzMBabxQTR4WhUuLD65BzALpgkquzBeOmXKiuwPXYT9/PAAfDoNeAytrhz+cl2CSCeQ+6moozU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y/TteNsH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-336b646768eso2679750a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731964; x=1761336764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mEyR0XL/MWXdmch8mXs3I8lfirsundW2Xy7Ox9OKFCE=;
        b=Y/TteNsHxd054Q6H5XfCHqfkLioMOndSCaDh5rCgqSXIzitF3aLyoInlEVVhEyNDXa
         0C49pCi2Mv2y5EB9Skc6ek11OlukIsYwJNAA4C9fKTk6puxaosZg2B+aSOjyfyEiJuwg
         2SsMHtexTs/HfEe8BIdY7bqy4zl/SVA6bGyEmntzI+zmQ5S2fGTZ3RKRJpUflRWzdoxB
         5/Ui4uwgC8MuShiI8tK5mPjTYmCncoknqospLRqSJcDY3MjvnjUI8U8PYW23cZJfNmEM
         5xFN/s1rZZTsRiX6Gimwm3Ii/hLgH1YFs7vn9QVHyFWt2ixAJI5V105kiRl6BLCssroP
         H6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731964; x=1761336764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEyR0XL/MWXdmch8mXs3I8lfirsundW2Xy7Ox9OKFCE=;
        b=O0L8h/sd3DprptYb+dEw0e1puYfji9VXcEiMNhpJA6YprpkGdVuz8Grq32PZ74MYGI
         j3dWOunLEpPFQXXW43zh70lhVc0lJclYMtupu+w60o3dh/KJBB4LcGskPQTh2pcHF8+T
         HpCesupMlxYolbMZbqcCBO/knPQHG3DDcUNjKe4uqPpF5sYOZpD6ALTVjaa0DrwB6S2I
         yEtFl6+iQM5R7A1e+CiT67gf2dYh1OYdjYgSvUsSEBvagTYdi1Bq8kTY5+kWzPmYQaiV
         NTLuwYnLfcJ7wE+awRiusBLFrVlyqc4fl+aPTr4D+wHwn97wO5yz4qYeOcvWmKEkjme/
         F2cg==
X-Forwarded-Encrypted: i=1; AJvYcCWPVlKwyTfg9lowZ4zMqSZTrd7v9Rj0IvD6xtzYEawWpliwoiHAuF5MQ5p5PeCHLanhPu1WE7klpZjPSNUb@vger.kernel.org
X-Gm-Message-State: AOJu0YyEvoVERBvdPR1sDWeEdn7SgEAIqy0U9FhkXBFWGTgGEYtmqnfZ
	cChkpQVAokUYzeTy++2qb1ojn7iqyCln1wJl7tjSbZsyAjTJbU3cjwHoxXhX/CqL8jKbeocC4tN
	pjcMfjueXmD/gNhE3JM//jAIMZQ==
X-Google-Smtp-Source: AGHT+IHrQmqbYBW8ZTel8gzz7v5OWEpv6AM6jQheWufRBYe3rBXgy4tqsdy8Q9e/A/F95BhCIEThHHdEEQUejvT3gA==
X-Received: from pjbqx13.prod.google.com ([2002:a17:90b:3e4d:b0:32d:e4c6:7410])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f10:b0:32d:17ce:49de with SMTP id 98e67ed59e1d1-33bcf85130bmr6655444a91.4.1760731963857;
 Fri, 17 Oct 2025 13:12:43 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:50 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <02aad35b728f4918e62dc6eb1d1d5546487b099e.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 09/37] KVM: guest_memfd: Skip LRU for guest_memfd folios
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

filemap_add_folio(), called from filemap_grab_folio(), adds folios to
an LRU list. This is unnecessary for guest_memfd, which does not
participate in swapping.

In addition, the LRU list takes a reference count on the folio. With
shared-to-private memory conversions for KVM guests dependent on folio
refcounts, this extra reference can cause conversions to fail due to
unexpected refcounts.

Rework kvm_gmem_get_folio() to manually allocate and insert the folio
into the page cache without placing it on the LRU. This is done by
calling __filemap_add_folio() directly.

The folio is then marked unevictable to avoid participation in
swapping. The ->free_folio() handler is modified to unset the
unevictable flag when the folio is released from guest_memfd.

This change ensures that LRU lists no longer take refcounts on
guest_memfd folios, significantly reducing the chance of elevated
refcounts during conversion.

To facilitate this, __filemap_add_folio is exported for KVM's use.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 mm/filemap.c           |  1 +
 mm/memcontrol.c        |  2 ++
 virt/kvm/guest_memfd.c | 60 +++++++++++++++++++++++++++++++++---------
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 03f223be575ca..60c7c95bbd7e6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -954,6 +954,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	return xas_error(&xas);
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
+EXPORT_SYMBOL_FOR_MODULES(__filemap_add_folio, "kvm");
 
 int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 				pgoff_t index, gfp_t gfp)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a942..fe8629414d0a9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4721,6 +4721,7 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 
 	return ret;
 }
+EXPORT_SYMBOL_FOR_MODULES(__mem_cgroup_charge, "kvm");
 
 /**
  * mem_cgroup_charge_hugetlb - charge the memcg for a hugetlb folio
@@ -4893,6 +4894,7 @@ void __mem_cgroup_uncharge(struct folio *folio)
 	uncharge_folio(folio, &ug);
 	uncharge_batch(&ug);
 }
+EXPORT_SYMBOL_FOR_MODULES(__mem_cgroup_uncharge, "kvm");
 
 void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
 {
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 2a9e9220a48aa..dab2b3ce78bc8 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -148,6 +148,41 @@ static struct mempolicy *kvm_gmem_get_folio_policy(struct gmem_inode *gi,
 #endif
 }
 
+static struct folio *__kvm_gmem_get_folio(struct address_space *mapping,
+					  pgoff_t index,
+					  struct mempolicy *policy)
+{
+	const gfp_t gfp = mapping_gfp_mask(mapping);
+	struct folio *folio;
+	int err;
+
+	folio = filemap_lock_folio(mapping, index);
+	if (!IS_ERR(folio))
+		return folio;
+
+	folio = filemap_alloc_folio(gfp, 0, policy);
+	if (!folio)
+		return ERR_PTR(-ENOMEM);
+
+	err = mem_cgroup_charge(folio, NULL, gfp);
+	if (err)
+		goto err_put;
+
+	__folio_set_locked(folio);
+
+	err = __filemap_add_folio(mapping, folio, index, gfp, NULL);
+	if (err) {
+		__folio_clear_locked(folio);
+		goto err_put;
+	}
+
+	return folio;
+
+err_put:
+	folio_put(folio);
+	return ERR_PTR(err);
+}
+
 /*
  * Returns a locked folio on success.  The caller is responsible for
  * setting the up-to-date flag before the memory is mapped into the guest.
@@ -160,6 +195,7 @@ static struct mempolicy *kvm_gmem_get_folio_policy(struct gmem_inode *gi,
 static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 {
 	/* TODO: Support huge pages. */
+	struct address_space *mapping = inode->i_mapping;
 	struct mempolicy *policy;
 	struct folio *folio;
 
@@ -167,16 +203,17 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	 * Fast-path: See if folio is already present in mapping to avoid
 	 * policy_lookup.
 	 */
-	folio = filemap_lock_folio(inode->i_mapping, index);
+	folio = filemap_lock_folio(mapping, index);
 	if (!IS_ERR(folio))
 		return folio;
 
 	policy = kvm_gmem_get_folio_policy(GMEM_I(inode), index);
-	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
-					 FGP_LOCK | FGP_CREAT,
-					 mapping_gfp_mask(inode->i_mapping), policy);
-	mpol_cond_put(policy);
 
+	do {
+		folio = __kvm_gmem_get_folio(mapping, index, policy);
+	} while (IS_ERR(folio) && PTR_ERR(folio) == -EEXIST);
+
+	mpol_cond_put(policy);
 	return folio;
 }
 
@@ -588,24 +625,21 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 	return MF_DELAYED;
 }
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 static void kvm_gmem_free_folio(struct folio *folio)
 {
-	struct page *page = folio_page(folio, 0);
-	kvm_pfn_t pfn = page_to_pfn(page);
-	int order = folio_order(folio);
+	folio_clear_unevictable(folio);
 
-	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
-}
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+	kvm_arch_gmem_invalidate(folio_pfn(folio),
+				 folio_pfn(folio) + folio_nr_pages(folio));
 #endif
+}
 
 static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 	.migrate_folio	= kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	.free_folio = kvm_gmem_free_folio,
-#endif
 };
 
 static int kvm_gmem_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-- 
2.51.0.858.gf9c4a03a3a-goog


