Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501825A2D3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiHZRSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 13:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiHZRR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:17:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2754AB07B;
        Fri, 26 Aug 2022 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661534276; x=1693070276;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eytTo9jR/taEQMRxBFsY1ZsO/Az6sn3vkXQeKBBLxVw=;
  b=Quc9ZHU1M5W3Tqj+tt5s4sML1XP3451wtfm7dpHItkkAtOZog1CPFqQU
   HHdMkK6Hw2xSRbUh3k/6Lg21i6D7Vo9PqCDpRp13e/Z1TDsh3Ho3f5ISh
   IBl0OftmrcXbY/hegYWVKeAmyg0SJfZhGQbQFy6mxw9zZSfQ3vag/tm5x
   TzXCYJ5KnOeiruwMxO+k2l3x992pk4UqWq9YJizMELP4BYl92UTeVybV8
   rrLyOqds6UgLF7MkrKkA65DDt4PCoFpRvaBrieyu+ciqp9LODr/Dk6ACI
   zYkDtAkQm6aWta7Z9d7XyH4AzIjLQAxRl9ZwG1wCCBMY4HKW327h2Y5df
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="380858566"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="380858566"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:17:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="714035729"
Received: from jodirobx-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.108.22])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:17:55 -0700
Subject: [PATCH 1/4] xfs: Quiet notify_failure EOPNOTSUPP cases
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org, djwong@kernel.org
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Jane Chu <jane.chu@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 26 Aug 2022 10:17:54 -0700
Message-ID: <166153427440.2758201.6709480562966161512.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com>
References: <166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

XFS always registers dax_holder_operations regardless of whether the
filesystem is capable of handling the notifications. The expectation is
that if the notify_failure handler cannot run then there are no
scenarios where it needs to run. In other words the expected semantic is
that page->index and page->mapping are valid for memory_failure() when
the conditions that cause -EOPNOTSUPP in xfs_dax_notify_failure() are
present.

A fallback to the generic memory_failure() path is expected so do not
warn when that happens.

Fixes: 6f643c57d57c ("xfs: implement ->notify_failure() for XFS")
Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Ritesh Harjani <riteshh@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/xfs/xfs_notify_failure.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 69d9c83ea4b2..01e2721589c4 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -181,7 +181,7 @@ xfs_dax_notify_failure(
 	}
 
 	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
-		xfs_warn(mp,
+		xfs_debug(mp,
 			 "notify_failure() not supported on realtime device!");
 		return -EOPNOTSUPP;
 	}
@@ -194,7 +194,7 @@ xfs_dax_notify_failure(
 	}
 
 	if (!xfs_has_rmapbt(mp)) {
-		xfs_warn(mp, "notify_failure() needs rmapbt enabled!");
+		xfs_debug(mp, "notify_failure() needs rmapbt enabled!");
 		return -EOPNOTSUPP;
 	}
 

