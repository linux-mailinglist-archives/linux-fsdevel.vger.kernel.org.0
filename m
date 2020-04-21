Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1739D1B3023
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 21:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgDUTSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 15:18:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:18919 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgDUTSJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:18:09 -0400
IronPort-SDR: QTU7rdq25HDBL+K4KdkNi/zaNii6wcHp4wDBC5nQVPatnBQ67jdZmj5WerqT5KU+FSKGROiMLn
 RzUTutxpSL8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 12:18:08 -0700
IronPort-SDR: 3syosJetz0bcm+8ykPRzsvNnLzUxZoCJMQ4koAdaW8DNRPOta+/iDPJ0yFxN9S5KHe1oo20FPL
 SExRBxsNuROA==
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="245763790"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 12:18:08 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Chinner <dchinner@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V9 01/11] fs/xfs: Remove unnecessary initialization of i_rwsem
Date:   Tue, 21 Apr 2020 12:17:43 -0700
Message-Id: <20200421191754.3372370-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200421191754.3372370-1-ira.weiny@intel.com>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
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

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
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
index 8bf1d15be3f6..17a0b86fe701 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -423,6 +423,7 @@ xfs_iget_cache_hit(
 		spin_unlock(&ip->i_flags_lock);
 		rcu_read_unlock();
 
+		ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 		error = xfs_reinit_inode(mp, inode);
 		if (error) {
 			bool wake;
@@ -456,9 +457,6 @@ xfs_iget_cache_hit(
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

