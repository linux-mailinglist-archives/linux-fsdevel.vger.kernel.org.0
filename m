Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 950CCB139E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbfILR26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:28:58 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44567 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387629AbfILR26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309337; x=1599845337;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=J4a176Tv9w3by7tKA41OqKdIpifabg3UQlH3Ls0c9cY=;
  b=oENr6bX1DFhI8ZUfKKfMppKVGAM1QjSSDNezfJ96+Oxfj+G3qWIC/iwq
   TDKGkI7DP8NiwgL1pouU/uDjYJE2C0GMOtYujRgTZOKKbRAOnAFO6pFh8
   u9ImVxfbAVKU+ocEuD76kFKs1Jp4lr/d30W6EWMcIIxVXWWuLg+3RKCvM
   k=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="750440669"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 12 Sep 2019 17:28:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id E6923A2D41;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D32UWB002.ant.amazon.com (10.43.161.139) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D32UWB002.ant.amazon.com (10.43.161.139) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E444CC056C; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <1072eb67b96d076c5dc040213f7fd503060e9dee.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Fri, 30 Aug 2019 23:45:03 +0000
Subject: [RFC PATCH 19/35] NFSv4.2: call the xattr cache functions
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call the xattr caching functions from the nfs42_proc_*xattr functions
to query/add/remove extended attributes.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs4proc.c  | 36 ++++++++++++++++++++++++++++++------
 fs/nfs/nfs4super.c |  1 +
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 36cca076ccdb..6d4758c35760 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7326,6 +7326,7 @@ static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
 				    size_t buflen, int flags)
 {
 	struct nfs_access_entry cache;
+	int ret;
 
 	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
 		return -EOPNOTSUPP;
@@ -7344,10 +7345,17 @@ static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
 			return -EACCES;
 	}
 
-	if (buf == NULL)
-		return nfs42_proc_removexattr(inode, key);
-	else
-		return nfs42_proc_setxattr(inode, key, buf, buflen, flags);
+	if (buf == NULL) {
+		ret = nfs42_proc_removexattr(inode, key);
+		if (!ret)
+			nfs4_xattr_cache_remove(inode, key);
+	} else {
+		ret = nfs42_proc_setxattr(inode, key, buf, buflen, flags);
+		if (!ret)
+			nfs4_xattr_cache_add(inode, key, buf, buflen);
+	}
+
+	return ret;
 }
 
 static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
@@ -7355,6 +7363,7 @@ static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
 				    const char *key, void *buf, size_t buflen)
 {
 	struct nfs_access_entry cache;
+	ssize_t ret;
 
 	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
 		return -EOPNOTSUPP;
@@ -7364,7 +7373,15 @@ static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
 			return -EACCES;
 	}
 
-	return nfs42_proc_getxattr(inode, key, buf, buflen);
+	ret = nfs4_xattr_cache_get(inode, key, buf, buflen);
+	if (ret >= 0 || (ret < 0 && ret != -ENOENT))
+		return ret;
+
+	ret = nfs42_proc_getxattr(inode, key, buf, buflen);
+	if (ret >= 0)
+		nfs4_xattr_cache_add(inode, key, buf, ret);
+
+	return ret;
 }
 
 static ssize_t
@@ -7372,7 +7389,7 @@ nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
 {
 	u64 cookie;
 	bool eof;
-	int ret, size;
+	ssize_t ret, size;
 	char *buf;
 	size_t buflen;
 	struct nfs_access_entry cache;
@@ -7385,6 +7402,10 @@ nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
 			return 0;
 	}
 
+	ret = nfs4_xattr_cache_list(inode, list, list_len);
+	if (ret >= 0 || (ret < 0 && ret != -ENOENT))
+		return ret;
+
 	cookie = 0;
 	eof = false;
 	buflen = list_len ? list_len : XATTR_LIST_MAX;
@@ -7404,6 +7425,9 @@ nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
 		size += ret;
 	}
 
+	if (list_len)
+		nfs4_xattr_cache_set_list(inode, list, size);
+
 	return size;
 }
 
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 04c57066a11a..5c2cb5505ec7 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -99,6 +99,7 @@ static void nfs4_evict_inode(struct inode *inode)
 	pnfs_destroy_layout(NFS_I(inode));
 	/* First call standard NFS clear_inode() code */
 	nfs_clear_inode(inode);
+	nfs4_xattr_cache_zap(inode);
 }
 
 /*
-- 
2.17.2

