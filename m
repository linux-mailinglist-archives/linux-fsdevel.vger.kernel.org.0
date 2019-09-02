Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05D7B13F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfILRqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:46:01 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27379 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfILRp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568310357; x=1599846357;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=mIfku6Drsc6ueHCyqdfnVWjm3DY4RS59WD5oOuIo6qc=;
  b=fAIB0pLVBl566D/R18hihoj3RmH8OWwEyOyuHHuWppcJogKgeXBBDN32
   CKv6QrVRZXxrj8lkteJ8Gl6WS3Yi4ssjceVfqyMlYiRsV3+qG4yCMb8iy
   Lu6sO1YEZbPyA2n2ZTonEVRu0W59bNb1m6HGSMIhvjuxZq0ujSz+c3fB2
   4=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="831156452"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Sep 2019 17:28:54 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id 42B13141C76;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D07UWB001.ant.amazon.com (10.43.161.238) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D07UWB001.ant.amazon.com (10.43.161.238) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:52 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E7ED0C0522; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <c66bc3c8b4ac4ed35e4789976f3c2b9d1b187a74.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 2 Sep 2019 21:30:23 +0000
Subject: [RFC PATCH 33/35] nfsd: add fattr support for user extended
 attributes
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Check if user extended attributes are supported for an inode,
and return the answer when being queried for file attributes.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4xdr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index be57dc09a468..92b9a067c744 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3149,6 +3149,17 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	}
 #endif
 
+#ifdef CONFIG_NFSD_V4_XATTR
+	if (bmval2 & FATTR4_WORD2_XATTR_SUPPORT) {
+		p = xdr_reserve_space(xdr, 4);
+		if (!p)
+			goto out_resource;
+		err = xattr_supported_namespace(d_inode(dentry),
+						XATTR_USER_PREFIX);
+		*p++ = cpu_to_be32(err == 0);
+	}
+#endif
+
 	attrlen = htonl(xdr->buf->len - attrlen_offset - 4);
 	write_bytes_to_xdr_buf(xdr->buf, attrlen_offset, &attrlen, 4);
 	status = nfs_ok;
-- 
2.17.2

