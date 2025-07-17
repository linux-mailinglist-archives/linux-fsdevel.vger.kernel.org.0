Return-Path: <linux-fsdevel+bounces-55246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 240BFB08BFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E7D1C23490
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B08E29B783;
	Thu, 17 Jul 2025 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAhSPGis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811029ACF1
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753140; cv=none; b=Q8SNMLZM4Ik1R715Atw40exqQuvVK4QVPIvq1xXdrv+dtRF3/CzR/Ef91JcOdGgsxMpx83EoiqphqI3XWbXPovApXf1mrouiApdoSsZ2XV0t3uo99p9YOuYLfhwPmOaJ7QXv4G2KrMrciG6aoC5QeQlIwI3N31uZhcQ/uMIjhh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753140; c=relaxed/simple;
	bh=dtRUOAXiN1/I2SpevfA/V6KnAReUthh4YQsh0CcAkEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hownSkLxz9bzC/ySl4VBdDDu+GZt1iEumdl1a/JeYk9h5KcW9hXcLoLD+Smtj8+3MPw0/KM5YFJsxqS2bHSwDlqNzUvLdsu+mJkiiro/pY1RB4Sr0Xf0jSCthwNw1tNOZxWHpdK2aRUzjESjO1MTLBwWnejeZmiA8EvYxYtGDZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAhSPGis; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752753137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8sA1/7fJchUOMEyFR6/9XGM4JcADGMS+VMGQR+LVY98=;
	b=CAhSPGisS/2ix225W1Rq/VmKwc1tfcgpDikkwgdUBWpnDxi2NuRMWkYbvNfUkcP/bomCVI
	G9tPDsxPub7q/5Q95fP0wIVccSEdBiAQpZPoG4BlRuGKaxbb2z8reKr+F+lFx0HROSWlkx
	FrnwHL7SJA2bMeJjnq6oaePrXlIg+2I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-PyM1R3arNhKg2hNtFNKQ2w-1; Thu, 17 Jul 2025 07:52:16 -0400
X-MC-Unique: PyM1R3arNhKg2hNtFNKQ2w-1
X-Mimecast-MFC-AGG-ID: PyM1R3arNhKg2hNtFNKQ2w_1752753135
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-456175dba68so6401135e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 04:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753135; x=1753357935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sA1/7fJchUOMEyFR6/9XGM4JcADGMS+VMGQR+LVY98=;
        b=wysqNXWImBg8jSixOQZyRob5ust5ULpLIF4qh86kTD30x2iyeXqctSUTTULBfD3xWW
         58kX4Fay7CnKDS6bQsK897grQJfpStyp2NcY64F4NQ85pu+lNRriA6Q6bu22AQSbmmI3
         vdDv1LyPM++SCqzAeuhSKgi7icmRLZrggrfcsZFHWeWybLVj2cckslT6KQvn+wX0lLXK
         1HVKptwyxwWg3tWqrzDHO/dO2zCiErq3W0tY38DWWzIcYdCLSzJBHEb5r1qiz7nLKU87
         E9QUCROJhyOdcU/w8WuQBy/9jS5gheb50jfFgj7rfdfuJXpbI1tUcOsaf1qUVdYMfW8Z
         BwSg==
X-Forwarded-Encrypted: i=1; AJvYcCVoCcNbHv5RJqW/cYry+RH6PNF56O/OFgK0j9537BHKtEca7ihAkUecmDmV/tEGy+jWLJBqPaU4WDGnnjL3@vger.kernel.org
X-Gm-Message-State: AOJu0YzHzbe1lKKHxasZtIwhTfebAf9XXDbf6MG/dFwP9hHOJ2+Vbice
	3kQ33GHEiXg6MCBox/ELrNkwiTwW3WZqpDuaZERtXPG6RPfAKc/pclArM9FtOBAF0ShZBvBNVax
	BIcv7qht+rSP8YEGeNxkJ90LLvNvN+/8/gvPXoN9VJZUrq/UtAcsMkfWtYdk8myBGOKU=
X-Gm-Gg: ASbGnctP3YiSahqRFPr2ozcpD2kPnCzcowrjfV5565JzhS2G5ukhajZKhEdSMRYDz3F
	VCbfb43X7sJ6EKwC7sJrqmKdN/3myKZUqUN5Sp+uyRH26px5mpRmVJNkrH2Mze1p6F3FNrOSp6e
	5FttROGFNGaI7u+omVGBIoqHkavw0ayj55TZ0OctCughsHzOFV2rpn5LZ2rXWWHVebDrzfRjwgo
	B062uPMNxYASXhn63vuwMGbKvDxrheCv6Bkt5kP5Yjl6WEOwBsXuuadCVU3LBrzwVoud0Khi3EC
	oLgnhgYhrQqxEcavVQdlftgwE4q72HNOKUZFwf7+XvSSkpHPOKkzAlSU3WWnWgNKTIsvZd29kaP
	Y8ob8EeGsDEy1y8rMqa7cEBk=
