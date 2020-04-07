Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7998A1A1395
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgDGSaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 14:30:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:16889 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgDGSaS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:30:18 -0400
IronPort-SDR: YKOMkBWL1CsdMBNXvB+MGdjJrSI71ZZYQ7FDt8t47+imrX6HDUmLB8lYZoGvWWst9AYftiHBfR
 kuM5He5S0q7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:17 -0700
IronPort-SDR: ePAZbIsRrsS6UG/p1hoq5+CTsUq3/kNY0KQagI7Q0ee3lR7deqMEjFShf+a0mnWzHO9bl0NGxn
 a/e+JK15sQZg==
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="397947609"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:16 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V6 1/8] fs/xfs: Remove unnecessary initialization of i_rwsem
Date:   Tue,  7 Apr 2020 11:29:51 -0700
Message-Id: <20200407182958.568475-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407182958.568475-1-ira.weiny@intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

An earlier call of xfs_reinit_inode() from xfs_iget_cache_hit() already
handles initialization of i_rwsem.

Doing so again is unneeded.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V4:
	Update commit message to make it clear the xfs_iget_cache_hit()
	is actually doing the initialization via xfs_reinit_inode()

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
2.25.1

