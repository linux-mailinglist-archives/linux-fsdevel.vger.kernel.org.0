Return-Path: <linux-fsdevel+bounces-54969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB63B05C58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04773ADA71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49982E7621;
	Tue, 15 Jul 2025 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dexsxioy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA742E7181
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585857; cv=none; b=PiEkMbEPtIMWYopcO28nL9h5/AYHaT3ggtMEZkhpdWBUYt4DHrLG8WfvP9sVIyvd79GRz4JGX5wvNZvjFYN4GRc8zVPU/pHPQLEUI/bNIhg7AnMM0tfgkt3ZNiRu3sXUDqYT1H6XlDS1Pf825vlEqaAXaUPIrrYe3LRBnknpwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585857; c=relaxed/simple;
	bh=TBptezEvoZbA/+QIqs5Pl7513sIN/gOoRGF1IIIkC9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1cuSRVqhrA48ZdC88JOkUoc9bLUQ6z2duCCz9PHqDlu+MynEVkw37Zq5jr01R9p9kczJpLl0rRxM/9SPlUe/dFNa++dnKlqJ5vP3QJrX3hGUBTWhW04NjbNk8a8EJ/7G6D0omFkE4YKHUvkHHlPl/aKhSRIfb1SUYwB6RAlpvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dexsxioy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipu1K94ir7ZDGEwTFYIjfG52vTt/Yk6xgTkmlb9d9g0=;
	b=dexsxioyWxZedP609GJjULozSbcGVGrjPHHHCfyzx7X/7TWpVeOCkfX5+8vMTFPy8pGeK6
	njSpIuFXKquYcEGZXXWttF9oRqzsUigwCzbhNFKYQu4dae+bg5bCkvkNt3CcVuBIu3AYVl
	BkCZIs0mbOxa7L2Iy5UDWmfkB8l53Sk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-x0dh6OVtMSerX1Sk8FgXew-1; Tue, 15 Jul 2025 09:24:13 -0400
X-MC-Unique: x0dh6OVtMSerX1Sk8FgXew-1
X-Mimecast-MFC-AGG-ID: x0dh6OVtMSerX1Sk8FgXew_1752585852
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so31684885e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 06:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585852; x=1753190652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipu1K94ir7ZDGEwTFYIjfG52vTt/Yk6xgTkmlb9d9g0=;
        b=pxbWxvNb4YSp2J5umpDIeRwHVrtdGyIMaKh8nI06rJDuyx+fR/V7a76KcrnNb1Rp7d
         OAjBbejlajf2tCp6WO8/tqidCqCLy/Nb1KC9BAMZg39dBcmaIhgPAulyI61aQahW1nDL
         d2metRg9b+PF152LobPRRgN2LL7hk+9vukQGyz+bAtkL8+stgKjNegSvF48lJ/8gkIoC
         n2WwKVtdN/+Abpy9UNgdXgDWqm+kfhqxvF7bchGovNjh0sSYbYOwQvq5VsNLbxr5ufKZ
         5Ed71+X9hFiRLMcR/o0JApmz2DZfyIHOUIZCaJkzUqLLIc1IrGums/RgJ8/Cwjfwi+gr
         DoHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC7yKIYKQCeAiuxE3xQKWVGgTo55LSRuhXd+AFCJ8imzXywNGkM49MU4JfTwmnWFTnErRZJZi6AnXa2lUA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9HEQ58hhKjdjcX+/XP/8qThLpPcay/VMzghVneJWZ0i+fy2W8
	JqDywbRtA9JoNKeev3Xn7B92+TzN8UzpVn7G38fPlkOckzTWTrYcuDraAgKtLZ83sK9xn8zLf88
	1etf/o7kc4zE2y8ZeNDoY3Dejkj5YNfwGFWWAZO2aAyWlzfKsnT0twUdZYYA2WFX/Y/3N0siSaw
	DMog==
X-Gm-Gg: ASbGncvUloCHoYd7CjRAZSG4EmFpTQIf/sIJ5vOdUpqcrTRxVUQWLHca/MGb9h31kSw
	OOWvYrNevpZYbYOll297naIfVCVjhNf/hgXLcAg8upV5BdqgyZC8XXwyAMEc2j6jGpyoTfW5hp+
	31xR7h/BRx/6zfbtYB/ToPdxRDUle+f7HpEP/XPYzV/WnSeJZMMH832iAzSfdi5ArZJdjP2EUhr
	ZDZTHgTViRxVn9ZOPlxDBeGIgwJ4e8ObNL2os1V8OES7a5DMtUi/LtneHrnF1Ii/ngMfi0UGAxs
	xgddtYiTBSRfrYCZDX9PlQSj2VWLZlHu95vxdr9etWftiURbLUBS+y+jWPbzbtZx2OoMzSltdS6
	1H1AByXR8M2qkU72Hi4XMeCN9
