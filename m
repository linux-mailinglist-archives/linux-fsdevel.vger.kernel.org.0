Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC7E30E61F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 23:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhBCWeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 17:34:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:45279 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232866AbhBCWeW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:34:22 -0500
IronPort-SDR: 86tdHmc3RFuPjEMuV6t4nX3OiRu2f8B1NZxHF62YIaimUWMWLdQfWeKuUDLjoD3sruzyEBdcB7
 Lc7D67BmXEZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168812233"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="168812233"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:33:35 -0800
IronPort-SDR: BiTfgGiCuRiqnGGyD3oA/vCjTN/Corbs6i2mXb3+HOgc5kWbqRa+FmYIfR4oPjm/0n1Piije2p
 E78hn2W/98zA==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="392673483"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:33:33 -0800
From:   ira.weiny@intel.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/coredump: Use kmap_local_page()
Date:   Wed,  3 Feb 2021 14:33:28 -0800
Message-Id: <20210203223328.558945-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In dump_user_range() there is no reason for the mapping to be global.
Use kmap_local_page() rather than kmap.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/coredump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a2f6ecc8e345..53f63e176a2a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -894,10 +894,10 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		 */
 		page = get_dump_page(addr);
 		if (page) {
-			void *kaddr = kmap(page);
+			void *kaddr = kmap_local_page(page);
 
 			stop = !dump_emit(cprm, kaddr, PAGE_SIZE);
-			kunmap(page);
+			kunmap_local(kaddr);
 			put_page(page);
 		} else {
 			stop = !dump_skip(cprm, PAGE_SIZE);
-- 
2.28.0.rc0.12.gb6a658bd00c9

