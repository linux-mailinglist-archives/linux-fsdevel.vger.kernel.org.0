Return-Path: <linux-fsdevel+bounces-55249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55021B08C11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073651C2407C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9A52BCF67;
	Thu, 17 Jul 2025 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzboA5qx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9829E0F1
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753147; cv=none; b=Pr/mVM1YeV+H27k9G4Kypbses75j6kszlZlAVx6bP4p34qU9zhLFtokWMSzEIR/5v0EKsSjaVanqaHrFyuFVrDHJX6pB+rF/reZ7Aag+sXFG45t1x7238TmTqtEwoIEemU7xUZyyAoh/Ixzfg0ByLLzgE1u4WqptI5UJOPJVNco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753147; c=relaxed/simple;
	bh=Dg+vKZ/RO8UXSK7n9DU1KLHAEhb+/0cG5UKKUXsdZOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=midCrxbkB2zBzpd1CSsvkQjesOsGqCJprVJs3A/LmY0rfFR8t/rG7/xqgbiBaxf6QJ1qHAdvTQU99zbu0I0b2fMgOv7dSNg4MxjLzJtPMtueO+sE7xnP/buz5ZopQAYrCkgWLlMf6liUSVx7WFgKM1hcSog7Qgw4bGRbnYwKgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IzboA5qx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752753145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAAYYXy+5qwpASBfNrlxr8guN8G2i706wjpGFlltV74=;
	b=IzboA5qxd+l3GUkwI6r9FA5oalx5gYoJ5qzOY2eJVNWiS//3Ud5cRBITPGy0B3IA4YPcBI
	o1GiFOlzawl/d3S0IYzFz/cZ/B8r5M2e1rryzOhrB0sOGz1YGD9SBqM2dhrw2hwd8+v9T7
	i/JD+8uCVNrSYw0S/JLELitpfNLYzOM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-nyIMG502MruXLSAr-RTrJg-1; Thu, 17 Jul 2025 07:52:24 -0400
X-MC-Unique: nyIMG502MruXLSAr-RTrJg-1
X-Mimecast-MFC-AGG-ID: nyIMG502MruXLSAr-RTrJg_1752753143
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-453817323afso5070005e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 04:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753143; x=1753357943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAAYYXy+5qwpASBfNrlxr8guN8G2i706wjpGFlltV74=;
        b=aycUpdtSqQKAEGhEVk6+SJ2ZBhiK+l7suAioe3vwrTiqiog6p5dWpWAsBZAHvjf403
         o0O/8mzIOxEcx2gk1cZm464w1zacLssrmnbws3wRHwHxueD7ZRXzc72Qzoh/dglR8RzR
         jfihk55kPnueqJ7MbV+H/TUL6ssSf3a8cz+3BmWbEPQhsn+L/bl7fOuTixfSFMFWvkkS
         H4X2Qqp84NeEhMPyf7wTGVT0mFNJkquh9vKqnS/F48RsJH0IOaov4QynDHeURBg1cHCW
         m/qilO6BvHf0ULYxmF+DkfiZlnRmgj1Aec+Yx2xD9XGeqQNIx8yaEwly05icjd93HWCM
         tJVg==
X-Forwarded-Encrypted: i=1; AJvYcCW9jDCgd/4LWE18MFnXv2rkl7uI6jjiPerNDE4Qg3a9LeE2F9OY7RuXZ1fuifcrWOXtjkH53y2k7q97WbNx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8z4PIcfqMXMbfOsdm94xPZBf76WiZapwdUvBIuxQdL7JYrOzK
	nO3M7YLUNYq6jWv8+EAxoA7FyZ9K93C6l1wTeGq5UJZheIwwWZbEvgg/wOzfR7WV2vXeyCgdS8E
	Tbqwj7h5gBevOKe7HFyYy910jm13ClwiQguTA0JOdP9x4sM91a8kGBUGL+GPd+8q+NPs=
X-Gm-Gg: ASbGncuO27h6hZ5kBxorkg2jQvhT0CEzgxEdRva798bNnLfRteE67uXZFZ8DezXbwFi
	sfcJ5beVo0Do5j+VfwcEdRa3NwpzWDGV4i3LbtrEEl6A7YORBdgQoU5f80+qkwdMu4v+/kFL6Ok
	6s69PQmfZkCD74/2w8AlnWQhAqo/D6+PS+eajMEzBrxtVo4/2ApD+BxosiQMsorzGogHWtyvAAf
	O9Q/MOMnXN3JIEBArQab94TEWNximcc58a52xPnHtnAmHjxv0PoPWeuvkClHDof2xlXsjgHq1Gm
	qpXf9aYLeFNDhSkY5IeJTst00dQ3vRTz693uFJRzzHAp4WYheNqChm5GTVsN/qvm5DBxmLsm+9L
	DZsxjukP/6jAfY+WMQg9sCiQ=
X-Received: by 2002:a05:6000:23c8:b0:3a6:d95c:5e8 with SMTP id ffacd0b85a97d-3b60dd7aac2mr3879063f8f.35.1752753142616;
        Thu, 17 Jul 2025 04:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLqq0HSziphIF4gY7jkSa/7zMDAewp7/5b6DkIKpjYL1yIcxKWQwPQ10nRUjdRU/WgBdtqyw==
X-Received: by 2002:a05:6000:23c8:b0:3a6:d95c:5e8 with SMTP id ffacd0b85a97d-3b60dd7aac2mr3879028f8f.35.1752753142142;
        Thu, 17 Jul 2025 04:52:22 -0700 (PDT)
Received: from localhost (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45634f4c546sm20298345e9.7.2025.07.17.04.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:52:21 -0700 (PDT)
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
Subject: [PATCH v2 3/9] mm/huge_memory: support huge zero folio in vmf_insert_folio_pmd()
Date: Thu, 17 Jul 2025 13:52:06 +0200
Message-ID: <20250717115212.1825089-4-david@redhat.com>
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

Just like we do for vmf_insert_page_mkwrite() -> ... ->
insert_page_into_pte_locked() with the shared zeropage, support the
huge zero folio in vmf_insert_folio_pmd().

When (un)mapping the huge zero folio in page tables, we neither
adjust the refcount nor the mapcount, just like for the shared zeropage.

For now, the huge zero folio is not marked as special yet, although
vm_normal_page_pmd() really wants to treat it as special. We'll change
that next.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 849feacaf8064..db08c37b87077 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1429,9 +1429,11 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (fop.is_folio) {
 		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
 
-		folio_get(fop.folio);
-		folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
-		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
+		if (!is_huge_zero_folio(fop.folio)) {
+			folio_get(fop.folio);
+			folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
+			add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
+		}
 	} else {
 		entry = pmd_mkhuge(pfn_pmd(fop.pfn, prot));
 		entry = pmd_mkspecial(entry);
-- 
2.50.1


