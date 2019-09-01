Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5354EB1393
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbfILR2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:28:55 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:10141 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387608AbfILR2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309333; x=1599845333;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=YLG9LrkTcV9Bkv1mJLOSlaN8R1K5vtemYmWMhgUh+zY=;
  b=RAue6LlzPYwkUFeJppPq9ulgUTqqrOdsqfaFhyfia77Ud0DGgbTnPPcg
   GT4dbRQ++uahw+2lOpW6WQD3trLER80oO/i+oVkHUIBXoFnqyN2ohWjSn
   iF1gbzMnT2kJ003hjq8S0t3EAWbZZ4BRGIOQzCCQm7MMwoG10zofyRrLt
   U=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="784654348"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 12 Sep 2019 17:28:53 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id C512AC125A;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D06UEA001.ant.amazon.com (10.43.61.154) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D06UEA001.ant.amazon.com (10.43.61.154) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E419DC037E; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <726530112064dd8f44c8203ba91f720d2c16b4e1.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Sun, 1 Sep 2019 01:19:41 +0000
Subject: [RFC PATCH 27/35] nfsd: implement the xattr procedure functions.
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the main entry points for the *XATTR operations.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4proc.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c  |  2 ++
 2 files changed, 76 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6ade983dd9b2..db9f3fde164e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1802,6 +1802,80 @@ nfsd4_layoutreturn(struct svc_rqst *rqstp,
 }
 #endif /* CONFIG_NFSD_PNFS */
 
+#ifdef CONFIG_NFSD_V4_XATTR
+static __be32
+nfsd4_getxattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	       union nfsd4_op_u *u)
+{
+	struct nfsd4_getxattr *getxattr = &u->getxattr;
+
+	return nfsd_getxattr(rqstp, &cstate->current_fh,
+			     getxattr->getxa_name, getxattr->getxa_buf,
+			     &getxattr->getxa_len);
+}
+
+static __be32
+nfsd4_setxattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	   union nfsd4_op_u *u)
+{
+	struct nfsd4_setxattr *setxattr = &u->setxattr;
+	int ret;
+
+	if (opens_in_grace(SVC_NET(rqstp)))
+		return nfserr_grace;
+
+	ret = nfsd_setxattr(rqstp, &cstate->current_fh, setxattr->setxa_name,
+			    setxattr->setxa_buf, setxattr->setxa_len,
+			    setxattr->setxa_flags);
+
+	if (!ret)
+		set_change_info(&setxattr->setxa_cinfo, &cstate->current_fh);
+
+	return ret;
+}
+
+static __be32
+nfsd4_listxattrs(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	   union nfsd4_op_u *u)
+{
+	int ret, len;
+
+	/*
+	 * Get the entire list, then copy out only the user attributes
+	 * in the encode function. lsxa_buf was previously allocated as
+	 * tmp svc space, and will be automatically freed later.
+	 */
+	len = XATTR_LIST_MAX;
+
+	ret = nfsd_listxattr(rqstp, &cstate->current_fh, u->listxattrs.lsxa_buf,
+			     &len);
+	if (ret)
+		return ret;
+
+	u->listxattrs.lsxa_len = len;
+
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_removexattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	   union nfsd4_op_u *u)
+{
+	struct nfsd4_removexattr *removexattr = &u->removexattr;
+	int ret;
+
+	if (opens_in_grace(SVC_NET(rqstp)))
+		return nfserr_grace;
+
+	ret = nfsd_removexattr(rqstp, &cstate->current_fh,
+	    removexattr->rmxa_name);
+
+	if (!ret)
+		set_change_info(&removexattr->rmxa_cinfo, &cstate->current_fh);
+
+	return ret;
+}
+#endif
 /*
  * NULL call.
  */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 25cd597f7b4e..c921945f0df0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -40,6 +40,8 @@
 #include <linux/utsname.h>
 #include <linux/pagemap.h>
 #include <linux/sunrpc/svcauth_gss.h>
+#include <linux/xattr.h>
+#include <uapi/linux/xattr.h>
 
 #include "idmap.h"
 #include "acl.h"
-- 
2.17.2

