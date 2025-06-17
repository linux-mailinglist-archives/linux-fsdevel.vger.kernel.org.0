Return-Path: <linux-fsdevel+bounces-51927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AF6ADD2D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB803AA15B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F5E2F5467;
	Tue, 17 Jun 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGE3D4BI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC32DFF21
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175055; cv=none; b=QrY0Fc1dpwhQaUjpt4tXW1oVe1szvTMx+jfWtTTNTon1I4UN3qX+B26IT5zcvHYvahiCFdxoeW0el7GU+0kL2er4FCTDhWoIukZgqvf/YoZHdnmRoq351Q8RJzAuMi7yUXXfOTouHbbYIcFA7c084Sx0nAmHAq/pdEIkrhs6rkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175055; c=relaxed/simple;
	bh=8LbU7WHsSEUDC9XyX0d6DQNa5JIUja8IK4JgIC3/fqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODwXZWAZwfREDgykjnVrV2oJI9cb4AbQHITqwCLJ4iVQbwPPPWE4WjCQa2TY8BcyySXykoIh1SIQa7nadn/jn2+H5SxiYRl/5M2umhpy4A//5k0GZyYhrabI8opXa7UmSOgax34DySv/cMMlC/rqNUPiffUYQH3ZbRU3hgqVPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGE3D4BI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPSX3LBtUNEGTHSkguHJQ+rqsVYvGpTDP2rR8uKdQH8=;
	b=jGE3D4BI+INmxoiJKNsvYCrf96B+z99h5WvCbiG+GEEYEaC8QNQv+IqVBxbiNTL1DPI5kF
	FKAPylBg6aJeLj65jBxjKr4KWdnzxKxpY4q13H35nTsPSjPKy5e0cdMggqANingq/lO3uA
	LtXgRlzMEUxd37ejvwfNJ+xg2wXeAr8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-JJ85UwpIPZaXEZLL8przfQ-1; Tue, 17 Jun 2025 11:44:10 -0400
X-MC-Unique: JJ85UwpIPZaXEZLL8przfQ-1
X-Mimecast-MFC-AGG-ID: JJ85UwpIPZaXEZLL8przfQ_1750175049
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4532ff43376so45622845e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175049; x=1750779849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPSX3LBtUNEGTHSkguHJQ+rqsVYvGpTDP2rR8uKdQH8=;
        b=oJNVafDe52ofBhribeq38BREehOG0F04fkaiCBs65OiTlIaJ7TULKHkAILfQ10B/ut
         inHj7b9BkeVbcEhZv3VVuTC0CxOL2N2/E0oB3JwscneO4VKNaioTI8zBQqx7ECyCz20F
         dTBJryWL3bQPlQ2OQysY4kwvw111uLogcEJ27Akl7n7/wEPmmzLImzilQVgJYak7Aqpb
         vIyLaA3C6dfiiO6+nLKkxjGv0IPBd8kZ9+7uFP0LtJzCBTESymW8KPwJZmVFG/81rPOD
         Dc5FkOjYrZ/Ec2R1tVcEWvEPt11cpHnhWk85l8JygQrlHqbYgTwwRQqXPfEhgc08L7xO
         A2rA==
X-Gm-Message-State: AOJu0YzLIbJ6jHrP45YYmeEjRkh/ItFurVB+z+q0icEvaptrs6S/772S
	zOgy5B8hRDq/GLcnWVH03hl268qqB6sFcD0smo3b61IEuuqXtVCXcYkNwV/dNyblWXVDJLFU6/i
	tjzYoEJY7kELgu6UL7Z3kMdXA19ZNb9Te/ZT/9Vb9OYIFm3tGRTN6dKc0rHz1iD/niNs=
X-Gm-Gg: ASbGncvOBJV5pcNcRqWcxH0wEKVYopfOawxwv8C8nH/8LwUZcH2G+g1yKaAcmTW/u1s
	3o7LuHQK0jHKyLFfzWhYvoOlrRHG9e+6ljgHb4qcFdMksNF0Z+bkwTeYXiM5y5YwW/8TdxlrVRu
	VUlq3n6WuQARnS0qELW5eT87a+K6t3PoMelLZPoyztMe+DgzIFfUxAXi9cUxhsIothBPc+Q7I/G
	BKP6SyFpgExPsdA4Ddq5tpQRe9hRvxPmUvXQVrSucoNrEea4L0SQ8rYXnu3U3kDT1gBqAmKjnl3
	De7XBm+i9vyNGeypsbDVDyh7l9+AJ/JNriT1v6PTyQk9VKqUQMmoCUxD+eRMihRzbueSHTTJ0CI
	nKE/eEg==
X-Received: by 2002:a5d:64c5:0:b0:3a5:2670:e220 with SMTP id ffacd0b85a97d-3a572e6b9ffmr8898797f8f.32.1750175049010;
        Tue, 17 Jun 2025 08:44:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM5m+wJRDUa8DrC/K/257QBXTR6G19KsTYyK8OpbCkrMRqwW7zfUBGXG+Jg5gfXSGV5z4C0A==
X-Received: by 2002:a5d:64c5:0:b0:3a5:2670:e220 with SMTP id ffacd0b85a97d-3a572e6b9ffmr8898776f8f.32.1750175048645;
        Tue, 17 Jun 2025 08:44:08 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b1eb9bsm14491105f8f.69.2025.06.17.08.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:44:08 -0700 (PDT)
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
Subject: [PATCH RFC 09/14] mm/memory: introduce is_huge_zero_pfn() and use it in vm_normal_page_pmd()
Date: Tue, 17 Jun 2025 17:43:40 +0200
Message-ID: <20250617154345.2494405-10-david@redhat.com>
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

Let's avoid working with the PMD when not required. If
vm_normal_page_pmd() would be called on something that is not a present
pmd, it would already be a bug (pfn possibly garbage).

While at it, let's support passing in any pfn covered by the huge zero
folio by masking off PFN bits -- which should be rather cheap.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/huge_mm.h | 12 +++++++++++-
 mm/memory.c             |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 35e34e6a98a27..b260f9a1fd3f2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -483,9 +483,14 @@ static inline bool is_huge_zero_folio(const struct folio *folio)
 	return READ_ONCE(huge_zero_folio) == folio;
 }
 
+static inline bool is_huge_zero_pfn(unsigned long pfn)
+{
+	return READ_ONCE(huge_zero_pfn) == (pfn & ~(HPAGE_PMD_NR - 1));
+}
+
 static inline bool is_huge_zero_pmd(pmd_t pmd)
 {
-	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
+	return pmd_present(pmd) && is_huge_zero_pfn(pmd_pfn(pmd));
 }
 
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
@@ -633,6 +638,11 @@ static inline bool is_huge_zero_folio(const struct folio *folio)
 	return false;
 }
 
+static inline bool is_huge_zero_pfn(unsigned long pfn)
+{
+	return false;
+}
+
 static inline bool is_huge_zero_pmd(pmd_t pmd)
 {
 	return false;
diff --git a/mm/memory.c b/mm/memory.c
index ef277dab69e33..b6c069f4ad11f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -669,7 +669,7 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 		}
 	}
 
-	if (is_huge_zero_pmd(pmd))
+	if (is_huge_zero_pfn(pfn))
 		return NULL;
 
 	/*
-- 
2.49.0


