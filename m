Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1FD2B13EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfILRp7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:45:59 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27357 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfILRp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568310357; x=1599846357;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=sVBoY42LcU+cF4RJ3NERXhAz7lLu9lNEpAKtGukjVKA=;
  b=h0laEV5APwo+IP3nb8lYWBL51obn3LxPUVqEdPk1cxaqVsQueymM0k4+
   R/p08PHtWC7GPDElY/q/WPbO4YmkBT40s5+FdXO4v4Mmh2Pffj1beyh/U
   tRfK8MaH58n6MdmT+LnoaGScEXUqWFJYENUKTJbif2ySC3onHu1nuo4DI
   8=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="831156453"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Sep 2019 17:28:54 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id C950CA25E7;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D32UWB001.ant.amazon.com (10.43.161.248) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D32UWB001.ant.amazon.com (10.43.161.248) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E4F19C051D; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <3d67fbe081f502a12215d3cb807df1d716b7b1bc.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 2 Sep 2019 20:19:20 +0000
Subject: [RFC PATCH 31/35] nfsd: add xattr operations to ops array
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With all underlying code implemented, let's add the user extended
attributes operations to nfsd4_ops.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4proc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 89cc5f7fceac..27f7be739c99 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2835,6 +2835,31 @@ static const struct nfsd4_operation nfsd4_ops[LAST_NFS4_OP + 1] = {
 		.op_name = "OP_OFFLOAD_CANCEL",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
+
+#ifdef CONFIG_NFSD_V4_XATTR
+	[OP_GETXATTR] = {
+		.op_func = nfsd4_getxattr,
+		.op_name = "OP_GETXATTR",
+		.op_rsize_bop = nfsd4_getxattr_rsize,
+	},
+	[OP_SETXATTR] = {
+		.op_func = nfsd4_setxattr,
+		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
+		.op_name = "OP_SETXATTR",
+		.op_rsize_bop = nfsd4_setxattr_rsize,
+	},
+	[OP_LISTXATTRS] = {
+		.op_func = nfsd4_listxattrs,
+		.op_name = "OP_LISTXATTRS",
+		.op_rsize_bop = nfsd4_listxattrs_rsize,
+	},
+	[OP_REMOVEXATTR] = {
+		.op_func = nfsd4_removexattr,
+		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
+		.op_name = "OP_REMOVEXATTR",
+		.op_rsize_bop = nfsd4_removexattr_rsize,
+	},
+#endif
 };
 
 /**
-- 
2.17.2

