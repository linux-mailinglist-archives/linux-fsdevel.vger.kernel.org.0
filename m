Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1238D21E948
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 09:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgGNHFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 03:05:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:36442 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbgGNHEV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:04:21 -0400
IronPort-SDR: ACgwm0Q1Kl4+u+a+0fm2nJRhaByd2yiJ5R4dOGP70IW8ekzBS+C0hthslOcxkRtLLi+v0gj07v
 dP5G1chAvo8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="213635649"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="213635649"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:17 -0700
IronPort-SDR: 5oFSt+rQ81PQdl8QBXCqp9lx6EuUp2oSohr8H0g6Sb5uObVFDfEd/Sews/ccuD5tPz01v6Cf0X
 n+qUtmLpJo0g==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="268570272"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:17 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 09/15] fs/dax: Remove unused size parameter
Date:   Tue, 14 Jul 2020 00:02:14 -0700
Message-Id: <20200714070220.3500839-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714070220.3500839-1-ira.weiny@intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Passing size to copy_user_dax implies it can copy variable sizes of data
when in fact it calls copy_user_page() which is exactly a page.

We are safe because the only caller uses PAGE_SIZE anyway so just remove
the variable for clarity.

While we are at it change copy_user_dax() to copy_cow_page_dax() to make
it clear it is a singleton helper for this one case not implementing
what dax_iomap_actor() does.

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/dax.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 11b16729b86f..3e0babeb0365 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -680,21 +680,20 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 	return __dax_invalidate_entry(mapping, index, false);
 }
 
-static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
-		sector_t sector, size_t size, struct page *to,
-		unsigned long vaddr)
+static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_dev,
+			     sector_t sector, struct page *to, unsigned long vaddr)
 {
 	void *vto, *kaddr;
 	pgoff_t pgoff;
 	long rc;
 	int id;
 
-	rc = bdev_dax_pgoff(bdev, sector, size, &pgoff);
+	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
 	if (rc)
 		return rc;
 
 	id = dax_read_lock();
-	rc = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size), &kaddr, NULL);
+	rc = dax_direct_access(dax_dev, pgoff, PHYS_PFN(PAGE_SIZE), &kaddr, NULL);
 	if (rc < 0) {
 		dax_read_unlock(id);
 		return rc;
@@ -1305,8 +1304,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 			clear_user_highpage(vmf->cow_page, vaddr);
 			break;
 		case IOMAP_MAPPED:
-			error = copy_user_dax(iomap.bdev, iomap.dax_dev,
-					sector, PAGE_SIZE, vmf->cow_page, vaddr);
+			error = copy_cow_page_dax(iomap.bdev, iomap.dax_dev,
+						  sector, vmf->cow_page, vaddr);
 			break;
 		default:
 			WARN_ON_ONCE(1);
-- 
2.25.1