X-Received: by 2002:a05:600c:8b21:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-454f427c7a3mr171862335e9.8.1752585851886;
        Tue, 15 Jul 2025 06:24:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaYqvO7Z17qzgP+gQiOIR1ioSQdxI9NA77sZCIReClJxyu/a9rC4GbIDSj1kdPYM9bqwFuHQ==
X-Received: by 2002:a05:600c:8b21:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-454f427c7a3mr171861965e9.8.1752585851440;
        Tue, 15 Jul 2025 06:24:11 -0700 (PDT)
Received: from localhost (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454dd537c6fsm163863975e9.21.2025.07.15.06.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:24:10 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v1 8/9] mm: introduce and use vm_normal_page_pud()
Date: Tue, 15 Jul 2025 15:23:49 +0200
Message-ID: <20250715132350.2448901-9-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715132350.2448901-1-david@redhat.com>
References: <20250715132350.2448901-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's introduce vm_normal_page_pud(), which ends up being fairly simple
because of our new common helpers and there not being a PUD-sized zero
folio.

Use vm_normal_page_pud() in folio_walk_start() to resolve a TODO,
structuring the code like the other (pmd/pte) cases. Defer
introducing vm_normal_folio_pud() until really used.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 27 +++++++++++++++++++++++++++
 mm/pagewalk.c      | 20 ++++++++++----------
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 611f337cc36c9..6877c894fe526 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2347,6 +2347,8 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 				  unsigned long addr, pmd_t pmd);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 				pmd_t pmd);
+struct page *vm_normal_page_pud(struct vm_area_struct *vma, unsigned long addr,
+		pud_t pud);
 
 void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		  unsigned long size);
diff --git a/mm/memory.c b/mm/memory.c
index d5f80419989b9..f1834a19a2f1e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -802,6 +802,33 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 		return page_folio(page);
 	return NULL;
 }
+
+/**
+ * vm_normal_page_pud() - Get the "struct page" associated with a PUD
+ * @vma: The VMA mapping the @pud.
+ * @addr: The address where the @pud is mapped.
+ * @pud: The PUD.
+ *
+ * Get the "struct page" associated with a PUD. See vm_normal_page_pfn()
+ * for details.
+ *
+ * Return: Returns the "struct page" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
+ */
+struct page *vm_normal_page_pud(struct vm_area_struct *vma,
+		unsigned long addr, pud_t pud)
+{
+	unsigned long pfn = pud_pfn(pud);
+
+	if (unlikely(pud_special(pud))) {
+		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
+			return NULL;
+
+		print_bad_page_map(vma, addr, pud_val(pud), NULL);
+		return NULL;
+	}
+	return vm_normal_page_pfn(vma, addr, pfn, pud_val(pud));
+}
 #endif
 
 /**
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 648038247a8d2..c6753d370ff4e 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -902,23 +902,23 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		fw->pudp = pudp;
 		fw->pud = pud;
 
-		/*
-		 * TODO: FW_MIGRATION support for PUD migration entries
-		 * once there are relevant users.
-		 */
-		if (!pud_present(pud) || pud_special(pud)) {
+		if (pud_none(pud)) {
 			spin_unlock(ptl);
 			goto not_found;
-		} else if (!pud_leaf(pud)) {
+		} else if (pud_present(pud) && !pud_leaf(pud)) {
 			spin_unlock(ptl);
 			goto pmd_table;
+		} else if (pud_present(pud)) {
+			page = vm_normal_page_pud(vma, addr, pud);
+			if (page)
+				goto found;
 		}
 		/*
-		 * TODO: vm_normal_page_pud() will be handy once we want to
-		 * support PUD mappings in VM_PFNMAP|VM_MIXEDMAP VMAs.
+		 * TODO: FW_MIGRATION support for PUD migration entries
+		 * once there are relevant users.
 		 */
-		page = pud_page(pud);
-		goto found;
+		spin_unlock(ptl);
+		goto not_found;
 	}
 
 pmd_table:
-- 
2.50.1


