Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC2EB139D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbfILR26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:28:58 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:7941 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387609AbfILR2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309334; x=1599845334;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=QPUvBZ7JzV6tMB76TfMxsyNnBqRiFeDigXzq545zAoE=;
  b=qW6nu2TODBWM/aZ5iA2G7CAQO01LFgSN66PmKOp+zRZ3B9iFIz3qepVW
   5n8uPHmwRACE8kxQEgEPkJjLknr3BYhBtcwM5YrNaqhxm8zcj9+g0+Fpy
   mo1SQPfNkJKd0ETKId35yz1RKzic+Ty5qEfq80RsGVHVRcHrWIHmoQE69
   g=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="414961239"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Sep 2019 17:28:53 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id CF982A179F;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D12UWC001.ant.amazon.com (10.43.162.78) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D12UWC001.ant.amazon.com (10.43.162.78) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:52 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E6FD8C0565; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <fb951c1cfcef37751ee8ff59563de2896e332ef1.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Sat, 31 Aug 2019 23:53:14 +0000
Subject: [RFC PATCH 24/35] nfsd: define xattr functions to call in to their
 vfs counterparts
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the filehandle based functions for the xattr operations
that call in to the vfs layer to do the actual work.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/vfs.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h |  10 ++++
 2 files changed, 139 insertions(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c85783e536d5..99363e7ce044 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1990,6 +1990,135 @@ static int exp_rdonly(struct svc_rqst *rqstp, struct svc_export *exp)
 	return nfsexp_flags(rqstp, exp) & NFSEXP_READONLY;
 }
 
+#ifdef CONFIG_NFSD_V4_XATTR
+/*
+ * Helper function to translate error numbers. In the case of xattr operations,
+ * some error codes need to be translated outside of the standard translations.
+ *
+ * ENODATA needs to be translated to nfserr_noxattr.
+ * E2BIG to nfserr_xattr2big.
+ *
+ * Additionally, vfs_listxattr can return -ERANGE. This means that the
+ * file has too many extended attributes to retrieve inside an
+ * XATTR_LIST_MAX sized buffer. This is a bug in the xattr implementation:
+ * filesystems will allow the adding of extended attributes until they hit
+ * their own internal limit. This limit may be larger than XATTR_LIST_MAX.
+ * So, at that point, the attributes are present and valid, but can't
+ * be retrieved using listxattr, since the upper level xattr code enforces
+ * the XATTR_LIST_MAX limit.
+ *
+ * This bug means that we need to deal with listxattr returning -ERANGE. The
+ * best mapping is to return TOOSMALL.
+ */
+static __be32
+nfsd_xattr_errno(int err)
+{
+	switch (err) {
+	case -ENODATA:
+		return nfserr_noxattr;
+	case -E2BIG:
+		return nfserr_xattr2big;
+	case -ERANGE:
+		return nfserr_toosmall;
+	}
+	return nfserrno(err);
+}
+
+__be32
+nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name, void *buf, int *lenp)
+{
+	ssize_t lerr;
+	int err;
+
+	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_READ);
+	if (err)
+		return err;
+
+	lerr = vfs_getxattr(fhp->fh_dentry, name, buf, *lenp);
+	if (lerr < 0)
+		err = nfsd_xattr_errno(lerr);
+	else
+		*lenp = lerr;
+
+	return err;
+}
+
+__be32
+nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, void *buf, int *lenp)
+{
+	ssize_t lerr;
+	int err;
+
+	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_READ);
+	if (err)
+		return err;
+
+	lerr = vfs_listxattr(fhp->fh_dentry, buf, *lenp);
+
+	if (lerr < 0)
+		err = nfsd_xattr_errno(lerr);
+	else
+		*lenp = lerr;
+
+	return err;
+}
+
+/*
+ * Removexattr and setxattr need to call fh_lock to both lock the inode
+ * and set the change attribute. Since the top-level vfs_removexattr
+ * and vfs_setxattr calls already do their own inode_lock calls, call
+ * the _locked variant. Pass in a NULL pointer for delegated_inode,
+ * and let the client deal with NFS4ERR_DELAY (same as with e.g.
+ * setattr and remove).
+ */
+__be32
+nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
+{
+	int err, ret;
+
+	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_WRITE);
+	if (err)
+		return err;
+
+	ret = fh_want_write(fhp);
+	if (ret)
+		return nfserrno(ret);
+
+	fh_lock(fhp);
+
+	ret = __vfs_removexattr_locked(fhp->fh_dentry, name, NULL);
+
+	fh_unlock(fhp);
+	fh_drop_write(fhp);
+
+	return nfsd_xattr_errno(ret);
+}
+
+__be32
+nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
+	      void *buf, u32 len, u32 flags)
+{
+	int err, ret;
+
+	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_WRITE);
+	if (err)
+		return err;
+
+	ret = fh_want_write(fhp);
+	if (ret)
+		return nfserrno(ret);
+	fh_lock(fhp);
+
+	ret = __vfs_setxattr_locked(fhp->fh_dentry, name, buf, len, flags,
+				    NULL);
+
+	fh_unlock(fhp);
+	fh_drop_write(fhp);
+
+	return nfsd_xattr_errno(ret);
+}
+#endif
+
 /*
  * Check for a user's access permissions to this inode.
  */
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index db351247892d..ef4e6eaf9c78 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -75,6 +75,16 @@ __be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
 				loff_t, unsigned long);
 #endif /* CONFIG_NFSD_V3 */
+#ifdef CONFIG_NFSD_V4_XATTR
+__be32         nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+			     char *name, void *buf, int *lenp);
+__be32         nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+			      void *buf, int *lenp);
+__be32         nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+				char *name);
+__be32         nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+			     char *name, void *buf, u32 len, u32 flags);
+#endif
 __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
 struct raparms;
-- 
2.17.2

