Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5B6B13BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbfILR3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:16 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:8060 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387665AbfILR3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309352; x=1599845352;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=8dWtkihj51CdY9eSpqcNedZCKX1EeD1xhejnUbKXAgM=;
  b=K2U5/SyUAd6YnUJEy5F/vFZ+bC2Pyp/Hulf54shaeeE25EnJL700TMUP
   bH1f34O6pf94uFCM+Y5kG0z/MXC9FhxCytMW8v2HdpDZ6sdgcvoTZ/kwb
   TAuNqYeyHIXq+2CkDOLqEX5qlW9ycIEbnhoEeCG5p/XfawokT2sW6vHwL
   U=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="414961359"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Sep 2019 17:29:11 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id D861FA1DD4;
        Thu, 12 Sep 2019 17:29:10 +0000 (UTC)
Received: from EX13D09UEA002.ant.amazon.com (10.43.61.145) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D09UEA002.ant.amazon.com (10.43.61.145) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:52 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E73CBC0568; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <0dc1762319d0515bf735daa9b27dd6535f24eb68.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 26 Aug 2019 23:09:27 +0000
Subject: [RFC PATCH 09/35] NFSv4.2: define and use extended attribute overhead
 sizes
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define, much like for read and write operations, the maximum overhead
sizes for get/set/listxattr, and use them to limit the maximum payload
size for those operations, in combination with the channel attributes.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/internal.h   |  5 +++++
 fs/nfs/nfs42xdr.c   | 23 +++++++++++++++++++++++
 fs/nfs/nfs4client.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index e64f810223be..a1464bf8d178 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -295,6 +295,11 @@ extern const u32 nfs41_maxread_overhead;
 extern const u32 nfs41_maxwrite_overhead;
 extern const u32 nfs41_maxgetdevinfo_overhead;
 #endif
+#ifdef CONFIG_NFS_V4_XATTR
+extern const u32 nfs42_maxsetxattr_overhead;
+extern const u32 nfs42_maxgetxattr_overhead;
+extern const u32 nfs42_maxlistxattrs_overhead;
+#endif
 
 /* nfs4proc.c */
 #if IS_ENABLED(CONFIG_NFS_V4)
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index d7657be74557..ca29d2702017 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -199,6 +199,29 @@
 				decode_sequence_maxsz + \
 				decode_putfh_maxsz + \
 				decode_removexattr_maxsz)
+
+/*
+ * These values specify the maximum amount of data that is not
+ * associated with the extended attribute name or extended
+ * attribute list in the SETXATTR, GETXATTR and LISTXATTR
+ * respectively.
+ */
+const u32 nfs42_maxsetxattr_overhead = ((RPC_MAX_HEADER_WITH_AUTH +
+					compound_encode_hdr_maxsz +
+					encode_sequence_maxsz +
+					encode_putfh_maxsz + 1 +
+					nfs4_xattr_name_maxsz)
+					* XDR_UNIT);
+
+const u32 nfs42_maxgetxattr_overhead = ((RPC_MAX_HEADER_WITH_AUTH +
+					compound_decode_hdr_maxsz +
+					decode_sequence_maxsz +
+					decode_putfh_maxsz + 1) * XDR_UNIT);
+
+const u32 nfs42_maxlistxattrs_overhead = ((RPC_MAX_HEADER_WITH_AUTH +
+					compound_decode_hdr_maxsz +
+					decode_sequence_maxsz +
+					decode_putfh_maxsz + 3) * XDR_UNIT);
 #endif
 
 static void encode_fallocate(struct xdr_stream *xdr,
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index da6204025a2d..d6f28bcd0929 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -990,6 +990,36 @@ static void nfs4_session_limit_rwsize(struct nfs_server *server)
 #endif /* CONFIG_NFS_V4_1 */
 }
 
+/*
+ * Limit xattr sizes using the channel attributes.
+ */
+static void nfs4_session_limit_xasize(struct nfs_server *server)
+{
+#ifdef CONFIG_NFS_V4_XATTR
+	struct nfs4_session *sess;
+	u32 server_gxa_sz;
+	u32 server_sxa_sz;
+	u32 server_lxa_sz;
+
+	if (!nfs4_has_session(server->nfs_client))
+		return;
+
+	sess = server->nfs_client->cl_session;
+
+	server_gxa_sz = sess->fc_attrs.max_resp_sz - nfs42_maxgetxattr_overhead;
+	server_sxa_sz = sess->fc_attrs.max_rqst_sz - nfs42_maxsetxattr_overhead;
+	server_lxa_sz = sess->fc_attrs.max_resp_sz -
+	    nfs42_maxlistxattrs_overhead;
+
+	if (server->gxasize > server_gxa_sz)
+		server->gxasize = server_gxa_sz;
+	if (server->sxasize > server_sxa_sz)
+		server->sxasize = server_sxa_sz;
+	if (server->lxasize > server_lxa_sz)
+		server->lxasize = server_lxa_sz;
+#endif
+}
+
 static int nfs4_server_common_setup(struct nfs_server *server,
 		struct nfs_fh *mntfh, bool auth_probe)
 {
@@ -1037,6 +1067,7 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 		goto out;
 
 	nfs4_session_limit_rwsize(server);
+	nfs4_session_limit_xasize(server);
 
 	if (server->namelen == 0 || server->namelen > NFS4_MAXNAMLEN)
 		server->namelen = NFS4_MAXNAMLEN;
-- 
2.17.2

