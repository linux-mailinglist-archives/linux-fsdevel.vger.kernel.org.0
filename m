Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68E7316D4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 18:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhBJRuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 12:50:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:25660 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233069AbhBJRuP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:50:15 -0500
IronPort-SDR: xFrjPEU0FT28N8Q9itkymFHOztahkhUnyUwQgcD9+ApbYWCwFKw5ux47p882GKbZujaHU3T0cy
 ONfNSiPul/UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="182258512"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="182258512"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 09:49:30 -0800
IronPort-SDR: EIbUcLcbRmcin5F06P67AqJ4SA55ZVK/ev1am/Uz4HGR0l1qSa5GvSAV9/TygSCzORk2rMb1L2
 5PsTqCoEMwVQ==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="380231750"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 09:49:30 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, clm@fb.com,
        josef@toxicpanda.com, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V2.1] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
Date:   Wed, 10 Feb 2021 09:49:28 -0800
Message-Id: <20210210174928.3156073-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210210062221.3023586-5-ira.weiny@intel.com>
References: <20210210062221.3023586-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Add VM_BUG_ON bounds checks to ensure the newly lifted and created page
memory operations do not result in corrupted data in neighbor pages.[1][2]

[1] https://lore.kernel.org/lkml/20201210053502.GS1563847@iweiny-DESK2.sc.intel.com/
[2] https://lore.kernel.org/lkml/20210209110931.00f00e47d9a0529fcee2ff01@linux-foundation.org/

Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2:
	Actually, really do VM_BUG_ON...  <sigh>
	Clean up commit message
---
 include/linux/highmem.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 0b5d89621cb9..44170f312ae7 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -283,6 +283,7 @@ static inline void memcpy_page(struct page *dst_page, size_t dst_off,
 	char *dst = kmap_local_page(dst_page);
 	char *src = kmap_local_page(src_page);
 
+	VM_BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
 	memcpy(dst + dst_off, src + src_off, len);
 	kunmap_local(src);
 	kunmap_local(dst);
@@ -295,6 +296,7 @@ static inline void memmove_page(struct page *dst_page, size_t dst_off,
 	char *dst = kmap_local_page(dst_page);
 	char *src = kmap_local_page(src_page);
 
+	VM_BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
 	memmove(dst + dst_off, src + src_off, len);
 	kunmap_local(src);
 	kunmap_local(dst);
@@ -305,6 +307,7 @@ static inline void memset_page(struct page *page, size_t offset, int val,
 {
 	char *addr = kmap_local_page(page);
 
+	VM_BUG_ON(offset + len > PAGE_SIZE);
 	memset(addr + offset, val, len);
 	kunmap_local(addr);
 }
@@ -314,6 +317,7 @@ static inline void memcpy_from_page(char *to, struct page *page,
 {
 	char *from = kmap_local_page(page);
 
+	VM_BUG_ON(offset + len > PAGE_SIZE);
 	memcpy(to, from + offset, len);
 	kunmap_local(from);
 }
@@ -323,6 +327,7 @@ static inline void memcpy_to_page(struct page *page, size_t offset,
 {
 	char *to = kmap_local_page(page);
 
+	VM_BUG_ON(offset + len > PAGE_SIZE);
 	memcpy(to + offset, from, len);
 	kunmap_local(to);
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9

