Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE05EB1391
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbfILR2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:28:55 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44567 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbfILR2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309333; x=1599845333;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=AGAO4q+sahYkfsrmsJLVcWrv5VJxiw7TVhVh6xK5AXY=;
  b=beHXutplI5rDNUk7DBJ6SuCpd1q4irB1Sz9bjzXsQApnUpwVx3TtKhv3
   T2P6K6ukB+5A4KatdMSqgvAIIX6ly0+Od8Uy6oOIuFFgc5U47y0sChGEh
   EqYuYj182FOfCvJvIeY4fZViscM+dPb7lTGRpbDxewCMXl/uJ7y6CzEs8
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="750440659"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id E9216A23A6;
        Thu, 12 Sep 2019 17:28:51 +0000 (UTC)
Received: from EX13D01UEB002.ant.amazon.com (10.43.60.219) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.96) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D01UEB002.ant.amazon.com (10.43.60.219) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E1935C053D; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <11fbf78833638e57b76950a74998b0c489fb3020.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Sat, 31 Aug 2019 19:00:31 +0000
Subject: [RFC PATCH 22/35] nfsd: split off the write decode code in to a
 seperate function
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

nfs4_decode_write has code to parse incoming XDR write data in to
a kvec head, and a list of pages.

Put this code in to a seperate function, so that it can be used
later by the xattr code, for setxattr. No functional change.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4xdr.c | 72 +++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f2090f7fed42..25cd597f7b4e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -248,6 +248,44 @@ svcxdr_dupstr(struct nfsd4_compoundargs *argp, void *buf, u32 len)
 	return p;
 }
 
+static __be32
+svcxdr_construct_vector(struct nfsd4_compoundargs *argp, struct kvec *head,
+                       struct page ***pagelist, u32 buflen)
+{
+	int avail;
+	int len;
+	int pages;
+
+	/* Sorry .. no magic macros for this.. *
+	 * READ_BUF(write->wr_buflen);
+	 * SAVEMEM(write->wr_buf, write->wr_buflen);
+	 */
+	avail = (char*)argp->end - (char*)argp->p;
+	if (avail + argp->pagelen < buflen) {
+		dprintk("NFSD: xdr error (%s:%d)\n",
+			       __FILE__, __LINE__);
+		return nfserr_bad_xdr;
+	}
+	head->iov_base = argp->p;
+	head->iov_len = avail;
+	*pagelist = argp->pagelist;
+
+	len = XDR_QUADLEN(buflen) << 2;
+	if (len >= avail) {
+	       len -= avail;
+
+	       pages = len >> PAGE_SHIFT;
+	       argp->pagelist += pages;
+	       argp->pagelen -= pages * PAGE_SIZE;
+	       len -= pages * PAGE_SIZE;
+
+	       next_decode_page(argp);
+	}
+	argp->p += XDR_QUADLEN(len);
+
+	return 0;
+}
+
 /**
  * savemem - duplicate a chunk of memory for later processing
  * @argp: NFSv4 compound argument structure to be freed with
@@ -1251,8 +1289,6 @@ nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify
 static __be32
 nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 {
-	int avail;
-	int len;
 	DECODE_HEAD;
 
 	status = nfsd4_decode_stateid(argp, &write->wr_stateid);
@@ -1265,34 +1301,10 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 		goto xdr_error;
 	write->wr_buflen = be32_to_cpup(p++);
 
-	/* Sorry .. no magic macros for this.. *
-	 * READ_BUF(write->wr_buflen);
-	 * SAVEMEM(write->wr_buf, write->wr_buflen);
-	 */
-	avail = (char*)argp->end - (char*)argp->p;
-	if (avail + argp->pagelen < write->wr_buflen) {
-		dprintk("NFSD: xdr error (%s:%d)\n",
-				__FILE__, __LINE__);
-		goto xdr_error;
-	}
-	write->wr_head.iov_base = p;
-	write->wr_head.iov_len = avail;
-	write->wr_pagelist = argp->pagelist;
-
-	len = XDR_QUADLEN(write->wr_buflen) << 2;
-	if (len >= avail) {
-		int pages;
-
-		len -= avail;
-
-		pages = len >> PAGE_SHIFT;
-		argp->pagelist += pages;
-		argp->pagelen -= pages * PAGE_SIZE;
-		len -= pages * PAGE_SIZE;
-
-		next_decode_page(argp);
-	}
-	argp->p += XDR_QUADLEN(len);
+	status = svcxdr_construct_vector(argp, &write->wr_head,
+					 &write->wr_pagelist, write->wr_buflen);
+	if (status)
+		return status;
 
 	DECODE_TAIL;
 }
-- 
2.17.2

