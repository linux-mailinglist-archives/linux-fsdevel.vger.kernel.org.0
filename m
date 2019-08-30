Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75F1B13A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbfILR27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:28:59 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:50455 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387615AbfILR2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309334; x=1599845334;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=28IySAVKxoJRV0LmgCtPNOskQLC1lDBZonx5ptDZpxE=;
  b=tK4nfSIoEuoEWIe7UZvBfqmjqB5AhzyGV9pXc2mAEOwlgCViTyRDgG5c
   +Rugk0mWM/gWi0+ks4YqojNBKFH3ct6il+1Fa00U2c8TFVNkuzQ45Bi4i
   23+nmLb5B/a4ovdJvNIFX1lzdk5msL6iEfZs6Xj1JBIHvay0vb7Tm9v3e
   0=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="420869470"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 12 Sep 2019 17:28:53 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 5914AA2335;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D13UEB003.ant.amazon.com (10.43.60.212) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.129) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D13UEB003.ant.amazon.com (10.43.60.212) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E3333C057F; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <91d9eecc2db69f7f7d01173d693983a658f87811.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Fri, 30 Aug 2019 23:31:46 +0000
Subject: [RFC PATCH 17/35] NFSv4.2: hook in the user extended attribute
 handlers
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all the lower level code is there to make the RPC calls, hook
it in to the xattr handlers and the listxattr entry point, to make them
available.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs4proc.c | 123 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 19d8fd087bf8..36cca076ccdb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -66,6 +66,7 @@
 #include "nfs4idmap.h"
 #include "nfs4session.h"
 #include "fscache.h"
+#include "nfs42.h"
 
 #include "nfs4trace.h"
 
@@ -7318,6 +7319,103 @@ nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
 
 #endif
 
+#ifdef CONFIG_NFS_V4_XATTR
+static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
+				    struct dentry *unused, struct inode *inode,
+				    const char *key, const void *buf,
+				    size_t buflen, int flags)
+{
+	struct nfs_access_entry cache;
+
+	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
+		return -EOPNOTSUPP;
+
+	/*
+	 * There is no mapping from the MAY_* flags to the NFS_ACCESS_XA*
+	 * flags right now. Handling of xattr operations use the normal
+	 * file read/write permissions.
+	 *
+	 * Just in case the server has other ideas (which RFC 8276 allows),
+	 * do a cached access check for the XA* flags to possibly avoid
+	 * doing an RPC and getting EACCES back.
+	 */
+	if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
+		if (!(cache.mask & NFS_ACCESS_XAWRITE))
+			return -EACCES;
+	}
+
+	if (buf == NULL)
+		return nfs42_proc_removexattr(inode, key);
+	else
+		return nfs42_proc_setxattr(inode, key, buf, buflen, flags);
+}
+
+static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
+				    struct dentry *unused, struct inode *inode,
+				    const char *key, void *buf, size_t buflen)
+{
+	struct nfs_access_entry cache;
+
+	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
+		return -EOPNOTSUPP;
+
+	if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
+		if (!(cache.mask & NFS_ACCESS_XAREAD))
+			return -EACCES;
+	}
+
+	return nfs42_proc_getxattr(inode, key, buf, buflen);
+}
+
+static ssize_t
+nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
+{
+	u64 cookie;
+	bool eof;
+	int ret, size;
+	char *buf;
+	size_t buflen;
+	struct nfs_access_entry cache;
+
+	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
+		return 0;
+
+	if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
+		if (!(cache.mask & NFS_ACCESS_XALIST))
+			return 0;
+	}
+
+	cookie = 0;
+	eof = false;
+	buflen = list_len ? list_len : XATTR_LIST_MAX;
+	buf = list_len ? list : NULL;
+	size = 0;
+
+	while (!eof) {
+		ret = nfs42_proc_listxattrs(inode, buf, buflen,
+		    &cookie, &eof);
+		if (ret < 0) {
+			return ret;
+		}
+		if (list_len) {
+			buf += ret;
+			buflen -= ret;
+		}
+		size += ret;
+	}
+
+	return size;
+}
+
+#else
+
+static ssize_t
+nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
+{
+	return 0;
+}
+#endif /* CONFIG_NFS_V4_XATTR */
+
 /*
  * nfs_fhget will use either the mounted_on_fileid or the fileid
  */
@@ -9886,7 +9984,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
-	ssize_t error, error2;
+	ssize_t error, error2, error3;
 
 	error = generic_listxattr(dentry, list, size);
 	if (error < 0)
@@ -9899,7 +9997,17 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 	error2 = nfs4_listxattr_nfs4_label(d_inode(dentry), list, size);
 	if (error2 < 0)
 		return error2;
-	return error + error2;
+
+	if (list) {
+		list += error2;
+		size -= error2;
+	}
+
+	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, size);
+	if (error3 < 0)
+		return error3;
+
+	return error + error2 + error3;
 }
 
 static const struct inode_operations nfs4_dir_inode_operations = {
@@ -9987,10 +10095,21 @@ static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
 	.set	= nfs4_xattr_set_nfs4_acl,
 };
 
+#ifdef CONFIG_NFS_V4_XATTR
+static const struct xattr_handler nfs4_xattr_nfs4_user_handler = {
+	.prefix	= XATTR_USER_PREFIX,
+	.get	= nfs4_xattr_get_nfs4_user,
+	.set	= nfs4_xattr_set_nfs4_user,
+};
+#endif
+
 const struct xattr_handler *nfs4_xattr_handlers[] = {
 	&nfs4_xattr_nfs4_acl_handler,
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	&nfs4_xattr_nfs4_label_handler,
+#endif
+#ifdef CONFIG_NFS_V4_XATTR
+	&nfs4_xattr_nfs4_user_handler,
 #endif
 	NULL
 };
-- 
2.17.2

