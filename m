Return-Path: <linux-fsdevel+bounces-51931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93384ADD2D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA15A1885126
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005F72EF29B;
	Tue, 17 Jun 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTSEQItz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39EB2ECD33
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175062; cv=none; b=t3WE7teo/Fx9wWICnzsPisHJo/P/w1giNOldkukjDOLrvZwRfpWBZjw3js7hzck3J4yOCAwul0s4WxY44jqUkx9MxiimBj+aLZP6n3wFFUZPco3ZsHIgz7cQxNJObSbPpUTdUfVQvWP+uboAPP/T5X2htzspbStF0+Hrh/SnOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175062; c=relaxed/simple;
	bh=BsU24r5xgG+FQtB1entGNmMfL4hNbq4o2pzMYPuggy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceJPxgzCP5D4Y++Fb6yzS7fya7nJEYc34fL7Os4oeYpEGn22gP7onvOjZA9VSJLnEb2YoYo9e5gxvBypAf0q1wnX2QpdrAG2SJHnSJpJEAGzPVyQdFQkYJk0vFs5p9SmAh4QtJYdqKE1R+TyuHDZF+r96UijGhYQFwOTiQbj98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTSEQItz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lq97cexcfDQMKZRu4/MkS8aw3BkFIIdya9sxYwoOveM=;
	b=OTSEQItzzDCSl64BFu5ztl+f4vfOA8uC88Az/c01utid7+4pP10fAvtt3L8PrjhggdjXZy
	B55CqBxPE2uvRUCoQcQYDs3g1N051aqsBBCHRL3DyHaE3CnxKNC3wnCSmyGJuxRvwycGae
	m13e2e0sBhUtm7p+keZZkRA/5GeQUhE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-2Lh8QqkFPz-Mpk5utMf4UA-1; Tue, 17 Jun 2025 11:44:18 -0400
X-MC-Unique: 2Lh8QqkFPz-Mpk5utMf4UA-1
X-Mimecast-MFC-AGG-ID: 2Lh8QqkFPz-Mpk5utMf4UA_1750175057
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4535011d48eso12454315e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175057; x=1750779857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lq97cexcfDQMKZRu4/MkS8aw3BkFIIdya9sxYwoOveM=;
        b=huB5X1pjtq4AI3etG90h4hzM6fY4ta4lo2AWKQxHJ9jD8sEoEU6Xcvmw1D57SwwVc2
         MuUwLCZJV7tuDVJFKgHhzcVjR9JgapOg4gFr5yj/3ttiNQPw28ODBDXUW8Hm0z2ru2z4
         g0ubGnT9WY1PjlERznPCW2TfeRWslbrqgviVnkbVUKJm4F34MBdku7n5Aa043lD5gZRL
         ePOVLMyBSLpCcyGn9FAW4pnN5Ii4Lbs1udOgOmeu9sBkvpDGnK+ZseTKJzhSg7TmOaZp
         mzpoR3bi3bjWkN6yEMAWBD4JJ2T+ZdoD5r15s5BCbidsI4WKvToV0aYB3e+k8XQrWWyW
         GpxA==
X-Gm-Message-State: AOJu0Yw5gtdDn1fLRxoTfm+ro0ORI5fRK8PK6NipOfU9splUCOh6Ux+W
	QlSxMU7rd3zQ3zngJuHCDcxaFZWhRpLGPAaHZVdxTwt2KU7uQI9uPCCB7WXlzcOuF1Ma8rVgoBd
	dAoxn7kDEGxqjF0QO4L//V52N9q24kTCfmlB2OHEsRmGMs603mtgRI5sXObLfhRKZHxk=
X-Gm-Gg: ASbGncsXblZJxbSv4ZktOLE47O0CukBVbN2mY4q8o9IVtXSgbyCXx5n68DUNNahCcxQ
	Ofjb0u4aCj8p/BAIn+NNHhhH20FAN94Fo0Lc84TrrcYTfKEoUa9AeJY4dyno0ZolmilKMbTsLWI
	82gvOZA/SluGKUWZlFmGievaSZeHNcW1KhX0j5ldqBOawRvTSyMpcSIyZawtSetMJB5YOedtLRk
	fWDKBefu/IdUN7F94/9028srOAaeBE4R0wvC25ARCPHPiEE9wbxM+J+GuLc24fuuz8zkbT21fV9
	Hb8Pf24Rpa9rXmZbrZWvchiMBBkUzmzmmyPhLjXSom3UbK2Z6HpzW0Xm7+ekkxDSXq6+JtxOrhg
	pSDHzcw==
X-Received: by 2002:a05:600c:1e02:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-4533c9dbbfemr142093095e9.0.1750175057514;
        Tue, 17 Jun 2025 08:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmLbqQvk/KforjobulOMd7Z8HmizRkZJwsjious12VlfKySMsgRFEBQ04fbeKOdJYcWkDwbQ==
X-Received: by 2002:a05:600c:1e02:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-4533c9dbbfemr142092735e9.0.1750175057156;
        Tue, 17 Jun 2025 08:44:17 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4533fc6578csm110483905e9.19.2025.06.17.08.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:44:16 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH RFC 13/14] mm: introduce and use vm_normal_page_pud()
Date: Tue, 17 Jun 2025 17:43:44 +0200
Message-ID: <20250617154345.2494405-14-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617154345.2494405-1-david@redhat.com>
References: <20250617154345.2494405-1-david@redhat.com>
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
 include/linux/mm.h |  1 +
 mm/memory.c        | 11 +++++++++++
 mm/pagewalk.c      | 20 ++++++++++----------
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef709457c7076..022e8ef2c78ef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2361,6 +2361,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma, pmd_t pmd);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, pmd_t pmd);
+struct page *vm_normal_page_pud(struct vm_area_struct *vma, pud_t pud);
 
 void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		  unsigned long size);
diff --git a/mm/memory.c b/mm/memory.c
index 34f961024e8e6..6c65f51248250 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -683,6 +683,17 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma, pmd_t pmd)
 		return page_folio(page);
 	return NULL;
 }
+
+struct page *vm_normal_page_pud(struct vm_area_struct *vma, pud_t pud)
+{
+	unsigned long pfn = pud_pfn(pud);
+
+	if (unlikely(pud_special(pud))) {
+		VM_WARN_ON_ONCE(!(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)));
+		return NULL;
+	}
+	return vm_normal_page_pfn(vma, pfn);
+}
 #endif
 
 /**
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 0edb7240d090c..8bd95cf326872 100644
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
+			page = vm_normal_page_pud(vma, pud);
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
2.49.0


