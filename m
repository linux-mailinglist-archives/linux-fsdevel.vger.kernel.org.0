Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6711A6282
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 07:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgDMFlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 01:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbgDMFla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 01:41:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E15DC008675;
        Sun, 12 Apr 2020 22:41:30 -0700 (PDT)
IronPort-SDR: QhjFJJJ1RMjaeYf8q4wFcxZHvlXCA+RMs1tys42YUZ9Ayn/yhuDQ0g7wQOGuFNwbPFJ7mJoGu7
 RzlGCRTeyE+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 22:41:26 -0700
IronPort-SDR: Hcd+XAaWBlBPrMyHf4SMn5E5Q7Ywj8yI+KmEfJr3A8P8T/wc7H4UB7zHJ74tNgFP9CiuvYhgdP
 DQ8rvnEyDPHQ==
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; 
   d="scan'208";a="270977630"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 22:41:26 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V7 7/9] fs: Define I_DONTCACNE in VFS layer
Date:   Sun, 12 Apr 2020 22:40:44 -0700
Message-Id: <20200413054046.1560106-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200413054046.1560106-1-ira.weiny@intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

DAX effective mode changes (setting of S_DAX) require inode eviction.

Define a flag which can be set to inform the VFS layer that inodes
should not be cached.  This will expedite the eviction of those nodes
requiring reload.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index a818ced22961..e2db71d150c3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2151,6 +2151,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *
  * I_CREATING		New object's inode in the middle of setting up.
  *
+ * I_DONTCACHE		Do not cache the inode
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2173,6 +2175,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_WB_SWITCH		(1 << 13)
 #define I_OVL_INUSE		(1 << 14)
 #define I_CREATING		(1 << 15)
+#define I_DONTCACHE		(1 << 16)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
@@ -3042,7 +3045,8 @@ extern int inode_needs_sync(struct inode *inode);
 extern int generic_delete_inode(struct inode *inode);
 static inline int generic_drop_inode(struct inode *inode)
 {
-	return !inode->i_nlink || inode_unhashed(inode);
+	return !inode->i_nlink || inode_unhashed(inode) ||
+		(inode->i_state & I_DONTCACHE);
 }
 
 extern struct inode *ilookup5_nowait(struct super_block *sb,
-- 
2.25.1

