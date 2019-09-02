Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C867B13AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbfILR3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:10 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2868 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387645AbfILR3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309348; x=1599845348;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=4Kq2cc1aLZizNrBly3qQl/WIlwejY+2o+OBDITVYIcc=;
  b=DdeguOC1xAYhVHPKbQA1c8QM1MYHNLhQ0MtBasWkQTrlnOYlA2gYnZKA
   I8YnlD4Q5WF/qzyQn3RFpMP/k8ft+9d7Y9bMawn6qXtFYaBSqM3kD2MZK
   qcjd34lnuz4D8l/aZO24lLyDFcT0lx2TTPONDqMR47HseD0cPo1v+Fqyn
   o=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="702191773"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Sep 2019 17:28:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 4B546244CE6;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D03UEA001.ant.amazon.com (10.43.61.200) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D03UEA001.ant.amazon.com (10.43.61.200) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E3059C051F; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <78ebac8806c7a8753c629fddb5dfa7340f8325a2.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 2 Sep 2019 23:06:35 +0000
Subject: [RFC PATCH 34/35] nfsd: add export flag to disable user extended
 attributes
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like with some other features, add a flag that allows a filesystem
to be exported without extended user attribute support, even if
support is compiled in.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/export.c                 |  1 +
 fs/nfsd/nfs4xdr.c                |  7 +++++--
 fs/nfsd/vfs.c                    | 12 ++++++++++++
 include/uapi/linux/nfsd/export.h |  3 ++-
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index baa01956a5b3..4e363272f757 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1105,6 +1105,7 @@ static struct flags {
 	{ NFSEXP_V4ROOT, {"v4root", ""}},
 	{ NFSEXP_PNFS, {"pnfs", ""}},
 	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
+	{ NFSEXP_NOUSERXATTR, {"no_userxattr", ""}},
 	{ 0, {"", ""}}
 };
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 92b9a067c744..4ed0fb023ee1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3154,8 +3154,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 4);
 		if (!p)
 			goto out_resource;
-		err = xattr_supported_namespace(d_inode(dentry),
-						XATTR_USER_PREFIX);
+		if (exp->ex_flags & NFSEXP_NOUSERXATTR)
+			err = -EOPNOTSUPP;
+		else
+			err = xattr_supported_namespace(d_inode(dentry),
+							XATTR_USER_PREFIX);
 		*p++ = cpu_to_be32(err == 0);
 	}
 #endif
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d76e3041fa8e..97a40dbd53a7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2046,6 +2046,9 @@ nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name, void *buf,
 	if (err)
 		return err;
 
+	if (fhp->fh_export->ex_flags & NFSEXP_NOUSERXATTR)
+		return nfserr_opnotsupp;
+
 	lerr = vfs_getxattr(fhp->fh_dentry, name, buf, *lenp);
 	if (lerr < 0)
 		err = nfsd_xattr_errno(lerr);
@@ -2065,6 +2068,9 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, void *buf, int *lenp)
 	if (err)
 		return err;
 
+	if (fhp->fh_export->ex_flags & NFSEXP_NOUSERXATTR)
+		return nfserr_opnotsupp;
+
 	lerr = vfs_listxattr(fhp->fh_dentry, buf, *lenp);
 
 	if (lerr < 0)
@@ -2092,6 +2098,9 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
 	if (err)
 		return err;
 
+	if (fhp->fh_export->ex_flags & NFSEXP_NOUSERXATTR)
+		return nfserr_opnotsupp;
+
 	ret = fh_want_write(fhp);
 	if (ret)
 		return nfserrno(ret);
@@ -2116,6 +2125,9 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 	if (err)
 		return err;
 
+	if (fhp->fh_export->ex_flags & NFSEXP_NOUSERXATTR)
+		return nfserr_opnotsupp;
+
 	ret = fh_want_write(fhp);
 	if (ret)
 		return nfserrno(ret);
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index 2124ba904779..b46ee0240fca 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -53,9 +53,10 @@
  */
 #define	NFSEXP_V4ROOT		0x10000
 #define NFSEXP_PNFS		0x20000
+#define NFSEXP_NOUSERXATTR	0x40000
 
 /* All flags that we claim to support.  (Note we don't support NOACL.) */
-#define NFSEXP_ALLFLAGS		0x3FEFF
+#define NFSEXP_ALLFLAGS		0x7FEFF
 
 /* The flags that may vary depending on security flavor: */
 #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
-- 
2.17.2

