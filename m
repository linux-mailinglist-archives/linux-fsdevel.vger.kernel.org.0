Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33585315F60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 07:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhBJGXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 01:23:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:39559 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231669AbhBJGX3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:23:29 -0500
IronPort-SDR: k+gfS1ocv02JE5uSmGcKFPVpMNsANXVUZloehs1j22Q6FKUb1rSKXdSWIIffEQTyc7uch5AqL/
 3We5/S9GCRtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="182086725"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="182086725"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:34 -0800
IronPort-SDR: 3Q1v837EzXA6qfxK2Yx8MZh/Cw/3Ps73YnDtNQdKsEAVoB1g/jmcsh0Su03O8JPlpdoeqdLXZz
 1B01NPVxHdyw==
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="587246151"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:34 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 4/8] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
Date:   Tue,  9 Feb 2021 22:22:17 -0800
Message-Id: <20210210062221.3023586-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210210062221.3023586-1-ira.weiny@intel.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Add VM_BUG_ON bounds checks to ensure the newly lifted and created page
memory operations do not result in corrupted data in neighbor pages and
to make them consistent with zero_user().[1][2]

[1] https://lore.kernel.org/lkml/20201210053502.GS1563847@iweiny-DESK2.sc.intel.com/
[2] https://lore.kernel.org/lkml/20210209110931.00f00e47d9a0529fcee2ff01@linux-foundation.org/

Cc: Christoph Hellwig <hch@infradead.org>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
New for V2
---
 include/linux/highmem.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 0b5d89621cb9..520bbc67e67f 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -283,6 +283,7 @@ static inline void memcpy_page(struct page *dst_page, size_t dst_off,
 	char *dst = kmap_local_page(dst_page);
 	char *src = kmap_local_page(src_page);
 
+	BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
 	memcpy(dst + dst_off, src + src_off, len);
 	kunmap_local(src);
 	kunmap_local(dst);
@@ -295,6 +296,7 @@ static inline void memmove_page(struct page *dst_page, size_t dst_off,
 	char *dst = kmap_local_page(dst_page);
 	char *src = kmap_local_page(src_page);
 
+	BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
 	memmove(dst + dst_off, src + src_off, len);
 	kunmap_local(src);
 	kunmap_local(dst);
@@ -305,6 +307,7 @@ static inline void memset_page(struct page *page, size_t offset, int val,
 {
 	char *addr = kmap_local_page(page);
 
+	BUG_ON(offset + len > PAGE_SIZE);
 	memset(addr + offset, val, len);
 	kunmap_local(addr);
 }
@@ -314,6 +317,7 @@ static inline void memcpy_from_page(char *to, struct page *page,
 {
 	char *from = kmap_local_page(page);
 
+	BUG_ON(offset + len > PAGE_SIZE);
 	memcpy(to, from + offset, len);
 	kunmap_local(from);
 }
@@ -323,6 +327,7 @@ static inline void memcpy_to_page(struct page *page, size_t offset,
 {
 	char *to = kmap_local_page(page);
 
+	BUG_ON(offset + len > PAGE_SIZE);
 	memcpy(to + offset, from, len);
 	kunmap_local(to);
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9

