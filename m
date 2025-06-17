Return-Path: <linux-fsdevel+bounces-51924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4365CADD2BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F79B3BFA90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46BF2F5464;
	Tue, 17 Jun 2025 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbNqYsXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10592F3658
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175047; cv=none; b=CeQiF07aY1OBeAVJ6W0vuXIpxdwCN7iIyGSmpK87juav1zmpPnjii/QAo2IIbKD4nIhk7BEz6E/QRtHX/suq2B6uWgzjRB2fVYgns/GoEqqbECTtC8rmHQGuYyxae3h0qWnsiq/XgMzizUXTOmRfJif1RmpNHiNheD/7XfmVG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175047; c=relaxed/simple;
	bh=AaLRVPcfUejWvJOHKekM/3Bd9o1DBMGCz5AGg2IT7Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTURPuIb5iU9wkVLkTYl8Y9gwlovLKULpwHlnK5uQYN4BQbOUAmJq5Svr5qwV1pXaXQ7xy5EZBdKXEigiOL6b8uJY7FgTqeR11EEDexrGni0b73tGGYk+azY5WKGJVKhcFZxAMMs9KdfsWhcDKY75y2TF6ibcS70L+VjU3VJyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbNqYsXH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZKss+ViQ3XsGRfMnfUZIAkjKJYTTy4h8nMBjUoSR6g=;
	b=AbNqYsXHXEUZFc1e9R2eIQvB6NLD3MuD7Zmw/yZkZjV41Fjj3R7CZPRFwDbHk7PvEo1MlO
	39XtQmCOwZ8o4YaSDNk1VKbn6nhrQSNRtpaTG6IY6LWaud94zTTsSsG9eAJ4UmMpaVNJ3q
	SpGAcnCVXM3FvI0MPS6lp2bBEewVGwg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-dhurkkwZOCSMO9kOuXWJMA-1; Tue, 17 Jun 2025 11:44:03 -0400
X-MC-Unique: dhurkkwZOCSMO9kOuXWJMA-1
X-Mimecast-MFC-AGG-ID: dhurkkwZOCSMO9kOuXWJMA_1750175042
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450d6768d4dso38138645e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175042; x=1750779842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZKss+ViQ3XsGRfMnfUZIAkjKJYTTy4h8nMBjUoSR6g=;
        b=nNXI//I0C2DR2VVZuTNBSBc4pu+e/vgKpENY7TGCKmOnWZTf8WN+H6RT8XKgXJrU3s
         aamsm0aEJu37unloF5K5Fjreu2GKlSezt4FzDgbgPEt3F7Yl8vR+kAmr/tAabaHqqz08
         rG0J6b/MKFzK4xBkt5jXBIyO4pomjGKqDWpuoQZZw2AAIh0uTQbukNF44jUeGIp4JBDp
         4zKaW6hF327m6EAZ4+/8lhYv7/p6G2+c7hL+m/GvNkx0vyJKfdMXxid6gxnqmhkygcMs
         Idmda7DuR49Z+42KBDt9kk8rgDosrhrGrZ6JYkOeHLwRrr/Xrdbc/erH5vxzWVGSqmlz
         PbyQ==
X-Gm-Message-State: AOJu0YwQzT2bMjiU6v6/WOpW/T1Rz/po5wwchWkfFDoh4Akbfrb9lTQm
	V84ToDaBcspVWsQ3k6ag6AKifvX5foB2/S+ziW9ZAbw4a/XhamESSKtIuTH1coMf7ceAbqfL8fV
	7r0KLiDuxFFq1jzt6nSBNjNMuQA2mc/5J0JdcKjDqsS71Lukz4PZIhv8iwVa949+rRQY=
X-Gm-Gg: ASbGncsP3eqBZWSxpdHeOZcMi6IT9wYICTWDBCOuy6F276p7VBXsNmEIGevAiHvAR/6
	NNEgoEf3j+YGVrwkE9c0Yh/h8Hn3hRBPdhrXOYE4bVJfwyylzuaR+eDJBr/MlR/YZhxXNrpFs6C
	OvUu4hXiXoWjfOooxwdBcbDgiYAeTtgRAvaC39Ji5ISRe9Kyn6qjiCr6JUCeejLJUxH8MrroaVy
	iq17jiD2IbE1q9LfPJPQLF50p9cIDEIeiLtrMajTXoCV1heCNcvq9E05SRRgKsmCbR2muYPLGzR
	j2JDjqwKhMgJrdD0qjMrS4/waWNITKZpmULdihcz+aoZRPGZlxQsC7+IWTyNZYZDTOBy2o2vrS8
	8ni+yrw==
X-Received: by 2002:a05:6000:40ca:b0:3a4:eb80:762d with SMTP id ffacd0b85a97d-3a572e9e7bfmr10544472f8f.56.1750175042151;
        Tue, 17 Jun 2025 08:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEizYNw7dc5qMU4ZYxHKAQ+J5Vp2J4wukFj23PAnuBxSQs+o+0P3zEnBC8W1ti7paRppqlPmw==
X-Received: by 2002:a05:6000:40ca:b0:3a4:eb80:762d with SMTP id ffacd0b85a97d-3a572e9e7bfmr10544452f8f.56.1750175041775;
        Tue, 17 Jun 2025 08:44:01 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4532e25ec9fsm175719105e9.34.2025.06.17.08.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:44:01 -0700 (PDT)
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
Subject: [PATCH RFC 06/14] mm/huge_memory: support huge zero folio in vmf_insert_folio_pmd()
Date: Tue, 17 Jun 2025 17:43:37 +0200
Message-ID: <20250617154345.2494405-7-david@redhat.com>
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

Just like we do for vmf_insert_page_mkwrite() -> ... ->
insert_page_into_pte_locked(), support the huge zero folio.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1ea23900b5adb..92400f3baa9ff 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1418,9 +1418,11 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
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
2.49.0


