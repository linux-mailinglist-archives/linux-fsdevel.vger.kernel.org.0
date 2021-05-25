Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E45390783
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 19:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhEYR0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 13:26:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:9404 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233835AbhEYR0S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 13:26:18 -0400
IronPort-SDR: uuYBvVQR2urQ05fFrZLRIpgG59Yauka25wjwJbn8mwY0GCn2IDfj8zT/IYrySjcg+SVpIXV7zJ
 uBumMgRFxihA==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="202288210"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="202288210"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 10:24:32 -0700
IronPort-SDR: OdHNGHsGvoFfmo9nVy8uBbmyAzlVttYVc6mn4zkD6OrNs9eFbsEEKMYl7leWvV3KbxrkFVTowF
 1W+pU5hd1R3A==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="633105446"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 10:24:31 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] fs/fuse: Remove unneeded kaddr parameter
Date:   Tue, 25 May 2021 10:24:26 -0700
Message-Id: <20210525172428.3634316-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210525172428.3634316-1-ira.weiny@intel.com>
References: <20210525172428.3634316-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

fuse_dax_mem_range_init() does not need the address or the pfn of the
memory requested in dax_direct_access().  It is only calling direct
access to get the number of pages.

Remove the unused variables and stop requesting the kaddr and pfn from
dax_direct_access().

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/fuse/dax.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index ff99ab2a3c43..34f8a5635c7f 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1234,8 +1234,6 @@ void fuse_dax_conn_free(struct fuse_conn *fc)
 static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
 {
 	long nr_pages, nr_ranges;
-	void *kaddr;
-	pfn_t pfn;
 	struct fuse_dax_mapping *range;
 	int ret, id;
 	size_t dax_size = -1;
@@ -1247,8 +1245,8 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
 	INIT_DELAYED_WORK(&fcd->free_work, fuse_dax_free_mem_worker);
 
 	id = dax_read_lock();
-	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), &kaddr,
-				     &pfn);
+	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), NULL,
+				     NULL);
 	dax_read_unlock(id);
 	if (nr_pages < 0) {
 		pr_debug("dax_direct_access() returned %ld\n", nr_pages);
-- 
2.28.0.rc0.12.gb6a658bd00c9

