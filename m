Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33146156785
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 20:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBHTff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Feb 2020 14:35:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:59763 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbgBHTev (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Feb 2020 14:34:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 11:34:51 -0800
X-IronPort-AV: E=Sophos;i="5.70,418,1574150400"; 
   d="scan'208";a="280279360"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 11:34:51 -0800
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
Subject: [PATCH v3 08/12] fs/xfs: Clarify lockdep dependency for xfs_isilocked()
Date:   Sat,  8 Feb 2020 11:34:41 -0800
Message-Id: <20200208193445.27421-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200208193445.27421-1-ira.weiny@intel.com>
References: <20200208193445.27421-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

xfs_isilocked() can't work fully without CONFIG_LOCKDEP.  However,
making xfs_isilocked() dependant on CONFIG_LOCKDEP is not feasible
because it is used for more than the i_rwsem.  Therefore a short-circuit
was provided via debug_locks.  However, this caused confusion while
working through the xfs locking.

Rather than use debug_locks as a flag specify this clearly using
IS_ENABLED(CONFIG_LOCKDEP).

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2:
	This patch is new for V3

 fs/xfs/xfs_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index c5077e6326c7..35df324875db 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -364,7 +364,7 @@ xfs_isilocked(
 
 	if (lock_flags & (XFS_IOLOCK_EXCL|XFS_IOLOCK_SHARED)) {
 		if (!(lock_flags & XFS_IOLOCK_SHARED))
-			return !debug_locks ||
+			return !IS_ENABLED(CONFIG_LOCKDEP) ||
 				lockdep_is_held_type(&VFS_I(ip)->i_rwsem, 0);
 		return rwsem_is_locked(&VFS_I(ip)->i_rwsem);
 	}
-- 
2.21.0

