Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D76218104B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 04:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfHECiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Aug 2019 22:38:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41397 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfHECiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Aug 2019 22:38:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so38820060pff.8;
        Sun, 04 Aug 2019 19:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30MQZ7ywyXKAPoZ0MqYExKYsjkeLdKEHUByfnmRZCb0=;
        b=IvagmT+JjyfUCHaWI+oWVe83Vd/BxQOf8lwVAIUGNrLrImKDoBg69DgWJgweIFVTTb
         t9Fd81BoXyIbeQKtADBPM518HlERGQ3S9QcdZHl5GHiZ+3CZc/mG3ldNB0DFVA+oLUky
         4YoCR5Kn54jmKeO0SgOFTU8UIG8AhTiXpPY6aJvZHzWR0iW1+d6D4ft05gUFQbHqtsLD
         2zVi6PAEyNlZ9Rcwg5VvXyY5LHWfMMKMh+VnR92xmXqN8pMV8+STxr2eXC203UO1Tpla
         uNVcRsRdtOQH81N2Ng5sIXu+JR5jaekJfCc+SvAJlP4bu/MpAl9h4hDu3E/NASSFtOhS
         NHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30MQZ7ywyXKAPoZ0MqYExKYsjkeLdKEHUByfnmRZCb0=;
        b=d2KmTrtCo0MbvIAtiaPKf4emrivyMlJshLfipUNil2ptHJw/ZxaoiJB7SlSi3XMbn9
         IX6WG4AlJRzbZk+CwD+XJY7Wy+IOz43rKR2LNGngbPrH7ei9vzym+sxI5OKlETp+DqqF
         rCem9qFqUg+fEex36a9QGa0niKLiLyQ0fsXW8wmfhH5zrl3kn1sBNv8dWl8mZR3paB7B
         z7/aqaIjLV/dz3rnuERNBE9FJmDfK/w6P0TyY7br39hovU0ThTgp0oVc85gwHEB+3whO
         fjExI7kSQJwzVstGWBTP6Pq8ESCsUwQ6RDaRoi8hV5U0zOkeAob0KxKEuOpW5S/xoLpb
         1hZg==
X-Gm-Message-State: APjAAAU+LqQGyQwJ2ig0DaQRz8BgR9KU7JvlLYbHJZzAyHWg7UPoe3Au
        BQmUHhOgXgBN1rm2i5zp8gY=
X-Google-Smtp-Source: APXvYqxhbQJILXTxhwn1nUnYV8i/zFa6et+z4o7S2/4wOMnlr3FWVDcMtMr/x65TCuwWLuIgS9IZbw==
X-Received: by 2002:a62:7a8a:: with SMTP id v132mr70688812pfc.103.1564972702334;
        Sun, 04 Aug 2019 19:38:22 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id p13sm25433972pjb.30.2019.08.04.19.38.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 19:38:21 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: convert put_page() to put_user_page*()
Date:   Sun,  4 Aug 2019 19:38:19 -0700
Message-Id: <20190805023819.11001-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Note that this effectively changes the code's behavior in
mm_iommu_unpin(): it now ultimately calls set_page_dirty_lock(),
instead of set_page_dirty(). This is probably more accurate.

As Christoph Hellwig put it, "set_page_dirty() is only safe if we are
dealing with a file backed page where we have reference on the inode it
hangs off." [1]

[1] https://lore.kernel.org/r/20190723153640.GB720@lst.de

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |  4 ++--
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 19 ++++++++++++++-----
 arch/powerpc/kvm/e500_mmu.c            |  3 +--
 arch/powerpc/mm/book3s64/iommu_api.c   | 11 +++++------
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 9a75f0e1933b..18646b738ce1 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -731,7 +731,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		 * we have to drop the reference on the correct tail
 		 * page to match the get inside gup()
 		 */
-		put_page(pages[0]);
+		put_user_page(pages[0]);
 	}
 	return ret;
 
@@ -1206,7 +1206,7 @@ void kvmppc_unpin_guest_page(struct kvm *kvm, void *va, unsigned long gpa,
 	unsigned long gfn;
 	int srcu_idx;
 
-	put_page(page);
+	put_user_page(page);
 
 	if (!dirty)
 		return;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 2d415c36a61d..f53273fbfa2d 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -821,8 +821,12 @@ int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
 	 */
 	if (!ptep) {
 		local_irq_enable();
-		if (page)
-			put_page(page);
+		if (page) {
+			if (upgrade_write)
+				put_user_page(page);
+			else
+				put_page(page);
+		}
 		return RESUME_GUEST;
 	}
 	pte = *ptep;
@@ -870,9 +874,14 @@ int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
 		*levelp = level;
 
 	if (page) {
-		if (!ret && (pte_val(pte) & _PAGE_WRITE))
-			set_page_dirty_lock(page);
-		put_page(page);
+		bool dirty = !ret && (pte_val(pte) & _PAGE_WRITE);
+		if (upgrade_write)
+			put_user_pages_dirty_lock(&page, 1, dirty);
+		else {
+			if (dirty)
+				set_page_dirty_lock(page);
+			put_page(page);
+		}
 	}
 
 	/* Increment number of large pages if we (successfully) inserted one */
diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 2d910b87e441..67bb8d59d4b1 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -850,8 +850,7 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu *vcpu,
  free_privs_first:
 	kfree(privs[0]);
  put_pages:
-	for (i = 0; i < num_pages; i++)
-		put_page(pages[i]);
+	put_user_pages(pages, num_pages);
  free_pages:
 	kfree(pages);
 	return ret;
diff --git a/arch/powerpc/mm/book3s64/iommu_api.c b/arch/powerpc/mm/book3s64/iommu_api.c
index b056cae3388b..e126193ba295 100644
--- a/arch/powerpc/mm/book3s64/iommu_api.c
+++ b/arch/powerpc/mm/book3s64/iommu_api.c
@@ -170,9 +170,8 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	return 0;
 
 free_exit:
-	/* free the reference taken */
-	for (i = 0; i < pinned; i++)
-		put_page(mem->hpages[i]);
+	/* free the references taken */
+	put_user_pages(mem->hpages, pinned);
 
 	vfree(mem->hpas);
 	kfree(mem);
@@ -203,6 +202,7 @@ static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
 {
 	long i;
 	struct page *page = NULL;
+	bool dirty = false;
 
 	if (!mem->hpas)
 		return;
@@ -215,10 +215,9 @@ static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
 		if (!page)
 			continue;
 
-		if (mem->hpas[i] & MM_IOMMU_TABLE_GROUP_PAGE_DIRTY)
-			SetPageDirty(page);
+		dirty = mem->hpas[i] & MM_IOMMU_TABLE_GROUP_PAGE_DIRTY;
 
-		put_page(page);
+		put_user_pages_dirty_lock(&page, 1, dirty);
 		mem->hpas[i] = 0;
 	}
 }
-- 
2.22.0