X-Received: by 2002:a05:600c:3b15:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-4562e36c7b1mr56529545e9.20.1752753135431;
        Thu, 17 Jul 2025 04:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/rOiDh/w9bPyIOHiP0sGPa++157liovsPLJqB62Hs3kS1lvQT8E6z4/Thjm3n+RdALYGJuQ==
X-Received: by 2002:a05:600c:3b15:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-4562e36c7b1mr56529205e9.20.1752753134877;
        Thu, 17 Jul 2025 04:52:14 -0700 (PDT)
Received: from localhost (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45634f85fd1sm20282385e9.25.2025.07.17.04.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:52:14 -0700 (PDT)
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
Subject: [PATCH v2 0/9] mm: vm_normal_page*() improvements
Date: Thu, 17 Jul 2025 13:52:03 +0200
Message-ID: <20250717115212.1825089-1-david@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on mm/mm-new from today that contains [2].

Cleanup and unify vm_normal_page_*() handling, also marking the
huge zerofolio as special in the PMD. Add+use vm_normal_page_pud() and
cleanup that XEN vm_ops->find_special_page thingy.

There are plans of using vm_normal_page_*() more widely soon.

Briefly tested on UML (making sure vm_normal_page() still works as expected
without pte_special() support) and on x86-64 with a bunch of tests.
Cross-compiled for a variety of weird archs.

[1] https://lkml.kernel.org/r/20250617154345.2494405-1-david@redhat.com
[2] https://lkml.kernel.org/r/cover.1752499009.git.luizcap@redhat.com

v1 -> v2:
* "mm/memory: convert print_bad_pte() to print_bad_page_map()"
 -> Don't use pgdp_get(), because it's broken on some arm configs
 -> Extend patch description
 -> Don't use pmd_val(pmdp_get()), because that doesn't work on some
    m68k configs
* Added RBs

RFC -> v1:
* Dropped the highest_memmap_pfn removal stuff and instead added
  "mm/memory: convert print_bad_pte() to print_bad_page_map()"
* Dropped "mm: compare pfns only if the entry is present when inserting
  pfns/pages" for now, will probably clean that up separately.
* Dropped "mm: remove "horrible special case to handle copy-on-write
  behaviour"", and "mm: drop addr parameter from vm_normal_*_pmd()" will
  require more thought
* "mm/huge_memory: support huge zero folio in vmf_insert_folio_pmd()"
 -> Extend patch description.
* "fs/dax: use vmf_insert_folio_pmd() to insert the huge zero folio"
 -> Extend patch description.
* "mm/huge_memory: mark PMD mappings of the huge zero folio special"
 -> Remove comment from vm_normal_page_pmd().
* "mm/memory: factor out common code from vm_normal_page_*()"
 -> Adjust to print_bad_page_map()/highest_memmap_pfn changes.
 -> Add proper kernel doc to all involved functions
* "mm: introduce and use vm_normal_page_pud()"
 -> Adjust to print_bad_page_map() changes.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Lance Yang <lance.yang@linux.dev>

David Hildenbrand (9):
  mm/huge_memory: move more common code into insert_pmd()
  mm/huge_memory: move more common code into insert_pud()
  mm/huge_memory: support huge zero folio in vmf_insert_folio_pmd()
  fs/dax: use vmf_insert_folio_pmd() to insert the huge zero folio
  mm/huge_memory: mark PMD mappings of the huge zero folio special
  mm/memory: convert print_bad_pte() to print_bad_page_map()
  mm/memory: factor out common code from vm_normal_page_*()
  mm: introduce and use vm_normal_page_pud()
  mm: rename vm_ops->find_special_page() to vm_ops->find_normal_page()

 drivers/xen/Kconfig              |   1 +
 drivers/xen/gntdev.c             |   5 +-
 fs/dax.c                         |  47 +----
 include/linux/mm.h               |  20 +-
 mm/Kconfig                       |   2 +
 mm/huge_memory.c                 | 119 ++++-------
 mm/memory.c                      | 346 ++++++++++++++++++++++---------
 mm/pagewalk.c                    |  20 +-
 tools/testing/vma/vma_internal.h |  18 +-
 9 files changed, 343 insertions(+), 235 deletions(-)


base-commit: 760b462b3921c5dc8bfa151d2d27a944e4e96081
-- 
2.50.1


