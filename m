Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D19F39077D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhEYR0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 13:26:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:9404 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233843AbhEYR0Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 13:26:16 -0400
IronPort-SDR: ORtokHP8GR+g4SaXWfdeAE+JDGJVwxfY5z5f0gcX0cugm8brw5jFZ1wabDmgBEBbJBiz4wiEVN
 fVzYdac7PPXw==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="202288219"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="202288219"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 10:24:33 -0700
IronPort-SDR: iSJB6XtPrtPA88Et5nfaFUasQXO07mqz6NAlMsTbI4655hsWgUQEF6JYKXVXNX+nNviIytsXNY
 l00jeGp5eGPQ==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="633105450"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 10:24:32 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] dax: Ensure errno is returned from dax_direct_access
Date:   Tue, 25 May 2021 10:24:28 -0700
Message-Id: <20210525172428.3634316-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210525172428.3634316-1-ira.weiny@intel.com>
References: <20210525172428.3634316-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

If the caller specifies a negative nr_pages that is an invalid
parameter.

Return -EINVAL to ensure callers get an errno if they want to check it.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 5fa6ae9dbc8b..44736cbd446e 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -313,7 +313,7 @@ long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 		return -ENXIO;
 
 	if (nr_pages < 0)
-		return nr_pages;
+		return -EINVAL;
 
 	avail = dax_dev->ops->direct_access(dax_dev, pgoff, nr_pages,
 			kaddr, pfn);
-- 
2.28.0.rc0.12.gb6a658bd00c9

