Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056ECB13E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfILRp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:45:58 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27366 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfILRp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568310357; x=1599846357;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=EqgMIYSw45qnvd23RSpRyLFR7a7OLht13AVPQ632evo=;
  b=e6C8OWIT8fD3LDev0fDU9LaeyOf15HCKOcuyjUlKVD8YLr3jv1Bf8HQM
   gf81hGN8BnaPdRFXEgpzV4PqGNFozJ7O3nD26X7Tj//yHauOtl5GYjntF
   fxRM+JOUEQ7M+GJijz6aGKu/+urHgVCEC6PNPIsikRN6Cv7feH5xoK7hT
   E=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="831156456"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Sep 2019 17:28:54 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id A238BA1E0A;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D28UWB003.ant.amazon.com (10.43.161.60) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D28UWB003.ant.amazon.com (10.43.161.60) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E3DF1C0554; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <8aa8c57639116b233cb50f7c9cc514bd96afa77c.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Sun, 1 Sep 2019 02:46:56 +0000
Subject: [RFC PATCH 01/35] nfsd: make sure the nfsd4_ops array has the right
 size
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The nfsd4_ops was initialized by initializing individual indices (op
numbers). So, the size of the array was determined by the largest
op number.

Some operations are enabled conditionally, based on config options.
If a conditionally enabled operation were to be the highest numbered
operation, the code (through OPDESC) would attempt to access memory
beyond the end of the array. This currently can't happen, since the
highest numbered op is not conditional, but will happen once the
XATTR operations are added.

So, always size the array with LAST_NFS4_OP + 1.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8beda999e134..6fc960677644 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2344,7 +2344,7 @@ static inline u32 nfsd4_seek_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 	return (op_encode_hdr_size + 3) * sizeof(__be32);
 }
 
-static const struct nfsd4_operation nfsd4_ops[] = {
+static const struct nfsd4_operation nfsd4_ops[LAST_NFS4_OP + 1] = {
 	[OP_ACCESS] = {
 		.op_func = nfsd4_access,
 		.op_name = "OP_ACCESS",
-- 
2.17.2

