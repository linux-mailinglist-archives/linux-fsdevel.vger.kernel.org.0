Return-Path: <linux-fsdevel+bounces-49045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAF2AB79E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BA37B7F5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44691246792;
	Wed, 14 May 2025 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykQwpTao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD46D2417F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266210; cv=none; b=nRODVyCtakNhoNdAfCHHNrkXEO8x22oUcPy102tl2yMjvbq72cbUdezuB8Ru//FDgX9wxhzxntpynvX0pQcFga5nYtogVmLN3Y99sNE3GhLJeugeh34nTozrudfWAIk9ZFI3r4C6n5qPqSJPeKTmdVQnJzAO2/VZyXoSXjrxWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266210; c=relaxed/simple;
	bh=nwUvWK7j9Kj8KbBDPMeg5Tkw109j7gyxcczO1q9K5+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RGkPzqGXazI4i9UGQBbF0yeeLoTgjqKJ0CVgVrar7oQ3yP/mmPaL7OGYkuvJZ1o+zF42SXrK7if+YHCjHUMaei+7GCO1SMxpI1ltf9aedpz15sWHqDakk12LZPQGl+apqO+O09i5NWvqaXFmsaKtIhYCfBdi0/yX0zMezLliSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykQwpTao; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30c371c34e7so404069a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266208; x=1747871008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iLum4dPU4sErthKtiaaPqZqnqSJWRV85cksXnAwJxvE=;
        b=ykQwpTaov4j6+oFidjP1X8A3elVTfV9/2BoGF7Vlbl9FSRYPdpXlin0PoCPLM/n3R6
         /vE+XBE+wYZOOIvq0pmn+MDErxokm3JT3picReyh7V81pJzvmkCvEArGPrLoQtNvvJIB
         dg65XgamWP69LLo56qhJSG6hDDSdQ/I+LykYqEeKlTJet+liIJwB6RBMB9mf6/N3O+Gm
         icRy74MdAdTIyEPpHmI2M5R08Bx8Tyzf6w2PtmyhUEcUrIcv86H1Dve3iAh6nV0B2g0t
         DfIbXtqcu6Sgir4TZkmWwVmQYWiiBllHMyByqDoPyIiMOhJRAjq2OMyPdaOcmSGyqsHi
         1Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266208; x=1747871008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLum4dPU4sErthKtiaaPqZqnqSJWRV85cksXnAwJxvE=;
        b=s6oBvnFLqX7uF9z0OTgGGyLYszzZNdDfdlADOlT+XnmqGpdly/YTft5ZyHofj3Wibo
         UzkzWFN/ClkaibaozHYwGprWjlR0WGONImEg078bmKnpFbeXlJ0Lg+/RQhdEi2Wy6Oqx
         yBA8iEXLfVZxw5bGR2ZPUjVVedGa3k35flX74Amr/tZVFPFO1skkwIJVMohQOhdxaXQS
         eGyXWa328JLm9I8lHlQQL1CobSJ700N2kUvHg2c0bwPgFDXNa3RTnN4HI+bMew9KfSdA
         /EHgOZ+YTrH6ZwGQfJ3Iy0JpN7oRQQfRH7V3KajWuEs1d20bC9NcAYrxsMh7KWWU9xad
         ihgw==
X-Forwarded-Encrypted: i=1; AJvYcCU1lIXoDq3bhmr+iax81pqdS3jMCfHQRW/w/Y3QFDBmw9igPSaaQX/K3ilHqD9GpFTprR13WknMURI9Og3L@vger.kernel.org
X-Gm-Message-State: AOJu0YxhTAqkPWhnRiYa6flGHMTW/e6jkP3WyHk6+AtPYyyRyJ5o0FN7
	zXEKr8bRn7+uxJJc5X0L0KsuHoXIq34gLql5cHN9BIxTlsBnm3XBxaKul1loGNOk9LCul4RAd0I
	udps8PkGVXxJw1S/gE3xjHg==
