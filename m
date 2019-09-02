Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 327D0B13BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbfILR3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:14 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:8060 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387660AbfILR3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309351; x=1599845351;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=fkVx2K4D/eERL+71XF4AhOrM0FQVMETuKGzom4086JQ=;
  b=uNct7adtPDvb90CkU/MSVkJCQRLxcOPoinr4SDHR4Af0akCsQ1aI8bDD
   s8KUJsLK0a5Axuns/MJTUIali9Owxm99l/eqbzEOqA2gnp4bK6XexUuM+
   bjzU+jwPrPAaZH5MkjAuN+NEMsxP81Gd8Lv5ZlYSeAuAWSmSVciXCPyP0
   w=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="414961355"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Sep 2019 17:29:10 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 6006DA34E7;
        Thu, 12 Sep 2019 17:29:10 +0000 (UTC)
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:52 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E569FC051E; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <a062bcf5693a8aeeaf6b9e9b2dca0b0f74adb22a.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 2 Sep 2019 19:40:42 +0000
Subject: [RFC PATCH 28/35] nfsd: define xattr reply size functions
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add functions to calculate the reply size for the user extended attribute
operations.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4proc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index db9f3fde164e..89cc5f7fceac 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2426,6 +2426,40 @@ static inline u32 nfsd4_seek_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 	return (op_encode_hdr_size + 3) * sizeof(__be32);
 }
 
+#ifdef CONFIG_NFSD_V4_XATTR
+static inline u32 nfsd4_getxattr_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+{
+	u32 maxcount, rlen;
+
+	maxcount = svc_max_payload(rqstp);
+	rlen = min_t(u32, XATTR_SIZE_MAX, maxcount);
+
+	return (op_encode_hdr_size + 1 + XDR_QUADLEN(rlen)) * sizeof(__be32);
+}
+
+static inline u32 nfsd4_setxattr_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+{
+	return (op_encode_hdr_size + op_encode_change_info_maxsz)
+		* sizeof(__be32);
+}
+static inline u32 nfsd4_listxattrs_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+{
+	u32 maxcount, rlen;
+
+	maxcount = svc_max_payload(rqstp);
+	rlen = min(op->u.listxattrs.lsxa_maxcount, maxcount);
+
+	return (op_encode_hdr_size + 4 + XDR_QUADLEN(rlen)) * sizeof(__be32);
+}
+
+static inline u32 nfsd4_removexattr_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+{
+	return (op_encode_hdr_size + op_encode_change_info_maxsz)
+		* sizeof(__be32);
+}
+#endif
+
+
 static const struct nfsd4_operation nfsd4_ops[LAST_NFS4_OP + 1] = {
 	[OP_ACCESS] = {
 		.op_func = nfsd4_access,
-- 
2.17.2

