Return-Path: <linux-fsdevel+bounces-55254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF27B08C24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07D516841D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31782BEC29;
	Thu, 17 Jul 2025 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/3AM0dM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD072BE04D
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753160; cv=none; b=kchwHY5KKK6v+gxYWV6Gkkb3k8wXVoDGRsTGJUT8gF6vfGxSzGlSoGwbJvBVYtuvkxWMbZy4I1za4HVSydsW/5YYi243Ybs9einzedm4cqBaoJ86zNrvXetpNc60of2+pTMQkRu68MQZFFaNXAsfxm38rBjCz6KAS119SbrtJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753160; c=relaxed/simple;
	bh=6/jjLRxyu6Gk21aB2ScFk9YQfi5MLdI3W8BYCgHrJ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBPG7wPQgOM9xzOwzs5hepyMagfzD0+jstdk4Y6GHlPjUa0tX+3qsYsdHg8MrhGS81dmB4e3S0cZ4WLZHeRr6qOMahziJbUSVo5TX2YOiI7FqZ6jAtguC4oXuEYrw+S1/2H48a3H2m0WnEpMPry+zibnBMKenlNYLmspAxOoYHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/3AM0dM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752753157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y93PTvMkvM029q6ldi/06ftGqYZT07G8pbjSDy6T3hs=;
	b=Z/3AM0dM5PwCbQza5Oi9+FpboGpcxweZx2NtowW27M5UhR5onZVY8DPTvVx1R9rXCKHCGD
	cGf6KEQnzIRL2qpu7X+9C2U3XunC6EfTFGo2rxDZZdU0fI+PLoIXrHoqpas6hQg4EGeyQt
	I4t069yR+tzwPp7pTNag29Pmddd+kQk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-zU2htObPM4ez48QApzoY3g-1; Thu, 17 Jul 2025 07:52:36 -0400
X-MC-Unique: zU2htObPM4ez48QApzoY3g-1
X-Mimecast-MFC-AGG-ID: zU2htObPM4ez48QApzoY3g_1752753155
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so563442f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 04:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753155; x=1753357955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y93PTvMkvM029q6ldi/06ftGqYZT07G8pbjSDy6T3hs=;
        b=d+Y6kksRkR9vqr+V3bPmU//qPyivhptwD4Yn/EMmtMG1FzKLVmkfp8sLoj+IXV4B49
         ntLmFmbNEUE4jrlxOD1VQv0LExsT32cugt2jNMAvIJr1FREOcRF+isOb5woDraFjLgsE
         p8+Q3o3fVFrK4UmxGX8PlLTfPW25FcWcgGJddAu4+oRNEHDbE4yG7XE7aQqvQFSSfIC+
         5vyDXQNUfOcTmrsqAszvJa2S9ILfnqdjsm0roRUOfgFc9yksUgMt6lHJcPJG/UB5fYcI
         ChrAYQRjHSh1CGjkH93UbCuf6fs/rRyQb4LugUwnhDaGrK+NUsKXyIS36TPfox4+Dsyn
         DYfA==
X-Forwarded-Encrypted: i=1; AJvYcCUMZ3X2ik82OI7aRXVtTzhzeHOI+LNy+Db1grztQQLo1R6TZOKAW5vsZr6GgzOJE/nBmnWG1Hlw6Zlb06b6@vger.kernel.org
X-Gm-Message-State: AOJu0YzdjSYuMDgEZE1BjxFrZCyS5p5CrGHfwe3V3fgdH6IGmheIqRtK
	kxdi6ysyhBlJM/Z4Wlp+FS18YnePyT88z+fbq1ieTlkO6k9fGD0lwfcnNkgN1jyc4n4GUKyi9HU
	dQ7DWz6oFErCMMQS6BSj60FpDjAlev/A0TmXuUDFpdF9PVK/nFPDkoar5ag8lYLS7NPw=
X-Gm-Gg: ASbGnctHa+/yWwZ0M45auXgqVp2Xl5M9DsAQRr37gJ4uNX11iWCnRAS1YMfbM/ichyd
	wTeBKVcUeNmxgcWjBmSRxsHwfPvnsnGCDbC1/8Q7hfMlrMP1tQLVP1r2YxY6b7Ch4GU31bpcPt0
	ZPC8XhQZG3OOkl1FnZCPmpEBap9LVtBHGBLiuCrvhvnxuH30NVp6T38dGsB0dSbPdbZD4Ao8asz
	mnSxVM/bhAP96tnjKrSbhoLOSZBnE9Z23cZZr6uAgC9+KeeESiNl/ZV95zR2cbYZ9gWsohXaJbE
	C0xoSTiE/75kjBPi53lXR0W8G6I35mD4WegP9Hrrx+qy6wFcRiadDEzVZPvsOGw4Az/ZZV3BZfx
	ZM/F3bTkuJuGGN4GLxj0CwUE=
X-Received: by 2002:a5d:6f14:0:b0:3a4:f661:c3e0 with SMTP id ffacd0b85a97d-3b60e510baamr4180672f8f.45.1752753154934;
        Thu, 17 Jul 2025 04:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAqQmPlaR0MqxERo3NRLrhaU4oEs8iGAGrgiheQNLTojFB3jUgPbGxNACr3plB8i5Bf9h92A==
X-Received: by 2002:a5d:6f14:0:b0:3a4:f661:c3e0 with SMTP id ffacd0b85a97d-3b60e510baamr4180643f8f.45.1752753154425;
        Thu, 17 Jul 2025 04:52:34 -0700 (PDT)
Received: from localhost (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8bd18ffsm20281626f8f.9.2025.07.17.04.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:52:33 -0700 (PDT)
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
Subject: [PATCH v2 8/9] mm: introduce and use vm_normal_page_pud()
Date: Thu, 17 Jul 2025 13:52:11 +0200
Message-ID: <20250717115212.1825089-9-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717115212.1825089-1-david@redhat.com>
References: <20250717115212.1825089-1-david@redhat.com>
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

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 27 +++++++++++++++++++++++++++
 mm/pagewalk.c      | 20 ++++++++++----------
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index abc47f1f307fb..0eb991262fbbf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2349,6 +2349,8 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 				  unsigned long addr, pmd_t pmd);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 				pmd_t pmd);
+struct page *vm_normal_page_pud(struct vm_area_struct *vma, unsigned long addr,
+		pud_t pud);
 
 void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		  unsigned long size);
diff --git a/mm/memory.c b/mm/memory.c
index c43ae5e4d7644..00a0d7ae3ba4a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -796,6 +796,33 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
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


