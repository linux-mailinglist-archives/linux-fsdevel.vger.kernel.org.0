Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F736223575
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 09:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgGQHVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 03:21:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:34219 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgGQHVK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:21:10 -0400
IronPort-SDR: FU6KNJALm+hR17Xi9/HncX83+Zh/uPRem6CpTh5Ed+sv1fNAApPL6MmviBT7tWoq+kDZmV9Xae
 2DvcDfK+xlBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="150928920"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="150928920"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:09 -0700
IronPort-SDR: DMw9Bg0fto/LYRsYYNO/RmvrHFgQrAU3QdS7dMnjcycrTtADfzCGcIaR6tz+7treV3M3/2IvuB
 Hz5Snhjs883w==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="486385675"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:09 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V2 15/17] nvdimm/pmem: Stray write protection for pmem->virt_addr
Date:   Fri, 17 Jul 2020 00:20:54 -0700
Message-Id: <20200717072056.73134-16-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The pmem driver uses a cached virtual address to access its memory
directly.  Because the nvdimm driver is well aware of the special
protections it has mapped memory with, we call dev_access_[en|dis]able()
around the direct pmem->virt_addr (pmem_addr) usage instead of the
unnecessary overhead of trying to get a page to kmap.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/nvdimm/pmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index d25e66fd942d..46c11a09b813 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -148,7 +148,9 @@ static blk_status_t pmem_do_read(struct pmem_device *pmem,
 	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
 		return BLK_STS_IOERR;
 
+	dev_access_enable();
 	rc = read_pmem(page, page_off, pmem_addr, len);
+	dev_access_disable();
 	flush_dcache_page(page);
 	return rc;
 }
@@ -180,11 +182,13 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 	 * after clear poison.
 	 */
 	flush_dcache_page(page);
+	dev_access_enable();
 	write_pmem(pmem_addr, page, page_off, len);
 	if (unlikely(bad_pmem)) {
 		rc = pmem_clear_poison(pmem, pmem_off, len);
 		write_pmem(pmem_addr, page, page_off, len);
 	}
+	dev_access_disable();
 
 	return rc;
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9

