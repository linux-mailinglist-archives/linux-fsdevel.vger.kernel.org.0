Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A841B13B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbfILR3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:12 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:57821 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387645AbfILR3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309350; x=1599845350;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=cppOhrCS7ATHTbfPlLYKQfLvi0c5+MKzD8qR957mkfI=;
  b=b6hXTVEpzOnKleE+Q22Yxxj3qPBpTSEbOqkapd7mj2ae6ehmIv/VNSOv
   rmmoyEXoSLefhklay+14X5jd+1zW7CwQS75IqxHJf/5TtU2MRQ04XoDzU
   hG0n41CSJ5R7kcALzVj+EFKcTZb9dJcooPCXXt+joRMUXJApEb/UVf+td
   g=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="702191778"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Sep 2019 17:28:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 705F6A2619;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D18UEA001.ant.amazon.com (10.43.61.129) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D18UEA001.ant.amazon.com (10.43.61.129) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E249AC053B; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <69bcfd7de0c47fb0fd45788394ffa52478a63bdc.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Fri, 30 Aug 2019 23:38:36 +0000
Subject: [RFC PATCH 18/35] NFSv4.2: add client side xattr caching functions
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement client side caching for NFSv4.2 extended attributes.

[note: this currently does nothing]

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/Makefile             |  1 +
 fs/nfs/internal.h           | 16 +++++++++
 fs/nfs/nfs42xattr.c         | 72 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/nfs_fs.h |  1 +
 4 files changed, 90 insertions(+)
 create mode 100644 fs/nfs/nfs42xattr.c

diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 34cdeaecccf6..0917598db270 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -31,6 +31,7 @@ nfsv4-$(CONFIG_NFS_USE_LEGACY_DNS) += cache_lib.o
 nfsv4-$(CONFIG_SYSCTL)	+= nfs4sysctl.o
 nfsv4-$(CONFIG_NFS_V4_1)	+= pnfs.o pnfs_dev.o pnfs_nfs.o
 nfsv4-$(CONFIG_NFS_V4_2)	+= nfs42proc.o
+nfsv4-$(CONFIG_NFS_V4_XATTR)	+= nfs42xattr.o
 
 obj-$(CONFIG_PNFS_FILE_LAYOUT) += filelayout/
 obj-$(CONFIG_PNFS_BLOCK) += blocklayout/
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 75645d9ff10b..558b9c8ddfbf 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -583,6 +583,22 @@ extern void nfs4_test_session_trunk(struct rpc_clnt *clnt,
 				struct rpc_xprt *xprt,
 				void *data);
 
+#ifdef CONFIG_NFS_V4_XATTR
+extern void nfs4_xattr_cache_add(struct inode *, const char *name,
+				 const char *buf, ssize_t buflen);
+extern void nfs4_xattr_cache_remove(struct inode *, const char *name);
+extern ssize_t nfs4_xattr_cache_get(struct inode *inode, const char *name,
+				char *buf, ssize_t buflen);
+extern void nfs4_xattr_cache_set_list(struct inode *, const char *buf,
+				      ssize_t buflen);
+extern ssize_t nfs4_xattr_cache_list(struct inode *, char *buf, ssize_t buflen);
+extern void nfs4_xattr_cache_zap(struct inode *);
+#else
+static inline void nfs4_xattr_cache_zap(struct inode *)
+{
+}
+#endif
+
 static inline struct inode *nfs_igrab_and_active(struct inode *inode)
 {
 	inode = igrab(inode);
diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
new file mode 100644
index 000000000000..40c190cfaa75
--- /dev/null
+++ b/fs/nfs/nfs42xattr.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ *
+ * User extended attribute client side cache functions.
+ *
+ * Author: Frank van der Linden <fllinden@amazon.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/nfs_fs.h>
+
+#include "nfs4_fs.h"
+#include "internal.h"
+
+#define NFSDBG_FACILITY         NFSDBG_XATTRCACHE
+
+
+/*
+ * Retrieve an xattr from the cache.
+ */
+ssize_t nfs4_xattr_cache_get(struct inode *inode, const char *name, char *buf,
+			 ssize_t buflen)
+{
+	return -ENOENT;
+}
+
+/*
+ * Retrieve a cached list of xattrs from the cache.
+ */
+ssize_t nfs4_xattr_cache_list(struct inode *inode, char *buf, ssize_t buflen)
+{
+	return -ENOENT;
+}
+
+/*
+ * Add an xattr to the cache.
+ *
+ * This also invalidates the xattr list cache.
+ */
+void nfs4_xattr_cache_add(struct inode *inode, const char *name,
+			  const char *buf, ssize_t buflen)
+{
+}
+
+
+/*
+ * Remove an xattr to the cache.
+ *
+ * This also invalidates the xattr list cache.
+ */
+void nfs4_xattr_cache_remove(struct inode *inode, const char *name)
+{
+}
+
+/*
+ * Cache listxattr output, replacing any possible old one.
+ *
+ * Should validate existing cache entries.
+ */
+void nfs4_xattr_cache_set_list(struct inode *inode, const char *buf,
+			       ssize_t buflen)
+{
+}
+
+/*
+ * Zap the entire cache.
+ */
+void nfs4_xattr_cache_zap(struct inode *inode)
+{
+}
diff --git a/include/uapi/linux/nfs_fs.h b/include/uapi/linux/nfs_fs.h
index 7bcc8cd6831d..3afe3767c55d 100644
--- a/include/uapi/linux/nfs_fs.h
+++ b/include/uapi/linux/nfs_fs.h
@@ -56,6 +56,7 @@
 #define NFSDBG_PNFS		0x1000
 #define NFSDBG_PNFS_LD		0x2000
 #define NFSDBG_STATE		0x4000
+#define NFSDBG_XATTRCACHE	0x8000
 #define NFSDBG_ALL		0xFFFF
 
 
-- 
2.17.2

