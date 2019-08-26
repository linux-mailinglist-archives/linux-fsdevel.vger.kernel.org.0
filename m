Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E0BB13EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfILRp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:45:57 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27366 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfILRp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568310356; x=1599846356;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=GlFlz4lbf/E/d+PxYf473bVpTCUGHfN3/4btU/+CjGw=;
  b=gWlKk785R+ILeDFuDfTQUcUYi9/CWXDDc7+zoo3OitIQzzos0Uhok9oc
   +P6b7+EF1pz2DwwDzLPfKqHAjpcouZWjkbgSoZ/X0BHJHJ56U4aFPYyQS
   3DaueIomntV3BX9FXAQ/AoBFMQJ891Kb6Lw6gKK9SbktEB4NRTeLTCWjo
   M=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="831156438"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Sep 2019 17:28:54 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id D239DA1E72;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D20UEB003.ant.amazon.com (10.43.60.73) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.129) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D20UEB003.ant.amazon.com (10.43.60.73) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:52 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E5DF6C052D; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <d3e2d8f1ecbc80e22f58d1ec10faa367072b1795.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 26 Aug 2019 21:38:31 +0000
Subject: [RFC PATCH 03/35] NFSv4.2: query the server for extended attribute
 support
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Query the server for extended attribute support, and record it
as the NFS_CAP_XATTR flag in the server capabilities.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs4proc.c         | 18 ++++++++++++++++--
 fs/nfs/nfs4xdr.c          | 27 +++++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |  2 ++
 include/linux/nfs_xdr.h   |  1 +
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1406858bae6c..dad22450546d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3650,6 +3650,7 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 {
 	u32 bitmask[3] = {}, minorversion = server->nfs_client->cl_minorversion;
+	u32 fattr4_word2_nfs42_mask;
 	struct nfs4_server_caps_arg args = {
 		.fhandle = fhandle,
 		.bitmask = bitmask,
@@ -3671,6 +3672,15 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 	if (minorversion)
 		bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT;
 
+	fattr4_word2_nfs42_mask = FATTR4_WORD2_NFS42_MASK;
+
+#ifdef CONFIG_NFS_V4_XATTR
+	if (minorversion >= 2 && (server->flags & NFS_MOUNT_USER_XATTR)) {
+		bitmask[2] |= FATTR4_WORD2_XATTR_SUPPORT;
+		fattr4_word2_nfs42_mask |= FATTR4_WORD2_XATTR_SUPPORT;
+	}
+#endif
+
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 	if (status == 0) {
 		/* Sanity check the server answers */
@@ -3683,7 +3693,7 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			res.attr_bitmask[2] &= FATTR4_WORD2_NFS41_MASK;
 			break;
 		case 2:
-			res.attr_bitmask[2] &= FATTR4_WORD2_NFS42_MASK;
+			res.attr_bitmask[2] &= fattr4_word2_nfs42_mask;
 		}
 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
 		server->caps &= ~(NFS_CAP_ACLS|NFS_CAP_HARDLINKS|
@@ -3691,7 +3701,7 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 				NFS_CAP_MODE|NFS_CAP_NLINK|NFS_CAP_OWNER|
 				NFS_CAP_OWNER_GROUP|NFS_CAP_ATIME|
 				NFS_CAP_CTIME|NFS_CAP_MTIME|
-				NFS_CAP_SECURITY_LABEL);
+				NFS_CAP_SECURITY_LABEL|NFS_CAP_XATTR);
 		if (res.attr_bitmask[0] & FATTR4_WORD0_ACL &&
 				res.acl_bitmask & ACL4_SUPPORT_ALLOW_ACL)
 			server->caps |= NFS_CAP_ACLS;
@@ -3718,6 +3728,10 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 		if (res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL)
 			server->caps |= NFS_CAP_SECURITY_LABEL;
+#endif
+#ifdef CONFIG_NFS_V4_XATTR
+		if (res.has_xattr)
+			server->caps |= NFS_CAP_XATTR;
 #endif
 		memcpy(server->attr_bitmask_nl, res.attr_bitmask,
 				sizeof(server->attr_bitmask));
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 46a8d636d151..00fd5732c59d 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4204,6 +4204,28 @@ static int decode_attr_time_modify(struct xdr_stream *xdr, uint32_t *bitmap, str
 	return status;
 }
 
+#ifdef CONFIG_NFS_V4_XATTR
+static int decode_attr_xattrsupport(struct xdr_stream *xdr, uint32_t *bitmap,
+				    uint32_t *res)
+{
+	__be32 *p;
+
+	*res = 0;
+	if (unlikely(bitmap[2] & (FATTR4_WORD2_XATTR_SUPPORT - 1U)))
+		return -EIO;
+	if (likely(bitmap[2] & FATTR4_WORD2_XATTR_SUPPORT)) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+		*res = be32_to_cpup(p);
+		bitmap[2] &= ~FATTR4_WORD2_XATTR_SUPPORT;
+	}
+	dprintk("%s: XATTR support=%s\n", __func__,
+		*res == 0 ? "false" : "true");
+	return 0;
+}
+#endif
+
 static int verify_attr_len(struct xdr_stream *xdr, unsigned int savep, uint32_t attrlen)
 {
 	unsigned int attrwords = XDR_QUADLEN(attrlen);
@@ -4371,6 +4393,11 @@ static int decode_server_caps(struct xdr_stream *xdr, struct nfs4_server_caps_re
 	if ((status = decode_attr_exclcreat_supported(xdr, bitmap,
 				res->exclcreat_bitmask)) != 0)
 		goto xdr_error;
+#ifdef CONFIG_NFS_V4_XATTR
+	if ((status = decode_attr_xattrsupport(xdr, bitmap,
+					       &res->has_xattr)) != 0)
+		goto xdr_error;
+#endif
 	status = verify_attr_len(xdr, savep, attrlen);
 xdr_error:
 	dprintk("%s: xdr returned %d!\n", __func__, -status);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index a87fe854f008..290d1c521226 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -149,6 +149,7 @@ struct nfs_server {
 #define NFS_MOUNT_LOCAL_FLOCK		0x100000
 #define NFS_MOUNT_LOCAL_FCNTL		0x200000
 #define NFS_MOUNT_SOFTERR		0x400000
+#define NFS_MOUNT_USER_XATTR		0x800000
 
 	unsigned int		caps;		/* server capabilities */
 	unsigned int		rsize;		/* read size */
@@ -276,5 +277,6 @@ struct nfs_server {
 #define NFS_CAP_COPY		(1U << 24)
 #define NFS_CAP_OFFLOAD_CANCEL	(1U << 25)
 #define NFS_CAP_LAYOUTERROR	(1U << 26)
+#define NFS_CAP_XATTR		(1U << 27)
 
 #endif
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9b8324ec08f3..f289c024943d 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1178,6 +1178,7 @@ struct nfs4_server_caps_res {
 	u32				has_links;
 	u32				has_symlinks;
 	u32				fh_expire_type;
+	u32				has_xattr;
 };
 
 #define NFS4_PATHNAME_MAXCOMPONENTS 512
-- 
2.17.2

