Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 445A6B13AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbfILR3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:08 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2868 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbfILR3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309347; x=1599845347;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=JPrJloghTz0psyuIOLhm/qvf4ymtHQcLhqh0B7GkyL8=;
  b=coCnlgOFfuD2OFnrS0LajeMV2UTR6MVx83vx7t87ljnsGlqhkL/PrJ5+
   YC6IXI0BJgbBY0XhK4T00sWksR32Ei9yL4I5yL7dYtXUMy1Ch8b7BbCVk
   zZkMio7ZTujqYNCT7eLclhzVoRqIMW7Ko9mk3H3jwg6gOXxJaWabqCcAl
   E=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="702191772"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Sep 2019 17:28:57 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 6EF94A223C;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D06UWC002.ant.amazon.com (10.43.162.205) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D06UWC002.ant.amazon.com (10.43.162.205) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E47B0C0563; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <5b49cb855ec94a477bad4730f936931af353e31d.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Sat, 31 Aug 2019 19:19:00 +0000
Subject: [RFC PATCH 23/35] nfsd: add defines for NFSv4.2 extended attribute
 support
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add defines for server-side extended attribute support. Most have
already been added as part of client support, but these are
the network order error codes for the noxattr and xattr2big errors,
and the addition of the xattr support to the supported file
attributes (if configured).

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfsd.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index af2947551e9c..7e2a2f4dcb24 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -280,7 +280,9 @@ void		nfsd_lockd_shutdown(void);
 #define nfserr_union_notsupp		cpu_to_be32(NFS4ERR_UNION_NOTSUPP)
 #define nfserr_offload_denied		cpu_to_be32(NFS4ERR_OFFLOAD_DENIED)
 #define nfserr_wrong_lfs		cpu_to_be32(NFS4ERR_WRONG_LFS)
-#define nfserr_badlabel		cpu_to_be32(NFS4ERR_BADLABEL)
+#define nfserr_badlabel			cpu_to_be32(NFS4ERR_BADLABEL)
+#define nfserr_xattr2big		cpu_to_be32(NFS4ERR_XATTR2BIG)
+#define nfserr_noxattr			cpu_to_be32(NFS4ERR_NOXATTR)
 
 /* error codes for internal use */
 /* if a request fails due to kmalloc failure, it gets dropped.
@@ -378,11 +380,18 @@ void		nfsd_lockd_shutdown(void);
 #define NFSD4_2_SECURITY_ATTRS		0
 #endif
 
+#ifdef CONFIG_NFSD_V4_XATTR
+#define NFSD4_2_XATTR			FATTR4_WORD2_XATTR_SUPPORT
+#else
+#define NFSD4_2_XATTR			0
+#endif
+
 #define NFSD4_2_SUPPORTED_ATTRS_WORD2 \
 	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
 	FATTR4_WORD2_CHANGE_ATTR_TYPE | \
 	FATTR4_WORD2_MODE_UMASK | \
-	NFSD4_2_SECURITY_ATTRS)
+	NFSD4_2_SECURITY_ATTRS | \
+	NFSD4_2_XATTR)
 
 extern const u32 nfsd_suppattrs[3][3];
 
-- 
2.17.2

