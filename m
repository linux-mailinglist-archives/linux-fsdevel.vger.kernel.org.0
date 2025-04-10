Return-Path: <linux-fsdevel+bounces-46181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C3BA83E39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 11:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CF0189DC4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2CB20CCC9;
	Thu, 10 Apr 2025 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlYb1Vd6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A5520AF9B
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276229; cv=none; b=L7CamUTr3eku0HG74oQo58gIFg9mVBvmGPE9OOtTNRmXlE3Ui+HyATYc6w4qlGMi9/8aH4qoQWPA1pjzZC2kvjZTsrU+wHYwDuKLRoQCk5gjgtwlEhtXaYaE6+Kk39bN7CLvZ3yBn39UPGk+ZYSId+4TWpbkLnaQC4Jr6T5VZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276229; c=relaxed/simple;
	bh=S4gD+3ui7K1tm6lBvIKO/M5DULRUHhtuzWDJL/fuqYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWJUCF4b+co0FNgQn0qElhXwTzzsAEApPPSlmZPyjRp3GymtVip0Z9ETbs7DlqmQMEySj5eGZECmU4A1Vo51/RjkFw3xJOcrY16LZvaqAYhh7AgHwsxwb6aJlhx1HJhnmCF8b0D0OMqunFSR18sT7arLASZzLAd+sWZM7UI7Rag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlYb1Vd6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744276226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=27eNNzuEQxbmkvmFUCfr+IytzedlUHGjPUYmckfSXUM=;
	b=WlYb1Vd66OuwxAfn+GCndWD0WkrQmfbuf/EfA/cuj8Enz3z6yQIGqrBQmpZS1Bc3SdJ3Dp
	lx0mDVqd52zIQY0CXaf41c0SUwYwyE5vN2QuwemAacMTzuSeqQfmmRE1fpxC4bm/w2fEuS
	KP4L8cSzL5zQUeD6MHQFGP5eTv6K7zo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-zKNY2H3uOte_zQI0ATVKPg-1; Thu, 10 Apr 2025 05:10:24 -0400
X-MC-Unique: zKNY2H3uOte_zQI0ATVKPg-1
X-Mimecast-MFC-AGG-ID: zKNY2H3uOte_zQI0ATVKPg_1744276223
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913f546dfdso283470f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 02:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744276223; x=1744881023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27eNNzuEQxbmkvmFUCfr+IytzedlUHGjPUYmckfSXUM=;
        b=Oye6ES8cYVzrKN0TkXMBWV0VTaLcSupzJgHi4Yy0r5893FVSyQEKqDRzuS2JMdhI1c
         qQNIkBWv8JRVdaLV/4JtUe5yxwvpVoqxssmhqFqLiRp7heoN9wMizty7hJEiC8jG20mm
         cLI4GxTTXoUANFAnBzoP461sxFQI1gvwztlpWY14ZwGyi2lM/+DtebT6BFKsz5vuAYlP
         pBT2mSYcTHgh1eQ81Td4xBEHp7uYq0PpRa/HCAGPshEsLdNIp8J1KkOA7dfiLIM96OZW
         Y8as6mRbFoQPgpo+DPZ+NtKaUFnuiR46wn7uksaOnMQMfaRH4mrxuQ4cORGm7s32Skiw
         6v+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnHpa1rGp8L2Dr8t6/e5yi9Eoh47vpXWhnaN34SQ3fxNc87nLopDZNNYE33vT7U3a8srEG5FOi1vu/Ydg6@vger.kernel.org
X-Gm-Message-State: AOJu0YwRXEZLwVc/B1RxfqrvcNu+D4m+U7PLqC73JS2V41AZrS7L9725
	4JIFVUI3mt7OvacCxlf1fDhSJDzblT04xnCgCipCp9QoS7VyA6K/1RbOAG9FrZcWVYhj9tlwUWr
	1Slu2+zfeGFTAZuG72dJjBxcyG7fP2v5aFpcN/qka547o69c+Rbgpw4DRCZWXzwc=
