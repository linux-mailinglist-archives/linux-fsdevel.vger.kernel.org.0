Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05BD73698D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 03:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfFFBpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 21:45:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:36143 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfFFBpO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:45:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 18:45:13 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2019 18:45:12 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH RFC 03/10] mm/gup: Pass flags down to __gup_device_huge* calls
Date:   Wed,  5 Jun 2019 18:45:36 -0700
Message-Id: <20190606014544.8339-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606014544.8339-1-ira.weiny@intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In order to support checking for a layout lease on a FS DAX inode these
calls need to know if FOLL_LONGTERM was specified.

Prepare for this with this patch.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/gup.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a3fb48605836..26a7a3a3a657 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1939,7 +1939,8 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 
 #if defined(__HAVE_ARCH_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
 static int __gup_device_huge(unsigned long pfn, unsigned long addr,
-		unsigned long end, struct page **pages, int *nr)
+		unsigned long end, struct page **pages, int *nr,
+		unsigned int flags)
 {
 	int nr_start = *nr;
 	struct dev_pagemap *pgmap = NULL;
@@ -1969,30 +1970,33 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 }
 
 static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, struct page **pages, int *nr)
+		unsigned long end, struct page **pages, int *nr,
+		unsigned int flags)
 {
 	unsigned long fault_pfn;
 	int nr_start = *nr;
 
 	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr))
+	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr, flags))
 		return 0;
 
 	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
 		undo_dev_pagemap(nr, nr_start, pages);
 		return 0;
 	}
+
 	return 1;
 }
 
 static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
-		unsigned long end, struct page **pages, int *nr)
+		unsigned long end, struct page **pages, int *nr,
+		unsigned int flags)
 {
 	unsigned long fault_pfn;
 	int nr_start = *nr;
 
 	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr))
+	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr, flags))
 		return 0;
 
 	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
@@ -2003,14 +2007,16 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 }
 #else
 static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, struct page **pages, int *nr)
+		unsigned long end, struct page **pages, int *nr,
+		unsigned int flags)
 {
 	BUILD_BUG();
 	return 0;
 }
 
 static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
-		unsigned long end, struct page **pages, int *nr)
+		unsigned long end, struct page **pages, int *nr,
+		unsigned int flags)
 {
 	BUILD_BUG();
 	return 0;
@@ -2029,7 +2035,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (pmd_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
-		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
+		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr,
+					     flags);
 	}
 
 	refs = 0;
@@ -2072,7 +2079,8 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (pud_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
-		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr);
+		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr,
+					     flags);
 	}
 
 	refs = 0;
-- 
2.20.1

