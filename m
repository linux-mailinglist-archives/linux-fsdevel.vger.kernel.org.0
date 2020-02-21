Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2C4C166BD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 01:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgBUAlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 19:41:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:20199 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729583AbgBUAlm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:41:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:41:42 -0800
X-IronPort-AV: E=Sophos;i="5.70,466,1574150400"; 
   d="scan'208";a="230293572"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:41:41 -0800
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 04/13] fs/stat: Define DAX statx attribute
Date:   Thu, 20 Feb 2020 16:41:25 -0800
Message-Id: <20200221004134.30599-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200221004134.30599-1-ira.weiny@intel.com>
References: <20200221004134.30599-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In order for users to determine if a file is currently operating in DAX
state (effective DAX).  Define a statx attribute value and set that
attribute if the effective DAX flag is set.

To go along with this we propose the following addition to the statx man
page:

STATX_ATTR_DAX

	The file is in the DAX (cpu direct access) state.  DAX state
	attempts to minimize software cache effects for both I/O and
	memory mappings of this file.  It requires a file system which
	has been configured to support DAX.

	DAX generally assumes all accesses are via cpu load / store
	instructions which can minimize overhead for small accesses, but
	may adversely affect cpu utilization for large transfers.

	File I/O is done directly to/from user-space buffers and memory
	mapped I/O may be performed with direct memory mappings that
	bypass kernel page cache.

	While the DAX property tends to result in data being transferred
	synchronously, it does not give the same guarantees of O_SYNC
	where data and the necessary metadata are transferred together.

	A DAX file may support being mapped with the MAP_SYNC flag,
	which enables a program to use CPU cache flush instructions to
	persist CPU store operations without an explicit fsync(2).  See
	mmap(2) for more information.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2:
	Update man page text with comments from Darrick, Jan, Dan, and
	Dave.
---
 fs/stat.c                 | 3 +++
 include/uapi/linux/stat.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index 030008796479..894699c74dde 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -79,6 +79,9 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	if (IS_AUTOMOUNT(inode))
 		stat->attributes |= STATX_ATTR_AUTOMOUNT;
 
+	if (IS_DAX(inode))
+		stat->attributes |= STATX_ATTR_DAX;
+
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(path, stat, request_mask,
 					    query_flags);
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index ad80a5c885d5..e5f9d5517f6b 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -169,6 +169,7 @@ struct statx {
 #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
 #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
+#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.21.0