X-Google-Smtp-Source: AGHT+IFTVxsTLBGkiAhxwxfXI0xdufC6Hc5PJQ+0/Nhxii2q/tPBLHxyosuWUQut2LexX0oTzZIxWEdMSOoJvrMGKg==
X-Received: from pjbpm14.prod.google.com ([2002:a17:90b:3c4e:b0:2fa:15aa:4d2b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1cce:b0:306:b6f7:58ba with SMTP id 98e67ed59e1d1-30e5156ea36mr715371a91.6.1747266208304;
 Wed, 14 May 2025 16:43:28 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:59 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <faa8085e653c2967fd8a3b7e73aa93eab34bdd4f.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 20/51] mm: mempolicy: Refactor out policy_node_nodemask()
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
	yuzenghui@huawei.com, zhiquan1.li@intel.com, 
	kernel test robot <lkp@intel.com>, Gregory Price <gourry@gourry.net>
Content-Type: text/plain; charset="UTF-8"

This was refactored out of huge_node().

huge_node()'s interpretation of vma for order assumes the
hugetlb-specific storage of the hstate information in the
inode. policy_node_nodemask() does not assume that, and can be used
more generically.

This refactoring also enforces that nid default to the current node
id, which was not previously enforced.

alloc_pages_mpol() is the last remaining direct user of
policy_nodemask(). All its callers begin with nid being the current
node id as well. More refactoring is required for to simplify that.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409140519.DIQST28c-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202409140553.G2RGVWNA-lkp@intel.com/
Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Change-Id: I5774b27d2e718f4d08b59f8d2fedbb34eda7bac3
---
 include/linux/mempolicy.h |  9 +++++++++
 mm/mempolicy.c            | 33 ++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index ce9885e0178a..840c576abcfd 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -138,6 +138,8 @@ extern void numa_policy_init(void);
 extern void mpol_rebind_task(struct task_struct *tsk, const nodemask_t *new);
 extern void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new);
 
+extern int policy_node_nodemask(struct mempolicy *mpol, gfp_t gfp_flags,
+				pgoff_t ilx, nodemask_t **nodemask);
 extern int huge_node(struct vm_area_struct *vma,
 				unsigned long addr, gfp_t gfp_flags,
 				struct mempolicy **mpol, nodemask_t **nodemask);
@@ -251,6 +253,13 @@ static inline void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 }
 
+static inline int policy_node_nodemask(struct mempolicy *mpol, gfp_t gfp_flags,
+				       pgoff_t ilx, nodemask_t **nodemask)
+{
+	*nodemask = NULL;
+	return 0;
+}
+
 static inline int huge_node(struct vm_area_struct *vma,
 				unsigned long addr, gfp_t gfp_flags,
 				struct mempolicy **mpol, nodemask_t **nodemask)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b28a1e6ae096..7837158ee5a8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1261,7 +1261,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 
 		h = folio_hstate(src);
 		gfp = htlb_alloc_mask(h);
-		nodemask = policy_nodemask(gfp, pol, ilx, &nid);
+		nid = policy_node_nodemask(pol, gfp, ilx, &nodemask);
 		return alloc_hugetlb_folio_nodemask(h, nid, nodemask, gfp,
 				htlb_allow_alloc_fallback(MR_MEMPOLICY_MBIND));
 	}
@@ -2121,6 +2121,29 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
 	return nodemask;
 }
 
+/**
+ * policy_node_nodemask() - Interpret memory policy to get nodemask and nid.
+ *
+ * @mpol: the memory policy to interpret.
+ * @gfp_flags: gfp flags for this request.
+ * @ilx: interleave index, for use only when MPOL_INTERLEAVE or
+ *       MPOL_WEIGHTED_INTERLEAVE
+ * @nodemask: (output) pointer to nodemask pointer for 'bind' and 'prefer-many'
+ *            policy
+ *
+ * Context: must hold reference on @mpol.
+ * Return: a nid suitable for a page allocation and a pointer. If the effective
+ *         policy is 'bind' or 'prefer-many', returns a pointer to the
+ *         mempolicy's @nodemask for filtering the zonelist.
+ */
+int policy_node_nodemask(struct mempolicy *mpol, gfp_t gfp_flags,
+			 pgoff_t ilx, nodemask_t **nodemask)
+{
+	int nid = numa_node_id();
+	*nodemask = policy_nodemask(gfp_flags, mpol, ilx, &nid);
+	return nid;
+}
+
 #ifdef CONFIG_HUGETLBFS
 /*
  * huge_node(@vma, @addr, @gfp_flags, @mpol)
@@ -2139,12 +2162,9 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
 		struct mempolicy **mpol, nodemask_t **nodemask)
 {
 	pgoff_t ilx;
-	int nid;
 
-	nid = numa_node_id();
 	*mpol = get_vma_policy(vma, addr, hstate_vma(vma)->order, &ilx);
-	*nodemask = policy_nodemask(gfp_flags, *mpol, ilx, &nid);
-	return nid;
+	return policy_node_nodemask(*mpol, gfp_flags, ilx, nodemask);
 }
 
 /*
@@ -2601,8 +2621,7 @@ unsigned long alloc_pages_bulk_mempolicy_noprof(gfp_t gfp,
 		return alloc_pages_bulk_preferred_many(gfp,
 				numa_node_id(), pol, nr_pages, page_array);
 
-	nid = numa_node_id();
-	nodemask = policy_nodemask(gfp, pol, NO_INTERLEAVE_INDEX, &nid);
+	nid = policy_node_nodemask(pol, gfp, NO_INTERLEAVE_INDEX, &nodemask);
 	return alloc_pages_bulk_noprof(gfp, nid, nodemask,
 				       nr_pages, page_array);
 }
-- 
2.49.0.1045.g170613ef41-goog