X-Gm-Gg: ASbGnct6pvqkLH1uMhALoNvafd68uCElH4YEn5XW6/tWc5JCwcs/qi8E27LZ5AzL3j6
	PEMYZRi96yfirBFJ4MsB+yV2ZmP6NSh9xeHGyDBNLvBMbUhVxfIRD/pmqwHR2FxwG8bHjzPXK9L
	W9fr8B9GC4HbXiLVafeWq+o2hPASzxnwPkmTtztVBz7PueBG/bcPXo+VJrDibjB4ahgNWohX/qg
	SdYS2PVx6uNp++te+/4Q6NqAezejzBKwcDswF9va4pt370juhzeHBNw3thAXmZZb1Q8UEFgew/F
	cKMVvMQzm5vXx30srnkUusLuD0tDUET00btTx5ZDUrhIl7f5CI2kstBOvujAV6xZSiltwt8C
X-Received: by 2002:a5d:59ad:0:b0:39c:13fa:3eb with SMTP id ffacd0b85a97d-39d8f4e43c0mr1524420f8f.39.1744276223381;
        Thu, 10 Apr 2025 02:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9o//1YdnfQaWfNqnIWzI/WV2dN54LX94NnfwgJ3jSA+I3+tbjCeuQrP5snslAD47XW4PEGg==
X-Received: by 2002:a5d:59ad:0:b0:39c:13fa:3eb with SMTP id ffacd0b85a97d-39d8f4e43c0mr1524393f8f.39.1744276222986;
        Thu, 10 Apr 2025 02:10:22 -0700 (PDT)
Received: from localhost (p200300cbc71a5900d1064706528a7cd5.dip0.t-ipconnect.de. [2003:cb:c71a:5900:d106:4706:528a:7cd5])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39d893773a0sm4135334f8f.25.2025.04.10.02.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 02:10:22 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v1] fs/dax: fix folio splitting issue by resetting old folio order + _nr_pages
Date: Thu, 10 Apr 2025 11:10:20 +0200
Message-ID: <20250410091020.119116-1-david@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alison reports an issue with fsdax when large extends end up using
large ZONE_DEVICE folios:

[  417.796271] BUG: kernel NULL pointer dereference, address: 0000000000000b00
[  417.796982] #PF: supervisor read access in kernel mode
[  417.797540] #PF: error_code(0x0000) - not-present page
[  417.798123] PGD 2a5c5067 P4D 2a5c5067 PUD 2a5c6067 PMD 0
[  417.798690] Oops: Oops: 0000 [#1] SMP NOPTI
[  417.799178] CPU: 5 UID: 0 PID: 1515 Comm: mmap Tainted: ...
[  417.800150] Tainted: [O]=OOT_MODULE
[  417.800583] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[  417.801358] RIP: 0010:__lruvec_stat_mod_folio+0x7e/0x250
[  417.801948] Code: ...
[  417.803662] RSP: 0000:ffffc90002be3a08 EFLAGS: 00010206
[  417.804234] RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000002
[  417.804984] RDX: ffffffff815652d7 RSI: 0000000000000000 RDI: ffffffff82a2beae
[  417.805689] RBP: ffffc90002be3a28 R08: 0000000000000000 R09: 0000000000000000
[  417.806384] R10: ffffea0007000040 R11: ffff888376ffe000 R12: 0000000000000001
[  417.807099] R13: 0000000000000012 R14: ffff88807fe4ab40 R15: ffff888029210580
[  417.807801] FS:  00007f339fa7a740(0000) GS:ffff8881fa9b9000(0000) knlGS:0000000000000000
[  417.808570] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  417.809193] CR2: 0000000000000b00 CR3: 000000002a4f0004 CR4: 0000000000370ef0
[  417.809925] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  417.810622] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  417.811353] Call Trace:
[  417.811709]  <TASK>
[  417.812038]  folio_add_file_rmap_ptes+0x143/0x230
[  417.812566]  insert_page_into_pte_locked+0x1ee/0x3c0
[  417.813132]  insert_page+0x78/0xf0
[  417.813558]  vmf_insert_page_mkwrite+0x55/0xa0
[  417.814088]  dax_fault_iter+0x484/0x7b0
[  417.814542]  dax_iomap_pte_fault+0x1ca/0x620
[  417.815055]  dax_iomap_fault+0x39/0x40
[  417.815499]  __xfs_write_fault+0x139/0x380
[  417.815995]  ? __handle_mm_fault+0x5e5/0x1a60
[  417.816483]  xfs_write_fault+0x41/0x50
[  417.816966]  xfs_filemap_fault+0x3b/0xe0
[  417.817424]  __do_fault+0x31/0x180
[  417.817859]  __handle_mm_fault+0xee1/0x1a60
[  417.818325]  ? debug_smp_processor_id+0x17/0x20
[  417.818844]  handle_mm_fault+0xe1/0x2b0
[...]

