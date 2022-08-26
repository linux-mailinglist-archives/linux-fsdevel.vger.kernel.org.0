Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9AF5A2D3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 19:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbiHZRSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 13:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiHZRSD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:18:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E368AB07B;
        Fri, 26 Aug 2022 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661534283; x=1693070283;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fs681qlkVC3ILKSgH9kmbbCYwIlE7iUgG8xYi36A6tk=;
  b=L4oaAFtXG4Tx7mz5PMYC34D0vQ6XBJY6Og5ptbZxztM1F3jkfGZOPGK2
   wlFWUoyaAioIzYHY+4SjWECZKjUoNLKF0HNPsgu9XNCvr6+46iYBLVihc
   Yq2fHMxviVJLXQhx8A+3HeZmEG2hSl8LhMmLDmVEGjC5z6TWrcOE+DyQ3
   d8BaubXJi4bLBp7/vUsiaeOjojNnNj9Pm7qEW38cqrfb6+QNNpk+ZXpKq
   RIhRaeqEoKgckwvx1YE3ztakPmcmO54exMHoDeuIpha+BR9j/z+d7jGkf
   eLNA01tpxLBTNd/MbAhLaukuKg/5+cP93f4DlzYAP8AMU2ve8vISmdSVO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="293297727"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="293297727"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:18:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="938824876"
Received: from jodirobx-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.108.22])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:18:01 -0700
Subject: [PATCH 2/4] xfs: Fix SB_BORN check in xfs_dax_notify_failure()
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
Date:   Fri, 26 Aug 2022 10:18:01 -0700
Message-ID: <166153428094.2758201.7936572520826540019.stgit@dwillia2-xfh.jf.intel.com>
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

The SB_BORN flag is stored in the vfs superblock, not xfs_sb.

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
 fs/xfs/xfs_notify_failure.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 01e2721589c4..5b1f9a24ed59 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -175,7 +175,7 @@ xfs_dax_notify_failure(
 	u64			ddev_start;
 	u64			ddev_end;
 
-	if (!(mp->m_sb.sb_flags & SB_BORN)) {
+	if (!(mp->m_super->s_flags & SB_BORN)) {
 		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
 		return -EIO;
 	}

