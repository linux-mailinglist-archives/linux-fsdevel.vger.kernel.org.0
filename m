Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53939B13B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbfILR3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:13 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2868 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbfILR3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309350; x=1599845350;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=Ew39LdvWu7jGojy6HuYqJR3Sb4scMbXC/rPTCjgYoMI=;
  b=MBxdy4m+JZ26JVRVnb5x6QgPvhK6H1lFWdZWZnZWUUvnx1AjD3cD0+0F
   2ZN364n/XFJEhOsOg/Doo5HeOk+fDl7Nmt++NEDCeBkkKuhhJyaPO+Hk+
   2vQMtnPfNfXqJBs1L5PTg1HvWJ3RmJtennZ8bYEOCsNEONzX6nZlDrM+/
   U=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="702191780"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Sep 2019 17:28:58 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 2C346A20F6;
        Thu, 12 Sep 2019 17:28:53 +0000 (UTC)
Received: from EX13D04UEB001.ant.amazon.com (10.43.60.125) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.129) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D04UEB001.ant.amazon.com (10.43.60.125) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:52 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E6940C0571; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <ada9fde50c51a81f3a5473b7d0f1c3921932d2c8.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 1 Jul 2019 17:56:01 +0000
Subject: [RFC PATCH 02/35] nfs/nfsd: basic NFS4 extended attribute definitions
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add definitions for the new operations, errors and flag as defined
in RFC 8276 (File System Extended Attributes in NFSv4).

Since this increments LAST_NFS4_OP/LAST_NFS42_OP, the nfsd code
now "knows" about this op, so add enotsup decode entry points.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4xdr.c         |  6 ++++++
 include/linux/nfs4.h      | 27 ++++++++++++++++++++++++++-
 include/linux/nfs_fs.h    |  3 +++
 include/uapi/linux/nfs4.h |  3 +++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 442811809f3d..f2090f7fed42 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1875,6 +1875,12 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_SEEK]		= (nfsd4_dec)nfsd4_decode_seek,
 	[OP_WRITE_SAME]		= (nfsd4_dec)nfsd4_decode_notsupp,
 	[OP_CLONE]		= (nfsd4_dec)nfsd4_decode_clone,
+
+        /* Placeholders for RFC 8276 extended atributes operations */
+        [OP_GETXATTR]           = (nfsd4_dec)nfsd4_decode_notsupp,
+        [OP_SETXATTR]           = (nfsd4_dec)nfsd4_decode_notsupp,
+        [OP_LISTXATTRS]         = (nfsd4_dec)nfsd4_decode_notsupp,
+        [OP_REMOVEXATTR]        = (nfsd4_dec)nfsd4_decode_notsupp,
 };
 
 static inline bool
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index fd59904a282c..4aaa67e1dbad 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -149,6 +149,12 @@ enum nfs_opnum4 {
 	OP_WRITE_SAME = 70,
 	OP_CLONE = 71,
 
+	/* xattr support (RFC8726) */
+	OP_GETXATTR                = 72,
+	OP_SETXATTR                = 73,
+	OP_LISTXATTRS              = 74,
+	OP_REMOVEXATTR             = 75,
+
 	OP_ILLEGAL = 10044,
 };
 
@@ -158,7 +164,7 @@ Needs to be updated if more operations are defined in future.*/
 #define FIRST_NFS4_OP	OP_ACCESS
 #define LAST_NFS40_OP	OP_RELEASE_LOCKOWNER
 #define LAST_NFS41_OP	OP_RECLAIM_COMPLETE
-#define LAST_NFS42_OP	OP_CLONE
+#define LAST_NFS42_OP	OP_REMOVEXATTR
 #define LAST_NFS4_OP	LAST_NFS42_OP
 
 enum nfsstat4 {
@@ -279,6 +285,10 @@ enum nfsstat4 {
 	NFS4ERR_WRONG_LFS = 10092,
 	NFS4ERR_BADLABEL = 10093,
 	NFS4ERR_OFFLOAD_NO_REQS = 10094,
+
+	/* xattr (RFC8276) */
+	NFS4ERR_NOXATTR        = 10095,
+	NFS4ERR_XATTR2BIG      = 10096,
 };
 
 static inline bool seqid_mutating_err(u32 err)
@@ -451,6 +461,7 @@ enum change_attr_type4 {
 #define FATTR4_WORD2_CHANGE_ATTR_TYPE	(1UL << 15)
 #define FATTR4_WORD2_SECURITY_LABEL     (1UL << 16)
 #define FATTR4_WORD2_MODE_UMASK		(1UL << 17)
+#define FATTR4_WORD2_XATTR_SUPPORT	(1UL << 18)
 
 /* MDS threshold bitmap bits */
 #define THRESHOLD_RD                    (1UL << 0)
@@ -539,6 +550,11 @@ enum {
 
 	NFSPROC4_CLNT_LOOKUPP,
 	NFSPROC4_CLNT_LAYOUTERROR,
+
+	NFSPROC4_CLNT_GETXATTR,
+	NFSPROC4_CLNT_SETXATTR,
+	NFSPROC4_CLNT_LISTXATTRS,
+	NFSPROC4_CLNT_REMOVEXATTR,
 };
 
 /* nfs41 types */
@@ -674,4 +690,13 @@ struct nfs4_op_map {
 	} u;
 };
 
+/*
+ * Options for setxattr. These match the flags for setxattr(2).
+ */
+enum nfs4_setxattr_options {
+	SETXATTR4_EITHER      = 0,
+	SETXATTR4_CREATE      = 1,
+	SETXATTR4_REPLACE     = 2,
+};
+
 #endif
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 0a11712a80e3..e87c894d1960 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -207,6 +207,9 @@ struct nfs4_copy_state {
 #define NFS_ACCESS_EXTEND      0x0008
 #define NFS_ACCESS_DELETE      0x0010
 #define NFS_ACCESS_EXECUTE     0x0020
+#define NFS_ACCESS_XAREAD      0x0040
+#define NFS_ACCESS_XAWRITE     0x0080
+#define NFS_ACCESS_XALIST      0x0100
 
 /*
  * Cache validity bit flags
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index 8572930cf5b0..bf197e99b98f 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -33,6 +33,9 @@
 #define NFS4_ACCESS_EXTEND      0x0008
 #define NFS4_ACCESS_DELETE      0x0010
 #define NFS4_ACCESS_EXECUTE     0x0020
+#define NFS4_ACCESS_XAREAD      0x0040
+#define NFS4_ACCESS_XAWRITE     0x0080
+#define NFS4_ACCESS_XALIST      0x0100
 
 #define NFS4_FH_PERSISTENT		0x0000
 #define NFS4_FH_NOEXPIRE_WITH_OPEN	0x0001
-- 
2.17.2

