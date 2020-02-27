Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE85617107F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 06:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgB0Fck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 00:32:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:15192 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgB0Fcj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:32:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 21:32:38 -0800
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="226996288"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 21:32:37 -0800
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V5 01/12] fs/xfs: Remove unnecessary initialization of i_rwsem
Date:   Wed, 26 Feb 2020 21:24:31 -0800
Message-Id: <20200227052442.22524-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200227052442.22524-1-ira.weiny@intel.com>
References: <20200227052442.22524-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

xfs_reinit_inode() -> inode_init_always() already handles calling
init_rwsem(i_rwsem).  Doing so again is unneeded.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
New for V4:

NOTE: This was found while ensuring the new i_aops_sem was properly
handled.  It seems like this is a layering violation so I think it is
worth cleaning up so as to not confuse others.
---
 fs/xfs/xfs_icache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 8dc2e5414276..836a1f09be03 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -419,6 +419,7 @@ xfs_iget_cache_hit(
 		spin_unlock(&ip->i_flags_lock);
 		rcu_read_unlock();
 
+		ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 		error = xfs_reinit_inode(mp, inode);
 		if (error) {
 			bool wake;
@@ -452,9 +453,6 @@ xfs_iget_cache_hit(
 		ip->i_sick = 0;
 		ip->i_checked = 0;
 
-		ASSERT(!rwsem_is_locked(&inode->i_rwsem));
-		init_rwsem(&inode->i_rwsem);
-
 		spin_unlock(&ip->i_flags_lock);
 		spin_unlock(&pag->pag_ici_lock);
 	} else {
-- 
2.21.0

