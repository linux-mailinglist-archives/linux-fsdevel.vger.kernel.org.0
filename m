Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1951B4F11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 23:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDVVVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 17:21:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:12966 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgDVVVR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:21:17 -0400
IronPort-SDR: 8jgz5v7oP61vjBrS3pxlGp5iTyIx3u9IvJ8XLqXH0RJAu4ax3EhQpNZTpMnW0PtuMPRCSDs7Vr
 g0d2X3djZdzQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 14:21:16 -0700
IronPort-SDR: kExJ3fAAktfWxz+ppsCTqVQnwvQ/6bsHAHMHFol38eHebWnqp8A5j0haWRKOXkoRq1nigFjYaP
 UFN9bhcJ1fWA==
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="334752640"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 14:21:16 -0700
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
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH V10 01/11] fs/xfs: Remove unnecessary initialization of i_rwsem
Date:   Wed, 22 Apr 2020 14:20:52 -0700
Message-Id: <20200422212102.3757660-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200422212102.3757660-1-ira.weiny@intel.com>
References: <20200422212102.3757660-1-ira.weiny@intel.com>
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

