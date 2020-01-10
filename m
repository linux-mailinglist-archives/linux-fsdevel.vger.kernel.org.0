Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B1113773D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 20:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgAJTbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 14:31:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:10924 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgAJT35 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:29:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:29:56 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="272503818"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:29:56 -0800
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
Subject: [RFC PATCH V2 01/12] fs/stat: Define DAX statx attribute
Date:   Fri, 10 Jan 2020 11:29:31 -0800
Message-Id: <20200110192942.25021-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200110192942.25021-1-ira.weiny@intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In order for users to determine if a file is currently operating in DAX
mode (effective DAX).  Define a statx attribute value and set that
attribute if the effective DAX flag is set.

To go along with this we propose the following addition to the statx man
page:

STATX_ATTR_DAX

	DAX (cpu direct access) is a file mode that attempts to minimize
	software cache effects for both I/O and memory mappings of this
	file.  It requires a capable device, a compatible filesystem
	block size, and filesystem opt-in. It generally assumes all
	accesses are via cpu load / store instructions which can
	minimize overhead for small accesses, but adversely affect cpu
	utilization for large transfers. File I/O is done directly
	to/from user-space buffers. While the DAX property tends to
	result in data being transferred synchronously it does not give
	the guarantees of synchronous I/O that data and necessary
	metadata are transferred. Memory mapped I/O may be performed
	with direct mappings that bypass system memory buffering. Again
	while memory-mapped I/O tends to result in data being
	transferred synchronously it does not guarantee synchronous
	metadata updates. A dax file may optionally support being mapped
	with the MAP_SYNC flag which does allow cpu store operations to
	be considered synchronous modulo cpu cache effects.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
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