The issue is that when we split a large ZONE_DEVICE folio to order-0
ones, we don't reset the order/_nr_pages. As folio->_nr_pages overlays
page[1]->memcg_data, once page[1] is a folio, it suddenly looks like it
has folio->memcg_data set. And we never manually initialize
folio->memcg_data in fsdax code, because we never expect it to be set at
all.

When __lruvec_stat_mod_folio() then stumbles over such a folio, it tries to
use folio->memcg_data (because it's non-NULL) but it does not actually
point at a memcg, resulting in the problem.

Alison also observed that these folios sometimes have "locked"
set, which is rather concerning (folios locked from the beginning ...).
The reason is that the order for large folios is stored in page[1]->flags,
which become the folio->flags of a new small folio.

Let's fix it by adding a folio helper to clear order/_nr_pages for
splitting purposes.

Maybe we should reinitialize other large folio flags / folio members as
well when splitting, because they might similarly cause harm once
page[1] becomes a folio? At least other flags in PAGE_FLAGS_SECOND should
not be set for fsdax, so at least page[1]->flags might be as expected with
this fix.

From a quick glimpse, initializing ->mapping, ->pgmap and ->share should
re-initialize most things from a previous page[1] used by large folios
that fsdax cares about. For example folio->private might not get
reinitialized, but maybe that's not relevant -- no traces of it's use in
fsdax code. Needs a closer look.

Another thing that should be considered in the future is performing similar
checks as we perform in free_tail_page_prepare() -- checking pincount etc.
-- when freeing a large fsdax folio.

Fixes: 4996fc547f5b ("mm: let _folio_nr_pages overlay memcg_data in first tail page")
Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
Reported-by: Alison Schofield <alison.schofield@intel.com>
Closes: https://lkml.kernel.org/r/Z_W9Oeg-D9FhImf3@aschofie-mobl2.lan
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/dax.c           |  1 +
 include/linux/mm.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index af5045b0f476e..676303419e9e8 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -396,6 +396,7 @@ static inline unsigned long dax_folio_put(struct folio *folio)
 	order = folio_order(folio);
 	if (!order)
 		return 0;
+	folio_reset_order(folio);
 
 	for (i = 0; i < (1UL << order); i++) {
 		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b7f13f087954b..bf55206935c46 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1218,6 +1218,23 @@ static inline unsigned int folio_order(const struct folio *folio)
 	return folio_large_order(folio);
 }
 
+/**
+ * folio_reset_order - Reset the folio order and derived _nr_pages
+ * @folio: The folio.
+ *
+ * Reset the order and derived _nr_pages to 0. Must only be used in the
+ * process of splitting large folios.
+ */
+static inline void folio_reset_order(struct folio *folio)
+{
+	if (WARN_ON_ONCE(!folio_test_large(folio)))
+		return;
+	folio->_flags_1 &= ~0xffUL;
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+	folio->_nr_pages = 0;
+#endif
+}
+
 #include <linux/huge_mm.h>
 
 /*
-- 
2.48.1


