Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA38B13AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbfILR3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:09 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:6371 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbfILR3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309348; x=1599845348;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=oTbv3dJjarXMQuNPh8MeEh/YF+oXxjl4UMVtnFmqS/E=;
  b=X/riSZR1+P5lFaEDcTjIyQZUYuJm39V699/Tf8NzcImr1G2XQk1gKHcI
   lncBLzuZdsGF1GxB9cS241C7HALDlRNeRB/yHwEMlL6buowFjV00Dar4K
   jmoHEJ0z3EXmeakXcUtpnE9uHjCexX9Q79bKHrub6quWHgVhiGDL3TAce
   w=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="702191769"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Sep 2019 17:28:56 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id CB79AA2A95;
        Thu, 12 Sep 2019 17:28:51 +0000 (UTC)
Received: from EX13D12UEA003.ant.amazon.com (10.43.61.184) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D12UEA003.ant.amazon.com (10.43.61.184) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:50 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E13A8C053E; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <018d01382de6339edc925a9071a8bab21ef93830.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 26 Aug 2019 22:44:17 +0000
Subject: [RFC PATCH 08/35] NFSv4.2: define the encode/decode sizes for the
 XATTR operations
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define the maximum XDR sizes for the RFC 8276 XATTR operations.
In the case of operations that carry a larger payload (SETXATTR,
GETXATTR, LISTXATTR), these exclude that payload, which is added
as seperate pages, like other operations do.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs42xdr.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index aed865a84629..d7657be74557 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -150,6 +150,57 @@
 					 decode_clone_maxsz + \
 					 decode_getattr_maxsz)
 
+#ifdef CONFIG_NFS_V4_XATTR
+/* Not limited by NFS itself, limited by the generic xattr code */
+#define nfs4_xattr_name_maxsz   XDR_QUADLEN(XATTR_NAME_MAX)
+
+#define encode_getxattr_maxsz   (op_encode_hdr_maxsz + 1 + \
+				 nfs4_xattr_name_maxsz)
+#define decode_getxattr_maxsz   (op_decode_hdr_maxsz + 1 + 1)
+#define encode_setxattr_maxsz   (op_encode_hdr_maxsz + \
+				 1 + nfs4_xattr_name_maxsz + 1)
+#define decode_setxattr_maxsz   (op_decode_hdr_maxsz + decode_change_info_maxsz)
+#define encode_listxattrs_maxsz  (op_encode_hdr_maxsz + 2 + 1)
+#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1)
+#define encode_removexattr_maxsz (op_encode_hdr_maxsz + 1 + \
+				  nfs4_xattr_name_maxsz)
+#define decode_removexattr_maxsz (op_decode_hdr_maxsz + \
+				  decode_change_info_maxsz)
+
+#define NFS4_enc_getxattr_sz	(compound_encode_hdr_maxsz + \
+				encode_sequence_maxsz + \
+				encode_putfh_maxsz + \
+				encode_getxattr_maxsz)
+#define NFS4_dec_getxattr_sz	(compound_decode_hdr_maxsz + \
+				decode_sequence_maxsz + \
+				decode_putfh_maxsz + \
+				decode_getxattr_maxsz)
+#define NFS4_enc_setxattr_sz	(compound_encode_hdr_maxsz + \
+				encode_sequence_maxsz + \
+				encode_putfh_maxsz + \
+				encode_setxattr_maxsz)
+#define NFS4_dec_setxattr_sz	(compound_decode_hdr_maxsz + \
+				decode_sequence_maxsz + \
+				decode_putfh_maxsz + \
+				decode_setxattr_maxsz)
+#define NFS4_enc_listxattrs_sz	(compound_encode_hdr_maxsz + \
+				encode_sequence_maxsz + \
+				encode_putfh_maxsz + \
+				encode_listxattrs_maxsz)
+#define NFS4_dec_listxattrs_sz	(compound_decode_hdr_maxsz + \
+				decode_sequence_maxsz + \
+				decode_putfh_maxsz + \
+				decode_listxattrs_maxsz)
+#define NFS4_enc_removexattr_sz	(compound_encode_hdr_maxsz + \
+				encode_sequence_maxsz + \
+				encode_putfh_maxsz + \
+				encode_removexattr_maxsz)
+#define NFS4_dec_removexattr_sz	(compound_decode_hdr_maxsz + \
+				decode_sequence_maxsz + \
+				decode_putfh_maxsz + \
+				decode_removexattr_maxsz)
+#endif
+
 static void encode_fallocate(struct xdr_stream *xdr,
 			     const struct nfs42_falloc_args *args)
 {
-- 
2.17.2

