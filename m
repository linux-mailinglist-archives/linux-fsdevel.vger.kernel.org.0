Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F5D39077E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhEYR0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 13:26:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:9404 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233852AbhEYR0Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 13:26:16 -0400
IronPort-SDR: T4J9M3K8ez9XlBmhz8UYK0JfdQw1kV8H4R5TI5DiSWm4YLZ130kxwzgpobp6DjHsVxX7JB39Ye
 Kug+r8syaVRw==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="202288198"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="202288198"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 10:24:32 -0700
IronPort-SDR: iTg7kWfPtWs9sWulBMt5sNbz3FIReiZmGS+ArfHxfJGzKJ5yq+zmb6tNwOwraCEALNJrKnbBck
 x13LZednWADA==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="633105443"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 10:24:32 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] fs/dax: Clarify nr_pages to dax_direct_access()
Date:   Tue, 25 May 2021 10:24:27 -0700
Message-Id: <20210525172428.3634316-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210525172428.3634316-1-ira.weiny@intel.com>
References: <20210525172428.3634316-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

dax_direct_access() takes a number of pages.  PHYS_PFN(PAGE_SIZE) is a
very round about way to specify '1'.

Change the nr_pages parameter to the explicit value of '1'.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index b3d27fdc6775..07621322aeee 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -710,7 +710,7 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
 		return rc;
 
 	id = dax_read_lock();
-	rc = dax_direct_access(dax_dev, pgoff, PHYS_PFN(PAGE_SIZE), &kaddr, NULL);
+	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
 	if (rc < 0) {
 		dax_read_unlock(id);
 		return rc;
-- 
2.28.0.rc0.12.gb6a658bd00c9

