Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63276B1399
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbfILR2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:28:53 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44567 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbfILR2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309332; x=1599845332;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=h7J2uw9Ut0Icf/XeWVsnv5/0niF/+yNuDvFrdNwUNvI=;
  b=AhEPHZsX3T9pk3EfX9fY4q815PHYQenZ1eQ9frqibeH6kIHsYe4oulHD
   caYklL6r5Em/dbj6JJhmrnBuSkeZV8Dk1oa+YGRjolgYGqos7ZhH4eH3F
   PSdJ1caGuzoMF+qE9fEx07mN5VoKI/HEiyOy1wLc6NKEXfMavU9UuQWGw
   U=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="750440654"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 4E66FA1E72;
        Thu, 12 Sep 2019 17:28:51 +0000 (UTC)
Received: from EX13D11UEB004.ant.amazon.com (10.43.60.132) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.96) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:50 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D11UEB004.ant.amazon.com (10.43.60.132) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:50 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:50 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E0DB5C011C; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <3856e70da4d1742b77e6d26987618c58ec4acef5.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Sun, 1 Sep 2019 00:13:54 +0000
Subject: [RFC PATCH 25/35] nfsd: take xattr access bits in to account when
 checking
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the NFSv4.2 extended attributes extension defines 3 new access
bits for xattr operations, take them in to account when validating
what the client is asking for, and when checking permissions.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4proc.c | 10 +++++++++-
 fs/nfsd/vfs.c      | 12 ++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6fc960677644..6ade983dd9b2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -557,8 +557,16 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
 	struct nfsd4_access *access = &u->access;
+	u32 access_full;
 
-	if (access->ac_req_access & ~NFS3_ACCESS_FULL)
+	access_full = NFS3_ACCESS_FULL;
+#ifdef CONFIG_NFSD_V4_XATTR
+	if (cstate->minorversion >= 2)
+		access_full |= NFS4_ACCESS_XALIST | NFS4_ACCESS_XAREAD |
+			       NFS4_ACCESS_XAWRITE;
+#endif
+
+	if (access->ac_req_access & ~access_full)
 		return nfserr_inval;
 
 	access->ac_resp_access = access->ac_req_access;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 99363e7ce044..d76e3041fa8e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -611,6 +611,12 @@ static struct accessmap	nfs3_regaccess[] = {
     {	NFS3_ACCESS_MODIFY,	NFSD_MAY_WRITE|NFSD_MAY_TRUNC	},
     {	NFS3_ACCESS_EXTEND,	NFSD_MAY_WRITE			},
 
+#ifdef CONFIG_NFSD_V4_XATTR
+    {	NFS4_ACCESS_XAREAD,	NFSD_MAY_READ			},
+    {	NFS4_ACCESS_XAWRITE,	NFSD_MAY_WRITE			},
+    {	NFS4_ACCESS_XALIST,	NFSD_MAY_READ			},
+#endif
+
     {	0,			0				}
 };
 
@@ -621,6 +627,12 @@ static struct accessmap	nfs3_diraccess[] = {
     {	NFS3_ACCESS_EXTEND,	NFSD_MAY_EXEC|NFSD_MAY_WRITE	},
     {	NFS3_ACCESS_DELETE,	NFSD_MAY_REMOVE			},
 
+#ifdef CONFIG_NFSD_V4_XATTR
+    {	NFS4_ACCESS_XAREAD,	NFSD_MAY_READ			},
+    {	NFS4_ACCESS_XAWRITE,	NFSD_MAY_WRITE			},
+    {	NFS4_ACCESS_XALIST,	NFSD_MAY_READ			},
+#endif
+
     {	0,			0				}
 };
 
-- 
2.17.2

