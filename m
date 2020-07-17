Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE6B22358A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 09:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgGQHVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 03:21:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:54609 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbgGQHVI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:21:08 -0400
IronPort-SDR: SVLSuXSirVpLmqh3r7+wgLaV0teCx1Ly4zniGPTMYpWCqi4slXe0KmzM9ciKktl+EFVhI5AW7H
 9UrnB1DAU9SA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148708703"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="148708703"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:07 -0700
IronPort-SDR: d+rBzvIqgHnaR+GhYVSKdQJaqDgG6px7MwHBlQpAXhhFUwBpMJADWMQT0thDv3dy+A5eGuvTxT
 jexEd3Xx6KHQ==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="486880410"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:06 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V2 11/17] drivers/dax: Expand lock scope to cover the use of addresses
Date:   Fri, 17 Jul 2020 00:20:50 -0700
Message-Id: <20200717072056.73134-12-ira.weiny@intel.com>
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

The addition of PKS protection to dax read lock/unlock will require that
the address returned by dax_direct_access() be protected by this lock.

While not technically necessary for this series, this corrects the
locking by ensuring that the use of kaddr and end_kaddr are covered by
the dax read lock/unlock.

Change the lock scope to cover the kaddr and end_kaddr use.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 8e32345be0f7..021739768093 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -103,11 +103,11 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	id = dax_read_lock();
 	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
 	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
-	dax_read_unlock(id);
 
 	if (len < 1 || len2 < 1) {
 		pr_debug("%s: error: dax access failed (%ld)\n",
 				bdevname(bdev, buf), len < 1 ? len : len2);
+		dax_read_unlock(id);
 		return false;
 	}
 
@@ -137,6 +137,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 		put_dev_pagemap(end_pgmap);
 
 	}
+	dax_read_unlock(id);
 
 	if (!dax_enabled) {
 		pr_debug("%s: error: dax support not enabled\n",
-- 
2.28.0.rc0.12.gb6a658bd00c9

