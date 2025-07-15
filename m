Return-Path: <linux-fsdevel+bounces-54963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA37EB05BF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A4D165F58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970D42E499F;
	Tue, 15 Jul 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7nSWJ3N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42A2E3B18
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585845; cv=none; b=M5CoeP9mLCCeCJwqSnWJXEcPHEZ/u+9oLXUQXebHdnWmiKtnP8EActjwGycZihL7upqd0aydQsliRI1hHDu9dMRBrkdVz1w5Jh7wE4/4DTfk7KG5O86OqpiRvr9HF8sPKTlVCvTUaQdhnnLiaRs8/claMJJxhi4MZLAx3+1g5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585845; c=relaxed/simple;
	bh=2xbQ3r+7QPHP9nmWWSES1W7hjLDjnCzsHuStzPREuqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6xyLXX26LGvm1HMHq6jZG0aeYi+yhmSnvQRZOBBnDTAHmwJDzSfCVvCbg1tm2cCF1fhY/BAncl64QJM9+LsKZOLC08xOCwX4CnywUQDxQzaBjySZCKJtrNmEG8k9Lktn/lF0uqjeAxw5dviRk2/TKPF2+xEEEMsqxC0i/Be7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7nSWJ3N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0W1gu/DbwB3HO+Ik7b3ciKtc0XnhekWlhthG95RGc8=;
	b=g7nSWJ3NFKOe8Xdu6cctJ140V8U+CYfzIzBQxHpZICLFTboXUe9UJrDeyyr4bKXqpvlFtW
	4R8Jn9BV1CPBFQ2B6qI930ejjvCtNSRBAZvioJuYQKAJ5fNxPeYSCmtGtCgPWID6D/aNvy
	vMFakjUnGbXsWVamGC0Udoq5nr9ndIE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-0fp9QeBoOyy0P3pY2NP53A-1; Tue, 15 Jul 2025 09:24:01 -0400
X-MC-Unique: 0fp9QeBoOyy0P3pY2NP53A-1
X-Mimecast-MFC-AGG-ID: 0fp9QeBoOyy0P3pY2NP53A_1752585840
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561bc2f477so13651275e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 06:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585840; x=1753190640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0W1gu/DbwB3HO+Ik7b3ciKtc0XnhekWlhthG95RGc8=;
        b=JxB/WoONq9r1zldxjqzLT2/YxCxh49TIFgjZrfbopJa3ZGGuIc2j83Jnna85/Nbs6W
         vAkUoyIEaPs8q27b/GTs7bSr21bBrei76ewxllsVA2HjAfMPfCuJvHGg3WF26pehLXsH
         0RXaw7hvEOo0jFiGeLIQYwmOycVDA24YBF+ObrHdyxrGoKFBhTe+27ZDcc7aPz4hMZmC
         +uJtx6kYJKXX2UZrO1YkZlCETYd5x6YCFxhMDHHFqwoPTWbqTiJoLdQmwOixFU8WtSVl
         Z7+EiK8+g8xvSv4QtAsx5jOI7+jV7xfsPwzbjpjAizCtWxqtzdkm/JKb+8FEM4SsE/TC
         XA0g==
X-Forwarded-Encrypted: i=1; AJvYcCXVKdXFF9YsSrXNiAdurxS/RLu7KMlexx23gVQITSBkhNOWLk8vdJb8JMjCm/1dc+mvhePumw0EJGtJ8cof@vger.kernel.org
X-Gm-Message-State: AOJu0YyCcdkAGPL7nKjJH1IWRuEx+oomKEbnsbdoqo/K0dY+yBcCCfkA
	zi0Fi0IdSuSnzOi7srIXn4o6gFZ+RJ2ALSbN4zAP5yeC9rZHVRtHvNdamKiaXuu05ahhvxRExU+
	fEuzLVVVvBrw04KW4NB/TEPbIM0/NW8XhF7TWl66TWVxEaQl/ZkD1PlN6qbKgXY18ar8=
X-Gm-Gg: ASbGnctmOeJSVVYVFah3MTbXDlV86qmEUmg+qUIy3iV74Ta5v6OStFN3MY12AsNHw2E
	WHo4mLvA0pvUgnQzZiB7WcotYQSn1d7B2mmvBvNW5d5k5easJ6Qpf8a42K8zQSkvOXpVCojcjsK
	D9ASmojImtURKhK6SnLZfebA0t28SRXbNPCm9X2FK/+qlYwREa5Q4rC2vw2qJsGBYXtdKK+Ursd
	dcjSZHWVGWfW4FOwTxALKjk0jw9doGA9981Gy96M+fyLjHw7/DF6iRN7us10/Fgfxz31IJeCJD0
	99HTMgHcnxIQV1gTqQHYAA4vUyhzWeoqml5EhQWa1HYhnhX/vxqA1U5XHDktCiCIjYyWi8mU8jm
	O71QBEsaoKACLg4ySR+jG7QsB
X-Received: by 2002:a05:600c:5387:b0:456:76c:84f2 with SMTP id 5b1f17b1804b1-456076c88c8mr137334425e9.30.1752585839947;
        Tue, 15 Jul 2025 06:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYbWegCM0S6a5gfkNemwi6OlAVodA9645Tyw+PVXIOkDyOGbitNWxrBtqQg62ekGoPNGMvNw==
X-Received: by 2002:a05:600c:5387:b0:456:76c:84f2 with SMTP id 5b1f17b1804b1-456076c88c8mr137333805e9.30.1752585839359;
        Tue, 15 Jul 2025 06:23:59 -0700 (PDT)
Received: from localhost (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45617f18d99sm69437455e9.8.2025.07.15.06.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:23:58 -0700 (PDT)
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
Subject: [PATCH v1 3/9] mm/huge_memory: support huge zero folio in vmf_insert_folio_pmd()
Date: Tue, 15 Jul 2025 15:23:44 +0200
Message-ID: <20250715132350.2448901-4-david@redhat.com>
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
index 1c4a42413042a..9ec7f48efde09 100644
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


