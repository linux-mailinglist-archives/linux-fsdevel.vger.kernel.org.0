Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B14223564
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 09:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgGQHVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 03:21:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:11415 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbgGQHVK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:21:10 -0400
IronPort-SDR: K75kQDp0cb8JmmILXvpz+oyuggRuth6vlJLIFNf3MF/Q22GyOhme01tT2huB9AlAQA+IFkCR9C
 t1u3PtQySSpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="234401130"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="234401130"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:10 -0700
IronPort-SDR: viJrwwhLUZwipsvXApKspDNsQU+CwYvDOwHjI74HqRE/r92df5TCe9N6WlL3Sucvt7R6kOjDXY
 nvO/Jnn8HJfQ==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="325362844"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:09 -0700
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
Subject: [PATCH RFC V2 16/17] [dax|pmem]: Enable stray write protection
Date:   Fri, 17 Jul 2020 00:20:55 -0700
Message-Id: <20200717072056.73134-17-ira.weiny@intel.com>
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

Protecting against stray writes is particularly important for PMEM
because, unlike writes to anonymous memory, writes to PMEM persists
across a reboot.  Thus data corruption could result in permanent loss of
data.  Therefore, there is no option presented to the user.

Enable stray write protection by setting the flag in pgmap which
requests it.  Note if Zone Device Access Protection not be supported
this flag will have no affect.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/device.c  | 2 ++
 drivers/nvdimm/pmem.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 4c0af2eb7e19..884f66d73d32 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -430,6 +430,8 @@ int dev_dax_probe(struct device *dev)
 	}
 
 	dev_dax->pgmap.type = MEMORY_DEVICE_DEVDAX;
+	dev_dax->pgmap.flags |= PGMAP_PROT_ENABLED;
+
 	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 46c11a09b813..9416a660eede 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -427,6 +427,8 @@ static int pmem_attach_disk(struct device *dev,
 		return -EBUSY;
 	}
 
+	pmem->pgmap.flags |= PGMAP_PROT_ENABLED;
+
 	q = blk_alloc_queue(pmem_make_request, dev_to_node(dev));
 	if (!q)
 		return -ENOMEM;
-- 
2.28.0.rc0.12.gb6a658bd00c9

