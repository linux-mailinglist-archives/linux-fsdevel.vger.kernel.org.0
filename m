Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36FEB13E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfILRp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:45:57 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27366 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfILRp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568310355; x=1599846355;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=vsUBs5qe6HwJFRS/CGE+L552O5IV2hS0/ulpsqSWsGM=;
  b=hs7jSDf8NAh3Jotn6RfPuk/TL05rJzX+0ir9aBH/IuVYBDZC8L6Wb+Bu
   /f1A+ieliqSvwumPEIyIcSG+LP4WneS0hV3VRclOjutTkPhCCJPncg13/
   c/0NXtIRE0dZG12IIuxIevEsmehY9Vbcryk+dkwO740jDi0dkIwKDf30W
   8=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="831156433"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 0116BA2229;
        Thu, 12 Sep 2019 17:28:51 +0000 (UTC)
Received: from EX13D30UWC003.ant.amazon.com (10.43.162.122) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D30UWC003.ant.amazon.com (10.43.162.122) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E2A70C0572; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <0efb6bf8860988c979c1bc0003d450494c61836e.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Sat, 31 Aug 2019 21:35:55 +0000
Subject: [RFC PATCH 26/35] nfsd: add structure definitions for xattr requests
 / responses
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the structures used in extended attribute request / response handling.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/xdr4.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index d64c870f998a..46df94ab2488 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -223,6 +223,32 @@ struct nfsd4_putfh {
 	char		*pf_fhval;          /* request */
 };
 
+struct nfsd4_getxattr {
+	char		*getxa_name;		/* request */
+	u32		getxa_len;		/* request */
+	void		*getxa_buf;
+};
+
+struct nfsd4_setxattr {
+	u32		setxa_flags;		/* request */
+	char		*setxa_name;		/* request */
+	char		*setxa_buf;		/* request */
+	u32		setxa_len;		/* request */
+	struct nfsd4_change_info  setxa_cinfo;	/* response */
+};
+
+struct nfsd4_removexattr {
+	char *		rmxa_name;		/* request */
+	struct nfsd4_change_info  rmxa_cinfo;	/* response */
+};
+
+struct nfsd4_listxattrs {
+	u64		lsxa_cookie;		/* request */
+	u32		lsxa_maxcount;		/* request */
+	char 		*lsxa_buf;		/* unfiltered buffer (reply) */
+	u32		lsxa_len;		/* unfiltered len (reply) */
+};
+
 struct nfsd4_open {
 	u32		op_claim_type;      /* request */
 	struct xdr_netobj op_fname;	    /* request - everything but CLAIM_PREV */
@@ -629,6 +655,11 @@ struct nfsd4_op {
 		struct nfsd4_copy		copy;
 		struct nfsd4_offload_status	offload_status;
 		struct nfsd4_seek		seek;
+
+		struct nfsd4_getxattr		getxattr;
+		struct nfsd4_setxattr		setxattr;
+		struct nfsd4_listxattrs		listxattrs;
+		struct nfsd4_removexattr	removexattr;
 	} u;
 	struct nfs4_replay *			replay;
 };
-- 
2.17.2

